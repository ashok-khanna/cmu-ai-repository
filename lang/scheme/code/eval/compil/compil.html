;
; Optimizing scheme compiler
; supports quote, set!, if, lambda special forms,
; constant refs, variable refs and proc applications
;
; Using Closures for Code Generation
; Marc Feeley and Guy LaPalme
; Computer Language, Vol. 12, No. 1, pp. 47-66
; 1987
;

(define (compile expr)
  ((gen expr nil #f)))

(define (gen expr env term)
  (cond
   ((symbol? expr)
    (ref (variable expr env) term))
   ((not (pair? expr))
    (cst expr term))
   ((eq? (car expr) 'quote)
    (cst (cadr expr) term))
   ((eq? (car expr) 'set!)
    (set (variable (cadr expr) env) (gen (caddr expr) env #f) term))
   ((eq? (car expr) 'if)
    (gen-tst (gen (cadr expr) env #f)
	     (gen (caddr expr) env term)
	     (gen (cadddr expr) env term)))
   ((eq? (car expr) 'lambda)
    (let ((p (cadr expr)))
      (prc p (gen (caddr expr) (allocate p env) #t) term)))
   (else
    (let ((args (map (lambda (x) (gen x env #f)) (cdr expr))))
      (let ((var (and (symbol? (car expr)) (variable (car expr) env))))
	(if (global? var)
	    (app (cons var args) #t term)
	    (app (cons (gen (car expr) env #f) args) #f term)))))))


(define (allocate parms env)
  (cond ((null? parms) env)
	((symbol? parms) (cons parms env))
	(else
	 (cons (car parms) (allocate (cdr parms) env)))))

(define (variable symb env)
  (let ((x (memq symb env)))
    (if x
	(- (length env) (length x))
	(begin
	  (if (not (assq symb -glo-env-)) (define-global symb '-undefined-))
	  (assq symb -glo-env-)))))

(define (global? var)
  (pair? var))

(define (cst val term)
  (cond ((eqv? val 1)
	 ((if term gen-1* gen-1)))
	((eqv? val 2)
	 ((if term gen-2* gen-2)))
	((eqv? val nil)
	 ((if term gen-null* gen-null)))
	(else
	 ((if term gen-cst* gen-cst) val))))

(define (ref var term)
  (cond ((global? var)
	 ((if term gen-ref-glo* gen-ref-glo) var))
	((= var 0)
	 ((if term gen-ref-loc-1* gen-ref-loc-1)))
	((= var 1)
	 ((if term gen-ref-loc-2* gen-ref-loc-2)))
	((= var 2)
	 ((if term gen-ref-loc-3* gen-ref-loc-3)))
	(else
	 ((if term gen-ref* gen-ref) var))))

(define (set var val term)
  (cond ((global? var)
	 ((if term gen-set-glo* gen-set-glo) var val))
	((= var 0)
	 ((if term gen-set-loc-1* gen-set-loc-1) val))
	((= var 1)
	 ((if term gen-set-loc-2* gen-set-loc-2) val))
	((= var 2)
	 ((if term gen-set-loc-3* gen-set-loc-3) val))
	(else
	 ((if term gen-set* gen-set) var val))))

(define (prc parms body term)
  ((cond ((null? parms)	
	  (if term gen-pr0* gen-pr0))
	 ((symbol? parms)
	  (if term gen-pr1/rest* gen-pr1/rest))
	 ((null? (cdr parms))
	  (if term gen-pr1* gen-pr1))
	 ((symbol? (cdr parms))
	  (if term gen-pr2/rest* gen-pr2/rest))
	 ((null? (cddr parms))
	  (if term gen-pr2* gen-pr2))
	 ((symbol? (cddr parms))
	  (if term gen-pr3/rest* gen-pr3/rest))
	 ((null? (cdddr parms))
	  (if term gen-pr3 gen-pr3))
	 (else
	  (error "too many parameters in a lambda-expression")))
   body))

(define (app vals glo term)
  (apply (case (length vals)
	   ((1) (if glo 
		    (if term gen-ap0-glo* gen-ap0-glo) 
		    (if term gen-ap0* gen-ap0)))
	   ((2) (if glo 
		    (if term gen-ap1-glo* gen-ap1-glo) 
		    (if term gen-ap1* gen-ap1)))
	   ((3) (if glo 
		    (if term gen-ap2-glo* gen-ap2-glo) 
		    (if term gen-ap2* gen-ap2)))
	   ((4) (if glo 
		    (if term gen-ap3-glo* gen-ap3-glo) 
		    (if term gen-ap3* gen-ap3)))
	   (else (error "too many arguments in a proc application")))
	 vals))
;
; code generation for non-terminal evaluations
;

;
; constants
;

(define (gen-1)		(lambda () 1))
(define (gen-2)		(lambda () 2))
(define (gen-null) 	(lambda () '()))
(define (gen-cst a)	(lambda () a))

;
; variable reference
;

(define (gen-ref-glo a)	(lambda () (cdr a)))		; global var
(define (gen-ref-loc-1)	(lambda () (cadr *env*)))	; first local var
(define (gen-ref-loc-2)	(lambda () (caddr *env*)))	; second local var
(define (gen-ref-loc-3)	(lambda () (cadddr *env*)))	; third local var
(define (gen-ref a)	(lambda () (do ((i 0 (1+ i))    ; any non-global
					(env (cdr *env*) (cdr env)))
				       ((= i a) (car env)))))

;
; assignment
;

(define (gen-set-glo a b)	(lambda () (set-cdr! a (b))))
(define (gen-set-loc-1 a)	(lambda () (set-car! (cdr *env*) (a))))
(define (gen-set-loc-2 a)	(lambda () (set-car! (cddr *env*) (a))))
(define (gen-set-loc-3 a)	(lambda () (set-car! (cdddr *env*) (a))))
(define (gen-set a b)		(lambda () (do ((i 0 (1+ i))
						(env (cdr *env*) (cdr env)))
					       ((= i a) (set-car! env (b))))))

;
; conditional
;

(define (gen-tst a b c)		(lambda () (if (a) (b) (c))))

;
; procedure application
;

(define (gen-ap0-glo a)		(lambda () ((cdr a))))
(define (gen-ap1-glo a b)	(lambda () ((cdr a) (b))))
(define (gen-ap2-glo a b c)	(lambda () ((cdr a) (b) (c))))
(define (gen-ap3-glo a b c d)	(lambda () ((cdr a) (b) (c) (d))))

(define (gen-ap0 a)		(lambda () ((a))))
(define (gen-ap1 a b)		(lambda () ((a) (b))))
(define (gen-ap2 a b c)		(lambda () ((a) (b) (c))))
(define (gen-ap3 a b c d)	(lambda () ((a) (b) (c) (d))))

;
; lambda expressions
;

(define (gen-pr0 a)			; without "rest" parameter
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda () 
	(set! *env* (cons *env* def))
	(a)))))

(define (gen-pr1 a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda (x)
	(set! *env* (cons *env* (cons x def)))
	(a)))))

(define (gen-pr2 a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda (x y)
	(set! *env* (cons *env* (cons x (cons y def))))
	(a)))))

(define (gen-pr3 a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda (x y z)
	(set! *env* (cons *env* (cons x (cons y (cons z def)))))
	(a)))))

(define (gen-pr1/rest a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda x
	(set! *env* (cons *env* (cons x def)))
	(a)))))

(define (gen-pr2/rest a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda (x . y)
	(set! *env* (cons *env* (cons x (cons y def))))
	(a)))))

(define (gen-pr3/rest a)
  (lambda ()
    (let ((def (cdr *env*)))
      (lambda (x y . z)
	(set! *env* (cons *env* (cons x (cons y (cons z def)))))
	(a)))))

;
; code generation for terminal evaluations
;

;
; constants
;

(define (gen-1*)
  (lambda ()
    (set! *env* (car *env*))
    1))

(define (gen-2*)
  (lambda ()
    (set! *env* (car *env*))
    2))

(define (gen-null*)
  (lambda ()
    (set! *env* (car *env*))
    '()))

(define (gen-cst* a)
  (lambda ()
    (set! *env* (car *env*))
    a))

;
; variable reference
;

(define (gen-ref-glo* a)
  (lambda ()
    (set! *env* (car *env*))
    (cdr a)))

(define (gen-ref-loc-1*)
  (lambda ()
    (let ((val (cadr *env*)))
      (set! *env* (car *env*))
      val)))

(define (gen-ref-loc-2*)
  (lambda ()
    (let ((val (caddr *env*)))
      (set! *env* (car *env*))
      val)))

(define (gen-ref-loc-3*)
  (lambda ()
    (let ((val (cadddr *env*)))
      (set! *env* (car *env*))
      val)))

(define (gen-ref* a)
  (lambda ()
    (do ((i 0 (1+ i))
	 (env (cdr *env*) (cdr env)))
	((= i a)
	 (set! *env* (car *env*))
	 (car env)))))

;
; assignment
;

(define (gen-set-glo* a b)
  (lambda ()
    (set! *env* (car *env*))
    (set-cdr! a (b))))

(define (gen-set-loc-1* a)
  (lambda ()
    (set! *env* (car *env*))
    (set-car! (cdr *env*) (a))))

(define (gen-set-loc-2* a)
  (lambda ()
    (set! *env* (car *env*))
    (set-car! (cddr *env*) (a))))

(define (gen-set-loc-3* a)
  (lambda ()
    (set! *env* (car *env*))
    (set-car! (cdddr *env*) (a))))

(define (gen-set* a b)
  (lambda ()
    (do ((i 0 (1+ i))
	 (env (cdr *env*) (cdr env)))
	((= i 0)
	 (set! *env* (car *env*))
	 (set-car! env (b))))))

;
; procedure application
;

(define (gen-ap0-glo* a)
  (lambda ()
    (set! *env* (car *env*))
    ((cdr a))))

(define (gen-ap1-glo* a b)
  (lambda ()
    (let ((x (b)))
      (set! *env* (car *env*))
      ((cdr a) x))))

(define (gen-ap2-glo* a b c)
  (lambda ()
    (let ((x (b)) (y (c)))
      (set! *env* (car *env*))
      ((cdr a) x y))))

(define (gen-ap3-glo* a b c d)
  (lambda ()
    (let ((x (b)) (y (c)) (z (d)))
      (set! *env* (car *env*))
      ((cdr a) x y z))))

(define (gen-ap0* a)
  (lambda ()
    (let ((w (a)))
      (set! *env* (car *env*))
      (w))))

(define (gen-ap1* a b)
  (lambda ()
    (let ((w (a)) (x (b)))
      (set! *env* (car *env*))
      (w x))))

(define (gen-ap2* a b c)
  (lambda ()
    (let ((w (a)) (x (b)) (y (c)))
      (set! *env* (car *env*))
      (w x y))))

(define (gen-ap3* a b c d)
  (lambda ()
    (let ((w (a)) (x (b)) (y (c)) (z (d)))
      (set! *env* (car *env*))
      (w x y z))))

;
; lambda
;

(define (gen-pr0* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda ()
	(set! *env* (cons *env* def))
	(a)))))


(define (gen-pr1* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda (x)
	(set! *env* (cons *env* (cons x def)))
	(a)))))

(define (gen-pr2* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda (x y)
	(set! *env* (cons *env* (cons x (cons y def))))
	(a)))))

(define (gen-pr3* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda (x y z)
	(set! *env* (cons *env* (cons x (cons y (cons z def)))))
	(a)))))

(define (gen-pr1/rest* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda x
	(set! *env* (cons *env* (cons x def)))
	(a)))))

(define (gen-pr2/rest* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda (x . y)
	(set! *env* (cons *env* (cons x (cons y def))))
	(a)))))

(define (gen-pr1/rest* a)
  (lambda ()
    (let ((def (cdr *env*)))
      (set! *env* (car *env*))
      (lambda (x y . z)
	(set! *env* (cons *env* (cons x (cons y (cons z def)))))
	(a)))))

;
; global defs
;

(define (define-global var val)
  (if (assq var -glo-env-)
      (set-cdr! (assq var -glo-env-) val)
      (set! -glo-env- (cons (cons var val) -glo-env-))))

(define -glo-env- (list (cons 'define define-global)))
(define-global 'cons cons)
(define-global 'car car)
(define-global 'cdr cdr)
(define-global 'null? null?)
(define-global 'not not)
(define-global '< <)
(define-global '1- 1-)
(define-global '+ +)
(define-global '- -)

;
; current environment
;

(define *env* '(dummy)))

;
; environment manipulation
;

(define (restore-env)
  (set! *env* (car *env*)))

;
; evaluator
;

(define (evaluate expr)
  ((compile (list 'lambda '() expr))))


(evaluate '(define 'fib
	     (lambda (x)
	       (if (< x 2)
		   x
		   (+ (fib (- x 1))
		      (fib (- x 2)))))))

;(define fib (lambda (x)
;	      (if (< x 2)
;		  x
;		  (+ (fib (- x 1))
;		     (fib (- x 2)))))))

