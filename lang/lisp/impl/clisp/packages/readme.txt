This directory contains application packages for CLISP.

The .orig files contain the original distribution from beta.xerom.com.
The .clisp files contain the sources, modified to run on CLISP.
I am not distributing memory images of these. You can compile it yourself,
just by typing "make" in the corresponding directory.


PCL is an implementation of a large subset of CLOS.
From the CLISP version 1993-09-01 on, CLISP has a native CLOS. You do not
need PCL any more (except if you want to program at the meta-object protocol
level).


CLX is an interface to the X window system. (Unix version of CLISP only.)


Garnet is a Lisp-based graphical user interface.


MCS is an object system for Common Lisp which emphasizes the use of
metaclasses.


SERIES is Richard C. Waters' Series package, as described in the appendix
of CLtL2. series-diffs contains the diffs from the original distribution to
this distribution.


Screamer is an extension for nondeterministic programming.


-------------------------------------------------------------------------------
From the comp.lang.lisp FAQ:

   PCL -- parcftp.xerox.com:pcl/ [13.1.64.94]
   Portable Common Loops (PCL) is a portable implementation of
   the Common Lisp Object System (CLOS). A miniature CLOS
   implementation called Closette is available pcl/mop/closette.lisp.

   MCS (Meta Class System) -- ftp.gmd.de:/lang/lisp/mcs/ [129.26.8.90]
   Portable object-oriented extension to Common Lisp. Integrates the
   functionality of CLOS (the Common Lisp Object System), and TELOS, (the
   object system of LeLisp Version 16 and EuLisp).  MCS provides a metaobject
   protocol which the user can specialize. Runs in any valid Common Lisp.
   Contact: Harry Bretthauer and Juergen Kopp, German National Research
   Center for Computer Science (GMD), AI Research Division,
   P.O. Box 1316, D-5205 Sankt Augustin 1, FRG, email: juergen.kopp@gmd.de

   CLUE (Common Lisp User-Interface Environment) is from TI, and extends CLX
   to provide a simple, object-oriented toolkit (like Xt) library that uses
   CLOS. Provides basic window classes, some stream I/O facilities, and a few
   other utilities. Still pretty low level (it's a toolkit, not widget
   library).  Available free by anonymous ftp from csc.ti.com:pub/clue.tar.Z
   Written by Kerry Kimbrough. Send bug reports to clue-bugs@dsg.csc.ti.com.

   CLIO (Common Lisp Interactive Objects) is a GUI from the people who created
   CLUE. It provides a set of CLOS classes that represent the standard
   components of an object-oriented user interface -- such as text, menus,
   buttons, scroller, and dialogs.  It is included as part of the CLUE
   distribution, along with some packages that use it, both sample and real.

   XIT (X User Interface Toolkit) is an object-oriented user interface
   toolkit for the X Window System based on Common Lisp, CLOS, CLX, and
   CLUE. It has been developed by the Research Group DRUID at the
   Department of Computer Science of the University of Stuttgart as a
   framework for Common Lisp/CLOS applications with graphical user
   interfaces for the X Window System.  The work is based on the USIT
   system developed by the Research Group INFORM at the University of
   Stuttgart. Although the system kernel is quite stable, XIT is still
   under active development. XIT can be obtained free by anonymous ftp
   from ifi.informatik.uni-stuttgart.de (129.69.211.1) in the directory
   /pub/xit/.

   Garnet is a large and flexible GUI. Lots of high-level features.  Does
   *not* depend on CLOS, but does depend on CLX. Garnet (version 2.0 and
   after) is now in the public domain, and has no licensing restrictions,
   so it is available to all foreign sites and for commercial uses.
   Detailed instructions for obtaining it by anonymous ftp are available
   by anonymous ftp from a.gp.cs.cmu.edu [128.2.242.7] as the file
   /usr/garnet/garnet/README.  Garnet includes the Lapidiary interactive
   design tool, C32 constraint editor, spreadsheet object, Gilt
   Interface Builder, automatic display management, two 
   widget sets (Motif look-and-feel and Garnet look-and-feel), support for
   gesture recognition, and automatic constraint maintenance, application
   data layout and PostScript generation. Runs in virtually any Common
   Lisp environment, including Allegro, Lucid, CMU, and Harlequin Common
   Lisps on Sun, DEC, HP, Apollo, IBM 6000, and many other machines.
   Garnet helps implement highly-interactive, graphical, direct
   manipulation programs for X/11 in Common Lisp.  Typical applications
   include: drawing programs similar to Macintosh MacDraw, user interfaces
   for expert systems and other AI applications, box and arrow diagram
   editors, graphical programming languages, game user interfaces,
   simulation and process monitoring programs, user interface construction
   tools, CAD/CAM programs, etc. Contact Brad Myers (bam@a.gp.cs.cmu.edu)
   for more information. Bug reports and administrative questions:
   garnet@cs.cmu.edu. Garnet is discussed on the newsgroup comp.windows.garnet.

   Screamer is an extension of Common Lisp that adds support for
   nondeterministic programming.  Screamer consists of two levels.  The
   basic nondeterministic level adds support for backtracking and
   undoable side effects.  On top of this nondeterministic substrate,
   Screamer provides a comprehensive constraint programming language in
   which one can formulate and solve mixed systems of numeric and
   symbolic constraints.  Together, these two levels augment Common Lisp
   with practically all of the functionality of both Prolog and
   constraint logic programming languages such as CHiP and CLP(R).
   Furthermore, Screamer is fully integrated with Common Lisp.
   Screamer is available by anonymous FTP from ftp.ai.mit.edu as the file
   /pub/screamer.tar.Z. Contact Jeffrey Mark Siskind <qobi@ai.mit.edu> for
   further information.

