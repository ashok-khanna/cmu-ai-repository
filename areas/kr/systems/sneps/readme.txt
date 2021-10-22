-*- Mode:Text -*-

WHAT IS SNePS ?
===============
SNePS is the Semantic Network Processing System. Its first version was
designed by Stuart C. Shapiro in the early seventies, and it has been
developed since by Shapiro et al. (see the `bibliography.ps' file in the
distribution for a list of SNePS related publications). SNePS is the
implementation of a fully intensional theory of propositional knowledge
representation and reasoning.

Here is a short summary of the major features and components of the current
version of SNePS (aka SNePS-2.1):

  + A module for creating and accessing propositional semantic networks
  + Path-based inference
  + Node-based inference based on SWM (a relevance logic with quantification)
    that uses natural deduction and can deal with recursive rules
  + forward, backward and bi-directional inference
  + Nonstandard logical connectives and quantifiers
  + An assumption based TMS for belief revision
  + A morphological analyzer and a generalized ATN (GATN) parser for parsing
    and generating natural language
  + SNePSLOG, a predicate-logic-style interface to SNePS
  + XGinseng, an X-based graphics interface for displaying, creating and
    editing SNePS networks
  + SNACTor, a preliminary version of the SNePS Acting component
  + SNIP 2.2, a new implementation of the SNePS Inference Package that uses
    rule shadowing and knowledge migration to speed up inference.

SNIP 2.2 is one of the results of Joongmin Choi's dissertation [1]. As of now
it is not fully merged with the main SNePS release, but it should be merged
soon to become the primary inference engine for SNePS.

Another upcoming development is the implementation of SNeRE (the SNePS
Rational Engine) which is one of the main results of Deepak Kumar's
dissertation about the integration of inference and acting [2]. It will
replace the current implementation of SNACTor.


LICENSING INFORMATION:
======================
Since June 1993 SNePS is free software; you may redistribute it and/or modify
it under the terms of the GNU General Public License as published by the Free
Software Foundation; either version 2, or (at your option) any later version.


MAILING LIST:
=============
If you use SNePS please send a short message to `shapiro@cs.buffalo.edu' and
`snwiz@cs.buffalo.edu' indicating that. Please also let us know whether you
want to be put on the SNUG (SNePS Users Group) mailing list. Notices about new
releases and other SNePS related information will be communicated on that
list.


SYSTEM REQUIREMENTS:
====================
COMMON-LISP: SNePS without the optional graphics stuff is written entirely in
Common-Lisp (as defined in Guy Steele's CLtL-I), hence, every proper
implementation of CLtL-I should be sufficient to run SNePS - in theory.
In practice, SNePS runs successfully in the following Common-Lisp
implementations (these Lisps are actually available to me for testing of the
current SNePS release):

  + Allegro CL 4.1      (on Sun SPARCs, SunOS 4.1.3)
  + Sun/Lucid CL 4.0    (on Sun SPARCs, SunOS 4.1.3)
  + TI Common-Lisp      (on TI-Explorers I/II, Rel.6.1)
  + CLISP May-93        (on Sun SPARCs, SunOS 4.1.3)
  + CMU Common-Lisp 17b (on Sun SPARCs, SunOS 4.1.3)

Previous versions of SNePS ran successfully (or were reported to run) in the
following Common-Lisp implementations, hence, there is a significant chance
that the current version will run too (or will require only minor
modifications to make it run): 

  + Symbolics CL         (on a 3620, Genera 7.2 or 8.0)
  + AKCL 1.600 and higher
  + VAX Common-Lisp
  + Allegro CL running on a Macintosh

Look at part 4 of the Lisp FAQ available via anonymous ftp from
`pit-manager.mit.edu' in directory `/pub/usenet/news.answers/lisp-faq' to find
out from where you can obtain free Common-Lisp implementations such as CLISP,
CMU Common-Lisp or AKCL.

OPERATING SYSTEM: Apart from the Lisp machines, all hardware platforms
available to me run some flavor of Unix, but there is no requirement to that
extent - again, in theory. SNePS uses an implementation of logical pathnames
(see below) that hides the underlying operating system pretty well (so far it
only supports Unix, VMS, Symbolics and Explorers, but extensions for DOS
(attractive with the advent of CLISP) or even Macs shouldn't be too hard to
write). The only requirement is the availability of a hierarchical file
system (lenience with regard to filename length will also help).

DISK SPACE: You will need about 10 Megabytes of disk space to install SNePS.
Once you have completed the installation you might be able to trim this to
about 5 Meg by compressing/deleting Lisp source files and/or documentation.
Here's a rough breakdown on what takes up how much space:

  + Complete distribution:  5.8 Meg
  + Documentation:          2.2 Meg  (included in the distribution)
  + Compiled files:         3.5 Meg  (for Allegro-CL 4.1)

GRAPHICS: An optional X-based graphics interface called XGinseng is now
available. XGinseng was written by Martin Zaidel and extended by John Lewocz.
It is built on top of the Garnet Toolkit developed at CMU.  Garnet is now in
the public domain and can be retrieved via anonymous ftp. For instructions on
how to get Garnet read the file `GARNET' in the `Doc' directory. The current
version of XGinseng is only tested with Garnet 2.1. It should also work with
the new Garnet 2.2 - in theory.


GETTING SNePS - FTP INSTRUCTIONS:
=================================
To retrieve SNePS via anonymous FTP connect to `ftp.cs.buffalo.edu'
(128.205.32.9), login as user `anonymous' and supply your e-mail address as a
password. Then cd to the directory `/pub/sneps', change the transmission mode
to binary and retrieve the file `rel-x-yyy.tar.Z' (fill in the correct `x-yyy'
according to the directory listing). The `README' file and the bibliography
and manual files are all part of the distribution, they are just there
separately so you can get a hold of them without unpacking the complete
distribution. See the following script for more details (done on a UNIX host):

> ftp ftp.cs.buffalo.edu

  FILL IN THE SCRIPT

>

Sorry, you can only retrieve SNePS via FTP, we do not have the manpower to
make tapes.


GENERAL RELEASE INFORMATION:
============================
The tar file you retrieved contains SNePS in its latest release. Details about
how SNePS can be used are contained in the corresponding manual.  SNePS is
written entirely in Common-Lisp, except for graphics packages such as Ginseng
and XGinseng.  The non-Common-Lisp packages are loaded conditionally,
depending on whether a particular Lisp implementation supports them or not.

The `Doc' directory contains LaTeX sources of the SNePS manual, and a
bibliography of Sneps related papers. DVI and Postscript versions of these
documents are also available.

