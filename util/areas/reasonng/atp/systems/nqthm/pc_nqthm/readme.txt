IMPORTANT!!  This system is loaded on top of Boyer and Moore's
``Nqthm-1992'' theorem prover.  You will need to obtain that system
before installing this one.  THE REST OF THIS FILE ASSUMES THAT YOU
HAVE ALREADY INSTALLED THAT SYSTEM.  Note also that this particular
system is *not* compatible with their earlier Nqthm releases (in
particular, the 1987 release), though at the time of this writing
there also exists such a version.

The rest of this file is analogous to the README file that comes with
the Boyer-Moore ``Nqthm-1992'' theorem prover.

This is the file README-pc for the directory /pub/pc-nqthm/pc-nqthm-1992/ on
Internet host ftp.cli.com.  The string ``pc'' stands for ``proof-checker,'' and
is used because this ``Pc-Nqthm-1992'' system is an interactive enhancement of
Boyer and Moore's theorem prover, Nqthm-1992.  It contains other additional
features as well, notably an implementation of first-order quantification.


                               LICENSE INVOLVED

Copying and use of Pc-Nqthm-1992 is authorized to those who have read and
agreed with the terms in the "Pc-Nqthm-1992 GENERAL PUBLIC SOFTWARE LICENSE,"
which may be found at the beginning of the Pc-Nqthm-1992 file "basis-pc.lisp"
and also in the files "pc-nqthm-public-software-license.doc" and
"pc-nqthm-public-software-license.ps".

NOTE:  The "misc/" subdirectory contains various Nqthm-1992 enhancements and
tools, as described in the README file in that directory.  Although these are
all covered by the license agreement, they are not part of what we refer to as
the ``Pc-Nqthm-1992 system,'' and in fact they may change at any time without
notice.

                            OBTAINING PC-NQTHM-1992

One may obtain Pc-Nqthm-1992 by tape or ftp.  We prefer that you obtain it by
ftp, and there is no charge if you obtain it by ftp; we charge for tapes.  For
further information on obtaining Pc-Nqthm by ftp, skip to the section NON-UNIX
FTP or UNIX FTP below.  For information on obtaining Pc-Nqthm-1992 on tape,
write to Software-Request, Computational Logic Inc., 1717 West Sixth, Suite
290, Austin, TX 78703-4776, USA; email: Software-Request@cli.com.  FAX: +1 512
322 0656.

If you have a tape sent by Computational Logic, it was made with the command:

    % tar cvf /dev/rmt8 pc-nqthm-1992

which produced an industry standard 6400 bpi tar tape.  To read the tape, mount
it and execute the command:

    % tar xvf /dev/rmt8

assuming that /dev/rmt8 is the name of your tape drive.  This command will copy
all the files on the tape into a "pc-nqthm-1992" subdirectory of the directory
to which you are currently connected.  Now proceed to the "COMPILE" instruction
of this README file.


                                 NON-UNIX FTP

To obtain Pc-Nqthm-1992 by ftp, connect to ftp.cli.com with the login name
`anonymous' and your email address as the password.  If you are not running a
Unix or variant system, then ftp all of the files on the
/pub/pc-nqthm/pc-nqthm-1992/ directory and its sub- and subsub-directories,
except "pc-nqthm-1992.tar.Z", and then go to the "COMPILE" instruction of this
README file.  Because there are many files and subdirectories, making sure that
you have gotten all of the files in this way can be tedious!  So even if you
are not running Unix, you may be well advised to try to get the files using
some variant of the directions for UNIX FTP below.

     
                                   UNIX FTP

To obtain Pc-Nqthm-1992 by ftp, connect to ftp.cli.com with the login name
`anonymous' and your email address as the password.  If you are running a Unix
or Unix variant, then `cd' to /pub/pc-nqthm/pc-nqthm-1992 and `get' the single
file pc-nqthm-1992.tar.Z.  Be sure to use binary mode, e.g., execute the ftp
command `binary' before doing the `get'.  Checksum information for
pc-nqthm-1992.tar.Z may be found in the file SUM which you may obtain with
another `get'; after you have obtained pc-nqthm-1992.tar.Z, executing `sum
pc-nqthm-1992.tar.Z' should produce the same results as are found in the file
SUM.  See the file make.pc-nqthm-1992.tar for information on how
pc-nqthm-1992.tar.Z and SUM are created.

The next step is to:

                                  UNCOMPRESS

% uncompress pc-nqthm-1992.tar.Z


                                     UNTAR

% tar xvf pc-nqthm-1992.tar

This "tar" command will create a subdirectory pc-nqthm-1992 that contains the
sources and examples.  This will take up a number of megabytes.  You may now
delete the file pc-nqthm-1992.tar to save space.

                                    COMPILE

