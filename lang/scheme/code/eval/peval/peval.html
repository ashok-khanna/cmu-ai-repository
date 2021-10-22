; peval.scm

;------------------------------------------------------------------------------
;
;                            A simple partial evaluator
;
;                              Marc Feeley (05/15/88)
;
;------------------------------------------------------------------------------

(define (pretty-print x) (write x) (newline))

(define (every? pred? l)
  (or (null? l) (and (pred? (car l)) (every? pred? (cdr l)))))

(define (some? pred? l)
  (if (null? l) #f (or (pred? (car l)) (some? pred? (cdr l)))))

(define (last-pair l)
  (let ((x (cdr l)))
    (if (pair? x) (last-pair x) l)))

;------------------------------------------------------------------------------
;
; The partial evaluator.

(define (partial-evaluate proc args)
  (peval (alphatize proc '()) args))

(define (alphatize exp env) ; return a copy of 'exp' where each bound var has
  (define (alpha exp)       ; been renamed (to prevent aliasing problems)
    (cond ((const-expr? exp)
           (quot (const-value exp)))
          ((symbol? exp)
           (let ((x (assq exp env))) (if x (cdr x) exp)))
          ((or (eq? (car exp) 'if) (eq? (car exp) 'begin))
           (cons (car exp) (map alpha (cdr exp))))
          ((or (eq? (car exp) 'let) (eq? (car exp) 'letrec))
           (let ((new-env (new-variables (map car (cadr exp)) env)))
             (list (car exp)
                   (map (lambda (x)
                          (list (cdr (assq (car x) new-env))
                                (if (eq? (car exp) 'let)
                                  (alpha (cadr x))
                                  (alphatize (cadr x) new-env))))
                        (cadr exp))
                   (alphatize (caddr exp) new-env))))
          ((eq? (car exp) 'lambda)
           (let ((new-env (new-variables (cadr exp) env)))
             (list 'lambda
                   (map (lambda (x) (cdr (assq x new-env))) (cadr exp))
                   (alphatize (caddr exp) new-env))))
          (else
           (map alpha exp))))
  (alpha exp))

(define (const-expr? expr) ; is 'expr' a constant expression?
  (and (not (symbol? expr))
       (or (not (pair? expr))
           (eq? (car expr) 'quote))))

(define (const-value expr) ; return the value of a constant expression
  (if (pair? expr) ; then it must be a quoted constant
    (cadr expr)
    expr))

(define (quot val) ; make a quoted constant whose value is 'val'
  (list 'quote val))

(define (new-variables parms env)
  (append (map (lambda (x) (cons x (new-variable x))) parms) env))

(define *current-num* 0)

(define (new-variable name)
  (set! *current-num* (+ *current-num* 1))
  (string->symbol
    (string-append (symbol->string name)
                   "_"
                   (number->string *current-num*))))

;------------------------------------------------------------------------------
;
; (peval proc args) will transform a procedure that is known to be called
; with constants as some of its arguments into a specialized procedure that
; is 'equivalent' but accepts only the non-constant parameters.  'proc' is the
; list representation of a lambda-expression and 'args' is a list of values,
; one for each parameter of the lambda-expression.  A special value (i.e.
; 'not-constant') is used to indicate an argument that is not a constant.
; The returned procedure is one that has as parameters the parameters of the
; original procedure which are NOT passed constants.  Constants will have been
; substituted for the constant parameters that are referenced in the body
; of the procedure.
;
; For example:
;
;   (peval
;     '(lambda (x y z) (f z x y)) ; the procedure
;     (list 1 not-constant #t))   ; the knowledge about x, y and z
;
; will return: (lambda (y) (f '#t '1 y))

(define (peval proc args)
  (simplify!
    (let ((parms (cadr proc))  ; get the parameter list
          (body (caddr proc))) ; get the body of the procedure
      (list 'lambda
            (remove-constant parms args) ; remove the constant parameters
            (beta-subst ; in the body, replace variable refs to the constant
              body      ; parameters by the corresponding constant
              (map (lambda (x y) (if (not-constant? y) '(()) (cons x (quot y))))
                   parms
                   args))))))

(define not-constant (list '?)) ; special value indicating non-constant parms.

(define (not-constant? x) (eq? x not-constant))

(define (remove-constant l a) ; remove from list 'l' all elements whose
  (cond ((null? l)            ; corresponding element in 'a' is a constant
         '())
        ((not-constant? (car a))
         (cons (car l) (remove-constant (cdr l) (cdr a))))
        (else
         (remove-constant (cdr l) (cdr a)))))

(define (extract-constant l a) ; extract from list 'l' all elements whose
  (cond ((null? l)             ; corresponding element in 'a' is a constant
         '())
        ((not-constant? (car a))
         (extract-constant (cdr l) (cdr a)))
        (else
         (cons (car l) (extract-constant (cdr l) (cdr a))))))

(define (beta-subst exp env) ; return a modified 'exp' where each var named in
  (define (bs exp)           ; 'env' is replaced by the corresponding expr (it
    (cond ((const-expr? exp) ; is assumed that the code has been alphatized)
           (quot (const-value exp)))
          ((symbol? exp)
           (let ((x (assq exp env))) 
             (if x (cdr x) exp)))
          ((or (eq? (car exp) 'if) (eq? (car exp) 'begin))
           (cons (car exp) (map bs (cdr exp))))
          ((or (eq? (car exp) 'let) (eq? (car exp) 'letrec))
           (list (car exp)
                 (map (lambda (x) (list (car x) (bs (cadr x)))) (cadr exp))
                 (bs (caddr exp))))
          ((eq? (car exp) 'lambda)
           (list 'lambda
                 (cadr exp)
                 (bs (caddr exp))))
          (else
           (map bs exp))))
  (bs exp))

;------------------------------------------------------------------------------
;
; The expression simplifier.

(define (simplify! exp)     ; simplify the expression 'exp' destructively (it
  (define (simp! where env) ; is assumed that the code has been alphatized)
    (define (s! where)
      (let ((exp (car where)))

        (cond ((const-expr? exp))  ; leave constants the way they are

              ((symbol? exp))      ; leave variable references the way they are

              ((eq? (car exp) 'if) ; dead code removal for conditionals
               (s! (cdr exp))      ; simplify the predicate
               (if (const-expr? (cadr exp)) ; is the predicate a constant?
                 (begin
                   (set-car! where
                     (if (memq (const-value (cadr exp)) '(#f ())) ; false?
                       (if (= (length exp) 3) ''() (cadddr exp))
                       (caddr exp)))
                   (s! where))
                 (for-each! s! (cddr exp)))) ; simplify consequent and alt.

              ((eq? (car exp) 'begin)
               (for-each! s! (cdr exp))
               (let loop ((exps exp)) ; remove all useless expressions
                 (if (not (null? (cddr exps))) ; not last expression?
                   (let ((x (cadr exps)))
                     (loop (if (or (const-expr? x)
                                   (symbol? x)
                                   (and (pair? x) (eq? (car x) 'lambda)))
                             (begin (set-cdr! exps (cddr exps)) exps)
                             (cdr exps))))))
               (if (null? (cddr exp)) ; only one expression in the begin?
                 (set-car! where (cadr exp))))

              ((or (eq? (car exp) 'let) (eq? (car exp) 'letrec))
               (let ((new-env (cons exp env)))
                 (define (keep i)
                   (if (>= i (length (cadar where)))
                     '()
                     (let* ((var (car (list-ref (cadar where) i)))
                            (val (cadr (assq var (cadar where))))
                            (refs (ref-count (car where) var))
                            (self-refs (ref-count val var))
                            (total-refs (- (car refs) (car self-refs)))
                            (oper-refs (- (cadr refs) (cadr self-refs))))
                       (cond ((= total-refs 0)
                              (keep (+ i 1)))
                             ((or (const-expr? val)
                                  (symbol? val)
                                  (and (pair? val)
                                       (eq? (car val) 'lambda)
                                       (= total-refs 1)
                                       (= oper-refs 1)
                                       (= (car self-refs) 0))
                                  (and (caddr refs)
                                       (= total-refs 1)))
                              (set-car! where
                                (beta-subst (car where)
                                            (list (cons var val))))
                              (keep (+ i 1)))
                             (else
                              (cons var (keep (+ i 1))))))))
                 (simp! (cddr exp) new-env)
                 (for-each! (lambda (x) (simp! (cdar x) new-env)) (cadr exp))
                 (let ((to-keep (keep 0)))
                   (if (< (length to-keep) (length (cadar where)))
                     (begin
                       (if (null? to-keep)
                         (set-car! where (caddar where))
                         (set-car! (cdar where)
                           (map (lambda (v) (assq v (cadar where))) to-keep)))
                       (s! where))
                     (if (null? to-keep)
                       (set-car! where (caddar where)))))))

              ((eq? (car exp) 'lambda)
               (simp! (cddr exp) (cons exp env)))

              (else
               (for-each! s! exp)
               (cond ((symbol? (car exp)) ; is the operator position a var ref?
                      (let ((frame (binding-frame (car exp) env)))
                        (if frame ; is it a bound variable?
                          (let ((proc (bound-expr (car exp) frame)))
                            (if (and (pair? proc)
                                     (eq? (car proc) 'lambda)
                                     (some? const-expr? (cdr exp)))
                              (let* ((args (arg-pattern (cdr exp)))
                                     (new-proc (peval proc args)))
                                (set-car! where
                                  (cons (add-binding new-proc frame (car exp))
                                        (remove-constant (cdr exp) args))))))
                          (set-car! where
                            (constant-fold-global (car exp) (cdr exp))))))
                     ((not (pair? (car exp))))
                     ((eq? (caar exp) 'lambda)
                      (set-car! where
                        (list 'let
                              (map list (cadar exp) (cdr exp))
                              (caddar exp)))
                      (s! where)))))))

    (s! where))
  (let ((x (list exp)))
    (simp! x '())
    (car x)))

(define (ref-count exp var) ; compute how many references to variable 'var'
  (let ((total 0)           ; are contained in 'exp'
        (oper 0)
        (always-evaled #t))
    (define (rc exp ae)
      (cond ((const-expr? exp))
            ((symbol? exp)
             (if (eq? exp var)
               (begin
                 (set! total (+ total 1))
                 (set! always-evaled (and ae always-evaled)))))
            ((eq? (car exp) 'if)
             (rc (cadr exp) ae)
             (for-each (lambda (x) (rc x #f)) (cddr exp)))
            ((eq? (car exp) 'begin)
             (for-each (lambda (x) (rc x ae)) (cdr exp)))
            ((or (eq? (car exp) 'let) (eq? (car exp) 'letrec))
             (for-each (lambda (x) (rc (cadr x) ae)) (cadr exp))
             (rc (caddr exp) ae))
            ((eq? (car exp) 'lambda)
             (rc (caddr exp) #f))
            (else
             (for-each (lambda (x) (rc x ae)) exp)
             (if (symbol? (car exp))
               (if (eq? (car exp) var) (set! oper (+ oper 1)))))))
    (rc exp #t)
    (list total oper always-evaled)))

(define (binding-frame var env)
  (cond ((null? env) #f)
        ((or (eq? (caar env) 'let) (eq? (caar env) 'letrec))
         (if (assq var (cadar env)) (car env) (binding-frame var (cdr env))))
        ((eq? (caar env) 'lambda)
         (if (memq var (cadar env)) (car env) (binding-frame var (cdr env))))
        (else
         (error "ill-formed environment"))))

(define (bound-expr var frame)
  (cond ((or (eq? (car frame) 'let) (eq? (car frame) 'letrec))
         (cadr (assq var (cadr frame))))
        ((eq? (car frame) 'lambda)
         not-constant)
        (else
         (error "ill-formed frame"))))

(define (add-binding val frame name)
  (define (find-val val bindings)
    (cond ((null? bindings) #f)
          ((equal? val (cadar bindings)) ; *kludge* equal? is not exactly what
           (caar bindings))              ; we want...
          (else
           (find-val val (cdr bindings)))))
  (or (find-val val (cadr frame))
      (let ((var (new-variable name)))
        (set-cdr! (last-pair (cadr frame)) (list (list var val)))
        var)))

(define (for-each! proc! l) ; call proc! on each CONS CELL in the list 'l'
  (if (not (null? l))
    (begin (proc! l) (for-each! proc! (cdr l)))))

(define (arg-pattern exps) ; return the argument pattern (i.e. the list of
  (if (null? exps)         ; constants in 'exps' but with the not-constant
    '()                    ; value wherever the corresponding expression in
    (cons (if (const-expr? (car exps)) ; 'exps' is not a constant)
            (const-value (car exps))
            not-constant)
          (arg-pattern (cdr exps)))))

;------------------------------------------------------------------------------
;
; Knowledge about primitive procedures.

(define *primitives*
  (list
    (cons 'car (lambda (args)
                 (and (= (length args) 1)
                      (pair? (car args))
                      (quot (car (car args))))))
    (cons 'cdr (lambda (args)
                 (and (= (length args) 1)
                      (pair? (car args))
                      (quot (cdr (car args))))))
    (cons '+ (lambda (args)
               (and (every? number? args) (quot (apply + args)))))
    (cons '* (lambda (args)
               (and (every? number? args) (quot (apply * args)))))
    (cons '- (lambda (args)
               (and (> (length args) 0)
                    (every? number? args)
                    (quot (apply - args)))))
    (cons '/ (lambda (args)
               (and (> (length args) 1)
                    (every? number? args)
                    (quot (apply / args)))))
    (cons '< (lambda (args)
               (and (= (length args) 2)
                    (every? number? args)
                    (quot (< (car args) (cadr args))))))
    (cons '= (lambda (args)
               (and (= (length args) 2)
                    (every? number? args)
                    (quot (= (car args) (cadr args))))))
    (cons '> (lambda (args)
               (and (= (length args) 2)
                    (every? number? args)
                    (quot (> (car args) (cadr args))))))
    (cons 'eq? (lambda (args)
                 (and (= (length args) 2)
                      (quot (eq? (car args) (cadr args))))))
    (cons 'not (lambda (args)
                 (and (= (length args) 1)
                      (quot (not (car args))))))
    (cons 'null? (lambda (args)
                   (and (= (length args) 1)
                        (quot (null? (car args))))))
    (cons 'pair? (lambda (args)
                   (and (= (length args) 1)
                        (quot (pair? (car args))))))
    (cons 'symbol? (lambda (args)
                     (and (= (length args) 1)
                          (quot (symbol? (car args))))))
    (cons 'length (lambda (args)
                    (and (= (length args) 1)
                         (proper-list? (car args))
                         (quot (length (car args))))))
  )
)

(define (reduce-global name args)
  (let ((x (assq name *primitives*)))
    (or (and x ((cdr x) args)) (cons name (map quot args)))))

(define (constant-fold-global name exprs)
  (define (flatten args op)
    (cond ((null? args)
           '())
          ((and (pair? (car args)) (eq? (caar args) op))
           (append (flatten (cdar args) op) (flatten (cdr args) op)))
          (else
           (cons (car args) (flatten (cdr args) op)))))
  (let ((args (if (or (eq? name '+) (eq? name '*)) ; associative ops
                (flatten exprs name)
                exprs)))
    (if (every? const-expr? args)
      (reduce-global name (map const-value args))
      (let ((pattern (arg-pattern args)))
        (let ((non-const (remove-constant args pattern))
              (const (map const-value (extract-constant args pattern))))
          (cond ((eq? name '+) ; + is commutative
                 (let ((x (reduce-global '+ const)))
                   (if (const-expr? x)
                     (let ((y (cadr x)))
                       (cons '+
                             (if (= y 0) non-const (cons x non-const))))
                     (cons name args))))
                ((eq? name '*) ; * is commutative
                 (let ((x (reduce-global '* const)))
                   (if (const-expr? x)
                     (let ((y (cadr x)))
                       (cons '*
                             (if (= y 1) non-const (cons x non-const))))
                     (cons name args))))
                (else
                 (cons name args))))))))

;------------------------------------------------------------------------------
;
; Examples:

(define (try proc args)
  (pretty-print (partial-evaluate proc args)))

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example1
  '(lambda (a b c)
     (if (null? a) b (+ (car a) c))))

(try example1 (list '(10 11) not-constant '1))

; prints:
;
; (lambda (b_2) '11)

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example2
  '(lambda (x y)
     (let ((q (lambda (a b) (if (< a 0) b (- 10 b)))))
       (if (< x 0) (q (- y) (- x)) (q y x)))))

(try example2 (list not-constant '1))

; prints:
;
; (lambda (x_5) (if (< x_5 '0) (- x_5) (- '10 x_5)))

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example3
  '(lambda (l n)
     (letrec ((add-list
               (lambda (l n)
                 (if (null? l)
                   '()
                   (cons (+ (car l) n) (add-list (cdr l) n))))))
       (add-list l n))))

(try example3 (list not-constant '1))

; prints:
;
; (lambda (l_12)
;   (letrec ((add-list_13_16
;             (lambda (l_15)
;               (if (null? l_15)
;                 '()
;                 (cons (+ '1 (car l_15)) (add-list_13_16 (cdr l_15)))))))
;    (add-list_13_16 l_12)))

(try example3 (list '(1 2 3) not-constant))

; prints:
;
; (lambda (n_17)
;   (cons (+ '1 n_17) (cons (+ '2 n_17) (cons (+ '3 n_17) '()))))

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example4
  '(lambda (exp env)
     (letrec ((eval
               (lambda (exp env)
                 (letrec ((eval-list
                            (lambda (l env)
                              (if (null? l)
                                '()
                                (cons (eval (car l) env)
                                      (eval-list (cdr l) env))))))
                   (if (symbol? exp) (lookup exp env)
                     (if (not (pair? exp)) exp
                       (if (eq? (car exp) 'quote) (car (cdr exp))
                         (apply (eval (car exp) env)
                                (eval-list (cdr exp) env)))))))))
       (eval exp env))))

(try example4 (list 'x not-constant))

; prints:
;
; (lambda (env_26) (lookup 'x env_26))

(try example4 (list '(f 1 2 3) not-constant))

; prints:
;
; (lambda (env_35)
;   (apply (lookup 'f env_35) (cons '1 (cons '2 (cons '3 '())))))

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example5
  '(lambda (a b)
     (letrec ((funct
               (lambda (x)
                 (+ x b (if (< x 1) 0 (funct (- x 1)))))))
       (funct a))))

(try example5 (list '5 not-constant))

; prints:
;
; (lambda (b_60) (+ '15 b_60 b_60 b_60 b_60 b_60 b_60))

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

(define example6
  '(lambda ()
     (letrec ((fact
               (lambda (x)
                 (if (< x 2) 1 (* x (fact (- x 1)))))))
       (fact 5))))

(try example6 '())

; prints:
;
; (lambda () '120)

; . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .

