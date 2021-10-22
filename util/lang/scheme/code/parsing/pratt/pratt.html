;; -*-mode:lisp-*-
;;
;; A simple Pratt-Parser for SIOD: 2-FEB-90, George Carrette, GJC@PARADIGM.COM
;; Siod version 2.4 may be obtained by anonymous FTP to BU.EDU (128.197.2.6)
;; Get the file users/gjc/siod-v2.4-shar
;;
;;                   COPYRIGHT (c) 1990 BY                       
;;     PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.
;;         See the source file SLIB.C for more information. 
;;
;;
;; Based on a theory of parsing presented in:                       
;;                                                                      
;;  Pratt, Vaughan R., ``Top Down Operator Precedence,''         
;;  ACM Symposium on Principles of Programming Languages         
;;  Boston, MA; October, 1973.                                   
;;                                                                      

;; The following terms may be useful in deciphering this code:

;; NUD -- NUll left Denotation (op has nothing to its left (prefix))
;; LED -- LEft Denotation      (op has something to left (postfix or infix))

;; LBP -- Left Binding Power  (the stickiness to the left)
;; RBP -- Right Binding Power (the stickiness to the right)
;;
;;

;; Example calls
;;
;; (pl '(f [ a ] = a + b / c)) => (= (f a) (+ a (/ b c)))
;;
;; (pl '(if g [ a COMMA b ] then a > b else k * c + a * b))
;;  => (if (g a b) (> a b) (+ (* k c) (* a b)))
;;
;; Notes: 
;;
;;   This code must be used with siod.scm loaded, in siod version 2.3
;;
;;   For practical use you will want to write some code to
;;   break up input into tokens.


(defvar *eof* (list '*eof*))

;; 

(defun pl (l)
  ;; parse a list of tokens
  (setq l (append l '($)))
  (toplevel-parse (lambda (op arg)
		    (cond ((eq op 'peek)
			   (if l (car l) *eof*))
			  ((eq op 'get)
			   (if l (pop l) *eof*))
			  ((eq op 'unget)
			   (push arg l))))))

(defun peek-token (stream)
  (stream 'peek nil))

(defun read-token (stream)
  (stream 'get nil))

(defun unread-token (x stream)
  (stream 'unget x))
   
(defun toplevel-parse (stream)
  (if (eq *eof* (peek-token stream))
      (read-token stream)
    (parse -1 stream)))

(defun get (sym key)
  ;; symbolconc takes the place of an explicit hash-table
  (setq sym (symbolconc sym '+INTERNAL-PLIST))
  (and (symbol-bound? sym)
       (cdr (assq key (symbol-value sym)))))

(defun putprop (sym val key)
  (set-cdr! (let ((cell (symbolconc sym '+INTERNAL-PLIST)))
	      (or (assq key (if (symbol-bound? cell)
				(symbol-value cell)
			      (set-symbol-value! cell nil)))
		  (car (set-symbol-value! cell
					  (cons (list key)
						(symbol-value cell))))))
	    val))

(defun plist (sym)
  (setq sym (symbolconc sym '+INTERNAL-PLIST))
  (and (symbol-bound? sym)
       (symbol-value sym)))


(defun value-if-symbol (x)
  (if (symbol? x)
      (symbol-value x)
    x))

(defun nudcall (token stream)
  (if (symbol? token)
      (if (get token 'nud)
	  ((value-if-symbol (get token 'nud)) token stream)
	(if (get token 'led)
	    (error 'not-a-prefix-operator token)
	  token)
	token)
    token))

(defun ledcall (token left stream)
  ((value-if-symbol (or (and (symbol? token)
			     (get token 'led))
			(error 'not-an-infix-operator token)))
   token
   left
   stream))


(defun lbp (token)
  (or (and (symbol? token) (get token 'lbp))
      200))

(defun rbp (token)
  (or (and (symbol? token) (get token 'rbp))
      200))

(defvar *parse-debug* nil)

(defun parse (rbp-level stream)
  (if *parse-debug* (print `(parse ,rbp-level)))
  (defun parse-loop (translation)
    (if (< rbp-level (lbp (peek-token stream)))
	(parse-loop (ledcall (read-token stream) translation stream))
      (begin (if *parse-debug* (print translation))
	     translation)))
  (parse-loop (nudcall (read-token stream) stream)))

(defun header (token)
  (or (get token 'header) token))

(defun parse-prefix (token stream)
  (list (header token)
	(parse (rbp token) stream)))

(defun parse-infix (token left stream)
  (list (header token)
	left
	(parse (rbp token) stream)))

(defun parse-nary (token left stream)
  (cons (header token) (cons left (prsnary token stream))))

(defun parse-matchfix (token left stream)
  (cons (header token)
	(prsmatch (or (get token 'match) token)
		  stream)))

(defun prsnary (token stream)
  (defun loop (l)
    (if (eq? token (peek-token stream))
	(begin (read-token stream)
	       (loop (cons (parse (rbp token) stream) l)))
      (reverse l)))
  (loop (list (parse (rbp token) stream))))

(defun prsmatch (token stream)
  (if (eq? token (peek-token stream))
      (begin (read-token stream)
	     nil)
    (begin (defun loop (l)
	     (if (eq? token (peek-token stream))
		 (begin (read-token stream)
			(reverse l))
	       (if (eq? 'COMMA (peek-token stream))
		   (begin (read-token stream)
			  (loop (cons (parse 10 stream) l)))
		 (error 'comma-or-match-not-found (read-token stream)))))
	   (loop (list (parse 10 stream))))))

(defun delim-err (token stream)
  (error 'illegal-use-of-delimiter token))

(defun erb-error (token left stream)
  (error 'too-many token))

(defun premterm-err (token stream)
  (error 'premature-termination-of-input token))

(defmac (defprops form)
  (defun loop (l result)
    (if (null? l)
	`(begin ,@result)
      (loop (cddr l)
	    `((putprop ',(cadr form) ',(cadr l) ',(car l))
	      ,@result))))
  (loop (cddr form) nil))


(defprops $
  lbp -1
  nud premterm-err)

(defprops COMMA
  lbp 10
  nud delim-err)


(defprops ]
  nud delim-err
  led erb-err
  lbp 5)

(defprops [
  nud open-paren-nud
  led open-paren-led
  lbp 200)

(defprops if
  nud if-nud
  rbp 45)

(defprops then
  nud delim-err
  lbp 5
  rbp 25)

(defprops else
  nud delim-err
  lbp 5
  rbp 25)

(defprops -
  nud parse-prefix
  led parse-nary
  lbp 100
  rbp 100)

(defprops +
  nud parse-prefix
  led parse-nary
  lbp 100
  rbp 100)

(defprops *
  led parse-nary
  lbp 120)

(defprops =
  led parse-infix
  lbp 80
  rbp 80)

(defprops **
  lbp 140
  rbp 139
  led parse-infix)

(defprops :=
  led parse-infix
  lbp 80
  rbp 80)


(defprops /
  led parse-infix
  lbp 120
  rbp 120)

(defprops >
  led parse-infix
  lbp 80
  rbp 80)

(defprops <
  led parse-infix
  lbp 80
  rbp 80)

(defprops >=
  led parse-infix
  lbp 80
  rbp 80)

(defprops <=
  led parse-infix
  lbp 80
  rbp 80)

(defprops not
  nud parse-prefix
  lbp 70
  rbp 70)

(defprops and
  led parse-nary
  lbp 65)

(defprops or
  led parse-nary
  lbp 60)


(defun open-paren-nud (token stream)
  (if (eq (peek-token stream) '])
      nil
    (let ((right (prsmatch '] stream)))
      (if (cdr right)
	  (cons 'sequence right)
	(car right)))))

(defun open-paren-led (token left stream)
  (cons (header left) (prsmatch '] stream)))


(defun if-nud (token stream)
  (define pred (parse (rbp token) stream))
  (define then (if (eq? (peek-token stream) 'then)
		   (parse (rbp (read-token stream)) stream)
		 (error 'missing-then)))
  (if (eq? (peek-token stream) 'else)
      `(if ,pred ,then ,(parse (rbp (read-token stream)) stream))
    `(if ,pred ,then)))
