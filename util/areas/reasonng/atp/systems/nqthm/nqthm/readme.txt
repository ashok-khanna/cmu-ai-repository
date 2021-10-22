This is the `README' file for the directory /pub/nqthm/nqthm-1992/ on Internet
host ftp.cli.com, where a publicly available version of Boyer and Moore's
theorem-prover Nqthm, the 1992 version, may be found.


			       LICENSE INVOLVED

Copying and use of Nqthm-1992 is authorized to those who have read and agreed
with the terms in the Nqthm-1992 GENERAL PUBLIC SOFTWARE LICENSE, which may
be found at the beginning of the Nqthm file `basis.lisp' and also in the files
`nqthm-public-software-license.doc' and `nqthm-public-software-license.ps'.


			     OBTAINING NQTHM-1992

One may obtain Nqthm-1992 by tape or ftp.  We prefer that you obtain it by ftp,
and there is no charge if you obtain it by ftp; we charge for tapes.  For
further information on obtaining Nqthm by ftp, skip to the section NON-UNIX FTP
or UNIX FTP below.  For information on obtaining Nqthm-1992 on tape, write to
Software-Request, Computational Logic Inc., 1717 West Sixth, Suite 290, Austin,
TX 78703-4776, USA; email: Software-Request@cli.com.  FAX: +1 512 322 0656.

If you have a tape sent by Computational Logic, it was made with the command:

    % tar cvf /dev/rmt8 nqthm-1992

which produced an industry standard 6400 bpi tar tape.  To read the tape, mount
it and execute the command:

    % tar xvf /dev/rmt8

assuming that /dev/rmt8 is the name of your tape drive.  This command will copy
all the files on the tape into an `nqthm-1992' subdirectory of the directory to
which you are currently connected.  Now proceed to the COMPILE instruction of
this README file.


				 NON-UNIX FTP

To obtain Nqthm-1992 by ftp, connect to ftp.cli.com with the login name
`anonymous' and your email address as the password.  If you are not running a
Unix or variant system, then ftp all of the files on the /pub/nqthm/nqthm-1992/
directory and its sub- and subsub-directories, except `nqthm-1992.tar.Z', and
then go to the COMPILE instruction of this README file.  Because there are
over a hundred files and over a dozen subdirectories, making sure that you have
gotten all of the files in this way can be tedious!  So even if you are not
running Unix, you may be well advised to try to get the files using some
variant of the directions for UNIX FTP below.


				   UNIX FTP

To obtain Nqthm-1992 by ftp, connect to ftp.cli.com with the login name
`anonymous' and your email address as the password.  If you are running a Unix
or Unix variant, then `cd' to /pub/nqthm/nqthm-1992 and `get' the single file
`nqthm-1992.tar.Z'.  Be sure to use binary mode, e.g., execute the ftp command
`binary' before doing the `get'.  Checksum information for `nqthm-1992.tar.Z'
may be found in the file `SUM', which you may obtain with another `get'; after
you have obtained `nqthm-1992.tar.Z', executing `sum nqthm-1992.tar.Z' should
produce the same results as are found in the file `SUM'.  See the file
`make.nqthm-1992.tar' for information on how `nqthm-1992.tar.Z' and `SUM' are
created.  `nqthm-1992.tar.Z' is almost four megabytes long.

The next step is to:

				  UNCOMPRESS

% uncompress nqthm-1992.tar.Z

				     UNTAR

% tar xvf nqthm-1992.tar

This `tar' command will create a subdirectory named `nqthm-1992', which
contains the sources and examples.  This will take up almost 16 additional
megabytes.  You may now delete the file nqthm-1992.tar to save space.


				    COMPILE

