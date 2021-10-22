Description of AKCL system.

OVERVIEW:

The AKCL system contains original files and change files (usually V/*
files).  The change files are then combined with files in the original
KCL distribution.  The latter is the June 1987 version.  The utility
merge, takes files from the original distribution and modifies them
according to a prescription in a `change file'.  The change files
reside in the directory V.  The enhancements include enhancements to
the lisp compiler, loader, garbage collector and to the basic C code.
If installed properly NOTHING in the original kcl directory should be
overwritten.  Files which have not changed will have only a link copy
in the akcl directory, and files which do change will have a changed
copy in the akcl directory, and an unchanged file in the kcl
directory.  To ensure that you do not accidentally alter a file in the
original directory you might wish to make the files there unwritable.
You do not need to do a make in the kcl directory.


OBTAINING SOURCES:
-----------------

* There are source files on rascal.ics.utexas.edu:pub/akcl/akcl-XX.tar.Z
You probably want the highest XX version number.  For example
akcl-1-605.tar.Z would allow you to build the version 1-605 of AKCL.  In
the following this compressed tar file is simply referred to as
akcl.tar.Z.  You will also need to obtain the original kcl distribution
of June 1987.  That is referred to as kcl.tar.Z and is also available on
rascal in the pub/kcl directory.  An alternate source for these files is
cli.com:akcl/akcl-XX.tar.Z In general the bandwidth to rascal is higher
than to cli.com.  Rascal's address is rascal.ics.utexas.edu (128.83.138.20).
				   
* If you cannot obtain these files via internet, a cartridge tape (sun
compatible) or diskettes containing akcl, and kcl sources may be
obtained for $250 US plus shipping, from J. Schelter, 1715
Barnswallow, Autin TX 78746.  This would be in standard tar format.
Some machines on which akcl compiles are 386 under System V (eg
Microport), Sun's (sparc,sun3's), HP under hpux and 4.3, Dec mips ultrix,
Sgi mips irix.

MAKING THE SYSTEM:
==================
To make the whole system, if you have obtained akcl.tar.Z and
kcl.tar.Z

UNCOMPRESS and UNTAR the SOURCES:
--------------------------------

Change to a directory in which you wish to put the kcl and akcl
subdirectories.  Make sure the two files kcl.tar.Z and akcl.tar.Z are
in your current directory.    When you extract the files make sure the write
file write dates are as in the distribution--make needs this.

% mkdir kcl
% (cd kcl ; uncompress -c ../kcl.tar.Z | tar  xvf -)
% mkdir akcl
% cd akcl
% uncompress -c ../akcl.tar.Z | tar  xvf -

      
ADD MACHINE DEFINITIONS TO MAKEFILES:
------------------------------------

Determine the NAME of your machine by looking in the MACHINES file (eg
sun3-os4).  Also remember where you untarred kcl.tar.Z (eg
/public/kcl)

	% add-defs sun3-os4 /public/kcl

	(in general % add-defs NAME DIRECTORY-WHERE-KCL-IS)

	You should finally be ready to go!

RUNNING MAKE:
------------

	% make -f Smakefile 

NOTE: Smakefile is a special makefile which causes make to be run
twice, the first time building a saved_kcl using some interpreted
code, and the second time compiling itself.  If this does not run
twice you will be using a good deal of interpreted code as well as a
combination of old and new compiler, which while sufficient to compile
the new compiler, would not be good for general use.  If you later
change files it will be sufficient to just use the regular makefile
(which has by now been slightly altered).

The make should continue without error.   There may be occasional
warnings from the C compiler, but all files should compile successfully
producing .o files.

The V/* change files will only be used if they are newer (normally the
case) than the existing files.  If you have modified files in the akcl
directory, eg. c/array.c, but wish merge to overwrite that with its
merged version, you could for example % touch V/c/array.c.  Building
akcl successfuly through the second pass, will mail a version info
message to akcl so we know which cpu, c compiler and os levels are
working properly, as well as printing out a message "Make of AKCL xxx
completed", where xxx stands for the version number.

When it has finally finished you may invoke AKCL by using

TRY IT OUT:
----------

% xbin/kcl
AKCL (Austin Kyoto Common Lisp)  Version(1.65) Wed Sep 21 00:52:31 CDT 1988
Contains Enhancements by W. Schelter
>(+ 2 3)

>5


COPY THE COMMAND SCRIPT:
-----------------------

	* You should copy xbin/kcl to /usr/local/bin or some place on users
	search paths.   This is so that users may conveniently invoke the saved
	image with a first arg equal to the directory where the image resides.
	(some things like faslink, autoload,.. need to know the system directory).


ELIMINATE SOME FILES?
--------------------

What to keep if you have no space!  The only files which are ESSENTIAL
to running of AKCL COMMON LISP once you have built the system (if you are
using sfasl, as is default on a sun eg).
  
    unixport/saved_kcl
    /usr/local/bin/akcl                (copy of xbin/akcl)

    Also if you are able to use sfasl, you may even % strip saved_kcl.
Of course keeping sources, documentation, etc. is desirable:
    doc/DOC
    doc/DOC-keys.el
And there are a few unloaded files */*.lisp which are useful to keep.
For example lsp/make.lisp, cmpnew/collectfn.lsp.


DOCUMENTATION:
==============
   If you use gnu emacs, a convenient method for viewing documentation
of common lisp functions (or functions in an extended system), is
provided by the doc/find-doc.el file.  This will be installed when you
do make in the doc directory.  Adding the following to your .emacs
file will allow you to use C-h d to find documentation.

(autoload 'find-doc "find-doc" nil t)
(global-set-key "d" 'find-doc)
(visit-doc-file "/public/akcl/doc/DOC")

See the file find-doc.el for more information.
Otherwise you may use the describe command inside lisp.
For example (describe 'print) will print out information about
print.   You may also peruse the file doc/DOC.


INSTALL:
=======
After the system has been built, in the main akcl directory

% make install 

will copy the command to execute kcl to the LBINDIR,
and will also attempt to install the documentation interface
for gnu emacs.   You will have to have write permission in the
emacs directory, and LBINDIR for this, so you may need to
be super user.


TROUBLE SHOOTING (some common problems reported):
----------------   

1) Did you extract the files with the original write dates--make
depends heavily on this?

2) Did you use -O on a compiler which puts out bad code?  Any time you
change the settings or use a new c compiler this is a tricky point.

3) A sample transcript from a correct make is included under
doc/sample-make.  If yours compiles less often or does things
differently, something is wrong, probably with dates or the clock on
the server or something.

4) If you can't save an image, try doing so on the file server rather
than a client.

