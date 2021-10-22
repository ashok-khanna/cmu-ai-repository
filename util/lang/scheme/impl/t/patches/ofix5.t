(herald ofix5 (syntax-table (env-syntax-table orbit-env)))

;;; from $BACK_END/closure.t

(define (close-analyze-label node heapenv heapvia)
  (let* ((live (lambda-live node))
         (need-contour? (eq? (lambda-env node) 'needs-link))
         (b (variable-binder heapvia))
         (via (if (or (lambda-live b)
		      (known-lambda? b)
		      (neq? (lambda-strategy b) strategy/heap))
                  *top-level-lambda* 
                  heapvia)))
    (set (lambda-env node) (create-join-point live via need-contour?))
    (walk (lambda (var) (set (variable-definition var) 'many)) live)
    (close-analyze-body (lambda-body node) '() via '() via)))

;;; from $BACK_END/lookup.t

(define (access-value node value)
  (cond ((and (variable? value)
	      (not (variable-binder value))
	      (var-is-vcell? value))
	 (let ((acc (lookup node (get-lvalue value) nil)))
	   (let ((reg (get-register 'pointer node '*)))
	     (generate-move acc reg)
	     (set (reg-node reg) -1)
	     (reg-offset reg 2))))
	(else
	 (really-access-value node value))))

;;; from $BACK_END/parassign.t

(define (do-assignment movers node)
  (iterate loop1 ((movers movers)
                  (targets (map arg-mover-to movers))
                  (temp nil))
    (cond ((null? movers))
        (else
         (iterate loop2 ((candidates targets))
           (cond ((null? candidates)
                  (let ((mover (car movers)))
                    (generate-move (arg-mover-to mover)
                                   (reg-offset TASK
                                     (if (eq? (reg-type (arg-mover-to mover))
					      'pointer)
                                          task/extra-pointer
                                          task/extra-scratch)))
                    (really-rep-convert node
                                        (arg-mover-from mover)
                                        (arg-mover-from-rep mover)
                                        (arg-mover-to mover)
                                        (arg-mover-to-rep mover))
                    (loop1 (cdr movers)
                           (delq (arg-mover-to mover) targets)
                           (arg-mover-to mover))))
                 ((not (mem? from-reg-eq? (car candidates) movers))
                  (let ((mover (car (mem to-reg-eq? (car candidates) movers))))
                    (really-rep-convert node
                         (cond ((eq? (arg-mover-from mover) temp)
                                (if (eq? (reg-type (arg-mover-from mover))
					 'pointer)
                                    (reg-offset TASK task/extra-pointer)
                                    (reg-offset TASK task/extra-scratch)))
                               (else
                                (arg-mover-from mover)))
                         (arg-mover-from-rep mover)
                         (arg-mover-to mover)
                         (arg-mover-to-rep mover))
                    (loop1 (delq mover movers)
                           (delq (arg-mover-to mover) targets)
                           temp)))
                 (else
                  (loop2 (cdr candidates)))))))))

;;; from $BACK_END/bookkeep.t
(define (kill-if-dead node where)
  (cond ((lambda-node? node)
         (walk (lambda (var)
                 (if (not (or (memq? var (lambda-live where))
                              (fx= (variable-number var) 0)))
                     (kill var)))
               (lambda-live node)))
        (else
	 (let ((var (leaf-value node)))
	   (cond ((not (variable? var))
		  (kill var))
		 (else
		  (let ((var (cond ((variable-known var) => lambda-self-var)
				   (else var))))
		    (if (not (memq? var (lambda-live where)))
			(kill var)))))))))

;;; from $FRONT_END/fixup.t send to hunt

(define (fix-exit-reference var node value)
  (let ((proc (call-proc (node-parent node))))
    (cond ((eq? node proc)
           (return))
          ((not (primop-node? proc))
           (introduce-exit-lambda var node value '#t))
          ((eq? primop/y (primop-value proc))
           (introduce-exit-lambda var node value '#t))
          (else
           (replace-with-lambda
            node
            (primop.values-returned
             (primop-value (call-proc (node-parent node)))))))))


;;; from $BACK_END/reg.t 

(define (allocate-location node prim)
  (let ((c (cont node)))
    (if (and (lambda-node? c)
             (let ((refs (variable-refs (car (lambda-variables c)))))
               (and refs
                    (null? (cdr refs))
                    (eq? c (node-parent (node-parent (car refs))))
		    (let ((proc (call-proc (lambda-body c))))
		      (and (primop-node? proc)
			   (neq? (primop-value proc) primop/make-cell)))
                    (reps-compatable? 
                      (primop.rep-wants (leaf-value ((call-arg 2) node)))
                      (variable-rep (car (lambda-variables c)))))))
        (generate-location-access node)
        (really-allocate-primop-call node prim))))

(define (introduce-cell var)
  (let ((node (variable-binder var))
        (new-var (create-variable (variable-name var))))
    (hack-references var new-var)
    (let-nodes ((call (($ primop/make-cell) 1 (^ cont1)))
                 (cont1 (() (v new-var))
                   (($ primop/set-location) 1
                    (^ cont2) ($ primop/cell-value) (* var) (* new-var)))
                  (cont2 (#f) ()))
      (cond ((primop-ref? (call-proc (lambda-body node))
			  primop/remove-state-object)
	     (insert-call call cont2 (car (call-args (lambda-body node)))))
	    (else
	     (insert-call call cont2 node))))))

    (define (add-side-effects name)
      (let* ((def (base-early-binding-env name))
             (primop (vref (definition-value def) 0))
             (mask (table-entry primop-predicate-table 'primop.side-effects?)))
        (modify (%primop-bitv primop)
                (lambda (x) (fixnum-logior x 2)))))

    (add-side-effects 'receive-values)

#|
;Real Fix - change this in DECLARE.T in the front-end:

    (define-declaration (simplifier name exp) (shape)
      (cond ((new-env-definition shape name)
             => (lambda (def)
                  (let* ((clauses `(((primop.simplify self node) (,exp node))
                                    ((primop.side-effects? self) '#t)
                                    ((primop.integrate? self node) nil)))
                         (primop (eval (primop-code name '() clauses) orbit-env)))
                    (set (primop.source primop) clauses)
                    (add-new-primop shape primop)
                    (set (definition-value def)
                         (node->vector (create-primop-node primop))))))
            (else
             (missing-declaration-variable-warning name 'simplifier))))


|#