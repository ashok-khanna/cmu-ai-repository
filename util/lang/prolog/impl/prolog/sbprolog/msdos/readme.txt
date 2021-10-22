A 386 MS-DOS port of the SB-Prolog system is available for anonymous
ftp from src.doc.ic.ac.uk [146.169.3.7] (login anonymous, password
your e-mail address) in the directory languages/sbprolog, filename
sbpmsdos.zip.  It contains everything you need in order to run the
Stony Brook Prolog System intepreter and compiler on a 386 machine
running MS-DOS.  Here is the README file from the distribution:

This is a binary release of SB-Prolog System version 3.1 for 386 MS-DOS
systems.  It was compiled using version 1.05 of the 386 MS-DOS GNU C
compiler port by D. J. Delorie.  It supports up to 128M of extended
memory and 128M of disk space for swapping.  It is compatible with XMS
and VCPI programs (such as QEMM and 386MAX), but not DPMI (such as
Windows 3.0).

In order to obey to the license agreement, this package should only be
made available together with the full source code that is covered by
it.  This means that you can make it available for anonymous ftp, only
if your machine also makes the full source code of SB-Prolog
available.  The source of SB-Prolog is available for anonymous ftp from
cs.arizona.edu:sbprolog/v3.  See the file COPYING for more
information.

In order to unpack the system correctly, the command:

	pkunzip -d sbpmsdos.zip

must be executed.  This will create the following files and directories:

README				This file
sbp.bat				Batch file to run the SB-Prolog system
sbprolog.doc			System documentation amended for MS-DOS
sim.exe				Executable for the WAM simulator
cmplib				\
lib				 } System directories
modlib				/
CHANGES				Changes from version 3.0 to 3.1
diffs				Patches for compiling the source under MS-DOS
				See Appendix 4 of the documentation for
				instructions.
frexp.c				Additional file needed for compiling
nrev.p				Naive reverse benchark
nrev.doc			Documentation on nrev.p
version				Port version


enjoy !

Diomidis
-- 
Diomidis Spinellis                  Internet:                 dds@doc.ic.ac.uk
Department of Computing             UUCP:                    ...!ukc!icdoc!dds
Imperial College, London SW7        #include "/dev/tty"


