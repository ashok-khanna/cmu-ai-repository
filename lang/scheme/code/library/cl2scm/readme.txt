This is brief notes on the procedures defined by the files in this
directory.  This is not intended to be a complete documentation but just
remarks that users of these functions and macroes should be aware of.
These source codes are writeen as a part of a project that involves first
porting a program written in CL to MIT Scheme.  I have tried to filter
out, in these files, the comments that relate to only that prject but there
might be some that escaped me.  Please ignore comments that do not seem
relevant.  As the primary goal of the afore mentioned project is not to
implement the CL language using MIT Scheme, the implementation contained
here are correct to a degree but I have not checked them rigourously
against the CL speciifiications.

					- Minghsun Liu
 					  lmh@medg.lcs.mit.edu	


1. MACRO-HACKS.SCM

This file contains modifications to the MIT Scheme macroes to make them
behave more like their CL counterparts.  I did not write these codes,
the codes are taken from the doc macro.txt, written by the MIT Scheme
team.


2. ARRAY.SCM & ARRAY-DISPLACED.SCM

These files are similar in all aspects except one: the array datatype
implemented in ARRAY.SCM does not include support for the :displaced-to
keyword whereas ARRAY-DISPLACED.SCM contains one that does. (buggy still
though)  With a few additional modifications to the implementation in
ARRAY-DISPLACED.SCM, support for :displaced-index-offset can be
easily implemented.  For now, these keywords are implemented:
:initial-contents, initial-element, and :displaced-to (in
ARRAY-DISPLACED.SCM).  Some of the major bugs in the implementation of array
with support for :displaced-to exist in the handling of displacements
between an array that has NIL dimension and one that has non-NIL
dimensions.

P.S. The elements of the array can't be lists.  If they are, FLATTEN in
MAKE-ARRAY has to be modified.


3. LOG-OPER.SCM

Implementations of some of the logical operations in CL.  ASH is 
implemented using arithmetic operations to simulate logical ones and
might be relatively expensive.  *MAX-BIT-STRING-LENGTH* is used by several
procedure, during the convertion of a number from its decimal
representation to binay representation, as the upper limit.  (i.e. These
logical operations should have no problem handling integers as large as
2^199 - 1, with 200 being the default value.)  


4. MISC.SCM

As the name suggests, this file contains definitions that I can't find
coherent groupings for.  A note concerning the implementation of SETQ:
since most of the time, the use of SETQ is similar to SET! in Scheme
except that it returns the new value, instead of the old value (or
something else), SETQ implement only this aspect while SETQQ is the
complete implementation that behaves like SETQ in CL.
BTW, the iterative constructs can also be found in this file.


5. UTIL.SCM

Contains an implementation of the TIME procedure in CL.  (This procedure
is the combined child of SHOW-TIME and PRINT-GC-STATISTICS procedures written
by the Scheme team as part of MIT Scheme.)


6. FILE.SCM

Implements WITH-OPEN-FILE with support for some keywords.


7. BSORT.SCM
 
This file contains an alternative definition to CL-SORT.  Instead of
using the sorting algorithm (Q-sort, a non-stable sort) defined in MIT
Scheme, this uses the good-old bubble sort.


8. SEQUENCE.SCM

Some of the operations on sequences are implemented in this file, with
support for most of the keywords.


In all, the follow CL functions and macroes are implemented:  (I tried
to use the same name when possible, if not, the name(s) to the left is(are)
the equivalent(s) in MIT Scheme.)

CL                                MIT Scheme (if different)
-----------------------------------------------------------
AREF                              AREF & ARRAY-SET!
ARAAY-DIMENSION
ARRAY-DIMENSIONS
ARRAY-RANK
ASH
COMPILE
CONCATENATE                   
COUNT 
COUNT-IF
DEFMACRO
DO*
DOLIST
DOTIMES
ELT
FIND
FILL
FUNCALL                           
INTEGER-LENGTH
LENGTH                            CL-LENGTH
LOGAND
LOGANDC2
LOGCOUNT
LOGIOR
LOOP
MAPCAN
MAPCAR                            MAP & MAP-VEC
NSUBSTITUTE-IF
NSUBSTITUTE-IF-NOT
POSITION
PRINT                    
PROG1
PSETQ
PUSH
READ-LINE
SEARCH
SET
SETF
SETQ                              SETQ & SETQQ
SORT      			  CL-SORT
STRING                            CL-STRING
TIME
(TYPEP OBJ 'ATOM)                 ATOM?
UNLESS
WHEN
WITH-OPEN-FILE










