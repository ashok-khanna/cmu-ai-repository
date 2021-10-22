-*- mode:Text -*-
This file may reference other files containing copyrighted software.
Any restrictions on the use of such software are described in the
files containing that software.  This file may be freely copied as
long as this notice is kept intact.

AVAILABLE PROGRAMS

Programs illustrating the following concepts are included in this
directory.  Asterisks in the following table mark programs for
which other versions are provided in a directory maintained for
Artificial Intelligence, Third edition.  Those other versions are
newer and more heavily commented.  To learn how to obtain those
other versions, send a message to ai3@ai.mit.edu with the word
``help'' on the subject line.

  File Name       Material Involved
-----------------------------------------------------------------
  18micro         Micro Lisp interpretation
* 19search        Network search
  20simula        Project simulation
  21blocks        Blocks-world planning
  22goals         Answering questions about blocks-world plans
  23constr        Propagating bounds on probabilities
* 24matchi        Matching
* 25stream        Stream manipulation
* 26forwar        Forward chaining
* 27backwa        Backward chaining
  28interp        Natural language grammar interpretation
* 29compil        Natural language grammar compilation
* 30databa        Accessing a relational database
  31stars         Constraint-based identification
  32mathem        Infix-to-prefix conversion,
                  sparse matrix operations,
                  and root extraction

FILES

Several types of files reside, along with this one, in this
software collection:

Type    Purpose

lsp     Lisp files contain Lisp programs.  
dta     Data files contain Lisp data.
exp     Experiment files contain Lisp forms that load program files and
        data files and that initiate simple tests.
ref     Reference files contain the text printed when the corresponding
        experiment files are loaded.

For example, to test the Micro Lisp interpreter on your system,
load the 18micro.exp file.  The 18micro.exp file, when loaded,
loads the 18micro.lsp program and runs it on sample data; the
18micro.ref file shows you what the Micro Lisp intepreter should
produce when run on the sample data.

HARDWARE AND SOFTWARE REQUIREMENTS

Each program is supplied in source form.  All have been tested
only on the following Common Lisp implementation:

> Lucid 4.0.2 (for SUN systems) 

RUNNING THE EXPERIMENTS

> FOR FRANZ, KCL, AND LUCID LISP SYSTEMS ON UNIX

First follow your standard login ritual.  Then change to the
directory containing the exp and lsp files.  Then load Lisp with
the appropriate selection from the following lines:

franz
kcl
lucid

> FOR THE GOLD HILL SYSTEM (MICROSOFT WINDOWS)

Load windows in your usual way.  Click on the Gold Hill icon to
load lisp.  Then evaluate a CD form to tell Lisp where your files
are.  For example, on one system we use, we type the following:

(cd "/phw/lisp3/")

> FOR THE GENERA SYSTEM (SYMBOLICS MACHINES)

Load files with full pathnames, thus resetting the default
pathname.  For example, on one system we use we type the
following:

(load "rushmore:~phw/lisp3/18micro.exp")

> FOR CORAL SYSTEMS (MACINTOSH MACHINES)

Type an expression that resets the default pathname.  For
example, on one system we use we type the following:

(setf *default-pathname-defaults* "phw:lisp3:")

Actually this method should work on all Lisps and does work on
many, but not all Lisps.

KNOWN PROBLEMS

> PACKAGES

Some procedures are defined in more than one file, thus creating
name conflicts.  Also, some Lisps add functions like XOR to the
basic repertoire of primitives, also creating name conflicts.  In
some Lisps, redefinition warnings are issued as these name
conflicts occur.

The right way to deal with these name conflicts is to use the
Common Lisp package system.  Package machinery was not used
because it adds a vernier of complexity that makes programs
harder to understand for many beginning programmers.

> THE GENERA SYSTEM (SYMBOLICS MACHINES)

Your Genera system may not use Common Lisp syntax as its default.
Try putting the string     syntax:Common-Lisp     in the comment
line of all files, forcing Genera to use Common Lisp syntax.




