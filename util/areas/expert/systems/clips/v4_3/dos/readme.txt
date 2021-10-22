                        CLIPS Release Notes

                    Version 4.3      June 13, 1989

This file contains any last minute information pertaining to this
version of CLIPS that was not included in the Reference Manual. It
also contains information of general use about CLIPS, such as where
to report problems, how to get CLIPS, and a description of any known
problems with the documentation or program.

DISTRIBUTION DISKS
------------------
If you received CLIPS on MS_DOS floppy disks, you should have
received twelve 360K disks. The essential contents of each disk is
listed below:

CLIPS SOURCE CODE DISK 1 : Some of the CLIPS Source Code along with 5 make
                           files for 5 different compilers.

CLIPS SOURCE CODE DISK 2 : More CLIPS Source Code.

CLIPS SOURCE CODE DISK 3 : More CLIPS Source Code.

CLIPS SOURCE CODE DISK 4 : More CLIPS Source Code.

MS-DOS EXECUTABLES DISK 1 : CLIPS.EXE, CLIPS help file, CLPSUTIL.EXE and
                            some miscelaneous key-color binding files.

MS-DOS EXECUTABLES DISK 2 : CLIPSWIN.EXE and PC interface help file.

MS-DOS EXECUTABLES DISK 3 : A demonstration executable along with some CLIPS
                            example files.

CLIPS UTILITIES DISK 1 : CRSV utility Executable and some of the CRSV source
                         files.

CLIPS UTILITIES DISK 2 : More CRSV source files.

CLIPS UTILITIES DISK 3 : More CRSV source files.

CLIPS UTILITIES DISK 4 : PC interface source code.

CLIPS UTILITIES DISK 5 : More PC interface source code.


NOTE:
-----

The CLIPS executable without the PC interface, i.e. CLIPS.EXE, has a very
limited number of options turned on in SETUP.H. To find out what all the
capabilities of CLIPS.EXE are, please enter the command: (options) while
running CLIPS.EXE. This was intended to show how small a CLIPS executable can
be. The CLIPSWIN.EXE, i.e. CLIPS with PC interface, has many more options on.
If one needs a CLIPS executable with more capabilities, but without the PC
interface, please refer to the Programming Guide on how to compile CLIPS.
Also, see the note below on make files for CLIPS.

The following is a list of categories of files with the corresponding sizes:

All of the distribution diskettes                          3750000  Bytes
The CLIPS executable                                        296598  Bytes
The CLIPS executable with the user interface                412417  Bytes
The CRSV utility executable                                 187326  Bytes
The DEMOnstration executable                                155604  Bytes
Some CLIPS examples                                          51835  Bytes
The CLIPS source files                                     1229567  Bytes
The CLIPS user interface source files                       484697  Bytes
The CRSV utility source files                               834570  Bytes



If you received CLIPS on Macintosh floppy disks, you should have
received four 800K disks. The essential contents of each disk is
listed below:

Disk 1 : CLIPS executable with user interface,
         help file, some CLIPS examples, projects and resource files
         for CLIPS and CRSV, README files

Disk 2 : Some of the CLIPS souce files

Disk 3 : More CLIPS source files,
         CLIPS MAC interface source code

Disk 4 : CRSV utility source code,
         CRSV executable with user interface.




HOW TO GET CLIPS
----------------
CLIPS was developed by the Artificial Intelligence Section of the
Mission Planning and Analysis Division at NASA/Johnson Space Center.
CLIPS is available to NASA groups by calling the CLIPS Help Desk
between the hours of 9:00 AM to 4:00 PM (CST) Monday through Friday
at (713) 280-2233. NASA contractors should have their contract
monitor call the CLIPS Help desk to obtain CLIPS.

CLIPS is available outside of NASA through COSMIC, the NASA software
distribution center. The cost of CLIPS is about $350 for both source
code and MS-DOS or Macintosh executable. Unlimited copies can be made
after purchasing CLIPS through COSMIC. The same source code will run
on nearly any machine which can support an ANSI or K&R C compiler.
The COSMIC program number is MSC-21208. COSMIC can be contacted at:

     COSMIC
     382 E. Broad St.
     Athens, GA  30602
     (404) 542-3265


PROBLEMS INSTALLING OR USING CLIPS
----------------------------------
CLIPS is not a commercial product, and is not supported to the extent
that a commercial product normally would be. However, NASA employees
can obtain some help with CLIPS problems by calling the CLIPS Help
desk. The Help desk is available between the hours of 9:00 AM to 4:00
PM (CST) Monday through Friday at (713) 280-2233. Callers should
leave a description of their problem and a phone number and they will
be contacted. Outside organizations should use the bug report forms
included with the CLIPS documentation to report problems with CLIPS.




VAX-VMS TERMINAL CONFIGURATION FOR CORRECT EMACS EDITOR USAGE:
--------------------------------------------------------------

The EMACS editor in CLIPS does not support anything beyond VT100 on VAX/VMS.
For newer terminals such as VT240, users need to set the terminal type in their
LOGIN.COM file to emulate VT100 as follows :

A) $SET TERM/DEVICE = VT100
B) From the VT240 terminal press F3 key which gets General Setup Menu.
   Move to 3rd item on the top row, i.e. VT100.
   Hit return until select VT100.
   Press F3 key to leave at VT100.

