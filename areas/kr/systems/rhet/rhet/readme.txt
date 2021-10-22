-*- Mode: Text; Vsp: 1 -*-

This file was last updated on 11/16/93

DIRECTORY CONTENTS: The RHET Knowledge Representation system.

This directory contains the latest and greatest Rhet distribution in a
tarred, compressed (by gzip) version (look for Rhet-version-tar.z). 

******
PLEASE: If you download any part of this distribution, please let
us know who you are. Send email to peg@cs.rochester.edu indicating
who will be responsible for Rhet at your site.

We maintain two Rhet discussion lists.

Rhet@cs.rochester.edu: General discussion about Rhet, enhancement
announcements, etc.

Bug-Rhet@cs.rochester.edu: for bug reports and patch
announcements.

You may supply peg@cs.rochester.edu with email addresses to be
added to either or both of these lists. Note that message traffic
never goes to both lists, so you should be on both if you want the
maximum information. Alternatively send mail to Rhet-Request or Bug-Rhet-Request.
Note that Rhet is currently piped into bug-rhet.


*******
Late breaking news:

New discussion lists for the Rhet rewrite (now in progress) called Shocker:

Shocker@cs.rochester.edu (send email to shocker-request to get on).

This is also gated into

Bug-Shocker@cs.rochester.edu (send email to bug-shocker-request to get on). 

shocker.ps.z in this directory is a postscript version of a very rough draft 
of what will eventually become the tutorial. It is based on Rhet's tutorial 
document. Mainly, it is intended to provide an idea of where the language 
specification stands at this point (or at least as of the date of the draft). I
expect to update and correct it roughly quarterly, further announcements will 
be made to the shocker mailing list, above.

***********
DOWNLOADING:

Use anonymous ftp to ftp.cs.rochester.edu

cd /pub/knowledge-tools/
get cl-lib-#.tar.z
get rhet-#.tar.z

(if tempos is desired)
get timelogic-#.tar.z
get tempos-#.tar.z

(if rprs is desired)
get rprs-#.tar.z

where # in the above is replaced by the version number you desire. The
README file in this directory discusses version compatibility. Usually you
will want the latest versions.

If there are other files in this directory, feel free to grab them as well. 
It's possible that this readme file is out of date in that respect.

*************
DOCUMENTATION:

There are several relevant TRs available. The list is periodically
updated. Send mail to peg@cs.rochester.edu for a recent list.

Many of these are available on this ftp server in pub/papers/ai so you 
might look there first!

***************
RELATED SYSTEMS:

To get the most out of Rhet, you should also grab a copy of
TIMELOGIC, TEMPOS and RPRS.


*************
OTHER FORMATS:

We can supply all systems on various forms of tape if needed;
contect peg@cs.rochester.edu for details.


******************
SYSTEM DESCRIPTION:

See TR 326 for a complete detailed description. In brief:

NAME/VERSION: RHET 20.0
PRESENT STATUS: Experimental (Released / Supported RESEARCH software)
[COST]:		$150. (free via FTP)
CONTACT:	Peg Meeker (peg@cs.rochester.edu) 
		Computer Science Department
		University of Rochester
		Rochester, NY 14627
(Technical):	Brad Miller (miller@cs.rochester.edu)
AVAILABILITY:   Noncommercial; Sources included plus relevant TRs (if you get 
		the tape). Also included:
		TIMELOGIC, TEMPOS (time reasoning subsystem)
		RPRS (Plan Recognition / System Demo)
                Commerical licences available with negotiation.
Supplied on:    Tar format cart tape or
                Tar format 8mm or
		FTP to ftp.cs.rochester.edu, (see below)
[INTENDED USERS]: AI Programmers / researchers in KR / NL / planning.
[DOMAIN/CATEGORY(IES)]: General KR research; NL; Planning and Plan Recognition
REPRESENTATION FORMALISMS: 
.	Frames with CONTEXTUAL equality, arbitrary constraints between
	roles.
.	BC / FC Horn Clauses extended with E-Unification and contextual
	capabilities.  
