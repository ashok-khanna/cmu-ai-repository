Subject: Free simulation software
From:    Bard Ermentrout <bard@mthbard.math.pitt.edu>
Date:    Thu, 23 Sep 93 10:41:48 -0500

        F R E E    S I M U L A T I O N   S O F T W A R E

I thought perhaps that modellers etc might be interested to know of the
availability of software for the analysis and simulation of dynamical and
probabilistic phenomena.  xpp is available free via anonymous ftp.  It
solves integro-differential equations, delay equations, iterative
equations, all combined with probabilistic models.  Postscript output is
supported.  A variety of numerical methods are employed so that the user
can generally be sure that the solutions are accurate.  Examples are
connectionist type neural nets, biophysical models, models with memory,
and models of cells with random inputs or with random transitions.  A
graphical interface using X windows as well as numerous plotting options
are provided.  The requirements are a C compiler and an OS capable of
running X11.  The software has been successfully compiled on
DEC,HP,SUN,IBM,NEXT workstations as well as on a PC running Linux.  Once
it is compiled, no more compilation is necessary as the program can read
algebraic expressions and interpret them in order to solve them.  The
program has been used in various guises for the last 5 years by a variety
of mathematicians, physicists, and biologists.  To get it follow the
instructions below:

- ------------Installing XPP1.6--------------------------------

 XPP is pretty simple to install
although you might have to add a line here and there
to the Makefile.  You can get it from
            mthsn4.math.pitt.edu (130.49.12.1)
here is how:

   ftp 130.49.12.1
   cd /pub
   bin
   get xpp1.6.tar.Z
   quit
   uncompress xpp1.6.tar.Z
   tar xf xpp1.6.tar
   make -k

If you get errors in the compilation it is likely to be one
of the following:
1) gcc not found in which case you should edit the Makefile
   so that it says  CC= cc
2)  Cant find X include files.  Then edit the line that says
    CFLAGS= ....
    by adding
            -I<pathname>
where <pathname> is where the include files are for X, e,g,
     -I/usr/X11/include
3) Cant find X libraries.  Then add a line
LDFLAGS= -L<pathname>
right after the CFLAGS= line where <pathname> is where to find the X11
libraries
then  change this line:
$(CC) -o xpp $(OBJECTS) $(LIBS)
to this line
$(CC) -o xpp $(OBJECTS) $(LDFLAGS) $(LIBS)

That should do it!!
If it still doesnt compile, then you should ask your sysadmin about
the proper paths.

Finally, some compilers have trouble with the GEAR algorithm if they
are optimized so you should remove the optimization flags i.e. replace
CFLAGS=  -O2 -I<your pathnames>
with
CFLAGS=   -I<your pathnames>

delete all the .o files and recompile

Good luck!
   Bard Ermentrout


  Send comments and bug reports to
     bard@mthbard.math.pitt.edu