Users should do both A & B.
If you don't emulate VT100, you will be continuously kicked out of the CLIPS
editor back to the VAX DCL command line at random and you may lose your
file(s).


WARNINGS, THINGS TO WATCH OUT FOR
---------------------------------
The following section describes common problems users have with
CLIPS, or things to be aware of when using CLIPS. If you are having
unusual problems, check this section and the next one before
reporting a bug.

1) Using the integrated editor to edit large files and then execute
them in CLIPS could cause severe memory problems on a PC. The editor
itself does not take up all that much memory, but a large file of
rules that is in the editor and then loaded into CLIPS could cause
the machine to do any of three things; completely hang, exit to DOS
with some kind of error message, or warn about memory failures and
refuse to compile a rule or file. The moral is when working on a PC,
use a PC with as much memory as possible, and avoid editing large
files while in CLIPS. The Macintosh generally does not have
as severe a memory limitation for rules, however, the Macintosh editor
is limited to 32K files.

2) Because of differences in machines, the allowable range of values
a CLIPS number may have can vary. Particularly, the largest or
smallest allowed value on one machine may cause floating point
overflows on another.

3) If errors occur while loading CLIPS rules, the system can be left
in an inconsistent state. For example, if the new rule is supposed to
replace an existing rule, after the error is found, neither rule
exists, since the old rule is excised first. Other kinds of errors
can be harder to detect. If errors occur while loading a rule, and
subsequent actions don't appear to be working right or you get system
error messages, it is best to exit CLIPS and start over.

4) If a SYSTEM NET ERROR message ever occurs, it means that the
pattern network has been "trashed" by some previous action (such as
some kinds of rule loading errors). The only real solution to this
problem is to exit CLIPS and reload all the rules.

5) Because it appears the VAX implementation of extern does not conform to
either ANSI or K&R, VAX VMS will not link with the file
edterm.obj in a library unless you use the /Include option. Or you can
link directly with edterm.obj.

6) If one uses the option "r+" to read from and write to a file, in the case
that the file does not already exists, CLIPS will not be able to find it.
The above option should only be used for files that already exist. So, if
one wants to read to and write to the same file that not necessarily exists,
they should check if it already exists or open for writing, i.e. "w", and
close immediately prior to accessing with "r+".

7) If you have color/key-binding data files generated by the prototype
CLPSUTIL.EXE distributed with a few very recent CLIPS 4.2 copies, they are
no longer useful for the new CLPSUTIL.EXE distributed with CLIPS 4.3. You
will need to remake those data files.


KNOWN PROBLEMS WITH CLIPS
-------------------------
The following section describes any known problems with CLIPS. Where
possible, work arounds or fixes will also be described

1) CLIPS typically won't allow a single symbol or string longer than
512 characters. Under most cirumstances, if CLIPS finds to long a
symbol or string, it prints an appropriate error message. However, if
a user types in a string at the top level that is longer than 512
characters, CLIPS may not handle it properly.

2) If SYSTEM V is used to compile and link the CLIPS executable on an
Apollo, retraction of the initial-fact would cause a fatal error. The work
around is to compile and link under BSD 4.2 or 4.3 and then use the
executable in either SYSTEM V or BSD environment.

MAKE FILES FOR CLIPS version 4.3
---------------------------------
----- DOS -----
On the CLIPS Source Code Diskette #1 there are make files to
recompile CLIPS for three DOS C compilers:

MSCCLIPS.MAK  for Microsoft C 5.1

TCCLIPS.MAK   for Turbo C 1.5 or 2.0

ZCLIPS.MAK    for Zortech C 1.07

These make files require the use of a linker response file, CLIPSOBJ.430,
which you will also find on the disk.  Since every make program is different
be sure to read the make file comments before using them.  You may also want
to consult the various vendors reference manuals concerning their
implementations of make.  These make files above have all been tested and
then copied to disk.  Before using these make files make certain the
appropriate CLIPS compiler option flags are set on or off in the file SETUP.H

----- UNIX -----
There are also two make files for UNIX systems:

SCOCLIPS.MAK  for SCO Xenix 2.2.3

UNXCLIPS.MAK  for general UNIX boxes

These make files do not require linker response files.  However because they
were copied to DOS diskettes from UNIX systems, necessary tabs were lost.
If you copy them back to UNIX boxes be sure to read the comments about where
to edit (only two places) and restore tabs necessary for correct operation.
You may also have to change the paths were the libraries libtermcap.a and
libm.a are found on your system if different than in the make files.  Before
using these make files make certain the appropriate CLIPS compiler option
flags are set on or off in the file SETUP.H

You should have noted from earlier comments in this file that compiling and
linking CLIPS under SYSTEM V on an Apollo produces an unusable executable.
However you should be able to compile and link under BSD and then use the
executable in either environment.


CLIPS PC-WINDOW INTERFACE
-------------------------
The interface for the PC-Window version of CLIPS was created with a
commercial software package - CURSES.  The vendor is Aspen Scientific, PO
Box 72, Wheat Ridge, Colorado 80034-0072, (303) 423-8088.


