Macintosh CLIPS, version 5.0

To get version 5.0 for your macintosh, you will need to get the two
files:

  mac-clips-50-1.hqx     (1 Mb)
  mac-clips-50-2.hqx     (1 Mb)

Once you download these files, you need to use a utility (such as
Binhex or Stuffit!) to unbinhex them into applications.
These two applications each unstuff themselves into the CLIPS and CRSV
executables and their source codes.  The executables will fit on
an 800K disk each.

Following is the original CLIPS README.TXT file included on
the CLIPS distribution disks.

Enjoy!

(Uploaded by Brent Burton (bpb9204@tamsun.tamu.edu or brentb@cs.tamu.edu)
 with the information gained from comp.ai.shells.  I was told it was OK
 to redistribute the CLIPS distribution via ftp, and it has already been
 done by others.)

--------------------------------------------------------------

                     CLIPS Release Notes (README.TXT)

                      Version 5.0      March 22, 1991

   ==========================================================
   |        NOTICE OF COMPUTER PROGRAM USE RESTRICTIONS             |
   |This computer program is furnished on the condition that it be  |
   |used only in connection with the specific cooperative project,  |
   |grant or contract under which it is provided and that no further|
   |use or dissemination shall be made without prior written         |
   |permission of the NASA forwarding officer. [NASA JSC PT4]      |
   |      RESTRICTED TO USE FOR US GOVERNMENT PURPOSES ONLY!    |
   ==========================================================


This file contains any last minute information pertaining to this version of
CLIPS that was not included in the Reference Manual. It also contains
information of general use about CLIPS, such as where to report problems, how
to get CLIPS, a description of any known problems with the documentation or
program.

********************************************************************                   N O T I C E     P C     U S E R S

The clips.exe file is built with overlays and will run EXCRUCIATINGLY slow on
808x and 8028x based computers WITHOUT expanded or extended memory.  You can
recompile it with the supplied make files (explained below) without overlays
but you cannot have the object system and other features on because you will
run out of memory upon simply loading the executible.  For more information
see WARNINGS and GENERAL INFORMATION sections below.
*******************************************************************

DISTRIBUTION DISKS
------------------
If you received CLIPS on MS_DOS floppy disks, you should have received four
360K or two 1.2M disks.   Disk 1 contains the installation program, this
README.TXT file, make files and some of the compressed programs.  Disks 2-4
contain the remainder of the compressed programs.

NOTES:
-----
---INSTALLING ON AN IBM PC OR COMPATIBLE:---

As mentioned above, for the IBM PC and compatible, we have added an
installation program on the diskette labeled CLIPS 5.0 Disk 1. It lets you
choose any category of files you want to copy and where you want them put on
the hard disk. In addition to that, the installation program will check to
determine if there is enough space on the hard disk for you to copy the files
you chose. Because the files on the disks are compressed, you MUST use the
installation program to decompress and install the desired files.  You can
start the installation program from either the floppy or from your hard disk by
typing a:install and selecting from the installation menu.

The following is a list of choices you have for installing CLIPS on your Hard
Disk along with APPROXIMATE corresponding, UNCOMPRESSED sizes:

All of the distribution diskettes                     4,535,355 Bytes
1.  The CLIPS executable                                    515,184 Bytes
2.  The CRSV utility executable                         245,634 Bytes
3.  The DEMOnstration executable                        155,604 Bytes
4.  Some CLIPS examples                                       74,888 Bytes
5.  The CLIPS source files                                  2,648,816 Bytes
6.  The CRSV utility source files                        1,011,129 Bytes

As mentioned earlier, the first step is to invoke the INSTALL.EXE. From then
on, simply make your selection and follow instructions.  The only other
information the installation software needs from the user is the name of the
directory where you want the selection to be copied. If the directory does not
exist, the installation program creates it. WHEN YOU ARE ASKED TO ENTER THE
DIRECTORY NAME(s), YOUR INPUT SHOULD BE THE FULL PATHNAME TO THE DIRECTORY.

---INSTALLING ON A MACINTOSH:---

If you received CLIPS on Macintosh floppy disks, you should have received two
800K disks.  Disk 1 contains a self extracting program for the CLIPS source
code as follows:

DISK 1:  Contents                                      Files           Size
             --------                                      -----           ----
Interface source folder                                 35             585k
Kernel source folder                                    129           2,593k
CLIPS 5_0 Symantec Think C Project               1               77k
CLIPS 5_0.Rsrc resource for Project                1              23k
README.TXT                                                      1              26k
                                                                                    ------
                                                                                     3,304k Total

