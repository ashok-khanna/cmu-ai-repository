; File: "proplist.scm"   (c) 1991, Marc Feeley

; Generalized 'put' and 'get' in Scheme.
;
; Hash tables are used for efficiency.

(define (make-1d-table . opt)
  (make-vector (if (null? opt) 4003 (car opt)) '()))

(define (1d-table-get table index)
  (let ((h (hash-object index (vector-length table))))
    (assq index (vector-ref table h))))

(define (1d-table-put table index value)
  (let ((h (hash-object index (vector-length table))))
    (let ((x (assq index (vector-ref table h))))
      (if x
        (begin
          (set-cdr! x value)
          x)
        (let ((y (cons index value)))
          (vector-set! table h (cons y (vector-ref table h)))
          y)))))

(define (make-2d-table . opt)
  (vector (if (or (null? opt) (null? (cdr opt))) 19 (cadr opt))
          (if (null? opt) (make-1d-table) (make-1d-table (car opt)))))

(define (2d-table-get table index1 index2)
  (let ((1d-table (vector-ref table 1)))
    (let ((x (1d-table-get 1d-table index1)))
      (and x (1d-table-get (cdr x) index2)))))

(define (2d-table-put table index1 index2 value)
  (let ((table-size (vector-ref table 0))
        (1d-table (vector-ref table 1)))
    (let ((x (1d-table-get 1d-table index1)))
      (if x
        (1d-table-put (cdr x) index2 value)
        (let ((y (if table-size (make-1d-table table-size) (make-1d-table))))
          (1d-table-put 1d-table index1 y)
          (1d-table-put y index2 value))))))

(define (hash-object obj n)

  (define (hash-symbol sym n)
    (hash-string (symbol->string sym) n))

  (define (hash-string str n)
    (let ((len (string-length str)))
      (let loop ((h 0) (i (- len 1)))
        (if (>= i 0)
          (let ((x (+ (* h 256) (char->integer (string-ref str i)))))
            (loop (modulo x n) (- i 1)))
          h))))

  (define (hash-number num n)
    (modulo
      (inexact->exact
        (floor
          (cond ((integer? num)  num)
                ((rational? num) (+ (numerator num) (denominator num)))
                ((real? num)     num)
                (else            (+ (real-part num) (imag-part num))))))
    n))

  (define (hash-char chr n)
    (modulo (char->integer chr) n))

  (define (hash-vector vec n)
    (modulo (vector-length vec) n))

  (cond ((symbol? obj)      (hash-symbol obj n))
        ((string? obj)      (hash-string obj n))
        ((number? obj)      (hash-number obj n))
        ((char? obj)        (hash-char obj n))
        ((vector? obj)      (hash-vector obj n))
        ((pair? obj)        0)
        (else               (modulo 1 n))))

; 'get' and 'put' procedures.  Indexes can be arbitrary objects and are
; considered the same when they are eq?.

(define (get index1 index2)
  (let ((x (2d-table-get *property-table* index1 index2)))
    (and x (cdr x))))

(define (put index1 index2 value)
  (2d-table-put *property-table* index1 index2 value))

(define *property-table* (make-2d-table))

