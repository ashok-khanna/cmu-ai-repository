To: winterp@hplnpm.hpl.hp.com,
    OSF/Motif source licencee mailing List <motif-talk@osf.org>
Subject: Announcing WINTERP 1.13 [MIT X11r5 contrib tape release]
Organization: Hewlett-Packard Labs, Software & Systems Lab, Palo Alto, CA.
X-Mailer: mh6.7
Date: Mon, 07 Oct 91 22:48:52 -0700
From: "Niels P. Mayer" <mayer@hplnpm.hpl.hp.com>


WINTERP 1.13 will soon find it's way to the MIT X consortium X11r5 contrib tape
(under contrib/Motif/clients). You may also pick WINTERP up via anonymous ftp
from export.lcs.mit.edu, directory contrib/winterp; file winterp-1.13.tar.Z.
(HPites, use hplnpm.hpl.hp.com, directory pub, file winterp-1.13.tar.Z

The following message details
	(1) (briefly) what's new in 1.13
	(2) blurb on WINTERP, how to get it by ftp or e-mail
	(3) what's to be expected in the upcoming 1.14 -- this is the version
	  that is mostly ready now, but I decided to hold off on releasing
	  due to some last-minute bugs (now fixed) and lack of time to test on 
	  other platforms (Sun, DEC).

==============================================================================
(1) WINTERP Version 1.13 -- X11r5 tape release
==============================================================================

WINTERP 1.13 is just a patch release over WINTERP 1.12 (see below):

	* Fixed SYSTEM // xlisp/unixstuff.c:Prim_SYSTEM
	  so that return value is a low-valued integer, same as returned
	  to shell.

	* Added TIMEOUT_ACTIVE_P // w_timeouts.c:Wto_Prim_TIMEOUT_ACTIVE_P
	  (Added to docs too)

	* Added GET_MOUSE_LOCATION // w_utils.c:Wut_Prim_GET_MOUSE_LOCATION
	  used by uunet!cimshop!rhess's menu server package.
	  (Added to docs too)

	* Fixed w_XmString.c:Get_String_or_XmString_Arg_Returning_XmString()
	  to print out correct error message if wrong type argument supplied
	  to function/method needing xmstring/string argument.

	* Fixed incorrect message name typo for XM_TEXT_FIELD_WIDGET_CLASS
	  method :SET_HIGHLIGHT, which was preventing :SET_CALLBACK
	  from working correctly on XM_TEXT_FIELD_WIDGET_CLASS.

	* Various other random fixes.

	* Added new demo programs, fixed and cleaned up existing ones, e.g:

		* grep-br.lsp: grep-based file search browser
			-- for Motif 1.1, new and improved search
			   browser functionality.

		* w_ctrlpnl.lsp: control panel, program editor for WINTERP.
			-- fixed problem with problems arising from
			   Motif1.1/X11r4 recursive event loop bug.
			   Unfortunately the fix requires that your
			   WINTERP be running an eval-server, and that
			   'wl' is on your path... See doc/BUGS for the
			   full story.

		* man-br.lsp: simple manual page browser.
			-- Browse 'cat' manual pages in a particular
			   directory. (I use this to browse Motif 'cat' 
			   manpages while programming Motif in WINTERP).

	* new entries in contrib directory:

		* WINTERP-based menu server package:
		  "The menu server allows the user to create menu's in a
		  "menu cache" and then pop them up when needed by calling
		  the  WINTERP menu server with the menu's "key".  This
		  allows for the creation of a collection of re-usable menus
		  for such things as command menus in GNU emacs or menu
		  driven shell scripts. Any menu in the server can be
		  accessed thru either the GNU or Perl interface (you just
		  need to know the menu's "key")."
		  (Courtesy of Richard Hess, cimshop!rhess@uunet.uu.net)

		* GNU Emacs extension providing automatic name completion
		  on WINTERP/Motif names, automatic lookup in WINTERP
		  documentation. Better handling of winterp.doc using
		  Emacs' "Thinktank-like" outline and rolodex mode.
		  (Courtesy of Bob Weiner, rsw@cs.brown.edu)

		* Patches for compiling on Sun 3/60, SunOS 3.5,
		  OSF/Motif 1.1. Didn't integrate this patch because 
		  I don't expect anybody to be using SunOS 3.5.
		  (Courtesy of Richard Hess, cimshop!rhess@uunet.uu.net)

		* Patches to replace BSD Inet/Unix domain server with
		  SysVish TLI -- for Sequent's DYNIX/ptx 1.2.0.
		  (Courtesy of Dave Wolfe, wolfe@sybase.com).

		* Patches to GNU Emacs interface to WINTERP:
		  added winterp-send-area, winterp-send-region;
	          modified  winterp-send-buffer, and winterp-send-defun.
		  (Courtesy of Dave Wolfe, wolfe@sybase.com).

		  winterp-eval-last-sexp, winterp-eval.
		  (Courtesy of Bob Weiner, rsw@cs.brown.edu)

		  winterp-send-region
		  (Courtesy of Stephen Gildea, gildea@alexander.bbn.com)


==============================================================================
Subject: Announcing WINTERP release 1.12 (for Motif 1.1 and 1.1.1)
==============================================================================

WINTERP 1.12 is a minor patch release over WINTERP 1.11 -- it corrects a
few simple source bugs that appeared when porting to non-HP platforms. This
release should work on most hardware and software platforms. WINTERP 1.12
has been tested on the following platforms:
        * HP9000s3xx (68030/68040) running HPUX 7.0, HPUX 6.5.
        * HP9000s8xx (HP's PA-RISC) running HPUX 7.0, HPUX 3.1.
        * HP9000s7xx (HP's PA-RISC 1.1) running HPUX 8.0
        * Sun Sparc 2 running SunOS Release 4.1.1
        * Data General AViiON (m88k, DG/UX 4.30, GNU C 1.37.23)
        * DECStation 3100 running Ultrix.
	* SGI 4D ("MIPS, SGI Unix, latest release (Cypress)")
	* Convex C220, ConvexOS 9.1

I've received reports that previous versions of WINTERP have run on the
following:
        * IBM RS6000 AIX 3.1
        * Sun 3 running SunOS 4.0.3
        * MIPS (Mips RS2030)
        * Intel System Vr3.2 v2.2 (using Intel X11R3 with Intel Motif v1.0.A and TWG/TCP v3.1)
        * Apollo's 680xx machines.

Release 1.11 and 1.12 feature (briefly):
        * Support for most of the new functionality of Motif 1.1 and 1.1.1
        * Support for some of the new functionality of X11r4
        * Source is #ifdef'd to automatically compile with Motif 1.1/1.1.1
          or 1.0.
        * Lots of new & nifty example and test programs.
        * Various bug fixes and code cleanup.
        * Added a number of missing Motif resources, methods, etc.
        * Better portability -- I've tried to accomodate all the
                patches and changes people have suggested in order to
                allow WINTERP to compile on a variety of machines.
        * Imakefiles corrected and updated to X11r4.
        * Makefile.generic, Makefile.hpux, Makefile.sparc -- a generic
          makefile system for those that don't want to bother with Imake.
        * The TCP/IP eval server is now a compilation option, a Unix Domain
          socket is used by default. This means that running WINTERP is 
          no longer a security hole. The TCP/IP server seemed to be a 
          big portability problem -- hopefully the Unix Domain socket
          version will be more portable.
        * TCP/IP and Unix Domain Socket servers can be enabled/disabled
          via X resources. Verbosity of evaluation messages output can also
          be reduced via X resource options. These options are useful for
          people building stand-alone applications on top of WINTERP. 
        * Entering XLISP break-loop on Xlib errors, XtWarnings, and
          XtErrors is optional. This allows applications delivered in 
          WINTERP to behave more like normal Xtoolkit programs. 
        * More and Better documentation.
        * Various emacs-lisp functionality added in "contrib" directory,
          courtesy of Bob Weiner of Brown University. (I Haven't had time
          to integrate or test this software yet).
        * etc, etc, etc.

Note that I've mainly tested WINTERP 1.12 on HPUX 7.0 running on HP9000s3xx
(Motif 1.0, Motif 1.1, Motif 1.1.1, and HP UEDK Motif 1.1); I've done a
little bit of testing on an HP9000s8xx machine, but only with Motif 1.0.
I've also briefly tested on an HP9000s7xx (Snakes series) machine running
HPUX 8.0 and HP UEDK Motif 1.1. I've also tested it on a Sun Sparc 2
running SunOS Release 4.1.1 and Motif 1.1.1. 

I've received reports from Victor Kan (Data General Corporation) that this
version of WINTERP compiles and seems to run ok on a Data General AViiON
(m88k, DG/UX 4.30, GNU C 1.37.23).

==============================================================================
	(2) blurb on WINTERP, how to get it by ftp or e-mail
==============================================================================

WINTERP: An object-oriented rapid prototyping, development and delivery
environment for building user-customizable applications with the OSF/Motif
UI Toolkit.

------------------------------------------------------------------------------

WINTERP is a Widget INTERPreter, an application development environment
enabling rapid prototyping of graphical user-interfaces (GUI) through the
interactive programmatic manipulation of user interface objects and their
attached actions. The interpreter, based on David Betz's XLISP, provides an
interface to the X11 toolkit Intrinsics (Xtk), the OSF/Motif widget set,
primitives for collecting data from UN*X processes, and facilities for
interacting with other UN*X processes. WINTERP thus supports rapid
prototyping of GUI-based applications by allowing the user to interactively
change both the UI appearance and application functionality. These features
make WINTERP a good tool for learning and experimenting with the
capabilities of the OSF/Motif UI toolkit, allowing UI designers to more
easily play "what if" games with different interface styles.

WINTERP is also an excellent platform for delivering extensible or
customizable applications. By embedding a small, efficient language
interpreter with UI primitives within the delivered application, users and
system integrators can tailor the static and dynamic layout of the UI,
UI-to-application dialogue, and application functionality. WINTERP's use of
a real programming language for customization allows WINTERP-based
applications to be much more flexible than applications using customization
schemes provided by the X resource database or OSF/Motif's UIL (user
interface language).

An environment similar to WINTERP's already exists in the Gnu-Emacs text
editor -- WINTERP was strongly influenced by Gnu-Emacs' successful design.
In Gnu-Emacs, a mini-Lisp interpreter is used to extend the editor to
provide text-browser style interfaces to a number of UN*X applications
(e.g. e-mail user agents, directory browsers, debuggers, etc). Whereas
Emacs-Lisp enables the creation of new applications by tying together
C-implemented primitives operating on text-buffer UI objects, WINTERP-Lisp
ties together operations on graphical UI objects implemented by the Motif
widgets. Both achieve a high degree of customizability that is common for
systems implemented in Lisp, while still attaining the speed of execution
and (relatively) small size associated with C-implemented applications.

Other features:
	* WINTERP is free software -- available via anonymous ftp from
	  export.lcs.mit.edu.
	* Portable -- runs without porting on many Unix systems.	
	* Interface to gnuemacs' lisp-mode allows code to be developed
	  and tested without leaving the editor;
	* Built-in RPC mechanism for inter-application communications;
	* XLISP provides a simple Smalltalk-like object system.
	* OSF/Motif widgets are real XLISP objects -- widgets can be
	  specialized via subclassing, methods added or altered, etc.
	* Automatic storage management of Motif/Xt/X data.
	* Contains facilities for "direct manipulation" of UI components;

You may obtain the latest released version of the WINTERP source,
documentation, and examples via anonymous ftp from internet host
export.lcs.mit.edu (18.30.0.238): in directory contrib/winterp you will
find the compress(1)'d tar(1) file winterp-???.tar.Z. (??? represents the
version number). Slides, papers and further documentation can be found in
directory contrib/winterp/papers.

If you do not have Internet access you may request the source code to be
mailed to you by sending a message to winterp-source%hplnpm@hplabs.hp.com
or hplabs!hplnpm!winterp-source.

There is also a mailing list for WINTERP-related announcements and
discussions. To get added to the list, send mail to
winterp-request%hplnpm@hplabs.hp.com or hplabs!hplnpm!winterp-request.

For discussions about XLISP, see the USENET newsgroup comp.lang.lisp.x.

-------------------------------------------------------------------------------

                        --------------------

Here's how to ftp WINTERP 1.13: (your input denoted by ^^^^^^^^^^)

hplnpm-17-/tmp> ftp export.lcs.mit.edu  (HPites, use hplnpm.hpl.hp.com)
                ^^^^^^^^^^^^^^^^^^^^^^
        [...]
Name (hplnpm.hpl.hp.com:mayer): anonymous
                                ^^^^^^^^^
Password (hplnpm.hpl.hp.com:anonymous): <anypassword you want here>
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^
331 Guest login ok, send ident as password.
230 Guest login ok, access restrictions apply.
ftp> cd contrib/winterp   (HPites should do "cd pub")
     ^^^^^^^^^^^^^^^^^^
200 CWD command okay.

ftp> type image
     ^^^^^^^^^^
200 Type set to I.

ftp> get winterp-1.13.tar.Z
     ^^^^^^^^^^^^^^^^^^^^^^
200 PORT command okay.
150 Opening data connection for winterp-1.13.tar.Z (15.255.176.225,3988) (1414493 bytes).
226 Transfer complete.
1414493 bytes received in 690.63 seconds (1.96 Kbytes/sec)

ftp> quit
     ^^^^
221 Goodbye.

hplnpm-18-/tmp> zcat winterp-1.13.tar.Z | tar xvf -
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        [... lengthy list of files from tar ...]

hplnpm-19-/tmp> rm winterp-1.13.tar.Z
                ^^^^^^^^^^^^^^^^^^^^^

   * For compilation tips, take a look at winterp-1.13/doc/COMPILING

   * For running hints, take a look at winterp-1.13/doc/RUNNING

   * For known (Motif 1.1 only) bugs, see winterp-1.13/doc/BUGS

   * For information on the examples, look at winterp-1.13/examples/README

   * For general information about WINTERP, see winterp-1.13/doc/winterp.doc

==============================================================================
(3) Description of upcoming version of WINTERP (1.14):
==============================================================================

At the time of this 1.13 WINTERP release, I actually have version 1.14 up
and running, but I haven't had enough time to test it extensively, nor have
I had time to find out whether it is portable or not.

Thus, I went ahead and released version 1.13, which is known to be portable
because it is directly derived from version 1.12, which seems to be
portable. I figured I'd be better off releasing something reliable and
portable for the X11r5 contrib tape.... Version 1.14 has many new features,
and an all-new XLISP, and therefore has great potential for trouble.

I plan to have version 1.14 available in a few weeks to a few months,
depending on how my schedule goes. Put yourself on the WINTERP mailing list
if you want to find out about the 1.14 release, or watch for an
announcement on comp.windows.x/comp.windows.x.motif.

			--------------------

Version 1.14 will include the following new features:

* Ability to communicate with interactive unix programs running as WINTERP
subprocesses -- allow easy GUI construction around existing Unix
applications. THis is partially implemented via an interface to Don Libes'
expect library. When combined with a higher-level interface to
XtAppAddInput(), the effect you get is very similar to the way gnuemacs
uses process-filter/process-sentinel to run asynchronous subprocesses.
This allows you to have widget displays which dynamically display the
output of a subprocess, while the rest of the UI is still "active" and able
to carry out it's intended actions.

* Trace and backtrace of 
	callbacks
	event handlers
	action procedures
	timeouts
	input callbacks

* Callbacks and event handlers can directly access instance
  variables of subclassed widgets.

* Resource to specify a load-path

* Callbacks (hooks) that fire upon a lisp error -- user can attach
arbitrary code in order to do things like pop up a dialog box warning of
error.

* All new improved version XLISP (xlisp 2.1c)
		-- faster, faster garbage collect, uses less memory
		-- closer to Common Lisp
		-- features conditionally compilable

For more info on xlisp 2.1c see below:

			--------------------

From: toma@sail.LABS.TEK.COM (Tom Almy)
Newsgroups: comp.lang.lisp.x
Subject: Enhanced XLISP differences
Date: 16 Aug 91 16:46:03 GMT
Reply-To: toma@sail.LABS.TEK.COM (Tom Almy)
Organization: Tektronix, Inc., Beaverton,  OR.

I have occasionally been asked about the differences between the
standard XLISP 2.1 and the version I have modified (which I am now
calling 2.1b). I have culled through my notes and produced the
following document of the changes made. I hope I found everything.

Tom Almy
toma@sail.labs.tek.com
Standard Disclaimers Apply


DIFFERENCES BETWEEN XLISP 2.1 AND XLISP 2.1b
*********************************************

In the following document, CL means "Common Lisp compatible to
the extent possible". CX means "now works with complex numbers". *
means "implemented in LISP rather than C". # means "implementation
moved from LISP to C".

**********************Bug fixes*********************************************

RESTORE did not work -- several bugs for 80x86 systems. Only one restore
	would work per session -- all systems.

:downcase for variable *printcase* did not work with some compilers.

Modifications to make the source acceptable to ANSI C compilers.

Values for ADEPTH and EDEPTH changed to more reasonable values -- before
this change the processor stack would overflow first, causing a crash.

On systems with 16 bit integers: STRCAT crashes when aggregate size of
argument strings were greater than 32k. MAKE-ARRAY crashes on too-large
arrays. DOTIMES, AREF, AREF and NTH place forms of SETF, 
MAKE-STRING-INPUT-STREAM  and GET-OUTPUT-STREAM-STRING treat numeric
argument modulo 65536. MAKE-STRING-INPUT-STREAM did not check for start>end.

Strings containing nulls could not be read or printed.

NTH and NTHCDR failed for zero length lists.

Unnamed streams did not survive garbage collections.

(format nil ...) did not protect from garbage collection the unnamed stream
it creates.

SORT did not protect some pointers from garbage collection.

SYMBOL-NAME SYMBOL-VALUE SYMBOL-PLIST BOUNDP and FBOUNDP failed with
symbol NIL as argument.

LAST returned wrong value when its argument list ended with a dotted pair.

*gc-hook* was not rebound to NIL during execution of gchook function, causing
potential infinite recursion and crash.

Executing RETURN from within a DOLIST or DOTIMES caused the environment to
be wrong.

When errors occured during loading, which were not caught, the file would
be left open.

EVAL and LOAD did not use global environment. EVALHOOK's default environment
was not global.

Invalid symbols (those containing control characters, for instance),
can no longer be created with intern and make-symbol.

The key T, meaning "otherwise" in the CASE function used to be allowed in
any position. Now it only means "otherwise" when used as the last case.

The lexical and functional environment of send of :answer (which defines
a new method) are now used during the method's evaluation, rather than
the global environment.

Signatures added for WKS files so that invalid ones will be rejected.

Checks added for file names and identifier names being too long.

Indexing code fixed to allow almost 64k long strings in 16 bit systems.
It is no longer possible to allocate arrays or strings that are too long
for the underlying system.

Circularity checks added to PRINT LAST BUTLAST LENGTH MEMBER and MAP 
functions. An error is produced for all but MEMBER, which will execute 
correctly.


*******************User interface changes***********************************

-w command line argument to specify alternate or no workspace.

-? command line argument gives usage message.

init.lsp not loaded if workspace loaded.

Search path can be provided for workspaces and .lsp files.

Standard input and output can be redirected.

Display writes are buffered.

Character literals available for all 256 values. CL

Uninterned symbols print with leading #:. CL

PRIN1 generates appropriate escape sequences for control and
meta characters in strings. CL

Read macro #. added. CL

Lisp code for nested backquote macros added. CL

Read macro #C added for complex numbers. CL

Semantics for #S read macro changed so that it can read in structures
written by PRINT. CL

*******************New/changed data types***********************************
NIL -- was treated as a special case, now just a normal symbol.
symbols -- value binding can optionally be constant or special.
complex numbers -- new type, can be integer or real.
character strings -- The ASCII NUL (code 0) is now a valid character.
objects -- objects of class Class have a new instance variable
	which is the print name of the class.
hash-table -- new type, close to CL
random-state -- new type, CL

Property list properties are no longer limited to just symbols CL

*******************New variables/constants**********************************

*apply-hook* Now activated
*displace-macros* Macros are replaced with their expansions when possible
*dos-input* MSDOS only, uses DOS interface to interact with user. Allows
	recall of earlier command(s).
*print-level* CL
*print-length* CL
*random-state* CL
*terminal-io* CL
internal-time-units-per-second CL
pi CL

*******************New functions********************************************

ACONS CL*
ACOSH CL*
ADJOIN CL
APPLYHOOK CL
ASINH CL*
ATANH CL*
BUTLAST CL
CEILING CL
CIS CL*
CLREOL (clear to end of line -- MS/DOS only)
CLRHASH CL
CLS (clear screen -- MS/DOS only)
COERCE CL
COLOR (graphics -- MS/DOS only)
COMPLEX CL
COMPLEXP CL
CONCATENATE CL
CONJUGATE CL
CONSTANTP CL
COPY-ALIST CL*
COPY-LIST CL*
COPY-TREE CL*
COSH CL*
COUNT-IF CL except no :from-end
DECF CL*
DEFCLASS * (define a new class)
DEFINST * (define a new instance)
DEFMETHOD * (define a new method)
DEFSETF CL*
DRAW (graphics -- MS/DOS only)
DRAWREL (graphics -- MS/DOS only)
ELT CL
EQUALP CL*
EVERY CL
FILE-LENGTH CL
FILE-POSITION CL
FILL CL*
FIND-IF CL except no :from-end
FLOOR CL
FRESH-LINE CL
FUNCTIONP CL*
GENERIC (implementation debugging function)
GET-INTERNAL-REAL-TIME CL
GET-INTERNAL-RUN-TIME CL
GETHASH CL
GOTO-XY (position cursor -- MS/DOS only)
HASH-TABLE-COUNT CL
IDENTITY CL*
IMAGPART CL
INCF CL*
INPUT-STREAM-P CL
INTERSECTION CL
LCM CL
LIST* CL
LOG CL
LOGTEST CL*
MAKE-HASK-TABLE CL
MAKE-RANDOM-STATE CL
MAP CL
MAPHASH CL
MODE (graphics -- MS/DOS only)
MOVE (graphics -- MS/DOS only)
MOVEREL (graphics -- MS/DOS only)
NINTERSECTION CL*
NOTANY CL
NOTEVERY CL
NREVERSE CL
NSET-DIFFERENCE CL*
NSET-EXCLUSIVE-OR CL*
NUNION CL*
OPEN-STREAM-P CL
OUTPUT-STREAM-P CL
PAIRLIS CL*
PHASE CL
POP CL*
POSITION-IF CL except no :from-end
PUSH CL*
PUSHNEW CL*
REALPART CL
REDUCE CL except no :from-end
REMHASH CL
REMOVE-DUPLICATES CL except no :from-end
REPLACE CL*
ROUND CL
SEARCH CL except no :from-end
SET-DIFFERENCE CL
SET-EXCLUSIVE-OR CL*
SETF Placeform ELT  CL
SETF Placeform GETHASH  CL
SETF Placeform SEND*	(set instance variable)
SIGNUM CL*
SINH CL*
SOME CL
SUBSETP CL
TANH CL*
TIME CL
TYPEP CL
UNINTERN CL*
UNION CL
WITH-INPUT-FROM-STRING CL*
WITH-OPEN-FILE CL*
WITH-OUTPUT-TO-STRING CL*
Y-OR-N-P CL*

	
******************Changed functions****************************************

&ALLOW-OTHER-KEYS CL (now functions, is no longer ignored)
* CL CX (with no arguments, returns 1)
+ CL CX (with no arguments, returns 0)
- CL CX
/ CX Almost CL (division of integers returns fp if no exact integer value)
1+ CL CX
1- CL CX
ABS CL CX
ACOS CL CX
ALLOC (new optional second argument)
APPLY CL (allows multiple arguments)
AREF CL (now works on strings)
ASIN CL CX
ASSOC CL (added :key)
ATAN CL CX (second argument now allowed)
CHAR-CODE CL (parity bit is stripped)
CLOSE CL (will close unnamed stream strings)
COS CL CX
DEFCONSTANT CL# (true constants)
DEFPARAMETER CL# (true special variables)
DEFVAR CL# (true special variables)
DELETE (added keywords :key :start :end. Works on arrays and strings)
DELETE-IF (added keywords :key :start :end. Works on arrays and strings)
DELETE-IF-NOT (added keywords :key :start :end. Works on arrays and strings)
EXP CL CX
EXPT CL CX
FORMAT (added directives ~D ~E ~F ~G ~& ~T ~\N and lowercase directives)
HASH (hashes everything, not just symbols or strings)
LOAD CL (uses path to find file)
LOGAND CL (with no arguments, returns -1)
LOGIOR CL (with no arguments, returns 0)
LOGXOR CL (with no arguments returns 0)
MAKE-STRING-INPUT-STREAM CL (:end NIL means end of string)
MAKUNBOUND #
MEMBER CL (added :key)
NSTRING-DOWNCASE CL (string argument can be symbol, :end NIL means end of 
	string)
NSTRING-UPCASE CL (string argument can be symbol, :end NIL means end of 
	string)
OPEN CL (many additional options, as in Common Lisp)
PEEK (fixnum sized location is fetched)
PEEK-CHAR CL (input stream NIL is *standard-input*, T is *terminal-io*)
POKE (fixnum sized location is stored)
PPRINT (output stream NIL is *standard-output*, T is *terminal-io*)
PRIN1 CL (output stream NIL is *standard-output*, T is *terminal-io*)
PRINC CL (output stream NIL is *standard-output*, T is *terminal-io*)
PRINT (output stream NIL is *standard-output*, T is *terminal-io*)
RANDOM CL (works with random-states)
READ (input stream NIL is *standard-input*, T is *terminal-io*)
READ-BYTE CL (input stream NIL is *standard-input*, T is *terminal-io*)
READ-CHAR CL (input stream NIL is *standard-input*, T is *terminal-io*)
READ-LINE CL (input stream NIL is *standard-input*, T is *terminal-io*)
REM CL (only two arguments now allowed, may be floating point)
REMOVE (added keywords :key :start :end. Works on arrays and strings)
REMOVE-IF (added keywords :key :start :end. Works on arrays and strings)
REMOVE-IF-NOT (added keywords :key :start :end. Works on arrays and strings)
RESTORE (uses path to find file, restores file streams)
REVERSE CL (works on arrays and strings)
SIN CL CX
SORT (added :key)
SQRT CL CX
STRCAT * (now a macro, use of CONCATENATE is recommended)
STRING-comparisonFunctions CL (string arguments can be symbols)
STRING-DOWNCASE CL (string argument can be symbol, :end NIL means end of 
	string)
STRING-LEFT-TRIM CL (string argument can be symbol)
STRING-RIGHT-TRIM CL (string argument can be symbol)
STRING-TRIM CL (string argument can be symbol)
STRING-UPCASE CL (string argument can be symbol, :end NIL means end of string)
SUBLIS CL (modified to do minimum copying)
SUBSEQ CL (works on arrays and lists)
SUBST CL (modified to do minimum copying)
TAN CL CX
TERPRI CL (output stream NIL is *standard-output*, T is *terminal-io*)
TRUNCATE CL (allows denominator argument)
TYPE-OF (returns HASH-TABLE for hashtables, COMPLEX for complex, and LIST for 
	NIL)
UNTRACE CL (with no arguments, untraces all functions)
WRITE-BYTE CL (output stream NIL is *standard-output*, T is *terminal-io*)
WRITE-CHAR CL (output stream NIL is *standard-output*, T is *terminal-io*)


****************New messages for class Object*******************************

	:prin1 <stream>
	:superclass *
	:ismemberof <cls> *
	:iskindof <cls> *
	:respondsto <selector> * 
	:storeon (returns form that will create a copy of the object) *

****************New messages for class Class********************************

	:superclass *
	:messages *
	:storeon (returns form that will recreate class and methods) *


-- 
Tom Almy
toma@sail.labs.tek.com
Standard Disclaimers Apply


------------------------------------------------------------------------------
------------------------------------------------------------------------------
-------------------------------------------------------------------------------
	    Niels Mayer -- hplabs!mayer -- mayer@hplabs.hp.com
		  Human-Computer Interaction Department
		       Hewlett-Packard Laboratories
			      Palo Alto, CA.
				   *
