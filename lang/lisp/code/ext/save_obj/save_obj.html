;;; -*- Base: 10; Mode: LISP; Package: (DATABASE :USE LISP); Syntax: Common-Lisp -*-

;;; SAVE-OBJECT, Version 9X.2 (EXPERIMENTAL, patched),
;;; Effective Date: June 1994.
;;; Copyright (C) Kerry V. Koitzsch, 1992,1993,1994.
;;; New work and beautification by Kevin Thompson, NASA Ames Research Center.

#|

The views, opinions, and/or findings contained in this document are those
of the author, and should not be construed as an official position, policy,
or decision of any company or other individual, unless designated by other
documentation.

Permission is granted to any individual or institution to use, copy, 
modify and distribute this document, provided the copyright and permission
notice is maintained, intact, in all copies and supporting documentation.
The author makes no representations about the suitability of the software
described herein for any purpose. It is provided "as is" without express
or implied warranty.

Suggestions, bugs, criticism and questions to kerry@crl.com.

Description of SAVE OBJECT:
----------- -- ---- -------

SAVE-OBJECT is a recursive function which writes an ASCII representation
of a LISP object to a designated file.

NOTE: SAVE-OBJECT doesnt need a special LOAD function! 
You can load files created by SAVE-OBJECT with the
standard LOAD function

To save:

(SAVE-OBJECT (list 10 20 30) "myfile.lisp")    ,

To restore the data in the saved list:

(LOAD "myfile.lisp")

Where the newly restored data ends up:

db:*db-input* == (LIST 10 20 30)

Objects which may be saved include:

--- symbols, keywords, characters, strings, and pathnames.
--- numbers, including integer, rational, complex, and floating point.
--- vectors and multi-dimensional arrays.
--- objects produced by DEFSTRUCT.
--- CLOS (PCL) instances, and CLOS(PCL) classes.
--- hash tables.
--- compiled functions, represented as (FUNCTION <function name>),
    internally.
--- generic functions, method objects, and class objects.
--- conses and lists.
--- circular conses and lists (new)
--- user defined methods may be defined for arbitrary objects, such
    as images.
--- readtables (a kludge for now)
--- CLIM objects (saved as ordinary CLOS instances)

Calling sequence for INSTANCE-DUMP-FORM:
------- -------- --- ------------------

class-slots ==> all-slotnames ==> all-slots-and-values ==>
map-instance ==> get-slot-values ==> get-ordered-slot-values ==>
instance-dump-form.


PLATFORMS:
=========

Tested on:
------ --

Machines: Sun-4,
          Symbolics 3670,
          Mac IIfx and Mac Quadra, Mac Classic II with MCL 2.0.1.

          Allegro\PC Version 1.0 on an IBM-PC with 16 meg, Windows 3.1,
          MSDOS 5.0.

Versions of Symbolics Common Lisp: Genera 8.1, Genera 7.2 w/rev 4b PCL.

Versions of PCL/CLOS: AAAI PCL, Victoria Day PCL, REV 4b PCL, Lucid 4.0
CLOS, Lucid 4.1 CLOS.

Versions of CMU Common Lisp: 16c, SunOS 4.1, Sun 4, and:
                             17b, SunOS 4.1, Sun 4 with PCL Sept. 1992 (f).
            

Versions of MCL: 2.0b3, Version 2.0.1.

Versions of Allegro Common Lisp: 4.0, 4.1, 4.2b.

Note: ALLEGRO 4.0 users (SUNS): the patch which fixes the defstruct slot-
value problem must be installed in your 4.0 image for this code to
work properly! Franz internal problem number: spr4914, patch25.fasl.
See your Franz dealer to get a copy.

Versions of Lucid (Sun) Common Lisp: 4.0, LCL 4.1.


========================= D I R E C T I O N S ============================

(1) Redefine the IN-PACKAGEs below to suit: they should USE CLOS or PCL,
though.

In version 5a, the attribute line should be correct to 'just load' the
file, even if the package database does not exist.
Or, try this:

