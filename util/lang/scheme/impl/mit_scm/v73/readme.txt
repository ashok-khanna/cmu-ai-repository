
	README for MIT Scheme FTP directory

	     Last change 17 Dec 1993

		  Version 7.3


This is a BETA Release.


CONTENTS OF THE FTP DIRECTORY:
-------------------------------------------------------------------------------

README		This file.

INSTALL		Installation instructions.
		This also tells you how to determine what files you
		need for a PC running DOS or Windows.

NEWS		A summmary of changes incorporated in this release.

gzip/		If you don't have the GNU gzip compression program
		already, this directory contains pre-built executables
		for all supported architectures (except DOS/NT which
		is distributed using ZIP compression).

gzip-1.2.4.tar.gz   This is a standard release of GNU gzip.

src.tar.gz		Source code for everything
src-microcode.tar.gz	Source code for microcode only

doc/		Preliminary documentation for this release.
		See doc/README for details.

*.tar.gz
*-run-bci.tar.gz
*-ed-bci.tar.gz

	For the most part, three files are provided for each supported
architecture.  The .tar file is the only one you really need.  Get the
*-run-bci.tar file (debugging info for the runtime system) if you have
a bit more disk space, as this stuff is generally useful.  Get the
*-ed-bci.tar file (debugging info for edwin) only if you have a lot of
disk space and are planning to customize the editor.

Available architectures (substitute name for * above):

    alpha	DEC Alpha running OSF/1
    hp400	HP 9000 series 300/400 running HP-UX 9
    hp700	HP 9000 series 700 running HP-UX 9
    next	NeXT running NeXTOS 2 (also known to work on 3.2)
    nws3250	Sony NEWS (MIPS), NEWS-OS 5.0.2 only
    pmax	DECStation (MIPS) running Ultrix
    rs6000	IBM RS-6000 running AIX (no native compiler)
    sgi		SGI (MIPS) running Irix 4
    sparc	Sun SPARC running SunOS 4.1 (no native compiler)
    sun3	Sun 68000 with floating-point chip, running SunOS 4.1
    sun3-nfp	Sun 68000 without floating-point chip, running SunOS 4.1

Other files:

    pc/			Intel 386/486 running DOS, NT, or Windows 3.1
			This directory contains a bunch of ZIP files;
			read INSTALL to determine what you need.

    linux.tar.gz	Intel 386/486 running Linux.
			Sorry, no debugging info provided.

REPORTING BUGS:
-------------------------------------------------------------------------------

	Please use the following email address to report bugs,
installation problems, or FTP problems:

	bug-cscheme@martigny.ai.mit.edu

Note that many of the files in this directory are large and may be
difficult to FTP to some sites.  If you are having trouble
transferring a file because it is too large and you can't keep an FTP
connection open long enough to complete the transfer, please send us
email and we will "split" the file into small pieces for you.
