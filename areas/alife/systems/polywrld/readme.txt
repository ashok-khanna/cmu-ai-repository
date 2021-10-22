The subdirectories in this "polyworld" area contain the source code for the
PolyWorld ecological simulator, designed and written by Larry Yaeger, and
Copyright 1990,1991,1992 by Apple Computer.

Postscript versions of my Artificial Life III technical paper have now
been added to the directory.  These should be directly printable from
most machines.  Because some unix systems' "lpr" commands cannot handle
very large files (ours at least), I have split the paper into
Yaeger.ALife3.1.ps and Yaeger.ALife3.2.ps.  These files can be ftp-ed
in "ascii" mode.  For unix users I have also included compressed
versions of both these files (indicated by the .Z suffix), but have
left the uncompressed versions around for people connecting from
non-unix systems.  I have not generated PostScript versions of the
images, because they are color and the resulting files are much too large
to store, retrieve, or print.  Accordingly, though I have removed a
Word-formatted version of the textual body of the paper that used to be
here, I have left a Word-formatted version of the color images.  If you
wish to acquire it, you will need to use the binary transfer mode to
move it to first your unix host and then to a Macintosh (unless Word on
a PC can read it - I don't know), and you may need to do something
nasty like use ResEdit to set the file type and creator to match those
of a standard Word document (Type = WDBN, Creator = MSWD).

This is an all too brief writeup on how to acquire and use PolyWorld from this
fileserver.  The bulk of the simulator code is in /pub/polyworld/rev## (only
rev19 exists currently).  A couple of files that will be needed if you happen
to be running under a very old version of Irix (3.2) and using AT&T's C++
compiler, are located in /pub/polyworld/CC.  If you are running the current
operating system, Irix 4.0.1, and using SGI's C++ compiler, the files in the
CC directory are not needed.

Copy all of the files to your machine using ftp as usual.  ASCII mode is fine.
I was keeping the couple of CC files in a subdirectory directly beneath my
home directory, as all projects need these when I am working under the old
operating system and AT&T compiler.  Moving all these files can easily
be accomplished by turning "prompt" off, and doing an "mget *", once you
have moved to the appropriate local and remote directories.

Alternatively, you can use binary mode and transfer the single "rev19.tar.Z"
file, which is just a tar-ed, compressed version of the rev19 subdirectory.
If you create your own "polyworld" directory, and use ftp to move this file
there, you can type "uncompress rev19.tar.Z" and "tar oxvf rev19.tar" to
create the rev19 subdirectory.  You will still have to manually move the
couple of files in the CC directory by hand, if and only if you are using the
old Irix 3.2 and AT&T C++ combination.

There are actually two or three fairly distinct versions of the
code wrapped together - one for Irix 3.2 with AT&T's C++ and one for
Irix 4.0.1 with SGI's C++ (plus an optimal foraging experiment "OF1"
embedded in the normal simulator).

