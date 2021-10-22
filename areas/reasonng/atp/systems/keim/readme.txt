                 Table of Contents

0.  Introduction
1.  Files in this distribution
2.  Getting started
  a. downloading and setup
  b. compilation
  c. dumping a version of KEIM
3.  Notes on DEFSYSTEM
4.  Documentation
5.  Authors

0. Introduction:

KEIM is a collection of software modules, written in Common Lisp with
CLOS, designed to be used in the production of theorem proving systems. 
KEIM is intended to be used by those who want to build or use deduction
systems (such as resolution theorem provers) without having to write the entire
framework. KEIM is also suitable for embedding a reasoning component into
another Common Lisp program.

KEIM offers a range of datatypes implementing a logical language of type
theory (higher order logic), in which first order logic can be embedded.
KEIM's datatypes and algorithms include: types; terms (symbols, applications, 
abstractions), environments (e.g., associating symbols with types); 
unification and substitutions; proofs, including resolution and natural
deduction style. 

KEIM also provides functionality for the pretty-printing, error
handling, formula parsing and user interface facilities which form a large 
part of any theorem prover.  Implementing with KEIM thus allows
the programmer to avoid a great deal of drudgery.

KEIM has been tested in Allegro CL 4.1 and Lucid CL 4.0 on Sun 4 
workstations.  It may run in CMU Common Lisp 16e or newer, but we haven't
been able to test it thoroughly.


1. Files in this distribution:

 keim.README: This file.

 COPYRIGHT: Unless otherwise noted in the files, the files in this
            distribution are covered under this copyright.  We distribute
            for use the files sys/defsystem.lisp, ags/prog/pcl-fixes.lisp,
            and ags/prog/xp-code.lisp, which are covered under the respective
            copyrights contained in them.  They allow, however, free 
            distribution.
 
 doc/       Contains tex macros needed to process the LaTeX version of the
            manual, and a PostScript version of the complete manual for
            this version.
 
 sys/       This directory contains the system definitions for use with
            the defsystem.lisp contained in the directory.  See below
            for some notes on the DEFSYSTEM definitions.

 ags/       Files pertaining to the AGS system.  See the README in
            this directory for more details.
 
 keim/      Files forming the KEIM system.  See the README in this
            directory for more details.

This is KEIM version 1.0.   The current version is stored in the variable
user:*keim-version*, which is defined in sys/ags.system.


2. Getting started:

  a. downloading and setup

You will need to ftp the most recent version of KEIM, which should be
the highest numbered file of the form keim-NNN.tar.Z, from one of 
the following machines:
 (Europe)      mpi-sb.mpg.de:pub/tools/deduction/
 (Europe)      js-sfbsun.cs.uni-sb.de:pub/keim/
 (N. America)  ftp.cs.cmu.edu:/afs/cs/project/tps/keim/

Once you have downloaded KEIM, you need to find a place for it. 
KEIM is now set up to use /home/omega/distrib as the top directory.  You
will probably want to change that.  Call that new directory
$KEIM.  Then mv the keim tar file to $KEIM. 

example% mkdir $KEIM
example% mv keim-1.0.tar.Z $KEIM
example% cd $KEIM
example% zcat keim-1.0.tar.Z |tar xf -
example% cd $KEIM/sys

This last command will uncompress the tar file and run it through tar,
to extract the files and directories.  

IMPORTANT: Now you will have to make at least one change in the distribution.
In the the file $KEIM/sys/ags.system, there is a line that looks like

(defvar *omega-top-dir* "/home/omega/distrib/" "Top KEIM directory")

Change this to (replacing $KEIM by its value):

(defvar *omega-top-dir* "$KEIM" "Top KEIM directory")

That should be enough.  Note that the value of *omega-top-dir* should end in a
"/" to indicate that it is a directory.  If you are using lisp on a system 
that requires a host or device, be sure to include them as well.  For example
"js-sfbsun:/home/omega/distrib/" might be required.

One further thing to watch out for.  Make sure that you (and whoever else
will be using KEIM) have write access to the files ags/fasl, keim/fasl,
ags/tex and keim/tex, because that is where compiled files and extracted
TeX files are going to put. 

 b. compilation

Now that KEIM has been installed, you will have to compile it.  Go to 
the $KEIM/sys directory. Start your lisp (we know that KEIM should run 
in Allegro CL 4.1 and Lucid 4.0, and probably in CMU CL 16e or newer), 
and do the following:

example% cd $KEIM/sys
example% lisp
lisp> (compile-file "defsystem.lisp")
lisp> (load "defsystem")

