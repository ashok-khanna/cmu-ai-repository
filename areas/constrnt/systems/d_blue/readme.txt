initial version: Nov 27  1991

This directory contains several implementations in different languages
of the DeltaBlue incremental dataflow constraint solver described in
UW CS TR 91-08-12 ``Using Constraints for User Interface
Construction'' by John Maloney.  Each implementation is in a separate
subdirectory, named with the name of the language: C-DEC, C-SUN4,
Smalltalk, common-lisp.

The C-DEC and C-SUN4 subdirectories contain almost-identical
implementations of the algorithm in the C language, developed on a
Decstation and a Sun 4.  There were some minor differences betweeen
the C compilers on the two machines that required a few changes.  The
major difference, however, is that the Sun 4 version preallocates and
re-uses temporary storage needed by the benchmarks.  Similar changes
could also be made to the Decstation version.

==================================
addition: Oct 18  1993

Warning: It appears that the C implementations of DeltaBlue can loop
infinitely when compiled on an IRIS (and perhaps other machines).  Here is
the fix:

>   I finally tracked down the bug in the DeltaBlue C code on the IRIS.
>   
>   Simple fix (though probably not best):
>   
>       In Constraint.h, change
>          #define NO_METHOD        (-1)
>       to
>          #define NO_METHOD        (255)
>   
>   Problem with the code or the C compiler (I'm not sure which): the
>   whichMethod field of a constraint is declared as a char.  When a
>   constraint's selected method is removed with "overridden->whichMethod =
>   NO_METHOD" this puts 255 into the char field.  Later, checking whether the
>   constraint is satisfied via "#define SATISFIED(c) ((c)->whichMethod !=
>   NO_METHOD)" returns nil, since -1 is not = 255.

==================================
addition: Feb 9  1994

The file UW-CSE-92-07-05a.PS.Z has been added to this directory.  This is a
pointer to the UW CSE tech report 92-07-05a, originally published 7/92,
revised 5/93.  This paper was also published in Software---Practice and
Experience, Vol. 23, No.  5, May 1993, pp.  529--566.

Title:
   Multi-way versus One-way Constraints in User Interfaces:
   Experience with the DeltaBlue Algorithm

Authors:
   Michael Sannella, John Maloney,
   Bjorn Freeman-Benson, and Alan Borning

Abstract:
   The efficient satisfaction of constraints is essential to the performance
   of constraint-based user interfaces.  In the past, most constraint-based
   user interfaces have used one-way rather than multi-way constraints
   because of a widespread belief that one-way constraints were more
   efficient.  In this paper we argue that many user interface construction
   problems are handled more naturally and elegantly by multi-way constraints
   than by one-way constraints.  We present pseudocode for an incremental
   multi-way constraint satisfaction algorithm, DeltaBlue, and describe
   experience in using the algorithm in two user interface toolkits.  Finally,
   we provide performance figures demonstrating that multi-way constraint
   solvers can be entirely competitive in performance with one-way constraint
   solvers.



