-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-

	   Instructions for Retrieving the Garnet Software
			   October 15, 1993
			     V2.2 RELEASE

These instructions are for the official release of version 2.2 of Garnet.
The following assumes you run Unix and can FTP from CMU.  This is the README
file for retrieving and compiling Garnet.  There is another README file
in the doc directory that explains how to print the Garnet manual.

The Garnet manual has been completely revised for version 2.2, and you
can retrieve it by following the instructions below (it is about 600
pages).  There is also a change document that accompanies the manual,
which describes all the changes that have been put in since the 2.1
release.  If you cannot print out the documentation, we will mail you
a hardcopy if you send a check for $35 (US) made out to "Carnegie
Mellon University" to:
	Brad A. Myers
	School of Computer Science
	Carnegie Mellon University
	5000 Forbes Avenue
	Pittsburgh, PA  15213-3890
If you have trouble printing the manuals, some people have reported
that it works better to change the top line of each postscript file from
    %!PS-Adobe-2.0
to be just
   %!

Note: There is an internet bulletin board for discussing Garnet,
called comp.windows.garnet.  If you cannot access that, then please
send mail to to garnet@cs.cmu.edu or garnet-request@cs.cmu.edu to
be added to the mailing list (which contains the same messages as the
bboard).  To send mail to the Garnet maintainers, send to
garnet-bugs@cs.cmu.edu.  Posting to the bboard or sending mail to
garnet-users@cs.cmu.edu will send the message to all garnet users all
over the world.  All administrative questions about the mailing list should
be sent to garnet-request@cs.cmu.edu.

If you are running Garnet from CMU, or if you have access to AFS, you
can access Garnet directly on the afs servers.  The official release of
Garnet is stored in
	/afs/cs.cmu.edu/project/garnet/src
	/afs/cs.cmu.edu/project/garnet/lib

We are keeping binaries of the official version.  The binaries
are in different subdirectories, depending on what your machine type
you have.  The new version of Garnet-Loader will try to choose the
correct binary format.  If you are using a Sparc Station to run
Allegro, CMUCL, or Lucid, or you are using a DECstation to run
Allegro, or you are using an HP to run Lucid, then you can load garnet
with
	(load "/afs/cs.cmu.edu/project/garnet/garnet-loader")
If it cannot find a binary to load, then it will let you know.  Please
contact garnet@cs.cmu.edu and we might maintain a binary for you.

For non-CMU users, or people with other types of machines and/or lisps, you
will need to FTP the software and compile it yourself.  The Garnet software
and documentation takes about 23 megabytes of disk space:
	Source code: 6 megabytes
	Binaries (actual size depends on your lisp): about 10 megabytes
	Lib: 0.5 megabytes
	Documentation: 6 megabytes
Therefore, you first need to find a machine with enough room on the
disk, and then create a directory called garnet wherever you want the
system to be:
	% mkdir garnet
(If you already have a copy of Garnet, you might want to move the old contents
of the garnet directory somewhere, in case you need to go back.  Otherwise,
delete all the contents of the garnet directory.)

Then, cd to the garnet directory.
	% cd garnet
Now, ftp to a.gp.cs.cmu.edu (128.2.242.7).  When asked to log in, 
use "anonymous", and your name as the password.
   % ftp a.gp.cs.cmu.edu
   Connected to A.GP.CS.CMU.EDU.
   220 A.GP.CS.CMU.EDU FTP server (Version 4.105 of 10-Jul-90 12:07) ready.
   Name (a.gp.cs.cmu.edu:bam): anonymous
   331 Guest login ok, send username@node as password.
   Password:
   230 Filenames can not have '/..' in them.

