************************************************************************
*                                                                      *
*                              SOM_PAK                                 *
*                                                                      *
*                                The                                   *
*                                                                      *
*                        Self-Organizing Map                           *
*                                                                      *
*                          Program  Package                            *
*                                                                      *
*                  Version 1.2 (November 2, 1992)                      *
*                                                                      *
*                          Prepared by the                             *
*                    SOM Programming Team of the                       *
*                 Helsinki University of Technology                    *
*           Laboratory of Computer and Information Science             *
*                Rakentajanaukio 2 C, SF-02150 Espoo                   *
*                              FINLAND                                 *
*                                                                      *
*                         Copyright (c) 1992                           *
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
*  e-mail address 'som@cochlea.hut.fi'.                                *
*                                                                      *
************************************************************************

This package contains all the programs necessary for the application
of Self-Organizing Map algorithms in an arbitrary complex data
visualization task.  

In the implementation of the SOM programs we have tried to use as
simple a code as possible.  Therefore the programs are supposed to
compile in various machines without any specific modifications made on
the code.  All programs have been written in ANSI C.

The som_pak program package includes the following files:
  - Documentation:
      README             this file
      som_doc.ps         documentation in (c) PostScript format
      som_doc.ps.Z       same as above but compressed
      som_doc.txt        documentation in ASCII format
  - Source file archives:
      som_p1r2.exe       Self-extracting MS-DOS archive file
      som_pak-1.2.tar    UNIX tape archive file
      som_pak-1.2.tar.Z  same as above but compressed

Installation in UNIX (in more detail, see som_doc.ps/txt):
  - Uncompress som_pak-1.2.tar.Z
  - Extract the files with "tar xovf som_pak-1.2.tar" which creates
    the subdirectory som_pak-1.2
  - If you use BSD make utility, copy makefile.bsd to the name makefile
  - If you use System V make utility, copy makefile.sv to the name makefile
  - If you use GNU gmake utility, copy makefile.sv to the name makefile and
    fix the macro definition in the makefile as described in it
  - If you use GNU gcc instead of cc, change the definition in the makefile
  - Revise other switches in the makefile, if necessary
  - Execute "make"

Installation in MS-DOS (in more detail, see som_doc.ps/txt):
  - By executing the command som_p1r2 the self-extracting archive
    creates the directory som_pak.1r2 and extracts all the files in it
  - You are supposed to use Borland C++ Version 2.0 and to have
    all the necessary environment settings
  - Copy the file makefile.dos to the name makefile
  - Revise the compiler switches in the makefile, if necessary
  - Execute "make"

Revision history:
  - Version 1.0 was released 9 October 1992.
  - Version 1.1 with a minor modification (in Eq. (3)) was released
    14 October 1992.
  - Version 1.2 with two corrections in the code was released 2 November
    1992. For the details see documentation.
