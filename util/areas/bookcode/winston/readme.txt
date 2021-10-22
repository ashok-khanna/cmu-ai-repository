-*- mode:Text -*-
Copyright 1992 Patrick H. Winston.  All rights reserved.
Version 1.1.1, transferred from master disk on 23 Apr 93
 
This file may reference other files containing copyrighted software.
Any restrictions on the use of such software are described in the
files containing that software.  This file may be freely copied as
long as this notice is kept intact.

AVAILABLE PROGRAMS

Programs illustrating the following concepts are included in this version:

Text File    | Chapter and Material Involved
-------------|-----------------------------------------------------------------
search.txt   |	4 Illustrates heuristic search using a highway net.
optimize.txt |	5 Illustrates optimal search using highway net.
contest.txt  |	6 Illustrates adversarial search using game trees.
bagger.txt   |	7 Illustrates forward chaining via grocery bagging.
zoobk.txt    |	7 Illustrates backward chaining via animal identification.
zoofw.txt    |	7 Illustrates forward chaining via animal identification.
prefer.txt   |	8 Illustrates SOAR's preference system using a highway net.
frames.txt   |	9 Illustrates inheritance using dwarfs and earthquakes.
time.txt     | 12 Illustrates constraint propagation using time intervals.
resolve.txt  | 13 Illustrates theorem proving using birds and blocks.
kd.txt       | 19 Illustrates nearest neighbor learning using colored blocks.
version.txt  | 20 Illustrates version space learning using allergies.
train.txt    | 23 Illustrates perceptron convergence using digits.
cast.txt     | 24 Illustrates interpolation/approximation nets using vacations.
tools.txt    | 29 Illustrates Natural language database query using tools.
rdb.txt	     | Illustrates relational database operations using beach data.

You also may wish to look at software provided for Lisp, Third
Edition.  Send a message to lisp3@ai.mit.edu with the word ``help''
on the subject line to learn how to get at that software.

FILES

Several types of files reside, along with this one, in this
software collection:

Type	Purpose

txt	Text files contain explanatory text, meant to be read by people.
lsp	Lisp files contain Lisp programs or Lisp data.  
exp	Experiment files contain Lisp forms that load program files and
	data files and that initiate experiments.
ref	Reference files contain the text printed when the corresponding
	experiment files are used.

For example, the bagger.txt file explains what the bagger program
does and what you should do with the bagger.exp file; the
bagger.exp file, when loaded, loads the bagger program and runs
it on sample data; the match.lsp, streams2.lsp, and forward.lsp
files contain the Lisp procedures in the bagger program; and the
bagger.ref file shows you what the bagger program should produce
when run on the sample data.

If you are short on disk memory, you may wish to transfer the txt
files to your machine first.  Then you can transfer the exp files
that you wish to work with.  The exp files, in turn, tell you
which lsp files you need to run the experiments.

HARDWARE AND SOFTWARE REQUIREMENTS

Each program is supplied in source form.  All, with exceptions
noted below, have been tested with each of the following Common
Lisp implementations:

> Macintosh Commonlisp
  Version 1.3.2 (for Macintosh users)
  Tested on Macintosh Quadra 700

> Franz
  Version 3.2.beta.1 (for UNIX users)
  Tested on IBM RS/6000

> Gold Hill
  Version 4.1 (for Microsoft Windows users)
  Tested on COMPAQ 386
 
> AKCL (Austin Kyoto Common Lisp)
  Version 1.530 (for UNIX users)
  Tested on SUN Sparc 2

> Lucid (UNIX)
  Version 4.0.0 (for UNIX users)
  Tested on IBM RS/6000

> Symbolics (Genera)
  Version 8.1
  Tested on Symbolics 3650

The exceptions are:

kd
prefer
resolve
time

At this writing, these have been tested on AKCL Lisp, Lucid Lisp,
and Symbolics Lisp systems only.

None of the programs requires much memory.  Consequently, you
should have no trouble running them as long as your computer
meets the minimum system requirements specified by the vendor of
your Common Lisp implementation.

RUNNING THE EXPERIMENTS

The txt files generally tell you how to load the exp files.
Note, however, that you have to tell Lisp where your files are
before the instructions in the txt files will work.  The easiest
way to do this is somewhat implementation dependent.

> FOR FRANZ, KCL, AND LUCID LISP SYSTEMS ON UNIX

First follow your standard login ritual.  Then change to the
directory containing the exp and lsp files.  Then load Lisp with
the appropriate selection from the following lines:

franz
kcl
lucid

Then follow the instructions in the txt file.

> FOR THE GOLD HILL SYSTEM (MICROSOFT WINDOWS)

Load windows in your usual way.  Click on the Gold Hill icon to
load lisp.  Then evaluate a CD form to tell Lisp where
your files are.  For example, on one system I use, I type the
following:

(cd "/phw/ai3/")

> FOR THE GENERA SYSTEM (SYMBOLICS MACHINES)

Load files with full pathnames, thus resetting the default
pathname.  For example, on one system I use I type the following:

(load "rushmore:~phw/ai3/search.exp")

> FOR CORAL SYSTEMS (MACINTOSH MACHINES)

Type an expression that resets the default pathname.  For
example, on one system I use I type the following:

(setf *default-pathname-defaults* "phw:ai3:")

Actually this method should work on all Lisps and does work on
many, but not all Lisps.

ADDITIONAL PROGRAMS

Additional programs will be prepared, if practicable, in response
to your requests.

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
The string     syntax:Common-Lisp     in the comment line of all
files forces Genera to use Common Lisp syntax, however.




