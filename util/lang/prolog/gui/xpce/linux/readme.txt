Dear Linux user,

I'm happy to announce release 4.6.6 of XPCE/SWI-Prolog/C++ for Linux.

WHAT IS XPCE?
=============

XPCE is a  symbolic  object-oriented   interface  toolkit  for  symbolic
programming languages and C++.  XPCE offers  a high level of abstraction
for communication with X11, Unix   processes, Unix networking facilities
(sockets) and Unix files.   XPCE's  built-in   classes  (about  150) are
mostly written in the C language.   The XPCE/Prolog interface allows the
user to create instances of these classes and manipulate instances.  The
user can also create new XPCE classes from Prolog.

XPCE's  window  related  classes  provide   various  styles  of  menu's,
primitive  graphical  objects,  compound  graphical  objects  and  Emacs
oriented programmable text manipulation windows.


ChangeLog (Summary; full ChangeLog is in the ftp directory)
===========================================================
Relative to 4.6.0
 
	* Added interface to C++.  Tested on SunOs 4.1.x and Linux
	0.99.13/gcc/g++-2.4.5/libc-4.4.2.  Allows linking C++/XPCE
	applications to XPCE/SWI-Prolog and allows for stand-alone
	XPCE/C++ applications.  Feedback (notably from real C++
	programmers is welcome!)

	* Removed unnecessary redisplay from text_item.  This is a big
	speed-up for the creation of some dialog windows.

	* Fixed two important memory-leaks.  A modification to the
	class-building system that reduces memory requirements by
	about 0.5 MB.

	* Completed/debugged/tested integration of dialog(items) and
	graphics.  This allows for user-defined dialog-items,
	auto-layout of dialogs holding normal graphicals (so, also
	list-browsers) and dialogues built from recursively nested
	sub-dialog.

	* Hopefully support of international keyboards/character sets
	(that is, displaying them is tested, using a
	french/spanish/swedish/...  keyboard I can't test).

	* Bugfixes. 

	* SWI-Prolog upgrade to 1.8.6 (only minor details).


FILES AND ORGANISATION
======================

	ftp site:	swi.psy.uva.nl  	(145.18.114.17)
	directories: 	pub/xpce/doc/..		(PostScript documentation)
			pub/xpce/linux		(Linux binaries)

To install the system from the precompiled and linked binaries you need

	pub/xpce/linux/xpcebin.i386-linux-0.99.13.tgz
	pub/xpce/linux/xpcelib.tgz
	BININSTALL

For those that like to link to   other  languages, modify SWI-Prolog and
link it to XPCE, etc.  there is

	pub/xpce/linux/xpcekit.i386-linux-0.99.13.tgz

Which contains the XPCE.a library, the   pl.o SWI-Prolog object file and
the .o files and sources for the   interface.   For this package too you
need pub/xpce/linux/xpcelib.tgz.


LINUX VERSIONS
==============

I compiled and linked all this on   stock SLS-1.03 with a 99pl13 kernel.
Libc 4.4.2.  The binary is  statically   linked  to  avoid problems with
saved states and is likely  to  run   on  most  more modern kernels.  To
relink from the kit, versions are probably critical.


LINUX BINARY VERSION vs. REGULAR VERSION
========================================

This  distribution  contains   a  binary  image  of  XPCE  connected  to
SWI-Prolog compiled  for  PC/Linux.   The regular  distribution  of XPCE
includes the sources and compiles on  various Unix machines  (see INFO).
It contains interfaces to both SWI-Prolog  and SICStus Prolog as well as
Sun  Lucid  CommonLisp and LispWorks.   See the file  INFO for  ordering
information.

The  binary Linux version  is (albeit  possible  porting problems) fully
equivalent to  the regular version.  It  may be copied  free of  charge.
XPCE/SWI-Prolog is distributed in the hope  that it will be useful,  but
WITHOUT   ANY   WARRANTY;  without   even   the  implied   warranty   of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Holders of the regular licence are allowed to modify XPCE and/or connect
it to  other  languages.  They are allowed  to distribute fully compiled
and  linked  executables  that  include XPCE for  the PC/Linux operating
system under the same conditions as this distribution.
