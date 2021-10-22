This source code and accompanying documentation is

		Copyright 1990 Rick McGowan

It is provided free-of-charge, as-is with no stated or implied level of
support, usefulness, or fitness for any purpose whatsoever.  It may be
freely distributed in source or binary form provided this notice and
all other copyright notices remain intact.

This directory contains the source for "vamv".  There's a file called
"Time.Stamp" which indicates the time it was archived from my source
tree.  Full "user" documentation is in "Vamv.Doc".  This file contains
notes on building the source.

To make an executable "vamv" in the default configuration just type
"make".  It will compile and link the required objects.  The program
(vamv) assumes it is running in a directory that has write permission
(for ".LastRun") and that "Lim.File" exists in the same directory.

The program will execute unchanged on ANSI type terminals.  It is
assumed that the screen-clear sequence is:
	esc [ H esc [J
and the cursor positioning sequence is:
	esc [ i ; j H
where "i" and "j" are row & column.

Vamv works very well at 19200 baud and 9600 baud (at 19200 organisms
seem to really swarm).  If you wish to make a version for very low-speed
connections, then use:
	#define LOWSPEED
in "prog.h"; that will make a version with a smaller (20 by 35) board.
It is still agonizingly slow on 1200 baud connections.  The default
board is 22 by 70, suitable for terminals at 19200 and 9600 baud.
If you wish to make a more square version with nearly the same area as
the default (suitable for variable window sizes), then use:
	#define SQUARE
in "prog.h".

If you're on System V Rel 3, you can edit the Makefile to set LIBS
to "-lc_s" if you wish to use shared libraries.  The rest of the
source shouldn't depend on your local operating system flavor.
It is assumed that you have two functions available in the standard
library:

	srand(i)	- seed the random number generator
	rand()		- return a random number

If you don't, oh well, fake it as best you can, or edit the Makefile
to link a library that has random number generators in it.

If you wish to profile the program (I can tell you now, about 70%
of its time is spent in "makemoves()") you can edit the CFLAGS in
the Makefile.  I've not been able to get MARK to work properly to
mark off sections of "mutate()".

Note that if you run the examples in Vamv.Doc with a different random
number generator than I have (on System V, Release 3.1), then you will
get different results.  On System V, unless the generator has changed
recently, you should get the same results.  I have not checked this
program on any machine with "char" type sign-extension, but it shouldn't
be a problem.  If it is, contact me and I'll fix it!

	Rick McGowan
	upheisei!rick@att.COM
	or, contact via: sun.COM!pyramid!xdos!doug
			 xdos!doug@apple.COM

