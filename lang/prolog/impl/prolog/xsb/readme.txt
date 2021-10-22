This directory contains the distribution files for the XSB system (and
the SLG metainterpreter.) XSB is an extension of an Edinburgh Prolog
system to include an efficient implementation of memoization and an
initial implementation of HiLog. SLG is a metainterpreter (that runs
under Quintus Prolog, SICStus Prolog and XSB) that implements SLG
resolution for general logic programs.

Files:

README: this file

XSB.tar.Z: The tarred and compressed distribution file for the XSB
system.  The XSB system supports table declarations for predicates,
which tell the system to maintain tables and not to make multiple
calls to the same subquery. This allows the XSB system to be used as
an in-memory Deductive Database system since it is complete for
Datalog queries.  The implementation is done by extending the WAM, so
it is quite efficient.  The XSB implementation of HiLog is not yet
completed.  The system will execute HiLog programs but they may be
quite inefficient.  XSB comes with all source code (in C and Prolog),
a Users Manual, and some technical documentation on its
implementation.

slg.tar.Z: The tarred and compressed distribution file for the SLG
system.  The SLG metainterpreter implements SLG resolution (PODS'93,
Chen and Warren), which is a partial deduction framework which reduces
queries while preserving the partial stable model semantics (or
3-valued stable model semantics.) It can be used directly to find
answers with respect to the well-founded semantics. The residual
program could be further evaluated to find answers with respect to the
partial stable model semantics. For further information on the SLG
meta-interpreter, see the file README_slg in this directory.

README_slg: More information on the SLG subsystem.

experXSB.tar.Z: (This file may or not be in this directory.) If this
file is here, it is an experimental version of XSB, which contains
more recent additions, which may not have been thoroughly tested. It
may also contain a version that has been ported to a wider variety of
machines than that in XSB.tar.Z. This file contains our most recent
version of XSB (if it differs from XSB.tar.Z). You may take it if you
wish (or are advised to) but beware.


The following is a list of instructions on how to ftp and install XSB.

     1) Issue FTP command to connect to our ftp server

                ftp sbcs.sunysb.edu or ftp 130.245.1.15

        When asked for Name, respond with "anonymous".
        When asked for Password, respond with your e-mail address.

     2) Issue the following change directory command to where the XSB system is
 
                cd pub/XSB
 
     3) Change transfer mode to binary
         
                binary
 
     4) Now retrieve the XSB system
 
                get XSB.tar.Z
 
     5) Exit the ftp program
 
                quit
 
     6) Now uncompress and untar the files
 
                uncompress -c XSB.tar.Z | tar xvf -

        Note that this command uncompresses the files into the current
	working directory, and creates a directory named XSB.
 
     7) Change directory to XSB

		cd XSB

	This directory should now contain some files (among which there should
	be one named "makeall"), and the following 6 directories: 

		cmplib, emu, examples, lib, manual, and syslib.

	Note that after the installation of XSB the directory structure of XSB
	should be maintained.  If at some point you want to move the directory
	where the original installation took place, you should re-install the
	XSB system in the new place.

     8) Read carefully the License Agreement for XSB found in the file LICENSE.

		more LICENCE

	This should be done before executing step 9 below.  By installing the
	XSB system you automatically agree to the contents of the LICENCE file.

     9) Install the XSB system by running the C-shell script "makeall"
	in this directory.  Unfortunately, this script cannot be run for
	Amiga machines running AmigaDOS and the whole process has to be
	done manually according to the instructions found at the end of
	this step.  It will prompt for the type of the machine
	that is being used.  Currently only "sun", "NeXT", "linux" (for
	80386/80486 based machines running Linux), "SGI", "HP300",
	"DECstation", and "IBM" are accepted, as input at this point.
	It will also prompt for the name of the C compiler to be used.
	Type "cc" if the name of the C compiler to be used is cc, or type
	"gcc" if you wish to install XSB with the Gnu C compiler.
	If for some reason something goes wrong while installing the system
	consult chapter 3 of the XSB manual, where you can find a more
	detailed description of the installation options. (see step 12)

	[For Amiga machines running AmigaDOS]
	  1. Edit the Makefile in the emu directory and manually replace
		- MACHINE=whatever	with	MACHINE=AMIGA
		- DIR=whatever		with	DIR=a valid Amiga directory
					name where you want XSB installed
					(e.g. "DIR=work:languages/Prologs/XSB")
		- (optional) CC=cc 	with	CC=gcc
	  2. While in the emu directory issue the following command
		make
	     This command will create an executable file named xsb.

    10) The Prolog byte code files in cmplib, syslib and lib should not
	have to be recompiled except under exceptional circumstances
	(such as corruption during ftp transmission), as they are machine
	and installation procedure independent.

    11) (Optional) Remove the compressed XSB system

                rm ../XSB.tar.Z

    12) The XSB Programmer's Manual (in LateX, dvi and Postcript format)
	resides in the directory manual.  In case the dvi or Postcript files
	are corrupted, you can type "latex manual" twice in the manual 
	directory to obtain the manual.dvi file.

    13) For those familiar with Prolog interpreters, the XSB interpreter
	can be called by the command

		emu/xsb -i

	All Prolog standard predicates are provided.  Those unfamiliar with
	Prolog systems, should read chapters 2 and 3 of the XSB manual to
	find out how to consult files and call predicates.

    14) Some sample programs and benchmarks are in the directory "examples".

    15) Have fun with the XSB system...


Note that some of these instructions apply only to Berkeley derived 
Unix, eg BSD, SunOS, etc.
 

Once you obtain XSB, please register as an XSB user.  If you do so, you
will be included in a mailing list for future releases or major bug-fixes.
To register, all you have to do is send either a high-tech or low-tech mail
consisting of your name, institution, and address (preferably e-mail) to the
addresses below:

 - high-tech address:

	e-mail: xsb-contact@cs.sunysb.edu

 - low-tech address:

	XSB
	Department of Computer Science
	SUNY at Stony Brook
	Stony Brook, NY 11794-4400
	U.S.A.

Please address all comments and bug reports to the addresses above.
We will be happy to hear from you or to assist you in any possible way.

