 
The Framework for Resolution-Based Automated Proof Procedure Systems:
			  FRAPPS Version 2.0


	Alan M. Frisch, Michael K. Mitchell and Tomas E. Uribe


                (C) 1992 The Board of Trustees of the
                        University of Illinois
                         All Rights Reserved
 
COPYRIGHT NOTICE
================
 
Permission to use, copy, modify, anddistribute this software and its
documentation for educational, research, and non-profit purposes is
hereby granted provided that the above copyright notice, the original
authors names, and this permission notice appear in all such copies
and supporting documentation; that no charge be made for such copies;
and that the name of the University of Illinois or that of any of the
Authors not be used for advertising or publicity pertaining to
distribution of the software without specific prior written
permission. Any entity desiring permission to incorporate this
software into commercial products should contact Prof. A. M. Frisch,
Department of Computer Science, University of Illinois, 1304 W.
Springfield Avenue, Urbana, IL 61801. The University of Illinois and
the Authors make no representations about the suitability of this
software for any purpose.  It is provided "as is" without express or
implied warranty.
 
SYSTEM DESCRIPTION
==================

The Framework for Resolution-based Automated Proof Procedure Systems
(FRAPPS) is a set of functions written in Common Lisp that facilitate
the construction of a wide variety of resolution-based deductive
systems.  FRAPPS offers the basic functionality necessary to build
such systems, freeing users from low-level implementation concerns.
It is not intended for use in the construction of high-performance
theorem provers, but rather to provide a modular and customizable
system useful for rapid prototyping and experimentation in teaching
and research.  An extension to FRAPPS, called "Hooked on FRAPPS" or
"Constraints in FRAPPS" enables the introduction of specialized
unification procedures and constraints.

The Lisp code and users' manuals (in dvi and postscript) for FRAPPS
and Hooked-on-FRAPPS are available in this directory.  Also included
with the documentation is a published description of the system (Tomas
E. Uribe, Alan M. Frisch and Michael K. Mitchell. "An Overview of
FRAPPS 2.0: A Framework for Resolution-based Automated Proof Procedure
Systems."  In D. Kapur (ed.), _Lecture Notes in Computer Science: 11th
International Conference on Automated Deduction_.  New York:
Springer-Verlag, 1992.)

PLEASE INFORM US
================

If take (ftp) a copy of FRAPPS, we would greatly appreciate your
sending a short note to Prof. Alan Frisch (frisch@cs.uiuc.edu) to let
us know who you are, where you are and how you intend to use FRAPPS.
This will help us create a mailing list for FRAPPS users.


OBTAINING FRAPPS
================

*** Remember to change the FTP mode to BINARY ("b") before the
"get"'s. ***

"frapps.tar.Z" is all of FRAPPS, including the extension to
constraints (a.k.a. "hooked-on-FRAPPS")

"convert.tar.Z" is the OTTER-to-FRAPPS input file translator, which
can be used to translate arbitrary FOPC formulas into clausal form.

"doc.tar.Z" contains the postscript and dvi versions of the FRAPPS
manual, the "hooked-on-frapps" manual, and the CADE-11 system
description.

Once these files are copied, do "uncompress <filename>.tar".  This
will replace the file "<filename>.tar.Z" by "<filename>.tar"

tar tf <filename>.tar will tell you the contents of a tar file if you
want to make sure they're OK before un-tar-ing them.  Once you have
the uncompressed tar file in the place you want, do tar xvf
<filename>.tar

"tar xvf frapps.tar" will *create* a directory called "frapps", with
all the relevant files and subdirectories within it.  See the README
files there for more information.

"tar xvf doc.tar" will create a directory called "doc-frapps",
containing the dvi and postscript versions of the FRAPPS
documentation.

"tar xvf convert.tar" will create a directory called "convert", with
the source code and makefile, and a subdirectory with some simple test
cases.  You can compile the program (on a UNIX system) with "make
convert".  (You might have to fiddle a bit with the makefile on some
systems.)  Writing input files for "convert" requires mastering
OTTER's syntax; this should not be too hard; the sample files should
give a good idea of how this works.

INSTALLING FRAPPS
=================

All you should have to do is edit the file "init.lsp", changing the
global variables that contain the pathnames that lead to the frapps
directory (and perhaps those for file extensions).  The comments in
there should help you do this.

To check that FRAPPS is working, after loading it in (with the
function "(start-frapps)", after loading "init.lsp"), try out
"(run-demo)".  If that works, you can look into the "user.lsp" file to
see HOW it works.

You might want to make a "bin" subdirectory, where executables should
go, and set the right FRAPPS global variable accordingly.  (You can
always have the source and executables in the same directory if you
want.)  Once FRAPPS knows where executables should go, you can run
"(compile-frapps)" (after all the source code has been loaded into
LISP).  From then on you'll have a choice between interpreted and
compiled code when you run "(start-frapps)".  (The "start-frapps"
function need only be run ONCE for each Lisp session; FRAPPS is reset
with "reset-frapps".)

Note that you can set things up so that the SAME "init.lsp" file works
for more than one filesystem (and/or LISP) installation.




































