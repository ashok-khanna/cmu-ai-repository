Subject: Tar utility that works with DOS

PAX - Portable Archive Interchange

Copyright (C) 1989 Mark H. Colburn
All Rights Reserved.


Introduction

    This is version 2.0 of Pax, an archiving utility.  
    
    Pax is an archiving utility that reads and writes tar and cpio formats, 
    both the traditional ones and the extended formats specified in IEEE 
    1003.1.  It handles multi-volume archives and automatically determines 
    the format of an archive while reading it.  Three user interfaces are 
    supported: tar, cpio, and pax.  The pax interface was designed by IEEE 
    1003.2 as a compromise in the chronic controversy over which of tar or 
    cpio is best.

    The Pax utility is being distributed free of charge and may be 
    redistributed by others in either source or binary form.  (See the 
    licensing section for restrictions)

    The source for Pax has been posted to comp.sources.unix on USENET and 
    will also be available by anonymous FTP on the Internet from uunet.uu.net,
    moon.src.honeywell.com and from ucb-arpa.berkeley.edu.  The source
    to Pax is also available via anonymous UUCP from minnetech.mn.org, the 
    author's home machine and possibly other sites.

    The source for Pax will continue to change as long as the definition of 
    the utility is modified by the 1003.2 working group.  (For example, 
    there are a number of changes in Draft 8 which will be incorporated as 
    soon as Draft 8 is available).  Additional modifications will be made 
    based on user input, such as request for support of additional archive 
    formats, etc.  Patches and new releases will be made as new functionality 
    is added or problems are diagnosed and fixed.


Installation

    In order to install Pax, you must run the Configure script.
    In addition, if your systems does not have at least a somewhat POSIX
    compliant <limits.h>, then you may have to tweak some of the values in
    limits.h.

Portability

    Pax is intended to run on as many systems as possible.  If you have
    problems getting Pax to compile or run on your system, please let me 
    know so that the source or the installation procedure can be modified.

    Pax has been tested and appears to run correctly on the following 
    machines:

        Machine                 Operating System/Release
	---------------------------------------------------
	Altos 586		System III (2.3)
	AT&T UNIX PC		System V.2 (Release 3.51)
        Convergent S/320	CTIX/68k 6.1, UNIX SysV 3.1
        Convergent S/80		CTIX/68k 6.1, UNIX SysV 3.1
	Cray 2			UNICOS
	Encore CC		02.00.r088
	HP 9000			HP/UX 6.0.1
        IBM PC/AT		Microport SV/AT V2.4
	Mac II 			A/UX 1.0
	NCR Tower		System V.2
	Pyramid			AT&T and Berkeley universe
	Sequent Symetry		Dynix 3.0
	SGI Iris 4D/60G		UNIX 3.0
	SGI Iris 4D/70G		UNIX 3.0
	SCO Xenix 386 		2.3.2
	SCO Unix 386 		3.2
	Sun 2			SunOS 3.4
	Sun 2			SunOS 3.5
	Sun 3			SunOS 3.4
	Sun 3			SunOS 3.5
	Sun 3			SunOS 4.0
	Sun 4			SunOS 4.0
	VAX 8750		BSD 4.3 (Mt. Xinu)
	VAX 8650		BSD 4.3 (Mt. Xinu)
	VAX 780			BSD 4.3 (Berkeley)
	---------------------------------------------------

    In future releases, the source will be moving toward ANSI C and POSIX 
    compatibility.  This should allow for portability over any system 
    supporting both ANSI and POSIX.  In addition, POSIX/ANSI portability 
    library routines will be developed which will allow the code to run on 
    the standard machines available now.