You should never need to compile defsystem.lisp again, except for a 
different lisp. 

With defsystem loaded, do the following to completely compile KEIM:

lisp> (load "compile-all.lisp")

Here it will take a while.  You may get some compiler warnings, but
should see no errors.  As soon as you get a normal lisp prompt again, 
you should probably exit your lisp to get a fresh one.  Now start another
lisp, and do the following:

lisp> (load "boot.lisp")
; Loading /home1/omega/distrib/sys/boot.lisp.
;   Fast loading /home1/omega/distrib/sys/defsystem.fasl.
Use the functions LOAD-SYS and COMPILE-SYS to load
a system.  Example:
(load-sys 'keim)
(load-sys 'nd)
Use the functions EXDOCU-SYS and CHECK-SYS to extract LaTeX Documentation or
check the programming conventions in the system.


Loading boot.lisp will load defsystem for you, and then tell you how to
start KEIM.  Use the following to all of KEIM including the test functions:

lisp> (load-sys 'test-keim)

In many of the .system files there is a dump function defined that will
create a core image of your KEIM.  For example, in test-keim.system, it
is called DUMP-TEST-KEIM.  Call that with a filename after loading test-keim.

lisp> (test-keim-dump "my-test-keim")

The next time you start up by

example% my-test-keim

What you did above gives you a workable KEIM.   To play with KEIM, and 
see some examples of its use, look at some of the examples scattered 
throughout the manual ($KEIM/doc/test-keim-manual.ps), as well as at the 
manual $KEIM/doc/examples.ps.

In addition, the file keim/prog/nd/rule-examples.lisp has some examples 
of defining natural deduction rules and natural deduction proofs.  
These examples also show the POST syntax of formulas which KEIM is based on. 

3. Notes on DEFSYSTEM:

We are using the portable defsystem.lisp written and provided by 
Mark Kantrowitz, with a few modifications.  First, we've changed it to
use CLOS classes instead of defstructs, so that we can define many of the
functions as generic functions.  This makes it much easier to extend the
functionality to other types of files besides source and binary.  For 
example, we generate .tex from our .lisp files.  

The main system definition is ags.system.  This sets up many of the
variables that will be used during a run: lisp extension, binary extension,
etc.  

Note that in defsystem.lisp we redefined how binary pathnames are computed.
That is going to result in every binary file from a system going into a
single directory (the value of :binary-root-dir option, basically). 

If you define your own systems, you will probably want to do it 
based on one of the definitions that exist in sys/.  Note that if you
put the .system file anywhere other than in sys/, you should modify
the variable mk::*central-registry* that is defined in ags.system.


4. Documentation:

Most documentation for KEIM is contained directly in the source code.
We've included a copy of the entire manual, generated from this code, in
the file doc/test-keim-manual.ps.  That is roughly 150 pages long. 

If you want to extract the documentation yourself, you need to run
the OPERATE-ON-SYSTEM (shortform OOS) function on the system with the
system, and the keyword :exdocu.  Here's an example.  After having loaded
a system (or at least the AGS system, which is the most basic), enter

lisp> (mk::oos 'test-keim :exdocu :force :new-source)

This will create the documentation.  For the AGS system, the tex files
will appear in ags/tex, and for other systems (such as in our example),
in keim/tex.  Now go to that directory.

example% cd $KEIM/keim/tex
example% latex test-keim-manual.tex
example% makeindex -s ../doc/manual.isty test-keim-manual.tex
example% latex test-keim-manual.tex

If some of the required styles are not found in your normal TeX distribution,
they are in $KEIM/doc/macros, so you may have to tell TeX where to look for
them (possibly by adjusting your TEXINPUTS environment variable). 

Now you can enjoy the resulting .dvi file. 

5. Authors:

The KEIM Project is located in the Department of Computer Science 
at the Universitaet des Saarlandes and is under the
direction of Prof. Joerg Siekmann. KEIM serves
as the basis for the Omega-MKRP proof development environment (successor
to the MKRP project) and other theorem provers in the German Deduction
Effort, sponsored by the Deutsche Forschungsgemeinschaft
as ``Schwerpunkt Deduktion.'' 

KEIM is the product of many people, among them:
Xiaorong Huang, Manfred Kerber, Michael Kohlhase, Erica Melis, Dan Nesmith, 
Axel Praecklein, Joern Richts, Ortwin Scheja, Arthur Sehn.  We have
also had help from many students who have tested KEIM and used it in their
own work, and we have also profited from the advice of numerous others.

