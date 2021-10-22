README  18-Feb-92

KTEXT Version 1.0.3, 18-Feb-92

This is version 1.0.3 of KTEXT, a morphological parser that
processes text. KTEXT is available for three operating systems:
    MS-DOS or PC-DOS (any IBM PC compatible)
    UNIX System V (SCO UNIX V/386 and A/UX) and 4.2 BSD UNIX
    Macintosh

As of version 1.0.3, there is also a version of KTEXT for PC's
running a 386 CPU. This version will use all available extended
or expanded memory. It supports VCPI-compliant memory managers
such as MS-DOS 5.0's EMM386 and Quarterdeck's QEMM386. It does
not support Microsoft Windows. In this software release, the
non-386 version is named KTEXT.EXE and the 386 version is named
KTEXT386.EXE. The 386 version of KTEXT is especially intended for
use with Englex, a large English lexicon that exceeds the limits
of the 640K version of KTEXT. Englex should be available from the
same source as KTEXT.

KTEXT uses the same parsing engine as PC-KIMMO; rules and lexicons
developed using PC-KIMMO can be directly used by KTEXT without
modification. PC-KIMMO is described in the book "PC-KIMMO: a two-level
processor for morphological analysis" by Evan L. Antworth,
published by the Summer Institute of Linguistics (1990). The PC-
KIMMO software is available for MS-DOS (IBM PCs and compatibles),
Macintosh, and UNIX. The book (including software) is available
for $23.00 (plus postage) from:

    International Academic Bookstore
    7500 W. Camp Wisdom Road
    Dallas TX, 75236
    U.S.A.

    phone  214/709-2404
    fax    214/709-2433

KTEXT, PC-KIMMO, and Englex are available via anonymous FTP from
the Consortium for Lexical Research, clr.nmsu.edu [128.123.1.11].
Address e-mail inquiries to lexical@nmsu.edu or
lexical@nmsu.bitnet.

The user's guide included in this release is a plain text file,
though it does contain a few eight-bit accented characters.

This software release contains the following items:

     KTEXT program
     CED program (not available for Macintosh)
     KTEXT User's Guide
     ReadMe file
     Tagalog subdirectory

To run KTEXT of the Tagalog sample, move the KTEXT program into the
Tagalog subdirectory (or configure your PATH) and type:

     ktext -w -x tag.ctl -i tag.txt -o tag.ana

I would like to hear your reactions to KTEXT, both pro and con.

Evan Antworth
Academic Computing Department
Summer Institute of Linguistics
7500 W. Camp Wisdom Road
Dallas, TX 75236
U.S.A.

phone   214/709-2418
e-mail  evan@sil.org
