This directory contains CLISP.

CLISP is a Common Lisp (CLtL1 + parts of CLtL2) implementation by
Bruno Haible of Karlsruhe University and Michael Stoll of Munich
University, both in Germany.  It runs on microcomputers (DOS, OS/2,
Atari ST, Amiga 500-4000) as well as on Unix workstations (Linux, Sun4,
Sun386, HP9000/800, SGI, Sun3 and others) and needs only 1.5 MB of RAM.
It is free software and may be distributed under the terms of GNU GPL.
German and English versions are available, French coming soon.  CLISP
includes an interpreter, a compiler, a subset of CLOS and, for some
machines, a screen editor. Packages running in CLISP include PCL and,
on Unix machines, CLX and Garnet.  Available by anonymous ftp from
ma2s2.mathematik.uni-karlsruhe.de [129.13.115.2] in the directory
/pub/lisp/clisp.  For more information, contact
haible@ma2s2.mathematik.uni-karlsruhe.de.

source/            source of CLISP

binaries/          binaries for several platforms
        dos/               executable running on DOS
        os2/               executable running on OS/2 2.0
        linux/             executable running on Linux
        sun4-sunos4/       executable running on Sun Sparc, SunOS 4
        sun4-sunos5/       executable running on Sun Sparc, SunOS 5 (Solaris 2)
        sun386/            executable running on Sun386i
        sun3-sunos4/       executable running on Sun 3, SunOS 4
        hp9000s800/        executable running on HP9000 Series 800/700
        386bsd/            executable running on 386BSD 0.1
        dec5000-ultrix/    executable running on DECstation 5000, Ultrix 4.2A
        sgi-irix4/         executable running on SGI, Irix 4
        coherent386/       executable running on Coherent 386
        amiga/             executable running on Amiga 500-4000
        atari/             first version of CLISP, running on Atari ST only

packages/          application packages ported to CLISP:
                   PCL (another CLOS subset), CLX, Maxima.

There is a mailing list for users of the Common Lisp implementation
CLISP. It is the proper forum for questions about CLISP, installation
problems, bug reports, application packages etc.
For information about the list and how to subscribe it, send mail to
listserv@ma2s2.mathematik.uni-karlsruhe.de, with the two lines
          help
          information clisp-list
in the message body.

Bruno Haible
haible@ma2s2.mathematik.uni-karlsruhe.de