To install this source, create a folder on your hard disk where you want the
code to be placed, then double click on the icon and respond to queries as they
appear.


Disk 2 contains two self extracting programs.  CLIPS and CRSV executables with
examples are in one self extracting program and the CRSV source is in another.


DISK 2:  Contents                                   Files           Size
         --------                                      -----           ----
  Executables                                                            800k Subtotal
V5.0 Examples folder                                   9             78k
CLIPS 5.0 interface exe   cutable                 1            468k
CRSV 1.3 executable                                    1            194k
CLIPS.hlp                                                     1             60k

  CRSV Source                                                           968k Subtotal
CRSV interface source folder                       7             132k
CRSV 1.3 command line source folder         21             813k
CRSV1_3 Symantec Think C Project              1              15k
CRSV1_3.Rsrc resource for Project               1               8k
                                                                                  -----
                                                                                 1,768k Total

To install this code, create a folder on your hard disk where you want the code
to be placed, then double click on the icon and respond to queries as they
appear.

HOW TO GET CLIPS
----------------
CLIPS was developed by the Software Technology Branch of the Information
System Directorate at NASA/Johnson Space Center. CLIPS is available to NASA
and USAF government organizations and their contractors by calling the STB
Products Help Desk between the hours of 8:00 AM to 4:45 PM (CST) Monday
through Friday at (713) 280-2233. Use of CLIPS is restricted as indicated in
the NOTICE at the top of this file and on each diskette.  US Government
contractors should have their contract number, government monitor's name and
phone number to provide to the STB Products Help desk to obtain CLIPS.  An
answering machine will take a message at other hours or when the line is
busy.  You may also use our electronic bulletin board to obtain information or
leave us a message. The numbers are (713) 280-3896 and (713) 280-3892; set
your modem at 300, 1200, or 2400 baud, no parity, 8 data bits and 1 stop bit.
The bulletin board operates 24 hours a day, seven days a week except for
maintenance.

CLIPS is available outside of the NASA and USAF and their contractors through
COSMIC, the NASA software distribution center. The cost of previous versions of
CLIPS has been about $350 for both source code and MS-DOS or Macintosh
executable. Unlimited copies can be made after purchasing CLIPS through COSMIC.
The same source code will run on nearly any machine which can support an ANSI
or K&R C compiler. The COSMIC program number is MSC-21208. COSMIC can be
contacted at:  COSMIC, 382 E. Broad St.,  Athens, GA  30602, (404) 542-3265.

PROBLEMS INSTALLING OR USING CLIPS
----------------------------------
Users can obtain some help with CLIPS problems by calling the STB Products Help
desk.  The Help desk is available between the hours of 8:00 AM to 4:45 PM (CST)
Monday through Friday at (713) 280-2233. Callers should leave a description of
their problem and a phone number and they will be contacted, usually within a
day. An answering machine will take a message at other hours or when the line
is busy. You may also use our electronic bulletin board to obtain information
or leave us a message. The numbers are (713) 280-3896 and (713) 280-3892; set
your modem at 300, 1200, or 2400 baud, no parity, 8 data bits and 1 stop bit.
The bulletin board operates 24 hours a day, seven days a week, except for
maintenance.  Outside organizations should use the bug report forms included
with the CLIPS documentation to report problems with CLIPS.

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

Users should do both A & B. If you don't emulate VT100, you will be continuously
kicked out of the CLIPS editor back to the VAX DCL command line at random and
you may lose your file(s).

WARNINGS, THINGS TO WATCH OUT FOR
---------------------------------
The following section describes common problems users have with CLIPS, or
things to be aware of when using CLIPS. If you are having unusual problems,
check this section and the next one before reporting a bug.  You should also
carefully read and understand the changes from version 4.3 as explained in
Appendix D of Volume I of the CLIPS Reference Manual.  Capabilities and
function names have been changed and may return different types from 4.3.

1) Using the integrated editor to edit large files and then execute them in
CLIPS could cause severe memory problems on a PC. The editor itself does not
take up all that much memory, but a large file of rules that is in the editor
and then loaded into CLIPS could cause the machine to do any of three things;
completely hang, exit to DOS with some kind of error message, or warn about
memory failures and refuse to compile a rule or file. The moral is when working
on a PC, use a PC with as much memory as possible, and avoid editing large
files while in CLIPS. The Macintosh generally does not have as severe a memory
limitation for rules; however, the Macintosh toolbox editor cannot edit files
larger than 32K.

