;;; This file adds the :METHOD capability to DEFGENERIC. It comes from
;;; keim-1.0.tar.z (file ags/prog/pcl-fixes.lisp) a theorem prover.
;;; It is lacking in the May Day, March 92, August 28 92, and 
;;; Sept 16 92 (f) versions of PCL, but appears in July 92 PCL.  

;;; -*- syntax: common-lisp; package: pcl; base: 10; mode: lisp -*-
;;; Here is the copyright notice from PCL:
;;; *************************************************************************
;;; Copyright (c) 1985, 1986, 1987, 1988, 1989, 1990 Xerox Corporation.
;;; All rights reserved.
;;;
;;; Use and copying of this software and preparation of derivative works
;;; based upon this software are permitted.  Any distribution of this
;;; software or derivative works must comply with all applicable United
;;; States export control laws.
;;; 
;;; This software is made available AS IS, and Xerox Corporation makes no
;;; warranty about the software, its performance or its conformity to any
;;; specification.
;;; 
;;; Any person obtaining a copy of this software is requested to send their
;;; name and post office or electronic mail address to:
;;;   CommonLoops Coordinator
;;;   Xerox PARC
;;;   3333 Coyote Hill Rd.
;;;   Palo Alto, CA 94304
;;; (or send Arpanet mail to CommonLoops-Coordinator.pa@Xerox.arpa)
;;;
;;; Suggestions, comments and requests for improvements are also welcome.
;;; *************************************************************************


;;; written by Dan Nesmith
;;; This file adds the ability to use the :method option in defgenerics.
;;; This is lacking in May Day, March 92, and August 28 92 PCL.
;;; as well as Sept 16 92 PCL (f)
;;; It appears, however, to be in July 92 PCL.  
;;; This file is intended to only be loaded when using PCL. (i.e., #+pcl).
;;; "5/1/90  May Day PCL (REV 2)"
;;; "5/1/90  May Day PCL (REV 4b)"
;;; "March 92 PCL (2a)"
;;; "August 28 92 PCL (a)"

(in-package "PCL")
(progn 
  (when (some #'(lambda (x) (search x *pcl-system-date* 
				    :test #'string-equal))
	      (list "March 92" "August 28 92"
		    "September 16 92 PCL (f)" ))
    (export 'class)
   (defun expand-defgeneric (funKE utiliction-specifier lambda-list options)
      (when (listp function-specifier) (do-standard-defsetf-1 (cadr function-specifier)))
      (let ((initargs ())
	    (methods nil))
	(flet ((duplicate-option (name)
		 (error "The option ~S appears more than once." name)))
	  ;;
	  ;; INITARG takes this screwy new argument to get around a bad
	  ;; interaction between lexical macros and setf in the Lucid
	  ;; compiler.
	  ;; 
	  (macrolet ((initarg (key &optional new)
		       (if new
			   `(setf (getf initargs ,key) ,new)
			 `(getf initargs ,key))))
	    (dolist (option options)
	      (ecase (car option)
		(:argument-precedence-order
		 (if (initarg :argument-precedence-order)
		     (duplicate-option :argument-precedence-order)
		   (initarg :argument-precedence-order `',(cdr option))))
		(declare
		 (initarg :declarations
			  (append (cdr option) (initarg :declarations))))
		(:documentation
		 (if (initarg :documentation)
		     (duplicate-option :documentation)
		   (initarg :documentation `',(cadr option))))
		(:method-combination
		 (if (initarg :method-combination)
		     (duplicate-option :method-combination)
		   (initarg :method-combination `',(cdr option))))
		(:generic-function-class
		 (if (initarg :generic-function-class)
		     (duplicate-option :generic-function-class)
		   (initarg :generic-function-class `',(cadr option))))
		(:method-class
		 (if (initarg :method-class)
		     (duplicate-option :method-class)
		   (initarg :method-class `',(cadr option))))
		(:method
		 (push `(defmethod ,function-specifier 
			    ,@(cdr option))
		       methods)	     
					;(error			
					;  "DEFGENERIC doesn't support the :METHOD option yet.")
		 )))
	    (let ((declarations (initarg :declarations)))
	      (when declarations (initarg :declarations `',declarations)))))
	`(prog2
	   (proclaim-defgeneric ',function-specifier ',lambda-list)
	   ,(make-top-level-form `(defgeneric ,function-specifier)
				 *defgeneric-times*
				 `(load-defgeneric ',function-specifier ',lambda-list ,@initargs))
	   ,@(nreverse methods))))
   (compile 'expand-defgeneric))

  (when (search "May Day" *pcl-system-date* :test #'string-equal)
    (defmethod same-specializer-p ((specl1 specializer) (specl2 specializer))
      nil)
    (defmethod same-specializer-p ((specl1 eql-specializer)
				   (specl2 eql-specializer))
      (eq (specializer-object specl1) (specializer-object specl2)))
    (defun expand-defgeneric (function-specifier lambda-list options)
      (when (listp function-specifier) (do-standard-defsetf-1 (cadr function-specifier)))
      (let ((initargs ())
	    (methods nil))
	(flet ((duplicate-option (name)
		 (error "The option ~S appears more than once." name)))
	  ;;
	  ;; INITARG takes this screwy new argument to get around a bad
	  ;; interaction between lexical macros and setf in the Lucid
	  ;; compiler.
	  ;; 
	  (macrolet ((initarg (key &optional new)
		       (if new
			   `(setf (getf initargs ,key) ,new)
			 `(getf initargs ,key))))
	    (dolist (option options)
	      (ecase (car option)
		(:argument-precedence-order
		 (if (initarg :argument-precedence-order)
		     (duplicate-option :argument-precedence-order)
		   (initarg :argument-precedence-order `',(cdr option))))
		(declare
		 (initarg :declarations
			  (append (cdr option) (initarg :declarations))))
		(:documentation
		 (if (initarg :documentation)
		     (duplicate-option :documentation)
		   (initarg :documentation `',(cadr option))))
		(:method-combination
		 (if (initarg :method-combination)
		     (duplicate-option :method-combination)
		   (initarg :method-combination `',(cdr option))))
		(:generic-function-class
		 (if (initarg :generic-function-class)
		     (duplicate-option :generic-function-class)
		   (initarg :generic-function-class `',(cadr option))))
		(:method-class
		 (if (initarg :method-class)
		     (duplicate-option :method-class)
		   (initarg :method-class `',(cadr option))))
		(:method
		 (push `(defmethod ,function-specifier 
			    ,@(cdr option))
		       methods)
					;	      (error
					;		"DEFGENERIC doesn't support the :METHOD option yet.")
		 )))

	    (let ((declarations (initarg :declarations)))
	      (when declarations (initarg :declarations `',declarations)))))
	`(prog1
	   ,(make-top-level-form `(defgeneric ,function-specifier)
				 *defgeneric-times*
				 `(load-defgeneric ',function-specifier ',lambda-list ,@initargs))
	   ,@(nreverse methods))
	))
    (compile 'expand-defgeneric))

  )

