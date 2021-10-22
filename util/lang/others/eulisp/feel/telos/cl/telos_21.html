#|
Telos in Common Lisp.  Copyright (C) Russell Bradford, August 1992,
rjb@maths.bath.ac.uk.

For educational use only.

An implementation of Telos as taken from the EuLisp document version 0.95,
and from the "Balancing" paper by Harry Bretthauer et al.

There are some differences with the above descriptions, mostly due to
the 2-valued nature of CL, some due to a passing attempt to integrate with the
usual type hierarchy of CL, others due to laziness on my part.

Disclaimer: this code was written to help me to understand Telos and MOPs
in general.  Thus there are probably many features, naiveities, or even bugs.
Plus the optimisations are somewhat simplistic.  I am interested in
hearing about bugs/improvements and so on, but won't necessarily act upon
them.

Developed on AKCL, has run on CMU, Clisp, HCL and WCL in its lifetime.  Works
best when compiled: otherwise somewhat slow!  See the documentation strings for
defclass, defgeneric, defmethod for more information.

Added attractions:
describe tells you much about an object.
defstructure is a simple implementation of structures.
class-hierarchy gives the current subclass hierarchy.
instance-hierarchy gives the current class instance hierarchy.

Version 2.0:  First released version RJB 92/10/27
        2.1:  Fixed bug in sorting applicable methods that was revealed by MI
              module RJB 92/10/29
|#

(in-package :telos)

(shadow '(describe
          #+KCL allocate
          #+CMU stream))

(export '(generic-funcall primitive-ref primitive-class-of primitive-allocate
	  metaclass class abstract-class function-class object generic-function
	  method slot-description local-slot-description
	  class-of subclass? class? slot-description?
	  generic-function? method? defgeneric method-function-lambda
	  defmethod class-name class-instance-length class-direct-superclasses
	  class-direct-subclasses class-slot-descriptions class-initargs
	  class-precedence-list generic-function-name generic-function-domain
	  generic-function-method-class generic-function-method-initargs
	  generic-function-methods generic-function-method-lookup-function
	  generic-function-discriminating-function generic-function-cache
	  method-generic-function method-domain
	  method-function slot-description-name slot-description-initfunction
	  slot-description-slot-reader slot-description-slot-writer
	  slot-value-using-slot-description find-slot-description
	  slot-value make allocate initialize call-next-method
	  next-method? apply-method call-method compute-method-lookup-function
	  compute-discriminating-function add-method remove-method
	  find-method compatible-superclasses-p compatible-superclass-p
	  compute-class-precedence-list compute-inherited-initargs
	  compute-initargs compute-inherited-slot-descriptions
	  compute-slot-descriptions compute-specialized-slot-description
	  compute-specialized-slot-description-class
	  compute-defined-slot-description
	  compute-defined-slot-description-class
	  copy-object compute-and-ensure-slot-accessors compute-slot-reader
	  compute-slot-writer ensure-slot-reader
	  compute-primitive-reader-using-slot-description
	  compute-primitive-reader-using-class
	  ensure-slot-writer compute-primitive-writer-using-slot-description
	  compute-primitive-writer-using-class add-subclass defclass
	  defmetaclass generic-prin common cl-object class-hierarchy
	  instance-hierarchy structure-class structure defstructure
	  describe standard-function find-key required))

;(eval-when (compile)
;   (proclaim '(optimize (speed 3) (safety 0) (compilation-speed 0))))

;#+AKCL (use-fast-links nil)

#+KCL
(eval-when (load)
  (format t "loading..."))

(defun generic-funcall (fun &rest args)
  (cond ((functionp fun) (apply fun args))
	((generic-function? fun)
	 (apply (generic-function-discriminating-function fun) args))
	(t (error "~a is not a function in GENERIC-FUNCALL" fun))))

(eval-when (compile load eval)

(defvar telos (find-package :telos)
  "The Telos Package")

) ; end of eval-when

(eval-when (compile)

(proclaim '(inline primitive-class-slots primitive-class-class
		   primitive-ref setter-primitive-ref
		   primitive-class-of setter-primitive-class-of))

) ; end of eval-when

(defstruct (primitive-class (:print-function primitive-print))
  class
  slots)

(defun primitive-ref (s n)
  (svref (primitive-class-slots s) n))

(defun setter-primitive-ref (s n v)
  (setf (svref (primitive-class-slots s) n) v))

(defsetf primitive-ref setter-primitive-ref)

(defun primitive-class-of (cl)
  (primitive-class-class cl))

(defun setter-primitive-class-of (cl val)
  (setf (primitive-class-class cl) val))

(defsetf primitive-class-of setter-primitive-class-of)

(defvar unbound (list 'unbound))

(defun unbound () unbound)

(defun primitive-allocate (cl size)
  (make-primitive-class :class cl
			:slots (make-array size :initial-element unbound)))


; object
(defconstant object-slots ())
(defconstant object-initargs ())
(defconstant object-size 0)

; class
(defconstant %name 0)
(defconstant %instance-length 1)
(defconstant %direct-superclasses 2)
(defconstant %direct-subclasses 3)
(defconstant %slot-descriptions 4)
(defconstant %initargs 5)
(defconstant %precedence-list 6)
(defconstant class-slots '(name instance-length direct-superclasses
			   direct-subclasses slot-descriptions
			   initargs class-precedence-list))
(defconstant class-accessors '(class-name class-instance-length
			       class-direct-superclasses
			       class-direct-subclasses
			       class-slot-descriptions class-initargs
			       class-precedence-list))
(defconstant class-inits '(:name :direct-superclasses :direct-slot-descriptions
			   :direct-initargs))
(defconstant class-size (length class-slots))


; generic-function
;(defconstant %name 0)
(defconstant %domain 1)
(defconstant %method-class 2)
(defconstant %method-initargs 3)
(defconstant %methods 4)
(defconstant %method-lookup-function 5)
(defconstant %discriminating-function 6)
(defconstant %cache 7)
(defconstant gf-slots '(name domain method-class method-initargs methods
			method-lookup-function discriminating-function
			cache))
(defconstant gf-accessors '(generic-function-name generic-function-domain
			    generic-function-method-class
			    generic-function-method-initargs
			    generic-function-methods
			    generic-function-method-lookup-function
			    generic-function-discriminating-function
			    generic-function-cache))
(defconstant gf-initargs '(:name :domain :method-class :method-initargs
			   :methods :method-lookup-function
			   :discriminating-function))
(defconstant gf-size (length gf-slots))

; method
(defconstant %generic-function 0)
;(defconstant %domain 1)
(defconstant %function 2)
(defconstant method-slots '(generic-function domain function))
(defconstant method-accessors '(method-generic-function method-domain
				method-function))