2) Because of differences in machines, the allowable range of values a CLIPS
number may have can vary. Particularly, the largest or smallest allowed value
on one machine may cause floating point overflows or underflows, respectively,
on another.

3) Because it appears that the VAX implementation of extern does not follow
ANSI or K & R, VAX VMS will NOT link with the file edterm.obj in a library
unless you use the /include option. Or you can link directly with edterm.obj.
If you don't do this, the editor files will not get linked and yet, you will
not get link errors and your program will crash when you try to use the editor.

4) If one uses the option "r+" to read from and write to a file, in the case
that the file does not already exist, CLIPS will not be able to find it. The
above option should only be used for files that already exist. So, if you want
to read to and write to the same file that does not necessarily exist, you
should check if it already exists and, if not, open it for writing, i.e. "w",
and close immediately prior to accessing with "r+".  Also be aware that
different C compilers may implement r+ to overwrite or append to the file and
consequently your results with different compilers may vary.

5) CLIPS is ANSI C code, it is NOT C++ and will NOT compile as C++ code.
However you can use the ANSI C compiler supplied with Turbo C++ 1.0 to compile
it as ANSI C and take advantage of Borland's VROOM to use overlays.

6) The PC window interface version of CLIPS is NOT included in this release.
Instead we are working on defining a consistent window interface across IBM and
compatible PCs, Macintoshes and Unix workstations.  When completed later this
year, we plan to have a window version for PCs which will work WITHOUT
Microsoft Windows 3.0, one which will work with Microsoft Windows 3.0, and an X
Windows interface.  All window interfaces will "behave" similarly.

7) While you can compile CLIPS 5.0 with all features activated on a PC, you
will find that when you attempt to run it, the program crashes out of memory.
You have several choices in this case.  You can deactivate some features and
recompile.  Or you can compile with the ANSI C compiler which comes with Turbo
C++ version 1.0 (as ANSI C code NOT C++) and use its VROOM technology to gain
significant room in memory; we have supplied a make file to do so, see below.
Or, you can move to another machine which can directly access more memory,
such as a Macintosh, VAX or UNIX workstation.

8) If, on an IBM PC or compatible, you plan to use the DOS print command from
inside CLIPS be sure to load the resident portion of print BEFORE starting
CLIPS (i.e. execute print from DOS before starting CLIPS).  Failure to do so
will result in memory being held and not released even after CLIPS is
terminated.  The only way to release this memory is by rebooting.

9) Terminate and Stay Resident (TSR) programs under DOS will not work from
CLIPS system calls.  Instead, spawn a DOS shell from CLIPS and execute the TSR
from the shell.

10) When using the CLIPS system command you may find that you get a 'normal'
return from the call but your command to the OS was not executed.  This occurs
under DOS when there is not sufficient memory to spawn a DOS shell and execute
the command. Since there is no return code from DOS which indicates this
problem, there is no way for CLIPS to tell you that your command did not get
executed.  Furthermore, since this problem depends on the amount of memory
present, and the amount of memory you have present varies by what programs you
have loaded, both in CLIPS and TSR's etc., the problem is often intermittent
on even your own computer.  If it appears your system commands are not being
executed, check to see that you have enough free memory and, if not, then you
will have to first free up some memory.

11) BLOAD clears the environment of constructs (defrules, deffacts,
deftemplates, deffunctions) before loading a file into memory.  BLOAD can be
called at any time unless some constructs that BLOAD will affect are in use
(i.e. a deffunction is currently executing).  When you do a BLOAD, all operant
defrules, deffacts, deftemplates and deffunctions are deleted (but not
facts).  Once a BLOAD has executed, you cannot load any constructs with LOAD
or delete any constructs.  You can do another BLOAD (which will delete all
constructs from the current BLOAD); you can also clear and then use LOAD.  See
Section 11.1.3, pages 161-2, of the CLIPS Basic Programming Guide for more
information.  Be absolutely certain that when you BLOAD a file, that it was
BSAVEd with the SAME version of CLIPS.  It is a serious error to BLOAD files
BSAVEd with different versions of CLIPS; your computer may hang/crash.

12) The Reference Manual may be incorrect in identifying characters echoed to
the screen for the various constructs when you load a file with (unwatch
all).  The correct constructs - identifiers are as follows:  deffacts - $,
defrule - *, defglobl - :, deftemplate - %, deffunction - !, defclass - #,
defmessage-handler - ~, defmethod - &, definstances - @, defgeneric - ^.  One 
such character is printed on the screen for each respective occurrence of the 
appropriate construct.

