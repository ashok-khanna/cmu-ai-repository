Description of GCL (GNU Common Lisp) system.

OVERVIEW:

The GCL system contains C and Lisp source files to build a Common Lisp
sytem.  The original KCL system was written by Taiichi Yuasa and
Masami Hagiya in 1984.  The AKCL system work was begun in 1987 by
William Schelter and continued through 1994.  A number of people have
contributed ports and pieces.  The file doc/contributors lists some of
these.  In 1994 AKCL was released as GCL (GNU Common Lisp) under the
GNU public library license.  Version akcl-1-624 was the last version
made under the old license and using the old file change mechanism.
This readme only applies to versions gcl.1.0 and later.  The GNU
library license does allow redistribution of executables containing
GCL as well as proprietary code, but such redistribution must be
accompanied by sufficient material (eg .o files) to allow recipients
to rebuild an executable, after possibly modifying GCL.  See the GNU
file COPYING.LIB-2.0 for a full description of your right to copy this
software.



OBTAINING SOURCES:
-----------------

* There are source files on math.utexas.edu:pub/gcl/gcl.x.x.tgz You
probably want the highest XX version number.  For example gcl-1.0.tgz
would allow you to build the version 1.0 of GCL.  In the following
this compressed tar file is simply referred to as gcl.tgz.  An
alternate source for these files is ftp.cli.com:pub/gcl/gcl-XX.tgz If you
do not have gzip it is available in the directory
/anyonymous@prep.ai.mit.edu:/u2/emacs .
GCL will also be available on prep.ai.mit.edu
				   

MAKING THE SYSTEM:
==================
To make the whole system, if you have obtained gcl.tgz. 

UNCOMPRESS and UNTAR the SOURCES:
--------------------------------

Change to a directory in which you wish to put gcl, eg /usr/local,
which we shall call PREFIX-DIR.
Copy the file gcl.tgz to the PREFIX-DIR.

% gzip -dc gcl.tgz | tar  xvf -

This will create the directory ${PREFIX-DIR}/gcl-1.xxx with
all the sources in it


      
ADD MACHINE DEFINITIONS TO MAKEFILES:
------------------------------------

Determine the NAME of your machine by looking in the MACHINES file (e.g.
sun3-os4).

        % cd gcl-1.xxx 
	% add-defs sun3-os4 

	You should finally be ready to go!

RUNNING MAKE:
------------

	% make

The make should continue without error.   There may be occasional
warnings from the C compiler, but all files should compile successfully
producing .o files.

At the end you should see a message at the end "Make of GCL xxx
completed", where xxx stands for the version number.

TRY IT OUT:
----------

When it has finally finished you may invoke GCL by using

% xbin/gcl
GCL (GNU Common Lisp)  Version(1.0)  Apr 21 00:52:31 CDT 1994
Contains Enhancements by W. Schelter
>(+ 2 3)

>5



INSTALLING:
----------
	To install under /usr/local do

		make install

	To specify an alternative directory such as /lusr
   	do 

	make install PREFIX_DIR=/lusr

	The default installation puts a full executable in

        /usr/local/lib/gcl-version/unixport/saved_gcl

	and some doc in
          
          /usr/local/lib/gcl-version/doc/

	and some autoloading files in

	  /usr/local/lib/gcl-version/lsp

        and a shell script in /usr/local/lib/gcl-version/xbin/gcl
	This script is also copied to

	/usr/local/bin

FUTURE DIRECTIONS
(and how you may be able to help)   Volunteers should contact
William Schelter (wfs@math.utexas.edu)

a) Upgrading to comply with the forthcoming ANSI standard.   Work 
needs to be done.   

b) Need work on providing a high level window interface.   One possible
way would be a good connection with TCL/TK.   Another would be to go
in the direction of CLIM.   

A new compiler has been written, which is closer to the ANSI standard
and provides some other benefits.   It will be in a future release.
We will need people willing to beta test and isolate any bugs.

Additonal work planned or desired:

  * Clean up distribution and installation.  Make it easier to link in
C code such as Novak's window stuff.   Faslink is not portable (since
many systems don't support ld -A).

  * Introduce COMMON-LISP and COMMON-LISP-USER packages as per ANSI
standard, change the package functions to behave as in the ANSI
standard.  Any other changes which people can identify which would
make life easier, and are compatible with ANSI.

  * Introduce C level and Lisp level way of signalling errors of the
types specified by the ANSI standard.  Make it so that when the CLOS
is present these become error objects.

  * Fix the run-process stuff to properly deallocate processes and
have listen do the right thing, by using select, which is POSIX.  Try
to make it compatible with the one in Allegro or Lucid.

  * Turn ANSI documentation into the new Lisp's on-line documentation.
This will be useful for development and for users.  No sense in basing
our work on the CLTL 2.  Must go to the ANSI document itself.

  * Make an appropriate Unix man page.

  * Add my allocation files and other changes necessary to make
INTERRUPTS safe.  This probably means adding in all the C files which
I have already written.

  * Change function calls to all refer to C stack and pass return
values in a uniform way, the way the new compiler does it.  This will
greatly improve funcalling, since right now there are generally two
types of functions which can be expected, and they expect their
arguments in different places.

  * Change to the new compiler which does things better from the ANSI
point of view, and is smaller, and makes all function calls go via the
C stack.

  * Include CLOS support.  Possibly take this from PCL or from
Attardi, who has written some.

  * Include a windowing interface with TCL/TK which is capable of
producing TK (similar to Motif but public) style windows and
scrollable menus, etc.  This implementation must be done in such a way
that it works in at least one additional Lisp, such as Allegro or
Lucid.

  * Loop package: either make sloop satisfy the standard or include
another implementation.

  * Changes to READ for ANSI, (including case sensitivity, etc.).

  * Byte compiler based on first pass of the new compiler.  Ideally
provides very small code and extremely rapid compiling for general
platform.  Notes: I have put the interrupt and run-process stuff early
on since it is necessary for window development.

  * Construct a Common Lisp test suite to help debug new releases.

DOCUMENTATION:
==============
   If you use GNU emacs, a convenient method for viewing documentation
of Common Lisp functions (or functions in an extended system), is
provided by the doc/find-doc.el file.  This will be installed when you
do make in the doc directory.  Adding the following to your .emacs
file will allow you to use C-h d to find documentation.

(autoload 'find-doc "find-doc" nil t)
(global-set-key "d" 'find-doc)
(visit-doc-file "/usr/local/lib/gcl/doc/DOC")

See the file find-doc.el for more information.
Otherwise you may use the describe command inside Lisp.
For example (describe 'print) will print out information about
print.   You may also peruse the file doc/DOC.


TROUBLE SHOOTING (some common problems reported):
----------------   

1) Did you extract the files with the original write dates--make
depends heavily on this?

2) Did you use -O on a compiler which puts out bad code?  Any time you
change the settings or use a new c compiler this is a tricky point.

3) If you can't save an image, try doing so on the file server rather
than a client.

4) Doing the make on a client with the main files on a server, has
sometimes caused random breakage.  The large temp files used by the C
compiler seem to sometimes get transferred incorrectly.  Solution: use
the server for the compile.

5) Did you make changes in the .defs or .h files, other than just
commenting out a CC=gcc line?

6) Did you read the recommendations in the XXXX.defs file on what
C compiler versions work?


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

     CC = gcc -msoft-float -DVOL=volatile -I$(GCLDIR)/o

         Or, if you are using the conventional UNIX C compiler:

     CC = cc -DVOL= -I. -I$(GCLDIR)/o
     
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