% cd pc-nqthm-1992
% nqthm-1992  ;or whatever command starts up your Nqthm-1992.
> (load "pc-nqthm.lisp")
> (proclaim '(optimize (speed 3) (safety 0) (space 0)))
> (compile-pc-nqthm)
> (bye)  ; however you get out, if you can.

If you encounter problems at this stage, please consult the file
"doc/manual-update.ps" in your nqthm-1992 directory (not in the current
directory).  That file describes many sorts of environmental problems you may
be encountering and some work arounds.

Finally, a comment from the Nqthm README file:  To use Nqthm under CMU Lisp
16e, use (SPACE 1) in the optimize proclamation to avoid a compiler bug.


                                     LOAD

% nqthm-1992  ; or however you start up Nqthm-1992
> (load "pc-nqthm.lisp")
> (load-pc-nqthm)

This will result in loading in this system, including execution of the
command (boot-strap nqthm).  If for some reason you prefer starting
with (boot-strap thm), replace (load-pc-nqthm) by (load-pc-nqthm thm).

You may find it convenient to save a binary image of Nqthm-1992.  This may be
done after the (load-nqthm) command.  The saving of an image is very dependent
upon the Lisp implementation being used, and may require many megabytes of
space.  Repeatedly loading the compiled code whenever one wants to use
Nqthm-1992 is sufficiently fast that one can comfortably get by without an
image.  But having a saved image is slightly more convenient and may provide an
economy under certain operating systems.


          FOR UNIX:  MAKING A SAVE IMAGE and TESTING VIA `make'

Pc-Nqthm-1992 is not tied to any particular operating system or Common Lisp
implementation.  However the creation of an executable Pc-Nqthm-1992 save image
and the running of certain tests has been automated for Unix and for certain
Lisp implementations.  Instead of following the preceding simple compiling and
loading commands, one can instead merely invoke `make' under some versions of
Unix and with some Lisps to do the compilation, save an executable Lisp image
named `pc-nqthm-1992', and then test that image.  Issue the single command

   make NQTHM=xxx

where `xxx' is the command to run your Nqthm-1992.  `nqthm-1992' is used for
`xxx' by default.  This `make' works only for AKCL, Allegro, CMU and Lucid
Common Lisps.  And it may only work on Sun Sparcs, for all we know about about
the portability of Unix `makefile' code.  See the file makefile for further
details.  If this `make' command does not work for you, please use the simple
installation commands above.

If the foregoing `make' command succeeds, then a somewhat longer test (of one
of the event files, ./examples/defn-sk/csb.events), can be run with the command

   make small-test


If that succeeds and you can afford to consume perhaps several days of cpu time
(in particular, well over one day on an unloaded Sparc 2) and over 100 hundred
megabytes of disk space, try

   make giant-test


                                 SAVING SPACE

For those really pressed for space, we note that it is not necessary to fetch
the file `pc-nqthm-1992.tar.Z' file in order to build Pc-Nqthm-1992.  That file
includes not only the Pc-Nqthm-1992 sources but also many examples.  It
suffices, for building Pc-Nqthm-1992, via the instructions above, to fetch only
the *.lisp files.  Example files may be fetched individually, from the examples
subdirectory and its subdirectories.


                                 DOCUMENTATION

The documentation for this system consists of the following technical
reports, available upon request from Computational Logic, Inc. at the
address

    Computational Logic, Inc., Suite 290
    1717 W. 6th St.
    Austin, Texas 78703-4776

Also, there is an on-line help facility, as discussed in the first
report listed below.

Technical Report 19:  The primary manual.  It may well suffice to look
at the first 11 pages of this report, and nothing else.

Technical Report 42:  An update, including ``free variables'' useful
especially when dealing with quantifiers and in certain rewriting
situations.

``An Extension of the Boyer-Moore Theorem Prover to Support
First-Order Quantification,'' J. Automated Reasoning 9 (December 1992)
pp. 355-372.  (Supersedes CLI Technical Report 43.)
    

                                   PROBLEMS

The installation guide chapter in the Nqthm-1992 file `doc/manual-update.ps'
describes a number of potential installation problems and how to work around
them.

All Nqthm and Pc-Nqthm libraries, i.e., the .lib and .lisp files produced by
calling MAKE-LIB, that were produced with earlier versions of Nqthm and
Pc-Nqthm are incompatible with Pc-Nqthm-1992 (and Nqthm-1992).  That is, one
must replay old event files under Nqthm-1992 or Pc-Nqthm-1992 and then remake
the libraries.  Our apologies for this inconvenience, which was necessitated
for reasons of logical soundness.


                                     HELP

To join the unmoderated nqthm-users mailing list, send a note to Internet
address nqthm-users-request@cli.com.  To send a message to all who receive
nqthm-users mail, send a message to nqthm-users@cli.com.


                                   EXAMPLES

See the file pc-nqthm-1992/examples/README for details on how to produce over
100 megabytes of proofs.  These examples are described CLI Technical Report 75,
available upon request from the address shown above.


				    IMAGES

For information on executable binary images of Pc-Nqthm-1992, please fetch the
file /pub/pc-nqthm/pc-nqthm-1992-images/README.


                                     NOTE

The Pc-Nqthm-1992 system is an ``interactive enhancement'' of the
Boyer-Moore theorem prover, Nqthm-1992.  All modifications of
functions and variables in the Boyer-Moore Theorem Prover appear in
the source files "nqthm-patches.lisp" and "top-nqthm.lisp".  In
particular, the PROVE-LEMMA and DEFN events have been modified to
support an interactive capability, and a DEFN-SK event has been added
support first-order quantification.


Matt Kaufmann
kaufmann@cli.com