(defconstant method-initargs '(:domain :function :generic-function))
(defconstant method-size (length method-slots))

; slot-description
(defconstant %reader 0)
(defconstant %writer 1)
(defconstant sd-slots '(reader writer))
(defconstant sd-accessors '(slot-description-slot-reader
			    slot-description-slot-writer))
(defconstant sd-initargs '(:reader :writer))
(defconstant sd-size (length sd-slots))

; local-slot-description
(defconstant %lsdname 2)
(defconstant %initfunction 3)
(defconstant lsd-slots (append sd-slots '(name initfunction)))
(defconstant lsd-accessors (append sd-accessors
			      '(slot-description-name
				slot-description-initfunction)))
(defconstant lsd-initargs (append sd-initargs '(:name :initfunction)))
(defconstant lsd-size (length lsd-slots))

(defvar metaclass (primitive-allocate () class-size)
  "The Telos metaclass METACLASS")

(defvar class (primitive-allocate metaclass class-size)
  "The Telos metaclass CLASS")

(defvar abstract-class (primitive-allocate metaclass class-size)
  "The Telos metaclass ABSTRACT-CLASS")

(defvar function-class (primitive-allocate metaclass class-size)
  "The Telos metaclass FUNCTION-CLASS")

(defvar object (primitive-allocate abstract-class class-size)
  "The Telos abstract class OBJECT")

(defvar generic-function (primitive-allocate function-class class-size)
  "The Telos class GENERIC-FUNCTION")

(defvar method (primitive-allocate class class-size)
  "The Telos class METHOD")

(defvar slot-description (primitive-allocate abstract-class class-size)
  "The Telos abstract class SLOT-DESCRIPTION")

(defvar local-slot-description (primitive-allocate class class-size)
  "The Telos class LOCAL-SLOT-DESCRIPTION")

; don't print result
(null (setf (primitive-class-of metaclass) metaclass))

; CL classes

(defvar common (primitive-allocate metaclass class-size)
  "The Telos metaclass COMMON")

(defvar cl-object (primitive-allocate abstract-class class-size)
  "The Telos abstract class CL-OBJECT")

(defmacro memq (a b) `(member ,a ,b :test #'eq))

(defconstant cl-class-table (make-hash-table :test #'eq))

; This will be overwritten later when we get around to defining CL classes.
; Hack due to (type-of ()) -> SYMBOL, not NULL as we might hope.
(defvar null () "The Telos class NULL")

#-KCL
(defun class-of (obj)
  (cond ((primitive-class-p obj) (primitive-class-of obj))
	((null obj) null)
	(t (let ((type (type-of obj)))
	     (or (gethash type cl-class-table)
		 (when (consp type) 
		   (gethash (car type) cl-class-table))
		 object)))))

; KCL uses conses for lambdas
#+KCL
(defvar standard-function () "The Telos class STANDARD FUNCTION")
#+KCL
(defun class-of (obj)
  (cond ((primitive-class-p obj) (primitive-class-of obj))
        ((null obj) null)
	((and (consp obj) (functionp obj)) standard-function)
        (t (let ((type (type-of obj)))
             (or (gethash type cl-class-table)
                 (when (consp type)
                   (gethash (car type) cl-class-table))
                 object)))))

(defvar primitive-metaclasses
  (list metaclass function-class abstract-class class common))

(defun primitive-metaclass? (obj)
  (memq obj primitive-metaclasses))

; assume both are classes
(defun subclass? (a b)
  (cond ((eq a b) t)
 	((null a) ())
 	(t (some #'(lambda (c) (subclass? c b))
 		 (if (primitive-metaclass? (class-of a))
		     (primitive-ref a %direct-superclasses)
		     (class-direct-superclasses a))))))

(defun cpl-subclass? (a b)
  (memq b (if (primitive-metaclass? (class-of a))
	      (primitive-ref a %precedence-list)
	      (class-precedence-list a))))

(defun class? (a) (subclass? (class-of a) class))

(defun slot-description? (a) (subclass? (class-of a) slot-description))

(defun generic-function? (a) (subclass? (class-of a) generic-function))

(defun method? (a) (subclass? (class-of a) method))

#+telos-debug (progn

; temporary version while debugging
; take care to avoid any gf calls
(defun primitive-print (obj str xx)
  (declare (ignore xx))
  (primitive-generic-prin obj str))

(defvar primitive-classes
  (list object class metaclass abstract-class function-class generic-function
	method slot-description local-slot-description))

(defun primitive-generic-prin (obj str)
  (let ((cl (primitive-class-of obj)))
    (cond ((or (memq obj primitive-classes)
	       (primitive-metaclass? cl))
	   (format str "#class(~s [~s])"
		   (primitive-ref obj %name)
		   (primitive-ref cl %name)))
	  ((eq cl local-slot-description)
	   (format str "#slotd(~s)"
		   (primitive-ref obj %lsdname)))
	  ((eq cl generic-function)
	   (format str "#gfun~s"
		   (cons (primitive-ref obj %name)
			 (mapcar #'(lambda (o) (primitive-ref o %name))
				 (primitive-ref obj %domain)))))
	  ((eq cl method)
	   (format str "#method~s"
		   (cons (if (generic-function?
			      (primitive-ref obj %generic-function))
			     (primitive-ref
			      (primitive-ref obj %generic-function)
			      %name)
			     :unattached)
 			 (mapcar #'(lambda (o) (primitive-ref o %name))
 				 (primitive-ref obj %domain)))))
	  (t (format str "#object([~s])"
		     (primitive-ref cl %name))))) obj)

) ; end of telos-debug

(defun init-class (cl name isize supers subs inits cpl)
  (setf (primitive-ref cl %name) name)
  (setf (primitive-ref cl %instance-length) isize)
  (setf (primitive-ref cl %direct-superclasses) supers)
  (setf (primitive-ref cl %direct-subclasses) subs)
  (setf (primitive-ref cl %slot-descriptions) ())
  (setf (primitive-ref cl %initargs) inits)
  (setf (primitive-ref cl %precedence-list) (cons cl cpl))
  name)

(init-class object 'object object-size ()
	    (list class method slot-description cl-object)
	    () ())
(init-class class 'class class-size (list object)
	    (list metaclass abstract-class function-class common)
	    class-inits (list object))
(init-class metaclass 'metaclass class-size (list class) () class-inits
	    (list class object))
(init-class abstract-class 'abstract-class class-size (list class) ()
	    class-inits (list class object))
(init-class function-class 'function-class class-size (list class) ()
	    class-inits (list class object))
;(init-class generic-function 'generic-function gf-size (list object) ()
;	    gf-initargs (list object))
(init-class method 'method method-size (list object) ()
	    method-initargs (list object))
(init-class slot-description 'slot-description sd-size (list object)
	    (list local-slot-description) sd-initargs (list object))
(init-class local-slot-description 'local-slot-description lsd-size
	    (list slot-description) () lsd-initargs
	    (list slot-description object))
(init-class common 'common class-size (list class) () class-inits
	    (list class object))
(init-class cl-object 'cl-object object-size (list object) ()
	    () (list object))

; CL classes

(defmacro def-cl-class (name supers cpl)
  `(progn
     (defvar ,name () ,(format () "The Telos class ~a" name))
     (setq ,name (primitive-allocate common class-size))
     (setf (primitive-ref ,name %name) ',name)
     (setf (primitive-ref ,name %instance-length) 0)
     (setf (primitive-ref ,name %direct-superclasses) (list ,@supers))
     (setf (primitive-ref ,name %direct-subclasses) ())
     (setf (primitive-ref ,name %slot-descriptions) ())
     (setf (primitive-ref ,name %initargs) ())
     (mapc #'(lambda (super)
	       (setf (primitive-ref super %direct-subclasses)
		     (cons ,name (primitive-ref super %direct-subclasses))))
	   (list ,@supers))
     (setf (primitive-ref ,name %precedence-list)
	   (cons ,name (append (list ,@cpl) (list cl-object object))))
     (setf (gethash ',name cl-class-table) ,name)
     ',name))

(defmacro synonym (a b)
  `(setf (gethash ',a cl-class-table) ,b))

(def-cl-class sequence (cl-object) ())
(def-cl-class list (sequence) (sequence))
(def-cl-class cons (list) (list sequence))
(def-cl-class array (cl-object) ())
(synonym simple-array array)
(def-cl-class vector (sequence array) (sequence array))
(synonym simple-vector vector)
(def-cl-class bit-vector (vector) (vector sequence array))
(synonym simple-bit-vector bit-vector)
(def-cl-class string (vector) (vector sequence array))
(synonym simple-string string)
#+KCL (synonym fat-string string)
(def-cl-class symbol (cl-object) ())
(synonym keyword symbol)
(def-cl-class null (list symbol) (list symbol sequence))
(def-cl-class character (cl-object) ())
(synonym string-char character)
(synonym standard-char character)
;
(def-cl-class function (cl-object) ())
(def-cl-class standard-function (function) (function))
(setf (gethash 'function cl-class-table) standard-function)
(synonym compiled-function standard-function)
;
(init-class generic-function 'generic-function gf-size (list function) ()
           gf-initargs (list function object))
(setf (primitive-ref function %direct-subclasses)
      (list generic-function standard-function))
;
(def-cl-class pathname (cl-object) ())
(def-cl-class stream (cl-object) ())
(def-cl-class random-state (cl-object) ())
(def-cl-class hash-table (cl-object) ())
(def-cl-class readtable (cl-object) ())
(def-cl-class package (cl-object) ())
(def-cl-class number (cl-object) ())
(def-cl-class complex (number) (number))
(def-cl-class float (number) (number))
(synonym short-float float)
(synonym single-float float)
(synonym double-float float)
(synonym long-float float)
(def-cl-class rational (number) (number))
(def-cl-class ratio (rational) (rational number))
(def-cl-class integer (rational) (rational number))
(synonym fixnum integer)
(synonym bignum integer)
(synonym bit integer)

(defun primitive-find-slot-position (cl name slots index)
  (cond ((null slots)
	 (error "slot ~s not found in class ~s" name cl))
 	((eq name (primitive-ref (car slots) %lsdname)) index)
 	(t (primitive-find-slot-position cl name (cdr slots) (+ index 1)))))

(defun primitive-slot-value (obj name)
  (let ((cl (class-of obj)))
    (primitive-ref obj (primitive-find-slot-position
			cl name
			(primitive-ref cl %slot-descriptions) 0))))

(defun setter-primitive-slot-value (obj name val)
  (let ((cl (class-of obj)))
    (setf (primitive-ref obj
	   (primitive-find-slot-position cl name
	    (primitive-ref cl %slot-descriptions) 0))
	  val)))

(defsetf primitive-slot-value setter-primitive-slot-value)

(defun stable-generic-function-discriminating-function (gf)
  (if (eq (class-of gf) generic-function)
      (primitive-ref gf %discriminating-function)
      (generic-function-discriminating-function gf)))

(eval-when (compile load eval)

(defun construct-name (fmt &rest args)
  (let ((*print-case* :upcase))
    (intern (apply #'format () fmt args))))

(defun reader2writer (name)
  (construct-name "SETTER-~a" name))

(defun get-gf-name (name)
  (cond ((symbolp name) name)
 	((and (consp name) (eq (car name) 'setf))
	 (reader2writer (cadr name)))
 	(t (error "bad name for generic ~a" name))))

(defvar required (list 'required))

(defun key2symbol (k)
  (if (keywordp k)
      (intern (symbol-name k))
      k))

(defun symbol2key (s)
  (if (keywordp s)
      s
      (intern (symbol-name s) :keyword)))

(defun find-key (name initargs default)
  (let* ((key (symbol2key name))
 	 (val (getf initargs key default)))
    (if (eq val required)
 	(error "Missing required initarg ~s" name)
 	val)))

(defun filter-initargs (initargs ignore)
  (cond ((null initargs) ())
 	((memq (car initargs) ignore)
 	 (filter-initargs (cddr initargs) ignore))
 	(t (cons (car initargs)
 		 (cons (cadr initargs)
		       (filter-initargs (cddr initargs) ignore))))))

(defun do-defgeneric-methods (name initargs)
  (cond ((null initargs) ())
	((eq (car initargs) :method)
 	 (cons `(defmethod ,name ,@(cadr initargs))
	       (do-defgeneric-methods name (cddr initargs))))
 	(t (do-defgeneric-methods name (cddr initargs)))))

(defun required-args (domain)
  (cond ((atom domain) ())
	((null (cdr domain)) domain)
	((eq (car domain) '&rest) ())
	(t (cons (car domain)
		 (required-args (cdr domain))))))

) ; end of eval-when

; allows (defgeneric (setf foo) ...)
(defmacro defgeneric (gfname arglist . initargs)
"Syntax: (defgeneric gfname (arglist) {initarg}*), where
gfname is {symbol | (setf symbol)},
arglist is {{symbol | (symbol class)}+ [ . symbol ]}, and
initarg is {key val}. Allowable initargs include
:class                   the class of the generic function
:method-class            the class of the associated methods
:method-initargs         a list of {key val} initargs to be passed to
                         calls of defmethod on this gfname
:method                  a method to be attached to the generic function
The :method initarg can be repeated."
  (let* ((gf-class (find-key :class initargs 'generic-function))
	 (method-class (find-key :method-class initargs 'method))
	 (domain (mapcar #'(lambda (a) (if (atom a) 'object (cadr a)))
			 (required-args arglist)))
#+CMU    (args (mapcar #'(lambda (a) (if (atom a) a (car a)))
		       (required-args arglist)))
 	 (name (get-gf-name gfname)))
    `(progn
       (defvar ,name ()
	 ,(find-key :documentation initargs
		    (format () "The generic function ~a ~a" name arglist)))
       (setq ,name (make-generic-function
		    ',name
		    (list ,@domain)
		    ,gf-class
		    ,method-class
		    (list ,@(find-key :method-initargs initargs ()))
		    (list 
		     ,@(filter-initargs
			initargs
			'(:class :method-class :method
			  :method-initargs :documentation)))))
#+CMU   (defun ,name ,args (list ,@args))
#-CLISP (setf (symbol-function ',name)
	      (stable-generic-function-discriminating-function ,name))
#+CLISP (progn
	  (eval-when (compile)
	    (system::c-defun ',name))
	  (system::remove-old-definitions ',name)
	  (system::%putd ',name
	    (stable-generic-function-discriminating-function ,name))
	  (eval-when (eval)
	    (system::%put ',name 'system::definition
	      '(defgeneric ,gfname ,arglist ,@initargs))))
       ,@(do-defgeneric-methods name initargs)
       ,@(if (eq name gfname) () `((defsetf ,(cadr gfname) ,name)))
       ',name)))

(defun make-generic-function
  (name domain gf-class method-class method-inits initargs)
  (if (and (eq gf-class generic-function)
	   (eq method-class method)
	   (null method-inits)
	   (null initargs))
      (primitive-make-generic-function name domain)
      (apply #'make
	     gf-class
	     :name name
	     :domain domain
	     :method-class method-class
	     :method-initargs method-inits
	     initargs)))

(defun primitive-make-generic-function (name domain)
  (let ((gf (primitive-allocate generic-function gf-size)))
    (setf (primitive-ref gf %name) name)
    (setf (primitive-ref gf %domain) domain)
    (setf (primitive-ref gf %method-class) method)
    (setf (primitive-ref gf %method-initargs) ())
    (setf (primitive-ref gf %methods) ())
    (let* ((nargs (length domain))
	   (lookup #'(lambda (&rest values)
		       (the-method-lookup-function
			gf
			(required-domain values nargs)))))
      (setf (primitive-ref gf %method-lookup-function) lookup)
      (setf (primitive-ref gf %cache) (new-cache))
      (setf (primitive-ref gf %discriminating-function)
	    (compute-primitive-discriminating-function gf lookup)))
    gf))

(defun check-nargs (gf nvals nargs)
  (unless (>= nvals nargs)
    (error "argument count mismatch: ~a requires ~r argument~:p,
but ~r ~:*~[were~;was~:;were~] supplied"
	   gf nargs nvals)))

; cache, c-n-m
; cf compute-discriminating-function
; takes same args as the gf
(defun compute-primitive-discriminating-function (gf lookup-fn)
  (let ((cache (primitive-ref gf %cache))
	(nargs (length (primitive-ref gf %domain))))
    #'(lambda (&rest values)
	(check-nargs gf (length values) nargs)
	(let ((applicable (cache-lookup
			   values
			   (required-domain values nargs)
			   cache
			   lookup-fn)))
	  (if (null applicable)
	      (error "no applicable methods ~s:~%arguments:~%~s~%classes:~%~s"
		     gf
		     values
		     (mapcar #'class-of values))
	      (apply (car applicable)	; apply-method
		     (cdr applicable)
		     values
		     values))))))

(defun stable-method-function (md)
  (if (eq (class-of md) method)
      (primitive-ref md %function)
      (method-function md)))

(defun stable-class-precedence-list (cl)
  (if (primitive-metaclass? cl)
      (primitive-ref cl %precedence-list)
      (class-precedence-list cl)))

; this one gets the correct number of required args
(defun the-method-lookup-function (gf classes)
  (let ((cpls (mapcar #'stable-class-precedence-list classes)))
    (if (and (eq (class-of gf) generic-function)
	     (listp classes))
	(primitive-method-lookup-function gf classes cpls)
	(general-method-lookup-function gf classes cpls))))

; note we don't know the class of the methods at this point
(defun primitive-method-lookup-function (gf classes cpls)
  (sort (select-methods classes (primitive-ref gf %methods))
	#'(lambda (md1 md2)
            (sig<= (stable-method-domain md1)
                   (stable-method-domain md2)
                   cpls))))

(defun general-method-lookup-function (gf classes cpls)
  (sort (select-methods classes (generic-function-methods gf))
	#'(lambda (md1 md2)
	    (sig<= (method-domain md1)
		   (method-domain md2)
		   cpls))))

(defun stable-method-domain (md)
  (if (eq (class-of md) method)
      (primitive-ref md %domain)
      (method-domain md)))

; select-methods copies, as sort is destructive
(defun select-methods (classes meths)
  (if (null meths)
      ()
      (let ((md (car meths)))
	(if (sig-applicable? classes (stable-method-domain md))
	    (cons md (select-methods classes (cdr meths)))
	    (select-methods classes (cdr meths))))))

; assume equal length
(defun sig-applicable? (m1 m2)
  (cond ((null m1) t)
	((cpl-subclass? (car m1) (car m2))
	 (sig-applicable? (cdr m1) (cdr m2)))
	(t ())))

; assume equal length
(defun sig<= (sig1 sig2 cpls)
  (cond ((null sig1) t)
	((eq (car sig1) (car sig2))
	 (sig<= (cdr sig1) (cdr sig2) (cdr cpls)))
	(t (cpl-preceeds? (car sig1) (car sig2) (car cpls)))))

; must have cl1 and cl2 in cpl
(defun cpl-preceeds? (cl1 cl2 cpl)
  (cond ((eq cl1 (car cpl)) t)
	((eq cl2 (car cpl)) ())
	(t (cpl-preceeds? cl1 cl2 (cdr cpl)))))

; cache
(defun new-cache ()
  (cons () ()))

(defmacro fast-cache (c) `(car ,c))
(defmacro slow-cache (c) `(cdr ,c))

(defun reset-cache (cache)
  (setf (fast-cache cache) ())
  (setf (slow-cache cache) ())
  cache)

(defun required-domain (values nargs)
  (if (> nargs 0)
      (cons (class-of (car values))
	    (required-domain (cdr values) (- nargs 1)))
      ()))

; cache
(defun cache-lookup (values classes cache lookup)
  (let ((fast (fast-cache cache))
	(slow (slow-cache cache)))
    (if (and (consp fast)
	     (equal (car fast) classes))
 	(cdr fast)
 	(let ((cc (member classes slow :test #'equal :key #'car)))
	  (if (null cc)
	      (let ((applicable (apply lookup values)))
		(if (null applicable)
		    ()
		    (let ((new (cons classes
				     (cons (stable-method-function
					    (car applicable))
					   (cdr applicable)))))
		      (setf (fast-cache cache) new)
		      (setf (slow-cache cache) (cons new slow))
		      (cdr new))))
	      (progn
 		(setf (fast-cache cache) (car cc))
 		(cdar cc)))))))

(eval-when (compile load eval)

; c-n-m
(defmacro method-function-lambda (args . body)
  `#'(lambda (*method-list* *argument-list* ,@args) ,@(block-body () body)))

#-KCL
(defmacro named-method-function-lambda (name args . body)
  `#'(lambda (*method-list* *argument-list* ,@args) ,@(block-body name body)))

(defun block-body (gfname body)
  (if (consp body)
      (cond ((stringp (car body))
	     (if (null (cdr body))
		 body
		 (block-body gfname (cdr body))))
	    ((and (consp (car body))
		  (eq (caar body) 'declare))
	     `(,(car body) ,@(block-body gfname (cdr body))))
	    (t (if (null gfname)
		   `((progn *method-list* *argument-list*)
			    ,@body)
		   `((block ,gfname *method-list* *argument-list* ,@body)))))
      ()))

)

; (defmethod foo ((a integer)...) ...)
; (defmethod foo :method-initarg 23 ... ((a integer)...) ...)
; allows (defmethod (setf foo) ...)
#-KCL
(defmacro defmethod (gfun . form)
  "Syntax: (defmethod gfname {key val}* (arglist) {form}*), where
gfname is {symbol | (setf symbol)}, and arglist is
{{symbol | (symbol class)}+ [ . symbol ]}"
  (let* ((initargs (defmethod-initargs form))
	 (sig (defmethod-sig form))
	 (body (defmethod-body form))
	 (inits (filter-initargs initargs '(:class)))
	 (method-class (find-key :class initargs ()))
	 (args (defmethod-args sig))
	 (domain (defmethod-domain sig))
	 (gfn (get-gf-name gfun)))
    `(stable-add-method
      ,gfn
      (make-method ,(if (null method-class)
			`(stable-generic-function-method-class ,gfn)
			method-class)
		   (list ,@domain)
		   (named-method-function-lambda ,gfn ,args ,@body)
		   (append
		    (list ,@inits)
		    (stable-generic-function-method-initargs ,gfn))))))

;; KCL has problems compiling the above due to
;; a combination of not bothering to macroexpand at compile time and
;; an inability to compile lambdas in random locations
#+KCL
(defmacro defmethod (gfun . form)
  "Syntax: (defmethod gfname {key val}* (arglist) {form}*), where
gfname is {symbol | (setf symbol)}, and arglist is
{{symbol | (symbol class)}+ [ . symbol ]}"
  (let* ((initargs (defmethod-initargs form))
	 (sig (defmethod-sig form))
	 (body (defmethod-body form))
	 (inits (filter-initargs initargs '(:class)))
	 (method-class (find-key :class initargs ()))
	 (args (defmethod-args sig))
	 (domain (defmethod-domain sig))
	 (gfn (get-gf-name gfun))
	 (ml (gensym (format () "~a/METHOD" gfn))))
    `(progn
       (defun ,ml (*method-list* *argument-list* ,@args) ; c-n-m
	 ,@(block-body gfn body))
       (stable-add-method
	,gfn
	(make-method ,(if (null method-class)
			  `(stable-generic-function-method-class ,gfn)
			  method-class)
		     (list ,@domain)
		     #',ml
		     (append
		      (list ,@inits)
		      (stable-generic-function-method-initargs ,gfn)))))))

(eval-when (compile load eval)

(defun defmethod-initargs (form)
  (if (atom (car form))
      (cons (car form)
	    (cons (cadr form) (defmethod-initargs (cddr form))))
      ()))

(defun defmethod-sig (form)
  (if (atom (car form))
      (defmethod-sig (cddr form))
      (car form)))

(defun defmethod-body (form)
  (if (atom (car form))
      (defmethod-body (cddr form))
      (cdr form)))

(defun defmethod-args (sig)
  (cond ((atom sig) (list '&rest sig))
	((null (cdr sig)) (list (if (atom (car sig)) (car sig) (caar sig))))
	((eq (car sig) '&rest) sig)
	(t (cons (if (atom (car sig)) (car sig) (caar sig))
		 (defmethod-args (cdr sig))))))

(defun defmethod-domain (sig)
  (cond ((atom sig) ())
	((null (cdr sig)) (list (if (atom (car sig)) 'object (cadar sig))))
	((eq (car sig) '&rest) ())
	(t (cons (if (atom (car sig)) 'object (cadar sig))
		 (defmethod-domain (cdr sig))))))

) ; end of eval-when

(defun stable-generic-function-method-class (gf)
  (if (eq (class-of gf) generic-function)
      (primitive-ref gf %method-class)
      (generic-function-method-class gf)))

(defun stable-generic-function-method-initargs (gf)
  (if (eq (class-of gf) generic-function)
      (primitive-ref gf %method-initargs)
      (generic-function-method-initargs gf)))

(defun stable-add-method (gf md)
  (if (and (eq (class-of gf) generic-function)
	   (eq (class-of md) method))
      (primitive-add-method gf md)
      (add-method gf md)))

; cpl-subclass as we are talking about inheritance of behaviour
(defun check-method-domain (md md-dom gf gf-dom)
  (unless (and (= (length md-dom)
		  (length gf-dom))
	       (every #'cpl-subclass? md-dom gf-dom))
    (error "domain mismatch in add-method:~%~s ~s" gf md)))

; cf add-method
; cache
(defun primitive-add-method (gf md)
  (check-method-domain md (primitive-ref md %domain)
		       gf (primitive-ref gf %domain))
  (let ((old (primitive-find-method gf (primitive-ref md %domain))))
    (when old (primitive-remove-method gf old)))
  (setf (primitive-ref gf %methods)
	(cons md (primitive-ref gf %methods)))
  (setf (primitive-ref md %generic-function) gf)
  (setf (primitive-ref gf %cache) (reset-cache (primitive-ref gf %cache)))
  gf)

(defun stable-find-method (gf domain)
  (if (and (eq (class-of gf) generic-function)
	   (listp domain))
      (primitive-find-method gf domain)
      (find-method gf domain)))

; cf find-method
(defun primitive-find-method (gf sig)
  (find sig (primitive-ref gf %methods)
	:test #'equal
	:key #'stable-method-domain))

(defun stable-remove-method (gf md)
  (if (and (eq (class-of gf) generic-function)
	   (eq (class-of md) method))
      (primitive-remove-method gf md)
      (remove-method gf md)))

; cf remove method
; cache
(defun primitive-remove-method (gf md)
  (let ((mds (primitive-ref gf %methods)))
    (when (memq md mds)
      (setf (primitive-ref gf %methods)
	    (remove md mds :test #'eq))
      (setf (primitive-ref md %generic-function) ())
      (setf (primitive-ref gf %cache)
	    (reset-cache (primitive-ref gf %cache)))))
  gf)

(defun make-method (method-class domain fn inits)
  (if (and (eq method-class method)
	   (listp domain)
	   (functionp fn)
	   (null inits))
      (primitive-make-method domain fn)
      (apply #'make
	     method-class
	     :domain domain
	     :function fn
	     inits)))

(defun primitive-make-method (domain fn)
  (let ((md (primitive-allocate method method-size)))
    (setf (primitive-ref md %domain) domain)
    (setf (primitive-ref md %function) fn) md))

#+unrestricted-metaclass
(progn

; slot accessors
(defgeneric class-name ((cl class))
  :method (((cl class)) (primitive-ref cl %name)))

(defgeneric (setf class-name) ((cl class) (val symbol))
  :method (((cl class) (val symbol)) (setf (primitive-ref cl %name) val)))

(defgeneric class-instance-length ((cl class))
  :method (((cl class)) (primitive-ref cl %instance-length)))

(defgeneric (setf class-instance-length) ((cl class) (val integer))
  :method (((cl class) (val integer))
	   (setf (primitive-ref cl %instance-length) val)))

(defgeneric class-direct-superclasses ((cl class))
  :method (((cl class)) (primitive-ref cl %direct-superclasses)))

(defgeneric (setf class-direct-superclasses) ((cl class) (val list))
  :method (((cl class) (val list))
	   (setf (primitive-ref cl %direct-superclasses) val)))

(defgeneric class-direct-subclasses ((cl class))
  :method (((cl class)) (primitive-ref cl %direct-subclasses)))

(defgeneric (setf class-direct-subclasses) ((cl class) (val list))
  :method (((cl class) (val list))
	   (setf (primitive-ref cl %direct-subclasses) val)))

(defgeneric class-slot-descriptions ((cl class))
  :method (((cl class)) (primitive-ref cl %slot-descriptions)))

(defgeneric (setf class-slot-descriptions) ((cl class) (val list))
  :method (((cl class) (val list))
	   (setf (primitive-ref cl %slot-descriptions) val)))

(defgeneric class-initargs ((cl class))
  :method (((cl class)) (primitive-ref cl %initargs)))

(defgeneric (setf class-initargs) ((cl class) (val list))
  :method (((cl class) (val list)) (setf (primitive-ref cl %initargs) val)))

(defgeneric class-precedence-list ((cl class))
  :method (((cl class)) (primitive-ref cl %precedence-list)))

(defgeneric (setf class-precedence-list) ((cl class) (val list))
  :method (((cl class) (val list))
	   (setf (primitive-ref cl %precedence-list) val)))

(defgeneric generic-function-name ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %name)))

(defgeneric (setf generic-function-name) ((gf generic-function) (val symbol))
  :method (((gf generic-function) (val symbol))
	   (setf (primitive-ref gf %name) val)))

(defgeneric generic-function-domain ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %domain)))

(defgeneric (setf generic-function-domain) ((gf generic-function) (val list))
  :method (((gf generic-function) (val list))
	   (setf (primitive-ref gf %domain) val)))

(defgeneric generic-function-method-class ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %method-class)))

(defgeneric (setf generic-function-method-class)
  ((gf generic-function) (val method))
  :method (((gf generic-function) (val method))
	   (setf (primitive-ref gf %method-class) val)))

(defgeneric generic-function-method-initargs ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %method-initargs)))

(defgeneric (setf generic-function-method-initargs)
  ((gf generic-function) (val list))
  :method (((gf generic-function) (val list))
	   (setf (primitive-ref gf %method-initargs) val)))

(defgeneric generic-function-methods ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %methods)))

(defgeneric (setf generic-function-methods)
  ((gf generic-function) (val list))
  :method (((gf generic-function) (val list))
	   (setf (primitive-ref gf %methods) val)))

(defgeneric generic-function-method-lookup-function ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %method-lookup-function)))

(defgeneric (setf generic-function-method-lookup-function)
  ((gf generic-function) (val function))
  :method (((gf generic-function) val)
	   (setf (primitive-ref gf %method-lookup-function) val)))

(defgeneric generic-function-discriminating-function ((gf generic-function))
  :method (((gf generic-function))
	   (primitive-ref gf %discriminating-function)))

(defgeneric (setf generic-function-discriminating-function)
  ((gf generic-function) (val function))
  :method (((gf generic-function) val)
	   (setf (primitive-ref gf %discriminating-function) val)))

(defgeneric generic-function-cache ((gf generic-function))
  :method (((gf generic-function)) (primitive-ref gf %cache)))

(defgeneric (setf generic-function-cache) ((gf generic-function) val)
  :method (((gf generic-function) val) (setf (primitive-ref gf %cache) val)))

(defgeneric method-generic-function ((md method))
  :method (((md method)) (primitive-ref md %generic-function)))

(defgeneric (setf method-generic-function) ((md method) (val generic-function))
  :method (((md method) (val generic-function))
	   (setf (primitive-ref md %generic-function) val)))

(defgeneric method-domain ((md method))
  :method (((md method)) (primitive-ref md %domain)))

(defgeneric (setf method-domain) ((md method) (val list))
  :method (((md method) (val list)) (setf (primitive-ref md %domain) val)))

(defgeneric method-function ((md method))
  :method (((md method)) (primitive-ref md %function)))

(defgeneric (setf method-function) ((md method) (val function))
  :method (((md method) val) (setf (primitive-ref md %function) val)))

(defgeneric slot-description-slot-reader ((sd slot-description))
  :method (((sd slot-description)) (primitive-ref sd %reader)))

(defgeneric (setf slot-description-slot-reader)
  ((sd slot-description) (val function))
  :method (((sd slot-description) val) (setf (primitive-ref sd %reader) val)))

(defgeneric slot-description-slot-writer ((sd slot-description))
  :method (((sd slot-description)) (primitive-ref sd %writer)))

(defgeneric (setf slot-description-slot-writer)
  ((sd slot-description) (val function))
  :method (((sd slot-description) val) (setf (primitive-ref sd %writer) val)))

(defgeneric slot-description-name ((sd slot-description))
  :method (((sd local-slot-description)) (primitive-ref sd %lsdname)))

(defgeneric (setf slot-description-name) ((sd slot-description) (val symbol))
  :method (((sd local-slot-description) (val symbol))
	   (setf (primitive-ref sd %lsdname) val)))

(defgeneric slot-description-initfunction ((sd slot-description))
  :method (((sd local-slot-description)) (primitive-ref sd %initfunction)))

(defgeneric (setf slot-description-initfunction)
  ((sd slot-description) (val function))
  :method (((sd local-slot-description) val)
	   (setf (primitive-ref sd %initfunction) val)))

(defun primitive-make-slot-description (name reader writer)
  (let ((sd (primitive-allocate local-slot-description lsd-size)))
    (setf (primitive-ref sd %lsdname) name)
    (setf (primitive-ref sd %initfunction) #'unbound)
    (setf (primitive-ref sd %reader) reader)
    (setf (primitive-ref sd %writer) writer)
    sd))

(defun make-slotds (names readers writers)
  (mapcar #'(lambda (name reader writer)
	      (primitive-make-slot-description name reader writer))
	    names readers writers))

;; install the slotds ....
;; get a macro to do this later
(let ((class-slotds (make-slotds class-slots
				 (list class-name
				       class-instance-length
				       class-direct-superclasses
				       class-direct-subclasses
				       class-slot-descriptions
				       class-initargs
				       class-precedence-list)
				 (list setter-class-name
				       setter-class-instance-length
				       setter-class-direct-superclasses
				       setter-class-direct-subclasses
				       setter-class-slot-descriptions
				       setter-class-initargs
				       setter-class-precedence-list))))
  (setf (primitive-ref class %slot-descriptions) class-slotds)
  (setf (primitive-ref metaclass %slot-descriptions) class-slotds)
  (setf (primitive-ref abstract-class %slot-descriptions) class-slotds)
  (setf (primitive-ref function-class %slot-descriptions) class-slotds)
  (setf (primitive-ref common %slot-descriptions) class-slotds))

(setf (primitive-ref generic-function %slot-descriptions)
      (make-slotds gf-slots
		   (list generic-function-name
			 generic-function-domain
			 generic-function-method-class
			 generic-function-method-initargs
			 generic-function-methods
			 generic-function-method-lookup-function
			 generic-function-discriminating-function
			 generic-function-cache)
		   (list setter-generic-function-name
			 setter-generic-function-domain
                         setter-generic-function-method-class
			 setter-generic-function-method-initargs
                         setter-generic-function-methods
                         setter-generic-function-method-lookup-function
                         setter-generic-function-discriminating-function
                         setter-generic-function-cache)))

(setf (primitive-ref method %slot-descriptions)
      (make-slotds method-slots
		   (list method-generic-function
			 method-domain
			 method-function)
		   (list setter-method-generic-function
			 setter-method-domain
			 setter-method-function)))

(let ((sd-slotds (make-slotds lsd-slots
			      (list slot-description-slot-reader
				    slot-description-slot-writer
				    slot-description-name
				    slot-description-initfunction)
			      (list setter-slot-description-slot-reader
				    setter-slot-description-slot-writer
				    setter-slot-description-name
				    setter-slot-description-initfunction))))
  (setf (primitive-ref slot-description %slot-descriptions)
	(list (car sd-slotds) (cadr sd-slotds)))
  (setf (primitive-ref local-slot-description %slot-descriptions) sd-slotds))

()

) ; end #+unrestricted-metaclass

#-unrestricted-metaclass
(progn

(defun class-name (cl) (primitive-ref cl %name))
(defun setter-class-name (cl val) (setf (primitive-ref cl %name) val))
(defsetf class-name setter-class-name)

(defun class-instance-length (cl) (primitive-ref cl %instance-length))
(defun setter-class-instance-length (cl val)
  (setf (primitive-ref cl %instance-length) val))
(defsetf class-instance-length setter-class-instance-length)

(defun class-direct-superclasses (cl) (primitive-ref cl %direct-superclasses))
(defun setter-class-direct-superclasses (cl val)
  (setf (primitive-ref cl %direct-superclasses) val))
(defsetf class-direct-superclasses setter-class-direct-superclasses)

(defun class-direct-subclasses (cl) (primitive-ref cl %direct-subclasses))
(defun setter-class-direct-subclasses (cl val)
  (setf (primitive-ref cl %direct-subclasses) val))
(defsetf class-direct-subclasses setter-class-direct-subclasses)

(defun class-slot-descriptions (cl) (primitive-ref cl %slot-descriptions))
(defun setter-class-slot-descriptions (cl val)
  (setf (primitive-ref cl %slot-descriptions) val))
(defsetf class-slot-descriptions setter-class-slot-descriptions)

(defun class-initargs (cl) (primitive-ref cl %initargs))
(defun setter-class-initargs (cl val)
  (setf (primitive-ref cl %initargs) val))
(defsetf class-initargs setter-class-initargs)

(defun class-precedence-list (cl) (primitive-ref cl %precedence-list))
(defun setter-class-precedence-list (cl val)
  (setf (primitive-ref cl %precedence-list) val))
(defsetf class-precedence-list setter-class-precedence-list)

(defun generic-function-name (gf) (primitive-ref gf %name))
(defun setter-generic-function-name (gf val)
  (setf (primitive-ref gf %name) val))
(defsetf generic-function-name setter-generic-function-name)

(defun generic-function-domain (gf) (primitive-ref gf %domain))
(defun setter-generic-function-domain (gf val)
  (setf (primitive-ref gf %domain) val))
(defsetf generic-function-domain setter-generic-function-domain)

(defun generic-function-method-class (gf) (primitive-ref gf %method-class))
(defun setter-generic-function-method-class (gf val)
  (setf (primitive-ref gf %method-class) val))
(defsetf generic-function-method-class setter-generic-function-method-class)

(defun generic-function-method-initargs (gf)
  (primitive-ref gf %method-initargs))
(defun setter-generic-function-method-initargs (gf val)
  (setf (primitive-ref gf %method-initargs) val))
(defsetf generic-function-method-initargs
  setter-generic-function-method-initargs)

(defun generic-function-methods (gf) (primitive-ref gf %methods))
(defun setter-generic-function-methods (gf val)
  (setf (primitive-ref gf %methods) val))
(defsetf generic-function-methods setter-generic-function-methods)

(defun generic-function-method-lookup-function (gf)
  (primitive-ref gf %method-lookup-function))
(defun setter-generic-function-method-lookup-function (gf val)
  (setf (primitive-ref gf %method-lookup-function) val))
(defsetf generic-function-method-lookup-function
  setter-generic-function-method-lookup-function)

(defun generic-function-discriminating-function (gf)
  (primitive-ref gf %discriminating-function))
(defun setter-generic-function-discriminating-function (gf val)
  (setf (primitive-ref gf %discriminating-function) val))
(defsetf generic-function-discriminating-function
  setter-generic-function-discriminating-function)

(defun generic-function-cache (gf) (primitive-ref gf %cache))
(defun setter-generic-function-cache (gf val)
  (setf (primitive-ref gf %cache) val))
(defsetf generic-function-cache setter-generic-function-cache)

(defun method-generic-function (md) (primitive-ref md %generic-function))
(defun setter-method-generic-function (md val)
  (setf (primitive-ref md %generic-function) val))
(defsetf method-generic-function setter-method-generic-function)

(defun method-domain (md) (primitive-ref md %domain))
(defun setter-method-domain (md val)
  (setf (primitive-ref md %domain) val))
(defsetf method-domain setter-method-domain)

(defun method-function (md) (primitive-ref md %function))
(defun setter-method-function (md val)
  (setf (primitive-ref md %function) val))
(defsetf method-function setter-method-function)

(defun slot-description-slot-reader (sd) (primitive-ref sd %reader))
(defun setter-slot-description-slot-reader (sd val)
  (setf (primitive-ref sd %reader) val))
(defsetf slot-description-slot-reader setter-slot-description-slot-reader)

(defun slot-description-slot-writer (sd) (primitive-ref sd %writer))
(defun setter-slot-description-slot-writer (sd val)
  (setf (primitive-ref sd %writer) val))
(defsetf slot-description-slot-writer setter-slot-description-slot-writer)

(defun slot-description-name (sd) (primitive-ref sd %lsdname))
(defun setter-slot-description-name (sd val)
  (setf (primitive-ref sd %lsdname) val))
(defsetf slot-description-name setter-slot-description-name)

(defun slot-description-initfunction (sd) (primitive-ref sd %initfunction))
(defun setter-slot-description-initfunction (sd val)
  (setf (primitive-ref sd %initfunction) val))
(defsetf slot-description-initfunction setter-slot-description-initfunction)

(defun primitive-make-slot-description (name index class)
  (let ((sd (primitive-allocate local-slot-description lsd-size)))
    (setf (primitive-ref sd %lsdname) name)
    (setf (primitive-ref sd %initfunction) #'unbound)
    (let ((reader (primitive-make-generic-function
		   (construct-name "~a-~a" (primitive-ref class %name) name)
		   (list class))))
      (stable-add-method reader
			 (primitive-make-method
			  (list class)
			  (method-function-lambda (obj)
			     (primitive-ref obj index))))
    (setf (primitive-ref sd %reader) reader))
    (let ((writer (primitive-make-generic-function
		   (construct-name "SETTER-~a-~a"
				   (primitive-ref class %name)
				   name)
		   (list class object))))
      (stable-add-method writer
			 (primitive-make-method
			  (list class object)
			  (method-function-lambda (obj val)
			    (setf (primitive-ref obj index) val))))
      (setf (primitive-ref sd %writer) writer))
    sd))

(defun make-slotds (names index class)
  (if (null names)
      ()
      (cons (primitive-make-slot-description (car names) index class)
	    (make-slotds (cdr names) (+ index 1) class))))

(let ((class-slotds (make-slotds class-slots 0 class)))
  (setf (primitive-ref class %slot-descriptions) class-slotds)
  (setf (primitive-ref metaclass %slot-descriptions) class-slotds)
  (setf (primitive-ref abstract-class %slot-descriptions) class-slotds)
  (setf (primitive-ref function-class %slot-descriptions) class-slotds)
  (setf (primitive-ref common %slot-descriptions) class-slotds))

(setf (primitive-ref generic-function %slot-descriptions)
      (make-slotds gf-slots 0 generic-function))

(setf (primitive-ref method %slot-descriptions)
      (make-slotds method-slots 0 method))

(let ((sd-slotds (make-slotds lsd-slots 0 slot-description)))
  (setf (primitive-ref slot-description %slot-descriptions)
	(list (car sd-slotds) (cadr sd-slotds)))
  (setf (primitive-ref local-slot-description %slot-descriptions) sd-slotds))

()

) ; end #-unrestricted-metaclass

; more useful accessors
(defgeneric slot-value-using-slot-description ((sd slot-description) obj)
  :method (((sd slot-description) obj)
	   (generic-funcall (slot-description-slot-reader sd) obj)))

(defgeneric (setf slot-value-using-slot-description)
  ((sd slot-description) obj val)
  :method (((sd slot-description) obj val)
	   (generic-funcall (slot-description-slot-writer sd) obj val)))

(eval-when (compile)
  (defsetf slot-value-using-slot-description
    setter-slot-value-using-slot-description))

(defgeneric find-slot-description ((cl class) (symb symbol)))

(defmethod find-slot-description ((cl class) (symb symbol))
  (let ((sd (find (key2symbol symb)
		  (class-slot-descriptions cl)
		  :test #'eq
		  :key #'slot-description-name)))
    (if (null sd)
	(error "slot ~s not found in class ~s" symb cl)
	sd)))

(defun slot-value (obj name)
  (if (primitive-metaclass? (class-of (class-of obj)))
      (primitive-slot-value obj name)
      (slot-value-using-slot-description
       (find-slot-description (class-of obj) name)
       obj)))

(defun setter-slot-value (obj name val)
  (if (primitive-metaclass? (class-of (class-of obj)))
      (setf (primitive-slot-value obj name) val)
      (setf (slot-value-using-slot-description
	     (find-slot-description (class-of obj) name)
	     obj)
	    val)))

(defsetf slot-value setter-slot-value)

;;;--------------------------------------------------------------------
;;;
;;; the MOP proper starts here
;;;
(defun make (cl &rest initargs)
  (initialize (allocate cl initargs) initargs))

(defgeneric allocate ((cl class) inits))

(defmethod allocate ((cl abstract-class) (inits list))
  (declare (ignore inits))
  (error "can't allocate an instance of an abstract-class ~s") cl)

(defmethod allocate ((cl class) (inits list))
  (declare (ignore inits))
  (primitive-allocate cl (class-instance-length cl)))

(defun check-legal-initargs (cl initargs)
  (let ((objinits (class-initargs cl)))
    (labels ((legal-initargs? (inits)
               (cond ((null inits) t)
                     ((memq (car inits) objinits)
                      (legal-initargs? (cddr inits)))
                     (t
                      (error "illegal initarg ~s in initialization of class ~a"
			     (car inits) cl)))))
      (legal-initargs? initargs))))

(defgeneric initialize ((obj object) initargs))

(defmethod initialize ((obj object) (initargs list))
  (let ((cl (class-of obj)))
    (check-legal-initargs cl initargs)
    (mapc #'(lambda (sd)
	      (initialize-using-slot-description obj sd initargs))
	  (class-slot-descriptions cl)))
  obj)

(defgeneric initialize-using-slot-description
  ((obj object) (sd slot-description) initargs))

(defmethod initialize-using-slot-description
  ((obj object) (sd local-slot-description) (initargs list))
  (let ((val (find-key (slot-description-name sd)
		       initargs
		       unbound)))
    (setf (slot-value-using-slot-description sd obj)
	  (if (eq val unbound)
	      (generic-funcall
	       (slot-description-initfunction sd))
	      val)))
  obj)

; relies on name capture
; c-n-m
(defmacro call-next-method ()
  `(if (null *method-list*)
       (error "no next method")
       (apply-method (car *method-list*)
		     (cdr *method-list*)
		     *argument-list*)))

; c-n-m
(defmacro next-method? ()
  `(not (null *method-list*)))

; c-n-m
(defun apply-method (md next-mds args)
  (apply (method-function md) next-mds args args))

; c-n-m
(defun call-method (md next-mds &rest args)
  (apply (method-function md) next-mds args args))

(defmethod initialize ((gf generic-function) (initargs list))
  (let ((name (find-key :name initargs :anonymous))
	(domain (find-key :domain initargs required))
	(method-class (find-key :method-class initargs method))
	(method-inits (find-key :method-initargs initargs ()))
	(methods (find-key :methods initargs ())))
    (call-next-method)
    (setf (generic-function-name gf) name)
    (setf (generic-function-method-class gf) method-class)
    (setf (generic-function-method-initargs gf) method-inits)
    (setf (generic-function-methods gf) ())
    (setf (generic-function-cache gf) (new-cache))
    (let ((lookup-fn (compute-method-lookup-function gf domain)))
      (setf (generic-function-method-lookup-function gf) lookup-fn)
      (setf (generic-function-discriminating-function gf)
	    (compute-discriminating-function gf domain lookup-fn ())))
    (mapc #'(lambda (md) (add-method gf md)) methods))
  gf)

; takes same args as the gf
(defgeneric compute-method-lookup-function ((gf generic-function) (sig list))
  :method (((gf generic-function) (sig cons))
           (declare (ignore sig))
	   (let ((nargs (length (generic-function-domain gf))))
	     #'(lambda (&rest values)
		 (the-method-lookup-function
		  gf
		  (required-domain values nargs))))))

(defgeneric compute-discriminating-function
  ((gf generic-function) (domain list) (lookup-fn function) (meths list)))

; cache
; cf compute-primitive-discriminating-function
; takes same args as the gf
(defmethod compute-discriminating-function
  ((gf generic-function) (domain cons) (lookup-fn function) (meths null))
  (declare (ignore domain meths))
  (let ((cache (generic-function-cache gf))
	(nargs (length (generic-function-domain gf))))
    #'(lambda (&rest values)
	(check-nargs gf (length values) nargs)
	(let ((applicable (cache-lookup
			   values
			   (required-domain values nargs)
			   cache
			   lookup-fn)))
	  (if (null applicable)
	      (error "no applicable methods ~s:~%arguments:~%~s~%classes:~%~s"
		     gf
		     values
		     (mapcar #'class-of values))
	      (apply (car applicable)	; apply-method
		     (cdr applicable)
		     values
		     values))))))

(defmethod initialize ((md method) (initargs list))
  (let ((domain (find-key :domain initargs required))
        (fn (find-key :function initargs required))
	(gf (find-key :generic-function initargs ())))
    (declare (ignore domain fn))
    (call-next-method)
    (unless (null gf) (add-method gf md)) ; make sure the gf knows what's up
    md))

(defgeneric add-method ((gf generic-function) (md method)))

; cf primitive-add-method
; cache
(defmethod add-method ((gf generic-function) (md method))
  (check-method-domain md (method-domain md)
		       gf (generic-function-domain gf))
  (unless (subclass? (class-of md)
		     (generic-function-method-class gf))
    (error "method class mismatch in add-method:~%~s ~s" gf (class-of md)))
  (let ((old (find-method gf (method-domain md))))
    (when old (remove-method gf old)))
  (setf (generic-function-methods gf)
	(cons md (generic-function-methods gf)))
  (setf (method-generic-function md) gf)
  (setf (generic-function-cache gf) (reset-cache (generic-function-cache gf)))
  gf)

(defgeneric find-method ((gf generic-function) (sig list)))

; cf primitive-find-method
(defmethod find-method ((gf generic-function) (sig cons))
  (find sig (generic-function-methods gf)
	:test #'equal
	:key #'method-domain))

(defgeneric remove-method ((gf generic-function) (md method)))

; cf primitive-remove-method
; cache
(defmethod remove-method ((gf generic-function) (md method))
  (let ((mds (generic-function-methods gf)))
    (when (memq md mds)
      (setf (generic-function-methods gf)
            (remove md mds :test #'eq))
      (setf (method-generic-function md) ())
      (setf (generic-function-cache gf)
	    (reset-cache (generic-function-cache gf)))))
  gf)

(defmethod initialize ((sd local-slot-description) (initargs list))
  (find-key :name initargs required)
  (call-next-method)
  (setf (slot-description-initfunction sd)
	(find-key :initfunction initargs #'unbound))
  sd)

(defmethod initialize ((cl class) (initargs list))
  (let ((name
	 (find-key :name initargs :anonymous))
	(direct-supers
	 (find-key :direct-superclasses initargs (list object)))
	(direct-slotds
	 (find-key :direct-slot-descriptions initargs ()))
	(direct-inits
	 (find-key :direct-initargs initargs ())))
    (call-next-method)
    (setf (class-name cl) name)
    (setf (class-direct-superclasses cl) direct-supers)
    (setf (class-direct-subclasses cl) ())
    (unless (compatible-superclasses-p cl direct-supers)
      (error "incompatible superclasses:~%~s can not be a subclass of ~%~s"
	     cl direct-supers))
    (let ((cpl (compute-class-precedence-list cl direct-supers)))
      (setf (class-precedence-list cl) cpl)
      (let ((effective-inits (compute-initargs
			      cl direct-inits
			      (compute-inherited-initargs cl direct-supers))))
	(setf (class-initargs cl) effective-inits)
	(let ((inherited-slotds (compute-inherited-slot-descriptions
				 cl direct-supers)))
	  (let ((effective-slotds
		 (compute-and-ensure-slot-accessors
		  cl (compute-slot-descriptions
		      cl direct-slotds inherited-slotds)
		  inherited-slotds)))
	    (setf (class-slot-descriptions cl) effective-slotds)
	    (setf (class-instance-length cl) (length effective-slotds))
	    (mapcar #'(lambda (super)
			(add-subclass super cl)) direct-supers))))))
  cl)

(defgeneric compatible-superclasses-p ((cl class) (superclasses list)))
  
; si
(defmethod compatible-superclasses-p ((cl class) (superclasses cons))
  (compatible-superclass-p cl (car superclasses)))

(defgeneric compatible-superclass-p ((cl class) (superclass class)))

#+unrestricted-metaclass
(defmethod compatible-superclass-p ((cl class) (super class))
  (subclass? (class-of cl) (class-of super)))

#-unrestricted-metaclass
(defmethod compatible-superclass-p ((cl class) (super class))
  (if (eq super metaclass)
      ()
      (subclass? (class-of cl) (class-of super))))

(defmethod compatible-superclass-p ((cl class) (super abstract-class))
  (declare (ignore cl super))
  t)

; patchy here
(defmethod compatible-superclass-p ((cl abstract-class) (super class))
  (declare (ignore cl super))
  ())

; patchy here
(defmethod compatible-superclass-p ((cl abstract-class) (super abstract-class))
  (declare (ignore cl super))
  t)

(defgeneric compute-class-precedence-list ((cl class) (direct-supers list)))

; si
(defmethod compute-class-precedence-list ((cl class) (direct-supers cons))
  (cons cl (class-precedence-list (car direct-supers))))

(defgeneric compute-inherited-initargs ((cl class) (direct-supers list)))

; si
(defmethod compute-inherited-initargs ((cl class) (direct-supers cons))
  (declare (ignore cl))
  (list (class-initargs (car direct-supers))))

(defgeneric compute-initargs
  ((cl class) (direct-inits list) (inherited-inits list)))

; si
(defmethod compute-initargs
  ((cl class) (direct-inits list) (inherited-inits cons))
  (declare (ignore cl))
  (remove-duplicates (append direct-inits (car inherited-inits))
		     :test #'eq))

(defgeneric compute-inherited-slot-descriptions
  ((cl class) (direct-supers list)))

; si
(defmethod compute-inherited-slot-descriptions
  ((cl class) (direct-supers cons))
  (declare (ignore cl))
  (list (class-slot-descriptions (car direct-supers))))

(defgeneric compute-slot-descriptions
  ((cl class) (slotd-specs list) (inherited-slotds list)))

; si
(defmethod compute-slot-descriptions
  ((cl class) (slotd-specs list) (inherited-slotds cons))
  (let ((old-sd-names (mapcar #'slot-description-name (car inherited-slotds)))
	(new-sd-plist (mapcan #'(lambda (spec)
				  (list (find-key :name spec required)
					spec))
			      slotd-specs)))
	(append
	 (mapcar #'(lambda (sd)
		     (compute-specialized-slot-description
		      cl (list sd)
		      (getf new-sd-plist (slot-description-name sd))))
		 (car inherited-slotds))
	 (mapcan #'(lambda (spec)
		     (if (memq (find-key :name spec required) old-sd-names)
			 ()
			 (list (compute-defined-slot-description
				cl spec))))
		 slotd-specs))))

(defgeneric compute-specialized-slot-description
  ((cl class) (sds list) (spec list)))

; si
(defmethod compute-specialized-slot-description
  ((cl class) (sds cons) (spec null))
  (let ((sd (car sds))
	(sdclass (compute-specialized-slot-description-class cl sds spec)))
    (if (eq sdclass (class-of sd))
	sd
	(make sdclass			; what of other initargs?
	      :name (slot-description-name sd)
	      :initfunction (slot-description-initfunction sd)
	      :reader (slot-description-slot-reader sd)
	      :writer (slot-description-slot-writer sd)))))

; si
(defmethod compute-specialized-slot-description
  ((cl class) (sds cons) (spec cons))
  (apply #'make
	 (compute-specialized-slot-description-class cl sds spec)
	 spec))

(defgeneric compute-specialized-slot-description-class
  ((cl class) (sds list) (spec list)))

(defmethod compute-specialized-slot-description-class
  ((cl class) (sds cons) (spec list))
  (declare (ignore cl sds spec))
  local-slot-description)

(defgeneric compute-defined-slot-description ((cl class) (spec list)))

(defmethod compute-defined-slot-description ((cl class) (spec cons))
  (apply #'make
	 (compute-defined-slot-description-class cl spec)
	 spec))

(defgeneric compute-defined-slot-description-class ((cl class) (spec list)))

(defmethod compute-defined-slot-description-class ((cl class) (spec cons))
  (declare (ignore cl spec))
  local-slot-description)

(defgeneric copy-object (obj))

(defmethod copy-object (obj)
  (let* ((cl (class-of obj))
	 (new (allocate cl ())))
    (mapc #'(lambda (sd)
	      (setf (slot-value-using-slot-description sd new)
		    (slot-value-using-slot-description sd obj)))
	  (class-slot-descriptions cl))
    new))

(defgeneric compute-and-ensure-slot-accessors
  ((cl class) (effective-slotds list) (inherited-slotds list)))

; si
; if inheriting a sd, assume its reader & writer are OK
(defmethod compute-and-ensure-slot-accessors
  ((cl class) (effective-slotds list) (inherited-slotds cons))
  (mapc #'(lambda (sd)
	    (unless (memq sd (car inherited-slotds))
	      (let ((reader (compute-slot-reader cl sd effective-slotds))
		    (writer (compute-slot-writer cl sd effective-slotds)))
		(setf (slot-description-slot-reader sd) reader)
		(setf (slot-description-slot-writer sd) writer)))
	    (ensure-slot-reader cl sd effective-slotds
				(slot-description-slot-reader sd))
	    (ensure-slot-writer cl sd effective-slotds
				(slot-description-slot-writer sd)))
	effective-slotds)
  effective-slotds)

(defgeneric compute-slot-reader
  ((cl class) (slotd slot-description) (effective-slotds list)))

(defmethod compute-slot-reader
  ((cl class) (slotd slot-description) (effective-slotds list))
  (declare (ignore slotd effective-slotds))
  (make generic-function
	:domain (list cl)
	:method-class method))

(defmethod compute-slot-reader
  ((cl class) (slotd local-slot-description) (effective-slotds list))
  (declare (ignore effective-slotds))
  (make generic-function
        :name (construct-name "~a-~a"
                              (class-name cl)
                              (slot-description-name slotd))
        :domain (list cl)
        :method-class method))

(defgeneric compute-slot-writer
  ((cl class) (slotd slot-description) (effective-slotds list)))

(defmethod compute-slot-writer
  ((cl class) (slotd slot-description) (effective-slotds list))
  (declare (ignore slotd effective-slotds))
  (make generic-function
	:domain (list cl object)
	:method-class method))

(defmethod compute-slot-writer
  ((cl class) (slotd local-slot-description) (effective-slotds list))
  (declare (ignore effective-slotds))
  (make generic-function
	:name (construct-name "SETTER-~a-~a"
			      (class-name cl)
			      (slot-description-name slotd))
	:domain (list cl object)
	:method-class method))

(defgeneric ensure-slot-reader
  ((cl class) (slotd slot-description)
   (effective-slotds list) (reader generic-function)))

; if there is a method, assume it's OK
(defmethod ensure-slot-reader
  ((cl class) (slotd slot-description)
   (effective-slotds list) (reader generic-function))
  (when (null (generic-function-methods reader))
    (let ((primitive-reader
	   (compute-primitive-reader-using-slot-description
	    slotd cl effective-slotds)))
      (add-method reader
		  (make (generic-function-method-class reader)
			:domain (list cl)
			:function (method-function-lambda (obj)
				    (funcall primitive-reader obj))))))
  reader)

(defgeneric compute-primitive-reader-using-slot-description
  ((slotd slot-description) (cl class) (effective-slotds list)))

(defmethod compute-primitive-reader-using-slot-description
  ((slotd slot-description) (cl class) (effective-slotds list))
  (compute-primitive-reader-using-class cl slotd effective-slotds))

(defgeneric compute-primitive-reader-using-class
  ((cl class) (slotd slot-description) (effective-slotds list)))

; search on readers rather than names
(defmethod compute-primitive-reader-using-class
  ((cl class) (slotd slot-description) (effective-slotds cons))
  (declare (ignore cl))
  (let ((reader (slot-description-slot-reader slotd)))
    (labels ((count (n slots)
	       (if (eq reader (slot-description-slot-reader (car slots)))
		   n
		   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
	#'(lambda (sd)
	    (primitive-ref sd index))))))

(defgeneric ensure-slot-writer
  ((cl class) (slotd slot-description)
   (effective-slotds list) (writer generic-function)))

; if there is a method, assume it's OK
(defmethod ensure-slot-writer
  ((cl class) (slotd slot-description)
   (effective-slotds list) (writer generic-function))
  (when (null (generic-function-methods writer))
    (let ((primitive-writer
	   (compute-primitive-writer-using-slot-description
	    slotd cl effective-slotds)))
      (add-method writer
		  (make (generic-function-method-class writer)
			:domain (list cl object)
			:function (method-function-lambda (obj val)
				    (funcall primitive-writer obj val))))))
  writer)

(defgeneric compute-primitive-writer-using-slot-description
  ((slotd slot-description) (cl class) (effective-slotds list)))

(defmethod compute-primitive-writer-using-slot-description
  ((slotd slot-description) (cl class) (effective-slotds list))
  (compute-primitive-writer-using-class cl slotd effective-slotds))
  
(defgeneric compute-primitive-writer-using-class
  ((cl class) (slotd slot-description) (effective-slotds list)))

(defmethod compute-primitive-writer-using-class
  ((cl class) (slotd slot-description) (effective-slotds cons))
  (declare (ignore cl))
  (let ((reader (slot-description-slot-reader slotd)))
    (labels ((count (n slots)
	       (if (eq reader (slot-description-slot-reader (car slots)))
                   n
                   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
        #'(lambda (sd val)
	    (setf (primitive-ref sd index) val))))))

(defgeneric add-subclass ((super class) (sub class)))

; would be nice to have weak pointers here
(defmethod add-subclass ((super class) (sub class))
  (setf (class-direct-subclasses super)
	(cons sub (class-direct-subclasses super))))

(eval-when (compile load eval)

(defun do-direct-slotds (slots)
  (cond ((null slots) ())
	((atom (car slots))
	 (cons `(list :name ',(car slots)
		      :initfunction #'unbound)
	       (do-direct-slotds (cdr slots))))
	(t (cons `(list :name ',(caar slots)
			,@(let ((initf (find-key :initform
						 (cdar slots)
						 ())))
			    (if (null initf)
				()
				`(:initfunction
				  #'(lambda () ,initf))))
			,@(filter-initargs (cdar slots)
					   '(:initform :accessor
						       :reader :writer)))
		 (do-direct-slotds (cdr slots))))))

(defun do-accessors (name slots)
  (mapcan #'(lambda (s)
	      (if (atom s)
		  ()
		  (do-accessor name (car s) (cdr s))))
	  slots))

(defun do-accessor (name slotname inits)
  (cond ((null inits) ())
	((eq (car inits) :accessor)
	 (let ((acc (cadr inits))
	       (setter (reader2writer (cadr inits))))
	   (append (do-reader acc name slotname)
		   (do-writer setter name slotname)
		   `((defsetf ,acc ,setter))
		   (do-accessor name slotname (cddr inits)))))
	((eq (car inits) :reader)
	 (let ((acc (cadr inits)))
	   (append (do-reader acc name slotname)
		   (do-accessor name slotname (cddr inits)))))
	((eq (car inits) :writer)
	 (let ((setter (cadr inits)))
	   (append (do-writer setter name slotname)
		   (do-accessor name slotname (cddr inits)))))
	(t (do-accessor name slotname (cddr inits)))))

(defun do-reader (acc name slotname)
  `((defvar ,acc () ,(format () "The ~s slot reader" acc))
    (let ((sdsr (slot-description-slot-reader
		 (find-slot-description ,name ',slotname))))
      (setq ,acc sdsr)
      (setf (symbol-function ',acc)
	    (if (generic-function? sdsr)
		(generic-function-discriminating-function sdsr)
		sdsr)))))

(defun do-writer (setter name slotname)
  `((defvar ,setter () ,(format () "The ~s slot writer" setter))
    (let ((sdsw (slot-description-slot-writer
		 (find-slot-description ,name ',slotname))))
      (setq ,setter sdsw)
      (setf (symbol-function ',setter)
	    (if (generic-function? sdsw)
		(generic-function-discriminating-function sdsw)
		sdsw)))))

(defun do-predicates (name initargs)
  (cond ((null initargs) ())
	((eq (car initargs) :predicate)
	 (let ((pred (cadr initargs)))
	   (append `((defgeneric ,pred (obj)
		       :method ((obj) ())
		       :method (((obj ,name)) t)))
		   (do-predicates name (cddr initargs)))))
	(t (do-predicates name (cddr initargs)))))

(defun do-constructors (name initargs)
  (cond ((null initargs) ())
	((eq (car initargs) :constructor)
	 (let ((con (cadr initargs)))
	   (cons (if (atom con)
		     `(defun ,con (&rest inits)
			(apply #'make ,name inits))
		     `(defun ,(car con) ,(cdr con)
			(make ,name
			      ,@(mapcan #'(lambda (init)
					    (list (symbol2key init)
						  init))
					(cdr con)))))
		 (do-constructors name (cddr initargs)))))
	(t (do-constructors name (cddr initargs)))))

(defun do-printfn (name initargs)
  (let ((pfn (find-key :print-function initargs ())))
    (if (null pfn)
	()
	`((defmethod generic-prin ((obj ,name) str)
	    (funcall ,pfn obj str))))))

) ; end of eval-when

(defmacro defclass (name supers slots . initargs)
"Syntax: (defclass name (supers) (slots) {initargs}*), where
name is a symbol,
supers is {class}*,
slots is {symbol | (symbol {slot-initargs}*)}, and
initargs and slot-initargs are {key val}. Allowable initargs include
:class               the class of the class begin defined
:initargs            a list of the allowable initargs for this class
:predicate           a predicate function for this class
:constructor         a constructor function for this class
:print-function      a function to be added as a method to generic-prin
                     to print an instance
The :predicate and :constructor initargs can be repeated.
Allowable slot-initargs include
:reader              a symbol to name a reader for this slot
:writer              a symbol to name a writer for this slot
:accessor            a symbol to name a reader for this slot; a writer
                     for this slot will be installed as the setf of the
                     reader
:initform            an initial value for the slot
The :reader, :writer, and :accessor initargs can be repeated."
  `(progn
     (defvar ,name ()
       ,(find-key :documentation initargs
		  (format () "The Telos class ~s" name)))
     (setq ,name
       (make ,(find-key :class initargs 'class)
	     :name ',name
	     :direct-superclasses
	     (list ,@(if (null supers) '(object) supers))
	     :direct-slot-descriptions (list ,@(do-direct-slotds slots))
	     :direct-initargs
	     ',(mapcar #'symbol2key (find-key :initargs initargs ()))
	     ,@(filter-initargs initargs '(:initargs :predicate
					   :class :constructor
					   :print-function :documentation))))
     ,@(do-accessors name slots)
     ,@(do-predicates name initargs)
     ,@(do-constructors name initargs)
     ,@(do-printfn name initargs)
     ',name))

(defmacro defmetaclass (name super slots . initargs)
"See defclass for documentation."
  `(progn
     (defvar ,name ()
       ,(find-key :documentation initargs
		  (format () "The Telos metaclass ~s" name)))
     (setq ,name
       (make ,(find-key :class initargs 'metaclass)
	     :name ',name
	     :direct-superclasses
	     (list ,(if (null super) 'class super))
	     :direct-slot-descriptions (list ,@(do-direct-slotds slots))
	     :direct-initargs
	     ',(mapcar #'symbol2key (find-key :initargs initargs ()))
	     ,@(filter-initargs initargs '(:initargs :predicate
					   :class :constructor
					   :print-function :documentation))))
     ,@(do-accessors name slots)
     ,@(do-predicates name initargs)
     ,@(do-constructors name initargs)
     ,@(do-printfn name initargs)
     ',name))

#-telos-debug (progn

(defun primitive-print (obj str xx)
  (declare (ignore xx))
  (generic-prin obj str))

(defgeneric generic-prin (obj str))

(defmethod generic-prin (obj str)
  (let ((*print-case* :downcase))
    (format str "#object([~a])"
	    (class-name (class-of obj)))))

(defmethod generic-prin ((obj class) str)
  (let ((*print-case* :downcase))
    (format str "#class(~a [~a])"
	    (class-name obj)
	    (class-name (class-of obj)))))

(defmethod generic-prin ((obj slot-description) str)
  (let ((*print-case* :downcase))
    (format str "#slotd([~a])"
	    (class-name (class-of obj)))))

(defmethod generic-prin ((obj local-slot-description) str)
  (let ((*print-case* :downcase))
    (format str "#slotd(~a [~a])"
	    (slot-description-name obj)
	    (class-name (class-of obj)))))

(defmethod generic-prin ((obj generic-function) str)
  (let ((*print-case* :downcase))
    (format str "#gfun~a"
	    (cons (generic-function-name obj)
		  (mapcar #'class-name
			  (generic-function-domain obj))))))

(defmethod generic-prin ((obj method) str)
  (let ((*print-case* :downcase))
    (format str "#method~a"
	    (let ((gf (method-generic-function obj)))
	      (cons (if (generic-function? gf)
			(generic-function-name gf)
			:unattached)
		    (mapcar #'class-name
			    (method-domain obj)))))))

(defmethod generic-prin ((obj cl-object) str)
  (format str "~s" obj))

) ; end of telos-debug

(defmethod allocate ((cl common) (inits list))
  (declare (ignore inits))
  (error "can't allocate a CL class: ~s" (class-name cl)))

;----------------------------------------------------------------------

(defun class-hierarchy (&optional (slots? ()))
  (do-class-hierarchy (list object) 0 slots?)
  t)

(defun do-class-hierarchy (objlist depth slots?)
    (print-indent (car objlist) depth)
    (when slots?
      (when (class-slot-descriptions (car objlist))
	(prin-indent "slots: " depth)
	(princ (class-slots-names (car objlist)))
	(fresh-line))
      (when (class-initargs (car objlist))
	(prin-indent "initargs: " depth)
	(princ (class-initargs (car objlist)))
	(fresh-line)))
    (when (class-direct-subclasses (car objlist))
      (do-class-hierarchy (class-direct-subclasses (car objlist))
			  (+ depth 4) slots?))
    (when (cdr objlist)
      (do-class-hierarchy (cdr objlist) depth slots?)))

(defun class-slots-names (cl)
  (mapcar #'slot-description-name
	  (class-slot-descriptions cl)))

(defun print-indent (obj depth)
    (prin-indent obj depth)
    (fresh-line))

(defun prin-indent (obj depth)
  (cond ((> depth 5) (princ "     ") (prin-indent obj (- depth 5)))
	((= depth 0) (princ obj))
	((= depth 1) (princ " ") (princ obj))
	((= depth 2) (princ "  ") (princ obj))
	((= depth 3) (princ "   ") (princ obj))
	((= depth 4) (princ "    ") (princ obj))
	((= depth 5) (princ "     ") (princ obj))))

(defun instance-hierarchy ()
  (let ((classes (collect-all-classes)))
    (do-instance-hierarchy metaclass
			   (remove metaclass classes)
			   0)
    (length classes)))

(defun collect-all-classes ()
  (remove-duplicates (collect-all-classes-aux object)
		     :test #'eq))

(defun collect-all-classes-aux (cl)
  (let ((subs (class-direct-subclasses cl)))
    (if (null subs)
	(list cl)
	(cons cl (mapcan #'(lambda (c)
			     (collect-all-classes-aux c))
			 subs)))))

(defun direct-instance? (cl sup)
  (eq (class-of cl) sup))

(defun class-direct-instances (cl classes)
  (remove-if-not #'(lambda (inst)
		     (direct-instance? inst cl))
		 classes))

(defun do-instance-hierarchy (cl classes depth)
  (let ((instances (class-direct-instances cl classes)))
    (print-indent cl depth)
    (mapc #'(lambda (inst)
	      (do-instance-hierarchy inst classes (+ depth 4)))
	  instances)))

;------------------------------------------------------------------------------

#-telos-debug (progn

(defmetaclass structure-class () ())

(defmethod compute-and-ensure-slot-accessors
  ((c structure-class) (effective-slotds list) (inherited-slotds list))
  (declare (ignore c inherited-slotds))
  (structure-c-a-e-s-a effective-slotds 0)
  effective-slotds)

(defun structure-c-a-e-s-a (effective-slotds index)
  (unless (null effective-slotds)
    (setf (slot-description-slot-reader (car effective-slotds))
	  #'(lambda (obj)
	      (primitive-ref obj index)))
    (setf (slot-description-slot-writer (car effective-slotds))
	  #'(lambda (obj val)
	      (setf (primitive-ref obj index) val)))
    (structure-c-a-e-s-a (cdr effective-slotds) (+ index 1))))

(defclass structure ()
  ()
  :class structure-class)

(defmethod initialize ((s structure) (inits list))
  (declare (ignore inits))
  (call-next-method)
  (mapc #'(lambda (sd)
	    (when (eq (slot-value-using-slot-description sd s) unbound)
	      (setf (slot-value-using-slot-description sd s) ())))
	(class-slot-descriptions (class-of s)))
  s)

(defmethod generic-prin ((s structure) str)
  (let* ((sclass (class-of s))
	 (slots (class-slot-descriptions sclass))
	 (names (mapcar #'slot-description-name slots))
	 (vals  (mapcan #'(lambda (name sd)
			    (list name
				  (slot-value-using-slot-description sd s)))
			names slots)))
    (format str "#struct~s" (cons (class-name sclass) vals))))

(defmacro defstructure (name super slots . inits)
  (let ((initargs (mapcar #'(lambda (s) (if (atom s) s (car s)))
			  slots))
	(slotinits
	 (mapcar #'(lambda (s)
		     (cond ((atom s)
			    `(,s :accessor ,(construct-name "~a-~a" name s)))
			   ((and (not (member :reader (cdr s)))
				 (not (member :writer (cdr s)))
				 (not (member :accessor (cdr s))))
			    `(,(car s) :accessor ,(construct-name
						   "~a-~a"
						   name
						   (car s))
			      ,@(cdr s)))
			   (t s)))
		 slots)))
    `(defclass ,name (,(if (null super) 'structure super))
       ,slotinits
       ,@inits
       :initargs ,initargs
       ,@(unless (member :constructor inits)
	   `(:constructor ,(construct-name "MAKE-~a" name)))
       ,@(unless (member :predicate inits)
	   `(:predicate ,(construct-name "~a-P" name)))
       :class structure-class)))

;------------------------------------------------------------------------------

(defvar *line-length* 60)

(defgeneric describe (obj))

(defmethod describe ((obj cl-object))
  (call-next-method)
#-WCL
  (lisp:describe obj))

(defmethod describe ((obj object))
  (let ((str1 (format () "~%~s is an instance of " obj))
	(str2 (format () "~s~%" (class-of obj))))
    (princ str1)
    (when (> (+ (length str1) (length str2)) *line-length*) (terpri))
    (princ str2))
  (let ((sds (class-slot-descriptions (class-of obj))))
    (when sds
      (let ((*print-case* :downcase))
	(mapc #'(lambda (sd)
		  (let ((val (slot-value-using-slot-description sd obj)))
		    (format t "~a: ~a~%" (slot-description-name sd)
			    (if (eq val unbound)
				'<unbound>
				val))))
	      sds))))
  (values))

) ; end of telos-debug

#+telos-debug (defun describe (x) (lisp:describe x))

;------------------------------------------------------------------------------

(let ((*package* (find-package :user)))
  (shadowing-import '(describe
		      #+KCL allocate
		      #+CMU stream))
#+PCL (unuse-package :pcl)
  (use-package telos))

#+KCL
(eval-when (load)
  (format t "done.~%"))
