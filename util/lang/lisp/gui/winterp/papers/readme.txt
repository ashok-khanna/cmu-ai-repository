This directory contains various documentation on WINTERP. All these files
are compressed. Run 'uncompress <filename>' to turn them into normal files.

-rw-rw-rw-  1 ftp          8804 Oct 30 17:49 RPC-Arch.PS.Z
-rw-rw-rw-  1 ftp         13306 Nov 16 16:08 XlispImpl.doc.Z
-rw-rw-rw-  1 ftp         10000 Oct 30 17:40 XlispOOP.doc.Z
-rw-rw-rw-  1 ftp        134945 Oct 30 17:41 XlispRef.doc.Z
-rw-rw-rw-  1 ftp          8687 Oct 30 17:49 arch.PS.Z
-rw-rw-rw-  1 ftp         78797 Oct 30 17:36 exug-90.PS.Z
-rw-rw-rw-  1 ftp         37788 Oct 30 17:36 exug-90.ms.Z
-rw-rw-rw-  1 ftp         76515 Oct 30 17:36 lisp-pointers.PS.Z
-rw-rw-rw-  1 ftp         35523 Oct 30 17:37 lisp-pointers.ms.Z
-rw-rw-rw-  1 ftp         63191 Oct 30 16:44 slides.PS.Z
-rw-rw-rw-  1 ftp         73919 Oct 30 17:42 winterp.doc.Z
-rw-rw-rw-  1 ftp         29808 Oct 30 17:42 xlisp.doc.Z
	
(1) exug-90.ms.Z exug-90.PS.Z:

These are the text to the WINTERP presentation given at the September 1990
European X Users Group (EXUG) First European X Conference, held in Surrey,
UK.  exug-90.ms can be processed via 'troff -ms ...'. exug-90.PS can be
sent to a postscript printer.

Note that the 'exug-90' paper is missing a few screen snapshots and
diagrams that were manually cut-n-pasted into the final paper. The screen
snapshots are not available here. The diagrams are arch.PS and
RPC-Arch.PS which can be printed on a postscript printer.

(2) lisp-pointers.ms.Z, lisp-pointers.PS.Z:

These are the text for an upcoming paper in the ACM SIGPLAN on Lisp, aka,
"Lisp Pointers". This paper is very similar to exug-90.ms with three main
differences: it is shorter, it doesn't introduce lisp syntax to the reader,
and it contains a more complex example program.

lisp-pointers.ms can be processed via 'troff -ms' although you may have to
change the file to produce more reasonable margins.  lisp-pointers.PS can
be sent to a postscript printer.

Note that the 'lisp-pointers' paper is missing two diagrams. The diagrams
are arch.PS and RPC-Arch.PS which can be printed on a postscript printer

(3) slides.PS.Z:

These are slides accompanying an hour-long introductory talk on WINTERP.
slides.PS can be sent directly to a postscript printer, but note that a few
screendumps are missing that could not be included in the postscript file.

(4) xlisp.doc.Z

xlisp.doc is a plain-text file that is included in the WINTERP
distribution.  This is David Betz's terse documentation on XLISP, along
with documentation for the additional Un*x functionality added by the
WINTERP distribution.

(5) winterp.doc.Z

winterp.doc is a plain-text file included in the WINTERP distribution. It
gives an overview of WINTERP and has detailed documentation on all the X
and Motif functionality of the system.

(6) XlispOOP.doc.Z:

This is Tim Mikkelsen's plain-text introduction to the object oriented
programming capabilities of the XLISP interpreter used by WINTERP.

(7) XlispRef.doc.Z:

This is Tim Mikkelsen's ~400pp plain-text reference guide on the XLISP
language used by WINTERP. The guide covers every function in the language,
and has examples of how to use each function. It does not cover the WINTERP
extensions to XLISP, which are best covered by winterp.doc and xlisp.doc.

(8) XlispImpl.doc.Z:

This is Jeff Prothero's plain-text overview of the XLISP C-Language
internals used by WINTERP. People wanting to add new primitives to
WINTERP/XlISP should read this as well as the source before proceeding.

-------------------------------------------------------------------------------
	    Niels Mayer -- hplabs!mayer -- mayer@hplabs.hp.com
		  Human-Computer Interaction Department
		       Hewlett-Packard Laboratories
			      Palo Alto, CA.
				   *