The `demo' directory tree contains files with various applications of SNePS.
If you type `(demo)' at the SNePS top level you get a menu of available and
working demos. The demos are supplied to give the novice SNePS user a flavor
of how SNePS code can be written. The extensions of the demo file names
correspond to the type of SNePS code of the demo, e.g., `.sneps' means that
this demo contains SNePS code written in SNePSUL, `.snlog' means that this is
a SNePSLOG demo.  Note that not all demos in the `demo' directory work with
the current release of SNePS (only the ones that are shown in the menu
mentioned above are save choices).


RESTORING THE SNePS SOURCES
===========================
Create a directory in which the SNePS installation is supposed to go (you will
need about 10 Meg of free disk space, see the section on system requirements
above), and copy the tar file into that directory.  Then do (assuming the
release is named `relXX.tar.Z' and a Un*x operating system):

   zcat relXX.tar.Z | tar xvf -

or

   uncompress relXX.tar.Z
   tar xvf relXX.tar

This will install all the SNePS sources with the appropriate directory
structure. Under a non-Unix operating system you will probably need
different commands to unpack the tar file.


INSTALLING, COMPILING AND LOADING OF SNEPS:
===========================================
After you have successfully created the SNePS directory tree on your machine
either follow the quick installation guide in the file `load-sneps.lisp' at
the top level of the SNePS directory tree, or do the following:

Edit the value of the variable `*sneps-directory*' in the file
`load-sneps.lisp' such that it corresponds to the root pathname of the
directory into which SNePS has been copied. Use pathname syntax appropriate
for your machine or operating system.  Do not add a final directory delimiter
(e.g., a slash in Unix or a semicolon on Explorers).  If the Garnet Toolkit is
available on your machine and you want to use XGinseng also edit the value of
the variable `*sneps-garnet-directory*' so that it points to the directory in
which Garnet is installed. If your Garnet installation differs from ours it
might be necessary to add some translations to `*sneps-garnet-translations*'
to map the logical pathnames used in the file
`sneps:xginseng;load-xginseng.lisp' onto the correct physical pathnames.

