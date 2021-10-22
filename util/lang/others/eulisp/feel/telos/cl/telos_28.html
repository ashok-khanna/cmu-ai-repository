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

Thoughts for the day:
Allow add-method to call compute-discriminating-function et al, and do
extra optimisation.
Share method-functions amongst compatible methods.
Extend hierarchy to, e.g., standard-generic-function as a subclass of
generic-function, etc., and have these as the standard system classes.  Then
we can optimize system classes.
  standard-class, standard-method, standard-generic-function,
  standard-local-slot-description(?)
Lazy finalization of classes and gfs.
|#

#+CMU
(defpackage :telos)

(in-package :telos)

#+PCL
(unuse-package :pcl)

(shadow '(describe
          #+CMU memq
          #+KCL allocate))

(export '(generic-funcall primitive-ref primitive-class-of primitive-allocate
          metaclass class abstract-class function-class object generic-function
          method slot-description local-slot-description
          class-of subclass? class? slot-description? function?
          generic-function? method? defgeneric method-function-lambda
          generic-lambda
          method-lambda apply-method-function call-method-function
          defmethod class-name class-instance-length class-direct-superclasses
          class-direct-subclasses class-slot-descriptions class-initargs
          class-precedence-list generic-function-name generic-function-domain
          generic-function-method-class generic-function-method-initargs
          generic-function-methods generic-function-method-lookup-function
          generic-function-discriminating-function generic-function-cache
          method-generic-function method-domain
          method-function slot-description-name slot-description-initfunction
          slot-description-slot-reader slot-description-slot-writer
	  slot-description-slot-initarg
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
          generic-prin common cl-object class-hierarchy
          instance-hierarchy structure-class structure defstructure
          describe standard-function find-key required
          <object>
            <structure>
            <class>
              <structure-class>
              <metaclass>
              <abstract-class>
              <function-class>
              <common>
            <method>
            <slot-description>
              <local-slot-description>
            <cl-object>
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
                <standard-function>
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
              <struct>))
                  
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
(defun unbound () unbound)
(defun unbound? (x) (eq x unbound))

(defun primitive-allocate (cl size)
  "Args: class size
Allocate and return an uninitialized object that has class CLASS,
and which has size SIZE."
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
(defconstant gf-slots '(name domain method-class method-initargs
                        methods method-lookup-function discriminating-function
                        cache))
(defconstant gf-accessors '(generic-function-name generic-function-domain
                            generic-function-method-class
                            generic-function-method-initargs
                            generic-function-methods
                            generic-function-method-lookup-function
                            generic-function-discriminating-function
                            generic-function-cache))