13) Using Macintosh Programmers  Workshop (MPW) C with CLIPS.  Since we don't
yet have MPW C  we aren't able to give specific changes.  We would welcome
this information from anyone who knows so we can distribute it to other
interested users. There are some general changes we can mention.  First, some
of the MPW C header files have different names than Symantec Think C.  Second,
MPW C uses long ints (4 bytes) while Symantec Think C uses short ints (2
bytes);  this is important because some of the Macintosh toolbox routines
require 2 byte ints.  The generic version of CLIPS should compile with no
problems.  Only the files for the interface in the interface folder should
require these modifications.

14) Using expanded (EMS) or extended (XMS) memory or IBM PCs and compatibiles.
We have investigated the use of both expanded and extended memory under DOS.
We feel the enormous amount of work necessary to use expanded memory cannot be
justified.  We expect to begin work on a Microsoft Windows 3.0 version of
CLIPS which can use extended memory and this could alleviate memory
constraints on IBM and compatible PCs.  Because CLIPS gets its memory from DOS
and DOS cannot use extended memory, there is no straightforward way for
CLIPS to use extended memory.  You could buy a DOS memory extender, then
recompile and relink CLIPS with their libraries (for Microsoft C and Turbo C,
at least) to use extended memory. Normally the vendors of DOS memory extenders
may require a license agreement (and fees) of those who distribute programs
built with their memory extender libraries.  For further information, please
contact the three vendors of DOS extenders we know of (they were reviewed in
April 1990 BYTE):

Ergo Computing                       Phar Lap Software                 Rational Systems
One Intercontinental Way          60 Aberdeen Ave.                  220 North Main St.
Peabody, MA 01960-9850         Cambridge, MA 02138          Natick, MA 01760
(508) 535-7510                       (617) 661-1510                   (508) 653-6006

15) To use the imbedded EMACS editor of CLIPS on IBM and compatable PCs you
must have the ANSI.SYS device driver loaded.  You may also use the ANSI.COM
utility program from PC Magazine.

16) For IBM Mainframes you should be able to compile and execute CLIPS 5.0
now. We have added a special header file, SHRTLNKN.H, to provide short name
file aliases to satisfy the linker limitation of 8 characters or less in a
file name.  In addition, you MUST set the flags for GENERIC to 1 and
ANSI_COMPILER to 1.  This procedure has been tested under MVS and VM.
Finally, you may want to make the following changes to the source code for IBM
C/370 Compiler and Library before compiling.

Our own limited testing on IBM mainframes and the reports of others who have
ported CLIPS to IBM mainframes have indicated that output is only flushed to
the screen when a carriage return is encountered (even an fflush call will not
flush output). The following changes can be made to the CLIPS source code to
force output to be displayed after the CLIPS prompt appears and before any
read or readline calls.

---------------------------------------------------------------------
In the PrintPrompt function in the COMMLINE.C file, change the following line

    PrintCLIPS(WCLIPS,"CLIPS> ");

TO

    PrintCLIPS(WCLIPS,"CLIPS>\n");

---------------------------------------------------------------------
In the ReadFunction function in the SYSIO.C file, change the following lines

   if (strcmp(dummyid,"stdin") == O)
      {
        inp_tkn.type = STOP;

TO

   if (strcmp(dummyid,"stdin") == O)
      {
        PrintCLIPS("stdout","\n");
        inp_tkn.type = STOP;

----------------------------------------------------------------------
In the ReadlineFunction function in the SYSIO.C file, change the following line

   buffer = FillBuffer(logicalName,&line_pos,&line_max);

TO

   if (strcmp(logicalName,"stdin") = O) PrintCLIPS("stdout","\n");
   buffer = FillBuffer(logicalName,&line_pos,&line_max);
----------------------------------------------------------------------

17) CLIPS will abort and quit upon encountering a symbol exceeding 512
characters.

18) CLIPS limits string length to 512 characters (including embedded blanks).
If your string exceeds 512 characters you will have to break it into smaller
strings each of which are 512 characters or less.


KNOWN PROBLEMS WITH CLIPS
-------------------------
The following section describes any known problems with CLIPS. Where possible,
workarounds or fixes will also be described.  If you discover bugs and
workarounds please call the HELP DESK and report them so we can update this
file.  Thanks.

1) CLIPS typically won't allow a single symbol or string longer than 512
characters. Under most circumstances, if CLIPS finds too long a symbol or
string, it prints an appropriate error message.

