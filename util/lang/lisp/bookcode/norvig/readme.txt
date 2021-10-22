
			      Code for
	  Paradigms of Artificial Intelligence Programming:
		     Case Studies in Common Lisp
		   Copyright (c) 1991 Peter Norvig

The Lisp source code files for the book "Paradigms of Artificial
Intelligence Programming" are available by anonymous FTP from the
Internet, and on disk in Macintosh or DOS format from the publisher,
Morgan Kaufmann.  The total size is about 440K bytes in 78 files of
source code and data.  Currently there are two sites for anonymous FTP:

country machine		  number	directory/files
------- ----------------- -----------	---------------
USA     unix.sri.com	  128.18.10.3	pub/norvig/*
Japan   etlport.etl.go.jp		pub/eus/norvig/* 
					(or pub/eus/norvig.tar.Z)

The downloading process works like this:

Computer Prints:		You type:
----------------		---------
%				ftp unix.sri.com
Name (unix.sri.com:yourname)	anonymous
Password:			yourname@your.address
ftp>				cd pub/norvig
250 CWD command succesful.
ftp>				prompt off
Interactive mode off.
ftp>				mget *
...
ftp>				bye
221 Goodbye.

Most of the files use some auxiliary macros and functions, so you
should load the files "auxmacs" and "auxfns" first.  Then load the
files you are interested in.  The index below gives the chapter in
the book, file name, and short description for each file.  The
filenames are shorter than normal to fit within the DOS limitation of
eight-character names.  If you have acquired a DOS disk, you will
find that the file type ".lisp" has been changed to ".lis" but
everything else works the same.

The function "requires" is used for a primitive form of control over
what files require other files to be loaded first.  If "requires" does
not work properly on your system you may have to alter its definition,
in the file "auxfns.lisp".  For more complicated use of these files,
you should follow the guidelines for organizing files explained in
Chapter 24.  Many of the Lisp files have a corresponding file of type
".dat".  These files contain appropriate test data.  They should not
be loaded, but rather should be evaluated one expression at a time,
comparing the output from your system with the output listed in the
file.

For more information, see the file "ORDERING" or contact:

	Morgan Kaufmann Publishers, Inc.	Tel: 	   (415) 578-9928
	2929 Campus Drive, Suite 260		Toll-free: (800) 745-7323
	San Mateo, CA 94403 USA			FAX:	   (415) 578-0672
						Email:	   morgan@unix.sri.com


CH FILENAME		DESCRIPTION
== =======		===========
-  README		This file: explanation and index
-  ORDERING		How to order the book from the publisher
-  ERRATA		Corrections for bugs and typos
-  auxmacs.lisp		A few macros; load this first
24 loop.lisp		Load this next if your Lisp doesn't support ANSI LOOP
-  auxfns.lisp		Commonly used auxiliary functions; load this third

1  intro.lisp		A few simple definitions
2  simple.lisp		Random sentence generator (two versions)
3  overview.lisp	14 versions of LENGTH and other examples

4  gps1.lisp		Simple version of General Problem Solver
4  gps1.dat		Test data (examples) for above
4  gps.lisp		Final version of General Problem Solver
4  gps.dat		Test data (examples) for above

5  eliza1.lisp		Basic version of Eliza program
5  eliza.lisp		Eliza with more rules; different reader

6  patmatch.lisp	Pattern Matching Utility
6  patmatch.dat		Test data (examples) for above
6  eliza-pm.lisp	Version of Eliza using utilities
6  search.lisp		Search Utility
6  search.dat		Test data (examples) for above
6  gps-srch.lisp	Version of GPS using the search utility 
6  gps-srch.dat		Test data (examples) for above

7  student.lisp		The Student Program
7  student.dat		Test data (examples) for above

8  macsyma.lisp		The Macsyma Program
8  macsymar.lisp	Simplification and integration rules for Macsyma
8  macsyma.dat		Test data (examples) for above

9-10			<no files; important functions in auxfns.lisp>

11 unify.lisp		Unification functions
11 prolog1.lisp		First version of Prolog interpreter
11 prolog1.dat		Test data (examples) for above
11 prolog.lisp		Final version of Prolog interpreter
11 prolog.dat		Test data (examples) for above

12 prologc1.lisp	First version of Prolog compiler
12 prologc1.dat		Test data (examples) for above
12 prologc2.lisp	Second version of Prolog compiler
12 prologc2.dat		Test data (examples) for above
12 prologc.lisp		Final version of Prolog compiler
12 prologc.dat		Test data (examples) for above
12 prologcp.lisp	Primitives for Prolog compiler

13 clos.lisp		Some object-oriented and CLOS code
13 clos.dat		Test data (examples) for above

14 krep1.lisp		Knowledge Representation code: first version 
14 krep1.dat		Test data (examples) for above
14 krep2.lisp		Knowledge Representation code with conjunctions
14 krep.lisp		Final KR code: worlds and attached functions

15 cmacsyma.lisp	Efficient Macsyma with canonical form
15 cmacsyma.dat		Test data (examples) for above

16 mycin.lisp		The Emycin expert system shell
16 mycin-r.lisp		Some rules for a medical application of emycin
16 mycin.dat		Test data (examples) for above

17 waltz.lisp		A Line-Labeling program using the Waltz algorithm
17 waltz.dat		Test data (examples) for above

18 othello.lisp		The Othello playing program and some strategies
18 othello.dat		Test data (examples) for above
18 othello2.lisp	Additional strategies for Othello
18 edge-tab.lisp	Edge table for Iago strategy

19 syntax1.lisp		Syntactic Parser
19 syntax1.dat		Test data (examples) for above
19 syntax2.lisp		Syntactic Parser with semantics
19 syntax2.dat		Test data (examples) for above
19 syntax3.lisp		Syntactic Parser with semantics and preferences
19 syntax3.dat		Test data (examples) for above

20 unifgram.lisp	Unification Parser
20 unifgram.dat		Test data (examples) for above

21 grammar.lisp		Comprehensive grammar of English
21 lexicon.lisp		Sample Lexicon of English
21 grammar.dat		Test data (examples) for above

22 interp1.lisp		Scheme interpreter, including version with macros
22 interp1.dat		Test data (examples) for above
22 interp2.lisp		A tail recurive Scheme interpreter
22 interp3.lisp		A Scheme interpreter that handles call/cc
22 interp3.dat		Test data (examples) for above

23 compile1.lisp	Simple Scheme compiler
23 compile2.lisp	Compiler with tail recursion and primitives
23 compile3.lisp	Compiler with peephole optimizer
23 compopt.lisp		Peephole optimizers for compile3.lisp
23 compile.dat		Test data (examples) for all 3 versions above


To use these files you must have a Common Lisp compiler.  There are
two free implementations available on the Internet, and at least four
vendors who will sell you a full industrial-strength implementation,
but only if you are willing to spend over $1000.


Kyoto Common Lisp (KCL) is free, but requires a license.
Austin Kyoto Common Lisp (AKCL) is Bill Schelter's
improvements to KCL. Both are available by anonymous ftp
from rascal.ics.utexas.edu [128.83.138.20] in the directory
/pub. KCL is in the file kcl.tar, and AKCL is in the file
akcl-xxx.tar.Z (take the highest value of xxx). 
Runs on Sparc, IBM RT, RS/6000.
Mailing List:kcl@rascal.ics.utexas.edu


CMU Common Lisp is free, and runs on Sparcs (Mach and SunOs),
DecStation 3100 (Mach), IBM RT (Mach) and requires 16mb RAM,
25mb disk. It includes an incremental compiler, Hemlock 
emacs-style editor, source-code level debugger, code profiler
and is X3J13 compatible, including the new loop macro.
It is available by anonymous ftp from any CMU CS machine,
such as lisp-rt1.slisp.cs.cmu.edu and lisp-rt2.slisp.cs.cmu.edu,
in the directory /afs/cs.cmu.edu/project/clisp/release. Login
with username "anonymous" and "userid@host" (your email address)
as password. Due to security restrictions on anonymous ftps,
it is important to "cd" to the source directory with a single
command. Don't forget to put the ftp into binary mode before
using "get" to obtain the compressed/tarred files. The binary
releases are contained in files of the form
<version>-<machine>_<os>.tar.Z
Other files in this directory of possible interest are
15b-sun4-source.tar.Z, which contains all the ".lisp" source
files used to build version 15b for Sparc machines, and
10-16-91-cmucl-master.tar.Z which contains the
project/clisp/master subtree, with RCS source (,v) files for
all of CMU CL. Bug reports should be sent to cmucl-bugs@cs.cmu.edu.