(defconstant gf-initargs '(:name :domain :function :method-class
                           :method-initargs
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
(defconstant %initarg 3)
(defconstant %initfunction 4)
(defconstant lsd-slots (append sd-slots '(name initarg initfunction)))
(defconstant lsd-accessors (append sd-accessors
                              '(slot-description-name
				slot-description-initarg
                                slot-description-initfunction)))
(defconstant lsd-initargs (append sd-initargs '(:name :initarg :initfunction)))
(defconstant lsd-size (length lsd-slots))

; accessors
(eval-when (compile)
  (proclaim '(inline class-name setter-class-name
                     class-instance-length setter-class-instance-length
                     class-direct-superclasses setter-class-direct-superclasses
                     class-direct-subclasses setter-class-direct-subclasses
                     class-slot-descriptions setter-class-slot-descriptions
                     class-initargs setter-class-initargs
                     class-precedence-list setter-class-precedence-list
                     generic-function-name setter-generic-function-name
                     generic-function-domain setter-generic-function-domain
                     generic-function-method-class
                     setter-generic-function-method-class
                     generic-function-method-initargs
                     setter-generic-function-method-initargs
                     generic-function-methods setter-generic-function-methods
                     generic-function-method-lookup-function
                     setter-generic-function-method-lookup-function
                     generic-function-discriminating-function
                     setter-generic-function-discriminating-function
                     generic-function-cache setter-generic-function-cache
                     method-generic-function setter-method-generic-function
                     method-domain setter-method-domain
                     method-function setter-method-function
                     slot-description-slot-reader
                     setter-slot-description-slot-reader
                     slot-description-slot-writer
                     setter-slot-description-slot-writer
		     slot-description-initarg
		     setter-slot-description-initarg
                     slot-description-name setter-slot-description-name
                     slot-description-initfunction
                     setter-slot-description-initfunction)))                 

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

(defun slot-description-initarg (sd) (primitive-ref sd %initarg))
(defun setter-slot-description-initarg (sd val)
  (setf (primitive-ref sd %initarg) val))
(defsetf slot-description-initarg setter-slot-description-initarg)

(defun slot-description-name (sd) (primitive-ref sd %lsdname))
(defun setter-slot-description-name (sd val)
  (setf (primitive-ref sd %lsdname) val))
(defsetf slot-description-name setter-slot-description-name)

(defun slot-description-initfunction (sd) (primitive-ref sd %initfunction))
(defun setter-slot-description-initfunction (sd val)
  (setf (primitive-ref sd %initfunction) val))
(defsetf slot-description-initfunction setter-slot-description-initfunction)

(defvar <metaclass> (primitive-allocate () class-size)
  "The Telos metaclass METACLASS")

(defvar <class> (primitive-allocate <metaclass> class-size)
  "The Telos metaclass CLASS")

(defvar <abstract-class> (primitive-allocate <metaclass> class-size)
  "The Telos metaclass ABSTRACT-CLASS")

(defvar <function-class> (primitive-allocate <metaclass> class-size)
  "The Telos metaclass FUNCTION-CLASS")

(defvar <object> (primitive-allocate <abstract-class> class-size)
  "The Telos abstract class OBJECT")

(defvar <generic-function> (primitive-allocate <function-class> class-size)
  "The Telos class GENERIC-FUNCTION")

(defvar <method> (primitive-allocate <class> class-size)
  "The Telos class METHOD")

(defvar <slot-description> (primitive-allocate <abstract-class> class-size)
  "The Telos abstract class SLOT-DESCRIPTION")

(defvar <local-slot-description> (primitive-allocate <class> class-size)
  "The Telos class LOCAL-SLOT-DESCRIPTION")

; don't print result
(null (setf (primitive-class-of <metaclass>) <metaclass>))

; CL classes

(defvar <common> (primitive-allocate <metaclass> class-size)
  "The Telos metaclass COMMON")

(defvar <cl-object> (primitive-allocate <abstract-class> class-size)
  "The Telos abstract class CL-OBJECT")

(defvar <struct> (primitive-allocate <abstract-class> class-size)
  "The Telos abstract class STRUCT")

(defmacro memq (a b) `(member ,a ,b :test #'eq))

(defconstant cl-class-table (make-hash-table :test #'eq))

; This will be overwritten later when we get around to defining CL classes.
; Hack due to (type-of ()) -> SYMBOL, not NULL as we might hope.
(defvar <null> () "The Telos class NULL")

; KCL uses conses for lambdas
#+KCL
(defvar <standard-function> () "The Telos class STANDARD FUNCTION")

(defun class-of (obj)
  (cond ((primitive-class-p obj) (primitive-class-of obj))
        ((null obj) <null>)
#+KCL   ((and (consp obj) (functionp obj)) <standard-function>)
        (t (let ((type (type-of obj)))
             (cond ((gethash type cl-class-table))
                   ((consp type)
                    (gethash (car type) cl-class-table))
                   ((symbolp type)
                    (install-new-struct-class type))
                   (t <object>))))))

(defun install-new-struct-class (type)
  (let ((new (make <common>
                   :name type
                   :direct-superclasses (list <struct>))))
    (setf (gethash type cl-class-table) new)
    new))

#|
(defun class-of (obj)
  (cond ((primitive-class-p obj) (primitive-class-of obj))
        ((null obj) <null>)
#+KCL        ((and (consp obj) (functionp obj)) <standard-function>)
        (t (let ((type (type-of obj)))
             (or (gethash type cl-class-table)
                 (when (consp type)
                   (gethash (car type) cl-class-table))
                 <object>)))))
|#

(defvar primitive-metaclasses
  (list <metaclass> <function-class> <abstract-class> <class> <common>))

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

(defun slot-description? (a) (subclass? (class-of a) <slot-description>))

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
  (list <object> <class> <metaclass> <abstract-class> <function-class>
        <generic-function> <method> <slot-description>
        <local-slot-description>))

(defun primitive-generic-prin (obj str)
  (let ((cl (primitive-class-of obj)))
    (cond ((or (memq obj primitive-classes)
               (primitive-metaclass? cl))
           (format str "#class(~s [~s])"
                   (class-name obj)
                   (class-name cl)))
          ((eq cl <local-slot-description>)
           (format str "#slotd(~s)"
                   (slot-description-name obj)))
          ((eq cl <generic-function>)
           (format str "#gfun~s"
                   (cons (generic-function-name obj)
                         (mapcar #'(lambda (o)
                                     (cond ((class? o) (class-name o))
                                           ((null o) '*)
                                           (t unbound)))
                                 (generic-function-domain obj)))))
          ((eq cl <method>)
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
          (t (let ((sds (class-slot-descriptions (class-of obj))))
	       (format str "#object(")
	       (mapc #'(lambda (sd)
			 (if (slot-description? sd)
			     (let ((name (slot-description-name sd)))
			       (if (unbound? name)
				   (format str "~s ~s " :??? :???)
				   (format str "~s ~s "
					   name
					   (primitive-slot-value obj name))))
			     (format str "~s ~s " :??? :???)))
		     sds)
	       (format str "[~s])"
		       (if (class? cl) (class-name cl) :???))))))
  obj)

) ; end of telos-debug

(defun init-class (cl name isize supers subs inits cpl)
  (setf (class-name cl) name)
  (setf (class-instance-length cl) isize)
  (setf (class-direct-superclasses cl) supers)
  (setf (class-direct-subclasses cl) subs)
  (setf (class-slot-descriptions cl) ())
  (setf (class-initargs cl) inits)
  (setf (class-precedence-list cl) (cons cl cpl))
  name)

(init-class <object> 'object object-size ()
            (list <class> <method> <slot-description> <cl-object>)
            () ())
(init-class <class> 'class class-size (list <object>)
            (list <metaclass> <abstract-class> <function-class> <common>)
            class-inits (list <object>))
(init-class <metaclass> 'metaclass class-size (list <class>) () class-inits
            (list <class> <object>))
(init-class <abstract-class> 'abstract-class class-size (list <class>) ()
            class-inits (list <class> <object>))
(init-class <function-class> 'function-class class-size (list <class>) ()
            class-inits (list <class> <object>))
;(init-class <generic-function> 'generic-function gf-size (list <object>) ()
;            gf-initargs (list <object>))
(init-class <method> 'method method-size (list <object>) ()
            method-initargs (list <object>))
(init-class <slot-description> 'slot-description sd-size (list <object>)
            (list <local-slot-description>) sd-initargs (list <object>))
(init-class <local-slot-description> 'local-slot-description lsd-size
            (list <slot-description>) () lsd-initargs
            (list <slot-description> <object>))
(init-class <common> 'common class-size (list <class>) () class-inits
            (list <class> <object>))
(init-class <cl-object> 'cl-object object-size (list <object>)
            (list <struct>) () (list <object>))
(init-class <struct> 'struct object-size (list <cl-object>) ()
            () (list <cl-object> <object>))

; CL classes

(defmacro def-cl-class (name <name> supers cpl)
  `(progn
     (defvar ,<name> () ,(format () "The Telos class ~a" name))
     (setq ,<name> (primitive-allocate <common> class-size))
     (setf (class-name ,<name>) ',name)
     (setf (class-instance-length ,<name>) 0)
     (setf (class-direct-superclasses ,<name>) (list ,@supers))
     (setf (class-direct-subclasses ,<name>) ())
     (setf (class-slot-descriptions ,<name>) ())
     (setf (class-initargs ,<name>) ())
     (mapc #'(lambda (super)
               (setf (class-direct-subclasses super)
                     (cons ,<name> (class-direct-subclasses super))))
           (list ,@supers))
     (setf (class-precedence-list ,<name>)
           (cons ,<name> (append (list ,@cpl) (list <cl-object> <object>))))
     (setf (gethash ',name cl-class-table) ,<name>)
     ',<name>))

(defmacro synonym (a b)
  `(setf (gethash ',a cl-class-table) ,b))

(def-cl-class sequence <sequence> (<cl-object>) ())
(def-cl-class list <list> (<sequence>) (<sequence>))
(def-cl-class cons <cons> (<list>) (<list> <sequence>))
(def-cl-class array <array> (<cl-object>) ())
(synonym simple-array <array>)
(def-cl-class vector <vector> (<sequence> <array>) (<sequence> <array>))
(synonym simple-vector <vector>)
(def-cl-class bit-vector <bit-vector> (<vector>) (<vector> <sequence> <array>))
(synonym simple-bit-vector <bit-vector>)
(def-cl-class string <string> (<vector>) (<vector> <sequence> <array>))
(synonym simple-string <string>)
#+KCL (synonym fat-string <string>)
(def-cl-class symbol <symbol> (<cl-object>) ())
(synonym keyword <symbol>)
(def-cl-class null <null> (<list> <symbol>) (<list> <symbol> <sequence>))
(def-cl-class character <character> (<cl-object>) ())
(synonym string-char <character>)
(synonym standard-char <character>)
;
; Now do generic-function which was delayed from above
(def-cl-class function <function> (<cl-object>) ())
(def-cl-class standard-function <standard-function> (<function>) (<function>))
(synonym function <standard-function>)        ; overwrite
(synonym compiled-function <standard-function>)
;
(init-class <generic-function> 'generic-function gf-size (list <function>) ()
           gf-initargs (list <function> <object>))
(setf (class-direct-subclasses <function>)
      (list <generic-function> <standard-function>))
;
(def-cl-class pathname <pathname> (<cl-object>) ())
(def-cl-class stream <stream> (<cl-object>) ())
(def-cl-class random-state <random-state> (<cl-object>) ())
(def-cl-class hash-table <hash-table> (<cl-object>) ())
(def-cl-class readtable <readtable> (<cl-object>) ())
(def-cl-class package <package> (<cl-object>) ())
(def-cl-class number <number> (<cl-object>) ())
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
         ((eq name (slot-description-name (car slots))) index)
         (t (primitive-find-slot-position cl name (cdr slots) (+ index 1)))))

(defun primitive-slot-value (obj name)
  (let ((cl (class-of obj)))
    (primitive-ref obj (primitive-find-slot-position
                        cl name
                        (class-slot-descriptions cl) 0))))
(defun setter-primitive-slot-value (obj name val)
  (let ((cl (class-of obj)))
    (setf (primitive-ref obj
           (primitive-find-slot-position
            cl name
            (class-slot-descriptions cl) 0))
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

(defvar required (list 'required))
(defvar absent (list 'absent))
(defun absent? (x) (eq x absent))

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
  (cond        ((atom domain) ())
        ((eq (car domain) '&rest) ())
        (t (cons (car domain)
                 (required-args (cdr domain))))))

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
(defmacro defgeneric (gfname arglist . initargs)
"Syntax: (defgeneric gfname (arglist) {initarg}*), where
gfname is {symbol | (setf symbol)},
arglist is {{symbol | (symbol class)}+ [ { . | &rest} symbol ]}, and
initarg is {key val}. Allowable initargs include
:class                   the class of the generic function
:method-class            the class of the associated methods
:method-initargs         a list of {key val} initargs to be passed to
                         calls of defmethod on this gfname
:method                  a method to be attached to the generic function
The :method initarg can be repeated."
  (let* ((gf-class (find-key :class initargs '<generic-function>))
         (method-class (find-key :method-class initargs '<method>))
         (method-inits (find-key :method-initargs initargs ()))
         (reqd (required-args arglist))
         (domain (mapcar #'(lambda (a) (if (atom a) () (cadr a)))
                         reqd))
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
                    (list ,@method-inits)
                    (list 
                     ,@(filter-initargs
                        initargs
                        '(:class :method-class :method :name
                          :method-initargs :documentation)))))
       ,(proclaim-gf name arglist)
       (setf (symbol-function ',name)
             (generic-function-discriminating-function ,name))
       ,@(do-defgeneric-methods name initargs)
       ,@(if (eq name gfname) () `((defsetf ,(cadr gfname) ,name)))
       ',name)))

(defmacro generic-lambda (arglist . initargs)
"Syntax: (generic-lambda (arglist) {initarg}*).
See defgeneric for details."
  (let* ((gf-class (find-key :class initargs '<generic-function>))
         (method-class (find-key :method-class initargs '<method>))
	 (method-inits (find-key :method-initargs initargs ()))
	 (name (find-key :name initargs :anonymous))
         (reqd (required-args arglist))
         (domain (mapcar #'(lambda (a) (if (atom a) () (cadr a)))
                         reqd))
         (gl (gensym "GENERIC-LAMBDA")))
    `(let ((,gl
            (make-generic-function
             ',name
             (list ,@domain)
             ,gf-class
             ,method-class
             (list ,@method-inits)
             (list 
              ,@(filter-initargs
                 initargs
                 '(:class :method-class :method :name
                          :method-initargs :documentation))))))
       ,@(do-defgeneric-methods gl initargs)
       ,gl)))

(defun make-generic-function
  (name domain gf-class method-class method-inits initargs)
  (if (and (eq gf-class <generic-function>)
           (eq method-class <method>)
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
  (when (every #'null domain)
    (error "initialize of generic function with no discriminators: ~a"
           name))
  (let ((gf (primitive-allocate <generic-function> gf-size)))
    (setf (generic-function-name gf) name)
    (setf (generic-function-domain gf) domain)
    (setf (generic-function-method-class gf) <method>)
    (setf (generic-function-method-initargs gf) ())
    (setf (generic-function-methods gf) ())
    (setf (generic-function-cache gf) (new-cache))
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
              (error "no applicable methods ~s:~%arguments:~%~s~%classes:~%~s"
                     gf
                     values
                     (mapcar #'class-of values))
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

; assume equal length
(defun sig-applicable? (m1 m2)
  (cond ((null m1) t)
        ((or (null (car m2))                ; non-discriminating arg
             (cpl-subclass? (car m1) (car m2)))
         (sig-applicable? (cdr m1) (cdr m2)))
        (t ())))

; assume equal length
(defun sig<= (sig1 sig2 cpls)
  (cond ((null sig1) t)
        ((eq (car sig1) (car sig2))        ; also case of non-discriminating arg
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
  (let* ((initargs (defmethod-initargs form))
         (sig (defmethod-sig form))
         (body (defmethod-body form))
         (inits (filter-initargs initargs '(:class)))
         (method-class (find-key :class initargs absent))
         (args (defmethod-args sig))
         (domain (defmethod-domain sig)))
    `(make-method ,(if (absent? method-class)
                       '<method>
                       method-class)
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
; (defmethod foo :method-initarg 23 ... ((a <integer>)...) ...)
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
         (method-class (find-key :class initargs absent))
         (args (defmethod-args sig))
         (domain (defmethod-domain sig))
         (gfn (get-gf-name gfun)))
    `(stable-add-method
      ,gfn
      (make-method ,(if (absent? method-class)
                        `(generic-function-method-class ,gfn)
                        method-class)
                   (list ,@domain)
                   (named-method-function-lambda ,gfn ,args ,@body)
                   (append
                    (list ,@inits)
                    (generic-function-method-initargs ,gfn))))))

; problems with KCL not expanding macros and compiling lambdas at compiletime
#+KCL (defvar kcl-bug () "Bug in KCL")

#+KCL
(defmacro defmethod (gfun . form)
  "Syntax: (defmethod gfname {key val}* (arglist) {form}*), where
gfname is {symbol | (setf symbol)}, and arglist is
{{symbol | (symbol class)}+ [ . symbol ]}"
  (let* ((initargs (defmethod-initargs form))
         (sig (defmethod-sig form))
         (body (defmethod-body form))
         (inits (filter-initargs initargs '(:class)))
         (method-class (find-key :class initargs absent))
         (args (defmethod-args sig))
         (domain (defmethod-domain sig))
         (gfn (get-gf-name gfun)))
    `(progn
       (setq kcl-bug #'(lambda (*method-list* *argument-list* ,@args)
			 ,@(block-body gfn body)))
       (stable-add-method
        ,gfn
        (make-method ,(if (absent? method-class)
                          `(generic-function-method-class ,gfn)
                          method-class)
                     (list ,@domain)
                     kcl-bug
                     (append
                      (list ,@inits)
                      (generic-function-method-initargs ,gfn)))))))

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
  (if (and (eq (class-of gf) <generic-function>)
           (eq (class-of md) <method>))
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
  (if (and (eq (class-of gf) <generic-function>)
           (listp domain))
      (primitive-find-method gf domain)
      (find-method gf domain)))

; cf find-method
(defun primitive-find-method (gf sig)
  (find sig (generic-function-methods gf)
        :test #'equal
        :key #'method-domain))

(defun stable-remove-method (gf md)
  (if (and (eq (class-of gf) <generic-function>)
           (eq (class-of md) <method>))
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
  (if (and (eq method-class <method>)
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
  (when (every #' null domain)
    (error "initialization of method with no discriminators"))
  (let ((md (primitive-allocate <method> method-size)))
    (setf (method-domain md) domain)
    (setf (method-function md) fn)
    md))

(defun primitive-make-slot-description (name index cl)
  (let ((sd (primitive-allocate <local-slot-description> lsd-size)))
    (setf (slot-description-name sd) name)
    (setf (slot-description-initarg sd) (symbol2key name))
    (let ((reader (generic-lambda ((obj cl))
		    :method (((obj cl)) (primitive-ref obj index))))
	  (writer (generic-lambda ((obj cl) val)
		    :method (((obj cl) val)
			     (setf (primitive-ref obj index) val)))))
      (setf (generic-function-name reader)
	    (construct-name "~a-~a" (class-name cl) name))
      (setf (generic-function-name writer)
	    (construct-name "SETTER-~a-~a" (class-name cl) name))
      (setf (slot-description-slot-reader sd) reader)
      (setf (slot-description-slot-writer sd) writer))
    sd))

(defun make-slotds (names index cl)
  (if (null names)
      ()
      (cons (primitive-make-slot-description (car names) index cl)
            (make-slotds (cdr names) (+ index 1) cl))))

(let ((class-slotds (make-slotds class-slots 0 <class>)))
  (setf (class-slot-descriptions <class>) class-slotds)
  (setf (class-slot-descriptions <metaclass>) class-slotds)
  (setf (class-slot-descriptions <abstract-class>) class-slotds)
  (setf (class-slot-descriptions <function-class>) class-slotds)
  (setf (class-slot-descriptions <common>) class-slotds))

(setf (class-slot-descriptions <generic-function>)
      (make-slotds gf-slots 0 <generic-function>))

(setf (class-slot-descriptions <method>)
      (make-slotds method-slots 0 <method>))

(let ((sd-slotds (make-slotds lsd-slots 0 <slot-description>)))
  (setf (class-slot-descriptions <slot-description>)
        (list (car sd-slotds) (cadr sd-slotds)))
  (setf (class-slot-descriptions <local-slot-description>) sd-slotds))

; more useful accessors
(defgeneric slot-value-using-slot-description ((sd <slot-description>) obj)
  :method (((sd <slot-description>) obj)
           (generic-funcall (slot-description-slot-reader sd) obj)))

(defgeneric (setf slot-value-using-slot-description)
  ((sd <slot-description>) obj val)
  :method (((sd <slot-description>) obj val)
           (generic-funcall (slot-description-slot-writer sd) obj val)))

(eval-when (compile)
  (defsetf slot-value-using-slot-description
    setter-slot-value-using-slot-description))

(defgeneric find-slot-description ((cl <class>) (symb <symbol>)))

(defmethod find-slot-description ((cl <class>) (symb <symbol>))
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

(defun function? (a) (subclass? (class-of a) <function>))

;;;--------------------------------------------------------------------
;;;
;;; the MOP proper starts here
;;;
(defun make (cl &rest initargs)
  (initialize (allocate cl initargs) initargs))

(defgeneric allocate ((cl <class>) inits))

(defmethod allocate ((cl <abstract-class>) inits)
  (declare (ignore inits))
  (error "can't allocate an instance of an abstract-class ~s" cl))

(defmethod allocate ((cl <class>) inits)
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

(defgeneric initialize ((obj <object>) initargs))

(defmethod initialize ((obj <object>) initargs)
  (let ((cl (class-of obj)))
    (check-legal-initargs cl initargs)
    (mapc #'(lambda (sd)
              (initialize-using-slot-description obj sd initargs))
          (class-slot-descriptions cl)))
  obj)

(defgeneric initialize-using-slot-description
  ((obj <object>) (sd <slot-description>) initargs))

(defmethod initialize-using-slot-description
  ((obj <object>) (sd <local-slot-description>) initargs)
  (let ((initarg (slot-description-initarg sd))
	(initfn (slot-description-initfunction sd)))
    (setf (slot-value-using-slot-description sd obj)
	  (if (unbound? initarg)
	      (if (function? initfn)
		  (generic-funcall initfn)
		  unbound)
	      (let ((val (find-key initarg initargs absent)))
		(if (absent? val)
		    (if (function? initfn)
			(generic-funcall initfn)
			unbound)
		    val)))))
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

(defmethod initialize ((gf <generic-function>) initargs)
  (let ((name (find-key :name initargs :anonymous))
        (domain (find-key :domain initargs required))
        (method-class (find-key :method-class initargs <method>))
        (method-inits (find-key :method-initargs initargs ()))
        (methods (find-key :methods initargs ())))
    (when (every #'null domain)
      (error "initialize of generic function with no discriminators: ~a"
             name))
    (call-next-method)
    (setf (generic-function-name gf) name)
    (setf (generic-function-method-class gf) method-class)
    (setf (generic-function-method-initargs gf) method-inits)
    (setf (generic-function-methods gf) ())
    (setf (generic-function-cache gf) (new-cache))
    (mapc #'(lambda (md) (add-method gf md)) methods)
    (finalize-generic gf))
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
              (error
               "no applicable methods ~s:~%arguments:~%~s~%classes:~%~s"
               gf
               values
               (mapcar #'class-of values))
              (apply (car applicable)        ; apply-method
                     (cdr applicable)
                     values
                     values))))))

(defmethod initialize ((md <method>) initargs)
  (let ((domain (find-key :domain initargs required))
        (fn (find-key :function initargs required))
        (gf (find-key :generic-function initargs absent)))
    (declare (ignore fn))
    (when (every #'null domain)
      (error "initialization of method with no discriminators"))
    (call-next-method)
    (unless (absent? gf)
      (add-method gf md)) ; make sure the gf knows what's up
    md))

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

(defmethod initialize ((sd <local-slot-description>) initargs)
  (declare (ignore sd))
  (find-key :name initargs required)
  (call-next-method))

(defmethod initialize ((cl <class>) initargs)
  (let ((name
         (find-key :name initargs :anonymous))
        (direct-supers
         (find-key :direct-superclasses initargs (list <object>)))
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
    (setf (class-precedence-list cl)
	  (compute-class-precedence-list cl direct-supers))
    (setf (class-initargs cl)
	  (compute-initargs cl direct-inits
			    (compute-inherited-initargs cl direct-supers)))
    (let* ((inherited-slotds (compute-inherited-slot-descriptions
			      cl direct-supers))
	   (effective-slotds
	    (compute-and-ensure-slot-accessors
	     cl (compute-slot-descriptions cl direct-slotds inherited-slotds)
	     inherited-slotds)))
      (setf (class-slot-descriptions cl) effective-slotds)
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
  (if (eq super <metaclass>)
      ()
      (subclass? (class-of cl) (class-of super))))

(defmethod compatible-superclass-p ((cl <class>) (super <abstract-class>))
  (declare (ignore cl super))
  t)

; patchy here
(defmethod compatible-superclass-p ((cl <abstract-class>) (super <class>))
  (declare (ignore cl super))
  ())

; patchy here
(defmethod compatible-superclass-p
  ((cl <abstract-class>) (super <abstract-class>))
  (declare (ignore cl super))
  t)

(defgeneric compute-class-precedence-list ((cl <class>) direct-supers))

; si
(defmethod compute-class-precedence-list ((cl <class>) direct-supers)
  (cons cl (class-precedence-list (car direct-supers))))

(defgeneric compute-inherited-initargs ((cl <class>) direct-supers))

; si
(defmethod compute-inherited-initargs ((cl <class>) direct-supers)
  (declare (ignore cl))
  (list (class-initargs (car direct-supers))))

(defgeneric compute-initargs ((cl <class>) direct-inits inherited-inits))

; si
(defmethod compute-initargs ((cl <class>) direct-inits inherited-inits)
  (declare (ignore cl))
  (remove-duplicates (append direct-inits (car inherited-inits))
                     :test #'eq))

(defgeneric compute-inherited-slot-descriptions ((cl <class>) direct-supers))

; si
(defmethod compute-inherited-slot-descriptions ((cl <class>) direct-supers)
  (declare (ignore cl))
  (list (class-slot-descriptions (car direct-supers))))

(defgeneric compute-slot-descriptions
  ((cl <class>) slotd-specs inherited-slotds))

; si
(defmethod compute-slot-descriptions
  ((cl <class>) slotd-specs inherited-slotds)
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

(defgeneric compute-specialized-slot-description ((cl <class>) sds spec))

; si
(defmethod compute-specialized-slot-description ((cl <class>) sds spec)
  (let* ((sd (car sds))
	 (sdclass (compute-specialized-slot-description-class cl sds spec)))
    (if (null spec)
	(inherited-slot-description cl sd sdclass)
	(redefined-slot-description cl sd sdclass spec))))

; inherited, but not redefined
(defun inherited-slot-description (cl sd sdclass)
  (declare (ignore cl))
  (if (eq sdclass (class-of sd))
      sd
      (make sdclass		; what of other initargs?
	    :name (slot-description-name sd)
	    :reader (slot-description-slot-reader sd)
	    :writer (slot-description-slot-writer sd)
	    :initarg (slot-description-initarg sd)
	    :initfunction (slot-description-initfunction sd))))

; inherited and redefined
(defun redefined-slot-description (cl sd sdclass spec)
  (let* ((reader (find-key :reader spec
			   (slot-description-slot-reader sd)))
	 (writer (find-key :writer spec
			   (slot-description-slot-writer sd)))
	 (initfn (find-key :initfunction spec
			   (slot-description-initfunction sd)))
	 (name (find-key :name spec required))
	 (initarg (find-key :initarg spec
			    (let ((ia (slot-description-initarg sd)))
			      (cond ((not (unbound? ia)) ia)
				    ((memq name (class-initargs cl)) name)
				    (t unbound))))))
    (apply #'make sdclass
	   :reader reader
	   :writer writer
	   :initarg initarg
	   :initfunction initfn
	   (filter-initargs spec '(:reader :writer
				   :initarg :initfunction)))))

(defgeneric compute-specialized-slot-description-class ((cl <class>) sds spec))

(defmethod compute-specialized-slot-description-class ((cl <class>) sds spec)
  (declare (ignore cl sds spec))
  <local-slot-description>)

(defgeneric compute-defined-slot-description ((cl <class>) spec))

(defmethod compute-defined-slot-description ((cl <class>) spec)
  (let* ((name (symbol2key (find-key :name spec required)))
	 (initarg (find-key :initarg spec
			    (if (memq name (class-initargs cl))
				name
				unbound))))
    (apply #'make
	   (compute-defined-slot-description-class cl spec)
	   :initarg initarg
	   (filter-initargs spec '(:initarg)))))

(defgeneric compute-defined-slot-description-class ((cl <class>) spec))

(defmethod compute-defined-slot-description-class ((cl <class>) spec)
  (declare (ignore cl spec))
  <local-slot-description>)

(defgeneric copy-object ((obj <object>)))

(defmethod copy-object ((obj <object>))
  (let* ((cl (class-of obj))
         (new (allocate cl ())))
    (mapc #'(lambda (sd)
              (setf (slot-value-using-slot-description sd new)
                    (slot-value-using-slot-description sd obj)))
          (class-slot-descriptions cl))
    new))

(defgeneric compute-and-ensure-slot-accessors
  ((cl <class>) effective-slotds inherited-slotds))

; si
; if inheriting a sd, assume its reader & writer are OK
(defmethod compute-and-ensure-slot-accessors
  ((cl <class>) effective-slotds inherited-slotds)
  (mapc #'(lambda (sd)
            (unless (member (slot-description-slot-reader sd)
                            (car inherited-slotds)
                            :test #'eq :key #'slot-description-slot-reader)
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
  ((cl <class>) (slotd <slot-description>) effective-slotds))

(defmethod compute-slot-reader
  ((cl <class>) (slotd <slot-description>) effective-slotds)
  (declare (ignore slotd effective-slotds))
  (generic-lambda ((obj cl))))

(defmethod compute-slot-reader
  ((cl <class>) (slotd <local-slot-description>) effective-slotds)
  (declare (ignore effective-slotds))
  (let ((reader (generic-lambda ((obj cl)))))
    (setf (generic-function-name reader)
	  (construct-name "~a-~a"
                          (class-name cl)
                          (slot-description-name slotd)))
    reader))

(defgeneric compute-slot-writer
  ((cl <class>) (slotd <slot-description>) effective-slotds))

(defmethod compute-slot-writer
  ((cl <class>) (slotd <slot-description>) effective-slotds)
  (declare (ignore slotd effective-slotds))
  (generic-lambda ((obj cl) val)))

(defmethod compute-slot-writer
  ((cl <class>) (slotd <local-slot-description>) effective-slotds)
  (declare (ignore effective-slotds))
  (let ((writer (generic-lambda ((obj cl) val))))
    (setf (generic-function-name writer)
	  (construct-name "SETTER-~a-~a"
                          (class-name cl)
                          (slot-description-name slotd)))
    writer))

(defgeneric ensure-slot-reader
  ((cl <class>) (slotd <slot-description>)
   effective-slotds (reader <generic-function>)))

; if there is a method, assume it's OK
(defmethod ensure-slot-reader
  ((cl <class>) (slotd <slot-description>)
   effective-slotds (reader <generic-function>))
  (when (null (generic-function-methods reader))
    (let ((primitive-reader
           (compute-primitive-reader-using-slot-description
            slotd cl effective-slotds)))
      (add-method reader
                  (method-lambda
                   :class (generic-function-method-class reader)
                   ((obj cl))
                   (funcall primitive-reader obj)))))
  reader)

(defgeneric compute-primitive-reader-using-slot-description
  ((slotd <slot-description>) (cl <class>) effective-slotds))

(defmethod compute-primitive-reader-using-slot-description
  ((slotd <slot-description>) (cl <class>) effective-slotds)
  (compute-primitive-reader-using-class cl slotd effective-slotds))

(defgeneric compute-primitive-reader-using-class
  ((cl <class>) (slotd <slot-description>) effective-slotds))

; search on readers rather than names
(defmethod compute-primitive-reader-using-class
  ((cl <class>) (slotd <slot-description>) effective-slotds)
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
  ((cl <class>) (slotd <slot-description>)
   effective-slotds (writer <generic-function>)))

; if there is a method, assume it's OK
(defmethod ensure-slot-writer
  ((cl <class>) (slotd <slot-description>)
   effective-slotds (writer <generic-function>))
  (when (null (generic-function-methods writer))
    (let ((primitive-writer
           (compute-primitive-writer-using-slot-description
            slotd cl effective-slotds)))
      (add-method writer
                  (method-lambda
                   :class (generic-function-method-class writer)
                   ((obj cl) val)
                   (funcall primitive-writer obj val)))))
  writer)

(defgeneric compute-primitive-writer-using-slot-description
  ((slotd <slot-description>) (cl <class>) effective-slotds))

(defmethod compute-primitive-writer-using-slot-description
  ((slotd <slot-description>) (cl <class>) effective-slotds)
  (compute-primitive-writer-using-class cl slotd effective-slotds))
  
(defgeneric compute-primitive-writer-using-class
  ((cl <class>) (slotd <slot-description>) effective-slotds))

; search on reader, rather than slot name
(defmethod compute-primitive-writer-using-class
  ((cl <class>) (slotd <slot-description>) effective-slotds)
  (declare (ignore cl))
  (let ((reader (slot-description-slot-reader slotd)))
    (labels ((count (n slots)
               (if (eq reader (slot-description-slot-reader (car slots)))
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
	(t (let ((initf (find-key :initform (cdar slots) absent))
		 (inita (find-key :initarg (cdar slots) absent)))
	     (cons `(list :name ',(caar slots)
			  ,@(if (absent? initf)
                                ()
                                `(:initfunction #'(lambda () ,initf)))
			  ,@(if (absent? inita)
				()
				`(:initarg ,(symbol2key inita)))
			  ,@(filter-initargs (cdar slots)
					     '(:initform :accessor
                                               :initarg :reader :writer)))
		   (do-direct-slotds (cdr slots)))))))

(defun find-slot-initargs (slots)
  (mapcan #'(lambda (s)
	      (if (atom s)
		  ()
		  (let ((init (find-key :initarg (cdr s) absent)))
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
    (let ((sdsr (slot-description-slot-reader
                 (find-slot-description ,name ',slotname))))
      (setq ,acc sdsr)
      (setf (symbol-function ',acc)
            (if (generic-function? sdsr)
                (generic-function-discriminating-function sdsr)
                sdsr)))))

(defun do-writer (setter name slotname)
  `((defvar ,setter () ,(format () "The ~s-~s slot writer" name slotname))
    (proclaim '(function ,setter (t t) t))
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
           (append `((defgeneric ,pred ((obj <object>))
                       :method (((obj <object>)) ())
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
  (let ((pfn (find-key :print-function initargs absent)))
    (if (absent? pfn)
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
:initarg             a symbol to be the initarg for the slot
:initform            an initial value for the slot
The :reader, :writer, and :accessor initargs can be repeated."
  (let ((real-name (strip-<> name)))
    `(progn
       (defvar ,name ()
         ,(find-key :documentation initargs
                    (format () "The Telos class ~s" real-name)))
       (when (and (boundp ',name)                ; for debugging
                  (class? ,name))
         (remove-class ,name))
       (setq ,name
             (make ,(find-key :class initargs '<class>)
                   :name ',real-name
                   :direct-superclasses
                   (list ,@(if (null supers) '(<object>) supers))
                   :direct-slot-descriptions (list ,@(do-direct-slotds slots))
                   :direct-initargs
                   ',(append 
		      (mapcar #'symbol2key (find-key :initargs initargs ()))
		      (find-slot-initargs slots))
                   ,@(filter-initargs initargs '(:initargs :predicate
                                                 :class :constructor
                                                 :print-function
                                                 :documentation))))
       ,@(do-accessors name slots)
       ,@(do-predicates name initargs)
       ,@(do-constructors name initargs)
       ,@(do-printfn name initargs)
     ',name)))

#-telos-debug (progn

(defun primitive-print (obj str xx)
  (declare (ignore xx))
  (generic-prin obj str))

(defgeneric generic-prin ((obj <object>) str))

(defmethod generic-prin ((obj <object>) str)
  (let ((*print-case* :downcase)
        (sds (class-slot-descriptions (class-of obj))))
    (format str "#object(")
    (when sds
      (mapc #'(lambda (sd)
                (let ((val (slot-value-using-slot-description sd obj)))
                  (format str "~a ~a " (slot-description-name sd)
                          (if (unbound? val)
                              :<unbound>
                              val))))
            sds))
    (format str "[~a])" (class-name (class-of obj)))))

(defmethod generic-prin ((obj <class>) str)
  (let ((*print-case* :downcase))
    (format str "#class(~a [~a])"
            (class-name obj)
            (class-name (class-of obj)))))

(defmethod generic-prin ((obj <slot-description>) str)
  (let ((*print-case* :downcase))
    (format str "#slotd([~a])"
            (class-name (class-of obj)))))

(defmethod generic-prin ((obj <local-slot-description>) str)
  (let ((*print-case* :downcase)
	(name (slot-description-name obj))
	(reader (slot-description-slot-reader obj))
	(class (class-name (class-of obj))))
    (if (generic-function? reader)
	(format str "#slotd(~a [~a])"
		(generic-function-name reader) class)
	(format str "#slotd(~a [~a])"
		name class))))

(defmethod generic-prin ((obj <generic-function>) str)
  (let ((*print-case* :downcase)
        (name (generic-function-name obj)))
    (format str "#gfun~a"
            (cons (if (unbound? name) :??? name)
                  (mapcar #'(lambda (cl)
                              (cond ((class? cl) (class-name cl))
                                    ((null cl) '*)
                                    (t :???)))
                          (generic-function-domain obj))))))

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

(defmethod generic-prin ((obj <cl-object>) str)
  (princ obj str))

) ; end of telos-debug

(defmethod allocate ((cl <common>) inits)
  (declare (ignore inits))
  (error "can't allocate a CL class: ~s" (class-name cl)))

;----------------------------------------------------------------------

(defun class-hierarchy (&optional (slots? ()))
  (do-class-hierarchy (list <object>) 0 slots?)
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
    (do-instance-hierarchy <metaclass>
                           (remove <metaclass> classes)
                           0)
    (length classes)))

(defun collect-all-classes ()
  (remove-duplicates (collect-all-classes-aux <object>)
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
  (remove-if #'(lambda (inst)
                 (not (direct-instance? inst cl)))
             classes))

(defun do-instance-hierarchy (cl classes depth)
  (let ((instances (class-direct-instances cl classes)))
    (print-indent cl depth)
    (mapc #'(lambda (inst)
              (do-instance-hierarchy inst classes (+ depth 4)))
          instances)))

;------------------------------------------------------------------------------

#-telos-debug (progn

(defclass <structure-class> (<class>)
  ()
  :class <metaclass>)

(defmethod compute-and-ensure-slot-accessors
  ((c <structure-class>) effective-slotds inherited-slotds)
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

(defclass <structure> ()
  ()
  :class <structure-class>)

(defmethod initialize ((s <structure>) inits)
  (declare (ignore inits))
  (call-next-method)
  (mapc #'(lambda (sd)
            (when (unbound? (slot-value-using-slot-description sd s))
              (setf (slot-value-using-slot-description sd s) ())))
        (class-slot-descriptions (class-of s)))
  s)

(defmethod generic-prin ((s <structure>) str)
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
    `(defclass ,name (,(if (null super) '<structure> super))
       ,slotinits
       ,@inits
       :initargs ,initargs
       ,@(unless (member :constructor inits)
           `(:constructor ,(construct-name "MAKE-~a" name)))
       ,@(unless (member :predicate inits)
           `(:predicate ,(construct-name "~a-P" name)))
       :class <structure-class>)))

;------------------------------------------------------------------------------

(defvar *line-length* 60)

(defgeneric describe ((obj <object>)))

(defmethod describe ((obj <cl-object>))
  (call-next-method)
#-WCL
  (lisp:describe obj))

(defmethod describe ((obj <object>))
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
                            (if (unbound? val)
                                '<unbound>
                                val))))
              sds))))
  (values))

) ; end of telos-debug

#+telos-debug (defun describe (x) (lisp:describe x))

;------------------------------------------------------------------------------

#-CMU
(eval-when (load)
   (provide :telos))

(push :telos *features*)

(let ((*package* (find-package :user)))
  (shadowing-import '(describe
                      #+KCL allocate))
#+PCL (unuse-package :pcl)
  (use-package telos))

#+KCL
(eval-when (load)
  (format t "done.~%"))
