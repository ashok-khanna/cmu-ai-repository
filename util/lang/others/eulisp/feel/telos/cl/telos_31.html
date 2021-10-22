#|
Telos in Common Lisp.  Copyright (C) Russell Bradford, August 1992,
                                                       August 1993,
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
        2.2:  Disambiguate find-key returning () to indicate key absent;
              more checking in add-method and generic-prin RJB 93/01/11
        2.3:  Add remove-subclass and change defclass to aid debugging
              RJB 93/01/18
        2.4:  Add method-lambda, call-method-function, apply-method-function;
              change *method-list* to be a list of method-function-lambdas
              RJB 93/01/20
        2.5:  Major renaming of parts, now classes are <classes>
              RJB 93/01/29
        2.6:  Some tidying and rearrangement of redundant code: removed last
              traces of support for unrestricted metaclasses
              RJB 93/02/03
        2.7:  Added generic-lambda, and subsequent tidying; added
              selective discrimination
              RJB 93/03/18
        2.8:  Altered inheritance of initargs and initforms; added slot
              initargs RJB 93/04/06
        3.0:  Class hierarchy rearranged and names changed to reflect latest
              EuLisp definition; default slot accessors are now simple
              functions; general other tidying RJB 93/12/01
        3.1:  Bug in lookup of methods on generics with non-discriminating
              arguments fixed RJB 93/12/17

Thoughts for the day:
Have add-method to call compute-discriminating-function et al, and do
extra optimisation.
Share method-functions amongst compatible methods.
Lazy finalization of classes and gfs.
trace-method
|#

#+CMU
(defpackage :telos)

(in-package :telos)

#-CMU
(eval-when (load)
   (provide :telos))

#+PCL
(unuse-package :pcl)

(shadow '(describe
          #+CMU memq
          #+KCL allocate))

(export '(generic-funcall primitive-ref primitive-class-of primitive-allocate
          class-of subclass? class? slot? function?
          generic-function? method? defgeneric method-function-lambda
          generic-lambda
          method-lambda apply-method-function call-method-function
          defmethod class-name class-instance-length class-direct-superclasses
          class-direct-subclasses class-slots class-keywords
          class-precedence-list generic-function-name generic-function-domain
          generic-function-method-class generic-function-method-keywords
          generic-function-methods generic-function-method-lookup-function
          generic-function-discriminating-function generic-function-cache
	  generic-function-rest
          method-generic-function method-domain
          method-function slot-name slot-default
          slot-reader slot-writer slot-keyword slot-required-p
          slot-value-using-slot find-slot
          slot-value make allocate initialize call-next-method
          next-method? apply-method call-method compute-method-lookup-function
          compute-discriminating-function add-method remove-method
          find-method compatible-superclasses-p compatible-superclass-p
          compute-class-precedence-list class-abstract-p
	  compute-inherited-keywords
          compute-keywords compute-inherited-slots
          compute-slots compute-specialized-slot
          compute-specialized-slot-class
          compute-defined-slot
          compute-defined-slot-class
          copy-object compute-and-ensure-slot-accessors compute-slot-reader
          compute-slot-writer ensure-slot-reader
          compute-primitive-reader-using-slot
          compute-primitive-reader-using-class
          ensure-slot-writer compute-primitive-writer-using-slot
          compute-primitive-writer-using-class add-subclass defclass
          generic-prin built-in-class built-in-object class-hierarchy
          instance-hierarchy structure-class structure defstructure
          describe simple-function find-keyword filter-keywords
          list-all-classes
          <object>
            <class>
              <simple-class>
              <function-class>
              <built-in-class>
            <method>
               <simple-method>
            <slot>
              <local-slot>
            <built-in-object>
              <number>
                <rational>
                  <integer>
                  <ratio>
                <float>
                <complex>
              <package>
              <readtable>
              <hash-table>
              <random-state>
              <stream>
              <pathname>
              <function>
                <generic-function>
                  <simple-generic-function>
                <simple-function>
              <character>
              <symbol>
                <null>
              <array>
                <vector>
                  <string>
                  <bit-vector>
              <sequence>
;                <vector>
;                  <string>
;                  <bit-vector>
                <list>
;                  <null>
                  <cons>
              <structure>))
                  
#+KCL
(eval-when (compile)
   (proclaim '(optimize (safety 2))))        ; checks structure refs

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

(defun key2symbol (k)
  (if (keywordp k)
      (intern (symbol-name k))
      k))

(defun symbol2key (s)
  (if (keywordp s)
      s
      (intern (symbol-name s) :keyword)))

;(pushnew :telos-debug *features*)

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

(defconstant unbound (list 'unbound))
(defun unbound? (x) (eq x unbound))

(defun primitive-allocate (cl size)
  "Args: class size
Allocate and return an uninitialized object that has class CLASS,
and which has size SIZE."
  (make-primitive-class :class cl
                        :slots (make-array size :initial-element unbound)))

;; Descriptions of the hand-crafted classes

; object
(defconstant object-slots ())
(defconstant object-keywords ())
(defconstant object-size 0)

; class
(defconstant %name 0)
(defconstant %instance-length 1)
(defconstant %direct-superclasses 2)
(defconstant %direct-subclasses 3)
(defconstant %slots 4)
(defconstant %keywords 5)
(defconstant %precedence-list 6)
(defconstant %abstractp 7)
(defconstant class-slotz '(name instance-length direct-superclasses
                           direct-subclasses slots
                           keywords class-precedence-list abstractp))
(defconstant class-accessors '(class-name class-instance-length
                               class-direct-superclasses
                               class-direct-subclasses
                               class-slots class-keywords
                               class-precedence-list class-abstract-p))
(defconstant class-inits '(:name :direct-superclasses :direct-slots
                           :direct-keywords :abstractp))
(defconstant class-slot-defaults
  (list #'(lambda () :anonymous)
        unbound
        #'(lambda () (list <object>))
        #'(lambda () ())
        #'(lambda () ())
        #'(lambda () ())
        unbound
        #'(lambda ()())))
(defconstant class-size (length class-slotz))

; generic-function
;(defconstant %name 0)
(defconstant %domain 1)
(defconstant %method-class 2)
(defconstant %method-keywords 3)
(defconstant %methods 4)
(defconstant %method-lookup-function 5)
(defconstant %discriminating-function 6)
(defconstant %cache 7)
(defconstant %rest 8)
(defconstant gf-slots '(name domain method-class method-keywords
                        methods method-lookup-function discriminating-function
                        cache rest))
(defconstant gf-accessors '(generic-function-name generic-function-domain
                            generic-function-method-class
                            generic-function-method-keywords
                            generic-function-methods
                            generic-function-method-lookup-function
                            generic-function-discriminating-function
                            generic-function-cache
			    generic-function-rest))
(defconstant gf-keywords '(:name :domain :function :method-class
                           :method-keywords
                           :methods :method-lookup-function
                           :discriminating-function :rest))
