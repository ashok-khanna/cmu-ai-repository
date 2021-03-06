(herald m68fix )

(define (generate-set node location value)
  (let ((access (if (lambda-node? value)        
		    (cond ((access/make-closure node value))
			  (else AN))
		    (access-with-rep node (leaf-value value) 'rep/pointer))))
    (protect-access access)
    (let ((loc (lookup node (get-lvalue (leaf-value location)) nil))
	  (hack1 (cons nil nil))
	  (hack2 (cons nil nil)))
      (let ((reg (get-register 'pointer node '*)))
	(release-access access)
	(generate-move loc reg)
	(lock reg)			;this was a bug! check out generate-
	(generate-move access (reg-offset reg 2)) ;move-address
	(unlock reg)
	(emit m68/tst .b (reg-offset reg 0))
	(emit-jump 'jneq hack1 hack2)
	(emit-tag hack1)                       
	(emit m68/move .l reg (reg-offset TASK task/extra-pointer))
	(generate-slink-jump slink/set)
	(generate-jump hack2)
	(emit-tag hack2)))))

(define (generate-move-address from to)
  (cond ((register? to)
         (if (or (atom? from)
                 (neq? (car from) to)
                 (neq? (cdr from) 0))
             (emit m68/lea from to)))
        ((reg-node AN)
         (emit m68/pea from)
         (generate-pop to))
        (else
         (emit m68/lea from AN)
         (emit m68/move .l AN to))))