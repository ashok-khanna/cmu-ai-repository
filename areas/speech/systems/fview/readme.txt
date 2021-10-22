This directory contains the sources and documentation to the
Fview program which is described below.

Directory Contents
******************

fview1.0.tar:
	fview sources and documentation
	Contact: 	Dr. Gareth Lee
			gareth@ee.uwa.edu.au

tr93-02.ps.gz:
	ANZIIS'93 conference proceedings describing fview program.


DESCRIPTION
***********

The program fview is used for projecting higher
dimensional data down onto the screen of the
computer and manipulating it in various ways. It
is particularly useful (and designed for) speech
data in the form of trajectories in twelve dimensional
space, and some is included. Also included, full
instructions for using standard data base data sets
to get more data. There is a full manual included
in the tar file.

For fun and profit, run the three dimensional sweep
presentation of an utterance such as `six', and watch it
spung out and hit you in the eye at the vowel, and dip
back for the stop. Great for checking end-pointing and
for exploring front-ends for speech recognition systems;
can be used with minor modifications for viewing, rotating
and time sequencing high dimensional data of all sorts.
Easily learnt graphics user interface makes it all a doddle
to play with.


INSTALLATION
************

This is the standard distribution for FVIEW 1.0 tailored to Sun SparcStations
using SunOS.  It may be compiled to run on other machines but needs Xlib and
XView libraries to be available.

Notes:

1. The supplied "./fview" binary will operate under SunOS on any Sun
SparcStation.  It has been statically linked and will therefore operate
on systems that *do not* have xview installed.  It is recommended that
users with xview and Xlib libraries installed should recompile using
dynamic linking which will reduce the executable size by three.

2. Users on other systems will need to recompile from the source files
supplied.  This can be achieved by editing "./Makefile" and modifying the
the chosen compiler (COMPILER), compiler options (OPTIONS), the X-windows
include directory (XINCLUDE) and library directory (XLIBRARY) before typing

$ make fview

at the command line.

If compilation fails, then object and executable files may be deleted using

$ make clean

3. Documentation is supplied in the directory "./docs" in the form of LaTeX
source and two ready-made postscript files.  All postscript and encapsulated
postscript has been compressed and may be unpacked using the "unpack"
csh script.  Two documents are supplied, a brief overview in the form of a
conference paper ./docs/anziis.ps.Z, and a more detailed users manual
./docs/manual.ps.Z.  If a postscript printer is available hard copy may be
achieved using the following command,

$ zcat ./docs/manual.ps.Z | lpr -Ppspr

Which assumes "pspr" is the postscript printer name.

The anziis file uses 5 sheets, whilst the manual is 35 pages.

4. Directory Structure.

  ./docs      Documentation in latex and diagrams in encapsulated postscript.
  ./lists     Example list files (data not supplied).
  ./drivers   Format converters and Front-end executables.
  ./src       Source code for driver programs.

5. Important files.

  ./Makefile  Makefile for generating fview (must be customized before use).
  ./Formats   Configuration file for format converters.
  ./Frontends Configuration file for front-end filters.
  ./envir     Examples of how to set the two environment variables that
              fview can use.
  ./src/Makefile  Makefile for format converter and front-end programs.

6. Fview source files.

  ./fview.c      Main source file for fview.
  ./fview.h      Header file for fview.c
  ./interface.c  Interface to the xview library.
  ./interface.h  Header file for interface.c
  ./projectors.c Screen refresh routines for 2D/3D and spectrograms.
  ./projectors.h Header file for projectors.c
  ./callbacks.c  Callback routines.
  ./callbacks.h  Header file for callbacks.c
  ./entropy.c    Trajectory prediction and vertex highlighting using entropy.
  ./entropy.h    Header file for entropy.c
  ./fviewio.h    Header containing structures for interface to converters.


--------------------------------
Gareth Lee.
22-11-93