All Lisp source files in this distribution have extension `.lisp'. If your
Common-Lisp uses a different extension by default you might want to rename all
files accordingly. Renaming is not mandatory, however, if you do choose to
rename the files you have to edit the value of the variable
`*sneps-lisp-extension*' to reflect that change.

Start up Common-Lisp and load the file `load-sneps.lisp'. You will be asked
whether you want to compile the system or just load it.  The first time you do
this select option `e' which will compile and load the whole system plus all
optional systems.

Once you have a compiled version of SNePS you can simply load it by loading
`load-sneps.lisp' and selecting option `a'. If you do not want any interaction
when you load SNePS you can change the value of `*sneps-noquery*' to T.  If
you do not want all the loading messages change the value of `*sneps-verbose*'
to NIL (all these variables are defined in `load-sneps.lisp', see that file
for more customization options).

After the system has been loaded successfully, just type `(sneps)' to start
interaction with SNePS. Type (lisp) to exit it. Type `(snepslog)' to start
SNePSLOG, type `lisp' to exit it.

To check whether your system works properly type `(demo)' at the SNePS prompt
(or `demo' at the SNEPSLOG prompt) and try the various demos. Here are some
approximate run times for the "Schubert's steamroller" SNePSLOG demo on
various Lisps and machines. These times are meant to give you a rough idea
whether your SNePS installation works efficiently or whether you spend 90% of
your time garbage collecting. All times are CPU times in seconds taken from
the value printed after the execution of a SNePS/LOG command. They were
achieved without any compiler optimization, i.e., just normal development mode
was used (where available):

                 SPARC-10/51(50MHz,64Meg) Sun-4/330(25MHz,64Meg) TI Explorer-II
Allegro CL 4.1           35 sec                   96 sec
Sun/Lucid CL 4.0.1       27 sec                   87 sec
Clisp                   110 sec
TI Explorer CL                                                       152
CMU CL                  173 sec (88)             554 sec (303)

The evaluator of CMU Common-Lisp seems to be very slow, hence, the parsing of
the Steamroller formulas which is done by an ATN parser that uses `eval' a
lot is very slow. The times in parentheses are the run times of the inference
alone without the parsing of the problem definition.


SNIP 2.2 and SNACTor:
=====================
Even though SNIP 2.2 (Joongmin Choi's new implementation of the SNePS
inference package [1]) is not yet fully merged with the main SNePS release, a
set of files defining it will be loaded automatically to overload the old
version of SNIP. If you do not want to use SNIP 2.2 edit the definition of the
variable `*sneps-load-snip22*' in `load-sneps.lisp' such that it has value
NIL.

A preliminary version of SNACTor (the SNePS Actor) can be loaded after SNePS
has been loaded by doing `(load "sneps:snactor")' (this is done automatically
by the various demos that use it). Future versions of SNePS will completely
integrate inference and acting with SNeRE [2] (the SNePS Rational Engine).


Logical Pathnames
=================
SNePS comes with a logical pathname package written by Mark Kantrowitz at CMU.
It currently supports Unix, TI-Explorer, Symbolics and VAX/VMS pathname
syntax. The package is a Common-Lisp portable implementation of logical
pathnames. It fulfills most of the X3J13 June 1989 specification for logical
pathnames, as documented in Guy Steele's "Common Lisp: The Language" (2nd
Edition), section 23.1.5 "Logical Pathnames".

Logical pathnames make SNePS almost completely independent of the particular
file system and location it is installed in. Only the directory variables
mentioned above have to be set to the appropriate pathnames.  For the machines
and operating systems mentioned above, and for popular Common-Lisps such as
Allegro-CL, Lucid(Sun)-CL, AKCL, CLISP, CMU-CL everything should work fine.
If you use some other Common-Lisp that uses special filename extensions for
Lisp or binary files, you might have to edit the values of the variables
`*sneps-lisp-extension*', `*sneps-default-lisp-extension*' or
`*sneps-binary-extension*' in `load-sneps.lisp' (see their documentation for
more details).

