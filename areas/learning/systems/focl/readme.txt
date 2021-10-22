FOCL is a machine learning system that extends Quinlan's FOIL program
by containing a compatible explanation-based learning component.  FOCL
learns Horn Clause programs from examples and (optionally) background
knowledge.

An updated version of FOCL (v 2.1) is now available by anonymous ftp
from ics.uci.edu

For details on FOCL, see: 

Pazzani, M. & Kibler, D. (1992). The role of prior knowledge in
inductive learning. Machine Learning, 9, 54-97.

It is available in one of two forms:

1. A (binhexed, Compacted) Macintosh application.  This is stored in
pub/machine-learning-programs/FOCL-1-2-3.cpt.hqx

In addition to the machine learning program, this contains a graphical
interface that displays the search space explored by FOCL, so it is a
useful pedagogical tool.

This application also contains a graphical interface for building rule
bases, so you can ignore the machine learning aspects, and use it as
an expert system shell with the following capabilities:

* A backward-chaining rule interpreter.
* A graphical rule and fact editor.
* Graphical display of the rule base.
* (Simple) Natural language explanation of inferences 
* Menu-based facilities for editing rules and adding natural language
  translations to rules.
* Optional typing of variables and checking the rule base for type conflicts
* Tracing of rules
* Analysis of the accuracy of rules in a rule base.

The expert system has been used successfully in an undergraduate
laboratory course.  Sample rule bases are included.  A minimum of 6MB
of memory is recommended for the application.  In addition, a
manual (that should print on any Macintosh printer) is available in
pub/machine-learning-programs/FOCL-1-2-3-manual.hqx



2. Common lisp source code.  
This is portable source code for the machine learning program
only, since the interface depends on the MAC.

Available by Anonymous ftp from ics.uci.edu in
pub/machine-learning-programs/FOCL-1-2-3.tar.Z

1. FTP FOCL-1-2-3.tar.Z to your machine.
2. Uncompress FOCL-1-2-3.tar.Z creating FOCL-1-2-3.tar
3. Extract the FOCL-1-2-3 files using tar -xf FOCL-1-2-3.tar
4. There will be a new directory called FOCL-1-2-3 containing
   the subdirectories source, compiled, and sample-domains, and
   the files load.lisp.
5. Start up common lisp in the FOCL-1-2-3 directory.
6. Type the following command to load and compile FOCL
         (load "load.lisp")
         (load-source)
         (compile-all)
         (load-comp)
7. After step 6 has been done once, to load the compiled code
         (load "load")
         (load-comp)
8. Load one of the sample domain files from the directory sample-domains
   e.g.     (load "sample-domains/cup.lisp")
   since all of these sample files contain a def-focl-problem learning
   parameter setting it is possible to invoke FOCL using the command:
            (learn)
   most of these files also contains a function, (e.g. (test-cup))
   that calls focl with an explicit set of parameters.
9. Warning.  FOCL takes a large number of keyword parameters.  Most
   of them are there to either
   a. permit us to turn off some capability of FOCL to see how it
      performs without that capability.
   b. To make FOCL run faster by ignoring some capability that we
      know will not affect the answer
   c. experiment with some capability (e.g., the evaluation function)
      It is possible to give inconsistent parameter settings and have
      strange things happen.

Unfortunately, we haven't yet written a manual to explain all the
settings of the learning program.  It is best to start with the
parameter settings of an example from the sample-domains directory.

If you have problems, or run into bugs, send mail to pazzani@ics.uci.edu
or brunk@ics.uci.edu and we will try to address them as time permits.
If you provide us with  data and a description of your problem, we can
help getting you started with FOCL.

Mike Pazzani
Cliff Brunk
ICS Dept
UC Irvine,
Irvine, CA 92717
USA

If you use a copy of FOCL, please send mail to pazzani@ics.uci.edu so
we can inform you of upgrades

