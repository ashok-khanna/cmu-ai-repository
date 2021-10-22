		    Standard ML of New Jersey
	          Version 0.93, February 16, 1993	

	 ------------------------------------------------

STANDARD ML OF NEW JERSEY COPYRIGHT NOTICE, LICENSE AND DISCLAIMER.

Copyright 1989, 1990, 1991, 1992, 1993 by AT&T Bell Laboratories

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appear in all copies and that
both the copyright notice and this permission notice and warranty
disclaimer appear in supporting documentation, and that the name of
AT&T Bell Laboratories or any AT&T entity not be used in advertising
or publicity pertaining to distribution of the software without
specific, written prior permission.

AT&T disclaims all warranties with regard to this software, including
all implied warranties of merchantability and fitness.  In no event
shall AT&T be liable for any special, indirect or consequential
damages or any damages whatsoever resulting from loss of use, data or
profits, whether in an action of contract, negligence or other
tortious action, arising out of or in connection with the use or
performance of this software.

	------------------------------------------------

This file describes how to obtain the latest release of Standard ML of
New Jersey, version 0.93.

Send comments and bug reports to:

   sml-bugs@research.att.com

or, if only paper mail is available, to:

   David MacQueen
   Room 2A-431
   AT&T Bell Laboratories
   Murray Hill, NJ 07974
   USA
   phone: 908-582-7691

The Release Notes, found in files releaseNotes.{txt,ps}, contain
instructions for installing the compiler and a more detailed
description of the distribution. 


FTP distribution instructions:

The primary means of distributing the compiler is anonymous internet
ftp.  For those who do not have internet access directly or
indirectly, distribution by tape may be possible as a last resort.
The following table gives the ftp connection information.

Host:		 	Net Address:	  Directory:
----------------------------------------------------
princeton.edu	 	128.112.128.1	  /pub/ml
research.att.com 	192.20.225.2	  /dist/ml

The directory pub/ml (dist/ml on research.att.com) contains this
README file and the following compressed tar files:

93.releaseNotes.ps   	Postscript version of Release Notes
93.releaseNotes.txt  	raw text version of Release Notes
93.src.tar.Z      	source code for the compiler
93.doc.tar.Z      	documentation directory (manpages, papers, help, ...)
93.tools.tar.Z    	tools directory (mlyacc, twig, sourcegroups, ...)
93.contrib.tar.Z	contributed, unsupported software
93.mo.m68.tar.Z   	object files for the MC68020 (Sun-3, HP, Sony, etc.)
93.mo.sparc.tar.Z 	object files for the SPARC (Sun-4)
93.mo.mipsl.tar.Z 	object files for the little-endian MIPS (DECstation)
93.mo.mipsb.tar.Z 	object files for the big-endian MIPS (MIPS, SGI)
93.mo.rs6000.tar.Z      object files for the RS6000
93.mo.i386.tar.Z	object files for the Intel 386
93.mo.hppa.tar.Z	object files for the HPPA 
93.mac.tar.Z		files for the Macintosh under MacOS
smlnj-lib.0.1.tar.Z    	the Standard ML of New Jersey Library
CML-0.9.8.tar.Z		Concurrent ML
eXene-0.4.tar.Z		eXene - a multithreaded X Windows toolkit

You need only transfer the 93.mo.*.tar.Z files that you need for your
machines (e.g. 93.mo.m68.tar.Z for Sun 3, NeXT, etc., 93.mo.sparc.tar.Z
for SPARCstations).  

***************************************************************************
NOTE: Ftp should be put into binary mode before transferring the compressed
tar files.
***************************************************************************

Here is a sample dialog:

   ftp
   ftp> open princeton.edu
   Name: anonymous
   Password: <your name@host>
   ftp> binary
   ftp> cd pub/ml
   ftp> get README
   ftp> get 93.src.tar.Z
   ftp> get smlnj-lib.0.1.tar.Z
   ftp> get 93.tools.tar.Z
   ftp> get 93.doc.tar.Z
   ftp> get 93.mo.m68.tar.Z
   ftp> get 93.mo.rs6000.tar.Z
   ftp> close
   ftp> quit

After the files are transferred they should be uncompressed 
and then extracted using tar into a directory called (e.g.) mldist.
For example:

   mkdir mldist
   mv 93.src.tar.Z mldist
   cd mldist
   zcat 93.src.tar.Z | tar xof -

will install the src directory. 
