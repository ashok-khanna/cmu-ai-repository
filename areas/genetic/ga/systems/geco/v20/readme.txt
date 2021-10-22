Genetic Evolution through Combination of Objects (GECO), version 2.0

GECO is an extensible, object-oriented framework for prototyping genetic
algorithms in Common Lisp. GECO makes extensive use of CLOS, the Common
Lisp Object System, to implement its functionality. The abstractions
provided by the classes have been chosen with the intent both of being
easily understandable to anyone familiar with the paradigm of genetic
algorithms, and of providing the algorithm developer with the ability to
customize all aspects of its operation. It comes with extensive
documentation, in the form of a PostScript(tm) file, and some simple
examples are also provided to illustrate its intended use.

Copyright (C) 1992,1993  George P. W. Williams, Jr.

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

Author:
    George P. W. Williams, Jr.
    1334 Columbus City Rd.
    Scottsboro, AL 35768
    george@hsvaic.hv.boeing.com

The DEFSYSTEM used (included) is available from Mark Kantrowitz <mkant@CS.CMU.EDU>
It is available for anonymous ftp at ftp.cs.cmu.edu, in the directory
/afs/cs.cmu.edu/project/ai-repository/ai/lang/lisp/.

The DEFRESOURCE used (included) is by Bradford W. Miller <miller@cs.rochester.edu>
and is also available for anonymous ftp from mkant's archive.

Bug reports, improvements, and feature requests should be sent to
george@hsvaic.hv.boeing.com. I will try to respond to them. Ports to
other lisps are also welcome.

GECO should be completely portable among CLtL2 compliant Common Lisps.
It has presently been tested with the following lisp implementations:
 - MCL 2.0 (Apple's Macintosh Common Lisp)
 - ACL 4.1 (Franz's Allegro Common Lisp)
 - LCL 4.1 (Lucid's Common Lisp)

TO USE THIS SOFTWARE
 - Look at the system definition file GECO.system.
   You may need to modify this file for the following reasons:
    .. GECO comes setup to use Mark Kantrowitz's portable defsystem, and
       expects the (require :DEFSYSTEM) form to load it.  Note that some
       lisps (e.g., ACL 4.1) have been known to have problems with this
       defsystem, since it has a lot of system specific code.  If your
       lisp has problems with the defsystem, it should be easy to adapt
       this definition to an alternate defsystem, or simply compile the
       files in the order they appear in the defsystem form.
    .. The defsystem expects the logical host GECO: should be properly
       defined to point to the directory containing GECO.
    .. If your lisp compiler doesn't support tail-recursion optimization
       (i.e., converting tail-recursive calls into goto's), then you
       should enable the appropriate conditional compilation feature
       (see the comments in the file).
    .. Select which random number generator is used by selecting the
       appropriate conditional compilation feature.
 - Evaluate or load GECO.system. This will define the GECO and
   GECO-USER packages and the GECO system, and define a small number of
   utility functions (depending on which Lisp implementation you are
   using).
 - Evaluate the form (geco:compile-geco).  GECO should now be compiled
   and loaded into your environment.  However, this doesn't actually give
   you anything that you can execute.  GECO is a library; you must define
   your own algorithm.
 - Some examples are provided to illustrate GECO's intended use in the
   files sb-test.lisp and ss-test.lisp.

Version History:
1.0 16-Nov-92	GPW
 - Initial public release (under the GNU General Public License).
2.0 29-Nov-93   GPW
 - Changed the license to the GNU Library General Public License
 - Minor patches for compatibility with other Lisps
 - Added documentation
 - Added some support for sequencing problems
 - Added support for minimizing vs maximizing, including renaming the
   organism "fitness" slot to "score"
 - Added more selection methods, generalized existing ones to work with
   both minimizing and maximizing GAs
 - Removed phenotype support from the organism class and added a mixin
   for when it is needed
 - Removed the statistics slot from the genetic-plan class and deleted
   the plan-statistics class, since it's not used by GECO.  If you need
   it, define a subclass.
 - Replaced printable-allele-set with printable-allele-values and
   allele-values
 - Renamed count-allele-values to count-allele-codes
 - Renamed mutate-chromosomes to mutate-chromosome
 - Renamed make-population-vector to make-organisms-vector
 - Renamed some of the files (changed "_" to "-")
 - Deleted unused function copy-population
 - Created GECO-USER package and moved examples to it.
 - Added conditional compilation features to select the random number
   generator, and support lisps which don't implement tail-recursion
   optimization
 - Added max-organism and min-organism slots to the
   population-statistics class
 - Miscellaneous efficiency improvements
 - Even fixed a bug or two B^)

Contributors:
GPW	George Williams