To select one or the other, you edit "makefile.h", and turn on or off
the ATT_IRIX3.2 flag, and then run cpp on makefile.c to produce your
new makefile.  You can actually just "source aliases" (or move the one
line there to your own .aliases file so it'll be available for all
future logins), and type "makemake".  (For the optimal foraging
experiment you turn on OF1 in critter.h, but be warned that this is a
special-purpose bit of code, that may not persist or be supported - or
may be made a permanent option, but properly controllable from the
"worldfile"... we'll see.)

If you are using the ATT_IRIX3.2 version, then you also need the couple
of files (gl.h and kluge.c) in the CC subdirectory somewhere (I keep them
just below my home directory, as you can see below).  And you point to
these files at the start of makefile.h.  The first few lines of
makefile.h look like:

----------------------------------------------------------------------

#ifdef NEVERDEFINED
// Place flags here to turn them off.
// It's okay to keep a list of possible flags here,
// and just copy them below to turn them on.
#define DEBUG
#define ATT_IRIX3.2
#endif

#ifdef ATT_IRIX3.2
CC=CC
CCINCLUDE = /usr/local/include/CC
GLFILE = /usr/u/larryy/CC/gl.h
KLUGEFILE = /usr/u/larryy/CC/kluge.c
#else
CC=CC
CCINCLUDE = /usr/include/CC
GLFILE = /usr/include/gl/gl.h
#endif

----------------------------------------------------------------------

You set CC to point to your system's C++ compiler, CCINCLUDE to point
to the directory where all of the C++ specific include files are
located, GLFILE and KLUGEFILE to the files in the special CC
directory.  For Irix 4.0.1 and SGI's C++ (the else clause), you only
need to set CC, CCINCLUDE, and GLFILE (all three of which are typically
the standard areas and files).  All this, of course, depends upon how
your system administrator set up your particular system.  (For the old
Irix 3.2 and AT&T's C++, you need to move the #define ATT_IRIX3.2 line
down to somewhere before the first #ifdef ATT_IRIX3.2.)

To compile PolyWorld then, you should first type "make depend", and
then "make".  "make depend" produces a file containing a complete list
of file dependencies, which is used during the "make".  You can ignore
a few warnings about non-const member functions being called for const
objects.  And you may seem some warnings about " signed" in gl.h not
being implemented; you can ignore these as well.

Finally, to run PolyWorld, you just type "pw", and it will
automatically read a file called "worldfile" to initialize its various
parameters, and begin to run.  There are a variety of additional
command line options, including -f filename to read an alternate "world
file".  Typing "pw +" (or pw followed by anything that it doesn't know
about) will cause it to display all of the available options -- or most
of them if I haven't kept it entirely up to date <sigh>.  I'll try to
provide a brief description of all the command line options soon.

The sample worldfile that has been provided is a relatively small
simulation, with few enough initial and allowed organisms that it can
probably run on a machine with only 16MB of RAM.  Running it at the
Artificial Life III conference, it seemed to produce a viable species
(the smallest world yet to do so), so it may be an interesting place
to start your own experiments.

You'll notice when you look in this sample worldfile that there is a
short label next to each input value.  These are just labels, not
keywords or anything like that... they are there purely for the user to
know what the parameters are, and are simply read out of the way by
"pw".  So the input file is strictly order dependent.  Hopefully some
of those labels will be sufficient to indicate the function of the
corresponding parameter; I will try to provide a brief description of
all of the worldfile's control parameters soon.

To exit the simulator, just hit "ESC"ape.  Hitting ESC once will terminate
the run after dumping its state to a "pw.dump" file.  The simulator can
be restarted from this point by using the "pw -l" (load) option.  The
simulator will also periodically checkpoint itself to this file (at a
frequency settable in the worldfile).  PolyWorld will also write out a
few simple statistics for the simulation to a "pw.stat" file at a
specifiable frequency.  Hitting ESC twice (less than a second apart) will
exit *without* creating the pw.dump file (though it will still write the
much smaller pw.stat file).

Some of the code is fairly well organised, and some is just horrible,
with lots of historical code that isn't even being used, too many
#ifdef's, and so on.  Sorry... but you're seeing code that was
originally only intended for my own consumption!  Oh yes, you can also
ignore a bunch of verbiage printed by the code when it exits, regarding
memory allocation.  I believe that I have left my own "new" and "delete"
functions in place that try to keep track of all memory allocations and
deletions (in order to plug memory leaks), which are responsible for this
printed information about "new"s without corresponding "delete"s and such.

Though I've been using the code for quite a while now, I've continued to
make changes to it, and, of course, cannot guarantee it to be bug free!
In fact, I noticed an odd problem with updating a couple of the graph
windows when the simulator was run under Irix 4.0.1 on a VGX class machine
at the ALife III conference, that I have not been able to duplicate on
my machine.  I may soon be upgrading to 4.0.1 on my machine, at which point
I should be able to find and fix this problem.
