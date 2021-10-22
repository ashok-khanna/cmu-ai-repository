                          ---------------------------
                          THE SOAR ANONYMOUS FTP SITE
                          ---------------------------

Last updated 3-May-94 by Allan Rempel (rempel@cs.cmu.edu).

Welcome to the anonymous ftp site of the Soar group!  This is a repository
for various Soar releases and other related stuff.

The two most recent main versions of Soar are Soar 5, a Lisp-based version,
and Soar 6, a C-based version.  Currently, Soar 5 is minimally supported,
and new users are strongly urged to use Soar 6.  Soar 6 continues to see
active development.  Soar 5 files are contained in the Soar5 directory,
and Soar 6 files are in the Soar6 directory.


Soar 6 files:

The repository of Soar 6-related files includes releases for Unix, Mac,
and MS Windows systems.  All of the Unix release filenames have
the form 6.A.BC.tar.Z where A and B are numbers, and C is a letter.
A corresponds to a major revision and B to a minor revision.  C is one of
the letters a, b or g which stand for:

  - Alpha release (the most recently released version)
  - Beta release (the next most recently released version--more stable)
  - Gamma release (the most stable released version)

The Mac release filename has the form MacSoar6.A.B.hqx where A and B are
as above.

The MS Windows release filename has the for IntelSoar6.A.B.zip where A and B
are as above.  The IntelSoar6.A.B.exe is a self-extracting archive for
those who don't have an unzip program.  Documentation is provided in the
IntelSoarDoc.6.A.B.zip file.  The IntelSoar versions are provided
independently of the main Soar effort, and are not yet fully supported
by the project.

The Soar Development Environment (SDE) (sde.tar.Z) is a facility for
developing Soar programs using GNU Emacs.  It includes programming
facilities tailored for Soar and a powerful interface for interacting
with Soar itself.

A version of the Soar 6 manual has also been made available online as
soar6-manual.tar.Z.  It is in gnu-info format, and can be viewed
either using the gnu-info tool (included) or by using the info mode
in emacs.


How to unpack a .tar.Z file:

A file name that ends in .tar.Z indicates a compressed tar file.  To unpack
this file, first put the file into a empty directory via the following:
     % mkdir <directory_name>
where <directory_name> is where you want to compile the code.
     % cp <filename>.tar.Z <directory_name>
where <filename> is everything except for the .tar.Z part of the file
you are trying to unpack. (i.e. 6.0.0g  if your .tar.Z file was named
6.0.0g.tar.Z)
     % cd <directory_name>
You will now be in the directory where you are going to unpack the code.
At your prompt type
     % uncompress <filename>.tar.Z
This will leave you with a file named <filename>.tar
Now, if you want to see all the files in the archive as they are being
unpacked, type
     % tar -xvf <filename>.tar
If you just want it to quietly unpack everything, type
     % tar -xf <filename>.tar
When it is finished unpacking, you should have the following in the
directory where you initially placed the .tar.Z file.
  a) The <filename>.tar file.
  b) A directory named 6.X.Y where X and Y are numbers.  This directory
     will have all the rest of the source code files below it.
You can at this point remove the .tar file if you wish.


How to compile the Soar6 code:

Change directory into the directory created by unpacking the code in the
previous step.  In this directory, there will be a file named 'makefile'.
I will refer to this file as the makefile from here on out.
  a) Edit the makefile, and set the line that reads:
       CC = gcc
     to be the appropriate compiler for your system.  If you do not know what
     compiler is appropriate, ask a system adminitrator at your site or ask
     your local help facility.
     For most systems, you will not need to change this line.
  b) If you are adding any code (for IO or hooks) to the source code, place
     these .c files into the user subdirectory that exists in the current
     directory.  You will only need to add code if you are creating new
     functions, or changing the abilities of current functions in the soar
     code.  If you do not understand what that means, you are most likely
     not adding any code.
  c) If you did not add any files, go to step e.
  d) For every file you added to the user subdirectory in step c, edit the
     makefile, and add the file's name to the line that defines the files to
     be compiled as user source code.
  e) If you didn't add any files and if a version of soar6 already exists at
     your site, you can run the version that's been compiled previously; you
     don't need to run a compile. Go to step g.
  f) Type 'make' at your prompt.  (This will create the soar executable
     and the convert program executable in the bin subdirectory.) If you are
     using gcc as your compiler, ignore any warnings that appear during this
     step.
  g) The final step is to add the soar executable to your path so that you can
     run it. (If you do not know how to add a directory to your path, ask a
     person at your site who knows a bit about UNIX.)
  h) If you did not need to recompile the soar executable, you should just be
     able to add the standard soar executable directory at your site to your
     path.
  i) If you did recompile soar, you will want to add the bin subdirectory
     below the current directory to your path, OR move the executables created
     in the bin subdirectory to where you wish them to be run from.

How to get help if things don't work:
  If you follow these steps, and things do not work correctly for you, you
  should report the problems to soar-bugs@cs.cmu.edu.

How to use the Soar program and the convert program:
  The convert program has its own README file which can be found in the
  subdirectory named convert.  Read this file to learn how to use the convert
  program.

  To run both the convert program and the soar program, you should (assuming
  the steps above to install it worked) be able to just type the name of
  the program (along with any arguments) on the command line.

Soar6 default rules:
  The standard set of soar 6 default rules exists in the subdirectory 
  default.

Testing:
  If you want to run the regression test code that we use for testing code
  changes to make sure everything installed correctly, change directory into
  the tests subdirectory and execute the run-all-tests shell script.
