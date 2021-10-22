The Ergo Support System (ESS) and
eLP (Ergo's implementation of lambda Prolog)
Version 0.15, 12 Feb 90

This file describes the latest (pre-)release of the Ergo Support System and
eLP, the Ergo project's implementation of lambda Prolog.  The system is
experimental and documentation sketchy.  Comment, questions, bug reports, etc.
are welcome.  When you retrieve the system, please print, fill out, and send
to the address below a copy of the non-restrictive license you will find in
the file LICENSE.  The software is distributed free of charge via anonymous
ftp.  If you send us a tape, we will write the system onto the tape and return
it to you, also free of charge.  Currently the Ergo Support System and eLP run
on Unix or Mach-based workstations and require Common Lisp.  With some
exceptions it has been tested on Sun3, Sun4, PMax, IBM RT, and MicroVax
Workstations.  It should run in Allegro Common Lisp, Sun Common Lisp (by
Lucid, Inc.), Kyoto Common Lisp, CMU Common Lisp and Ibuki Common Lisp, though
not all machine/CL implementation combinations have been tested.  The ESS and
eLP have come together through the efforts of many contributors, too numerous
to acknowledge them all here.  We would like to acknowledge, however, that eLP
was implemented primarily by Conal Elliott, with contributions by Frank
Pfenning and Dale Miller and example suites by Scott Dietzen, Amy Felty, and
John Hannan.  The lambda Prolog language itself was designed primarily by
Gopalan Nadathur and Dale Miller.

There are three mailing lists maintained related to this distribution.
  elp@cs.cmu.edu  -  a general discussion mailing list for issues
		     relating to lambda Prolog and eLP.  Announcements
		     about updates will also be mailed to this list.
  elp-request@cs.cmu.edu  -  for request concerning the eLP mailing list.
  elp-bugs@cs.cmu.edu  -  for bug reports concerning the ESS and eLP.

For paper requests and license form, please use
-------------------------------------
Frank Pfenning                       
School of Computer Science       
Carnegie Mellon University           
Pittsburgh, PA 15213-3890            
                                     
Telephone: (412) 268-6343            
InterNet: fp@cs.cmu.edu               
-------------------------------------

1. Retrieving the ESS and eLP.

Connect with anonymous ftp to alonzo.tip.cs.cmu.edu  [128.2.209.194]

Go to the ess directory with  cd /afs/cs/project/ergo/export/ess

Retrieve files *.tar.Z
 - remember to set the file type to "binary".
 - fixes may be found under fixN.tar.Z subdirectory.
   Only kclfix.tar.Z has not been integrated into the release
 - you only need to retrieve those systems components that
   you are interested in, but "ergolisp" is necessary for all the others.
   See a description below.
 - For a lambda Prolog with non-customizable parser you need:
     ergolisp.tar.Z, elp.tar.Z
   If you want to customize the parser with object-language features:
     sb.tar.Z

Uncompress, untar, and relocate the files with

  uncompress *.tar.Z

and, for each resulting <file>.tar file:

  tar -xf <file>.tar

Refer to the file INSTALL for further installation instructions.

2. System components.

The following system components are currently available:

 ergolisp    - the Ergo project's extensions to Common Lisp, including
	       some facilities for attributes and dealing with abstract
	       syntax trees. [many contributors]
  
 sb	     - the Ergo Parser/Unparser/Formatter generator.
	       [Scott Dietzen, Penny Anderson, Anne Rogers, Bill Chiles]

 ab	     - the Ergo Attribute Grammar facility.
	       [Rod Nord, Bill Maddox]

 elp	     - the Ergo implementation of lambda Prolog.  To customize
	       grammars you need the sb feature.
	       [Conal Elliott, Frank Pfenning, Dale Miller]

NOTE: the clx, display, and mellowcard features have not been tested outside
of CMU in this Version of the ESS.
 clx	     - Low-level Common Lisp/X11 interface.  This particular
	       piece of code was not written by the Ergo project, so
	       this version may not be the most up-to-date one.  The
	       most up-to-date version is available by anonymous ftp
	       from csc.ti.com. 
  
 display     - A higher-level Common Lisp/X interface.  This works with
	       X10 under Lucid and with X11 under Lucid and Allegro.  It
	       needs the clx and sb features.  This compiles by
	       default to support X11 only.  To support X10 or both
	       X10 and X11, see the file $ess/if/display/INSTALL.
	       [Tim Freeman]
  
 mellowcard  - A window-oriented documentation system for elp.  It
	       needs the clx and elp features.
	       [Tim Freeman]

"ergolisp" is needed by all other parts.  There is also a few additions to
gnu-emacs in order to facilitate interaction with eLP and Lisp in a shell
window.  This package is included in the "ergolisp" features.  The files
are in the gnu/ subdirectory.

ACKNOWLEDGMENT: The Ergo group is supported in part by the Office of Naval
Research under contract N00014-84-K-0415 and in part by the Defense Advanced
Research Projects Agency (DOD), ARPA Order No.  5404, monitored by the Office
of Naval Research under the same contract.
