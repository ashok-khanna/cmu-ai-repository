Abstract from "BUGS: A Non-Technical Report":

BUGS (Better to Use Genetic Systems) is an interactive program for
demonstrating the Genetic Algorithm and is written in the spirit of
Richard Dawkins' celebrated Blind Watchmaker software.  The user can
play god (or `GA fitness function,' more accurately) and try to evolve
lifelike organisms (curves).  Playing with BUGS is an easy way to get
an understanding of how and why the GA works.  In addition to
demonstrating the basic genetic operators (selection, crossover, and
mutation), it allows users to easily see and understand phenomena such
as genetic drift and premature convergence.  BUGS is written in C and
runs under Suntools and X Windows.

See "Designing Biomorphs with an Interactive Genetic Algorithm," J. R.
Smith, Proceedings of the Fourth International Conference on Genetic
Algorithms.



What you get:

The directory BUGS contains the `non-technical report' mentioned
above, this README file, and three subdirectories, "X_version,"
"Suntools_version," and (NEW!) "morph".  As you might expect, the
first two contain the X Windows and Suntools versions of the BUGS
program.  The subdirectory called "morph" contains a program that runs
under Suntools.  It "morphs" between randomly chosen biomorphs.


Unpacking:

Before you can compile BUGS, you need to uncompress it and then de-tar
it.  To uncompress it, type
     uncompress BUGS.tar.Z
To de-tar it, type
     tar -xf BUGS.tar BUGS



Compiling and Running BUGS:

After you've downloaded and uncompressed BUGS, you should put it in
its own subdirectory.  The two versions (X and Suntools) are different
programs; you'll probably only want to use one of them.  Each version
has its own subdirectory, complete with its own makefile.  So just cd
into the appropriate subdirectory (`X_version' or `Suntools_version')
and type `make' to compile.  To run, type `b' (the letter `b').  Away
you go.


Questions or problems? Send email to jrs@santafe.edu.

Joshua Smith