% cd nqthm-1992
% lisp  ; Or whatever commands starts your Lisp.
> (load "nqthm.lisp")
> (proclaim '(optimize (speed 3) (safety 0) (space 0)))
> (in-package "USER")
> (compile-nqthm)  ; maybe 40 minutes on a Sun-3/280
> (bye)  ; however you get out, if you can.

If you encounter problems at this stage, please consult the installation
chapter in the file `doc/manual-update.ps', which describes many sorts of
environmental problems you may be encountering and some work arounds.  (To use
Nqthm under CMU Lisp 16e, use (space 1) in the optimize proclamation to avoid a
compiler bug.)


				     LOAD

% lisp
> (load "nqthm.lisp")
> (in-package "USER")
> (load-nqthm)
> ; Nqthm is now ready to use.  Here is a simple test.
> (boot-strap nqthm)
> (assoc-of-app)

The last form should result in a few pages of terminal output proving the
associativity of app.  If it does, you (probably) have a working Nqthm and can
now try any of the commands described in the reference guide chapter of the
documentation.

You may find it convenient to save a binary image of Nqthm-1992.  This may be
done after the (load-nqthm) command.  The saving of an image is very dependent
upon the Lisp implementation being used, and may require many megabytes of
space.  Repeatedly loading the compiled code whenever one wants to use
Nqthm-1992 is sufficiently fast that one can comfortably get by without an
image.  But having a saved image is slightly more convenient and may provide an
economy under certain operating systems.

MCL Note: To use Nqthm under MCL 2.0, start by loading the file
mcl-nqthm-startup.lisp from the EVAL window.


	     FOR UNIX:  MAKING A SAVE IMAGE and TESTING VIA `make'

Nqthm-1992 is not tied to any particular operating system or Common Lisp
implementation.  However the creation of an executable Nqthm-1992 save image
and the running of certain tests has been automated for Unix and for certain
Lisp implementations.  Instead of following the preceding simple compiling and
loading commands, one can instead merely invoke `make' under some versions of
Unix and with some Lisps to do the compilation, save an executable Lisp image
named `nqthm-1992', and then test that image.  Issue the single command

   make LISP=xxx

where `xxx' is the command to run your Lisp.  `lisp' is used for `xxx' by
default.  This `make' works only for AKCL, Allegro, CMU, and Lucid Common
Lisps.  And it may only work on Sun Sparcs, for all we know about the
portability of Unix `makefile' code.  See the file makefile for further
details.  If this `make' command does not work for you, please use the simple
installation commands above.

If the foregoing `make' command succeeds, then a longer test of the file
examples/basic/proveall.events can be run with the command

   make small-test

If that succeeds, and if you can afford to consume perhaps several days of cpu
time and over a hundred megabytes of disk space, try

   make giant-test

        
				 SAVING SPACE

For those really pressed for space, we note that it is not necessary to fetch
the whole four megabyte `nqthm-1992.tar.Z' file in order to build Nqthm-1992.
That file includes not only the Nqthm-1992 sources but also many examples.  It
suffices, for building Nqthm-1992, via the instructions above, to fetch only
the *.lisp files, which take up less than 1.3 megabytes.  Example files may be
fetched individually, from the examples subdirectory and its subdirectories.


				    MANUAL

There is a comprehensive user's manual available, namely the book `A
Computational Logic Handbook', by Robert S. Boyer and J Strother Moore,
published by Academic Press, 1988.  ISBN 0-12-122952-1.  To order, call
Academic Press in the USA at (800) 321-5068, FAX: 1-800-874-6418, or write to
Academic Press Books, Customer Service Department, Orlando, FL 32887, USA.
(Currently, one copy costs $54.50.)

The 1988 edition of the book `A Computational Logic Handbook' is out of date in
a few respects.  Therefore, in the file `doc/manual-update.ps' you will find
revised versions of chapters 3, 4, and 12, a completely new chapter 14 and a
completely new Appendix I.  The distribution of the revised chapters is
authorized by Academic Press.  For the details of this authorization, see the
file `doc/ap-copyright-permission.text'.  Change bars in the margins of the
revised chapters in `doc/manual-update.ps' indicate what has changed since the
1988 edition.  The file `doc/logic-reference.doc' contains a version of the
text for the revised chapters 4 and 12 in a plain text format.


				   PROBLEMS

The installation guide chapter in the file `doc/manual-update.ps' describe a
number of potential installation problems and how to work around them.

All Nqthm libraries, i.e., the .lib and .lisp files produced by calling
MAKE-LIB, that were produced with earlier versions of Nqthm are incompatible
with Nqthm-1992.  That is, one must replay old event files under Nqthm-1992 and
then remake the libraries.  Our apologies for this inconvenience, which was
necessitated for reasons of logical soundness.


				     HELP

To join the unmoderated nqthm-users mailing list, send a note to Internet
address nqthm-users-request@cli.com.  To send a message to all who receive
nqthm-users mail, send a message to nqthm-users@cli.com.


				   EXAMPLES

See the file examples/README for details on how to run Nqthm-1992 on many
examples.  These examples are described in Chapter 14 of the file
`doc/manual-update.ps'.

				    IMAGES

For information on executable binary images of Nqthm-1992 for a variety of
computers, please fetch the file /pub/nqthm/nqthm-1992-images/README.


    Bob Boyer                                J Moore
    boyer@cli.com                            moore@cli.com

    January, 1994