The only places where actual physical pathnames are used are the translation
definitions of the logical hosts `sneps', `sneps-p' and `garnet'. Throughout
the system only logical pathnames are used to compile or load files. Once the
logical pathnames package is loaded logical pathnames can be used in all lisp
functions that use filenames as arguments, such as `load', `compile', `open',
`close', etc., but also SNePS functions such as `demo', `atnin' and so on.
Look at the translations for the logical host `sneps' to learn about various
logical pathnames that refer to important files. For example, to load the
SNACTor system all you have to do is `(load "sneps:snactor")'.

As a last resort if you cannot get the logical pathname system to work at all,
you can replace all logical with physical pathnames (most of them reside in
the system definition file `system.lisp').


Known bugs, problems, caveats, restrictions:
============================================
- XGinseng is only tested with Garnet 2.1, the new Garnet 2.2 should work but
  you never know until you actually try it.
- XGinseng does not work properly with CMU Common-Lisp
- SNePSLOG does not work in Symbolics-CL (Genera-7.2)
- Some of the operators available in SNePS-79 are not yet implemented, e.g.,
  the NON-DERIVABLE operator. Not yet implemented features are pointed out as
  such in the manual.
- Parts of the SNePS code are very ugly (to put it mildly), other parts are
  pretty clean. Keep in mind that this software has evolved over almost 20
  years now, from Franzlisp to Common-Lisp under the hands of many students
  (many of whom learned Common-Lisp while they developed/translated code).
- The SNePS prompt is the same as the CMU Common-Lisp prompt (we had it
  first :-). 


Development history:
====================
The current version of SNePS was mainly developed on a TI-Explorer 
under release 4.1 and release 6. Patches for release 1.0 were developed
under release 6.0, but also on various other Common-Lisp implementations
such as Allegro-CL (3.1.4 Sun 4), Sun(Lucid)-CL (3.0.0 Sun 4) and
Symbolics-CL (Genera 7.2). Since November 1990 the main development machines
are SPARC stations running Sun(Lucid)-CL 4.0 and Allegro-CL 4.1.


Consulting and Maintenance:
===========================
If you have any problems installing SNePS or find any bugs please send
e-mail to `snwiz@cs.buffalo.edu'. If you have to make adjustments to the
SNePS source to install it under your particular Common-Lisp installation
please report them to the above address so future users can also profit from
your adaptations.  Any other suggestions for improvements are also welcome.


Good luck,

Hans Chalupsky <hans@cs.buffalo.edu>

Department of Computer Science, 226 Bell Hall
State University of New York at Buffalo
Buffalo, NY 14260 USA


References:
===========
[1] Joongmin Choi: "Experience-Based Learning in Deductive Reasoning Systems",
    Ph.D. Thesis, Technical Report #93-20, Department of Computer Science,
    State University of New York at Buffalo, 1993

[2] Deepak Kumar: ""From Beliefs and Goals to Intentions and Actions -- An
    Amalgamated Model of Acting and Inference",  Ph.D. Thesis, Department of
    Computer Science, State University of New York at Buffalo, 1993