(defconstant gf-slot-defaults
  (list #'(lambda () :anonymous)
        :required
        #'(lambda () (list <simple-method>))
        #'(lambda () ())
        #'(lambda () ())
        unbound
        unbound
        #'(lambda () (new-cache))
        #'(lambda () ())))
(defconstant gf-size (length gf-slots))

; method
(defconstant %generic-function 0)
;(defconstant %domain 1)
(defconstant %function 2)
(defconstant method-slots '(generic-function domain function))
(defconstant method-accessors '(method-generic-function method-domain
                                method-function))
(defconstant method-keywords '(:domain :function :generic-function))
(defconstant method-slot-defaults
  (list unbound
        :required
        :required))
(defconstant method-size (length method-slots))

; slot-description
(defconstant %reader 0)
(defconstant %writer 1)
(defconstant sd-slots '(reader writer))
(defconstant sd-accessors '(slot-reader slot-writer))
(defconstant sd-keywords '(:reader :writer))
(defconstant sd-size (length sd-slots))

; local-slot-description
(defconstant %lsdname 2)
(defconstant %keyword 3)
(defconstant %default 4)
(defconstant %requiredp 5)
(defconstant lsd-slots (append sd-slots '(name keyword default requiredp)))
(defconstant lsd-accessors (append sd-accessors
                              '(slot-name
				slot-keyword
                                slot-default
				slot-required-p)))
(defconstant lsd-keywords (append sd-keywords '(:name :keyword :default
						:requiredp)))
(defconstant lsd-slot-defaults
  (list unbound
        unbound
        :required
        unbound
        unbound
        #'(lambda () ())))
(defconstant lsd-size (length lsd-slots))

;; Allow the accessors to be inlined
(eval-when (compile)
  (proclaim '(inline class-name setter-class-name
                     class-instance-length setter-class-instance-length
                     class-direct-superclasses setter-class-direct-superclasses
                     class-direct-subclasses setter-class-direct-subclasses
                     class-slots setter-class-slots
                     class-keywords setter-class-keywords
                     class-precedence-list setter-class-precedence-list
		     class-abstract-p setter-class-abstract-p
                     generic-function-name setter-generic-function-name
                     generic-function-domain setter-generic-function-domain
                     generic-function-method-class
                     setter-generic-function-method-class
                     generic-function-method-keywords
                     setter-generic-function-method-keywords
                     generic-function-methods setter-generic-function-methods
                     generic-function-method-lookup-function
                     setter-generic-function-method-lookup-function
                     generic-function-discriminating-function
                     setter-generic-function-discriminating-function
                     generic-function-cache setter-generic-function-cache
		     generic-function-rest setter-generic-function-rest
                     method-generic-function setter-method-generic-function
                     method-domain setter-method-domain
                     method-function setter-method-function
                     slot-reader setter-slot-reader
                     slot-writer setter-slot-writer
		     slot-keyword setter-slot-keyword
                     slot-name setter-slot-name
                     slot-default setter-slot-default
		     slot-required-p setter-slot-required-p)))                 

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

(defun class-slots (cl) (primitive-ref cl %slots))
(defun setter-class-slots (cl val)
  (setf (primitive-ref cl %slots) val))
(defsetf class-slots setter-class-slots)

(defun class-keywords (cl) (primitive-ref cl %keywords))
(defun setter-class-keywords (cl val)
  (setf (primitive-ref cl %keywords) val))
(defsetf class-keywords setter-class-keywords)

(defun class-precedence-list (cl) (primitive-ref cl %precedence-list))
(defun setter-class-precedence-list (cl val)
  (setf (primitive-ref cl %precedence-list) val))
(defsetf class-precedence-list setter-class-precedence-list)

(defun class-abstract-p (cl) (primitive-ref cl %abstractp))
(defun setter-class-abstract-p (cl val)
  (setf (primitive-ref cl %abstractp) val))
(defsetf class-abstract-p setter-class-abstract-p)

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

(defun generic-function-method-keywords (gf)
  (primitive-ref gf %method-keywords))
(defun setter-generic-function-method-keywords (gf val)
  (setf (primitive-ref gf %method-keywords) val))
(defsetf generic-function-method-keywords
  setter-generic-function-method-keywords)

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

(defun generic-function-rest (gf) (primitive-ref gf %rest))
(defun setter-generic-function-rest (gf val)
  (setf (primitive-ref gf %rest) val))
(defsetf generic-function-rest setter-generic-function-rest)

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

(defun slot-reader (sd) (primitive-ref sd %reader))
(defun setter-slot-reader (sd val)
  (setf (primitive-ref sd %reader) val))
(defsetf slot-reader setter-slot-reader)

(defun slot-writer (sd) (primitive-ref sd %writer))
(defun setter-slot-writer (sd val)
  (setf (primitive-ref sd %writer) val))
(defsetf slot-writer setter-slot-writer)

(defun slot-keyword (sd) (primitive-ref sd %keyword))
(defun setter-slot-keyword (sd val)
  (setf (primitive-ref sd %keyword) val))
(defsetf slot-keyword setter-slot-keyword)

(defun slot-name (sd) (primitive-ref sd %lsdname))
(defun setter-slot-name (sd val)
  (setf (primitive-ref sd %lsdname) val))
(defsetf slot-name setter-slot-name)

(defun slot-default (sd) (primitive-ref sd %default))
(defun setter-slot-default (sd val)
  (setf (primitive-ref sd %default) val))
(defsetf slot-default setter-slot-default)

(defun slot-required-p (sd) (primitive-ref sd %requiredp))
(defun setter-slot-required-p (sd val)
  (setf (primitive-ref sd %requiredp) val))
(defsetf slot-required-p setter-slot-required-p)

(defvar <simple-class> (primitive-allocate () class-size)
  "The Telos metaclass SIMPLE-CLASS")

(defvar <class> (primitive-allocate <simple-class> class-size)
  "The Telos metaclass CLASS")

(defvar <function-class> (primitive-allocate <simple-class> class-size)
  "The Telos metaclass FUNCTION-CLASS")

(defvar <object> (primitive-allocate <simple-class> class-size)
  "The Telos abstract class OBJECT")

(defvar <generic-function> (primitive-allocate <function-class> class-size)
  "The Telos abstract class GENERIC-FUNCTION")

(defvar <simple-generic-function>
  (primitive-allocate <function-class> class-size)
  "The Telos class SIMPLE-GENERIC-FUNCTION")

(defvar <method> (primitive-allocate <simple-class> class-size)
  "The Telos abstract class METHOD")

(defvar <simple-method> (primitive-allocate <simple-class> class-size)
  "The Telos class SIMPLE-CLASS")

(defvar <slot> (primitive-allocate <simple-class> class-size)
  "The Telos abstract class SLOT")

(defvar <local-slot> (primitive-allocate <simple-class> class-size)
  "The Telos class LOCAL-SLOT")

; don't print result---it's loopy
(null (setf (primitive-class-of <simple-class>) <simple-class>))

;; CL classes

(defvar <built-in-class> (primitive-allocate <simple-class> class-size)
  "The Telos metaclass BUILT-IN-CLASS")

(defvar <built-in-object> (primitive-allocate <built-in-class> class-size)
  "The Telos abstract class BUILT-IN-OBJECT")

(defvar <structure> (primitive-allocate <built-in-class> class-size)
  "The Telos abstract class STRUCTURE")

(defmacro memq (a b) `(member ,a ,b :test #'eq))

(defconstant cl-class-table (make-hash-table :test #'eq))

; This will be overwritten later when we get around to defining CL classes.
; Hack due to (type-of ()) -> SYMBOL, not NULL as we might hope.
(defvar <null> () "The Telos class NULL")

; KCL uses conses for lambdas: (functionp '(lambda (x) x)) -> t
; but (type-of '(lambda (x) x)) -> CONS
#+KCL
(defvar <simple-function> () "The Telos class SIMPLE FUNCTION")

(defun class-of (obj)
  (cond ((primitive-class-p obj) (primitive-class-of obj))
        ((null obj) <null>)
#+KCL   ((functionp obj) <simple-function>)
        (t (let ((type (type-of obj)))
             (cond ((gethash type cl-class-table))
                   ((and (consp type)
			 (gethash (car type) cl-class-table)))
                   ((symbolp type)
                    (install-new-struct-class type))
                   (t <object>))))))

(defun install-new-struct-class (type)
  (let ((new (make <built-in-class>
                   :name type
                   :direct-superclasses (list <structure>))))
    (setf (gethash type cl-class-table) new)
    new))

(defvar primitive-metaclasses
  (list <simple-class> <function-class> <built-in-class>))

(defun primitive-metaclass? (obj)
  (memq obj primitive-metaclasses))

; assume both are classes
(defun subclass? (a b)
  (cond ((eq a b) t)
         ((null a) ())
         (t (some #'(lambda (c) (subclass? c b))
                 (class-direct-superclasses a)))))

(defun cpl-subclass? (a b)
  (memq b (class-precedence-list a)))

(defun class? (a) (subclass? (class-of a) <class>))

(defun slot? (a) (subclass? (class-of a) <slot>))

(defun generic-function? (a) (subclass? (class-of a) <generic-function>))

(defun method? (a) (subclass? (class-of a) <method>))

#+telos-debug (progn

#+KCL (use-fast-links ())

; temporary version while debugging
; take care to avoid any gf calls
(defun primitive-print (obj str xx)
  (declare (ignore xx))
  (primitive-generic-prin obj str))

(defvar primitive-classes
  (list <object> <simple-class> <class> <function-class>
        <generic-function> <simple-generic-function> <method> <simple-method>
	<slot> <local-slot>))

(defun debug-class-print (cl obj str)
  (format str "#class(~s [~s])" (class-name obj) (class-name cl)))

(defun debug-local-slot-print (cl obj str)
  (format str "#slot(~s)" (slot-name obj)))

(defun debug-simple-gf-print (cl obj str)
  (format str "#gfun~s"
	  (cons (generic-function-name obj)
		(mapcar #'(lambda (o)
			    (cond ((class? o) (class-name o))
				  ((null o) '*)
				  (t unbound)))
			(generic-function-domain obj)))))

(defun debug-simple-method-print (cl obj str)
  (format str "#method~s"
	  (cons (if (generic-function?
		     (method-generic-function obj))
		    (generic-function-name
		     (method-generic-function obj))
		    :unattached)
		(mapcar #'(lambda (o)
			    (cond ((class? o) (class-name o))
				  ((null o) '*)
				  (t unbound)))
			(method-domain obj)))))

(defun debug-default-print (cl obj str)
  (let ((sds (class-slots (class-of obj))))
    (format str "#object(")
    (mapc #'(lambda (sd)
	      (if (slot? sd)
		  (let ((name (slot-name sd)))
		    (if (unbound? name)
			(format str "~s ~s " :??? :???)
			(format str "~s ~s "
				name
				(primitive-slot-value obj name))))
		  (format str "~s ~s " :??? :???)))
	  sds)
    (format str "[~s])"
	    (if (class? cl) (class-name cl) :???))))

(defun primitive-generic-prin (obj str)
  (let ((cl (primitive-class-of obj)))
    (cond ((or (memq obj primitive-classes)
               (primitive-metaclass? cl))
	   (debug-class-print cl obj str))
          ((eq cl <local-slot>)
	   (debug-local-slot-print cl obj str))
	  ((eq cl <simple-generic-function>)
	   (debug-simple-gf-print cl obj str))
          ((eq cl <simple-method>)
	   (debug-simple-method-print cl obj str))
          (t (debug-default-print cl obj str))))
  obj)

) ; end of telos-debug

(defun init-class (cl name isize supers subs inits cpl absp)
  (setf (class-name cl) name)
  (setf (class-instance-length cl) isize)
  (setf (class-direct-superclasses cl) supers)
  (setf (class-direct-subclasses cl) subs)
  (setf (class-keywords cl) inits)
  (setf (class-precedence-list cl) (cons cl cpl))
  (setf (class-abstract-p cl) absp)
  name)

(init-class <object> 'object object-size ()
            (list <class> <method> <slot> <built-in-object>)
            () () t)
(init-class <class> 'class class-size (list <object>)
            (list <simple-class> <function-class> <built-in-class>)
            class-inits (list <object>) t)
(init-class <simple-class> 'simple-class class-size (list <class>) ()
            class-inits (list <class> <object>) ())
(init-class <function-class> 'function-class class-size (list <class>) ()
            class-inits (list <class> <object>) ())
; generic-function delayed until CL classes in place
;(init-class <generic-function> 'generic-function gf-size (list <object>) ()
;            gf-keywords (list <object>) t)
;(init-class <simple-generic-function> 'simple-generic-function
;	    gf-size (list <generic-function>) () gf-keywords
;	    (list <generic-function> <function> <object>) ())
(init-class <method> 'method method-size (list <object>) (list <simple-class>)
            method-keywords (list <object>) t)
(init-class <simple-method> 'simple-method method-size (list <method>)
	    () method-keywords (list <method> <object>) ())
(init-class <slot> 'slot sd-size (list <object>)
            (list <local-slot>) sd-keywords (list <object>) t)
(init-class <local-slot> 'local-slot lsd-size
            (list <slot>) () lsd-keywords
            (list <slot> <object>) ())
(init-class <built-in-class> 'built-in-class class-size (list <class>)
	    () class-inits
            (list <class> <object>) t)
(init-class <built-in-object> 'built-in-object object-size (list <object>)
            (list <structure>) () (list <object>) t)
(init-class <structure> 'structure object-size (list <built-in-object>) ()
            () (list <built-in-object> <object>) t)

;; Now fill in the slots

(defun read-slot0 (obj) (primitive-ref obj 0))
(defun read-slot1 (obj) (primitive-ref obj 1))
(defun read-slot2 (obj) (primitive-ref obj 2))
(defun read-slot3 (obj) (primitive-ref obj 3))
(defun read-slot4 (obj) (primitive-ref obj 4))
(defun read-slot5 (obj) (primitive-ref obj 5))
(defun read-slot6 (obj) (primitive-ref obj 6))
(defun read-slot7 (obj) (primitive-ref obj 7))
(defun read-slot8 (obj) (primitive-ref obj 8))
(defun read-slot9 (obj) (primitive-ref obj 9))

(defvar primitive-readers
  (list #'read-slot0 #'read-slot1 #'read-slot2 #'read-slot3
	#'read-slot4 #'read-slot5 #'read-slot6 #'read-slot7
	#'read-slot8 #'read-slot9))

(defun write-slot0 (obj val) (setf (primitive-ref obj 0) val))
(defun write-slot1 (obj val) (setf (primitive-ref obj 1) val))
(defun write-slot2 (obj val) (setf (primitive-ref obj 2) val))
(defun write-slot3 (obj val) (setf (primitive-ref obj 3) val))
(defun write-slot4 (obj val) (setf (primitive-ref obj 4) val))
(defun write-slot5 (obj val) (setf (primitive-ref obj 5) val))
(defun write-slot6 (obj val) (setf (primitive-ref obj 6) val))
(defun write-slot7 (obj val) (setf (primitive-ref obj 7) val))
(defun write-slot8 (obj val) (setf (primitive-ref obj 8) val))
(defun write-slot9 (obj val) (setf (primitive-ref obj 9) val))

(defvar primitive-writers
  (list #'write-slot0 #'write-slot1 #'write-slot2 #'write-slot3
	#'write-slot4 #'write-slot5 #'write-slot6 #'write-slot7
	#'write-slot8 #'write-slot9))

(defun primitive-make-slot (name index default)
  (let ((sd (primitive-allocate <local-slot> lsd-size)))
    (setf (slot-name sd) name)
    (setf (slot-keyword sd) (symbol2key name))
    (setf (slot-reader sd) (nth index primitive-readers))
    (setf (slot-writer sd) (nth index primitive-writers))
    (if (eq default :required)
	(progn (setf (slot-required-p sd) t)
	       (setf (slot-default sd) unbound))
	(progn (setf (slot-required-p sd) ())
	       (setf (slot-default sd) default)))	   
    sd))

(defun make-slotds (names index defaults)
  (if (null names)
      ()
      (cons (primitive-make-slot (car names) index (car defaults))
            (make-slotds (cdr names) (+ index 1) (cdr defaults)))))

(setf (class-slots <object>) ())
(setf (class-slots <built-in-object>) ())
(setf (class-slots <structure>) ())

(let ((class-slotds (make-slotds class-slotz 0 class-slot-defaults)))
  (setf (class-slots <simple-class>) class-slotds)
  (setf (class-slots <class>) class-slotds)
  (setf (class-slots <function-class>) class-slotds)
  (setf (class-slots <built-in-class>) class-slotds))

(let ((gf-slotds (make-slotds gf-slots 0 gf-slot-defaults)))
  (setf (class-slots <generic-function>) gf-slotds)
  (setf (class-slots <simple-generic-function>) gf-slotds))

(let ((method-slotds (make-slotds method-slots 0 method-slot-defaults)))
  (setf (class-slots <method>) method-slotds)
  (setf (class-slots <simple-method>) method-slotds))

(let ((sd-slotds (make-slotds lsd-slots 0 lsd-slot-defaults)))
  (setf (class-slots <slot>)
        (list (car sd-slotds) (cadr sd-slotds)))
  (setf (class-slots <local-slot>) sd-slotds))

;; CL classes

(defmacro def-cl-class (name <name> supers cpl)
  `(progn
     (defvar ,<name> () ,(format () "The Telos class ~a" name))
     (setq ,<name> (primitive-allocate <built-in-class> class-size))
     (setf (class-name ,<name>) ',name)
     (setf (class-instance-length ,<name>) 0)
     (setf (class-direct-superclasses ,<name>) (list ,@supers))
     (setf (class-direct-subclasses ,<name>) ())
     (setf (class-slots ,<name>) ())
     (setf (class-keywords ,<name>) ())
     (setf (class-abstract-p ,<name>) ())
     (mapc #'(lambda (super)
               (setf (class-direct-subclasses super)
                     (cons ,<name> (class-direct-subclasses super))))
           (list ,@supers))
     (setf (class-precedence-list ,<name>)
           (cons ,<name> (append (list ,@cpl)
				 (list <built-in-object> <object>))))
     (setf (gethash ',name cl-class-table) ,<name>)
     ',<name>))

(defmacro synonym (a b)
  `(setf (gethash ',a cl-class-table) ,b))

(def-cl-class sequence <sequence> (<built-in-object>) ())
(def-cl-class list <list> (<sequence>) (<sequence>))
(def-cl-class cons <cons> (<list>) (<list> <sequence>))
(def-cl-class array <array> (<built-in-object>) ())
(synonym simple-array <array>)
(def-cl-class vector <vector> (<sequence> <array>) (<sequence> <array>))
(synonym simple-vector <vector>)
(def-cl-class bit-vector <bit-vector> (<vector>) (<vector> <sequence> <array>))
(synonym simple-bit-vector <bit-vector>)
(def-cl-class string <string> (<vector>) (<vector> <sequence> <array>))
(synonym simple-string <string>)
#+KCL (synonym fat-string <string>)
(def-cl-class symbol <symbol> (<built-in-object>) ())
(synonym keyword <symbol>)
(def-cl-class null <null> (<list> <symbol>) (<list> <symbol> <sequence>))
(def-cl-class character <character> (<built-in-object>) ())
(synonym string-char <character>)
(synonym standard-char <character>)
;
;
(def-cl-class function <function> (<built-in-object>) ())
(def-cl-class simple-function <simple-function> (<function>) (<function>))
(synonym function <simple-function>)        ; overwrite
(synonym compiled-function <simple-function>)
;;
;; Now do generic-function which was delayed from above
(init-class <generic-function> 'generic-function gf-size (list <function>)
	    (list <simple-generic-function>)
	    gf-keywords (list <function> <object>) t)
(init-class <simple-generic-function> 'simple-generic-function
	    gf-size (list <generic-function>) () gf-keywords
	    (list <generic-function> <function> <object>) ())
(setf (class-direct-subclasses <function>)
      (list <generic-function> <simple-function>))
;
(def-cl-class pathname <pathname> (<built-in-object>) ())
(def-cl-class stream <stream> (<built-in-object>) ())
(def-cl-class random-state <random-state> (<built-in-object>) ())
(def-cl-class hash-table <hash-table> (<built-in-object>) ())
(def-cl-class readtable <readtable> (<built-in-object>) ())
(def-cl-class package <package> (<built-in-object>) ())
(def-cl-class number <number> (<built-in-object>) ())
(def-cl-class complex <complex> (<number>) (<number>))
(def-cl-class float <float> (<number>) (<number>))
(synonym short-float <float>)
(synonym single-float <float>)
(synonym double-float <float>)
(synonym long-float <float>)
(def-cl-class rational <rational> (<number>) (<number>))
(def-cl-class ratio <ratio> (<rational>) (<rational> <number>))
(def-cl-class integer <integer> (<rational>) (<rational> <number>))
(synonym fixnum <integer>)
(synonym bignum <integer>)
(synonym bit <integer>)

(defun primitive-find-slot-position (cl name slots index)
  (cond ((null slots)
         (error "slot ~s not found in class ~s" name cl))
         ((eq name (slot-name (car slots))) index)
         (t (primitive-find-slot-position cl name (cdr slots) (+ index 1)))))

(defun primitive-slot-value (obj name)
  (let ((cl (class-of obj)))
    (primitive-ref obj (primitive-find-slot-position
                        cl name
                        (class-slots cl) 0))))

(defun setter-primitive-slot-value (obj name val)
  (let ((cl (class-of obj)))
    (setf (primitive-ref obj
           (primitive-find-slot-position
            cl name
            (class-slots cl) 0))
          val)))

(defsetf primitive-slot-value setter-primitive-slot-value)

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

(defvar absent (list 'absent))
(defun absent? (x) (eq x absent))

(defun find-keyword (name keywords default)
  "Find a key in a {key val}* keyword list
Syntax: (find-keyword key keyword-list default), where default is a value to
return if the key is absent.  If default is :required, an
error is signalled when the key is absent"
  (let* ((key (symbol2key name))
          (val (getf keywords key default)))
    (if (eq val :required)
         (error "Missing required keyword ~s" name)
         val)))

(defun filter-keywords (ignore keywords)
  "Remove selected {key val} pairs from a keyword list
Syntax: (filter-keywords keys keywords), where keys is
a list of keys.  Returns the keyword list with these keys and their
corresponding values removed"
  (cond ((null keywords) ())
         ((memq (car keywords) ignore)
          (filter-keywords ignore (cddr keywords)))
         (t (cons (car keywords)
                  (cons (cadr keywords)
                       (filter-keywords ignore (cddr keywords)))))))

(defun do-defgeneric-methods (name keywords)
  (cond ((null keywords) ())
        ((eq (car keywords) :method)
          (cons `(defmethod ,name ,@(cadr keywords))
               (do-defgeneric-methods name (cddr keywords))))
         (t (do-defgeneric-methods name (cddr keywords)))))

(defun required-args (domain)
  (cond ((atom domain) ())
        ((eq (car domain) '&rest) ())
        (t (cons (car domain)
                 (required-args (cdr domain))))))

(defun restargs? (domain)
  (cond ((null domain) ())
	((atom domain) t)
	((eq (car domain) '&rest) t)
	(t (restargs? (cdr domain)))))

(defun gf-args (arglist)
  (cond ((null arglist) ())
        ((atom arglist) (list '&rest arglist))
        ((eq (car arglist) '&rest) arglist)
        ((atom (car arglist)) (cons (car arglist) (gf-args (cdr arglist))))
        (t (cons (caar arglist) (gf-args (cdr arglist))))))

(defun proclaim-gf (name arglist)
  (let ((args (mapcar #'(lambda (a) (if (eq a '&rest) '&rest t))
                      (gf-args arglist))))
    `(proclaim '(function ,name ,args t))))

) ; end of eval-when

; allows (defgeneric (setf foo) ...)
(defmacro defgeneric (gfname arglist . keywords)
"Syntax: (defgeneric gfname (arglist) {keyword}*), where
gfname is {symbol | (setf symbol)},
arglist is {{symbol | (symbol class)}+ [ { . | &rest} symbol ]}, and
keyword is {key val}. Allowable keywords include
:class                   the class of the generic function
:method-class            the class of the associated methods
:method-keywords         a list of {key val} keywords to be passed to
                         calls of defmethod on this gfname
:method                  a method to be attached to the generic function
The :method keyword can be repeated."
  (let* ((gf-class (find-keyword :class keywords '<simple-generic-function>))
         (method-class (find-keyword :method-class keywords '<simple-method>))
         (method-inits (find-keyword :method-keywords keywords ()))
         (reqd (required-args arglist))
         (domain (mapcar #'(lambda (a) (if (atom a) () (cadr a)))
                         reqd))
	 (name (get-gf-name gfname))
	 (rest (restargs? arglist)))
    `(progn
       (defvar ,name ()
         ,(find-keyword :documentation keywords
                    (format () "The generic function ~a ~a" name arglist)))
       (setq ,name (make-generic-function
                    ',name
                    (list ,@domain)
		    ,rest
                    ,gf-class
                    ,method-class
                    (list ,@method-inits)
                    (list 
                     ,@(filter-keywords
                        '(:class :method-class :method :name
                          :method-keywords :documentation)
			keywords))))
       ,(proclaim-gf name arglist)
       (setf (symbol-function ',name)
             (generic-function-discriminating-function ,name))
       ,@(do-defgeneric-methods name keywords)
       ,@(if (eq name gfname) () `((defsetf ,(cadr gfname) ,name)))
       ',name)))

(defmacro generic-lambda (arglist . keywords)
"Syntax: (generic-lambda (arglist) {keyword}*).
See defgeneric for details."
  (let* ((gf-class (find-keyword :class keywords '<simple-generic-function>))
         (method-class (find-keyword :method-class keywords '<simple-method>))
	 (method-inits (find-keyword :method-keywords keywords ()))
	 (name (find-keyword :name keywords :anonymous))
         (reqd (required-args arglist))
         (domain (mapcar #'(lambda (a) (if (atom a) () (cadr a)))
                         reqd))
	 (rest (restargs? arglist))
         (gl (gensym "GENERIC-LAMBDA")))
    `(let ((,gl
            (make-generic-function
             ',name
             (list ,@domain)
	     ,rest
             ,gf-class
             ,method-class
             (list ,@method-inits)
             (list 
              ,@(filter-keywords
                 '(:class :method-class :method :name
                          :method-keywords :documentation)
		 keywords)))))
       ,@(do-defgeneric-methods gl keywords)
       ,gl)))

(defun make-generic-function
  (name domain rest gf-class method-class method-inits keywords)
  (if (and (eq gf-class <simple-generic-function>)
           (eq method-class <simple-method>)
           (null method-inits)
           (null keywords))
      (primitive-make-generic-function name domain rest)
      (apply #'make
             gf-class
             :name name
             :domain domain
             :method-class method-class
             :method-keywords method-inits
	     :rest rest
             keywords)))

(defun primitive-make-generic-function (name domain rest)
  (when (every #'null domain)
    (error "initialize of generic function with no discriminators: ~a"
           name))
  (let ((gf (primitive-allocate <simple-generic-function> gf-size)))
    (setf (generic-function-name gf) name)
    (setf (generic-function-domain gf) domain)
    (setf (generic-function-method-class gf) <simple-method>)
    (setf (generic-function-method-keywords gf) ())
    (setf (generic-function-methods gf) ())
    (setf (generic-function-cache gf) (new-cache))
    (setf (generic-function-rest gf) rest)
    (let* ((lookup #'(lambda (&rest values)
                       (the-method-lookup-function gf values domain)))
           (disc (compute-primitive-discriminating-function gf lookup)))
      (setf (generic-function-method-lookup-function gf) lookup)
      (setf (generic-function-discriminating-function gf) disc))
    gf))

(defun check-nargs (gf nvals nargs)
  (unless (>= nvals nargs)
    (error "argument count mismatch: ~a requires ~r argument~:p,
but ~r ~:*~[were~;was~:;were~] supplied"
           gf nargs nvals)))

(defun error-no-applicable-methods (gf values)
  (error "no applicable methods ~s:~%arguments:~%~s~%classes:~%~s"
	 gf
	 values
	 (mapcar #'class-of values)))

; cache, c-n-m
; cf compute-discriminating-function
; takes same args as the gf
(defun compute-primitive-discriminating-function (gf lookup-fn)
  (let* ((cache (generic-function-cache gf))
         (domain (generic-function-domain gf))
         (nargs (length domain)))
    #'(lambda (&rest values)
        (check-nargs gf (length values) nargs)
        (let ((applicable (cache-lookup
                           values
                           (discriminating-domain values domain)
                           cache
                           lookup-fn)))
          (if (null applicable)
	      (error-no-applicable-methods gf values)
              (apply (car applicable)        ; apply-method-function
                     (cdr applicable)
                     values
                     values))))))

(defun the-method-lookup-function (gf values domain)
  (let* ((classes (discriminating-domain values domain))
         (cpls (mapcar #'class-precedence-list classes)))
    (sort (select-methods classes (generic-function-methods gf))
          #'(lambda (md1 md2)
              (sig<= (method-domain md1)
                     (method-domain md2)
                     cpls)))))

; select-methods copies, as sort is destructive
(defun select-methods (classes meths)
  (if (null meths)
      ()
      (let ((md (car meths)))
        (if (sig-applicable? classes (method-domain md))
            (cons md (select-methods classes (cdr meths)))
            (select-methods classes (cdr meths))))))

; args (class class ... ) and (class () class ... )
(defun sig-applicable? (m1 m2)
  (cond ((null m1) t)
	((null (car m2))		; non-discriminating arg
	 (sig-applicable? m1 (cdr m2)))
	((cpl-subclass? (car m1) (car m2))
	 (sig-applicable? (cdr m1) (cdr m2)))
        (t ())))

; assume equal length
(defun sig<= (sig1 sig2 cpls)
  (cond ((null sig1) t)
        ((eq (car sig1) (car sig2))	; also case of non-discriminating arg
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

(defun discriminating-domain (values domain)
  (cond ((null domain) ())
        ((car domain) (cons (class-of (car values))
                            (discriminating-domain (cdr values) (cdr domain))))
        (t (discriminating-domain (cdr values) (cdr domain)))))

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
                                     (mapcar #'method-function
                                             applicable))))
                      (setf (fast-cache cache) new)
                      (setf (slow-cache cache) (cons new slow))
                      (cdr new))))
              (progn
                 (setf (fast-cache cache) (car cc))
                 (cdar cc)))))))

; c-n-m
(defmacro method-function-lambda (args . body)
  "Create a lambda that can be used as the function part of a method.
Syntax: (method-function-lambda (arglist) {form}*), where arglist is
{(symbol+ [ . symbol ]) | (symbol+ [ &rest symbol ])}"
  `#'(lambda (*method-list* *argument-list* ,@args) ,@(block-body () body)))

(defmacro named-method-function-lambda (name args . body)
  `#'(lambda (*method-list* *argument-list* ,@args) ,@(block-body name body)))

(defmacro method-lambda form
  "Create an anonymous method.
Syntax: (method-lambda {key val}* (arglist) {form}*), where arglist is
{{symbol | (symbol class)}+ [{ . | &rest} symbol]}"
  (let* ((keywords (defmethod-keywords form))
         (sig (defmethod-sig form))
         (body (defmethod-body form))
         (inits (filter-keywords '(:class) keywords))
         (method-class (find-keyword :class keywords '<simple-method>))
         (args (defmethod-args sig))
         (domain (defmethod-domain sig)))
    `(make-method ,method-class
                  (list ,@domain)
                  (method-function-lambda ,args ,@body)
                  (list ,@inits))))

(eval-when (compile load eval)

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
                   `((progn *method-list* *argument-list*
                            ,@body))
                   `((block ,gfname *method-list* *argument-list* ,@body)))))
      ()))

) ; eval-when

; (defmethod foo ((a <integer>)...) ...)
; (defmethod foo :method-keyword 23 ... ((a <integer>)...) ...)
; allows (defmethod (setf foo) ...)
(defmacro defmethod (gfun . form)
  "Syntax: (defmethod gfname {key val}* (arglist) {form}*), where
gfname is {symbol | (setf symbol)}, and arglist is
{{symbol | (symbol class)}+ [ . symbol ]}"
  (let* ((keywords (defmethod-keywords form))
         (sig (defmethod-sig form))
         (body (defmethod-body form))
         (inits (filter-keywords '(:class) keywords))
         (method-class (find-keyword :class keywords absent))
         (args (defmethod-args sig))
         (domain (defmethod-domain sig))
         (gfn (get-gf-name gfun))
	 (name (gensym (symbol-name gfn))))
    `(progn
       (defun ,name (*method-list* *argument-list* ,@args)
	 ,@(block-body gfn body))
       (stable-add-method
        ,gfn
        (make-method ,(if (absent? method-class)
                          `(generic-function-method-class ,gfn)
                          method-class)
                     (list ,@domain)
                     #',name
                     (append
                      (list ,@inits)
                      (generic-function-method-keywords ,gfn)))))))

(eval-when (compile load eval)

(defun defmethod-keywords (form)
  (if (atom (car form))
      (cons (car form)
            (cons (cadr form) (defmethod-keywords (cddr form))))
      ()))

(defun defmethod-sig (form)
  (if (atom (car form))
      (defmethod-sig (cddr form))
      (car form)))

(defun defmethod-body (form)
  (if (atom (car form))
      (defmethod-body (cddr form))
      (cdr form)))

; allows {symbol | (symbol+ [ . symbol ]) | (symbol* [ &rest symbol ]) }
(defun defmethod-args (sig)
  (cond ((null sig) ())
        ((atom sig) (list '&rest sig))
        ((eq (car sig) '&rest) sig)
        ((atom (car sig)) (cons (car sig) (defmethod-args (cdr sig))))
        (t (cons (caar sig) (defmethod-args (cdr sig))))))

(defun defmethod-domain (sig)
  (cond ((atom sig) ())
        ((eq (car sig) '&rest) ())
        ((atom (car sig))
         (cons () (defmethod-domain (cdr sig))))
        (t (cons (cadar sig) (defmethod-domain (cdr sig))))))

) ; end of eval-when

(defun stable-add-method (gf md)
  (if (and (eq (class-of gf) <simple-generic-function>)
           (eq (class-of md) <simple-method>))
      (primitive-add-method gf md)
      (add-method gf md)))

; cpl-subclass as we are talking about inheritance of behaviour
(defun check-method-domain (md gf)
  (let ((md-dom (method-domain md))
        (gf-dom (generic-function-domain gf)))
    (unless (= (length md-dom) (length gf-dom))
      (error "domain mismatch in add-method:~%~s~%~s" gf md))
    (unless (every #'(lambda (md gd)
                       (cond (gd (and md (cpl-subclass? md gd)))
                             (md ())
                             (t t)))
                   md-dom gf-dom)
      (error "attempt to extend domain in add-method:~%~s~%~s" gf md))))

; cf add-method
; cache
(defun primitive-add-method (gf md)
  (check-method-domain md gf)
  (when (generic-function? (method-generic-function md))
    (error "method already attached in add-method: ~s~%" md))
  (let ((old (primitive-find-method gf (method-domain md))))
    (when old (primitive-remove-method gf old)))
  (setf (generic-function-methods gf)
        (cons md (generic-function-methods gf)))
  (setf (method-generic-function md) gf)
  (reset-cache (generic-function-cache gf))
  gf)

(defun stable-find-method (gf domain)
  (if (and (eq (class-of gf) <simple-generic-function>)
           (listp domain))
      (primitive-find-method gf domain)
      (find-method gf domain)))

; cf find-method
(defun primitive-find-method (gf sig)
  (find sig (generic-function-methods gf)
        :test #'equal
        :key #'method-domain))

(defun stable-remove-method (gf md)
  (if (and (eq (class-of gf) <simple-generic-function>)
           (eq (class-of md) <simple-method>))
      (primitive-remove-method gf md)
      (remove-method gf md)))

; cf remove method
; cache
(defun primitive-remove-method (gf md)
  (let ((mds (generic-function-methods gf)))
    (when (memq md mds)
      (setf (generic-function-methods gf)
            (remove md mds :test #'eq))
      (setf (method-generic-function md) ())
      (reset-cache (generic-function-cache gf))))
  gf)

(defun make-method (method-class domain fn inits)
  (if (and (eq method-class <simple-method>)
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
  (when (every #'null domain)
    (error "initialization of method with no discriminators"))
  (let ((md (primitive-allocate <simple-method> method-size)))
    (setf (method-domain md) domain)
    (setf (method-function md) fn)
    md))

; more useful accessors
(defgeneric slot-value-using-slot ((sd <slot>) obj)
  :method (((sd <slot>) obj)
           (generic-funcall (slot-reader sd) obj)))

(defgeneric (setf slot-value-using-slot)
  ((sd <slot>) obj val)
  :method (((sd <slot>) obj val)
           (generic-funcall (slot-writer sd) obj val)))

(eval-when (compile)
  (defsetf slot-value-using-slot
    setter-slot-value-using-slot))

(defgeneric find-slot ((cl <class>) (symb <symbol>)))

(defmethod find-slot ((cl <class>) (symb <symbol>))
  (let ((sd (find (key2symbol symb)
                  (class-slots cl)
                  :test #'eq
                  :key #'slot-name)))
    (if (null sd)
        (error "slot ~s not found in class ~s" symb cl)
        sd)))

(defun slot-value (obj name)
  (if (primitive-metaclass? (class-of (class-of obj)))
      (primitive-slot-value obj name)
      (slot-value-using-slot
       (find-slot (class-of obj) name)
       obj)))

(defun setter-slot-value (obj name val)
  (if (primitive-metaclass? (class-of (class-of obj)))
      (setf (primitive-slot-value obj name) val)
      (setf (slot-value-using-slot
             (find-slot (class-of obj) name)
             obj)
            val)))

(defsetf slot-value setter-slot-value)

(defun function? (a) (subclass? (class-of a) <function>))

;;;--------------------------------------------------------------------
;;;
;;; the MOP proper starts here
;;;
(defun make (cl &rest keywords)
  (initialize (allocate cl keywords) keywords))

(defgeneric allocate ((cl <class>) inits))

(defmethod allocate ((cl <class>) inits)
  (declare (ignore inits))
  (when (class-abstract-p cl)
    (error "can't allocate an instance of an abstract-class~%~s" cl))
  (primitive-allocate cl (class-instance-length cl)))

(defun error-unexpected-keyword (key cl)
  (error "unexpected keyword ~s in initialization of object of class~%~a"
	 key cl))

(defun check-legal-keywords (cl keywords)
  (let ((objinits (class-keywords cl)))
    (labels ((legal-keywords? (inits)
               (cond ((null inits) t)
                     ((memq (car inits) objinits)
                      (legal-keywords? (cddr inits)))
                     (t (error-unexpected-keyword (car inits) cl)))))
      (legal-keywords? keywords))))

(defgeneric initialize ((obj <object>) keywords))

(defmethod initialize ((obj <object>) keywords)
  (let ((cl (class-of obj)))
    (check-legal-keywords cl keywords)
    (mapc #'(lambda (sd)
              (initialize-using-slot obj sd keywords))
          (class-slots cl)))
  obj)

(defgeneric initialize-using-slot
  ((obj <object>) (sd <slot>) keywords))

(defun error-missing-keyword (obj key)
  (error "missing required keyword ~s in initialization of object~%of class ~a"
	 key (class-of obj)))

; don't touch the slot in the object if not initializing it
(defmethod initialize-using-slot
  ((obj <object>) (sd <local-slot>) keywords)
  (let* ((keyword (slot-keyword sd))
	 (initfn (slot-default sd))
	 (initval
	  (if (unbound? keyword)
	      (if (function? initfn)
		  (generic-funcall initfn)
		  absent)
	      (let ((val (find-keyword keyword keywords absent)))
		(if (absent? val)
		    (if (slot-required-p sd)
			(error-missing-keyword obj keyword)
			(if (function? initfn)
			    (generic-funcall initfn)
			    absent))
		    val)))))
    (unless (absent? initval)
      (setf (slot-value-using-slot sd obj) initval)))
  obj)

; relies on name capture
; c-n-m
(defmacro call-next-method ()
  `(if (null *method-list*)
       (error "no next method")
       (apply (car *method-list*)        ; apply-method-function
              (cdr *method-list*)
              *argument-list*
              *argument-list*)))

; c-n-m
(defmacro next-method? ()
  `(not (null *method-list*)))

; c-n-m
(defun apply-method (md next-mds args)
  (apply (method-function md)
         (mapcar #'method-function next-mds)
         args
         args))

; c-n-m
(defun call-method (md next-mds &rest args)
  (apply (method-function md) 
         (mapcar #'method-function next-mds)
         args
         args))

;; c-n-m
(defun apply-method-function (mdfn next-mdfns args)
  (apply mdfn next-mdfns args args))

; c-n-m
(defun call-method-function (mdfn next-mdfns &rest args)
  (apply mdfn next-mdfns args args))

(defmethod initialize ((gf <generic-function>) keywords)
  (call-next-method)
  (when (every #'null (generic-function-domain gf))
    (error "initialize of generic function with no discriminators: ~a"
	   (generic-function-name gf)))
  (mapc #'(lambda (md) (add-method gf md)) (find-keyword :methods keywords ()))
  (finalize-generic gf)
  gf)

(defgeneric finalize-generic ((gf <generic-function>)))

(defmethod finalize-generic ((gf <generic-function>))
  (let* ((domain (generic-function-domain gf))
         (methods (generic-function-methods gf))
         (lookup (compute-method-lookup-function gf domain methods))
         (disc (compute-discriminating-function gf domain lookup methods)))
    (setf (generic-function-method-lookup-function gf) lookup)
    (setf (generic-function-discriminating-function gf) disc))
  (reset-cache (generic-function-cache gf))
  gf)

; takes same args as the gf
(defgeneric compute-method-lookup-function
  ((gf <generic-function>) sig methods))

(defmethod compute-method-lookup-function
  ((gf <generic-function>) sig methods)
  (declare (ignore sig methods))
  (let ((domain (generic-function-domain gf)))
    #'(lambda (&rest values)
        (the-method-lookup-function gf values domain))))

(defgeneric compute-discriminating-function
  ((gf <generic-function>) domain lookup-fn meths))

; cache
; cf compute-primitive-discriminating-function
; takes same args as the gf
(defmethod compute-discriminating-function
  ((gf <generic-function>) domain lookup-fn meths)
  (declare (ignore meths))
  (let ((cache (generic-function-cache gf))
        (domain (generic-function-domain gf))
        (nargs (length domain)))
    #'(lambda (&rest values)
        (check-nargs gf (length values) nargs)
        (let ((applicable (cache-lookup
                           values
                           (discriminating-domain values domain)
                           cache
                           lookup-fn)))
          (if (null applicable)
	      (error-no-applicable-methods gf values)
              (apply (car applicable)        ; apply-method
                     (cdr applicable)
                     values
                     values))))))

(defmethod initialize ((md <method>) keywords)
  (call-next-method)
  (when (every #'null (method-domain md))
    (error "initialization of method with no discriminators"))
  (let ((gf (find-keyword :generic-function keywords absent)))
    (unless (absent? gf)
      (add-method gf md)))		; make sure the gf knows what's up
  md)

(defgeneric add-method ((gf <generic-function>) (md <method>)))

; cf primitive-add-method
; cache
(defmethod add-method ((gf <generic-function>) (md <method>))
  (check-method-domain md gf)
  (unless (subclass? (class-of md)
                     (generic-function-method-class gf))
    (error "method class mismatch in add-method:~%~s ~s" gf (class-of md)))
  (when (generic-function? (method-generic-function md))
    (error "method already attached in add-method: ~s~%" md))
  (let ((old (find-method gf (method-domain md))))
    (when old (remove-method gf old)))
  (setf (generic-function-methods gf)
        (cons md (generic-function-methods gf)))
  (setf (method-generic-function md) gf)
  (finalize-generic gf)                        ; resets cache
  gf)

(defgeneric find-method ((gf <generic-function>) sig))

; cf primitive-find-method
(defmethod find-method ((gf <generic-function>) sig)
  (find sig (generic-function-methods gf)
        :test #'equal
        :key #'method-domain))

(defgeneric remove-method ((gf <generic-function>) (md <method>)))

; cf primitive-remove-method
; cache
(defmethod remove-method ((gf <generic-function>) (md <method>))
  (let ((mds (generic-function-methods gf)))
    (when (memq md mds)
      (setf (generic-function-methods gf)
            (remove md mds :test #'eq))
      (setf (method-generic-function md) ())
      (finalize-generic gf)))                ; resets cache
  gf)

(defmethod initialize ((cl <class>) keywords)
  (call-next-method)
  (let ((direct-supers (class-direct-superclasses cl))
        (direct-slotds
         (find-keyword :direct-slots keywords ()))
        (direct-inits
         (find-keyword :direct-keywords keywords ())))
    (unless (compatible-superclasses-p cl direct-supers)
      (error "incompatible superclasses:~%~s can not be a subclass of ~%~s"
             cl direct-supers))
    (setf (class-precedence-list cl)
	  (compute-class-precedence-list cl direct-supers))
    (setf (class-keywords cl)
	  (compute-keywords cl direct-inits
			    (compute-inherited-keywords cl direct-supers)))
    (let* ((inherited-slotds (compute-inherited-slots
			      cl direct-supers))
	   (effective-slotds
	    (compute-and-ensure-slot-accessors
	     cl (compute-slots cl direct-slotds inherited-slotds)
	     inherited-slotds)))
      (setf (class-slots cl) effective-slotds)
      (setf (class-instance-length cl) (length effective-slotds)))
    (mapcar #'(lambda (super)
		(add-subclass super cl)) direct-supers))
  cl)

(defgeneric compatible-superclasses-p ((cl <class>) superclasses))
  
; si
(defmethod compatible-superclasses-p ((cl <class>) superclasses)
  (compatible-superclass-p cl (car superclasses)))

(defgeneric compatible-superclass-p ((cl <class>) (superclass <class>)))

(defmethod compatible-superclass-p ((cl <class>) (super <class>))
  (or (class-abstract-p super)
      (subclass? (class-of cl) (class-of super))))

(defgeneric compute-class-precedence-list ((cl <class>) direct-supers))

; si
(defmethod compute-class-precedence-list ((cl <class>) direct-supers)
  (cons cl (class-precedence-list (car direct-supers))))

(defgeneric compute-inherited-keywords ((cl <class>) direct-supers))

; si
(defmethod compute-inherited-keywords ((cl <class>) direct-supers)
  (declare (ignore cl))
  (list (class-keywords (car direct-supers))))

(defgeneric compute-keywords ((cl <class>) direct-inits inherited-inits))

; si
(defmethod compute-keywords ((cl <class>) direct-inits inherited-inits)
  (declare (ignore cl))
  (remove-duplicates (append direct-inits (car inherited-inits))
                     :test #'eq))

(defgeneric compute-inherited-slots ((cl <class>) direct-supers))

; si
(defmethod compute-inherited-slots ((cl <class>) direct-supers)
  (declare (ignore cl))
  (list (class-slots (car direct-supers))))

(defgeneric compute-slots
  ((cl <class>) slotd-specs inherited-slotds))

; si
(defmethod compute-slots
  ((cl <class>) slotd-specs inherited-slotds)
  (let ((old-sd-names (mapcar #'slot-name (car inherited-slotds)))
        (new-sd-plist (mapcan #'(lambda (spec)
                                  (list (find-keyword :name spec :required)
                                        spec))
                              slotd-specs)))
    (append
     (mapcar #'(lambda (sd)
		 (compute-specialized-slot
		  cl (list sd)
		  (getf new-sd-plist (slot-name sd))))
	     (car inherited-slotds))
     (mapcan #'(lambda (spec)
		 (if (memq (find-keyword :name spec :required) old-sd-names)
		     ()
		     (list (compute-defined-slot
			    cl spec))))
	     slotd-specs))))

(defgeneric compute-specialized-slot ((cl <class>) sds spec))

; si
(defmethod compute-specialized-slot ((cl <class>) sds spec)
  (let* ((sd (car sds))
	 (sdclass (compute-specialized-slot-class cl sds spec)))
    (if (null spec)
	(inherited-slot cl sd sdclass)
	(redefined-slot cl sd sdclass spec))))

; inherited, but not redefined
(defun inherited-slot (cl sd sdclass)
  (declare (ignore cl))
  (if (eq sdclass (class-of sd))
      sd
      (make sdclass			; what of other keywords?
	    :name (slot-name sd)	; this is incomplete
	    :reader (slot-reader sd)
	    :writer (slot-writer sd)
	    :keyword (slot-keyword sd)
	    :default (slot-default sd)
	    :requiredp (slot-required-p sd))))

; inherited and redefined
(defun redefined-slot (cl sd sdclass spec)
  (let* ((reader (find-keyword :reader spec
			   (slot-reader sd)))
	 (writer (find-keyword :writer spec
			   (slot-writer sd)))
	 (initfn (find-keyword :default spec
			   (slot-default sd)))
	 (name (find-keyword :name spec :required))
	 (reqd (find-keyword :requiredp spec (slot-required-p sd)))
	 (keyword (find-keyword :keyword spec
			    (let ((ia (slot-keyword sd)))
			      (cond ((not (unbound? ia)) ia)
				    ((memq name (class-keywords cl)) name)
				    (t unbound))))))
    (apply #'make sdclass
	   :reader reader
	   :writer writer
	   :keyword keyword
	   :default initfn
	   :requiredp reqd
	   (filter-keywords '(:reader :writer :keyword :default) spec))))

(defgeneric compute-specialized-slot-class ((cl <class>) sds spec))

(defmethod compute-specialized-slot-class ((cl <class>) sds spec)
  (declare (ignore cl sds spec))
  <local-slot>)

(defgeneric compute-defined-slot ((cl <class>) spec))

(defmethod compute-defined-slot ((cl <class>) spec)
  (let* ((name (symbol2key (find-keyword :name spec :required)))
	 (keyword (find-keyword :keyword spec
			    (if (memq name (class-keywords cl))
				name
				unbound))))
    (apply #'make
	   (compute-defined-slot-class cl spec)
	   :keyword keyword
	   (filter-keywords '(:keyword) spec))))

(defgeneric compute-defined-slot-class ((cl <class>) spec))

(defmethod compute-defined-slot-class ((cl <class>) spec)
  (declare (ignore cl spec))
  <local-slot>)

(defgeneric copy-object ((obj <object>)))

(defmethod copy-object ((obj <object>))
  (let* ((cl (class-of obj))
         (new (allocate cl ())))
    (mapc #'(lambda (sd)
              (setf (slot-value-using-slot sd new)
                    (slot-value-using-slot sd obj)))
          (class-slots cl))
    new))

(defgeneric compute-and-ensure-slot-accessors
  ((cl <class>) effective-slotds inherited-slotds))

; si
; if inheriting a sd, assume its reader & writer are OK
(defmethod compute-and-ensure-slot-accessors
  ((cl <class>) effective-slotds inherited-slotds)
  (mapc #'(lambda (sd)
            (unless (member (slot-reader sd)
                            (car inherited-slotds)
                            :test #'eq :key #'slot-reader)
              (let ((reader (compute-slot-reader cl sd effective-slotds))
                    (writer (compute-slot-writer cl sd effective-slotds)))
                (setf (slot-reader sd) reader)
                (setf (slot-writer sd) writer)))
            (ensure-slot-reader cl sd effective-slotds
                                (slot-reader sd))
            (ensure-slot-writer cl sd effective-slotds
                                (slot-writer sd)))
        effective-slotds)
  effective-slotds)

(defgeneric compute-slot-reader
  ((cl <class>) (slotd <slot>) effective-slotds))

(defmethod compute-slot-reader
  ((cl <class>) (slotd <slot>) effective-slotds)
  (declare (ignore slotd effective-slotds))
  (generic-lambda ((obj cl))))

; si, accessors are simple functions
(defmethod compute-slot-reader
  ((cl <class>) (slotd <local-slot>) effective-slotds)
  (declare (ignore cl))
  (let ((name (slot-name slotd)))
    (labels ((count (n slots)
	       (if (eq name (slot-name (car slots)))
                   n
                   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
        #'(lambda (obj)
            (primitive-ref obj index))))))

(defgeneric compute-slot-writer
  ((cl <class>) (slotd <slot>) effective-slotds))

(defmethod compute-slot-writer
  ((cl <class>) (slotd <slot>) effective-slotds)
  (declare (ignore slotd effective-slotds))
  (generic-lambda ((obj cl) val)))

; si, accessors are simple functions
(defmethod compute-slot-writer
  ((cl <class>) (slotd <local-slot>) effective-slotds)
  (declare (ignore cl))
  (let ((name (slot-name slotd)))
    (labels ((count (n slots)
               (if (eq name (slot-name (car slots)))
                   n
                   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
        #'(lambda (obj val)
            (setf (primitive-ref obj index) val))))))

(defgeneric ensure-slot-reader
  ((cl <class>) (slotd <slot>) effective-slotds (reader <function>)))

; si nothing to do
(defmethod ensure-slot-reader
  ((cl <class>) (slotd <local-slot>)
   effective-slotds (reader <function>))
  (declare (ignore cl slotd effective-slotds))
  reader)

(defgeneric compute-primitive-reader-using-slot
  ((slotd <slot>) (cl <class>) effective-slotds))

(defmethod compute-primitive-reader-using-slot
  ((slotd <slot>) (cl <class>) effective-slotds)
  (compute-primitive-reader-using-class cl slotd effective-slotds))

(defgeneric compute-primitive-reader-using-class
  ((cl <class>) (slotd <slot>) effective-slotds))

; search on readers rather than names
(defmethod compute-primitive-reader-using-class
  ((cl <class>) (slotd <slot>) effective-slotds)
  (declare (ignore cl))
  (let ((reader (slot-reader slotd)))
    (labels ((count (n slots)
               (if (eq reader (slot-reader (car slots)))
                   n
                   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
        #'(lambda (sd)
            (primitive-ref sd index))))))

(defgeneric ensure-slot-writer
  ((cl <class>) (slotd <slot>) effective-slotds (writer <function>)))

; si nothing to do
(defmethod ensure-slot-writer
  ((cl <class>) (slotd <local-slot>)
   effective-slotds (writer <function>))
  (declare (ignore cl slotd effective-slotds))
  writer)

(defgeneric compute-primitive-writer-using-slot
  ((slotd <slot>) (cl <class>) effective-slotds))

(defmethod compute-primitive-writer-using-slot
  ((slotd <slot>) (cl <class>) effective-slotds)
  (compute-primitive-writer-using-class cl slotd effective-slotds))
  
(defgeneric compute-primitive-writer-using-class
  ((cl <class>) (slotd <slot>) effective-slotds))

; search on reader, rather than slot name
(defmethod compute-primitive-writer-using-class
  ((cl <class>) (slotd <slot>) effective-slotds)
  (declare (ignore cl))
  (let ((reader (slot-reader slotd)))
    (labels ((count (n slots)
               (if (eq reader (slot-reader (car slots)))
                   n
                   (count (+ n 1) (cdr slots)))))
      (let ((index (count 0 effective-slotds)))
        #'(lambda (sd val)
            (setf (primitive-ref sd index) val))))))

(defgeneric add-subclass ((super <class>) (sub <class>)))

; would be nice to have weak pointers here
(defmethod add-subclass ((super <class>) (sub <class>))
  (setf (class-direct-subclasses super)
        (cons sub (class-direct-subclasses super))))

; for debugging
(defgeneric remove-class ((cl <class>)))

; si
; dodgy if cl is a metaclass
(defmethod remove-class ((cl <class>))
  (let ((super (car (class-direct-superclasses cl))))
    (setf (class-direct-subclasses super)
          (remove cl (class-direct-subclasses super) :test #'eq)))
  cl)

(eval-when (compile load eval)

(defun strip-<> (sym)
  (let ((str (symbol-name sym)))
    (if (eql (aref str 0) #\<)
        (intern (string-trim "<>" str) (symbol-package sym))
        sym)))

(defun do-direct-slotds (slots)
  (cond ((null slots) ())
        ((atom (car slots))
         (cons `(list :name ',(car slots))
               (do-direct-slotds (cdr slots))))
	(t (let ((initf (find-keyword :default (cdar slots) absent))
		 (inita (find-keyword :keyword (cdar slots) absent)))
	     (cons `(list :name ',(caar slots)
			  ,@(if (absent? initf)
                                ()
                                `(:default #'(lambda () ,initf)))
			  ,@(if (absent? inita)
				()
				`(:keyword ,(symbol2key inita)))
			  ,@(filter-keywords '(:default :accessor
					       :keyword :reader :writer)
					     (cdar slots)))
		   (do-direct-slotds (cdr slots)))))))

(defun find-slot-keywords (slots)
  (mapcan #'(lambda (s)
	      (if (atom s)
		  ()
		  (let ((init (find-keyword :keyword (cdr s) absent)))
		    (if (absent? init)
			()
			(list (symbol2key init))))))
	  slots))

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
  `((defvar ,acc () ,(format () "The ~s-~s slot reader" name slotname))
    (proclaim '(function ,acc (t) t))
    (let ((sdsr (slot-reader
                 (find-slot ,name ',slotname))))
      (setq ,acc sdsr)
      (setf (symbol-function ',acc)
            (if (generic-function? sdsr)
                (generic-function-discriminating-function sdsr)
                sdsr)))))

(defun do-writer (setter name slotname)
  `((defvar ,setter () ,(format () "The ~s-~s slot writer" name slotname))
    (proclaim '(function ,setter (t t) t))
    (let ((sdsw (slot-writer
                 (find-slot ,name ',slotname))))
      (setq ,setter sdsw)
      (setf (symbol-function ',setter)
            (if (generic-function? sdsw)
                (generic-function-discriminating-function sdsw)
                sdsw)))))

(defun do-predicates (name keywords)
  (cond ((null keywords) ())
        ((eq (car keywords) :predicate)
         (let ((pred (cadr keywords)))
           (append `((defgeneric ,pred ((obj <object>))
                       :method (((obj <object>)) ())
                       :method (((obj ,name)) t)))
                   (do-predicates name (cddr keywords)))))
        (t (do-predicates name (cddr keywords)))))

(defun do-constructors (name keywords)
  (cond ((null keywords) ())
        ((eq (car keywords) :constructor)
         (let ((con (cadr keywords)))
           (cons (if (atom con)
                     `(defun ,con (&rest inits)
                        (apply #'make ,name inits))
                     `(defun ,(car con) ,(cdr con)
                        (make ,name
                              ,@(mapcan #'(lambda (init)
                                            (list (symbol2key init)
                                                  init))
                                        (cdr con)))))
                 (do-constructors name (cddr keywords)))))
        (t (do-constructors name (cddr keywords)))))

(defun do-printfn (name keywords)
  (let ((pfn (find-keyword :print-function keywords absent)))
    (cond ((absent? pfn) ())
	  ((symbolp pfn)
	   `((defmethod generic-prin ((obj ,name) str)
	       (,pfn obj str))))
	  (t
	   `((defmethod generic-prin ((obj ,name) str)
	       (funcall ,pfn obj str)))))))

) ; end of eval-when

(defmacro defclass (name supers slots . keywords)
"Syntax: (defclass name (supers) (slots) {keywords}*), where
name is a symbol,
supers is {class}*,
slots is {symbol | (symbol {slot-keywords}*)}, and
keywords and slot-keywords are {key val}. Allowable keywords include
:class               the class of the class begin defined
:keywords            a list of the allowable keywords for this class
:predicate           a predicate function for this class
:constructor         a constructor function for this class
:print-function      a function (object stream) to be added as a method
                     to generic-prin to print an instance
The :predicate and :constructor keywords can be repeated.
Allowable slot-keywords include
:reader              a symbol to name a reader for this slot
:writer              a symbol to name a writer for this slot
:accessor            a symbol to name a reader for this slot; a writer
                     for this slot will be installed as the setf of the
                     reader
:keyword             a symbol to be the keyword for the slot
:default             an initial value for the slot
The :reader, :writer, and :accessor keywords can be repeated."
  (let ((real-name (strip-<> name)))
    `(progn
       (defvar ,name ()
         ,(find-keyword :documentation keywords
                    (format () "The Telos class ~s" real-name)))
       (when (and (boundp ',name)                ; for debugging
                  (class? ,name))
         (remove-class ,name))
       (setq ,name
             (make ,(find-keyword :class keywords '<simple-class>)
                   :name ',real-name
                   :direct-superclasses
                   (list ,@(if (null supers) '(<object>) supers))
                   :direct-slots (list ,@(do-direct-slotds slots))
                   :direct-keywords
                   ',(append 
		      (mapcar #'symbol2key (find-keyword
					    :keywords keywords ()))
		      (find-slot-keywords slots))
                   ,@(filter-keywords '(:keywords :predicate
					:class :constructor
					:print-function
					:documentation) keywords)))
       ,@(do-accessors name slots)
       ,@(do-predicates name keywords)
       ,@(do-constructors name keywords)
       ,@(do-printfn name keywords)
     ',name)))

#-telos-debug (progn

(defun primitive-print (obj str xx)
  (declare (ignore xx))
  (generic-prin obj str))

(defgeneric generic-prin ((obj <object>) str))

(defmethod generic-prin ((obj <object>) str)
  (let ((*print-case* :downcase)
        (sds (class-slots (class-of obj))))
    (format str "#object(")
    (when sds
      (mapc #'(lambda (sd)
                (let ((val (slot-value-using-slot sd obj)))
                  (format str "~a ~a " (slot-name sd)
                          (if (unbound? val)
                              "<unbound>"
                              val))))
            sds))
    (format str "[~a])" (class-name (class-of obj)))))

(defmethod generic-prin ((obj <class>) str)
  (let ((*print-case* :downcase))
    (format str "#class(~a [~a])"
            (class-name obj)
            (class-name (class-of obj)))))

(defmethod generic-prin ((obj <slot>) str)
  (let ((*print-case* :downcase))
    (format str "#slot([~a])"
            (class-name (class-of obj)))))

(defmethod generic-prin ((obj <local-slot>) str)
  (let ((*print-case* :downcase)
	(name (slot-name obj))
	(class (class-name (class-of obj))))
    (format str "#slot(~a [~a])" name class)))

(defmethod generic-prin ((obj <generic-function>) str)
  (let ((*print-case* :downcase)
        (name (generic-function-name obj)))
    (format str "#gfun~a"
      (let ((args (mapcar #'(lambda (cl)
			      (cond ((class? cl) (class-name cl))
				    ((null cl) '*)
				    (t :???)))
			  (generic-function-domain obj))))
	(when (generic-function-rest obj)
	  (setf (cdr (last args)) 'object))
	(cons (if (unbound? name) :??? name) args)))))

(defmethod generic-prin ((obj <method>) str)
  (let ((*print-case* :downcase))
    (format str "#method~a"
            (let ((gf (method-generic-function obj)))
              (cons (if (generic-function? gf)
                        (generic-function-name gf)
                        :unattached)
                    (mapcar #'(lambda (cl)
                              (cond ((class? cl) (class-name cl))
                                    ((null cl) '*)
                                    (t :???)))
                            (method-domain obj)))))))

(defmethod generic-prin ((obj <built-in-object>) str)
  (princ obj str))

) ; end of telos-debug

(defmethod allocate ((cl <built-in-class>) inits)
  (declare (ignore inits))
  (error "can't allocate a built-in class: ~s" (class-name cl)))

;----------------------------------------------------------------------

(defun class-hierarchy (&optional (slots? ()))
  (do-class-hierarchy (list <object>) 0 slots?)
  t)

(defun do-class-hierarchy (objlist depth slots?)
    (print-indent (car objlist) depth)
    (when slots?
      (when (class-slots (car objlist))
        (prin-indent "slots: " depth)
        (princ (class-slots-names (car objlist)))
        (fresh-line))
      (when (class-keywords (car objlist))
        (prin-indent "keywords: " depth)
        (princ (class-keywords (car objlist)))
        (fresh-line)))
    (when (class-direct-subclasses (car objlist))
      (do-class-hierarchy (class-direct-subclasses (car objlist))
                          (+ depth 4) slots?))
    (when (cdr objlist)
      (do-class-hierarchy (cdr objlist) depth slots?)))

(defun class-slots-names (cl)
  (mapcar #'slot-name
          (class-slots cl)))

(defun print-indent (obj depth)
    (prin-indent obj depth)
    (fresh-line))

(defun prin-indent (obj depth)
  (princ (make-string depth :initial-element #\space))
  (princ obj))

;------------------------------------------------------------------------------

(defvar *line-length* 60)

(defgeneric telos-describe ((obj <object>)))

(defmethod telos-describe ((obj <built-in-object>))
  (call-next-method)
#-WCL
  (lisp:describe obj))

(defmethod telos-describe ((obj <object>))
  (let ((str1 (format () "~%~s is an instance of " obj))
        (str2 (format () "~s~%" (class-of obj))))
    (princ str1)
    (when (> (+ (length str1) (length str2)) *line-length*) (terpri))
    (princ str2))
  (let ((sds (class-slots (class-of obj))))
    (unless (null sds)
      (let ((*print-case* :downcase))
        (mapc #'(lambda (sd)
                  (let ((val (slot-value-using-slot sd obj)))
                    (format t "~a: ~a~%" (slot-name sd)
                            (if (unbound? val)
                                "<unbound>"
                                val))))
              sds)))))

#-telos-debug (defun describe (x) (telos-describe x) (values))

#+telos-debug (defun describe (x) (lisp:describe x) (values))

(defun list-all-classes ()
  "Returns a list of all existing Telos classes"
  (labels ((collect-subclasses (cl)
	     (if (null (class-direct-subclasses cl))
		 (list cl)
		 (cons cl (mapcan #'collect-subclasses
				  (class-direct-subclasses cl))))))
    (remove-duplicates (collect-subclasses <object>))))

;------------------------------------------------------------------------------

(pushnew :telos *features*)

(let ((*package* (find-package :user)))
  (shadowing-import '(describe
                      #+KCL allocate))
#+PCL (unuse-package :pcl)
  (use-package telos))

#+KCL
(eval-when (load)
  (format t "done.~%"))

#|
(setq si::*notify-gbc* t)
|#