2) If SYSTEM V is used to compile and link the CLIPS executable on an Apollo,
retraction of the initial-fact would cause a fatal error. The work around is to
compile and link under BSD and then use the executable in either the SYSTEM V
or the BSD environment.

3) Do not use the same multi-field variable name in the same pattern because
the implicit test for equality will not work, for example:

(defrule multi-field-bug
; this rule will fire for both drivers joe and bob in deffacts drivers below
; it should only fire for bob
  (driver ?name morning-routes $?routes evening-routes $?routes)
=>
 (printout t  "Not necessairly the same routes!" crlf))
;-----------------------------------------------------------------------------
(deffacts drivers
 (driver joe morning-routes r1 r2 r3 evening-routes r1 other)
 (driver bob morning-routes r5 r7 r8 evening-routes r5 r7 r8)
)
;-----------------------------------------------------------------------------
(defrule multi-field-bug-work-around
  (driver ?name morning-routes $?morning-routes evening-routes $?evening-routes)
; the workaround for the bug in rule multi-field-bug is to use a test
; this rule fires only for driver bob as it should
  (test (eq $?morning-routes $?evening-routes))
=>
 (printout t "Same routes, for sure dude!" crlf))
;-----------------------------------------------------------------------------
THANKS TO LIZ FOLEY OF LOCKHEED FOR REPORTING THIS BUG.

4) You cannot break out of a while loop on personal computers with CTRL-C but
you should be able to break out on a UNIX workstation.

5) The function subsetp erroneously returns true when the first multifield variable 
argument contains every atom in the second but the cardinality of the common 
atoms is incorrect, for example

(subsetp (mv-append a b a) (mv-append a b)) returns TRUE when it should return FALSE
 
(subsetp (mv-append a b b) (mv-append a b c d)) returns TRUE when it should return FALSE

(subsetp (mv-append a b a) (mv-append b a b)) returns TRUE when it should return FALSE.


MAKE FILES FOR CLIPS version 5.0
---------------------------------
-------------------
-- GENERAL NOTES --
-------------------
Since every make program is different be sure to read the make file comments
before using them as you will likely have to change the path names defined in
macros to agree with your machine.  You may also want to consult the various
vendors reference manuals concerning their versions of make.  These make files
above have all been tested and then copied to disk.  Before using these make
files make certain the appropriate CLIPS compiler option flags are set on or
off in the file SETUP.H

---------------
----- DOS -----
---------------
On the Diskette #1 there are make files to recompile CLIPS for the following
DOS C compilers (we recommend files=20 and buffers=30 in your config.sys):

(WARNING!!!  Be sure to use the make program which came with the compiler
including the appropriate version; i.e. don't use Microsoft make with Turbo C
make files or vice versa.):

M51CLIPS.MAK and M60CLIPS.MAK  for Microsoft C 5.1 and 6.0 respectively

T20CLIPS.MAK   for Turbo C 2.0 and Turbo C++ 1.0 (as ANSI C NOT C++)

These make files require the use of a linker response file, CLIPSOBJ.500,
which you will also find on the disk.

MAKEFILE   for Turbo C++ 1.0 (as ANSI C NOT C++) using overlays

This make file, MAKEFILE, requires the linker response file named LINKRSP,
included on the disk.  In addition you should use the main.c program in file
mainovl.c NOT the one in file main.c.  This main.c is designed to set
appropriate stack and buffer sizes for overlay use and to take advantage of
expanded or extended memory, if present.

---------------
----- UNIX -----
---------------
There is also one make file for UNIX systems:

UNXCLIPS.MAK  for general UNIX boxes

This make file does not require linker response files.  However because it was
copied to DOS diskettes from UNIX systems, necessary tabs were lost. If you
copy it back to UNIX boxes be sure to read the comments about where to edit
(only two places) and restore tabs necessary for correct operation. You may
also have to change the paths were the libraries libtermcap.a and libm.a are
found on your system if different than in the make file.  Before using this
make file, make certain the appropriate CLIPS compiler option flags are set on
or off in the file SETUP.H

You should have noted from earlier comments in this file that compiling and
linking CLIPS under SYSTEM V on an Apollo may produce an unusable executable.
However you should be able to compile and link under BSD and then use the
executable in either environment.

-------------------
-----Macintosh-----
-------------------
There is one project file for Symantec Think C 4.0 together with the necessary
resource file.

CLIPS 5_0             the project file
CLIPS 5_0.Rsrc     the resource file for the CLIPS ICON

The Macintosh window interface only comes on the Macintosh distribution
diskettes.  It is NOT on the IBM and compatible PC disks or on the VAX tape.

