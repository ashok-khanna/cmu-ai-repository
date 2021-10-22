DIRECTORY CONTENTS: The TimeGraph II temporal reasoning system

This directory contains the latest distribution in a tarred, 
compressed (by gzip) version.

TimeGraph II (TG-II) is an efficient system for reasoning about
qualitative temporal information. TG-II handles the set of the
relations of the Point Algebra and of the Pointizable Interval
Algebra. Temporal relations are represented through a "timegraph", 
a graph partitioned into a collection of "time chains" which are
automatically structured for efficiency. The system is scalable, 
in the sense that the storage tends to remain linear in the number 
of relations asserted. Efficient query handling is achieved through 
a time point numbering scheme and a "metagraph" data structure. 
TG-II is written in Common Lisp.

This is a release of TimeGraph-II version 1.0.  It has been tested
under Allegro Common Lisp 4.2 and Lucid Common Lisp 4.0.0 on Sun 
SPARC machines running 4.1.3 . The syntax for installing and loading 
the defsystem outlined in timegraph-II.doc is given for Allegro 
Common Lisp.

We maintain the discussion list bug-tg2@cs.rochester.edu 
for bug reports and patch announcements.  To be put on the
bug-tg2@cs.rochester.edu mailing list, send your request to
bug-tg2-request@cs.rochester.edu.

You are free to use, copy and distribute this software provided that:
 1. You report *ALL* bugs to bug-tg2@cs.rochester.edu whether or not 
    you need them fixed. Include the version number (1.0) in the 
    message.
 2. You report *ALL* bugs that you fixed to bug-tg2@cs.rochester.edu.
    Include the version number (1.0) in the message.
 3. Every time you run TimeGraph-II on a machine or using a Lisp 
    compiler not mentioned above, you send a message stating the new 
    environment and the version number (1.0) to bug-tg2@cs.rochester.edu
 4. You inform us that you obtained a copy of TimeGraph-II by sending 
    a message to bug-tg2-request@cs.rochester.edu.

Refer to the file "COPYRIGHT.TEXT" for more details.
 
tg-ii-1.tar.gz  contains the following files:

README: this file
COPYRIGHT.TEXT: the copyright notice
COPYING: GNU General Public License
definitions.lisp: data structures and global variables of the engine
ui-defs.lisp: data structures and global variables of the user interface
cl-lib-definitions.lisp: cl-lib macros used by TimeGraph-II
timegraph-II.lisp: defsystem
tg2.lisp: TimeGraph-II code
interval-interface.lisp: interface for entering and querying interval 
                         relations
point-interface.lisp: interface for entering and querying point relations
pointizable-relations: list of pointizable interval algebra
timegraph-II.doc: documentation for TimeGraph-II
example-interval-relations: an example for specifying interval relations
example-point-relations: an example for specifying point relations


For a description of the theory underlying the system see:

"Efficient Temporal Reasoning through Timegraphs", 
Alfonso Gerevini and Lenhart Schubert, in Proceedings of IJCAI-93; 

"Temporal Reasoning in Timegraph I-II", 
Alfonso Gerevini and Lenhart Schubert, SIGART Bulletin 4(3), 1993.

"Efficient Algorithms for Qualitative Reasoning about Time", 
Alfonso Gerevini and Lenhart Schubert, Artificial Intelligece, to
appear; currently available as IRST Technical Report 9307-44, IRST
38050 Povo, TN Italy; or Technical Report 496, Computer Science
Department, University of Rochester, 14627 Rochester, USA.


			FUTURE VERSION
                        -------------- 
A new version of TimeGraph-II which includes an algorithm for managing
disjunctions of point relations is in preparation.  This extension
will allow the representation of a larger class of interval relations,
including in particular disjointness relations such as "interval I
before or after interval J".
