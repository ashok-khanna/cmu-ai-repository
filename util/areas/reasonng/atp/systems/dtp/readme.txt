_______________________________________________________________________________
INTRODUCTION

Welcome to the Don Theorem Prover (DTP), version 2.4

DTP is an inference engine for first-order predicate calculus, and it
specializes in domain-independent control of reasoning.

Please send comments to Don Geddis at
	Geddis@CS.Stanford.EDU
or
	Computer Science Department
	Stanford University
	Stanford, California 94305
_______________________________________________________________________________
IMPLEMENTATION

The code was developed under
	Franz Allegro CL 4.2.beta.0 (on a Sun Sparc)
and is written in Common Lisp with some CLtL2 extensions (e.g. the LOOP macro).

Earlier versions were tested under
	Lucid HP Common Lisp Rev. A.04.01 (on an HP-9000 Series 300/400)
	MCL 2.0p2 (on an Apple Macintosh)
although the latest version has not been.
_______________________________________________________________________________
AVAILABILITY

DTP is available on the World Wide Web (WWW) from
	http://meta.stanford.edu/FTP/dtp/
or by anonymous FTP from
	meta.stanford.edu:/pub/dtp/
with the files
	dtp.tar.Z	Common Lisp (CLtL2) source code
	logic.tar.Z	Logic puzzle examples
	manual.ps	Documentation
Unfortunately, the documentation is out of date by some number of versions.
Most of the functionality is shown in the examples in the logical theories,
which are exercised by running the function (test-dtp).  Other new functions
of interest include (settings), to examine the state of the theorem prover
options, and (show <object>), which takes a proof object or answer object
and generates a postscript graph of the space using AT&T's program "dot".

Also of interest may be some technical papers, available as
	http://meta.stanford.edu/FTP/papers/	[WWW]
	meta.stanford.edu:/pub/papers/		[FTP]
including
	overview.ps	An overview of first-order inference
	caching.ps	Subgoal caching in first-order inference
	complete.ps	Completeness of caching in first-order inference
_______________________________________________________________________________
VERSION

Version history:
	1.0	Resolution-based inference system
	2.0	Subgoaling inference system
	2.1	Corrected reduction inference combined with caching
	2.2	Depth limits and iteration (broken)
	2.3	Reduction check at conjunct instead of subgoal
	2.4	General "view" tool on proofs and answers

Note: This is an alpha release, pending the resolution of current theoretical
questions about completeness of postponement caching.
_______________________________________________________________________________
