This is the Rochester Connectionist Simulator (version 4.2); it is
COPYRIGHT 1989 University of Rochester.

This program is free software; you can redistribute it and/or modify it
under the terms of the GNU General Public License as published by the
Free Software Foundation; either version 1, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
General Public License for more details.

You should have received a copy of the GNU General Public License (in
the file named "COPYING") along with this program; if not, write to the
Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

===============================================================================

HOW TO INSTALL IT:

(0) Read the other README.* files to see if there is any machine-dependent
information that applies to you.

(1) 
	(1a) Find some free room; the source takes about 10 megabytes
	before compilation, and about 12 megabytes after compilation.
	The permanent (binary) installation requires about 2 megabytes.

	(1b) Make a directory and cd to it.  It may be named anything
	you wish.  For example,
		mkdir rcs_v4.2; cd rcs_v4.2

	(1b) Read in your distribution.
	The command to use for a reel-to-reel tape might be
		tar xf /dev/rmt8
	while for a SUN cartridge tape it might be
		tar xf /dev/rst8
	or, for a compressed tar file
		compress -d < rcs_v4.2.tar.Z | tar xBf -

	This will read the distribution into the current directory.

(2) Edit the Makefile in this directory for your site.  You need
to (re)set the following variables.  Various suggestions are provided in
the Makefile; comment out all but one for each choice.

	SRCDIR	- top level directory during compilation.
	SIMDIR	- top level directory after installation.
			(SIMDIR and SRCDIR can be the same.)
	MANDIR	- where to put the manual page.
	BINDIR	- where to put the main executable shell script.
	CC	- command to use to compile this distribution.
			WARNING: See notes below regarding the gcc compiler.
	LD	- linker to use during installation
	MLD	- linker to be used by "makesim" shell script
	NM	- command to use to extract namelists
	CCLDFLAGS - extra flags to add to final "CC" linking step in makesim.
	CCLDLIBS - extra libraries to add to final "CC" linking step in makesim.
	SIMCC	- command for simulator to use to compile code at runtime.
	SIMLD   - linker for simulator to use to dynamically link in user code.
	LDCOMPILE  - yes => distribution ld needs compiling.
	LDCOMFLAGS - for compiler to use when compiling distribution ld.
	DEFAULT_GRAPHICS - either SUN or X11 or none.
	WANT_X11   - yes => compile the X11 Graphics.
	  XUSRLIBDIR - where the X libraries are installed,
		     typically /usr/lib.
	  XINCROOT   - where the X include directory is installed,
		     typically /usr/include
	WANT_SUN   - yes => compile the SunView Graphics.

	MAKE,RM,ECHO,CP,INSTALL - commands for the makefiles to use.

(3) Make all programs.

	make clean all

    This will take about 45 minutes on a SPARCstation; your mileage may vary.
    The "clean" is recommended in general, because the Makefiles as they stand
    may leave undesirably-configured object files around between runs --
    you may accidentally come up with a mix of floating point and integer
    routines.  The makefiles will probably be improved in a future release.

(4) Install the simulator.  For this you need write permission in
    BINDIR, MANDIR and SIMDIR, and SIMDIR/{bin,include,lib}.
    You might `su' to root to do this.

	make install

    To install on a remote machine, using the same installation
    directory structure, log on to the remote machine, copy the
    Makefile to the remote machine, and type

	make remote-install REMOTE=compilemachine

    where compilemachine is the machine on which the distribution
    was compiled.

(5) Add the MANDIR directory to your MANPATH and the BINDIR
    directory to your PATH.  This enables access to the manpage
    and to the main shell script "makesim".

    Now you can go to the SRCDIR/example directory and run through the
    examples, and/or go to the SRCDIR/test directory and run through the
    non-comprehensive tests.  If you want to compile the simulator source
    -g to debug it, give makesim the -x flag after making sure that you
    have write permission in the SRCDIR/src/* directories.  If you have
    executed step (6) you will have to redo step (3) before you can debug
    the simulator sources.  If you have executed step (7), you will have to
    redo steps (1), (2) and (3).

(6) Optional: to restore the distribution directory tree to its initial state:

	make clean
	
(7) Optional: once you are sure the simulator is installed ok you can
    remove the SRCDIR directory structure (make sure you have saved the
    distribution to tape first).

===============================================================================

HOW TO GET THE SIMULATOR DISTRIBUTION:

The Rochester Connectionist Simulator is available by anonymous FTP
from "cs.rochester.edu" (192.5.53.209) on the Internet, in the
directory "pub/simulator".  That directory contains the simulator
distribution, along with an archive of official patches.

Compressed files generally have a name ending in ".Z".
REMEMBER TO USE THE "TYPE TENEX" or "TYPE BINARY" COMMAND IN FTP WHEN
RETRIEVING COMPRESSED TAR FILES!!!

The simulator is too big to mail electronically, so please don't ask.


The same files are available to subscribers of UUNET's UUCP service.
They are stored in the directory ~uucp/pub/simulator.


If you are unable to obtain anonymous FTP or UUCP access to the simulator
distribution, you can still order a copy the old-fashioned way.  Send a
check for US$150 (payable to the University of Rochester) to:
	Peg Meeker
	Computer Science Department
	University of Rochester
	Rochester, NY  14627
	(USA)
You will, in return, receive a distribution tape and a 200-page manual.
PLEASE SPECIFY WHETHER YOU WANT:
	a 1600bpi 1/2" reel
OR	a QIC-24 (SUN) 1/4" cartridge.

If you have a PostScript printer, you should be able to produce
your own copy of the manual.  If you want a paper copy of the
manual anyway, send a check for US$10 per manual (payable to the
University of Rochester) to Peg Meeker at the above address.

We do not have the facilities for generating invoices, so payment is
required with any order.

===============================================================================

JOIN THE MAILING LISTS!

There is a <simulator-users@cs.rochester.edu> electronic mailing list.  On this
list you will find the other users of the Rochester Connectionist Simulator.
We strongly recommend that you stay in touch by joining the mailing list.

If you have any ADMINISTRATIVE requests, such as mailing list additions
or deletions, please send them to
	<simulator-request@cs.rochester.edu>

Please send BUG REPORTS to
	<simulator-bugs@cs.rochester.edu>
We are interested in fixing bugs, but can't make any promises!
Please make your bug reports as specific as possible.

If you have patches to send in, please use "diff -c OLD NEW" (not NEW OLD)
to generate them.

It will often be helpful to include the output from "make show"
if you have a problem that is at all related to your configuration.

===============================================================================
