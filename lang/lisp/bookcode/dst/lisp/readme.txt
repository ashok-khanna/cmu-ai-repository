		SDRAW, DTRACE, and PPMX Tools
		   Software To Accompany
  Common Lisp: A Gentle Introduction to Symbolic Computation
                   by David S. Touretzky

       Copyright (c) 1990 by Symbolic Technology, Ltd.

   Published by The Benjamin/Cummings Publishing Company, Inc.
			390 Bridge Parkway
		      Redwood City, CA 94065

****************************************************************
			*COPYRIGHT NOTICE*

These tools are made available to adopters of Common Lisp: A
Gentle Introduction to Symbolic Computation.  They are intended
for instructional use, and copies may be made for this purpose,
provided that no fee is charged for the copies.  All other uses
and distribution modes are prohibited without the prior written
permission of Symbolic Technology, Ltd.
****************************************************************

This directory contains six versions of the SDRAW and DTRACE tools
described in Touretzky's book.  Each version has a different extension:

  .generic  - Generic version
  .cmucl    - CMU Common Lisp version
  .lucid    - Lucid Lisp version
  .allegro  - Allegro Common Lisp version
  .kcl      - Kyoto Common Lisp
  .gc1      - Golden Common Lisp 1.1 version
  .gc3      - Golden Common Lisp 3.1 version

These versions differ in important ways, as outlined below.

	GENERIC VERSION 
 The generic versions of SDRAW and DTRACE are identical to those published
in Appendices A and B of the book.  The generic SDRAW will run in any legal
Common Lisp implementation.  It uses ordinary printing characters to draw
cons cell diagrams.  The generic version of DTRACE requires one
implementation-dependent function, FETCH-ARGLIST.  See the discussion in
Appendix B and the examples at the end of the source file for help on creating 
a FETCH-ARGLIST function appropriate to your Lisp implementation.


	CMUCL VERSION
 The CMUCL versions of SDRAW and DTRACE are specific to CMU's implementation
of Common Lisp.  The SDRAW implementation uses CLX, the Common Lisp-X Windows
interface, to draw high quality cons cell diagrams using bitmapped
graphics.  This implementation exploits the full functionality of CLX.  For
example, it handles window reexposure events and adjusts its display
parameters automatically when a window is resized.  Few people outside of
Carnegie Mellon run CMU Common Lisp, but this version is included because
it gives the best example of making SDRAW work with CLX.  The DTRACE
implementation contains a CMU-specific version of FETCH-ARGLIST, but is
otherwise the same as the generic version.


	LUCID VERSION
 The LUCID versions of SDRAW and DTRACE specific to release 3 of Lucid Common
Lisp.  The SDRAW implementation uses basic CLX functions to draw cons cell
diagrams on the bitmapped display, but does not respond to event
notifications like the CMU Common Lisp version.  The DTRACE implementation
is generic except for the FETCH-ARGLIST function.


	ALLEGRO VERSION
 Versions specific to Allegro Common Lisp.  The SDRAW implementation uses
CLX functions for graphics, just like the Lucid version.  Thus this version
of SDRAW can produce graphics on Suns and DEC Pmaxen, but not on the Macintosh.
The DTRACE implementation is generic except for the FETCH-ARGLIST function.

	KCL VERSION
 The KCL version of DTRACE is very close to the generic version; the
differences have to do with FETCH-ARGLIST and a peculiarity of KCL's own
trace macro.  There is no SDRAW.KCL; the generic version works fine.

	GC1 VERSION
 The GC1 versions of SDRAW and DTRACE are specific to Golden Common Lisp
version 1.1.  The SDRAW implementation uses the IBM graphic character set to
draw nice-looking cons cell diagrams.  The DTRACE implementation uses the
IBM graphic character set to produce nicer trace diagrams than the generic
version.  Support for color displays is included.


	GC3 VERSION
The GC3 versions of SDRAW and DTRACE are specific to Golden Common Lisp
version 3.1.  The SDRAW implementation uses the IBM graphic character set to
draw nice-looking cons cell diagrams.  The DTRACE implementation uses the
IBM graphic character set to produce nicer trace diagrams than the generic
version.  Support for color displays is included.


	OTHER FILES
 This directory also holds a README file, which you are now reading, and a file
ppmx.lisp containing a tool for pretty printing macro expansions.  This tool
will work in any legal Common Lisp implementation.


****************************************************************

INSTALLATION INSTRUCTIONS

1. Create a directory to hold the software.  For example, on an IBM PC
class machine, you might call the directory "C:\GENTLE".  On a Unix
machine you might call it "/usr/lisp/gentle".

2. Copy the files from the appropriate directory on this diskette into
the GENTLE directory on your machine.  You'll want one copy each of
SDRAW and DTRACE, and a copy of PPMX.  If your Lisp isn't one of those
listed above, use the generic versions of SDRAW and DTRACE.

3. Run Lisp on your machine.  At the top level read-eval-print loop,
load in the SDRAW tool.  Note: for GCLisp users, you need to type two
backslash characters instead of one when entering file names.

	(load "c:\\gentle\\sdraw.lsp")		for GCLisp

	(load "/usr/lisp/gentle/sdraw.lisp")	for Unix

4. Test the tool to make sure it works.  To test SDRAW, try this:

	(sdraw '(foo (bar) baz))

5. If your Lisp has a compiler, you should compile the tools because they
will run much faster that way.  In order to ensure correct compilation, it
is a good idea to load the source files first, as we did in step 3.  Then,
compile SDRAW by typing the following:

    (compile-file "c:\\gentle\\sdraw.lsp")		for GCLisp 3

    (compile-file "/usr/lisp/gentle/sdraw.lisp")	for Unix

The compiler will create a file called SDRAW.F2S (for GCLisp 3) or
sdraw.lbin (for Lucid) or sdraw.fasl (for some other Lisps).

6. Most Lisps have a provision for a user-modifiable init file, which can
be used to adjust various default parameter settings and load desired
software.  For example, GCLisp provides both an INIT.LSP file (for
system-wide initializations) and a USERINIT.LSP file (for personal
preferences.)  Lucid uses a file called lisp-init.lisp.

You may want to add a few lines to your init file to automatically load in
the SDRAW, DTRACE, and PPMX tools, especially if you're teaching a class
and want all students to automatically have access to them.  To
automatically load SDRAW, add a line like the following:

    (load "c:\\gentle\\sdraw.f2s")		for GCLisp 3

    (load "/usr/lisp/gentle/sdraw.lbin")	for Lucid

7. Repeat steps 3 through 6 for the DTRACE and PPMX tools.  Note that in
the case of DTRACE, if you're not using GCLisp or Lucid Lisp, you will need
to modify the FETCH-ARGLIST function in an implementation-dependent way in
order to get the full functionality shown in the book.  But DTRACE can be
made to work in any generic Common Lisp by defining FETCH-ARGLIST to return
NIL.  See the comments in the source for the generic version of DTRACE for
more information.

Note: if you're running GCLisp on a color display, you must set the
variable SYS::*MONITOR-IS-COLOR* to T in your CONFIG.LSP file in order to
enable the use of color by GCLisp programs, including SDRAW and DTRACE.
The variable must be set in CONFIG.LSP; changing it after the Lisp has
booted will not have the desired effect.