DOS stuff:

    It has been tested only with the Microsoft C V5.1 compiler and
    MASM V5.1.  It supports both the DOS filesystem and the raw
    "tape on a disk" system used by micro UN*X systems.  For more
    details, see below. This will allow for easy transfer of files
    to and from UN*X systems.  Multiple volumes and the tar append
    option are supported.

    To get PAX.EXE and CPIO.EXE just copy TAR.EXE to PAX.EXE and
    CPIO.EXE. Since MSDOS 2.X does not report the file name to the
    program, those users (and anyone else that wants to) can set the
    environment variable PAXNAM to the program name that they want
    (ie. set PAXNAM=tar). Note that both tar and cpio archives can
    be accessed through the pax interface.

    This program does not do ANY translation on data files.  File and
    directory names have their backslashes changed to forward slashes and
    uppercase changed to lowercase when writing an archive on an MSDOS
    machine.  File and directory names are truncated to an 8 character name
    and a 3 character extension on extraction from an archive along with
    translation of '.' to '_' where appropriate and translation to
    monocase.

    Unix style shell regular expressions are now supported on the command
    line. To prevent expansion enclose the argument in single quotes
    (backslashes don't work, they are simply translated into forward
    slashes).  If a *.* is encountered, the program warns the user that to
    get all the files he needs to use a * instead and proceeds to archive
    filenames with a period in them.  A trailing slash on a filename 
    matches a directory.  Arguments with spaces in them need to be
    enclosed in double quotes (ie. "'with space'").

    True dos character device support (eg. a tape drive with a
    character device driver, inspired by John B. Theil) has been
    added, but is only available when the archive filename is
    supplied on the command line (not stdin-stdout).

    To use the raw "tape on a disk" feature give an archive filename
    of "a:dio" or "b:dio" (dio stands for direct I/O) for floppy
    drives "a" and "b".  This program will support any media
    supported by DOS, but you MUST do a DIR on an MSDOS formatted
    disk at the density you want to use before using PAX, TAR, or
    CPIO with direct I/O.  Note that the direct I/O destroys the
    logical structure of the disk.  

    Floppy disk type specification is now supported on the
    command line for the raw disk interface. This gets rid of
    having to do the disk exchange, although the disk exchange
    method still works.  The following floppy disk types are
    supported under pax, tar, and cpio.

    Abbreviation        Type
          ld      DSDD 360k 5 1/4 inch
          hd      DSHD 1.2M 5 1/4 inch
          l3      DSSD 720k 3 1/2 inch
          h3      DSDD 1.44M 3 1/2 inch

    The abbreviation is tacked onto the end of [ab]:dio?? like
    a:diold or b:diohd.  Examples are given below.

    The default blocking factor for tar has been changed to 20.

    Examples:

    Using direct i/o on a floppy with tar.exe and a high density
    formatted 5 1/4 inch floppy disk (a:diohd and b:diohd are special)
    
        1) Put the formatted high density floppy in drive "a"
        2) tar cvf a:diohd .

    Using direct i/o on a floppy with tar.exe (a:dio and b:dio are special)
    
        1) Put high or low density MSDOS formatted floppy in drive "a".
        2) Do a DIR (this is a required step)
        3) Remove the floppy
        4) Put a floppy in drive "a" with the same density as step 1
        5) tar cvf a:dio .
    
    Using direct i/o on a floppy with cpio.exe (a:dio and b:dio are special)
    
        1) Put high or low density MSDOS formatted floppy in drive "a".
        2) Do a DIR (this is a required step)
        3) Remove the floppy
        4) Put a floppy in drive "a" with the same density as step 1
        5) find . -print | cpio -ocvBD a:dio
             (note the undocumented D option to specify the
              archive, works on reads too)
    
    Using direct i/o on a floppy with pax.exe and the tar archive format 
    (a:dio and b:dio are special)
    
        1) Put high or low density MSDOS formatted floppy in drive "a".
        2) Do a DIR (this is a required step)
        3) Remove the floppy
        4) Put a floppy in drive "a" with the same density as step 1
        5) pax -w -b 20b -f a:dio .
    
    Using tar.exe within the MSDOS filesystem (the filename does not matter)
    Will not destroy the logical structure of the disk.  Similarly for
    cpio.exe and pax.exe. 
    
        1) Put high or low density MSDOS formatted floppy in drive "a".
        2) tar cvf a:whatever.tar .
    
    Using tar.exe within the MSDOS filesystem to a character device like a
    tape drive.
    
        1) Put tape in tape drive
        2) tar cvf /dev/tape .

	
Credit Where Credit is Due

    Parts of the code which makes up Pax were gleaned from a number of
    different sources: the directory access routines in ./dirent/ are
    copies of Doug Gwyn's dirent library; some of the tar archive
    routines were initially written by John Gilmore for his PDTAR;
    Harold Walters provided the basis for the MSDOS support and
    finally afio, written by Mark Brukhartz at Lachman Associates, was
    the basis for the buffering schemes used in pax.


Licensing

    Copyright (c) 1989 Mark H. Colburn.  
    All rights reserved.

    Redistribution and use in source and binary forms are permitted
    provided that the above copyright notice is duplicated in all such 
    forms and that any documentation, advertising materials, and other 
    materials related to such distribution and use acknowledge that the 
    software was developed by Mark H. Colburn.

    THE SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
    IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

Please report any bug or problems to:

Mark Colburn
Open Systems Architects, Inc.
7555 Marketplace Drive
Eden Prairie, MN 55344

mark@minnetech.MN.ORG
