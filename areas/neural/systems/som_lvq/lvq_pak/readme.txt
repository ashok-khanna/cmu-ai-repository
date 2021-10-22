************************************************************************
*                                                                      *
*                              LVQ_PAK                                 *
*                                                                      *
*                                The                                   *
*                                                                      *
*                   Learning  Vector  Quantization                     *
*                                                                      *
*                          Program  Package                            *
*                                                                      *
*                  Version 2.1 (October 9, 1991)                       *
*                                                                      *
*                          Prepared by the                             *
*                    LVQ Programming Team of the                       *
*                 Helsinki University of Technology                    *
*           Laboratory of Computer and Information Science             *
*                Rakentajanaukio 2 C, SF-02150 Espoo                   *
*                              FINLAND                                 *
*                                                                      *
*                      Copyright (c) 1991-1992                         *
*                                                                      *
************************************************************************
*                                                                      *
*  NOTE: This program package is copyrighted in the sense that it      *
*  may be used for scientific purposes. The package as a whole, or     *
*  parts thereof, cannot be included or used in any commercial         *
*  application without written permission granted by its producents.   *
*  No programs contained in this package may be copied for commercial  *
*  distribution.                                                       *
*                                                                      *
*  All comments concerning this program package may be sent to the     *
*  e-mail address 'lvq@cochlea.hut.fi'.                                *
*                                                                      *
************************************************************************

This package contains all the programs necessary for the correct
application of certain LVQ (Learning Vector Quantization) algorithms
in an arbitrary statistical classification or pattern recognition
task.  To this package three options for the algorithms, the
LVQ1, the LVQ2.1 and the LVQ3, have been selected.  

In the implementation of the LVQ programs we have tried to use as
simple a code as possible.  Therefore the programs are supposed to
compile in various machines without any specific modifications made on
the code.  All programs have been written in ANSI C.

The lvq_pak program package includes the following files:
  - Documentation:
      README             this file
      lvq_doc.ps         documentation in (c) PostScript format
      lvq_doc.ps.Z       same as above but compressed
      lvq_doc.txt        documentation in ASCII format
  - Source file archives:
      lvq_p2r1.exe       Self-extracting MS-DOS archive file
      lvq_pak-2.1.tar    UNIX tape archive file
      lvq_pak-2.1.tar.Z  same as above but compressed

Installation in UNIX (in more detail, see lvq_doc.ps/txt):
  - Uncompress lvq_pak-2.1.tar.Z
  - Extract the files with "tar xovf lvq_pak-2.1.tar" which creates
    the subdirectory lvq_pak-2.1
  - If you use BSD make utility, copy makefile.bsd to the name makefile
  - If you use System V make utility, copy makefile.sv to the name makefile
  - If you use GNU gmake utility, copy makefile.sv to the name makefile and
    fix the macro definition in the makefile as described in it
  - If you use GNU gcc instead of cc, change the definition in the makefile
  - Revise other switches in the makefile, if necessary
  - Execute "make"

Installation in MS-DOS (in more detail, see lvq_doc.ps/txt):
  - By executing the command lvq_p2r1 the self-extracting archive
    creates the directory lvq_pak.2r1 and extracts all the files in it
  - You are supposed to use Borland C++ Version 2.1 and to have
    all the necessary environment settings
  - Copy the file makefile.dos to the name makefile
  - Revise the compiler switches in the makefile, if necessary
  - Execute "make"

Revision history:
  - Version 1.0 was released 19 December 1991.
  - Version 1.1 containing only a minor bug fix in memory allocation
    was released 31 December 1991.
  - Version 2.0 containing major modifications in the algorithms was
    released January 31, 1992; for these changes, see documentation.
  - Version 2.1 containing some improvements in the speed of algorithms
    and one new program was released October 9, 1992; for these
    changes see documentation.