5) Doing the make on a client with the main files on a server, has
sometimes caused random breakage.  The large temp files used by the C
compiler seem to sometimes get transferred incorrectly.  Solution: use
the server for the compile.

6) Did you make changes in the .defs or .h files, other than just
commenting out a CC=gcc line?


CHANGING THINGS: MAYBE EDIT TWO FILES:
--------------------

Normally you should not need to edit ANY files.  There may be some
parameter sizes you wish to change or if you don't have gcc where
we have made that the default, then see CC below.


EDIT the appropriate h/NAME.defs file.   These are definitions to
be included in the various makefiles.

For example if the `NAME' of your machine is sun3-os4.

% emacs h/sun3-os4.defs

   * CC: set C compiler options.  For example, if you are using the GNU
     C compiler:

     CC = gcc -msoft-float -DVOL=volatile -I$(AKCLDIR)/o

         Or, if you are using the conventional UNIX C compiler:

     CC = cc -DVOL= -I. -I$(AKCLDIR)/o
     
   * ODIR_DEBUG:
     
     ODIR_DEBUG= -g

     If you want files in the main c source compiled with debugging
     information.   Note this is incompatible with OFLAGS= -O on
     some compilers.   Size will be smaller without -g, but you
     are then helpless in the face of problems.
     
   * INITFORM: The normal thing is to just have the one form
     required for fast loading.

    INITFORM=(si::build-symbol-table)


-----------

EDIT the file h/NAME.h  (eg h/sun3-os4.h)

(Actually you probably don't need to change it)

This file will be included by virtually every compilation of C
files, except the translated C produced by kcl.

% emacs h/sun3-os4.h

      if you wish to change a parameter such as MAXPAGE 16384 established
      in bsd.h (ie. number of 2000 byte pages you want as your absolute max
      swap space).   MAXPAGE must be a power of 2.

      #undef MAXPAGE
      #define MAXPAGE (2 * 16384)

      You may similarly redefine VSSIZE the maximum size for the value
      stack (running very deep recursion interpreted may well require this).



DISCLAIMER:
----------

W. Schelter, the University of Texas, and other parties provide this
program on an "as is" basis without warranty of any kind, either
expressed or implied, including, but not limited to, the implied
warranties of merchantability and fitness for a particular purpose.


Bill Schelter 
wfs@math.utexas.edu

See the file doc/contributors for a partial list of people who have
made helpful contributions to ports etc.