.	Constraints on (typed) variables.  
BASE LANGUAGE: Common Lisp
OS/HARDWARE: Symbolics Genera 8.1.1; Allegro 4.1 (with or without clim 1.1), Allegro 4.2beta w/clim 2.0
[SYSTEM INTERFACES]: Bidirectional to Common-Lisp
[USER INTERFACES]: Symbolics style window interface, and lisp functions.
The system now supports window interface for Symbolics. Allegro 4.1
also provide X-window interface under CLIM package. To create an interface
in X under Allegro: 

;after loading Rhet
user: :pa rwin
rwin: (rhetwin)

Be warned that the binaries for Symbolics are not
(and will not be) up-to-date, and need recompiled or patches loaded.

[SHORT DESCRIPTION]: This is a Knowledge Representation
system based on concepts proved with HORNE, and follow James Allen's grand
design for KR following his publications (in particular, see his book with
Pelavin and Kautz).  It includes 2 major modes for representing knowledge
(as Horn Clauses or as frames), which are interchangable; a type subsystem
for typed and type restricted objects (including variables); E-unification;
negation; forward and backward chaining; complete proofs (prove, disprove,
find the KB inconsistent, or claim a goal is neither provable nor
disprovable); contextual reasoning; truth maintenance; intelligent
backtracking; full LISP compatibility (can call or be called by lisp);
upward compatible with HORNE; Allen & Koomen's TEMPOS time interval
reasoning subsystem; frames have KL-1 type features, plus arbitrary
predicate restrictions on slots within a frame as well as default values for
slots; separate subsystem providing user-interface facilities and ZMACS
interface on the lispms.
[EFFICIENCY]:   e-unification is very fast, though adding new equalities
		(contextually) isn't.
		If all you want is PROLOG, a decent PROLOG compiler will be about
		1000x faster than (interpreted) RHET. However, you should be able to
                write most prolog programs in Rhet directly; those than confuse function
                terms with predicates will be harder to port.
[APPLICATIONS]: 
                Rhet has been used as the programming
		language basis of several local thesis, and is currently in
		use offsite as a general KR systm. Plan Recognition system (RPRS)
                is sent with RHET as a sample application. The NL and Planning
                reasoners for the TRAINS project (see
                separate TR series here) are currently based on Rhet/Tempos.
[FURTHER DEVELOPMENTS]: Son of Rhet (Shocker) is currently under development. It will
                include:
		Generalization of the context trees to DAGs allowing a more complex
		view of Beliefs (and other modal operators) to be implemented.
		Stronger typing of functions vs predicates allowing greater
		efficiency in dealing with (typed) terms.
		Goal Caching
                Full Meta language (e.g. you can write axioms that rewrite axioms,
                or your own reasoner in Shocker).
                axiom compiler
                semi-intelligent backtracking
                ability to take advantage of parallel shared memory processors (e.g.
                on Sun Sparcstation-10s).
[RELATED WORK]: HORNE / PROLOG / KL1 
[REFERENCES]: 
@techreport{Rhet:prog-notes,
	Author = "Miller, Bradford W.",
	Title = "Rhet Programmer's Guide",
	Institution = URCS,
	Number = "363",
        Note = "Originally TR 239",
	Month = Dec,
	Year = 1990}

@techreport{Rhet:tut,
	Author = "Allen, James F. and Miller, Bradford W.",
	Title = "The Rhet System: A Sequence of Self-Guided Tutorials",
	Institution = URCS,
	Number = "325",
	Month = Jul,
	Year = 1991}

@techreport{Rhet:ref,
	Author = "Miller, Bradford W.",
	Title = "The Rhetorical Knowledge Representation System Reference Manual",
	Institution = URCS,
	Number = "326",
	Month = ??,
	Year = 1991}

@techreport{RPRS,
	Author = "Miller, Bradford W.",
	Title = "The RHET Plan Recognition System",
	Institution = URCS,
	Number = 298,
	Month = Jan,
	Year = 1990}

@techreport{timelogic,
	Author = "Koomen, Johannes A.G.M.",
	Title = "The TIMELOGIC Temporal Reasoning System",
	Institution = URCS,
	Number = "231 (revised)",
	Month = Oct,
	Year = 1988}

@phdthesis{recurrence,
	Author = "Koomen, Johannes A.G.M.",
	Title = "Reasoning About Recurrence",
	Institution = URCS,
	School = "University of Rochester",
	Month = Jul,
	Note = "Also TR 307",
	Year = 1989}
	

**********
DISCLAIMER:

See the file copyright.text in this directory.