(make-package 'DATABASE :nicknames '(db) :use '(common-lisp))
(in-package 'database)
(shadowing-import '(setf documentation) 'database)
(use-package 'clos)

If at any point an error occurs about conflicting symbols, select the
proceed option which prefers the symbols in the common lisp package.

(2) After defining an appropriate package, load the file,
    save-object.lisp, or its compiled version.

(3) Enter package DATABASE with (in-package 'DATABASE) or 
(in-package "database"). You are now ready to save objects!

(4) To save an object to a file, invoke the SAVE-OBJECT function:

(in-package 'database) or (in-package "database") if in 8.1.1.

(save-object (list 20 30 19.6) "my-simple-filename.lisp")

to reload the saved-object file:

(load "my-simple-filename.lisp")

The result of the load is stored in the global variable *db-input*,
in the DATABASE package.

(in-package 'db)
*db-input* ====> (20 30 19.6)

(5) To save MULTIPLE OBJECTS to a file, use the macro WITH-SAVED-
OBJECTS:

(with-saved-objects (x "my-multiple-save-file.lisp")
    (make-whiz) ;; a defstruct
    (make-instance 'my-class) ;; a clos/pcl instance...
    PI ;; whatever you want....
    #c(0 1)
)

To re-load a multiple-object data-file, simply use LOAD:

(load "my-multiple-save-file.lisp")

Results end up in the global variable *storage-vector*:

(aref *storage-vector* 0) ====> a whiz instance
                       1  ====> clos pcl instance
                       2   ====> pi
                       3   ====> a complex number...

Since save-object uses vector-push-extend on *storage-vector*,
no allocation or manipulation of *storage-vector* is necessary.

To forget and reset *storage-vector*, simply do

(defvar *storage-vector*) or (mkunbound '*storage-vector*).
=======================================================================
Changes in Version 9X:
=======================================================================

- Fixed definition of CIRCULAR-LIST-P for MCL.

Notes on version 9
===== == ======= =

In MCL 2.0.1, the slot-definition-... access functions remain undefined.
This means some components of the generated DEFCLASS DUMP FORM may be
unpredictable; this will be fixed when MCL has all the appropriate access
functions available.kvk

Changes in Version 9
  (Changes by KOT == Kevin Thompson, kthompso@ptolemy.arc.nasa.gov)
    Tried to make indentation relatively uniform (only top-level forms in
      col 1, and only use 3 ;;;'s if in column 1).  This makes most GNU Emacs
      Lisp modes work better (since begin-of-defun looks for lparen in col 1),
      but makes etags fail ...
    Tried to make it all fit in 80 columns, since 90% of it did already.
    Various fixes for Allegro 4.2 (mostly just change #+)
    Wrapped several top-level (def***) and (setf) forms in eval-when.
      My understanding of CL fails here; but one way or another previously one
      had to load this first to get it to compile in Allegro, and now that's
      unnecessary.
    Many declare's etc, in an anal attempt to remove most compiler warnings.
    Fixed get-defstruct-constructor when defstruct has a :constructor option.
    Other misc bug fixes -- search for 'KOT' below.

=======================================================================
Changes in Version 7:
=======================================================================

1. Support for the newer PCL versions: March, June and August PCLs.

2. Support for CMU Common Lisp.

3. Support for Austin Kyoto Common Lisp.

4. Support for the saving of multiple objects to one file with the
   macro WITH-SAVED-OBJECTS.

5. The ability to save defstruct 'classes' to file, as well as 
   defstruct instances.

6. A complete re-write of defstruct accessors: most of these functions
   are generated automatically by the function CREATE-DEFSTRUCT-ACCESS-
   FUNCTIONS.

7. Support for Symbolics Genera 8.1.1.

8. Improved array and vector functions: added MAP-INTO if needed.

9. The ability to save GENSYMed symbols, circular CONSes, and
    symbol property lists (if the global variable flag is set).
 
10. Numerous bug fixes and documentation changes.

11. Added DOTTED-LIST-P, DOTTED-LIST-DUMP-FORM, modified
    GET-DUMP-FORM, added %EVERY, %SOME:
    changed all occurences of EVERY and SOME to
    %EVERY and %SOME (predicates which dont barf on dotted lists)
    This means (SAVE-OBJECT (LIST* 1 2 3 4 5) "my-dotted-list.lisp")
    should work.

=======================================================================
Changes from Version 4A;
------------------------

--- Attribute line is fixed for Symbolics users.

--- the ability to save CLOS instances with unbound slots: fixed the
    bug where nil was installed as the slot value. (see TEST-UNBOUND-
    SLOT-SAVE function)

--- the ability to save out CONSes (vs LISTS) in the appropriate
    format: required modification to predicate CONS-P and %TYPE-OF.
    (see TEST-CONS-SAVE function)

--- predicate %CONS-P is the internal cons predicate: EXCL uses an
    internal function: the non-EXCL version uses a Common Lisp
    version. Ideally one would use (LAST X 0) as in CLtl2 pg. 416,
    but here i use (CDR (LAST X)).

--- Unsaveable slot bug, which screwed up slots and values returned,
    is now fixed in the new mechanism using INSTANCE-SLOTNAMES.

=======================================================================

 Defstruct functions used by SAVE-OBJECT:
 --------- --------- ---- -- -----------

   STRUCTURE-P (x) [Function] :
   Predicate, returns T if X is a structure instance.

   GET-DEFSTRUCT-LENGTH (s) [Function] :
   Returns the number of slots in a structure instance S.

   GET-DEFSTRUCT-DESCRIPTOR (symbol) [Function] :
   Given a symbol, returns a standard defstruct spec if
   SYMBOL is the name of a defined defstruct class:
   NIL otherwise.

   ALLOCATE-STRUCT (type) [Function] :
   Given a symbol TYPE which is the name of a defined defstruct
   class, make a default instance of that class.

   FILL-STRUCT (struct vals) [Function] :
   Fills the structure instance struct with the values vals.

   GET-DEFSTRUCT-CONSTRUCTOR (s) [Function] :
   Given a symbol or structure instance, return the
   name of the function that can construct an instance 
   of the same type as S.

   GET-DEFSTRUCT-NAME (s) [Function] :
   Given a structure instance S, return the name of
   that instances class.

   GET-DEFSTRUCT-TYPE (s) [Function] :
   Given a symbol or structure instance <s>, return the
   type of that structure class.

   SET-DEFSTRUCT-SLOT-VALUE (s slotname new-value) [Function] :
   Sets the defstruct instance <s> slot named <slotname>
   with the new value <newval>.

   GET-DEFSTRUCT-SLOT-VALUE (s slotname) [Function]:
   Given the defstruct instance <s> and the slot name <slotname>,
   return the value of <slotname> in <s>.

   GET-DEFSTRUCT-SLOT-NAMES (s) [Function] :
   Given a structure instance S, return a list of the
   names of that instances slots, in no particular order.

   COPY-STRUCTURE (s &key (mode :shallow)) [Function] :
   Analogous to the COPY-INSTANCE method. Mode may be :SHALLOW or
   :DEEP : make a copy of the structure instance S.

   GET-DEFSTRUCT-SLOTS-AND-VALS (s) [Function] :

   MAKE-STRUCTURE (struct-type &rest kwd-val-pairs) [Macro] :
   Analogous to MAKE-INSTANCE.

   GET-DEFSTRUCT-VALUES (s) [Function] :
   Return the values of all the slots in structure instance S,
   in the same order that the slot names are returned from
   GET-DEFSTRUCT-SLOT-NAMES.

   GET-DEFSTRUCT-DOCUMENTATION:

   GET-DEFSTRUCT-PREDICATE:

   GET-DEFSTRUCT-PRINT-FUNCTION:

   GET-DEFSTRUCT-INCLUDE:

   GET-DEFSTRUCT-CONC-NAME:


Slot operations:
==== ===========

GET-DEFSTRUCT-SLOT-READ-STATUS (sd) [Function]:

GET-DEFSTRUCT-SLOT-ACCESSOR (sd): [Function]:

GET-DEFSTRUCT-SLOT-NAME (sd) [Function]:

GET-DEFSTRUCT-SLOT-TYPE (sd) [Function]:

GET-DEFSTRUCT-SLOT-READER (sd) [Function]:

GET-DEFSTRUCT-SLOT-WRITER (sd) [Function]:

GET-DEFSTRUCT-SLOT-DESCRIPTOR (sd) [Function]:


NEW MACINTOSH CHANGES:
=== ========= =======

#+:mcl changed to #+mcl. (12-19-93)


|#

;;; Package engineering....

#+akcl
(eval-when (load eval compile)
  (in-package 'DATABASE :nicknames '(DB) :use '(LISP))
  )

#+lucid
(in-package 'DATABASE :nicknames '(DB) :use '(CLOS LISP))

#+mcl
(eval-when (load eval compile)

  (unless (find-package 'database)
    (make-package 'database  :nicknames '(db) :use '(common-lisp)))

  (in-package DATABASE) ;; ANSI definition of IN-PACKAGE

  ;; Uncomment the following line if using mcl....
  ;;(PUSHNEW :mcl *features*)
  (pushnew :clos *features*) ;; MCL has clos, but it isnt in the features list.

  (unless (find-package 'clos)
    (make-package 'clos :use '(ccl common-lisp))) ;;hence no cl package, either

  (when (equal (machine-instance) "Quadra")
    (pushnew :quadra *features*) ;; note that its a 68040 on features....
    )

  (when (equal (machine-type) "Macintosh IIfx")
    (pushnew :fx *features*) ;; note that its an fx on features....
    )
  ) ;; end of MCL eval-when...

#+lispm
(eval-when (load eval compile)
  ;; NEW: added 1.1 to the minor release list below....
  (multiple-value-bind (major minor status)
      (sct:get-release-version)
    (cond ((and (equal major 7)(equal minor "2"))(pushnew :rel-7-2 *features*))
          ((and (equal major 8)(member minor '("0" "1" "1.1") :test #'equal))
           (pushnew :rel8 *features*)
           (if (equal minor "0")(pushnew :rel-8-0 *features*)
             (pushnew :rel-8-1 *features*)))
          (T (error "Can't deal with major release ~a, minor release ~a!" 
                    major minor))))

  (when (find-package 'clos)
    (pushnew :clos *features*))

  (unless (find-package 'database)
    (make-package 'database :nicknames '(db) :use '(clos)))

  (shadowing-import '(setf documentation) 'database)

  (unless (find-package 'clos)
    (format t "Couldnt find the CLOS package, trying to continue.~%"))

  #-rel-8-1(in-package 'database :use '(LISP))
  #+rel-8-1(in-package "database" :use '(LISP))

  (defun UNLOCK-PKG (packagename)
    "Changes read-only package status to read+write, if package exists."
    (when (find-package packagename)
      (setf (si:pkg-locked (find-package packagename)) NIL)))

  ) ;; end of Symbolics eval-when. Worry about TI much later.

;;; Initial package-building eval-when for allegro on suns.

#+excl
(eval-when (load eval compile)

  (setf excl:*cltl1-in-package-compatibility-p* T)

  (in-package :Common-lisp-user)

  (defpackage "database" (:nicknames "dbs") 
    (:use :clos :excl :common-lisp-user))

  (in-package DATABASE)

  (in-package 'DATABASE)

  #+(or allegro-v4.1 allegro-v4.2)
  (defun UNLOCK-pKG (packagename)
    (setf (excl:package-definition-lock (find-package packagename)) nil))

  #+(or allegro-v4.1 allegro-v4.2)
  (unlock-pkg 'common-lisp)

  #|

  #+(or allegro-v4.1 allegro-v4.2)
  (defun UNLOCK-PKG (packagename)
    "Changes read-only package status to read+write, if package exists."
    (when (find-package packagename)
      (setf (excl::package-lock-fdefinitions
             (find-package packagename)) NIL)))

  #+(or allegro-v4.1 allegro-v4.2)
  (unlock-pkg 'common-lisp)
  |#

  ) ;; end of excl eval-when...

;;; Set up correct Lucid hash-table accessors....

#+lucid
(shadowing-import '(lcl::hash-table-rehash-size
                    lcl::hash-table-size
                    lcl::hash-table-test
                    lcl::hash-table-rehash-threshold
                    lcl::ignore-errors
                    ) 'database)

;;; Set up correct ACL\PC hash-table accessors....

#+aclpc

(eval-when (load eval compile)

  (in-package 'DATABASE :nicknames '(DB) :use '(LISP))


  (shadowing-import '(acl::hash-table-rehash-size
                      acl::hash-table-size
                      acl::hash-table-test
                      acl::hash-table-rehash-threshold
                      ) 'database)

  ) ;; end aclpc eval-when...

#+cmu
(eval-when (load eval compile)

  (in-package 'database :nicknames '(db) :use '(PCL LISP))

  (shadowing-import '(common-lisp::hash-table-rehash-size
                      common-lisp::hash-table-rehash-threshold
                      ) 'database)

  (setf (symbol-function 'hash-table-rehash-size)
    #'common-lisp::hash-table-rehash-size)
  (setf (symbol-function 'hash-table-rehash-threshold) 
    #'common-lisp::hash-table-rehash-threshold)
  ) ;; end of cmu evalwhen....

#+lucid
(eval-when (load eval compile)
  (setf (symbol-function 'hash-table-rehash-size)
        #'lcl::hash-table-rehash-size)
  (setf (symbol-function 'hash-table-size) #'lcl::hash-table-size)
  (setf (symbol-function 'hash-table-test) #'lcl::hash-table-test)
  (setf (symbol-function 'hash-table-rehash-threshold) 
    #'lcl::hash-table-rehash-threshold)
  ) ;; end lucid eval-when

;;; NOTE: Change the package def below if it does not suit you:
;;; make sure you USE-PACKAGE your favorite brand of CLOS or PCL, though.

#+lispm
(in-package 'DATABASE :nicknames '(DB) :use '(CLOS LISP))

#+pcl
(in-package 'DATABASE :nicknames '(DB) :use '(PCL LISP))

#+pcl
(eval-when (load eval compile)
  (when (equal pcl::*pcl-system-date* "July 92 PCL (beta)")
    (pushnew :july-pcl *features*))
  (when (equal pcl::*pcl-system-date* "March 92 PCL (3a)")
    (pushnew :march-pcl *features*))
  (when (equal pcl::*pcl-system-date* "Aug 92 PCL (a)")
    (pushnew :aug-pcl *features*))
  (when (equal pcl::*pcl-system-date* "September 16 92 PCL (f)")
    (pushnew :sept-pcl *features*))
  (when (or (member :march-pcl *features*)
            (member :july-pcl *features*)
            (member :aug-pcl *features*)
            (member :sept-pcl *features*))
    (pushnew :new-pcl *features*))
  )

;;; KOT added this, made some directives simpler below.
#+(or allegro-v4.0 allegro-v4.1 allegro-v4.2)
(eval-when (load eval compile)
  (pushnew :allegro-v4 *features*))

;;; KOT first cut, this might not be portable but should work.  See if
;;; function-lambda-expression is defined, and if so can use it below.
(eval-when (load eval compile)
  (let ((apropos (apropos-list "FUNCTION-LAMBDA-EXPRESSION"
                               (find-package :user))))
    (when (some #'fboundp apropos)
      (pushnew :function-lambda-expression *features*))))

#+lucid
(in-package :DATABASE :nicknames '(DB) :use '(LISP))


;;; ========= end of package engineering .... ===========

;;; Tracing defun eval-when follows....

#+ignore
(eval-when (load eval compile)
  
  (shadow '(defun))

(in-package :DATABASE :nicknames '(DB) :use '(LISP))

  (defmacro DEFUN (name &rest args)
    `(eval-when (load eval compile)
       (when (fboundp ',name)
	     (format t "Warning: ~s was already defined!~%" ',name))
       (format t "now compiling: ~a.~%" ',name)
       (lisp:defun ,name ,@args)))

#+ignore
  (defmacro DEFMETHOD (name &rest args)
    `(eval-when (load eval compile)
       (when (fboundp ',name)
	     (format t "Warning: METHOD ~s was already defined!~%" ',name))
       (format t "now compiling method: ~a.~%" ',name)
       (pcl::defmethod ,name ,@args)))


 ) ;; end of tracing defun eval-when.....

;; Exports.

(export '(save-object
          with-saved-objects
          makesyms
          *save-object-system-date*
          *db-input*
          *storage-vector*
          get-slot-values))

;;; Global variables.

(defvar *db-input* nil "where the loaded data file deposits 
the saved object on reload.")

#-akcl ;;; new, AKCL (PCL defclass) doesnt like this one!
(eval-when (load eval compile)
  (setf *print-circle* t)
  )

#+lucid
(defvar *lucid-structure-types*
    '(package  hash-table  defstruct  system::process  
                            lucid:arrayheader  lucid:%pathname  
                            lucid::area  lucid::region  lucid::stack-group
                            lucid::defstruct-slot  lucid::%fs-slot 
                            lucid::%fsft-pointer  lucid::%fsft-structure 
                            lucid::%fsft-field  lucid::%fsft-array 
                            lucid::%fsft-primitive  lucid::%fsft-set  
                            lucid::%fsft-enumerate  lucid::%foreign-type
                            #+LCL4.l lucid::fsft 
        ))

(defvar *storage-list* nil)

;;; KOT wrapped eval-when around this, in Allegro-V4 allows better compilation
(eval-when (load eval compile)
  (defvar *storage-hash-table* (make-hash-table)
    "Used by with-saved-objects : NEW.")
  ) ;; end of eval-when


(defvar *use-file-encoded-format* nil "NEW:")

(defvar *use-symbol-long-form* nil
  "if t, use a make-symbol form instead of quote+letter.")

(defvar *minimum-storage-vector-length* 5
  "default length of *storage-vector*")

(defvar *save-symbol-plist* nil
  "Used in long-symbol-dump-form. if t, the symbols property
 list is saved with the occurrence of the symbol.")



(eval-when (load eval compile)
  ;; KOT -- older version of this had the defvar at top level, and the (if)
  ;; form in the eval-when.  Allegro V4 (at least) bombed on this, saying
  ;; *allow-defstruct-save* didn't yet exist in this case.  This fixes it,
  ;; though I'm not clear why.
  (defvar *allow-defstruct-save* t
    "when t, allow the saving of defstruct 'classes', e.g. the thing
  defined by DEFSTRUCT.")
  (if *allow-defstruct-save* (pushnew :allow-defstruct-save *features*))
  )

(defvar *debug-instance-storage* nil
  "when this one is T, status messages are printed by the CLOS instance saver 
   to aid diagnosis of problems.")

(defvar *debug-local-bindings* nil
  "set this var to t to see a printout of the constructed lexical bindings as 
   they are created.")

(defvar *supress-standard-object* T "")

(defvar *save-contents-of-class-allocated-classes* T
  "This one, if true, includes the slot contents of slots with :allocation 
  :class.")

(defvar *make-list-length-threshold* 10
  "any list longer than this, which has the same element throughout,
  is constructed with MAKE-LIST instead of (list el el el el el el....)."
  )
(defvar *load-object-hash-table* (make-hash-table :size 50 :test #'eql)
  "A hash table which is filled at load time with objects restored from a
   file.")

(defvar *save-object-hash-table* (make-hash-table :size 50 :test #'eql)
  "A hash table which is filled at save time by the invokation of the
  save object function.")

(defvar *mode-for-set-object-var* nil
  "Either :load or :save, depending on the context. Used by SET-OBJECT-VAR.")

(defvar *mode-for-object-var* :save)

(defvar *global-unsaveable-slotnames* nil "")

(defvar *save-object-system-date* 
    "June 1994 Save Object 9 X.2 Experimental (PATCHED).")

(defvar *unbound-slot-token* '%%.us.%)
(defvar *debug-htab-load* t)
(defvar *debug-struct-save* nil)

(defvar *classes-seen* nil)
(defvar *class-vars* nil)

(defvar *seen* nil)
(defvar *vars* nil)
(defvar *structs-seen* nil)
(defvar *struct-vars* nil)
(defvar *htabs-seen* nil)
(defvar *htab-vars* nil)

(defvar *arrays-seen* nil)
(defvar *array-vars* nil)
(defvar *vectors-seen* nil)
(defvar *vector-vars* nil)

(defvar *current-htab-size* 5000)

(defvar *current-htab-rehash-threshold* #-akcl 65
        #+akcl 0.6
        )
(defvar *current-htab-rehash-size* 39)
(defvar *current-htab-test* #'eql)

(defvar *pco-types* '(structure hash-table array-type-t
                      class instance circular-list)
  "A list of the type names returned by function %type-of, that
  are potentially circular objects (PCOs).")

(setf *pco-types* '(structure hash-table array-type-t 
                    class instance circular-list))

#+lucid
(setf lcl::*print-structure* T) ;; "Prints the #S form of a defstruct when t."

(defvar *global-instance-count* 0)

(defvar *global-object-count* 0
  "count of varnames made for object hashtable objects, by makevar in 
   cache-object invokations.")

(defvar *use-default-class-initargs* nil)

(defvar *unsaveable-slot-token* '%.uns.%)

(defvar *unsaveable-slotname-hash-table* (make-hash-table))
;;; Used by WITH-SAVED-OBJECTS to store more than one result...

(defvar *storage-vector*)

(defvar *save-defstruct-includes* nil "")

(defvar *construct-pkg-if-not-found* nil "")

#|

   Vendor Dependent Defstruct Internal Structure Access Control Variables:
   =======================================================================
  Vendor dependent defstruct access info is encoded in the following
  global lists:

  *vendor-set-slot-function*
  *vendor-defstruct-type-function*
  *vendor-defstruct-name-function*
  *vendor-defstruct-descriptor-function*
  *vendor-defstruct-slot-descriptors-function*

  |#

;;;; Vendor dependent defstruct access data.

(defvar *vendor-set-slot-function*)

(setf *vendor-set-slot-function*
  
  #+symbolics  #'(lambda (struct slotname newval)
                   (setf (slot-value struct slotname) newval))
  #+lucid #'(lambda (struct slotname newval)
              (eval `(SETF (,(get-defstruct-slot-accessor struct slotname) 
                            ,struct)
                           ,newval)))
  #+excl #'(lambda (struct slotname newval)
             (setf (slot-value struct slotname) newval))
  #+akcl #'(lambda (struct slotname newval)
             (let ((offset (get-defstruct-slot-offset struct slotname))
                   (type (get-defstruct-type struct)))
               (si:structure-set struct type offset newval)))
  #+cmu #'(lambda (struct slotname newval)
            (let ((offset (%get-defstruct-slot-offset struct slotname)))
              (kernel::structure-set struct offset newval)))
  #+mcl #'(lambda (struct slotname newval)
            (let ((offset (get-defstruct-slot-offset struct slotname)))
              (ccl::struct-set struct offset newval))) ;;; corrected this typo
  #+xerox #'(lambda (struct slotname newval)
              ) 
  #+aclpc #'(lambda (struct slotname newval)
              (eval `(SETF (,(get-defstruct-slot-accessor struct slotname) 
                            ,struct)
                           ,newval)))
  ) 

#+cmu
(defun %GET-DEFSTRUCT-SLOT-OFFSET (struct slotname)
  (let ((sd (get-sd-named struct slotname)))
    (when sd (c::dsd-index sd))))

(defvar *vendor-defstruct-type-function*)

(setf *vendor-defstruct-type-function*
  #+akcl #'(lambda(desc)(si::s-data-type desc))
  #+excl #'(lambda(desc)(slot-value desc 'excl::type))
  #+lucid #'(lambda(desc)(system::structure-ref desc 1 'lucid::defstruct))
  #+lispm #'(lambda(desc)(si:defstruct-description-type desc))
  #+mcl #'(lambda(desc)(car (ccl::struct-ref desc 0)))
  #+cmu #'(lambda(desc)(kernel::structure-ref struct 1))
  #+xerox #'(lambda(desc))
  #+aclpc #'(lambda (desc) (first (aref desc 0)))
  )

(defvar *vendor-defstruct-name-function*)

;;; Added for 9X.

#+lucid
(proclaim '(special lucid::*defstructs*))

(setf *vendor-defstruct-name-function*
  #+akcl #'(lambda(desc)(si::s-data-name desc))
  #+excl #'(lambda(desc)(slot-value desc 'excl::name))
  #+lucid #'(lambda(desc)(system::structure-ref desc 0 'lucid::defstruct))
  #+lispm #'(lambda(desc)(si:defstruct-description-name desc))
  #+mcl #'(lambda(desc)(class-name (class-of desc)))
  #+cmu #'(lambda(desc)(kernel::structure-ref struct 0))
  #+xerox #'(lambda(desc))
  #+aclpc #'(lambda (desc) desc)
  )

(defvar *vendor-defstruct-descriptor-function* nil
  "from symbol name of defstruct get the defstruct descriptor.")

(setf *vendor-defstruct-descriptor-function*
  #+symbolics #'(lambda(name)(si:get name 'si:defstruct-description))
  #+lucid #'(lambda(name)(gethash name lucid::*defstructs*))
  #+excl #'(lambda(name)(get name 'excl::%structure-definition))
  #+akcl #'(lambda (name)(get name 'si::s-data))
  #+old-cmu #'(lambda (name)(ext:info c::type c::defined-structure-info name))
  #+cmu #'(lambda (name)(ext:info c::type c::defined-structure-info name))
  #+mcl #'(lambda (name)(gethash name ccl::%defstructs%))
  #+xerox #'(lambda(name))
  #+aclpc #'(lambda (name)(acl::structure-name-p name))
  )


(defvar *vendor-defstruct-slot-descriptors-function* nil
  "from name of defstruct get list of the defstruct slot descriptors.")

;;; KOT wrapped eval-when around -- think it makes later compilation cleaner
(eval-when (load eval compile)
  (setf *vendor-defstruct-slot-descriptors-function*
    #+symbolics #'(lambda(name)
                    (let ((desc (get-defstruct-descriptor name)))
                     (FOURTH DESC)))
    #+lucid #'(lambda(name)
                (let ((desc (get-defstruct-descriptor name)))
                  (coerce (system:structure-ref desc 7 'lucid::defstruct)
                          'list)))
    #+excl #'(lambda(name)
               (let ((desc (get-defstruct-descriptor name)))
                 (slot-value desc 'excl::slots)))
    #+akcl #'(lambda (name)
               (let ((desc (get-defstruct-descriptor name)))
                 (si::s-data-slot-descriptions desc)))
    #+cmu #'(lambda (name)
              (let ((desc (get-defstruct-descriptor name)))
                (c::dd-slots desc)))
    #+mcl #'(lambda (name)
             (let ((desc (gethash name ccl::%defstructs%)))
(mapcar #'(lambda (cell)(list (first cell)(second cell)))
        (REST (elt desc 1)))))
    #+xerox #'(lambda (name)
                )
    #+aclpc #'(lambda (name)
                (let ((desc (get-defstruct-descriptor name)))
                  (when desc (rest (aref desc 1)))))))


(defvar *vendor-defstruct-predicate-function*)

;;; KOT wrapped eval-when around -- think it makes later compilation cleaner
(eval-when (load eval compile)
  (setf *vendor-defstruct-predicate-function*
    #+aclpc #'(lambda (x)(and (not (hash-table-p x))
                              (typep x 'structure-object)))
    #+symbolics #'cli::structurep
    #+lucid #'(lambda (x)
                (and (system:structurep x)
                     (let ((type (system:structure-type x)))
                       (and (not (lucid::memq type *lucid-structure-types*))
                            (not #+LCL4.1 
                                 (lucid::memq type lucid::*stream-type-names*)
                                 #-LCL4.1
                                 (streamp x))
                            (not (typep x 'standard-object))))))
    #+excl #'excl::structurep
;;;    #+akcl #'(lambda (x)(and (system::structurep x)
;;;                             (not (hash-table-p x))))
    #+akcl #'(lambda (x)(and (not (classp x))
			     (not (hash-table-p x))
			     (not (instance-p x))
			     (sys:structurep x)))
    #+old-cmu #'(lambda (x)
                  (and (system::structurep x)
                       (not (hash-table-p x))
                       (not (instance-p x))))
    #+cmu #'(lambda (instance)
              (equal (class-name (class-of (find-class (type-of instance))))
                     'structure-class))
    #+mcl
    #'(lambda (x) (ccl::structurep x))
;;;; old def: (equal (class-of x) 'structure-class))
    #+xerox #'(lambda (x))
    ))

(defvar *vendor-data-table-access-function* nil
  "This function accesses a particular column of the data tables,
 dependent upon which vendor it is. ")

(setf *vendor-data-table-access-function*
  #+symbolics #'first
  #+lucid     #'second
  #+excl      #'third
  #+akcl      #'fourth
  #+cmu       #'fifth
  #+mcl      #'sixth
  #+xerox     #'seventh
  #+aclpc     #'eighth
  )

(defvar *vendor-defstruct-slot-desc-access-function* nil
  "given a slot description and an index, return the contents of index.")

(setf *vendor-defstruct-slot-desc-access-function*
  #+symbolics #'(lambda (desc i)(elt desc i))
  #+lucid #'(lambda(desc i)
              (system::structure-ref desc i 'lucid::defstruct-slot))
  #+excl #'(lambda(desc i)(excl::structure-ref desc i))
  #+akcl #'(lambda (desc i)(elt desc i))
  #+cmu #'(lambda(desc i)(kernel::structure-ref desc i))
  #+mcl #'(lambda(desc i)(ccl::struct-ref desc i))
  #+xerox #'(lambda(desc i))
  #+aclpc #'(lambda(desc i))
  )


(defvar *vendor-defstruct-desc-access-function* nil
  "given a description and an index, return the contents of index."
  )

(setf *vendor-defstruct-desc-access-function*
  #+symbolics #'(lambda(desc i)(nth i desc))
  #+lucid #'(lambda(desc i)(system::structure-ref desc i 'lucid::defstruct))
  #+excl #'(lambda(desc i)(excl::structure-ref desc i))
  #+akcl #'(lambda (desc i)(system::structure-ref desc i))
  #+cmu #'(lambda(desc i)(kernel::structure-ref desc i))
  #+mcl #'(lambda(desc i)(ccl::struct-ref desc i))
  #+xerox #'(lambda(desc i))
  #+aclpc #'(lambda(desc i))
  )


(defvar *vendor-defstruct-slot-desc-index-table* nil
  "values in this table are either nil, a number, or a symbol.
 if nil, funcall desc index function on slot desc only.
 if a number, funcall desc index function on slot desc, index.
 if a symbol, the symbol represents a slot name. call slot-value
 on desc (which is presumed to be a CLOS instance) and the slot name.
 If t, we dont know what it is: return the result of a default function."
  )


(setf *vendor-defstruct-slot-desc-index-table*
  ;;"SYMBOLICS LUCID EXCL AKCL    CMU           MCL   XEROX ACLPC"
  '((:name 0      0   #+excl excl::name #-excl nil 
           #+akcl 0 #-akcl nil
           #+cmu #'c::dsd-name #-cmu nil  
           #+mcl #'first #-mcl nil
           #+xerox t #-xerox nil
           0 ;; aclpc
           )
    (:type   4      3   #+excl excl::type #-excl nil
     #+akcl 2 #-akcl nil
     #+cmu #'c::dsd-type #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     3 ;; aclpc
     )
    (:read-status 0 5   #+excl excl::read-only #-excl nil
     #+akcl 3 #-akcl nil
     #+cmu #'c::dsd-read-only #-cmu nil 
     #+mcl t #-mcl nil
     #+xerox t #+xerox nil
     4 ;; aclpc ????
     )
    (:position 1    1   #+excl excl::index #-excl nil
     #+akcl 4 #-akcl nil
     #+cmu #'c::dsd-index #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     #+aclpc t #-aclpc nil
     )
    (:default-value 3 4 #+excl excl::default #-excl nil
                    #+akcl 1 #-akcl nil
                    #+cmu #'c::dsd-default #-cmu nil  
                    #+mcl #'second #-mcl nil
                    #+xerox t #-xerox nil
                    2 ;; aclpc
                    )
    (:accessor 6    2   #+excl excl::accessor #-excl nil
     #+akcl t #-akcl nil
     #+cmu #'c::dsd-accessor #-cmu nil 
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     1 ;; aclpc
     )
    ))


(defvar *vendor-dependent-defstruct-symbol-function* nil
  "Given a name of a defstruct as a symbol, return the defstruct descriptor
   data structure for that defstruct."
  )

(setf *vendor-dependent-defstruct-symbol-function*
  #+symbolics #'(lambda(name)(si:get name 'si:defstruct-description))
  #+lucid #'(lambda(name)(gethash name lucid::*defstructs*))
  #+excl #'(lambda(name)(get name 'excl::%structure-definition))
  #+akcl #'(lambda (name)(get name 'si::s-data))
  #+cmu #'(lambda (name)(ext:info c::type c::defined-structure-info name))
  #+mcl #'(lambda (name)(gethash name ccl::%defstructs%))
  #+xerox #'(lambda(name))
  #+aclpc #'(lambda(name)(acl::structure-name-p name))
  )

(defvar *vendor-defstruct-desc-index-table* nil
  "values in this table are either nil, a number, or a symbol.
 if nil, funcall desc index function on desc only.
 if a number, funcall desc index function on desc, index.
 if a symbol, the symbol represents a slot name. call slot-value
 on desc (which is presumed to be a CLOS instance) and the slot name.")


(setf *vendor-defstruct-desc-index-table*
  ;;"SYMBOLICS LUCID EXCL             AKCL                      CMU MCL"

  '((:NAME #+lispm #'si:defstruct-description-name #-lispm nil
           0
           #+excl excl::name #-excl nil
           #+akcl #'si::s-data-conc-name #-akcl nil          
           #+cmu #'c::dd-name #-cmu nil
           #+mcl t #-mcl nil
           #+xerox t #-xerox nil
           #+aclpc t #-aclpc nil
           )
    (:PRINT-FUNCTION #+lispm #'si:defstruct-description-print-function
     #-lispm nil
     6  
     #+excl excl::print-function  #-excl nil
     #+akcl #'si::s-data-print-function  #-akcl nil
     #+cmu #'c::dd-print-function  #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     #+aclpc t #-aclpc nil
     )

    (:TYPE #+lispm #'si:defstruct-description-type #-lispm nil
     1
     #+excl excl::type #-excl nil
     #+akcl #'si::s-data-type #-akcl nil             
     #+cmu #'c::dd-type #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     0 ;; aclpc
     )
    (:PREDICATE #+lispm #'si:defstruct-description-predicate
     #-lispm nil
     5    
     #+excl  excl::predicate #-excl nil
     #+akcl t #-akcl nil                    
     #+cmu #'c::dd-predicate #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     4 ;; aclpc
     )
    (:COPIER #+lispm #'si:defstruct-description-copier #-lispm nil
     4 
     #+excl excl::copier #-excl nil
     #+akcl t #-akcl nil           
     #+cmu #'c::dd-copier #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     5 ;; aclpc
     )
    (:DOCUMENTATION #+lispm #'si:defstruct-description-documentation
     #-lispm nil
     t   #+excl excl::doc #-excl nil
     #+akcl #'si::s-data-documentation #-akcl nil
     #+cmu #'c::dd-doc #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     #+aclpc t #-aclpc nil
     )
    (:CONC-NAME #+lispm #'si::defstruct-description-conc-name #-lispm nil
     2  
     #+excl excl::conc-name #-excl nil
     #+akcl #'si::s-data-conc-name  #-akcl nil
     #+cmu #'c::dd-conc-name #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     #+aclpc t #-aclpc nil
     )
    (:INCLUDE #+lispm #'si:defstruct-description-include #-lispm nil
     0
     #+excl excl::include #-excl nil
     #+akcl #'si::s-data-include #-akcl nil
     #+cmu #'c::dd-include #-cmu nil
     #+mcl t #-mcl nil
     #+xerox t #-xerox nil
     3 ;; aclpc ?????
     )
    (:CONSTRUCTOR #+lispm #'si::defstruct-description-constructor #-lispm nil
     3
     #+excl  excl::constructor #-excl nil
     #+akcl #'(lambda (x)
                (let ((them (si::s-data-constructors x)))
                  (if (listp them)(first them) them)))
     #-akcl nil
     #+cmu 
     #'(lambda (x)
         (let ((them (c::dd-constructors x)))
           (if (listp them)(first them) them)))
     #-cmu nil
;;;;;     #+mcl t #-mcl nil
     4 ;;;; fifth thing in the descriptor in mcl 2.0.1
     #+xerox t #-xerox nil
     2 ;; aclpc
     )
    ))

(defvar *use-default-defstruct-options-in-save* nil "")


;;;======================================================================

#+akcl
(eval-when (load eval compile)
  ;; HASH-TABLE-SIZE does not seem to exist in AKCL!
  (when (not (fboundp 'hash-table-size))
    (defun HASH-TABLE-SIZE (htab)
      39)
    )
  (defun INSTANCE-P (X) (typep x 'pcl::standard-object))
  (defun %CLASSP (X) (pcl::classp x))

  ) ;; end of akcl eval-when....

;;; ROW MAJOR AREF --- ACL doesnt have it, Genera has it in package FCL....

;;; lucid has row-major-aref, no problem.

#+(or rel-8-0 rel-8-1)
(shadowing-import '(future-common-lisp:row-major-aref) 'database)

#+cmu
(shadowing-import '(user::row-major-aref) 'database)

;;; KOT I think don't need this in Allegro 4.2 (Sun); it's defined in CL
;;; package but I don't know how to test whether it works as I don't use
;;; arrays in my test cases.
#-(or lispm rel-8-0 rel-8-1 lucid cmu aclpc)
(when (not (fboundp 'row-major-aref))
  (pushnew :need-row-major-aref *features*))

;;; lispm has it, CMU has it.

#-(or cmu lispm aclpc)
(eval-when (load eval compile)
  
  #+need-row-major-aref 
  (defun ROW-MAJOR-AREF (array index)
    "We have to define this, as Franz does not implement RMA pg. 450 CLtL2.
     NOTE: Neither does Symbolics."
    (aref (make-array (array-total-size array)
                      :displaced-to array
                      :element-type (array-element-type array))
          index))

  #+need-row-major-aref
  (defun ROW-MAJOR-SETA (array index newval)
    "so we can defsetf row-major-aref!"
    (setf (aref (make-array (array-total-size array)
                            :displaced-to array
                            :element-type (array-element-type array))
                index) newval))

  #+need-row-major-aref
  (defsetf row-major-aref row-major-seta)

  ) ;; row-major-aref eval-when....


(defun %FILL-INSTANCE (i ordered-slot-values)
  "Modified by KJ for MCL: Fills in the slots alphabetically. 
  Assumes the slot values come into the function
  alphabetically ordered already: Returns the instance object.
  NOTE: modification to deal with unbound slots is included!"
  (if (null ordered-slot-values) i
    (let ((osv (copy-list ordered-slot-values))
          (unbound-slot nil)
          (default-slot nil)
          (names (get-ordered-slot-names i))
          (thang nil)
          (name nil))
(IF (NULL NAMES) I
      (loop (setf name (pop names))
        (setf thang (pop osv))
        (cond ((unbound-slot-token-p thang)
               (setf unbound-slot T)
               (setf default-slot NIL))
              ((unsaveable-slot-token-p thang)
               (setf default-slot T))
              ((and thang (symbolp thang))
               ;; mod by KJ to get rid of annoying quotes that
               ;; don't belong (I think this is because
               ;; initialize-instance is no longer getting
               ;; called so the quotes aren't needed.)
                              ;(setf thang `(quote ,thang))
               (setf unbound-slot NIL)
               (setf default-slot NIL))
              (T (setf unbound-slot NIL)
                 (setf default-slot NIL)))
        ;; if this slot was marked as unsaveable,
        ;; let the value be whatever allocate-instace willed it to be.
        ;; if it was unbound when saved, make the new instace slot
        ;; unbound, too. if neither, put the supplied slot value from
        ;; the file in the slot.
        (if default-slot NIL ;; do nothing.
          (if (not unbound-slot)
              (cond ((instance-p i)
                     (setf (slot-value i name) thang)) ;; put the value in.
                    ((structure-p i)(set-defstruct-slot-value i name thang)))
            (slot-makunbound i name))) ;; make the slot unbound.
        (when (and (null names)(null osv))(return i)))))))

(defmacro ASV (new-element)
  "Add to storage vector, create, or vector push extend if necessary."
  `(progn (when (not (boundp '*storage-vector*))
            (setf *storage-vector* 
              (make-array *minimum-storage-vector-length*
                          :adjustable t :fill-pointer 0)))
          (vector-push-extend (EVAL ',new-element) *storage-vector*)))

(defun WRITE-ASV-FORM (stream instance)
  "Write the dump form of the instance for appending to the storage vector.
 make sure that print-pretty is turned off to save room."
  (let* ((*print-pretty* nil))
    (format stream "~s~%" `(ASV ,(get-dump-form instance))))
  )

(defun %WRITE-ASV-FORM (stream instance)
  "Write the dump form of the instance for appending to the storage vector.
 make sure that print-pretty is turned off to save room."
  (let* ((*print-pretty* nil))
    (format stream "~s~%" `(ASV ,(make-dumpable-form instance))))
  )

(defun WRITE-ASV-FORMS (stream)
  ""
  (maphash #'(lambda (key val)
               (declare (ignore key))
               (format stream "~s~%" `(ASV ,val)))
           *storage-hash-table*))

(defmacro WITH-SAVED-OBJECTS-INTERNAL ((so-var construction-form) &rest body)
  "Internal workhorse macro for WITH-SAVED-OBJECTS... derived from WITH-OPEN-
 FILE...."
  `(let ((.stream-abort-flag. :ABORT))
     (unwind-protect
         (multiple-value-prog1
             (progn (set ',so-var ,construction-form)
                    (write-attribute-line ,so-var)
                    (write-package-info ,so-var)
                    (dolist (form ',body)
                      ;;(let ((result (eval form)))              
                        ;;(if (not (pco-p result))
                            ;;(write-asv-form ,so-var result)
                          ;;(get-dump-form result)
                          ;;))
                      (%write-asv-form ,so-var (eval form))              
                      )
                    ;;(write-lex-env-prelude ,so-var)
                    ;;(write-asv-forms ,so-var)
                    ;;(write-lex-env-apotheosis ,so-var)
                    (setf .stream-abort-flag. nil))
           (when ,so-var (close ,so-var :abort .stream-abort-flag.))))))

(defun WRITE-LEX-ENV-PRELUDE (stream)
  (format stream "(LET* ( ")
  (maphash #'(lambda (key value)
               (format stream "(~A ~A)"
                       key value))
           *storage-hash-table*)
  (format stream ")"))

(defun WRITE-LEX-ENV-APOTHEOSIS (stream)
  ""
  (format stream ")~%"))

(defmacro WITH-SAVED-OBJECTS ((svar sspec . options) &body body)
  "Macro which evaluates, then dumps, as many forms as you want to
 the specified file. If you donot specify file attributes, a reasonable
 set (such as :direction :output, if does not exist :create) is assumed.
 NOTE: This macro now returns the filename where the data is stored."
  (clrhash *storage-hash-table*)
  (setf (get 'already-exists 'file)(probe-file sspec))
  (when (null options)(setf options (list :direction :output
                                          :if-exists :append
                                          :if-does-not-exist :create)))
  `(progn (with-saved-objects-internal (,svar (open ,sspec . ,options))
            . ,body)
          ,sspec))

;;; Dump forms.

#|
  Dump forms include:

  constant 
  complex
  quoted-symbol
  simple-list
  defstruct-instance
  defstruct-class

  |#

(defun STREAM-DUMP-FORM (instance)
  "Very machine dependent! for now, just recognize we got one, return NIL as
   DUMP FORM."
  (format t "Recognized a stream in save object: ~a.~%" instance)
  NIL)

(defun CONSTANT-DUMP-FORM (instance)
  "Anything which evals to itself (aside from structured objects),
 can be written as is."
  instance)

(defun COMPLEX-DUMP-FORM (instance)
  "Dumps anything which is a complex number."
  `(COMPLEX ,(get-dump-form (REALPART instance))
            ,(get-dump-form (IMAGPART instance))))

(defun QUOTED-SYMBOL-DUMP-FORM (instance)
  "PATCHED: ADDED SECOND QUOTE FOR 9X: Dump form for a quoted symbol."
  `(QUOTE (QUOTE ,(second instance))))

(defun SIMPLE-LEX-DUMP-FORM (lst)
  `(QUOTE (LIST ,@lst)))

(defun SIMPLE-LIST-DUMP-FORM (instance)
  "Dump form for lists of admissible cnstants."
  #-cmu `(LIST ,@instance)
  #+cmu `(LIST ',@instance)
  )

(defun DOTTED-LIST-DUMP-FORM (instance)
  "Dump form whose last element is a dotted air, .g. returned by LIST*."
  `(LIST*  ,(get-dump-form (first instance))
           ,(get-dump-form (rest instance))))

(defun DEFSTRUCT-INSTANCE-DUMP-FORM (instance)
  "Vendor independent!"
  `(fill-struct ,(get-instance-label instance)
                ;; ',(get-defstruct-values instance)
                (LIST ,@(get-defstruct-values instance))))

(defun REGULAR-FUNCTION-DUMP-FORM (instance)
  ""
  `(FUNCTION ,instance))

;;; Lucid is the only one that has a list length limit.

#-lucid
(eval-when (load eval compile)
  
  (defun LONG-LIST-DUMP-FORM (instance)
    ""
    (list-dump-form instance))

  ) ;; long-list eval-when.

(defun LIST-DUMP-FORM (instance)
  ""
  `(LIST ,@(mapcar #'(lambda (thing)
                       (get-dump-form thing))
                   instance)))

(defun NEW-CACHE-OBJECT (object object-list var-list1 var-list2
                         dump-form)
  "Fixed bug in position call this time."
  (if (member object object-list :test #'equal)
      (symbol-dump-form (nth (position OBJECT object-list :test #'equal)
			     var-list1))
    (progn (push object object-list)
           (setq var-list2 (pushsym var-list1))
           (funcall dump-form object))))

;;; KOT added this; though not clearly how to completely add it in.
(defun CLOSUREP (x)
  "This machine dependent predicate returns t if the object <x> is
   a lexical closure, ie. either a (function (lambda .... thing, or
   a hash-mark quote thing,"
  #+lucid (and (not (typep x 'compiled-function))
               (typep x 'system:procedure))
  #+allegro-v4 (typep x 'excl::closure)
  #-(or lucid allegro-v4)(progn x nil)
  )

(defun CLOSURE-DUMP-FORM (closure)
  #-:function-lambda-expression (declare (ignore closure))
  #+:function-lambda-expression
  (multiple-value-bind (lambda-expression closure-p name)
      (function-lambda-expression closure)
    ;; KOT's reading of ANSI Draft 12.24, page 5-26, is that only the primary
    ;; value is something that potentially could be readable.
    (declare (ignore closure-p name))
    lambda-expression)
  #-:function-lambda-expression nil
  )

;;; KOT put this in here to look at, but it doesn't write anything useful
;;; in Allegro-V4
#+:ignore 
(defun CLOSURE-DUMP-FORM-V70 (closure)
  (let ((ans nil)
        (strname ""))
    (setq *readtable* (copy-readtable))
    (set-dispatch-macro-character #\# #\' (function pseudo-quote-reader))
    (set-dispatch-macro-character #\# #\< (function pseudo-quote-reader))
    (setf strname (format nil "~S" closure))
    (setq ans (read-from-string  (SUBSEQ strname 0 (length strname))))
    (setq *readtable* (copy-readtable nil))
    `(FUNCTION ,ans)))

(defun STRUCTURED-OBJECT-DUMP-FORM (object)
  "Routine which deals with any potentially circular objects (PCOS).
 NEW: Adds the local variable and the dump form to the *Storage-hash-table*
 so that with-saved-objects need to only do one set of local bindings for
 structure-sharing. need to complete arrayp, hash-table-p clauses, test."
  (cond ((null object) NIL)
        ((%classp object)
         (if (member object *classes-seen* :test #'equal)
             (symbol-dump-form
              (nth (position object *classes-seen* :test #'equal)
                   *class-vars*))
           (let ((df nil))
             (push object *classes-seen*)
             (setq *vars* (pushsym *class-vars*))
             (setf df (class-dump-form object))
             (push (list (first *vars*) df) *storage-list*)
             (setf (gethash (first *vars*) *storage-hash-table*)
               df)
             df)))
        ((instance-p object)
         (if (member object *seen* :test #'equal)
             (symbol-dump-form
              (nth (position object *seen* :test #'equal) *vars*))
           (let ((df nil))
             (push object *seen*)
             (setq *vars* (pushsym *vars*))
             (setf df (instance-dump-form object))
             (push (list (first *vars*) df) *storage-list*)
             (setf (gethash (first *vars*) *storage-hash-table*)
               df)
             df)))
        ((structure-p object)
         (if (member object *structs-seen* :test #'equal)
             (symbol-dump-form (nth (position object *structs-seen*
                                              :test #'equal)
                                    *struct-vars*))
           (let* ((df nil))
             (push object *structs-seen*)
             (setf *struct-vars* (pushsym *struct-vars*))
             (setf df  (structure-dump-form object))
             (push (list (first *struct-vars*) df) *storage-list*)
             (setf (gethash (first *struct-vars*) *storage-hash-table*)
               df)
             df)))
        ((vectorp object)
         (if (member object *vectors-seen* :test #'equal)
             (progn (symbol-dump-form (nth (position object *vectors-seen*
                                                     :test #'equal)
                                           *vector-vars*)))
           (let ((df nil))
             (push object *vectors-seen*)
             (setf *vector-vars* (pushsym *vector-vars*))
             (setf df (vector-dump-form object))
             (push (list (first *vector-vars*) df) *storage-list*)
             (setf (gethash (first *vector-vars*) *storage-hash-table*)
               df)
             df)))
        ((arrayp object)
         (if (member object *arrays-seen* :test #'equal)
             (progn (symbol-dump-form (nth (position object *arrays-seen*
                                                     :test #'equal)
                                           *array-vars*)))
           (let ((df nil))
             (push object *arrays-seen*)
             (setf *array-vars* (pushsym *array-vars*))
             (setf df (array-dump-form object))
             (push (list (first *array-vars*) df) *storage-list*)
             (setf (gethash (first *array-vars*) *storage-hash-table*)
               df)
             df)))
        ((hash-table-p object)
         (if (member object *htabs-seen* :test #'equal)
             (symbol-dump-form  (nth (position object *htabs-seen* 
                                               :test #'equal) *htab-vars*))
           (let* ((df nil))
             (push object *htabs-seen*)
             (setf *htab-vars* (pushsym *htab-vars*))
             (setf *current-htab-size* (or (hash-table-size object) 5000))
             (setf *current-htab-rehash-threshold* 
                   (or (hash-table-rehash-threshold object) 20))
             (setf *current-htab-test* (hash-table-test object))
             (setf *current-htab-rehash-size*
                   (or (hash-table-rehash-size object) 67))
             (setf df (htab-dump-form object))
             (push (list (first *htab-vars*) df) *storage-list*)
             (setf (gethash (first *htab-vars*) *storage-hash-table*)
               df)
             df)))
        ((circular-list-p object)(circular-list-dump-form object))
        (T (error "couldnt parse ~a as a structured object!" object))))


(defun DEFSTRUCT-OBJECT-P (obj)
  "Predicate for testing whether something is a defstruct descriptor."
  (typep obj #+lispm 'si::defstruct-description
         #+allegro 'excl::defstruct-description
         #+lucid 'defstruct
         #+akcl 'system::s-data
         #+cmu  'c::defstruct-descriptor
         #+mcl 'vector
         #+aclpc 'vector ;; the descriptor as a whole is a simple vector.
         )
  )

#|

  (defun STRUCTURED-OBJECT-DUMP-FORM (object)
    "Routine which deals with any potentially circular objects (PCOS)."
  (cond ((null object) NIL)
  ((defstruct-object-p object)
  (defstruct-object-dump-form object))
  ((%classp object)
  (new-cache-object object *classes-seen* *class-vars* *vars*
  #'class-dump-form))
  ((instance-p object)
  (new-cache-object object *seen* *vars* *vars*
  #'instance-dump-form))
  ((structure-p object)
  (new-cache-object object *structs-seen* *struct-vars* 
  *struct-vars*
  #'defstruct-instance-dump-form))
  ((vectorp object)
  (new-cache-object object *vectors-seen* *vector-vars* 
  *vector-vars*
  #'vector-dump-form))
  ((arrayp object)
  (new-cache-object object *arrays-seen* *array-vars* 
  *array-vars*
  #'array-dump-form))
  ((hash-table-p object)
  (if (member object *htabs-seen* :test #'equal)
  (symbol-dump-form 
  (nth (position object *htabs-seen* :test #'equal) *htab-vars*))
  (progn (push object *htabs-seen*)
  (setf *htab-vars* (pushsym *htab-vars*))
  (setf *current-htab-size* (or (hash-table-size object) 5000))
  (setf *current-htab-rehash-threshold*
  (or (hash-table-rehash-threshold object) 20))
  (setf *current-htab-test* (hash-table-test object))
  (setf *current-htab-rehash-size*
  (or (hash-table-rehash-size object) 67))
  (htab-dump-form object))))
  ((circular-list-p object)(circular-list-dump-form object))
  (T (error "couldnt parse ~a as a structured object!" object))))
  |#

(defun HTAB-DUMP-FORM (htab)
  "Dump for for hash tables.... "
  `(makehash ,(get-instance-label htab)
             :test ,(get-dump-form (hash-table-test htab))
             :size ,(get-dump-form (hash-table-size htab))
             :rehash-size ,(get-dump-form (hash-table-rehash-size htab))
             :rehash-threshold ,(get-dump-form
                                 (hash-table-rehash-threshold htab))
             :values (LIST ,@(get-htab-values htab))))

(defun PACKAGE-DUMP-FORM (package)
  "assume its there in the environment, somewhere."
  (let ((pn (get-dump-form (package-name package))))
    `(FIND-PACKAGE ,pn)))

(defun REPEATING-ELEMENT-LIST-DUMP-FORM (instance)
  (let ((length (length instance))
        (form (get-dump-form (first instance))))
    `(MAKE-LIST ,length :initial-element ,form)))

(defun REC-LIST-DUMP-FORM (l)
  `(LIST ,@(%rec-list-dump-form l)))

(defun %REC-LIST-DUMP-FORM (l)
  ""
  (cond ((null l) nil)
        ((not (listp (first l)))
         (cons (get-dump-form (first l))
               (%rec-list-dump-form (rest l))))
        (T (cons (%rec-list-dump-form (first l))
                 (%rec-list-dump-form (rest l))))))

(defun CONS-DUMP-FORM (item)
  `(CONS ,(get-dump-form (first item))
         ,(get-dump-form (rest item))))

(defun PRINT-SLOTS (instance)
"Utility function to print the slots in the instance, ala describe."
(mapcar #'(lambda (s)(format t "Name:~a, Value:~a~%" s 
(if (slot-boundp instance s)(slot-value instance s) :UNBOUND)))
(all-slotnames instance)))

(defun ARRAY-DUMP-FORM (array)
  "this function return a make-array form."  
  (setf *print-array* T)
  (let ((vals (%list-array array)))
    `(let ((tmp (allocate-array ,(get-dump-form (array-dimensions array))
                                :element-type ',(array-element-type array)
                                :adjustable ,(adjustable-array-p array)
                                :initial-contents 
                                #-aclpc ,(get-dump-form vals)
                                #+aclpc ,(get-dump-form vals)
                                )))
       TMP)))

(defun SIMPLE-ARRAY-DUMP-FORM (array)
  "Numerical arrays are stored using this routine...."
  (let ((vals (%list-array array)))
  `(allocate-array ,(get-dump-form (array-dimensions array))
               :element-type ',(array-element-type array)
               :initial-contents 
               #-aclpc ,(get-dump-form vals)
               #+aclpc ,(get-dump-form vals)
               )))

(defun VECTOR-DUMP-FORM (array)
  "this function return a make-array form."  
  (setf *print-array* T)
  (let ((vals (%list-array array)))
    `(let ((tmp (allocate-array ,(get-dump-form (array-dimensions array))
                                :element-type ',(array-element-type array)
                                :adjustable ,(adjustable-array-p array)
                                :initial-contents ,(get-dump-form vals))))
       TMP)))

(defun READTABLE-DUMP-FORM (i)
  "Doesnt seem to be a good way to probe the internals of readtables, even
   machine specific ways!!!!"
  (declare (ignore i))
  `(copy-readtable *readtable*))

(defun GENERIC-FUNCTION-DUMP-FORM (instance)
  "Dump Form for saving out generic functions..."
  (let ((name (generic-function-name instance))
        (arglist (generic-function-lambda-list instance))
        (documentation (%generic-function-documentation instance)))
    `(OR (FIND-GENERIC-FUNCTION ',name)
         (DEFGENERIC ,name ,arglist (:DOCUMENTATION ,(or documentation ""))))))

(defun METHOD-DUMP-FORM (instance)
  "dump form for saving out method objects."
  (LET* ((name (generic-function-name (method-generic-function instance)))
         (qualifiers (method-qualifiers instance))
         (specializers (method-specializers instance)))
        `(FIND-METHOD (FUNCTION ,name)
                      (LIST ,@qualifiers)
                      (LIST ,@(DO-SPECIALIZERS specializers))
                      NIL)))

;;; PCL/CLOS classes and instances.
;;; NOTE: CLASS DEFINITIONS, WHEN READ IN, WILL OVERWRITE THE CLASS
;;; DEFINITION PREVIOUSLY IN MEMORY. IF YOU DO NOT WANT THIS TO HAPPEN,
;;; REPLACE 'DEFCLASS' BELOW WITH 'FIND CLASS' + the APPROPRIATE ARGUMENTS!

(defun SAFE-CLASS-DUMP-FORM (instance)
  "This version of the class-dump-form function WILL NOT overwrite 
 current class definitions with the same name. It is the one invoked
 by GET-DUMP-FORM and SAVE-OBJECT."
  (let* ((name (%class-name instance))
         (supertypes (get-class-superclasses instance))
         (slots (generate-class-slot-forms instance))
         (options (generate-class-options-form instance)))
    `(OR (FIND-CLASS ',name)
         (DEFCLASS ,name ,supertypes ,slots ,@options))))

(defun CLASS-DUMP-FORM (instance)
  "This version of the class-dump-form function WILL OVERWRITE 
 CURRENT CLASS DEFINITIONS WITH THE SAME NAME. Sunstitute a call to
 this one in GET-DUMP-FORM and SAVE-OBJECT."
  (let* ((name (%class-name instance))
         (supertypes (get-class-superclasses instance))
         (slots (generate-class-slot-forms instance))
         (options (generate-class-options-form instance)))
    (if (builtin-class-p instance) `(FIND-CLASS ',name)
      `(DEFCLASS ,name ,supertypes ,slots ,@options))))

(defun INSTANCE-DUMP-FORM (instance)
  "Basic dump form for clos/pcl instances. checks if the instance has a custom
 dump form, binds it to a generated symbol name, recursively expands the
 instances contents."
  (declare (special tmp))
  (if (has-dump-form-p (instance-name instance))
      `(setq ,(get-instance-label instance) ,(funcall #'(lambda (x)
                                                          (get-dump-form x))
                                                      instance))
    `(fill-instance ,(get-instance-label instance)
                    (LIST ,@(get-ordered-slot-values instance)))))

(defun LONG-SYMBOL-DUMP-FORM (instance)
  "Uses a MAKE-SYMBOL form to re-create the symbol: 
 saves the property list of the symbol if the global flag is set."
  (make-symbol (symbol-name instance)))

(defun SYMBOL-DUMP-FORM (instance)
  "Better bolder symbol saving formula which includes the package data 
   implicitly: if package cell is NULL (as returned by GENSYM), 
   default *package* is used."
  (let ((package-name nil)
        (the-package (symbol-package instance)))
    (if (null the-package)(setf package-name (package-name *package*))
      (setf package-name (package-name the-package)))
    (if (null instance) NIL
      (if (special-marker-p instance) instance
        (if *use-symbol-long-form*
            (long-symbol-dump-form instance)
          (read-from-string (format nil "~a"
                                    (concatenate 'string "'"
                                                 package-name "::"
                                                 (symbol-name instance)))))))))

(defun SIMPLE-QUOTED-LIST-DUMP-FORM (x)
  (let ((it (quoteit x)))
    `(QUOTE (,@it))))

 #|
  (defun SIMPLE-QUOTED-LIST-DUMP-FORM (x)
    "If the list contains no sublists, and the elements are admissible
      constants, use this dump form."
  `(QUOTE (,@x)))
  |#

(defun ALL-NUMBERS-LIST-DUMP-FORM (instance)
  `(LIST ,@instance))

(defun QUOTED-LIST-DUMP-FORM (instance)
  "If something is a quoted list (may contain sublists), 
  put the quote at the right place."
  `(QUOTE ,instance)
  )

(defun COMPILED-FUNCTION-DUMP-FORM (X)
  "dump form for hashmark-quote e.g. (FUNCTION name) forms."
  #+lispm (if (si:lexical-closure-p x) nil)
  `(function ,(get-compiled-function-name x)))

;;; *** beginning of MCL common lisp definitions...***

;;; NOTE: mst of the slot definition access functions remain undefined in
;;; MCL 2.0.1 --- see introspective-mop.txt for details! kvk

#+mcl
(eval-when (load eval compile)
  
  (defun CLASS-SLOTNAMES (class-object)
    "Calls the clos internal function to compute class slot names."
    (remove nil (mapcar #'first (class-slots class-object))))

  (defun CLASS-SLOTS (class)
    "MODIFIED: Given a class object, return all the slot objects."
                              ;#+quadra(ccl::class-instance-slots class)
                              ;#+fx (ccl::class-slots class)
                              ;#+mcl(class-direct-slots class)
    ;; modified by KJ
    #+mcl(ccl::class-instance-slots class)
    )

  ;; ---- new experimental routines for Mcl ------

  #-ccl-2
  (defun CLASS-DIRECT-SLOTS (class)
    "Given a class object return the slot objects."
    (ccl::class-direct-slots class))

  #+ccl-2
  (defun CLASS-DIRECT-SLOTS (class)
    "Given a class object return the slot objects."
    (ccl::class-direct-class-slots class))

  (defun INSTANCE-P (X)
    "Predicate to determine whether something is an INSTANCE."
    (and (not (%classp x))(typep x 'standard-object)))

  (defun GET-CLASS-DEFAULT-INITARGS (class)
    "Gets the default-initargs out of the class object."
    class
    nil)

  (defun %CLASSP (X)
    "predicate to tell if something is a class object."
    (typep x 'ccl::standard-class))

  (defun %GENERIC-FUNCTION-DOCUMENTATION (f)
    ""
    (or (documentation f) ""))

  (defun GET-SLOT-TYPE (S)
    ""
    (if (dotted-list-p s)(rest (%last s)) ;;; this line is new, kvk.
    (first (reverse s))))

#+ignore
  (defun GET-SLOT-TYPE (S)
    ""
    (if (dotted-list-p s)(rest (%last s)) ;;; this line is new, kvk.
    (first (reverse s))))

  (defun GET-DIRECT-SLOTS (class-object)
    "Gets the immediately available 'new' non inheried slot OBJECTS."
    (class-direct-slots class-object))

  (defun GET-SLOT-DOCUMENTATION (s)
    ""
    (if (listp s) ""
    (or (documentation s) "")))

  (defun GET-SLOT-NAME (S)
    "Method to get the name from a standard slot."
    (clos::slot-definition-name s))

  (defun SLOT-HAS-AN-INITFORM-P (slot-object)
    "Predicate for ccl (where slots are represented as lists) to determine 
    whether a slot object has an initform component."
    (second slot-object))

  (defun GET-SLOT-READERS (s)
    ""
    s
    nil)

  (defun GET-SLOT-WRITERS (s)
    ""
    s
    nil)

  (defun %SLOT-DEFINITION-ALLOCATION (S)
    ""
    s
    NIL)

  (defun GET-SLOT-NAMED (instance name)
    ""
    (find-if #'(lambda (slot)
                 (equal (get-slot-name slot) name))
             (all-slots instance)))

  (defun GET-SLOT-ALLOCATION (S)
    "Method to get the type of allocation from a standard slot: oneof
    :CLASS or :INSTANCE."
    (let ((alloc (%slot-definition-allocation s)))
      (cond ((%classp alloc) :CLASS)
            ((member alloc '(:INSTANCE :CLASS)) alloc) 
            (T :INSTANCE))))

  (defun GET-SLOT-INITFORM (s)
    "For ccl:returns the initform of a slot object."
    (when (slot-has-an-initform-p s)
      (first (second s))))

  (defun GET-SLOT-INITARGS (s)
    ""
    (format t "s == ~a~%" s)
    (if (listp s)(list (second s))
    (ccl::class-slot-initargs s)))

  (defun GET-SLOT-INITARG (s)
    ""
    (format t "s <==> ~a~%" s)
    (if (listp s)(second s)
    (first (ccl::class-slot-initargs s))))

  (defmethod ALL-SLOTNAMES ((instance T) &optional (all-allocations T))
    "returns the names of the slots in instance, uses what MOP stuff is 
    available."
    (declare (ignore all-allocations))
    (REMOVE NIL (mapcar #'clos::slot-definition-name 
                        (class-slots (clos::class-of instance)))))

  ;; Hohmann patch...
  (setf (symbol-function 'classp) #'ccl::classp) ;; FIXED!!!!

  (defun ALL-SLOTS (instance)
    "Gets all the slots from the instances class, whether inherited or not."
    (class-slots (clos::class-of instance)))

  (defun GET-SUPERCLASS-NAMES (class)
    ""
    (mapcar #'clos::class-name (clos::class-direct-superclasses class)))

  ) ;; *END OF MCL CCL CLOS eval-when! ****


;;; A CLOS eval-when for Allegro PC:

#+clos
(eval-when (load eval compile)
  
  #-aclpc
  (defun %CLASS-NAME (x)
    "If instance, gets the name of the class of the instance."
    (if (instance-p x)(clos::class-name (clos::class-of x))
      (clos::class-name x)))

  #+aclpc
  (defun %CLASS-NAME (x)
    "If instance, gets the name of the class of the instance."
    (if (instance-p x)(class-name (class-of x))
      (class-name x)))

  #+aclpc
  (defun ACLPC-GET-DEFSTRUCT-CONSTRUCTOR (symbol)
    (read-from-string (concatenate 'string "MAKE-" (format nil "~A" symbol))))

  #+aclpc
  (defmethod ALLOCATE-INSTANCE ((class structure-class) &rest initargs)
    ""
    (apply (aclpc-get-defstruct-constructor (class-name class)) nil))

  ) ;; end of eval-when....

;;; HASH TABLES...

;;; PCL Dependent functions & methods,,,

#+pcl
(eval-when (load eval compile)
  
  (defvar *the-pcl-standard-class-name* 'pcl::standard-class)

  (defun BUILTIN-CLASS-P (X)
    (member (type-of x) (mapcar #'first pcl::*built-in-classes*)))

  (defun GET-SLOT-READERS (slot-object)
    #-new-pcl(pcl::slotd-readers slot-object)
    #+new-pcl(pcl::slot-definition-readers slot-object)
    )

  (defun GET-SLOT-WRITERS (slot-object)
    #-new-pcl(pcl::slotd-writers slot-object)
    #+new-pcl(pcl::slot-definition-writers slot-object)
    )

  (defun %GET-SLOT-ALLOCATION (s)
    #-new-pcl(pcl::slotd-allocation s)
    #+new-pcl(pcl::slot-definition-allocation s)
    )

  (defun GET-SLOT-ALLOCATION (S)
    "Method to get the type of allocation from a standard slot: oneof
    :CLASS or :INSTANCE."
    (let ((alloc (%get-slot-allocation s)))
      (cond ((%classp alloc) :CLASS)
            ((member alloc '(:INSTANCE :CLASS)) alloc) 
            (T :INSTANCE))))

  (defun GET-SLOT-NAME (S)
    "Method to get the name from a standard slot."
    #-new-pcl(pcl::slotd-name s)
    #+new-pcl(pcl::slot-definition-name s)
    )

  (defun %CLASS-NAME (class)
    ""
    (pcl::class-name class))

  (defmethod GET-SLOT-INITFORM (s)
    ""
    (when (slot-has-an-initform-p s)
      #-new-pcl(pcl::slotd-initform s)
      #+new-pcl(pcl::slot-definition-initform s)
      ))

  (defun SLOT-HAS-AN-INITFORM-P (s)
    ""
    (slot-boundp s 'pcl::initform))

  (defun GET-SLOT-INITARGS (s)
    ""
    #-new-pcl(pcl::slotd-initargs s)
    #+new-pcl(pcl::slot-definition-initargs s)
    )

  (defun GET-SLOT-INITARG (s)
    ""
    #-new-pcl(first (pcl::slotd-initargs s))
    #+new-pcl(first (pcl::slot-definition-initargs s))
    )

  #-akcl
  (defun CLASS-SLOTS (class-object)
    "Calls the clos internal function to compute class slot objects:
     used in CMUCL, too!"
    (pcl::slots-to-inspect (class-of class-object) class-object))

  (defun %ALLOCATE-INSTANCE (class-object &rest htab-plist)
    (cond
     ((equal class-object 'HASH-TABLE)
      (allocate-htab class-object 
                     :size (getf htab-plist :size 5000)
                     :rehash-size (getf htab-plist :rehash-size 67)
                     :rehash-threshold (getf htab-plist :rehash-threshold 0.67)
                     :test (getf htab-plist :test #'eql)))
     ((get-symbol-defstruct-spec class-object)
      (allocate-struct class-object))
     ((structure-p class-object)(allocate-struct class-object))
     ((symbolp class-object)
      (pcl::allocate-instance (find-class class-object nil)))
     ((%classp class-object)(pcl::allocate-instance class-object))
     ((instance-p class-object) class-object)
     (T (format T "Warning: couldnt allocate instance for object: ~A!" class-object) NIL)))

  ;; CLASSP is not exported from PCL, the next two are substitutes.

  (defun CLASSP (x)
    "Predicate, determines whether the object x is a class object."
    (pcl::classp x))

  (defun %CLASSP (x)
    "Predicate, determines whether the object x is a class object."
    (classp x))

  (defun INSTANCE-NAME (instance)
    "returns the symbol naming the given class object."
    (cond ((hash-table-p instance) 'hash-table)
          ((structure-p instance)(get-defstruct-name instance))
          ((instance-p instance)(pcl::class-name (pcl::class-of instance)))
          (T NIL)))

  (defun ALL-SLOTNAMES (instance &optional (all-allocations T))
    "returns the names of the slots in instance."
    (let ((them (mapcar #'(lambda (slot)
                            (pcl::slot-value slot 'pcl::name))
                        (pcl::slots-to-inspect (pcl::class-of instance)
                                               instance))))
      (if all-allocations them 
        (remove-if-not #'(lambda (slot)
                           (equal (%get-slot-allocation slot) :instance))
                       them))))

  (defun ALL-SLOTS (instance &optional (all-allocations T))
    "returns the names of the slots in instance."
    (let ((them (pcl::slots-to-inspect (pcl::class-of instance)
                                       instance)))
      (if all-allocations them 
        (remove-if-not #'(lambda (slot)
                           (equal (%get-slot-allocation slot) :instance))
                       them))))

  (defun %GENERIC-FUNCTION-P (X)
    ""
    (pcl::generic-function-p x))

  (defun GET-SLOT-DOCUMENTATION (slot)
    ""
    (or (documentation slot (type-of slot)) ""))

  (defun GET-SLOT-TYPE (slot)
    ""
    #-new-pcl(pcl::slotd-type slot)
    #+new-pcl(pcl::slot-definition-type slot)
    )

  (defun GET-SUPERCLASS-NAMES (class)
    ""
    (mapcar #'%class-name (pcl::class-direct-superclasses class)))

  (defun GET-CLASS-DEFAULT-INITARGS (class)
    ""
    (pcl::class-default-initargs class))

  (defun GET-CLASS-METACLASS (class-object)
    "Given a class object, returns the metaclass name to help build
 CLASS-DUMP-FORM:  (NEW)."
    (when (%classp class-object)
      (let ((meta (%class-name (class-of (class-of class-object)))))
        (if (not (equal meta *the-pcl-standard-class-name*)) ;; the default...
            (list (list :metaclass meta))))))

  #+cmu
  (eval-when (load eval compile)

    (defun INSTANCE-P (x)
      "Predicate for CMU Common Lisp: detects instances."
      ;; used to be std-instance.
      (and (not (%classp x))(typep x 'pcl::standard-object))) 

    ) ;; end of CMU CL eval-when for PCL.....

  (defun GET-DOCUMENTATION (object)
    ""
    (let ((answers nil))
      (dolist (current-type (get-available-types object)(nreverse answers))
        (push (documentation object current-type) answers))))

  )  ;; *** END PCL EVAL-WHEN.... ***

(defun GET-COMPILED-FUNCTION-NAME (fn)
  "Given a function object <fn>, return the symbol name of the function."
  #+lispm
  (when (si:lexical-closure-p fn)
    (return-from get-compiled-function-name nil))
  (etypecase fn 
    (symbol fn)
    (compiled-function #+old-cmu(kernel:%function-header-name fn)
                       #+cmu(kernel:%function-name fn)
                       #+mcl(ccl::function-name fn)
                       #+lispm(si:compiled-function-name fn)
                       #+akcl(system::compiled-function-name fn)
                       #+lucid
                       (when (sys:procedurep fn)
                         (sys:procedure-ref fn SYS:PROCEDURE-SYMBOL))
                       #+excl (xref::object-to-function-name fn)
                       )))

;;;(let ((ans nil)
;;;      (strname ""))
;;;(setq *readtable* (copy-readtable))
;;;(set-dispatch-macro-character #\# #\' (function pseudo-quote-reader))
;;;(set-dispatch-macro-character #\# #\< (function pseudo-quote-reader))
;;;(setf strname (format nil "~S" fn))
;;;(setq ans (read-from-string (SUBSEQ strname 0 (length strname))))
;;;(setq *readtable* (copy-readtable nil))
;;;ans)
;;;)))

;;; Support functions for MAP-CLASS.

#+lucid
(defun ALL-SLOTS (class-object)
  ""
  (class-slots class-object))

(eval-when (load eval compile)
  
  (defun GET-SLOT-COMPONENT (key slot-object)
    ""
    (let* ((keylist '((:all identity)
                      (:initform get-slot-initform)))
           (applyfun (second (assoc key keylist :test #'equal))))
      (when applyfun (funcall applyfun slot-object))))

  (defun MAP-CLASS (function class-object &key (component :all)
                                               (save T)
                                               (plist T))
    "Iterator for class objects. Applies a function to each (slot). "
    (let ((slots (all-slots class-object))
          (answer nil)
          (current nil))
      (dolist (slot slots answer)
        (if plist
            (setf current (list (make-keyword (get-slot-name slot))
                                (funcall function
                                         (get-slot-component component slot))))
          (setf current (funcall function
                                 (get-slot-component component slot))))
        (when (and save (not plist)) (push current answer))
        (when (and save plist)(setf answer (append answer current))))
      answer))

  (defun MAP-CLASS-DUMP-FORM (class-object &key (component :all))
    ""
    (get-dump-form
     (map-class #'get-dump-form class-object :plist t 
                :component component :save t)))
  ) ;; non clos/pcl eval-when end.

(defun SIMPLE-ARRAY-P (instance)
  ""
  ;; KOT fixed typo here.
  (and (arrayp instance)(not (pco-p instance))))

#+mcl
(defun MAC-HANDLE-DUMP-FORM (instance)
"STUB."
nil)

(defun BUILTIN-INSTANCE-P (instance)
  (and instance (not (eq instance T))
       (not (instance-p instance))
       (not (hash-table-p instance))
       (not (pathnamep instance))
       (not (numberp instance))
       (not (keywordp instance))
       (not (arrayp instance))
       (not (consp instance))
  (builtin-class-p (type-of instance))))

(defun MAKE-BUILTIN-INSTANCE (instance)
"STUB!"
  :INSTANCE)

(defun BUILTIN-INSTANCE-DUMP-FORM (instance)
`(MAKE-BUILTIN-INSTANCE ',(instance-name instance)))

(defun GET-DUMP-FORM (instance)
  "New incarnation of get-dump-form: if the instance is a structured
   object, construct a representation for it anticipating that it might
   be a PCO. NOTE: in MCL Common Lisp, note that STREAMS are implemented as
   CLASSES! This makes it possible to SAVE-OBJECT things like *TERMINAL-IO*!"
  (cond ((null instance) nil)
        ((equal instance T) T)
        #+mcl ((ccl::handlep instance)(mac-handle-dump-form instance))
        ((circular-cons-p instance)(circular-cons-dump-form instance))
        ((circular-dotted-list-p instance)
         (circular-dotted-list-dump-form instance))
        ((numberp instance) instance)
        ((or (pathnamep instance)
             (stringp instance)
             (keywordp instance)
             (special-marker-p instance)
             (characterp instance)) instance)
        ((packagep instance)(package-dump-form instance))
        ((quoted-symbol-p instance)(quoted-symbol-dump-form instance))
;;;        ((quoted-form-p instance)(quoted-form-dump-form instance))
        ((symbolp instance)(symbol-dump-form instance))
        ;; ((simple-array-p instance)(simple-array-dump-form instance))
        ((vectorp instance)(vector-dump-form instance))
        ((cons-p instance)(cons-dump-form instance))
        ((BUILTIN-INSTANCE-P INSTANCE)
         (format t "found builtin : ~a~%" instance)
         (BUILTIN-INSTANCE-DUMP-FORM INSTANCE))
        ((pco-p instance)(structured-object-dump-form instance))
        ((arrayp instance)(array-dump-form instance))

        ;; KOT put this in.  Might be wrong for many people, but for my
        ;; application dumping closures just caused me to have unreadable
        ;; forms, so I've basically stubbed out closures (as nil) above.
        ;; I'm unconvinced these can be written portably, do with this what
        ;; you want.
        ((closurep instance) (closure-dump-form instance))

        #-mcl ((functionp instance) (compiled-function-dump-form instance))
        #+mcl ((functionp instance)
               (if (ccl::function-name instance)
                   (compiled-function-dump-form instance)))

        ((stream-p instance)(stream-dump-form instance))
        ((readtablep instance)(readtable-dump-form instance))
        ((repeating-element-list-p instance)
         (repeating-element-list-dump-form instance))
        ((dotted-list-p instance)(dotted-list-dump-form instance))
        ((all-numbers-list-p instance)(all-numbers-list-dump-form instance))
        ((simple-lex-list-p instance)(simple-lex-dump-form instance))
        ;;((simple-quoted-list-p instance)
        ;;(simple-quoted-list-dump-form instance))
;;      #-mcl ((quoted-list-p instance)(quoted-list-dump-form instance))
;;      #-mcl ((simple-list-p instance)(simple-list-dump-form instance))
        ;;((LISTP instance)(rec-list-dump-form instance))
        #-mcl((listp instance) `(LIST ,@(mapcar #'(lambda (thing)
                                               (get-dump-form thing)) 
                                           instance)))
        #+mcl((listp instance)(list-dump-form instance))
        (T (error "could not parse object ~a, of type ~a.~%"
                  instance (type-of instance)))))

(defun MAPAPPEND (fun &rest args)
  "From the MOP book!"
  (if (%some #'null args)
      ()
    (append (apply fun (mapcar #'car args))
            (apply #'mapappend fun (mapcar #'cdr args)))))

(defun QUOTEIT (l)
  (cond ((null l) nil)
        ((null (first l))
         (cons nil (quoteit (rest l))))
        ((equal (first l) T)
         (cons t (quoteit (rest l))))
        ((not (listp (first l)))
         (cons (get-dump-form (first l))(quoteit (rest l))))
        ((simple-quoted-list-p (first l))
         (cons (simple-quoted-list-dump-form (first l))
               (quoteit (rest l))))
        (T (cons (quoted-list-dump-form (first l))
                 (quoteit (rest l))))))

(defun SAMESET (l1 l2 &key (test #'equal))
  "predicate, returns t if the two sets contain the same elements."
  (and (subsetp l1 l2 :test test)(subsetp l2 l1 :test test)))

(defun MAPPLIST (fun x)
  "From the MOP book!"
  (if (null x) nil (cons (funcall fun (first x)(second x))
                         (mapplist fun (cddr x)))))

(defun %TYPE-OF (x)
  "Special type-of operator, returns more intelligent type for object caching:"
  (cond ((%classp x) 'class)
        ((instance-p x) 'instance)
        ((structure-p x) 'structure)
        ((hash-table-p x) 'hash-table)
        ((typep x 'vector) 'vector)
        ((array-type-t-p x) 'array-type-t)
        ((arrayp x) 'array)
        ((cons-p x) 'cons)
        ((listp x)(if (circular-list-p x) 'circular-list 'list))
        (T (type-of x))))

(defun FLATTEN (l)
  ""
  (let ((answers nil))
    (dolist (cell l answers)
      (setf answers (nconc answers cell)))
    answers))

(defun FLATTEN1 (cells)
  (let ((answer nil))
    (dolist (cell cells answer)
      (setf answer (nconc answer cell)))
    answer))

(defun PAIR-UP (l)
  ""
  (let ((answers nil))
    (loop (push (list (pop l)(pop l)) answers)
      (when (null l)(return (reverse answers))))))

(defun GET-ORDERED-SLOT-VALUES (i)
  "Gets the dump forms out of the instance slot values, then alphabetizes them"
  (cond ((instance-p i)(alphabetize-by-keyword (get-slot-values i)))
        ((structure-p i)(%%get-defstruct-values i))
        (T (error "could not parse object ~a~%" i))))

(defun MAKE-KEYWORD (x)
  "Makes a keyword out of a symbol."
  (if (keywordp x) x (intern (symbol-name x) 'keyword)))

(defun NEWSYM (symbol)
  "Similar to GENSYM, but allows access to the gensym counter unlike pre-ANSI 
   GENSYM."
  (if (null (get symbol 'namecounter))
      (setf (get symbol 'namecounter) 0))
  (read-from-string (concatenate 'string (string symbol)
                                 (format nil "~S" 
                                         (incf (get symbol 'namecounter))))))

(defun PSEUDO-QUOTE-READER (stream subchar arg)
  "Reader to convert a function spec into a more parsable format."
  (declare (ignore subchar arg))
  (eval
   (list 'quote
         (second (read-from-string 
                  (nsubstitute #\space #\#
                               (concatenate 'string "(" 
                                            (read-line stream t nil t) ")")
                               :test #'equal))))))

(defun INSURE-LIST (X)
  (if (listp x) x (list x)))

(defun NASSOC (key list &key (test #'equal))
  "Given a key and a list, return the thing AFTER that key in the list.
 Similar to GETF."
  (let ((where (position key list :test test)))
    (when where (nth (1+ where) list))))

(defun MAKEVAR (&optional (label '.%%SL%%.))
  "makes a new variable for something in the global object hashtable."
  (incf *global-object-count*)
  (newsym label))

(defun PUSHSYM (list &optional (label '.%%SL%%.))
  "label must match with special-marker-p, and must be upper-case."
  (push (newsym label) list))

(defun MAKESYMS (symbol min max &optional (pkg *package*))
  (let ((c min))
    (progn
      ;; KOT *nowarn* isn't defined in 4.2, not sure why ...
      #+(and excl (not :allegro-v4.2)) (setf excl::*nowarn* T)
      #+symbolics (setf compiler::*suppress-compiler-warnings* T)
      (dotimes (count max)
        (incf c)

        (eval `(defvar
                   ,(read-from-string (concatenate 'string
                                                   (format nil "~A" symbol)
                                                   (format nil "~A" c))
                                      pkg))))
      #+(and excl (not :allegro-v4.2)) (setf excl::*nowarn* NIL)
      #+symbolics (setf compiler::*suppress-compiler-warnings* NIL)
      )))

(defun %INSURE-LIST (X)
"If a list retrns it, if not a list, makes it one."
  (if (listp x) x
    (list nil x)))

;;; Functions for allocating and maniulating arrays.

(defmacro ALLOCATE-ARRAY (dims &key (element-type t)
                                    (adjustable nil)
                                    (initial-contents nil))
  "Function to allocate an array. No fill-pointer.
 suggested by kanderson@bbn.com."
  `(make-array ,dims :element-type ,element-type
               :initial-contents #-mcl ,initial-contents
                                 #+mcl ,initial-contents
               :adjustable ,adjustable))

(defmacro ALLOCATE-VECTOR (dims &key (element-type t)
                                     (adjustable nil)
                                     (fill-pointer nil))
  "Function to allocate an array. suggested by kanderson@bbn.com."
  `(make-array ,dims :element-type ,element-type
               :adjustable ,adjustable
               :fill-pointer ,fill-pointer))

(defun LIST-ARRAY (array)
  "Function for converting an n-dimensional array into the kind of list approp
   riate for the initial-elements keyword of a make-array function: dump-form-on-p
   means that the elements of the array are generated as dump forms, not just
   the explict LISP values within the array!"
  (list-array-aux array 0 nil :dump-form-on-p T))

(defun %LIST-ARRAY (array)
  "Function for converting an n-dimensional array into the kind of list approp
   riate for the initial-elements keyword of a make-array function. 
   DUMP-FORM-ON is NIL. The generated list contains the explicit values which
   were in the array, NOT the dump forms! This is used in VECTOR-DUMP-FORM and
   ARRAY-DUMP-FORM, among others."
  (list-array-aux array 0 nil :dump-form-on-p nil))

#-(or mcl akcl allegro aclpc)
(defun LIST-ARRAY-AUX (array level subscript-list &key (dump-form-on-p T))
  "Helper function for coercing an n-dimensional array into a list."
  (let ((new-level (1+ level))
        (dims (array-dimensions array)))
    (loop for i from 0 to (1- (nth level dims))
        collect
          (cond ((equal level (1- (length dims)))
                 (let* ((aref-arg-list
                         (cons array (append subscript-list
                                             (list i))))
                        (array-val (apply #'aref aref-arg-list)))
                   (if (numberp array-val) array-val
                       (if dump-form-on-p (get-dump-form array-val)
                           array-val))))
                (T (list-array-aux array new-level
                                   (append subscript-list (list i)))))
          ;; (append '(list) temp)
        into temp finally (return temp))))

#+(or akcl mcl allegro aclpc)
(defun LIST-ARRAY-AUX (array level subscript-list &key (dump-form-on-p nil))
  "Helper function for coercing an n-dimensional array into a list."
  (let ((new-level (1+ level))
        (dims (array-dimensions array))
        (answers nil))
    ;; was 1- nth level-dims before.
    (dotimes (i (nth level dims) answers)
      (setf answers (append 
                     answers
                     (list
                      (cond ((equal level (1- (length dims)))
                             (let* ((aref-arg-list
                                     (cons array (append subscript-list
                                                         (list i))))
                                    (array-val (apply #'aref aref-arg-list)))
                               (if (numberp array-val) array-val
                                   (if dump-form-on-p (get-dump-form array-val)
                                       array-val))))
                            (T (list-array-aux array new-level
                                               (append subscript-list
                                                       (list i)))))))))
    answers))

(defun CLEAR-GLOBAL-VARS-AND-HTABS ()
  "Initializes the SAVE-OBJECT enviroment for recording graph cycles."
  (setf *classes-seen* nil *class-vars* nil)
  (setf *structs-seen* nil *struct-vars* nil)
  (setf *vectors-seen* nil *vector-vars* nil)
  (setf *arrays-seen* nil *array-vars* nil)
  (setf *htabs-seen* nil *htab-vars* nil)
  (setf *seen* nil *vars* nil)
  (clrhash *save-object-hash-table*))

;;; Functions for manipulating hash tables....

(defun %LOAD-HTAB  (htab &optional lst)
  ""
  (loop
    (when *debug-htab-load* (format t "setting slot ~a to ~a.~%"
                                    (first lst)(second lst)))
    (setf (gethash (pop lst) htab)(pop lst)) 
    (when (null lst)(return htab))))

;;; Map lucid/allegro htab incompatibility of rehash threshold
;;; parameter into mutually acceptable values. (i.e. fix bug)

#+lucid
(defun SCALE-REHASH-THRESHOLD (num)
  (if (> num 1)(float (/ num 100)) num))

#+allegro
(defun  SCALE-REHASH-THRESHOLD (num)
  (if (<= num 1)(* num 100) num))

#-(or allegro lucid)
(defun SCALE-REHASH-THRESHOLD (num)
  num)

(defun MAKEHASH (h &key (test #'eql)
                        (size 5000)
                        (rehash-size 67)
                        (rehash-threshold 0.65)
                        values)
  ""
  (let ((htab (or h 
                  (make-hash-table 
                   :test test
                   :size size
                   :rehash-size rehash-size
                   :rehash-threshold (scale-rehash-threshold rehash-threshold)
                   ))))
    (if (null values) htab
      (progn (%load-htab htab values) htab))))

(defun GET-HTAB-VALUES (htab)
  (let ((values nil))
    (maphash #'(lambda (key val)
                 (push (get-dump-form val) values)
                 (push (get-dump-form key) values))
             htab) values))

(defun PRINT-HTAB (htab)
  (maphash #'(lambda (key val)
               (format t "~%Key: ~a, value=~a.~%" key val))
           htab))

;;; Now, the Symbolics....

#+lispm
(eval-when  (load eval compile)

  (defun HASH-TABLE-SIZE (x)
    (scl:send x :size))

  (defun HASH-TABLE-TEST (x)
    (si:function-name (cli::test-function x)))

  )

(defun CREATE-HASH-TABLE (&key (test #'eql)
                               (size 67)
                               (rehash-size nil)
                               (rehash-threshold nil))
  (let ((args (remove nil
                      `(:size ,(get-dump-form size)
                              :test ,test
                              ,@(when rehash-size
                                  (list :rehash-size
                                        (get-dump-form rehash-size)))
                              ,@(when rehash-threshold
                                  (list :rehash-threshold
                                        (get-dump-form rehash-threshold)))))))
    (cache-object (apply #'make-hash-table args) :mode :load)))

(defun LOAD-HTAB (values &key (test #'eql)
                              (size 67)
                              (rehash-size nil)
                              (rehash-threshold nil))
  ""
  (let ((htab (create-hash-table :test test
                                 :size size
                                 :rehash-size rehash-size
                                 :rehash-threshold rehash-threshold))
        (key nil)(val nil))
    (dolist (cell values)
      (setf key (first cell))
      (setf val (eval (second cell)))
      (setf (gethash key htab) val))))

;;; Defstruct access functions.

(defun GET-DEFSTRUCT-TYPE (structname)
  ""
  (if (structure-p structname)(type-of structname)
    (let ((desc (get-defstruct-descriptor structname)))
      (funcall *vendor-defstruct-type-function* desc))))

;;; KOT wrapped eval-when around this -- in Allegro-V4 at least, allowed the
;;; succeeding (setf (symbol-function 'structurep)) to compile (???).
(eval-when (load eval compile)
  (defun STRUCTURE-P (X)
    "Predicate: returns T if x is a structure instance!"
    (funcall *vendor-defstruct-predicate-function* x)))

#-aclpc
(eval-when (load eval compile)
  (setf (symbol-function 'structurep) #'structure-p)
  ) ;; end of eval-when....

(defun GET-DEFSTRUCT-DESCRIPTOR (structname)
  ""
  (when (structure-p structname)
    (setf structname (get-defstruct-name structname)))
  (funcall *vendor-defstruct-descriptor-function* structname))

(defun GET-DEFSTRUCT-SLOT-DESCRIPTORS (structname)
  ""
  (when (structure-p structname)
    (setf structname (get-defstruct-name structname)))
  (funcall *vendor-defstruct-slot-descriptors-function* structname))

(defun GET-DEFSTRUCT-SLOT-DESCRIPTOR (structname slotname)
  ""
  (dolist (slot (get-defstruct-slot-descriptors structname))
    (when (equal slotname (get-defstruct-slot-name slot))
      (return slot))))
;;; (eval-when (:compile-toplevel :load-toplevel :execute)
;;; KOT wrapped eval-when around this, in Allegro-V4 allows better compilation

(eval-when (load eval compile)
  (defun MAKE-DEFSTRUCT-ACCESS-FUNCTIONS ()
    "Automatically generates the functions we need to access the
     components of the defstruct object and its instances."
    (let* ((kwd-list '(:print-function :predicate :include
                       :constructor :copier :documentation :conc-name))
           (kwd-slot-list '(:name :type :read-status :default-value :position))
           (answers nil))
      (dolist (kwd kwd-slot-list answers)
;;; This next EVAL seems to have problems in MCL 2.0.1:
        (pushnew (EVAL `(defun
                            ,(read-from-string (concatenate 'string
                                                 "GET-DEFSTRUCT-SLOT-"
                                                 (symbol-name kwd)))
                            (slotd)
                          (defstruct-slot-descriptor-ref slotd ,kwd)))
                 answers))
      (dolist (kwd kwd-list answers)
        (pushnew (EVAL `(defun
                            ,(read-from-string (concatenate 'string
                                                 "GET-DEFSTRUCT-"
                                                 (symbol-name kwd)))
                            (struct)
                          (let ((desc (get-defstruct-descriptor struct)))
                            (when (null desc)
                              (format t "WARNING: desc was NULL!~%"))
                            (defstruct-descriptor-ref desc ,kwd))))
                 answers)))))

(defun GET-INDEX-FOR-DD-KWD (kwd)
  (funcall *vendor-data-table-access-function*
           (cdr (assoc kwd *vendor-defstruct-desc-index-table*
                       :test #'equal))))

(defun GET-INDEX-FOR-SD-KWD (kwd)
  (funcall *vendor-data-table-access-function*
           (cdr (assoc kwd *vendor-defstruct-slot-desc-index-table*
                       :test #'equal))))

(defun SD-USE-DEFAULT (sd kwd &optional structname)
  ""
  (let* ((sdname
          (symbol-name (defstruct-slot-descriptor-ref sd :name))))
    (cond ((equal kwd :accessor)
           (return-from sd-use-default
             (read-from-string              
              (concatenate 'string (symbol-name structname)
                           "-" sdname)))))))

(defun DD-USE-DEFAULT (dd kwd)
  ""
  (let* ((name (defstruct-descriptor-ref dd :name))
            (sname (symbol-name name))
            (kwds '((:copier "COPY-")
                    (:constructor "MAKE-")))
          (the-one (second (assoc kwd kwds :test #'equal))))
    (when the-one (return-from dd-use-default
                    (read-from-string (concatenate 'string the-one sname))))))

(defun DEFSTRUCT-DESCRIPTOR-REF (desc kwd)
  "Vendor independent function to extract defstruct info from a defstruct
 descriptor."
  (let ((i (get-index-for-dd-kwd kwd)))
    (cond ((null i)
           (funcall *vendor-defstruct-desc-access-function* desc))
          ((equal i T)(dd-use-default desc kwd))
          ((numberp i)(apply *vendor-defstruct-desc-access-function* 
                             (list desc i)))
          ((compiled-function-p i)(funcall i desc))
          ((symbolp i)(slot-value desc i))
          ((and (listp i)(equal (first i) 'function))
           (funcall (eval i) desc))
          (T (error "not a valid index type: ~s~%" i)))))

(defun DEFSTRUCT-SLOT-DESCRIPTOR-REF (sd kwd &optional structname)
  "Given a slot descriptor and a keyword, return the value for that
 keyword. If the kewyord value is T, that means we dont really know
 how to do it, and to use the default function for that keyword."
  (let ((i (get-index-for-sd-kwd kwd)))
    (cond ((null i)
           (funcall *vendor-defstruct-slot-desc-access-function* sd))
          ((equal i T)(sd-use-default sd kwd structname))
          ((numberp i)
           (funcall *vendor-defstruct-slot-desc-access-function* sd i))
          ((compiled-function-p i)(funcall i sd))
          ((symbolp i)(slot-value sd i))
          ((and (listp i)(equal (first i) 'function))
           (funcall (eval i) sd))
          (T (error "not a valid index type: ~s~%" i)))))

#+aclpc
(defun GET-DEFSTRUCT-SLOT-NAMES (struct)
  "Gets an unordered list of the structs slotnames."
  (let* ((desc (get-defstruct-slot-descriptors (get-defstruct-name struct))))
    (when desc (mapcar #'first desc))))

#-aclpc
(defun GET-DEFSTRUCT-SLOT-NAMES (struct)
  "Gets an unordered list of the structs slotnames."
  (let* ((slotds (get-defstruct-slot-descriptors (get-defstruct-name struct)))
         (names (mapcar #'(lambda (slotd)
                            (get-defstruct-slot-name slotd))
                        slotds)))
    names))

(defun FILL-STRUCT (struct vals)
  "Fills the structure instance struct with the values vals."
  (when (symbolp struct)(setf struct (allocate-struct struct)))
  (dolist (slotname (get-defstruct-slot-names struct) struct)
;;;;  (format t "Slot name:~s, Value: ~s~%" slotname (first vals))
    (set-defstruct-slot-value struct slotname (pop vals)))
  struct)

(defun ALLOCATE-STRUCT (name)
  "Function to allocate the empty husk of a defstruct."
  (apply (get-defstruct-constructor name) nil))

(defun FIND-STRUCTURE-OBJECT (name)
  "Now its just get-defstruct-descriptor, but it might get mor elaborate."
  (get-defstruct-descriptor name))

(defun GET-NAME-FROM-OPTION-LIST (option-list)
  ""
  ;; KOT put in declare, but what is the use of this??
  (declare (ignore option-list)) 
  )

(defun CONSTRUCT-DEFSTRUCT-OPTION-LIST (name)
  "Given a defstruct descriptor, make an option list for that descriptor."
  (cond ((structure-p name))
        ((symbolp name))
        (T NIL)))

(defun CONSTRUCT-DEFSTRUCT-SLOT-LIST (name)
  "Given a defstruct descriptor, make a slot list for that descriptor."
  (let* ((slist (get-defstruct-slot-descriptors name))
         (answers nil))
    (dolist (slot slist (nreverse answers))
      (let ((name (get-defstruct-slot-name slot))
            (value (get-defstruct-slot-default-value slot))
            (read-status (get-defstruct-slot-read-status slot))
            (type (get-defstruct-slot-type slot)))
        (push (make-canonical-defstruct-slot-form
               name value read-status type)
              answers)))))
  
(defun MAKE-CANONICAL-DEFSTRUCT-SLOT-FORM
    (name value read-status type)
  `( ,(get-dump-form name)
     ,(get-dump-form value)
     :type ,(get-dump-form type)
     :read-only ,(get-dump-form read-status)))

(defun NO-OPTION-BUT-NAME-p (option-list)
  "Inline predicate: "
  ;; KOT put in declare, but what is the use of this??
  (declare (ignore option-list) 
           (inline no-option-but-name-p))
  )

(defun ENSURE-DEFSTRUCT-CLASS-OBJECT (option-list doc-string slots)
  ""
  (when (null doc-string)(setf doc-string ""))
  `(or (find-structure-object ,(get-name-from-option-list option-list))
       (defstruct ,option-list ,doc-string ,@slots)))

;;; KOT couldn't the lambda-list here just be (name &allow-other-keywords)?
(defun MAKE-STRUCTURE-OBJECT (name
                              &key type
                                   lisp-type
                                   (copier nil)
                                   (predicate nil)
                                   (constructor nil)
                                   slots
                                   conc-name
                                   named
                                   include
                                   (documentation ""))
  ""
  `(defstruct ,(make-defstruct-option-list :name name)
     ,documentation ,@slots)
  )

(defun MAKE-DEFSTRUCT-PRINT-FUNCTION (name)
  ""
  (if *use-default-defstruct-options-in-save*
      nil
    (get-defstruct-print-function name)))

(defun MAKE-DEFSTRUCT-COPIER (name)
  ""
  (if *use-default-defstruct-options-in-save*
      (read-from-string (concatenate 'string "COPY-" 
                                     (format nil "~A" name)))
    (get-defstruct-copier name)))

(defun MAKE-DEFSTRUCT-CONSTRUCTOR (name)
  ""
  (if *use-default-defstruct-options-in-save*
      (read-from-string (concatenate 'string "MAKE-" 
                                     (format nil "~A" name)))
    (get-defstruct-constructor name)))

(defun MAKE-DEFSTRUCT-PREDICATE (name)
  ""
  (if *use-default-defstruct-options-in-save*
      (read-from-string (concatenate 'string  
                          (format nil "~A" name) "-P" ))
    (get-defstruct-predicate name)))

(defun MAKE-DEFSTRUCT-CONC-NAME (name)
  ""
  (if *use-default-defstruct-options-in-save*
      (read-from-string (concatenate 'string  
                          (format nil "~A" name) "-" ))
    (get-defstruct-conc-name name)))

;;; KOT couldn't the lambda-list here just be (name &allow-other-keywords)?
(defun MAKE-DEFSTRUCT-OPTION-LIST (&key name
                                        (copier name)
                                        (include name)
                                        (predicate name)
                                        (constructor name)
                                        (conc-name name))
  "" 
  `(,name (:copier ,(make-defstruct-copier name))
          (:include ,(make-defstruct-include name))
          (:predicate ,(make-defstruct-predicate name))
          (:constructor ,(make-defstruct-constructor name))
          (:print-function ,(make-defstruct-print-function name))
          (:conc-name ,(make-defstruct-conc-name name))))

(defun MAKE-FUNCTION-PLACEHOLDER (name)
  ""
  (setf (symbol-function name)
        #'(lambda (&rest ignore) (declare (ignore ignore)) nil)))

(defun STRUCTURE-DUMP-FORM (instance)
  "Independent of vendor: make-defstruct-values was UNquoted."
  `(fill-struct ,(get-instance-label instance)
                (LIST ,@(get-defstruct-values instance))))

(defun DEFSTRUCT-OBJECT-DUMP-FORM (instance)
  "The dump form for defstruct 'classes'."
  (let* ((struct-name (get-defstruct-name instance))
         (option-list (construct-defstruct-option-list struct-name))
         (doc-string (get-defstruct-documentation struct-name))
         (slot-def-list (construct-defstruct-slot-list instance)))
    `(ensure-defstruct-class-object ,(get-dump-form option-list)
                                    ,(get-dump-form doc-string)
                                    ,slot-def-list)))

(defun GET-ORDERED-SLOT-NAMES (I)
  "Returns a list of the slot names of the instance, alphabetized."
  (cond ((instance-p i)(remove nil (sort (all-slotnames i) #'sym<)))
        ((structure-p i)#-excl (get-defstruct-slotnames i)
                        #+excl (%get-defstruct-slotnames i)
                        )
        (T (error "couldnt parse object ~a!" i))))

(defun ALLOCATE-HTAB (htab &rest arglist)
  "Allocates the empty husk of a hash table,
 getting its attributes from the object itself."
  (declare (ignore htab))
  (let ((size (getf arglist :size))
        (rehash-size (getf arglist :rehash-size))
        (test (getf arglist :test))
        (rehash-threshold (getf arglist :rehash-threshold)))
    (make-hash-table :size size 
                     :rehash-size rehash-size 
                     :rehash-threshold 
                     (scale-rehash-threshold rehash-threshold)
                     :test test)))

(defun GET-CLASS-DOCUMENTATION (c)
  ""
  (or (get-documentation c) ""))

(defun GET-AVAILABLE-TYPES (symbol)
  "Returns a list of the types this symbol represents."
  ;; KOT this first (if) creates a special variable 'answers', should the let
  ;; be earlier?? RIGHT, FIXED IT, kvk
  (let ((answers nil))
  (if (not (symbolp symbol))
      (push (type-of symbol) answers)
    (return-from get-available-types answers))
    (if (boundp symbol)(push 'symbol answers))
    (if (fboundp symbol)(push 'function answers))
    (if (classp symbol)(push 'class answers))
    answers))

;;; Vendor independent, PCL/CLOS independent CLOS functions.

(eval-when (load eval compile)

  (defun %GET-SLOT-INITFORM (S)
    "Method to create the initform pair, if there is an initform value!"
    (list :initform (get-dump-form (EVAL (get-slot-initform s)))))

  (defun PAIR-SLOTNAMES (instance)
    "Makes an alist of the slotnames with their 'stripped' values."
    (let ((slots (all-slotnames instance)))
      (pairlis (mapcar #'strip-package slots) slots)))

  (defun FIND-PACKAGED-SLOTNAME (instance stripped)
    "Given the slotname WITHOUT package, find the slotname WITH package."
    (let ((choices (pair-slotnames instance)))
      (rest (assoc stripped choices :test #'equal))))

  (defun SLOT-VALUE-ANY (instance stripped)
    "Find the value of the real slot given the stripped name."
    (let ((slotname (find-packaged-slotname instance stripped)))
      (when slotname (if (slot-boundp instance slotname)
                         (slot-value instance slotname)
                       *unbound-slot-token*))))

  (defun GET-UNSAVEABLE-SLOTNAMES (instance)
    "Returns a list of the slotnames in instance, or the slotnames
 in the class of instance, which have been marked as unsaveable,
 appended to the list of *global-unsaveable-slotnames*"
    (append (copy-list *global-unsaveable-slotnames*)
            (slot-value-any instance 'unsaveable)))

  ) ;; end of pcl/clos eval-when....

#-pcl
(defun GET-DOCUMENTATION (object)
  ""
  (or (documentation object) nil))

(defun GET-INSTANCE-LABEL (instance)
  ""
  (let* ((lists (if (%classp instance)
                    (list *classes-seen* *class-vars*)
                  (case (%type-of instance)
                    (INSTANCE (list *seen* *vars*))
                    (STRUCTURE (list *structs-seen* *struct-vars*))
                    (HASH-TABLE (list *htabs-seen* *htab-vars*))
                    (otherwise (error "Couldnt parse ~a, of type ~a!"
                                      instance (type-of instance)))))))
    (let* ((instance-list (first lists))
           (var-list (second lists))
           (where (position instance instance-list :test #'equal)))
      (if (null where)
          (progn (format t "~a was not on the seen list!, creating!~%"
                         instance)
                 (case (%type-of instance)
                   (INSTANCE 
                    (return-from get-instance-label
                      (get-dump-form (instance-name instance))))
                   (STRUCTURE
                    (return-from get-instance-label
                      (get-dump-form (get-defstruct-name instance))))))
        (return-from get-instance-label  (nth where var-list))))))

(defun DO-VAR-TYPE-CELLS (vars insts)
  "Turns (a b c) and  (1 2 3) into ((a 1)(b 2)(c 3))."
  (mapcar #'(lambda (a b)(list a b))
          vars insts))

(defun MAKE-VAR-TYPE-CELLS (vars insts &optional plists samep)
  "An auxilary function for MAKE-LET-FORM..."
  (let ((htab-plist (if samep (mapcar #'get-dump-form (first plists))))
           (count -1))
    (mapappend
     #'(lambda (cell)
         (incf count)
         (list (list (first cell)
                     (append
                      (list '%allocate-instance 
                            `(QUOTE ,(instance-name (second cell))))
                      (if samep htab-plist
                        (mapcar #'get-dump-form
                                (nth count plists)))))))
     (do-var-type-cells vars insts))))

(defun MAKE-HTAB-PLIST (htab)
  "makes a plist for a hash tables inner attributes!"
  (list :size (hash-table-size htab)
        :rehash-size (hash-table-rehash-size htab)
        :test (hash-table-test htab)
        :rehash-threshold (hash-table-rehash-threshold htab)))

(defun MAKE-HTAB-PLISTS (list-o-htabs)
  "takes a list of htabs: checks to see if the plists are the same,
   multiple value return of the attribute plist(s), and whether they
   are the same (T or NIL)."
  (let ((answers nil)(new-plist nil)) 
    (dolist (htab list-o-htabs answers)
      (setf new-plist (make-htab-plist htab))
      (push new-plist answers))
    (let ((samep (all-htab-plists-samep list-o-htabs)))
      (if samep (values (list (first answers)) T)
        (values answers NIL)))))

(defun MAKE-ILIST-VAR-TYPE-CELLS (to-be-saved-list)
  (declare (ignore to-be-saved-list))
  (delete nil (make-var-type-cells *vars* *seen*)))

(defun MAKE-LIST-VAR-TYPE-CELLS (to-be-saved-list)
  "SEQUENCES need the whole ball of wax."
  (declare (ignore to-be-saved-list))
  (multiple-value-bind (plists samep)
      (make-htab-plists *htabs-seen*)
    (let* ((insts (make-var-type-cells *vars* *seen*))
           (classes (make-var-type-cells *class-vars* *classes-seen*))
           (structs (make-var-type-cells *struct-vars* *structs-seen*))
           (htabs (make-var-type-cells *htab-vars* *htabs-seen*
                                       plists samep))
           (end-result (NCONC classes insts structs htabs)))
      (when *debug-local-bindings* (format t "~%~A~%" end-result))
      (delete nil end-result))))

(defun MAKE-LET-FORM (object &optional other-code)
  "This functions constructs the lexical environment for the text 
   representation of LISP objects --- without this, there could be no self 
   refererence!"
  (cond ((compiled-function-p object)(get-dump-form object))
        ((dotted-list-p object)
         (return-from make-let-form (get-dump-form object)))
        ((simple-list-p object)`(LIST ,@object))
        ((%classp object)
         `(let* ,(make-list-var-type-cells object)
            ,other-code))
        ((equal (%type-of object) 'instance)
         `(let* ,(make-list-var-type-cells object)
            ,other-code))
        ((equal (%type-of object) 'structure)
         `(let* ,(make-list-var-type-cells object)
            ,other-code))
        ((equal (%type-of object) 'hash-table)
         `(let* ,(make-list-var-type-cells object)
            ,other-code))
        ((equal (%type-of object) 'circular-list)
         `(progn ,other-code))
        ((equal (%type-of object) 'vector)
         `(let* ,(make-list-var-type-cells object) ,other-code))
        ((equal (%type-of object) 'array)
         `(let* ,(make-list-var-type-cells object) ,other-code))
        ((cons-p object)
         `(let* ,(make-list-var-type-cells object) ,other-code))
        ;; ((simple-list-p object)`(progn ,other-code))
        ((quoted-list-p object)`(progn ,other-code))
        ((all-instance-list-p object)
         `(let* ,(make-ilist-var-type-cells object)
            ,other-code))
        ((LISTP object)
         `(let* ,(make-list-var-type-cells object) 
            ,other-code))
        (T (warn "FROM MAKE LET FORM: object was of bogus type: ~A!!!"
                 (%type-of object))
           (if other-code `(progn ,other-code)
             (progn (warn "there was no code to enclose!") nil)))))

(defun MAP-NONCIRCULAR-ELEMENTS-AND-COPY (function circ-list)
  ""
  (let ((elts (mapcar function
                      (copy-list (get-circular-list-elements circ-list)))))
    (make-circular-list elts)))

(defun MAP-OBJECT (function object)
  "Generalized iterator for PCOs."
  (cond ((circular-list-p object)
         (map-noncircular-elements-and-copy function object))
        ((vectorp object)
         #-(or akcl excl) ;; Lucid, Symbolics, CMU OK.
         (loop for count from 0 to (1- (length object)) do
               (setf (aref object count)
                 (funcall function (aref object count)))
             finally (return object))
         #+(or akcl excl)
         (dotimes (count (1- (length object)) object)
           (setf (aref object count)(funcall function (aref object count))))
         )
        ((arrayp object)(map-array function object))
        ((structure-p object)(mapstruct function object))
        ((hash-table-p object)(maphash #'(lambda (key val)
                                           (setf (gethash key object)
                                             (funcall function val)))
                                       object) object)
        ((instance-p object)(map-instance function object))
        (T (warn "Couldnt deal with object ~a, type: ~a.~%"
                 object (type-of object)))))

;;; Functions and Generic Functions.

#+mcl
(eval-when (load eval compile)

  (defun GET-SLOT-NAME (s)
    (ccl::slot-definition-name s))

  (defun GENERIC-FUNCTION-NAME (instance)
    (get-compiled-function-name instance))

  (defun GENERIC-FUNCTION-LAMBDA-LIST (gf)
    ""
    (function-lambda-expression gf))

  (defun %GENERIC-FUNCTION-P (X)
    ""
    (ccl::standard-generic-function-p x))

  (defun METHOD-SPECIALIZERS (method)
    ""
    (ccl:specializer-direct-generic-functions method))

  (defun METHOD-GENERIC-FUNCTION (gf)
    ""
    (ccl:method-generic-function gf))

  ) ;; end of MCL function & generic function eval-when!

#+allegro-v4.0
(eval-when (load eval compile)

  (defun HASH-TABLE-TEST (htab)
    #'eql)

  (defun HASH-TABLE-SIZE (htab)
    32)

  ) ;; end of allegro ver 4.0 eval-when....

(defun PARSE-HASH-TABLE-SPEC (htab)
  (let ((ans nil)
        (*readtable* (copy-readtable)))
    (set-dispatch-macro-character #\# #\' (function pseudo-quote-reader))
    (set-dispatch-macro-character #\# #\< (function pseudo-quote-reader))
    (setq ans (rest (butlast (read-from-string 
                              (concatenate 'string "(" 
                                           (subseq (format nil "~a" htab) 8)
                                           ")")))))
    ans))

(defun PARSE-DEFSTRUCT-SPEC (struct)
  (let ((ans nil)
        (*print-readably* t)
        (*readtable* (copy-readtable)))
    (set-dispatch-macro-character #\# #\' (function pseudo-quote-reader))
    (set-dispatch-macro-character #\# #\< (function pseudo-quote-reader))
    (set-dispatch-macro-character #\# #\S (function pseudo-quote-reader))
    (setq ans (subseq (format nil "~a" struct) 3))
    (setq ans (subseq ans 0 (position #\space ans)))
    (read-from-string ans)))

(defun GET-DEFSTRUCT-NAME (instance)
  "Given a defstruct instance, return the symbol which is its name."
  ;; This is an ugly way of doing this, and relies on the print-function
  ;; correctly taking *print-readably* into account.
  ;;(parse-defstruct-spec instance)
  ;; Kerry suggests just changing to this, though he says not always correct
  ;; KOT -- how could this not be correct??
  (type-of instance)
  )

#+rel8
(defun HASH-TABLE-REHASH-SIZE (x)
  ""
  (future-common-lisp:hash-table-rehash-size x))

#+rel8
(defun HASH-TABLE-REHASH-THRESHOLD (x)
  ""
  (future-common-lisp:hash-table-rehash-threshold x))

#+cmu
(eval-when (load eval compile)
  (when (not (fboundp 'hash-table-test))
    (defun HASH-TABLE-TEST (htab)
      ""
      #'eql)
    )
  (when (not (fboundp 'hash-table-size))
    (defun HASH-TABLE-SIZE (htab)
      ""
      101)
    )
  ) ;; end of cmu eval-when...

#+akcl
(eval-when (load eval compile)
  (when (not (fboundp 'hash-table-test))
    (defun HASH-TABLE-TEST (htab)
      ""
      #'eq)
    )
  (when (not (fboundp 'hash-table-rehash-size))
    (defun HASH-TABLE-REHASH-SIZE (htab)
      ""
      101)
    )
  (when (not (fboundp 'hash-table-rehash-threshold))
    (defun HASH-TABLE-REHASH-THRESHOLD (htab)
      ""
      0.5)
    )
  ) ;; end of AKCL hash table eval-when...

#+rel-7-2
(defun HASH-TABLE-REHASH-SIZE (x)
  ""
  (let ((spec (parse-hash-table-spec x)))
    (getf spec :rehash-size 32)))

#+rel-7-2
(defun HASH-TABLE-REHASH-THRESHOLD (x)
  ""
  (let ((spec (parse-hash-table-spec x)))
    (getf spec :rehash-threshold 0.5)))

(defun UNBOUND-SLOT-TOKEN-P (x)
  "Predicate: "
  (and (symbolp x)(equal x *unbound-slot-token*)))

  (defun FILL-INSTANCE (classname vals)
    "New: allocates an instance given classname, the vals are the alphabetized 
     list of slot values extracted from the target instance. returns the 
     newly filled in instance."
    (let* ((new (%allocate-instance classname)))
      (%fill-instance new vals)
      new))

  #-pcl
  (defun %ALLOCATE-INSTANCE (class-object &rest htab-plist) 
    (cond ((instance-p class-object) class-object)
          ((equal class-object 'HASH-TABLE)
           (allocate-htab class-object 
                          :size (getf htab-plist :size 5000)
                          :rehash-size (getf htab-plist :rehash-size 67)
                          :rehash-threshold (getf htab-plist
                                                  :rehash-threshold 0.67)
                          :test (getf htab-plist :test #'eql)))
          ((symbolp class-object)
           ;; KOT hackery -- Allegro 
           #+(or allegro-v4.1 allegro-v4.2)
           (let ((class (find-class class-object nil)))
             (cond
              ((and class (eq (type-of class) 'structure-class))
               (allocate-struct class-object))
              (class (clos::allocate-instance class))))
           #-(or allegro-v4.1 allegro-v4.2)
           (let ((class-object (find-class class-object nil)))
             (when class-object
               #-(or pcl aclpc)
               (clos::allocate-instance class-object)
               #+pcl (pcl::allocate-instance class-object)
               #+aclpc(allocate-instance class-object)
               )))
          ((%structure-p class-object)
           #-(or aclpc pcl excl)(clos::allocate-instance class-object)
           #+cmu (pcl::allocate-instance class-object)
           #+aclpc (allocate-instance class-object)
           #+allegro-v4.0(%%allocate-instance class-object)
           #+(or allegro-v4.1 allegro-v4.2)(allocate-struct class-object)
           )
          (T (when *debug-instance-storage*
               (format t "now trying to allocate an instance for ~a!" 
                       class-object))
             nil)))

;;;  *** Beginning of CLOS eval-when... ***

#+clos 
(eval-when (load eval compile)

  (defun CLASSP (x)
    "Predicate, determines whether the object x is a class object."
    (typep x 'standard-class))

  ;; KOT this gets done later as more complex thing for excl, why duplicate??
  (defun %CLASSP (x)
    "Predicate, determines whether the object x is a class object."
    (classp x))

  ;; KOT this gets done later for allegro-v4, maybe conditionalize here??
  ;; NOTE: this one should really have a test to include CLASSES? kvk
  #-(or mcl :allegro-v4.0 :allegro-v4.1 :allegro-v4.2)
  (defun INSTANCE-P (x)
    ""
    (and (NOT (%CLASSP x)) ;;; new clause of test, kvk
         (typep x 'standard-object)))

  ;; ALLOCATE INSTANCE methods on STRUCTURE CLASS, for those which dont have
  ;; them.

  #+allegro-v4.0
  ;; KOT this eval-when is redundant -- maybe just progn?  That's obscure
  ;; questions of what should be at top-level and what shouldn't ...
  (eval-when (load eval compile)

    (defmethod CLOS::ALLOCATE-INSTANCE ((self clos:structure-class) 
                                        &rest initargs)
      (declare (ignore initargs))
      (allocate-struct (instance-name self)))

    (defmethod %%ALLOCATE-INSTANCE ((self clos:structure-class))
      (allocate-struct (instance-name self)))

    (defmethod %%ALLOCATE-INSTANCE ((self symbol))
      (if (get-symbol-defstruct-spec self)
          (allocate-struct self)))

    (defmethod CLOS::ALLOCATE-INSTANCE ((self symbol) &rest init-plist)
      (allocate-struct self))

    ) ;; end of allegro ver4.0 eval-when...

  ;; *** BEGINNING OF NON-MCL definitions! ***

  #-(or akcl mcl pcl) 
  (eval-when (load eval compile)

    (defun GET-CLASS-DEFAULT-INITARGS (class)
      "Gets the default-initargs out of the class object."
      (mapcan #'(lambda (l)
                  (list (first l)(get-dump-form (third l))))
              #-aclpc(clos::class-direct-default-initargs class)
              #+aclpc(class-direct-default-initargs class)
              ))

    (defmethod ALL-SLOTNAMES ((instance T) &optional (all-allocations T))
      "returns the names of the slots in instance, uses what MOP stuff
   is available."
      ;; KOT put this in, probably just there for lambda-list equivalency
      (declare (ignore all-allocations))
      #-aclpc
      (mapcar #'clos::slot-definition-name 
              ;; KOT patch
              ;;(clos::class-DIRECT-slots (clos::class-of instance))
              (clos::class-slots (clos::class-of instance))
              )
      #+aclpc
      (mapcar #'slot-definition-name 
              (class-DIRECT-slots (class-of instance)))
      )
    ;;******

    ) ;; end of non-MCL definitions eval-when...

  ;; *** Allegro non-MCL eval-when (e.g. on Suns.) ***

  #+excl
  (eval-when (load eval compile)

    (defun GET-SLOT-READERS (slot-object)
      (clos::slotd-readers slot-object))

    (defun GET-SLOT-WRITERS (slot-object)
      (clos::slotd-writers slot-object))

    (defun GET-SLOT-ALLOCATION (S)
      "Method to get the type of allocation from a standard slot: 
       one of :CLASS or :INSTANCE."
      (let ((alloc (clos::slotd-allocation s)))
        (cond ((%classp alloc) :CLASS)
              ((member alloc '(:INSTANCE :CLASS)) alloc) 
              (T :INSTANCE))))

    (defun GET-SLOT-NAME (S)
      "Method to get the name from a standard slot."
      (clos::slotd-name s))

    (defun %CLASSP (X)
      "Predicate, determines whether the object x is a class object."
      (or (typep x 'clos::standard-class)(typep x 'clos::built-in-class)))

    (defmethod GET-SLOT-INITFORM (s)
      ""
      (when (slot-boundp s 'clos::initform)
        (clos::slotd-initform s)))

    (defun SLOT-HAS-AN-INITFORM-P (s)
      (clos::slotd-initform s))

    (defun GET-SLOT-INITARGS (s)
      (clos::slotd-initargs s))

    (defun GET-SLOT-INITARG (s)
      (first (clos::slotd-initargs s)))

    (defun BUILTIN-CLASS-P (X)
      "Predicate to determine whether class object is a builtin class. returns
       T if it is."
      (and (%classp x)(typep x 'clos::built-in-class)))

    #+(or allegro-v4.1 allegro-v4.2)
    (defun INSTANCE-P (X)
      "With the 4.0 series, structures are instances as well: exclude these."
      (and (not (typep x 'clos::structure-class))
           (not (%classp x))(excl::standard-instance-p x)))

    #+allegro-v4.0
    (defun INSTANCE-P (X)
      "With V4.0, structures are instances as well: exclude these:
       NOTE, removed the clause testing for clos:structure-object."
      (not (%classp x))(excl::standard-instance-p x))

    (defun GET-SLOT-DOCUMENTATION (s)
      ""
      (or (documentation s) ""))

    ) ;; *** end of non-MCL Allegro (like Sun Allegro) CLOS eval-when. ***

  ;; *** Lisp Machine Genera 8.x CLOS eval-when. ***

  #+lispm
  (eval-when (load eval compile)

    (defun ALL-SLOTS (instance)
      "Gets all the slots from the instances class, whether inherited or not."
      (clos::class-slots (clos::class-of instance)))

    (defun GET-SUPERCLASS-NAMES (class)
      ""
      (mapcar #'clos::class-name (clos::class-direct-superclasses class)))

    (defun %GENERIC-FUNCTION-P (x)
      "Predicate, returns t for generic functions. causes symbol conflict 
       problem in genera 8.0."
      (clos-internals::generic-function-p x))

    (defun BUILTIN-CLASS-P (class-object)
      "Predicate to determine whether a class object (that which is returned 
      by (FIND-CLASS <NAME>)) is a BUILTIN class or not."
      (typep class-object 'clos:built-in-class))

    (defmethod CLASS-NAME ((object t))
      "We use this in %classp. we already know its either an instance or a 
      class. if its an instance, it has no name. CLASS-NAME on standard class 
      takes care of real class objects."
      nil)

    (defun %CLASSP (X)
      "The function CLASSP is not defined at all in Genera."
      (and (instance-p x)(find-class (class-name x) nil)))

    (defun INSTANCE-P (x)
      "This will work in Genera 8x CLOSes: filters out entities that are 
      flavor instances. Also filters out things that are defstruct instances."
      (and (sys:instancep x)(not (flavor:find-flavor (type-of x) nil))))

    (defun GET-SLOT-TYPE (S)
      "This will work for Genera 8x CLOSses."
      (clos:slot-definition-type s))

    (defun GET-DIRECT-SLOTS (class-object)
      ""
      (clos:class-direct-slots class-object))

    (defun GET-SLOT-NAME (S)
      "Method to get the name from a standard slot."
      (clos::slot-definition-name s))

    (defun SLOT-HAS-AN-INITFORM-P (slot-object)
      (clos::slot-definition-initform slot-object))

    (defun GET-SLOT-READERS (slot-object)
      (clos::slot-definition-readers slot-object))

    (defun GET-SLOT-WRITERS (slot-object)
      (clos::slot-definition-writers slot-object))

    (defun GET-SLOT-NAMED (instance name)
      (find-if #'(lambda (slot)(equal (get-slot-name slot) name))
               (all-slots instance)))

    (defun GET-SLOT-ALLOCATION (S)
      "Method to get the type of allocation from a standard slot: oneof :CLASS
      or :INSTANCE."
      (let ((alloc (clos::slot-definition-allocation s)))
        (cond ((%classp alloc) :CLASS)
              ((member alloc '(:INSTANCE :CLASS)) alloc) 
              (T :INSTANCE))))

    (defmethod GET-SLOT-INITFORM (s)
      ""
      (when (slot-has-an-initform-p s)(clos::slot-definition-initform s)))

    (defun GET-SLOT-INITARGS (s)
      (clos::slot-definition-initargs s))

    (defun GET-SLOT-INITARG (s)
      (first (clos::slot-definition-initargs s)))

    ) ;; end of Genera 8x CLOS eval-when.

  ;; Lucid CLOS eval when...

  #+lucid
  (eval-when (load eval compile)

    (defun GET-SUPERCLASS-NAMES (class)
      "Expects the object returned by FIND-CLASS."
      (mapcar #'clos::class-name (clos::class-direct-superclasses class)))

    (defun INSTANCE-P (x)
      "Alternate def as a function for lucid 4.0."
      (and (system:standard-object-p x)(not (system:classp x))))

    (defun GET-SLOT-DOCUMENTATION (s)
      ""
      (or (clos::slotd-documentation s) ""))

    (defun GET-SLOT-NAME (S)
      "Method to get the name from a standard slot."
      (clos::slotd-name s))

    (defun GET-SLOT-READERS (slot-object)
      (clos::slotd-readers slot-object))

    (defun GET-SLOT-WRITERS (slot-object)
      (clos::slotd-writers slot-object))

    (defun GET-SLOT-ALLOCATION (S)
      "Method to get the type of allocation from a standard slot: oneof 
      :CLASS or :INSTANCE."
      (let ((alloc (clos::slotd-allocation s)))
        (cond ((%classp alloc) :CLASS)
              ((member alloc '(:INSTANCE :CLASS)) alloc) 
              (T :INSTANCE))))

    (defun %CLASSP (X)
      "CLASSP is not exported in Lucid or EXCL, and is not defined at all in 
      Genera!"
      (clos::classp x))

    (defmethod GET-SLOT-INITFORM (s)
      ""
      (when (slot-boundp s 'clos::initform)
        (clos::slotd-initform s)))

    (defun SLOT-HAS-AN-INITFORM-P (s)
      ""
      (slot-boundp s 'clos::initform))

    (defun GET-SLOT-INITARGS (s)
      (clos::slotd-initargs s))

    (defun GET-SLOT-INITARG (s)
      (first (clos::slotd-initargs s)))

    (defun BUILTIN-CLASS-P (X)
      "Predicate to determine whether a class object is a builtin class. 
      returns T if it is."
      (and (%classp x)(member (%class-name x)
                              (mapcar #'first clos-system::built-in-classes) 
                              :test #'equal)))

    ) ;; *** end of Lucid CLOS eval-when. ***
  )

;;; THE END OF THE CLOS EVAL-WHEN....

(defun CLEAR-SAVE-OBJECT ()
  "shorthand to clear the environment."
  (clear-global-vars-and-htabs)
  )

(defun WRITE-GLOBAL-HEADER (stream symbol min max
                            &optional (pkg-name (package-name *package*)))
  (format stream (format nil "~%(EVAL-WHEN (LOAD EVAL COMPILE)
                       (DATABASE:MAKESYMS '~A ~A ~A ~s))~%"
                         symbol min max pkg-name)))

#+mcl
(defun BUILTIN-CLASS-p (X)
  "Predicate to determine whether a class object is a built-in class: this 
  should be the generic definition of this one."
  (cond ((and (symbolp x)(find-class x nil))
      (equal (class-name (class-of (find-class x))) 'built-in-class))
      ((classp x)
       (or (typep x 'built-in-class)
           (equal (class-name (class-of x)) 'built-in-class)))
      ((builtin-class-p (type-of x)))
      (T NIL)))

(defun ADMISSIBLE-CONSTANT-P (X)
  "Predicate: returns T if x is symbol, number, or keyword."
  (or (stringp x)
      (null x)
      (equal x T)
      (pathnamep x)
      (numberp x)
      (keywordp x)
      (characterp x)))

(defun ALL-NUMBERS-LIST-P (X)
  (and (listp x)(%every #'numberp x)))

(defun SIMPLE-LIST-P (X)
  "Predicate: returns t if every element of a list X is an admissible constant"
  (and (not (cons-p x))
       (listp x)
       (not (circular-list-p X))
       (%every #'admissible-constant-p x)))

;;; Quoted lists.

(defun SIMPLE-QUOTED-LIST-P (X)
  "Predicate, if somethings a quoted list...."
  (and (not (cons-p x))
       (listp x)
       (not (circular-list-p x))
       (not (%every #'null x))
       (%every #'(lambda (sub)(and (not (special-marker-p sub))
                                   (or (numberp sub)
                                       (characterp sub)
                                       (not (listp sub))
                                       (stringp sub)
                                       (symbolp sub))))
               x)))

(defun SAME-KEYWORDS-P (p1 p2)
  "Predicate:"
  (if (or (not (listp p1))(not (listp p2))) nil
    (sameset (get-evens p1)(get-evens p2))))

(defun SAME-PLIST-VALUES-P (p1 p2)
  "Use mapplist from the MOP book!"
  (let ((kwds1 (get-evens p1))
        (kwds2 (get-evens p2)))
    (if (not (sameset kwds1 kwds2))
        nil
      (dolist (kwd kwds1 T)
        (when (not (equal (getf p1 kwd)(getf p2 kwd))) (return nil))))))

(defun UNORDERED-PLIST-EQUAL (p1 p2)
  "predicate to tell if plist keywords & values are equal,
 regardless of attribute pair ordering."
  (and (same-keywords-p p1 p2)(same-plist-values-p p1 p2)))

(defun ALL-HTAB-PLISTS-SAMEP (htab-plist-list)
  "Predicate: does set equality on plists."
  (%every #'(lambda (plist)(unordered-plist-equal plist
                                                  (first htab-plist-list)))
          (rest htab-plist-list)))

(defun ARRAY-TYPE-T-P (X)
  "Predicate, checks type and element-type of x."
  (and (arrayp x)(not (stringp x))(equal (array-element-type x) T)))

(defun ALL-NULLS-P (X)
  (%every #'null x))

(defun ALL-TS-P (X)
  (%every #'(lambda (y)(equal y t))
          x))

(defun SIMPLE-LEX-LIST-P (X)
  (and (not (cons-p x))
       (listp x)
       (not (all-nulls-p x))
       (not (all-ts-p x))
       (not (circular-list-p x))
       (%every #'(lambda (e)
                   (or (special-marker-p e)
                       (admissible-constant-p e)))
               x)))
#|
  (defun %CONS-P (X)
    "Internal dotted list predicate..."
  (and (not (null (%list-length x)))
  (listp x)
  (atom (cdr (last x)))
  (not (null (cdr (last x))))))

  (defun CONS-P (x)
  "ingenious predicate for testing whether something is a cons cell vs. a list.
   note that this returns nil for (LIST 'A 'B) whereas it returns T for
   (CONS 'A 'B)."
  (cond ((not (listp x)) NIL)
    ((and (listp x)(null (%list-length x))) nil)
  ((or (%cons-p x)(and (listp x)(null (listp (rest x))))) T)
  (T NIL)))
  |#

(defun %CONS-p (X)
  (and (listp x)(null (listp (cdr x)))))

(defun CONS-p (x)
  (%cons-p x))

#-kcl
(eval-when (load eval compile)

  (defun ALL-INSTANCE-LIST-P (x)
    "Predicate for a list containing only instances!"
    (and (listp x) (%every #'instance-p x)))

  (defun UNSAVEABLE-SLOT-P (slot instance)
    "Predicate returns t if the slotname SLOT is marked as USAVEABLE
    for instances of the type of instance."
    (or (member slot *global-unsaveable-slotnames* :test #'equal)
        (member slot (get-unsaveable-slotnames instance) :test #'equal)))

  )

(defun UNSAVEABLE-SLOT-TOKEN-P (X)
  "Predicate"
  (declare (inline unsaveable-slot-token-p))
  (equal x *unsaveable-slot-token*))

(defun CIRCULAR-CONS-P (X)
"Predicate: returns t if <x> is a real cons (not list!) and it is circular."
  (and (cons-p x)(eq (rest x) x)))

(defun CIRCULAR-CONS-DUMP-FORM (instance)
  `(let ((first ,(get-dump-form (list (first instance)))))
     (setf (rest first) first)))

(defun SLOT-EXISTS-P-ANY (instance name)
  "returns t if the slotname exists with any package designator."
  (let ((slots (mapcar #'strip-package (all-slotnames instance))))
    (member (strip-package name) slots :test #'equal)))

(defun STRIP-PACKAGE (x)
  "strip the package designator off the symbol, return the rest,
  if keyword, return self.."
  (if (keywordp x) x
    (intern (symbol-name x))))

#-aclpc
(defun %CIRCULAR-LIST-P (X)
  "Predicate to determine if something is a circular list, uses
  LIST-LENGTH, which, unlike LENGTH, terminates and returns NIL if
  the list is circular: LIST-LENGTH may not be in all versions of
  LISP, as it is CLtL2: CHANGED TO INCLUDE THE RECURSIVE DEFINITION
  OF CIRCULAR LISTS."
  (cond ((not (listp x)) nil)
        ((cons-p x) nil)
	(T (multiple-value-bind (len is-circ)
				(%circular-list-length x)
				(declare (ignore len))
				is-circ))))

;;; NOTE: the only ones which dont seem to have IGNORE-ERRORS is
;;; AKCL and ACL\PC.

#+(or akcl aclpc)
(defmacro IGNORE-ERRORS (&body body)
  `(progn . ,body))

;;; MODIFIED for 9X: MCL def changed to simple version...
;;; differentiate between circular lists and circular conses!

#+mcl
(defun CIRCULAR-LIST-P (x)
(cond ((cons-p x) nil)
       ((not (listp x)) nil)
      ((circular-cons-p x) nil)
      ((and (listp x)(null (list-length x))) T)
      (T NIL)))

#-(or mcl aclpc)
(defun CIRCULAR-LIST-P (x)
  "The point of having the ignore errors is if the some clause of
  %circular-list-p encounters a dotted list, it will barf, ignore-erros
  prevents the barf and just returns a multiple value of nil and error."
  (ignore-errors (%circular-list-p x)))

#+aclpc

(defun CIRCULAR-LIST-P (x)
;; listp doesnt break on clists in ACL\PC.
(and (listp x) (null (list-length x))))

#-lucid
(defun CIRCULAR-LIST-DUMP-FORM (clist)
  ""
  (let ((ones (get-dump-form (get-circular-list-elements clist))))
    `(make-circular-list ,ones)))

#+lucid
(defun CIRCULAR-LIST-DUMP-FORM (clist)
"NEW for 9X Lucid:"
  (list-dump-form (collect-circ-elements clist)))

(defun CIRCULAR-DOTTED-LIST-DUMP-FORM (clist)
  ""
  (let ((ones (get-circular-list-elements clist)))
    `(make-circular-dotted-list ,ones)))

(defun CIRCULAR-LIST-EQUAL (a b)
  ""
  (and (equal (circular-list-length a)(circular-list-length b))
       (equal (get-circular-list-elements a)(get-circular-list-elements b))))

(defun STREAM-P (x)
  "Avoids problems with vendor-made type confusion."
  (and (not (%classp x))(streamp x)))

(defun REPEATING-ELEMENT-LIST-P (instance)
  ""
  (if (not (listp instance)) nil)
  (if (< (%length instance) *make-list-length-threshold*) nil
    (let ((test (first instance)))
      (%every #'(lambda (e)(equal e test)) instance))))

(defun SPECIAL-MARKER-P (X &optional (label ".%%SL%%."))
  "label must match with pushsym, and must be upper-case."
  (and (symbolp x)(search label (format nil "~A"  x) :test #'equal)))

(defun QUOTED-LIST-P (x)
  "Predicate, if somethings a quoted list. May contain sublists."
  (and (not (cons-p x))
       (listp x)
       (not (circular-list-p x))
       (not (%every #'null x))
       (%every #'(lambda (sub)(or (numberp sub)
                                  (characterp sub)
                                  (stringp sub)
                                  (AND (symbolp sub)
                                       (not (special-marker-p sub)))
                                  (quoted-list-p sub)
                                  ;; (not (listp sub))
                                  ))
               x)))

(defun %ENDP (element &optional parent-list)
  "Modified definiton of ENDP:
 checks to see if the parent list is a dotted list, then
 compares the last of parent with element, returns t if they are equal.
 multiple-value return is whether the elemnt is the end of parent list,
 and if the parent lst is dotted or not."
  (if (dotted-list-p parent-list)(values (equal (last parent-list) element)
                                         T)
    (values (endp element) NIL)))

(defun CIRCULAR-DOTTED-LIST-P (X)
"Predicate, returns t if x is a dotted list, and it is also a circular list."
  (and (dotted-list-p x)(circular-list-p x)))

(defun %LAST (p)
  (cond ((null p) nil)
        ((NOT (LISTP P)) P)
        ((circular-list-p p)(cons 
                             (first (reverse (get-circular-list-elements p)))
                             p))
        (T (last p))))

(defun DOTTED-LIST-P (x)
  "MODIFIED: Predicate which returns T if something is a dotted list.
 NIL is NOT a dotted list!"
  (and (listp x)
#-mcl(cons-p (%last x))
#+mcl(cons-p (%last x))
))

(defun %%LIST-LENGTH (x)
  "Differs from ClTl2 LIST-LENGTH in that a multiple value return of
  NIL and counter value are returned if its a circular list:
  uses %ENDP instead of ENDP to deal with dotted lists."
  (do (( n 0 (+ n 2))
       (fast x (cddr fast))
       (slow x (cdr slow)))
      (nil)
    (when (endp fast)(return (values nil n)))
    (when (endp (cdr fast))(return (values nil (1+ n))))
    (when (and (eq fast slow)(> n 0))(return (values T (/ n 2))))))

(defun %LIST-LENGTH (x)
  "Differs from ClTl2 LIST-LENGTH in that a multiple value return of
  NIL and counter value are returned if its a circular list:
  uses %ENDP instead of ENDP to deal with dotted lists."
  (cond ((cons-p x)(length x))
        ((listp x)(do (( n 0 (+ n 2))
                       (fast x (cddr fast))
                       (slow x (cdr slow)))
                      (nil)
                    (multiple-value-bind (ended dotted)
                        (%endp fast x)
                      (when ended (if dotted (return (values (+ n 2) nil))
                                    (return (values n nil)))))
                    (multiple-value-bind (ended dotted)
                        (%endp (cdr fast) x)
                      (when ended (if dotted (return (values (+ n 3) nil))
                                    (return (values (1+ n) nil)))))
                    (when (and (eq fast slow)(> n 0))
                      (return (values nil (/ n 2))))))
        (T (values nil nil))))

(defun FIRSTN (n list)
  "Return the first n elements of a list."
  (let ((answers nil))
    (dotimes (count (1- n) answers)
      (push (nth count list) answers))
    (nreverse answers)))

;;; Support for dealing with circular lists...

(defun GET-CIRCULAR-LIST-ELEMENTS (circular-list)
  "MODIFIED: Given a circular list, get the repeating pattern."
  (if (circular-list-p circular-list)
      (let ((len (%circular-list-length circular-list)))
        (when (numberp len)
          (firstn (1+ len) circular-list)))
    circular-list))

(defun MAKE-CIRCULAR-LIST (elts)
  "Given non circular list elements elts, return a circular list of those 
  elements."
  (rest (rplacd (last elts) elts)))

(defun MAKE-CIRCULAR-DOTTED-LIST (dl)
  ""
  (let* (
         ;; KOT commented both these out, not used.
         ;; (elts (get-dump-form (get-circular-list-elements dl)))
         ;;(dotted (eval `(LIST* ',@elts)))
         )
    ;; KOT x --> dl typos fix.
    (rest (rplacd (last dl) dl))))

(defun %CIRCULAR-LIST-LENGTH (circ &optional (len 0)(already-seen nil))
  ""
  (cond ((null circ)(values len nil))
        ((member circ already-seen :test #'eq)(values len T))
        ((member (first circ) already-seen :test #'eq)(values len T))
        (T (%circular-list-length (rest circ)(incf len)
                                  (append already-seen (list (first circ)))))))

(defun CIRCULAR-LIST-LENGTH (clist)
  "Given a circular list, returns the number of non-circular elements before 
  cycle: returns an error if this is not a circular list!"
  (multiple-value-bind (status length)
      (%list-length clist)
    (when status  ;;;; (warn "this is not a circular list!")
	  (return-from circular-list-length (length clist)))
    length))

(defun COLLECT-CIRC-ELEMENTS (clist)
"NEW: Just creates a list with the (non-repeating) list length of elements."
  (loop for count from 0 to (1- (circular-list-length clist))
	collect (nth count clist)))

(defun LIST-TYPE (X)
  (cond ((not (listp x))
         (format t "error: ~a is not a list~%" x))
        ((cons-p x) 'cons)
        ((simple-list-p x) 'simple)
        ((quoted-list-p x) 'quoted)
        (T 'ordinary)))

(defun MAKE-SYM (x)
  (if (keywordp x)
      (read-from-string (subseq (symbol-name x) 0))
    x))

(defun GET-EVENS (l)
  (let ((answers nil))
    (dotimes (count (1- (length l)) answers)
      (if (evenp count)(push (nth count l) answers)))
    (nreverse answers)))

(defun GET-ODDS (l)
  (let ((answers nil))
    (dotimes (count (1- (length l)) answers)
      (if (oddp count)(push (nth count l) answers)))
    (nreverse answers)))

(defun SYM< (a b)
  "Predicate to see if symbol a is alphabetically before symbol b. T if a is."
  (string< (format nil "~A" A)(format nil "~A" b)))

(defun SYMF< (a b)
  "Predicate to see if symbol a is alphabetically before symbol b. T if a is."
  (string< (format nil "~A" (FIRST A))(format nil "~A" (first b))))

(defun ALPHABETIZE-BY-KEYWORD (lst)
  ""
  (let ((alpha-cells (sort (pair-up lst) #'symf<)))
    (mapcar #'second alpha-cells)))

#+lucid
(defun MAP-ARRAY (function array)
  "like mapcar, but maps a function over each element of an
  n-dim array: the function to be applied is a function of two args,
  the count and the element value at aref count in the array."
  (let* ((vec (sys:underlying-simple-vector array)))
    (map-into vec function vec)
    array))

;;;      (len (1- (length vec))))
;;;(loop for count from 0 to len do (setf (aref vec count)
;;;  (funcall function count (aref vec count)))
;;;  finally (return array))))                           

#+lucid
(defun FILL-ARRAY (array l)
  "Fill n-dimensional array with values from list."
  (let* ((vec (sys:underlying-simple-vector array))
         (len (1- (length vec)))
         (data (flatten l)))
    (loop for index from 0 to len 
        do (setf (aref vec index)(nth index data))
        finally (return array))))                                

#-(or lispm lucid akcl excl)
(defun FILL-ARRAY (array l)
  "Fill n-dimensional array with values from list."
  (let ((list (flatten l)))
    (if (= 1 (length (array-dimensions array)))
        (loop for count from 0 to (1- (length array)) do
              (setf (aref array count)(nth count list))
            finally (return-from fill-array array))
      (progn (dotimes (i (array-total-size array) array)
               (setf (row-major-aref array i)(nth i list)))
             (return-from fill-array array)))))

#+excl
(defun FILL-ARRAY (array l)
  "Fill n-dimensional array with values from list."
  (let ((list (flatten l)))
    (dotimes (i (array-total-size array) array)
      (setf (row-major-aref array i)(nth i list)))
    (return-from fill-array array)))

#+lispm
(defun FILL-ARRAY (array l)
  "Fill n-dimensional array with values from list."
  (let ((list (flatten l))(array array))
    (declare (sys:array-register array))
    (if (= 1 (length (array-dimensions array)))
        (loop for count from 0 to (1- (length array)) do
              (setf (si:%1d-aref array count)(nth count list))
            finally (return-from fill-array array))
      (progn  (dotimes (i (array-total-size array) array)
                (setf (row-major-aref array i)(nth i list)))
              (return-from fill-array array)))))

(defvar *debug-array-operations* t)


(defun ARRAY-ELEMENTS-SAME-P (array)
  "Predicate, returns t if every element of an n-dimensional array
 is the same, NIL otherwise."
  (let ((current nil))
    (map-array #'(lambda (count element)
                   (declare (ignore count))
                   (if (null current)
                       (setf current element)
                     (if (equal element current) nil
                       (return-from array-elements-same-p nil))))
               array)
    (return-from array-elements-same-p T)))

#-lucid
(defun MAP-ARRAY (function array)
  "like mapcar, but maps a function over each element of an
   n-dim array: the function to be applied is a function of two args,
   the count and the element value at aref count in the array."
  (let ((array array))
    #+lispm (declare (sys:array-register-1d array))
    (if (= 1 (length (array-dimensions array)))
        (dotimes (count (1- (length array)) array)
          #+lispm(setf (sys:%1d-aref array count)
                   (funcall function count (sys:%1d-aref array count)))
          #-lispm(setf (aref array count)
                   (funcall function count (aref array count)))
          )
      ;; this is the multi-dimensional array clause.....
      (progn  (dotimes (i (array-total-size array) array)
                (setf (row-major-aref array i)
                  (funcall function i (row-major-aref array i))))
              (return-from map-array array)))))

;;; CLOS/PCL independent class accessor methods.

(eval-when (load eval compile)

  (defun DO-SPECIALIZER (spec)
    "Map objects to class names."
    (cond ((SYMBOLP SPEC) spec)
          ((%CLASSP SPEC)`(FIND-CLASS ',(%class-name spec)))
          (T SPEC)))

  (defun DO-SPECIALIZERS (lst)
    (let ((answers nil))
      (dolist (spec lst answers)
        (setf answers (append (list (do-specializer spec)))))
      answers))

  (defun GENERATE-CLASS-SLOT-FORMS (class)
    "This generates dump forms for all the slots in the class object."
    (let ((slots nil))
      (dolist (slot (class-slots class) slots)
        (setf slots (append slots 
                            (list (generate-class-slot-form slot)))))
      slots))

  ) ;; end of class-save eval-when.

#+pcl
(format t "COPY INSTANCE NOT DEFINED for PCL!")

#-(or cmu kcl)
(defmethod COPY-INSTANCE ((instance T))
  "Provides shallow copying of any instance: returns a new copy of a 
  given clos instance, writ as a method so youse gys can write ur own."
  (let* ((copy (make-instance (instance-name instance)))
            (slots (all-slotnames instance)))
    (dolist (slot slots)
      (if (not (slot-boundp instance slot))
          (slot-makunbound copy slot)
        (setf (slot-value copy slot)(slot-value instance slot))))
    copy))

;;;  *** Beginning of CLOS eval-when... ***

#+clos 
(eval-when (load eval compile)

  ;; *** Dont-care vendor CLOS definitions. ***

  (defun GET-CLASS-METACLASS (class-object)
    "Given a class object, returns the metaclass name to help build
 CLASS-DUMP-FORM:  (NEW)."
    (when (%classp class-object)
      (let ((meta (%class-name (class-of (class-of class-object)))))
        (if (not (equal meta #-aclpc 'clos::standard-class
                        #+aclpc 'standard-class
                        )) ;; the default...
            (list (list :metaclass meta))))))

  (defun INSTANCE-NAME (instance)
    "returns the symbol naming the given class object.
   NOTE: on the slimbolical hash-tables are FLAVORS.
   Therefore one must use HASH-TABLE-P instead of TYPE-OF,
   and the type returned is a Common Lisp entity, NOT a FLAVOR!"
    (cond ((hash-table-p instance) 'hash-table)
          ((equal (%type-of instance) 'structure)(type-of instance))
          (T #-aclpc (clos::class-name
                      (clos::class-of instance)
                      #+aclpc(class-name (class-of instance))             
                      ))))

  ) ;; end of CLOS eval-when ....

;;; *** Non-LISP machine CLOS eval-when. ***

#-(or lispm :mcl akcl pcl)
(eval-when (load eval compile)

  (defun GET-SLOT-TYPE (S)
    "Method to get the type from a standard slot:
 this works for most things EXCEPT Genera 8x CLOS."
    #-aclpc (clos::slotd-type s)
    #+aclpc(slot-definition-type s)
    )

;;;(defun GET-DIRECT-SLOTS (class-object)
;;;""
;;;(clos::class-class-direct-slots class-object))

  (defun %GENERIC-FUNCTION-P (x)
    "Predicate, returns t for generic functions. causes symbol conflict problem
 in genera 8.0."
    #-aclpc(clos::generic-function-p x)
    #+aclpc(generic-function-p x)
    )

  )
;;; *** END OF NON LISPM EVAL-WHEN ***


;;; Independent.

;;; DEFINE-DUMP-FORM macro.
;;; package changed from user to cl-user---NEW CHANGE

(defun HAS-DUMP-FORM-P (class-name)
  "Predicate, returns t if a class has a user-defined DUMP FORM method."
  (get class-name #+mcl 'cl-user::%%DUMP-FORM-METHOD%%
       #-mcl 'user::%%DUMP-FORM-METHOD%%
       ))

(defmacro DEFINE-DUMP-FORM (class-name arglist &body body)
  "Macro to define a user-defined dump-form for a given class-name.
   You could do this as two discrete steps, programmatically where you need it"
  `(progn (setf (get ',class-name #+mcl 'cl-user::%%dump-form-method%%
                     #-mcl 'user::%%dump-form-method%%
                     ) T)
          (defmethod DUMP-FORM ,arglist ,@body)
          ',class-name))

;;; Everything except AKCL.

(eval-when (load eval compile)

  (defun GET-CLASS-SUPERCLASSES (class)
    "Returns a list of the NAMES (symbol list) of the direct superclasses of 
    the class object."
    (let ((the-ones (get-superclass-names class)))
      (if *supress-standard-object* (delete 'standard-object the-ones)
        the-ones)))

  (defun GET-SLOT-READER (slot-object)
    (first (get-slot-readers slot-object)))

  (defun GET-SLOT-WRITER (slot-object)
    (first (get-slot-writers slot-object)))

  (defun ACCESSOR-EXISTS-P (S)
    "Predicate: Returns T iff the slot has both a reader and a standard writer"
    (let* ((readers (get-slot-readers s))
           (writers (get-slot-writers s))
           (accessors (%some #'(lambda (writer)
                                 (and (listp writer)
                                      (equal (first writer) 'SETF)
                                      (second writer)
                                      (member (second writer) readers
                                              :test #'equal)))
                             writers)))
      accessors))

  (defun GET-SLOT-ACCESSOR (s)
    "Returns the first slot accessor alone."
    (let ((val  (first (get-slot-readers s))))
      (when (and val (accessor-exists-p s))
        val)))

  (defun %GET-SLOT-NAME (S)
    "Method to get the name from a standard slot."
    (get-slot-name s))

  (defun %GET-SLOT-ALLOCATION (S)
    "Method to get the type of allocation from a standard slot: oneof :CLASS 
    or :INSTANCE."
    (let ((val  (get-slot-allocation s)))
      (when val (list :allocation val))))

  (defun %GET-SLOT-TYPE (S)
    "Method to get the type from a standard slot.."
    (list :type (get-slot-type s)))

  (defun %GET-SLOT-INITARG (S)
    "Method to get the first initarg found for the standard slot instance 
    supplied."
    (let ((val (or (first (get-slot-initargs s))
                   (if *use-default-class-initargs* (make-keyword
                                                     (get-slot-name s))))))
      (when val (list :initarg val))))

  (defun %GET-SLOT-READER (slot)
    "Method to determine whether to use an accessor or a reader. Does not 
    splice into the dump form if there is no reader defined."
    (when (null (%get-slot-accessor slot))
      (let ((val  (GET-SLOT-reader slot)))
        (when val (list :reader val)))))

  (defun %GET-SLOT-WRITER (slot)
    "Method to determine whether to use an accessor or a writer. Does not 
     splice into the dump form if there is no writer defined."
    (when (null (%get-slot-accessor slot))
      (let ((val (GET-SLOT-WRITER slot)))
        (when val (list :writer val)))))

  (defun %GET-SLOT-DOCUMENTATION (S)
    ""
    (list :documentation (or (GET-SLOT-DOCUMENTATION s) "")))

  (defun %GET-SLOT-ACCESSOR (S)
    ""
    (let ((val  (GET-SLOT-READER s)))
      (when (and val (accessor-exists-p s))
        (list :accessor val))))

  (defmethod METHODP ((thing null))
    "NIL is not a method."
    nil)

  (defmethod METHODP ((thing t)) 
    "Anything else is not a method."
    nil)

  (defmethod MBOUNDP ((name symbol))
    "Predicate: returns t if this name is a method as opposed to a 
    function/macro."
    (when (methodp name) T))

  (defmethod MBOUNDP ((name null))
    "vacuous case for NIL."
    NIL)

  (defmethod MBOUNDP ((name t))
    "Predicate: returns t if this name is a method as opposed to a 
    function/macro."
    (when (methodp name) T))

  (defun SLOT-DATA-AS-PLIST (slot)
    "Generates the slot value pairs of the slot descriptor as a property list, 
    of course the name is stuck on the front."
    (let ((name (get-slot-name slot))
          (initarg (get-slot-initarg slot))
          (accessor (get-slot-accessor slot))
          (initform (get-slot-initform slot))
          (type (get-slot-type slot))
          (documentation (get-slot-documentation slot))
          (allocation (get-slot-allocation slot)))
      (if accessor
          (list name :initarg initarg 
                :accessor accessor
                :initform initform
                :type type
                :documentation documentation
                :allocation allocation)
        (list name :initarg initarg 
              :initform initform
              :type type
              :documentation documentation
              :allocation allocation))))

  (defun CONSTRUCT-SLOT-SPEC (slot)
    "The internal dump-form constructor for slots."
    (let ((name (%get-slot-name slot))
          (initarg-pair (%get-slot-initarg slot))
          (type-pair (%get-slot-type slot))
          (accessor-pair (%get-slot-accessor slot))
          (reader-pair (%get-slot-reader slot))
          (writer-pair (%get-slot-writer slot))
          (allocation-pair (%get-slot-allocation slot))
          (initform-pair (%get-slot-initform slot))
          (documentation-pair (%get-slot-documentation slot)))
      `(,name ,@initarg-pair
              ,@type-pair
              ,@accessor-pair
              ,@reader-pair
              ,@writer-pair
              ,@allocation-pair
              ,@initform-pair
              ,@documentation-pair)))

  (defun GENERATE-CLASS-SLOT-FORM (slotd)
    "Default method for rev4b --- seems to be defective...
 This one gets called by CLASS-DUMP-FORM."
    (construct-slot-spec slotd))

  (defun SORT-ALLOCATED-SLOTS (class-object)
    ""
    (let ((slots (class-slots class-object)))
      (values
       (remove-if-not #'(lambda (slot)(equal (get-slot-allocation slot)
                                             :CLASS))
                      slots)
       (remove-if-not #'(lambda (slot)(equal (get-slot-allocation slot)
                                             :INSTANCE))
                      slots))))
  ) ;; non-akcl eval when....

;;; Only allow class save, method save, and generic function save when this
;;; file is loaded: control this with :class-save on the features list.
;;; end of lucid eval-when.

;;; NOTE! Returned result from CLASS-DIRECT-SLOTS varies with the vendor!

;;; CLOS/PCL independent class accessor methods.

(eval-when (load eval compile)

  (defun FIND-GENERIC-FUNCTION (name)
    "A function given the name of a supposed generic function,
 returns the function object if it exists, NIL otherwise."
    (cond ((and (fboundp name)(%generic-function-p name))
           (symbol-function name))
          (T NIL)))

  (defun GENERATE-CLASS-OPTIONS-FORM (class)
    "Generates a dump form for the default-initargs, metaclass,
 documentation components of a class object...."
    (let ((default-initargs (get-class-default-initargs class))
          (metaclass (get-class-metaclass class)))
      (if default-initargs
          `((:default-initargs ,@default-initargs)
            ,@metaclass
            (:documentation ,(or (get-class-documentation class) "")))
        `(,@metaclass
          (:documentation ,(or (get-class-documentation class) ""))))))

  ) ;; end of class-save eval-when.

#+allegro-v4
(defmethod ALL-SLOTS-AND-VALUES ((instance T))
  "returns an alist of slot value pairs.
 NOTE: Each alist cell is a LIST, NOT a CONS!
 Also, this has been modified to deal with unbound slots."
  (let ((answers nil))
    (dolist (slot (all-slotnames instance) answers)
      (setf answers (nconc answers
                           (list slot (if (slot-boundp instance slot)
                                          (slot-value instance slot)
                                        *unbound-slot-token*)))))
    answers))

#-(or kcl allegro-v4.0 allegro-v4.1 allegro-v4.2)
(defmethod ALL-SLOTS-AND-VALUES ((instance T))
  "returns an alist of slot value pairs.
 NOTE: Each alist cell is a LIST, NOT a CONS!
 Also, this has been modified to deal with unbound slots."
  (loop for slot in (all-slotnames instance) nconc
        (list slot (if (slot-boundp instance slot)
                       (slot-value instance slot)
                     *unbound-slot-token*)) into answers
      finally (return answers)))

(defun PRSLOT (key val &optional (stream *standard-output*))
  "Simple function to be used by MAP-INSTANCE, printing out a slots key
 and value, ala DESCRIBE."
  (format stream "Key: ~a, Value: ~a~%" key val))

(defun MAP-INSTANCE (function instance &key (modify T)
                              (concat nil)
                              (OPERATE-ON-UNBOUND-SLOTS NIL))
  "Iterator over the slots in an instance, ala MAPHASH. Takes a function of the
   keyword/ value (2 arguments, not ONE!)."
  (let* ((slotnames (all-slotnames instance))
         (answers nil)
         (result nil))
    (when (null slotnames)(return-from map-instance nil))
    (dolist (slot slotnames answers)
      (IF (SLOT-BOUNDP INSTANCE SLOT)
      (setf result (funcall function slot (slot-value instance slot)))
      (WHEN OPERATE-ON-UNBOUND-SLOTS
              (SETF RESULT (FUNCALL FUNCTION SLOT *UNBOUND-SLOT-TOKEN*)))
      )
      (when concat (setf answers (append answers (list result))))
      (when modify (setf (slot-value instance slot) result)))
    (if (null concat) instance (flatten1 answers))))
#|
#-(or akcl allegro-v4.0 cmu)
(defun MAP-INSTANCE (function instance &key (modify T)(concat nil))
  "Iterator over the slots in an instance, ala MAPHASH. Takes a function of the
  keyword/ value (2 arguments, not ONE!)."
  (let* ((init (all-slots-and-values instance))
         (answer (loop with con = nil
                     until (null init)
                     as key = (pop init)
                     as val = (pop init)
                     as result = (funcall function key val)
                     when concat do (setf con (append con (list result)))
                     when modify do (setf (slot-value instance key) result)
                     finally (return (if (null concat) instance
                                       (flatten1 con))))))
    answer))
|#

(defun QUOTED-SYMBOL-P (X)
  "Predicate: returns t if the object is a quoted symbol."
  (and (listp x)(equal (first x) 'quote)(symbolp (second x))))

(defun QUOTED-FORM-P (X)
  "Predicate: returns t if the object is a quoted form."
   #-mcl (and (listp x)(equal (first x) 'quote))
   #+mcl (ccl::quoted-form-p x)
   )

(defun QUOTED-FORM-DUMP-FORM (instance)
""
`(QUOTE ,(get-dump-form (second instance))))

(defun GET-SLOT-VALUES (clos-instance)
  "given a pcl/clos instance,constructs a plist of all the saveable
   slot/value pairs."
  (incf *global-instance-count*)
  (let ((unsaveable (get-unsaveable-slotnames clos-instance)))
    (map-instance #'(lambda (key val)
                      (if (or (member key unsaveable :test #'equal)
                              (member key *global-unsaveable-slotnames*
                                      :test #'equal))
                          (list (make-keyword key) *unsaveable-slot-token*)
                        (list (make-keyword key)(get-dump-form val))))
                  clos-instance
                  :modify nil
                  :concat t)))

;;; Unsaveable slots.

(defun INDEX-UNSAVEABLE-SLOT (class slot)
  ""
  (pushnew slot (gethash class *unsaveable-slotname-hash-table*)))

(defun RETRIEVE-UNSAVEABLE-SLOTS (class)
  (gethash class *unsaveable-slotname-hash-table*))

#+mcl
(defun GET-DEFSTRUCT-SLOT-OFFSET (struct slotname)
  "New definition of slot offset for MCL 2.0.1. Position 0 of the spec is the
   name of the defstruct, assuming GDSNAMES produces the slotnames in the same  
   order as they occur in the defstruct definition, 1 the position of the slotname
   is the correct offset."
(1+ (position slotname (get-defstruct-slot-names struct) :test #'equal)))

#-mcl
(defun GET-DEFSTRUCT-SLOT-OFFSET (struct slotname)
  ""
  (let ((slots (get-defstruct-slot-descriptors 
                (get-defstruct-name struct)))
        (answer nil))
    (dolist (slot slots answer)
      (if (and (listp slot)(equal (first slot) slotname))
          (setf answer (first (reverse slot)))))))

;;; =================== VENDOR INDEPENDENT FUNCTIONS ===================

(defun GET-SD-NAMED (struct slotname)
  (dolist (sd (get-defstruct-slot-descriptors struct))
    (when (equal (get-defstruct-slot-name sd) slotname)
      (return sd))))

#+aclpc
(defun GET-DEFSTRUCT-SLOT-ACCESSOR (struct slotname)
  "Given a structure instance and a slotname, ret the accessor for
 that name."
  (first (cdr (assoc slotname (get-defstruct-slot-descriptors 
                               (get-defstruct-name struct))))))

#-aclpc
(defun GET-DEFSTRUCT-SLOT-ACCESSOR (struct slotname)
  "Given a structure instance and a slotname, ret the accessor for
 that name."
  (let ((sd (get-sd-named struct slotname))
        (structname (get-defstruct-name struct)))
    (defstruct-slot-descriptor-ref sd :accessor structname)
    ))

(defun GET-DEFSTRUCT-SLOT-VALUE (instance slotname)
  "Given an instance of a defstruct, and the name of some slot, return the 
  slots value."
  (let ((fun (get-defstruct-slot-accessor instance slotname)))
    (if fun (funcall fun instance)
      (error 
       "No function was found to access slot ~a in defstruct instance ~a."
       slotname instance))))

(defun SET-DEFSTRUCT-SLOT-VALUE (instance slotname newval)
  (funcall *vendor-set-slot-function* instance slotname newval))

(defun GET-DEFSTRUCT-VALUES (instance)
  ""
  (let ((answers nil))
    (dolist (slot (get-defstruct-slot-names instance)(nreverse answers))
      (push (get-dump-form (get-defstruct-slot-value instance slot)) answers)
      )))

#-lucid
(eval-when (load eval compile)

  (defun GET-DEFSTRUCT-SLOT-LOCATION (i name)
    ""
    (position name (nreverse (get-defstruct-slot-names i))))

  ) ;; end of no-lucid eval when...

;;; Utilities.

(defun WRITE-ATTRIBUTE-LINE (stream)
  ""
  (format stream
          ";;;-*- Mode: Lisp; Base: 10; Syntax: Common-Lisp; Package: ~a -*-~%"
          (package-name *package*)))

(defun WRITE-PACKAGE-INFO (stream)
  ""
  ;; modified by KJ to not quote package name
  #+mcl(format stream "~%(in-package :~s)"
               (read-from-string (package-name *package*)))
  #-mcl
  (format stream "~%~s"
          `(in-package ',(read-from-string (package-name *package*))))
  )

(defun PCO-P (instance)
  "A predicate to determine if a LISP object is a PCO."
  (declare (inline pco-p))
  (and (not (stringp instance))
       (member (%type-of instance) *pco-types*)))

(defun MAKE-DUMPABLE-FORM (object-instance)
  ""
  (MAKE-LET-FORM object-instance (get-dump-form object-instance)))

(defun SAVE-OBJECT (object-instance filename &key
                                             (compile nil)
                                             (variable '*db-input*)
                                             (if-exists :append)
                                             (print-pretty nil)
                                             (max-print-level 10000000)
                                             (package nil) 
                                             (if-does-not-exist :create))
  (setf *global-instance-count* 0)
  (setf *global-object-count* 0)
  (clear-global-vars-and-htabs)
  (let* ((*print-level*  max-print-level)
         #+lispm (scl::*print-structure-contents* t)
         (*print-circle* t)
         (*print-pretty* print-pretty)
         (*print-length* 50000000)
         (*package*      (or (and package (find-package package))
                             *package*))
         (filename-result filename)
         (form (MAKE-DUMPABLE-FORM object-instance)))
    (setf (get '.%%SL%%. 'namecounter) 0)
    (with-open-file (stream filename :direction :output :if-exists if-exists
                     :if-does-not-exist if-does-not-exist)
      (when (not (equal if-exists :append))(write-attribute-line stream))
      (write-package-info stream)
      (write-global-header stream 
                           '.%%SL%%. 0
                           *global-instance-count*)
      (format stream "~%~s" `(setq ,variable ,form)))
    (format t "~& object saved to file: ~A"filename)
    (when compile (format t "~% compiling file ~A" filename)
          (setf filename-result (compile-file filename))
          (format t "~% done compiling file ~A"filename))
    filename-result))

;;; %EVERY and %SOME: equivalent to EVERY and SOME, but dont blow
;;; up if they encounter a dotted list.

(defun SEQUENCEP (x)
  (declare (inline sequencep))
  (typep x 'sequence))

(defun %REVERSE (dl)
  (if (dotted-list-p dl)
      (let ((l (%length dl))
            (answers nil))
        (append (list (first (last dl)))
                (dotimes (i (- l 2) answers)
                  (push (nth i dl) answers))))
    (reverse dl)))

(defun %BUTLAST (seq)
  (if (dotted-list-p seq)
      (%reverse (%reverse seq))
    (butlast seq)))

(defun %ELT (seq i)
  (cond ((dotted-list-p seq)
         (let ((lbl (1- (length (%butlast seq)))))
           (if (< i lbl)
               (elt (%butlast seq) i)
             (if (= i lbl)
                 (car (last seq))
               (cdr (last seq))))))
        ((not (sequencep seq)) seq)
        (T  (elt seq i))))

(defun GET-ELTS (seq loseqs index)
  "Subfunction of MAP-INTO...."
  (let ((answers nil))
    (if (null (sequencep seq))(list seq)
      (if (null loseqs)(list (%elt seq index))
        (append (list (%elt seq index))
                (dolist (req loseqs (nreverse answers))
                  (if (sequencep req)(push (%elt req index) answers)
                    (push req answers))))))))

(defun %EVERY (predicate sequence &rest more-sequences)
  ""
  (let* ((all-seqs (if more-sequences
                       (append (list sequence) more-sequences)
                     (list sequence)))
            (min (get-min-seq-length all-seqs)))
    ;;(format t "sequence == ~a, sequence length == ~d~%" all-seqs min)
    (dotimes (index min)
      (when (not (apply predicate (get-elts sequence more-sequences index)))
        (return-from %every nil)))
    (return-from %every T)))

(defun %SOME (predicate sequence &rest more-sequences)
  ""
  (let* ((all-seqs (if more-sequences
                       (append (list sequence) more-sequences)
                     (list sequence)))
            (min (get-min-seq-length all-seqs)))
    ;;(format t "sequence == ~a, sequence length == ~d~%" all-seqs min)
    (dotimes (index min)
      (when (apply predicate (get-elts sequence more-sequences index))
        (return-from %some T)))
    (return-from %some nil)))
#|
#+(or lucid allegro)
(setf (symbol-function '%some) #'some)
#+(or lucid allegro)
(setf (symbol-function '%every) #'every)
|#

(defun %LENGTH (lst)
  "Just like length, except if its dotted, it uses our %list-length def."
  (if (dotted-list-p lst)(%list-length lst)
    (length lst)))

(defun GET-MIN-SEQ-LENGTH (seqs)
  "Function which, when given a list of sequences, returns the list of the
 shortest, uses the loop MINIMIZE clause if loop is available, otherwise
 does some iteration 'hair' to get the same result."
  #+(or symbolics lucid aclpc)(loop for seq in seqs minimize (%length seq))
  #-(or symbolics lucid aclpc)
  (let ((tmp most-positive-fixnum))
    (dolist (seq seqs tmp)
      (let ((l (%length seq)))
        (if (numberp l) ;; if its not circular    
            (when (< l tmp)
              (setf tmp l))))))
  )

;;; MAP-INTO: Symbolics and Allegro and MCL have it, 
;;; the other big three dont, and Allegro\PC does not have it.

;;;   (loop for seq on sequences
;;;      for arg on args
;;;      do (if (listp (first seq))
;;;             (setf (first arg)(pop (first seq)))
;;;           (setf (first arg)(aref (first seq) i))))
;;;   (apply function args))))

;;;  ... seems to cause a bug in ACL\PC.... fixed by patch103.fasl:

#-(or symbolics allegro mcl lucid) ;;; for lucid, you need the patch.
(defun MAP-INTO (result-sequence function &rest sequences)
  "Part of CLtL2: only symbolics and allegro and MCL have it...."
  (let ((args (make-list (length sequences)))
        (n (if (listp result-sequence) most-positive-fixnum
             (array-dimension result-sequence 0))))
    (when sequences
      (setf n (min n (get-min-seq-length sequences))))
    (flet
        ((do-one-call (i)
           (loop for seq on sequences
               for arg on args
               do (if (listp (first seq))
                      (setf (first arg)(pop (first seq)))
                    (setf (first arg)(aref (first seq) i))))
           (apply function args))
         (do-result (i)
           (if (and (vectorp result-sequence)
                    (array-has-fill-pointer-p result-sequence))
               (setf (fill-pointer result-sequence)
                 (max i (fill-pointer result-sequence))))))
      (declare (inline do-one-call))
      (if (listp result-sequence)
          (loop for i from 0 to (- n 1)
              for r on result-sequence
              do (setf (first r)(do-one-call i)))
        (loop for i from 0 to (- n 1)
            do (setf (aref result-sequence i)(do-one-call i))
            finally (do-result n))))
    result-sequence))

#+lucid
(eval-when (load eval compile)
(unless (fboundp 'map-into) ;;; you have the lucid patch, use their definition.
(defun MAP-INTO (result-sequence function &rest sequences)
  "Part of CLtL2: only symbolics and allegro and MCL have it...."
  (let ((args (make-list (length sequences)))
        (n (if (listp result-sequence) most-positive-fixnum
             (array-dimension result-sequence 0))))
    (when sequences
      (setf n (min n (get-min-seq-length sequences))))
    (flet
        ((do-one-call (i)
           (loop for seq on sequences
               for arg on args
               do (if (listp (first seq))
                      (setf (first arg)(pop (first seq)))
                    (setf (first arg)(aref (first seq) i))))
           (apply function args))
         (do-result (i)
           (if (and (vectorp result-sequence)
                    (array-has-fill-pointer-p result-sequence))
               (setf (fill-pointer result-sequence)
                 (max i (fill-pointer result-sequence))))))
      (declare (inline do-one-call))
      (if (listp result-sequence)
          (loop for i from 0 to (- n 1)
              for r on result-sequence
              do (setf (first r)(do-one-call i)))
        (loop for i from 0 to (- n 1)
            do (setf (aref result-sequence i)(do-one-call i))
            finally (do-result n))))
    result-sequence))
)
) ;;;; end lucid map-into condition and eval-when....

(defun MAP-VECTOR (func v &key save (modify t))
  "Maps a function of one argument over the elements of a simple
 vector: if modify is t the vector elements are destructively
 modified to contain the result of the function application.
 if save is t, the results of the function application are
 returned as a list."
  (let ((len (length v))
        (answers nil)
        (result nil))
    ;; KOT answer and len are never used, whazzup?
    (declare (ignore answers len))
    (if modify (setf result (map-into v func v))
      (progn (map 'vector func v)
             (setf result v)))
    (if save (return-from map-vector (coerce 'list result))
      (return-from map-vector result))))
      
#|
(if save
    (dotimes (i len (nreverse answers))
      (setf result (funcall func (svref (the simple-vector v) i)))
      (push result answers)
      (when modify (setf (svref (the simple-vector v) i) result)))
  (dotimes (i len v)
    (setf result (funcall func (svref (the simple-vector v) i)))
    (when modify (setf (svref (the simple-vector v) i) result))))))
|#

;;; This is where the defstruct access functions are created automatically.

(eval-when (load eval compile)
  (make-defstruct-access-functions)
  )

;;; KOT hackery -- in Allegro 4.[12], defstructs of the form
;;; (defstruct (foo (:constructor make-foo (<lambda-list>))) slot1 slot2)
;;; result in the standard constructor slot being nil, so look instead at the
;;; boa-constructors slot of the defstruct definition.  So redefine one of
;;; the access functions after the make-defstruct-accessor-functions above.
;;; Note however, that in order to be able to just funcall
;;; get-defstruct-constructor with no arguments (see ALLOCATE-STRUCT), the
;;; :constructor must have a lambda-list with no required arguments.  with 0
;;; arguments, since allocate-struct does that.  Note also that it might be
;;; nicer to have this abstracted a bit, but such is not the nature of the
;;; beast.

#+(or allegro-v4.1 allegro-v4.2)  
(defun get-defstruct-constructor (name)
  (let* ((struct-def (get-defstruct-descriptor name))
         (constructors (excl::dd-boa-constructors struct-def)))
    (or
     (defstruct-descriptor-ref struct-def :constructor)
     (if constructors
         (or
          (some #'(lambda (constructor)
                    (when (member (first (second constructor)) 
                                  lambda-list-keywords)
                      ;; acceptable, return fun-name
                      (car constructor)))
                constructors)
          (error
           "No constructors are available which can be called without ~
            arguments for defstruct type ~A~%" name)))
     (error "No constructor defined for defstruct type ~A~%" name))))

(defun LOOKUP-OBJECT (X &key (mode :save))
  "Accessor to the global object hashtable."
  (rassoc x (gethash (%type-of x)(if (equal mode :save)
                                     *save-object-hash-table*
                                   *load-object-hash-table*))
          :test #'equalp))

(defun CACHE-OBJECT (x &key (mode :save))
  "If the object is a structured object, cache the object in the object
  hash table, if it isnt already there, along with its variable designation."
  (push (CONS (makevar) x)
        (gethash (%type-of x)
                 (if (equal mode :save) *save-object-hash-table*
                   *load-object-hash-table*)))
  x)

(defun LOOKUP-OBJECT-OR-CACHE (x)
  ""
  (cond ((null (lookup-object (eval x) :mode :load))
         (cache-object (eval x) :mode :load))
        (T x)))

(defun OBJECT-VAR (some-object &optional mode)
  "The structure of the object htabs entries is (key . object),
 finding the cell with lookup-object, then the first element of the CONS!"
  (if (null mode)(setf mode *mode-for-object-var*))
  (let ((lo (lookup-object some-object :mode *mode-for-object-var*)))
    (setf lo
      (cond ((null lo)(warn "couldnt find ~a in object var!" some-object) NIL)
            ((listp lo)(first lo))
            (T lo)))))

(defun SET-OBJECT-VAR (object new-var)
  "Given object and new var, and mode, set the appropriate hash table
  key/value to the new-var."
  (let* ((mode *mode-for-set-object-var*)
         (there (lookup-object object :mode mode)))
    (when (not there)(cache-object object :mode *mode-for-object-var*))
    (rplaca (lookup-object object :mode *mode-for-object-var*)
            (object-var new-var))))

(defsetf object-var set-object-var)

(defun %STRUCTURE-p (symbol)
  "predicate, returns t if symbol names a struct."
  (funcall *vendor-dependent-defstruct-symbol-function* symbol))

(defun GET-SYMBOL-DEFSTRUCT-SPEC (symbol)
  ""
  (if (not (symbolp symbol)) nil
  (funcall *vendor-dependent-defstruct-symbol-function* symbol)))

;;; ===================================== TESTS ===============================

#| Directions for using the tests:
   ========== === ===== === =====
|#

(defstruct (WHIZ (:copier %do-whiz))
  (A 25.0 :type float :read-only nil)
  (b PI :type float :read-only nil)
  (c "foo label" :type string :read-only nil)
  (d #c(0 1) :type complex :read-only nil)
  (e (make-hash-table :test #'equal) :type t :read-only nil)
  )

#-(or akcl cmu)
(eval-when (load eval compile)

  #-akcl
  (eval-when (load eval compile)
    #+(or pcl clos)
    (eval-when (load eval compile)

      ;; *** NASTY TEST SUITE: A collection of self-referencing consolas that
      ;; put this code to the test!

      (setf *print-circle* t)
      (defvar l '(a b c d e f) "test list")  ;; KOT being anal
      (defvar b nil "test boo")   ;; KOT being anal
      (defvar b1 nil "test boo1") ;; KOT being anal

      (setf (third l) (cdr l))

      (defstruct (boo (:type list))  x y)

      (setq b (make-boo
               :x (vector 1 2 (make-hash-table) 4)
               :y (make-boo :x '(#\a #c(1.7 4.99)))))

      (defstruct boo1  x y)

      (setq b1 (make-boo1
                :x (vector 1 2 (make-hash-table) 4)
                :y (make-boo :x '(#\a #c(1.7 4.99)))))

      #+aclpc
      (defvar *nasty-path* "c:\\")

      #+lispm
      (defvar *nasty-path* "e:>kerry>")

      #+mcl
      (defvar *nasty-path*)

      #+mcl
      (setf *nasty-path* "Macintosh HD:Lisp:")

      ;; UNIX BOX PATH:

      #+(or excl akcl lucid)
      (defvar *nasty-path* "/users/kerry/save-object/tests/")

      ;; Test Classes:

      (defclass SLOTLESS ()
        ((a)(B)(c)(d)(e)))

      (defclass BOGON ()
        ((name :initarg :name
               :type string
               :accessor bogon-name
               :documentation ""))
        (:default-initargs :name "")
        (:documentation ""))

      (defclass TEST (bogon)
        ((a :initarg :a)
         (b :initarg :b)
         (c :initarg :c)
         (name :initarg :name))
        (:default-initargs :a nil
          :b nil
          :c nil
          :name "")
        (:documentation "Simple test class for the examples below."))

      (defclass ZYGON ()
        ((a :initform (make-instance 'slotless) :allocation :class)
         (b :initform (make-instance 'test))
         (c :initform (make-instance 'test) :allocation :class))
        (:documentation "tests the saving of initforms and slotvalues of
                         allocation class..."))

      (defclass ZYG ()
        ((a :initform (make-instance 'slotless))
         (b :initform (make-instance 'test))
         (c :initform (make-instance 'bogon))
         (d :initform (make-instance 'zygon))))

      (defvar *test-cons-save* (cons 10 (cons (make-hash-table :test #'equal)
                                              (make-array 20))))

      (defvar *nasty-extension* #+aclpc ".lsp" 
              #-aclpc ".lisp"
              )

      (defun TEST-CONS-SAVE ()
        ""
        (save-object *test-cons-save* (NASTY-PATH "cons-save-test")))


      (defun TEST-UNBOUND-SLOT-SAVE ()
        ""
        (let ((inst (make-instance 'slotless)))
          (save-object inst (nasty-PATH "slotless-test-save"))))

      (defun NASTY-PATH (filename)
        ""
        (concatenate 'string *nasty-path* filename))

(defun FRANZ-TEST ()
  (when (probe-file "zood.lisp")
    (delete-file "zood.lisp"))
	(setf n "franz")
	(setf l `("hugo" "pepi" ,n "susi" ,n))
	(save-object l "zood.lisp"))

(defun FRANZ-TEST-1 ()
  (when (probe-file "zoob.lisp")
    (delete-file "zoob.lisp"))
  (save-object '(A 'A N '(a b c) (Z Y S) 'S '44 '20.6 'XXXX "dfdfjdh" q)
               "zoob.lisp"))

      (defun LESS-NASTY-INSTANCE-TEST ()
        "One instance with one self-reference."
        (let ((a (make-instance 'test)))
          (setf (slot-value a 'a) a)
          (setf (slot-value a 'b) a)
          (save-object a (NASTY-PATH #-aclpc "little-instance"
                                     #+aclpc "linst1"
                                     ))))

      (defvar *a)
      (defvar *b)
      (defvar *c)
      (defvar *d)
      (defvar *the-nasties* nil "stored here for later review.")

      (defmethod INITIALIZE-INSTANCE :AFTER ((self bogon) &rest plist)
        (declare (ignore plist))
        (push self *the-nasties*))

#|
      #-(or akcl lispm)
      (defmethod PRINT-OBJECT ((self bogon) stream)
      (with-slots (name) self
      (format stream "#<Test Instance ~A>" name)))

      #+lispm
      (defmethod PRINT-OBJECT ((self bogon) stream)
      (with-slots (name) self
      (format stream "#<~A: ~A>" name (si:%pointer self))))
|#

      (defstruct foo a b c)

      (defun NASTY-STRUCT-TEST ()
        (let ((a (make-foo)))
          (setf (foo-a a) a)
          (save-object a (NASTY-PATH "nnn.lisp"))))

      (defun GET-NASTY (filename)
        (concatenate 'string *nasty-path* filename
                     #+ACLPC ".lsp" #-aclpc ".lisp"
                     ))

      #+lispm
      (defun NASTY-ARRAY-TEST ()
        ""
        (let ((them! nil))
          (tv:noting-progress ("Nasty Array Allocation!")
            (setf them! (LIST
                         (make-array '(50 20 36) :element-type 'float
                                     :initial-element PI)
                         (make-array 10 :initial-contents 
                                     (make-list 10 
                                                :initial-element "STRINGS!"))
                         (make-array '(21 16 33 4) :element-type
                                     '(unsigned-byte 32)
                                     :initial-element 1024)
                         (make-array '(20 20) :element-type 'character
                                     :initial-element #\!)))
            )
          (tv:noting-progress ("Nasty Array Storage!")
            (save-object them! (NASTY-PATH "horrid-arrays.lisp")))))

      #-lispm
      (defun NASTY-ARRAY-TEST ()
        ""
        (let ((them! (LIST
                      (make-array '(50 20 36) :element-type 'float
                                  :initial-element pi)
                      (make-array 10 :initial-contents
                                  (make-list 10 :initial-element "STRINGS!"))
                      (make-array '(21 16 33 4) :element-type
                                  '(unsigned-byte 32)
                                  :initial-element 666)
                      (make-array '(20 20) :element-type 'character
                                  :initial-element #\!))))
          (save-object them! (NASTY-PATH "horrid-arrays"))))

      (defun NASTY-INSTANCE-TEST ()
        ""
        (setf *a (make-instance 'test :name "A")
              *b (make-instance 'test :name "B")
              *c (make-instance 'test :name "C"))
        (setf (slot-value *a 'a) *b)
        (setf (slot-value *a 'b) *c)
        (setf (slot-value *b 'a) *a)
        (setf (slot-value *b 'b) *c)
        (setf (slot-value *c 'a) *b)
        (setf (slot-value *c 'b) *a)
        (save-object *a (NASTY-PATH #-aclpc "nasty-inst.lisp"
                                    #+aclpc "ninst.lsp"
                                    )))

      (defun INSTANCE-TEST ()
        " A ----> B ----> C ----> D
          ^       ^       |       V
          |-------+--------       |
                  |----------------   "

        (setf *a (make-instance 'test :name "A")
              *b (make-instance 'test :name "B")
              *c (make-instance 'test :name "C")
              *d (make-instance 'test :name "D"))

        (setf (slot-value *a 'a) *b)
        (setf (slot-value *b 'a) *c)
        (setf (slot-value *c 'a) *d)
        (setf (slot-value *c 'b) *a)
        (setf (slot-value *d 'a) *b)

        (save-object *a (NASTY-PATH "bobtest")))

;;;;
      (defun INSTANCE-TEST-2 ()

        "BACKPOINTERS ON ALL THE PREVIOUS EXAMPLES
 (two links on each node: twice as many as before, ten.)

    A <---> B <---> C <---> D
    ^       ^       V       V
    V--<>---+-------^       |
            V----<>---------^   "               

        (setf *a (make-instance 'test :name "A")
              *b (make-instance 'test :name "B")
              *c (make-instance 'test :name "C")
              *d (make-instance 'test :name "D"))

        (setf (slot-value *a 'a) *b)
        (setf (slot-value *a 'b) *c)

        (setf (slot-value *b 'a) *c)
        (setf (slot-value *b 'b) *d)
        (setf (slot-value *b 'c) *a)

        (setf (slot-value *c 'a) *d)
        (setf (slot-value *c 'b) *a)
        (setf (slot-value *c 'c) *d)

        (setf (slot-value *d 'a) *b)
        (setf (slot-value *d 'b) *c)
        (save-object *a (NASTY-PATH "bobtest2")))

      (defvar *nasty-hash-tables* nil)

      (defun NASTY-HASH-CHAIN-TEST ()
        " Makes a nested hash table net like this:

     a->b  b->c  c->d  d->e   e->a
    a-----b-----c-----d----->e----->|
    ^                               v
    |<---------------------<---------
      e->a      e->a       e->a   e->"

        (setf *nasty-hash-tables* nil)
        (let* ((a (make-hash-table))
               (b (make-hash-table))
               (c (make-hash-table))
               (d (make-hash-table))
               (e (make-hash-table)))
          (pushnew a *nasty-hash-tables*)
          (pushnew b *nasty-hash-tables*)
          (pushnew c *nasty-hash-tables*)
          (pushnew d *nasty-hash-tables*)
          (pushnew e *nasty-hash-tables*)
          (setf (gethash 'a->b b) a)
          (setf (gethash 'b->a a) b)
          (setf (gethash 'b->c c) b)
          (setf (gethash 'c->b b) c)
          (setf (gethash 'c->d d) c)
          (setf (gethash 'd->e e) d)
          (setf (gethash 'e->a a) e)
          (save-object a (NASTY-PATH "qhash"))))

      (defun NASTIER-STRUCT-TEST ()
        (save-object b1 (NASTY-PATH "b1-test")))

      (defun GET-HTAB-KEYS (htab)
        (let ((values nil))
          (maphash #'(lambda (key val)
                       (declare (ignore val))
                       (push key values))
                   htab)
          values))

      (defvar *test-struct-form*
          '(SETQ *DB-INPUT*
                 (LET* ((.%%SL%%.1 (%ALLOCATE-INSTANCE 'BOO1)))
                       (FILL-STRUCT .%%SL%%.1 '(BOO1)))))

      (defvar *test1* (list (make-instance 'test)
                            (make-hash-table :test #'eq)
                            (list (make-foo)
                                  (make-foo)
                                  (list (make-instance 'test)
                                        #c(0 1)
                                        (make-foo)))))

      (defun DESCRIBE-STRUCT-INSTANCE (name)
        (let* ((desc (get-defstruct-descriptor name))
               (type (get-defstruct-type name))
               (conc-name (get-defstruct-conc-name name))
               (predicate (get-defstruct-predicate name))
               (include (get-defstruct-include name))
               (included-by (get-defstruct-included-by name))
               (print-function (get-defstruct-print-function name))
               (copier (get-defstruct-copier name))
               (constructor (get-defstruct-constructor name))
               ;; KOT this isn't enough args for get-defstruct-slot-descriptor;
               ;; it wants struct-name slot-name, not sure which this name is.
               (sds (get-defstruct-slot-descriptor name))
               )
          (dolist (sd sds) (describe-struct-slot sd))))

      ) ;; end of tests eval-when....
    )

  (defun TEST-SO-MULT ()
    ;; KOT -- this results in compiler warning for var 'it', maybe
    ;; with-saved-objects isn't quite kosher ...
    (with-saved-objects (it "filetest.dat" :direction :output
                            :if-exists :append
                            :if-does-not-exist :create)
      "this is a filetest.")
    "filetest.dat"
    )

  (defun TEST-SO-MULT-1 ()
    ;; KOT -- this results in compiler warning for var 'it', maybe
    ;; with-saved-objects isn't quite kosher ...
    (with-saved-objects (it "filetest.dat" :direction :output
                            :if-exists :append
                            :if-does-not-exist :create)
      (make-whiz)
      (make-whiz)
      (make-whiz)
      (make-boo1))
    #-aclpc "filetest.dat"
    #+aclpc "ft.dat"
    )

  ) ;; end of eval-when of all TESTS.

#-aclpc
(defun QUIT ()
  "sick of having to remember which one it is!"
  #+lispm nil
  #+aclpc(user::quit)
  #+lucid(lcl::quit)
  #+mcl (user::quit)
  #+akcl(bye)
  #+cmu(user::quit)
  #+excl(excl::exit)
  )

#+aclpc
(defun INSTANCE-NAME (instance)
  (class-name (class-of instance)))

;;; eof.
