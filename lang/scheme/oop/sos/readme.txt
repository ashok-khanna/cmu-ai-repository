
					October 7, 1993


This directory contains the source code and documentation for SOS, an
object-oriented programming system for Scheme.  The contents are as
follows:

    "doc/" contains documentation for the system.  The documentation
    is written in the Texinfo formatting language.  In addition to the
    documentation source file, there is an Emacs Info file and a TeX
    .dvi file.

    "src/" contains the source code for use with MIT Scheme.  This
    code is known to work in MIT Scheme release 7.2, and will probably
    work in release 7.1.  As of this date, 7.2 is not released, but we
    plan to release it in about one month.  To compile the code, load
    the file "compile.scm".  To load the compiled code, load the file
    "load".

    "sc/" contains the source code for use with Scheme->C.  This code
    is known to work in the 15mar93 release; it does not work in any
    earlier release.  To compile the code, edit the "CFLAGS" line in
    "Makefile", then "make all"; this will create an executable called
    "sos".

NOTE WELL: this software is not supported, either by me or by the MIT
Scheme project.  Modifications or extensions to this software must be
implemented by YOU.  Bugs in the implementation, or, more
specifically, incorrect operation of the program as defined by the
documentation, may be reported to me at the email address appearing
below.  Please do NOT send email asking me to do anything other than
fix bugs in the software.

As usual, this software may be copied, distributed, modified,
extended, or embedded according to the terms of the copyright.  If you
use or modify this software in an interesting way, I would like to
hear about it.


Chris Hanson
cph@zurich.ai.mit.edu