Then change to the garnet directory (note the double garnet's) and use
binary transfer mode:
	ftp> cd /usr/garnet/garnet
	ftp> bin

The files have all been combined into TAR format files for your convenience.
These will create the appropriate sub-directories automatically.  We
have both compressed and uncompressed versions.  For the regular
versions, do the following:
	ftp> get src.tar
	ftp> get lib.tar
	ftp> get doc.tar

To get the compressed version, do the following:
	ftp> get src.tar.Z
	ftp> get lib.tar.Z
	ftp> get doc.tar.Z

Now you can quit FTP:
	ftp> quit

If you got the compressed versions, you will need to uncompress them:
	% uncompress src.tar.Z
	% uncompress lib.tar.Z
	% uncompress doc.tar.Z

Now, for each tar file, you will need to "untar" it, to get all the original
files:
	% tar -xvf src.tar
	% tar -xvf lib.tar
	% tar -xvf doc.tar

This will create subdirectories will all the sources in them.  At this point
you can delete the original tar files, which will free up a lot of disk space:
	% rm *.tar

Now, copy the files garnet-loader.lisp, garnet-compiler.lisp, 
garnet-prepare-compile.lisp, and garnet-after-compile from the src directory
into the garnet directory:
	% cp src/garnet-*  .

The file garnet-loader.lisp contains path names for all the parts of garnet.
You will now need to edit garnet-loader.lisp in an editor, and define the
location of your top-level Garnet directory.  Comments in the file will direct
you on how to do this.  At the top of the file are two variables you will need
to set:  Your-Garnet-Pathname and Your-CLX-Pathname.  These are used for all
the :external branches of the loader.
	% emacs garnet-loader.lisp (or whatever editor you use)

NOTE: Some people running Sun Common Lisp or Lucid Common Lisp V4.0.1 on
Sun OS version 4.0 have reported a problem with the multiple process
code in Garnet.  This is due to a bug in the Lisp.  Upgrading to
version 4.0.2 or 4.1 of Lucid will fix this problem.  Or else, please edit
the line in Garnet-Loader that sets launch-process-p to make it be NIL if
you are using the older version of Lucid on Suns.  As described in the
manual and tour, you will then need to run (inter:main-event-loop)
explicitly at various times (but not when running the demos since they
run it for you).

NOTE: Some people using CMUCL have reported that they have to click several
times in a Garnet window before the click events are processed.  This is due
to a bug in the CMUCL implementation of CLX.  To fix the bug, load CLX into
your CMUCL image and recompile the file code/serve-event.lisp which can be
found in your CMUCL source files.  If your lisp image already includes CLX
(i.e., you do not load CLX explicitly at the beginning of a Garnet session),
then you will have to reload the compiled file each time you start CMUCL.
Alternatively, you could make a new core image of CMUCL after loading the
compiled file, so that the fix is included every time you start lisp.

Lisp requires very large address spaces.  We have found on many Unix
systems, that you need to expand the area that it is willing to give
to a process.  The following commands work in many systems.  Type
these commands to the C shell (csh).  You might want to also put these
commands into your .cshrc file.
	% unlimit datasize
	% unlimit stacksize

Note: If you are running OpenWindows from Sun, you will need to add
the following line to your .Xdefaults file to make text input work
correctly:
	OpenWindows.FocusLenience:		True

To compile or load Garnet, the Unix environment variable DISPLAY
must be set correctly.  Typically, the variable will be set with
something like unix:0.0.  If you are running on a remote machine
different from the one you want the windows to appear on, you can do
something like:
	setenv DISPLAY mymachine.garnet.cs.cmu.edu:0.0
The setenv call might be put in your .login file.  You can check the
value of the DISPLAY variable (note it must be in all capitals), using
	echo $DISPLAY
There is more information on the DISPLAY variable in the V2.2 full manual on
page 207.

Now, you will need to compile the Garnet source to make your own binaries.
This is achieved by loading the compiler scripts.  There is more information
on compiling in the full V2.2 reference manual on page 12:
	lisp> (load "garnet-prepare-compile")
	lisp> (load "garnet-loader")
	lisp> (load "garnet-compiler")

Now Garnet is all compiled and loaded, so you can run Garnet code.  To
set up for the next time, however, it is best to quit lisp now, and
run a shell script to move all the binaries to the correct places.  If
your sources are not in a directory named garnet/src or your binaries
should not be in a directory named garnet/bin, then you will need to
edit garnet-after-compile to set the directories.  Also, if your
compiler produces binary files that do not have one of the following
extensions, then you need to edit the variable CompilerExtension in
garnet-after-compile: ".fasl", ".lbin", ".sbin", ",hbin", or ".sparcf".
Otherwise, you can just execute the file as it is supplied (note: this is
run from the shell, not from Lisp).  You should be in the garnet directory.
	% csh garnet-after-compile

Now you can start lisp again, and load Garnet:
	lisp> (load "garnet-loader")

Full instructions for how to load and then run Garnet are in the 
Garnet 2.2 Reference Manual on page 12.

You might now want to read the introductory material in the manual, 
and then run the "tour" and read the "tutorial".

Thanks again for your interest in Garnet, and we hope that it works
well for you.
