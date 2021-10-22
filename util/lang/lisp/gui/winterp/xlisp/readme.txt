This file contains some of the information I have on Tom Almy's improved
release of David Betz's XLISP 2.1:

Roadmap of files: (note -- text stolen from Almy's readme.1st file):
	* ./sources (directory):
		Contains all the C source files as well as make*, *stuf.c
		and *.asm files needed for compiling on MSDOS and other PC's.
	* ./lsp (directory):
		Contains all the xlisp example programs and initialization
		files. Particularly important (and documented in the manual)
		are init.lsp, common.lsp, and classes.lsp.
		Also useful are Tom Almy's structure editor, repair.lsp,
		and the pretty printer pp.lsp.
	* ./doc (directory):
		Contains the ASCII and postscript documentation files. The
		ASCII version 'xlispdoc.txt' has underlines to highlight changes.
		'xlispdoc.text' is the same but with all ^H_ sequences deleted
		so you can read it with a text editor.
	* ./xlisp20.exe:
		MSDOS executable -- has all options enabled except JMAC
		(see sources/xlisp.h for details), compiled for any 80x86
		with a floating point coprocessor. It has been compressed
		with lzexe (decompression not necessary for execution).

Files added by me:
	* ./xlisp --> ./sources/xlisp:
		The hpux 7.0 s300 executable. Compiled with options
		ADDEDTAA, BETTERIO, PRINDEPTH, OBJPRNT, ENHFORMAT, JGC,
		COMMONLISP, STRUCTS, APPLYHOOK, SAVERESTORE
		(see for further info, see ./sources/xlisp.h).
	* ./xlisp-mode.el:
		Gnuemacs interface to xlisp subprocess. M-X load-file into gnuemacs.
		Then, M-X run-xlisp starts subprocess. Visit a *.lsp file, and use
		C-M-X (xlisp-send-defun) to send an expression to the interpreter
		interactively.
	* ./sources/README, ./sources/Makefile:
		Information on changes I made to compile under HPUX, as well
		as info on other files added in this directory.
	* ./doc/xlispdoc.text:
		Same as ./doc/xlispdoc.txt but the ^H_ sequences have been
	        removed so that you can read the file with an editor. To
		see find out about functionality in Almy's distribution,
		print out xlispdoc.txt and note the underlined sections.
	* ./sources/unixstuff.whedbee (directory):
		A version of sources/unixstuff.c that I couldn't get working
		properly (note that I didn't expend much effort trying).
		It supposedly allows you to use ^C, ^T, ^P, etc to access
		xlisp debugging/system features.

NOTE: I DO NOT SUPPORT THIS PACKAGE -- I AM PROVIDING IT AS A SERVICE TO
THOSE THAT WANT TO USE XLISP.  PLEASE DON'T SEND MAIL EXPECTING ME TO HELP
YOU OUT -- I MAY NOT BE ABLE TO ANSWER IN A TIMELY FASHION IF I AM BUSY.
THEREFORE, PLEASE DIRECT ALL QUESTIONS ABOUT XLISP TO NEWSGROUP
comp.lang.lisp.x !!

(Note, however, that I do support the WINTERP Motif application
construction and extension environment which is based on XLISP...  WINTERP
is available via anon ftp from hplnpm:pub/winterp-1.01.tar.Z).

-------------------------------------------------------------------------------
	    Niels Mayer -- hplabs!mayer -- mayer@hplabs.hp.com
		  Human-Computer Interaction Department
		       Hewlett-Packard Laboratories
			      Palo Alto, CA.
				   *

==============================================================================
Note: I obtained these sources from Tom Almy via MS-DOS floppy after seeing
the following message in comp.lang.lisp:
==============================================================================

From: toma@tekgvs.LABS.TEK.COM (Tom Almy)
Newsgroups: comp.lang.lisp
Subject: Re: Is there a cheap, decent PCLisp Out There?
Keywords: lisp, pc, ms, dos
Message-ID: <8294@tekgvs.LABS.TEK.COM>
Date: 19 Oct 90 21:19:07 GMT
References: <CCM.90Oct15153120@DARWIN.CRITTERS.CS.CMU.EDU> <9281@milton.u.washington.edu> <1990Oct17.224606.26480@cbnewsc.att.com> <463@caslon.cs.arizona.edu>
Reply-To: toma@tekgvs.LABS.TEK.COM (Tom Almy)
Organization: Tektronix, Inc., Beaverton,  OR.
Lines: 32

In article <463@caslon.cs.arizona.edu> shack@cs.arizona.edu (David Michael Shackelford) writes:
>In article <9281@milton.u.washington.edu>, efowler@milton.u.washington.edu (Eric Fowler) writes:
>> The subject line says it all-I need a (preferably)CommonLisp that will run 
>> on a PC. This is mostly for self-teaching of LISP at home, and need not be 
>> exotic.

>How about XLISP?  I think it's available on SIMTEL (maybe in its own directory)
>It's not necessarily 100% CommonLisp, but you can't beat the price anywhere!
>
>It should do the job, our programming languages class uses
>an XLISP dialect for the LISP section of the course.

I have an extensively modified XLISP 2.1 which has been molded more into
CL and fixes numerous bugs in the standard XLISP distribution. The extension
over the standard XLISP are obtained via compilation options.

Send a self-addressed, stamped mailer with a formatted high density floppy
to:

Tom Almy
17830 SW Shasta Trail
Tualatin, OR 97062

Atatch a note saying:
1. You want XLISP sources.
2. Any binaries you need (generic w/wo 80x87 and 80386 protected mode w. 80387
	available).
3. Documentation as PostScript file, ASCII text file, or WordPerfect 5.1 file.

Tom Almy
toma@tekgvs.labs.tek.com
Standard Disclaimers Apply

==============================================================================
Niels' comment: this info was in file mods.txt:
==============================================================================

	Modifications made to XLISP 2.0

	Tom Almy

All repairs and additions my own unless crediting name is given.

Bug fixes are permanently installed. Other changes by conditional compilation.


**********Bug fixes

STRCAT where aggregate size of argument strings is greater than 32k
causes crash (16 bit integer systems)

MAKE-ARRAY creates bogus array for sizes 32768-65535, and arrays of
size (mod size 65536) for larger sizes.  MAKE-ARRAY attempts to make
negative sized arrays! (16 bit integer systems)

The following functions treat their numeric count argument modulo 65536: 
	DOTIMES, AREF, and the AREF and NTH place forms of SETF.

"restore" corrupts system (argument stack not being reset, and modification
        to CVPTR is needed for 8086 systems)

Any attempt to do more than one RESTORE in a session causes the error
	"insufficient memory - segment".

Strings containing nulls cannot be read or printed.
(Note, strcat has the same problem, but I have a new version, the
 Common Lisp concatenate function, which will replace it.

NTH and NTHCDR fail for zero length (i.e. NIL) lists.

:DOWNCASE does not work with all compilers because of side effects in
   tolower() in some C libraries.

Unnamed streams never survive a garbage collection (Paul A.W. van Niekerk).

(format nil ...) does not protect the unnamed stream it creates, it will
   vanish during a GC. (Paul A. W. van Niekerk)

In XLISP 2.0, there seems to be a bug in (sort ... ...) due to some
	unprotected pointers in sortlist() and splitlist() in file xllist.c. 
	(Neal Holtz)

The functions SYMBOL-NAME, SYMBOL-VALUE, SYMBOL-PLIST, BOUNDP, and FBOUNDP
	fail with the symbol NIL as the argument. Corrected to return
	"NIL", nil, nil, t, and nil, respectively.

The function LAST returned the wrong value when its argment list ended with
	a dotted pair.

***********Functional Improvements (or minor bugs)

Uninterned symbols print with leading "#:".

Control and meta characters printed "raw" with prin1, now generate
appropriate escape sequences.

Can now declare character literals for control and meta characters, using
new escape sequences.( #\C-<char> for control characters, #\M-<char> for meta
characters (msb set), #\M-C-<char> for meta-control characters, #\rubout for
0x7f).

Double quotes are now escaped when printed (i.e., (print "\"") would print
as """).


Invalid symbols can no longer be created with intern and make-symbol (such as 
        symbol names containing control characters). Also, you can 
        no longer make NIL, which was highly irregular! You can't change the
	value of a constant (with set functions). Constants are T and keywords
	which always evaluate to themselves.

(UNTRACE) now untraces all functions.

The key "T", meaning "otherwise" in the CASE function, 
    used to be allowed at any position, when Common Lisp (and common 
    sense) dictates it should only be at the end.

Functions which take the :end keyword argument now allow NIL
	to mean "end of sequence" as in Common Lisp. Also 
	MAKE-STRING-INPUT-STREAM and SUBSEQ end arguments accept 
	NIL to mean "end of sequence".

(string <expr>) now makes a string from an integer as version 1.6 did, 
	and the manual suggests.

SUBST and SUBLIS perform minimum structure copying, as required by Common
Lisp.

EQUAL compares vectors element by element, as in Common Lisp, rather than just
checking for EQ.

Added command line option -w for "don't load xlisp.wks workspace".  If
xlisp.wks loaded at initialization time, init.lsp will not be loaded.

Added command line option -? to give usage message.

Code in *stuf.c changed so that xlisp runs with a "raw" terminal mode, 
break off, and buffering for faster display.  If *DOS-INPUT* is non-nil,
DOS is used to read input lines, which allows programs like CED to work, 
and better operation of xlisp in a Epsilon process window.  But the control
characters to special operations no longer work -- funtions must be called 
instead:

	^C	(top-level)
	^G	(clean-up)
	^P	(continue)
	^T	(room)
	^Z	at top level, (exit)

Improved formatting in FORMAT (Neal Holtz)

Lexical and functional environment of a call to DEFMETHOD is used during
the methods evaluation (Niels Mayer).

Functions with names starting with "STRING" will accept a symbol as the string
	argument, as in Common Lisp.

AREF will work on strings as well as arrays (Common Lisp compatibility).

SUBSEQ REVERSE REMOVE... DELETE... take sequence (CONS ARRAY or STRING)
	arguments rather than just list arguments.

REMOVE... and DELETE... accept :start and :end keyword arguments

CHAR-CODE changed to mask off "parity" bit, thus returning only code values
0-127. This means that (code-char (char-code x)) succeeds for all characters 
x.


APPEND and NCONC modified to give error messages for improper arguments, 
rather than just ignoring them.

***********New Functions

ASIN, ACOS, and ATAN of XLISP 2.1 added.

DEFSTRUCT (and structures) of XLISP 2.1 added. Code modified so that
keywords in structure printing and structure literals (i.e., #S() construct)
have leading colon and structure literals do not evaluate arguments. Also 
fixed bug that allowed referencing off end of structure if improper accessing 
function used. 

(It seems that these are the only differences between 2.0 and 2.1)

The system identifies itself as 2.1 if these functions are included in the
compile.

Reader macro #. evaluates following expression at read time.

STRCAT is eliminated (a macro is placed in init.lsp for backwards
compatibility).  The replacement function is CONCATENATE which will
concatenate sequences of any type(s) into a result sequence of any
type.  It is used: (CONCATENATE <type> <seq1> [<seq2> ...]) where 
type is the result type, one of CONS ARRAY or STRING.

*print-level* and *print-length* added.

A new function, which I call "GENERIC" was added.  This function takes one
argument and converts the argument to an equivalent internally structured
type that is more easily examined.  Types SYMBOL, OBJECT, and CLOSURE are
returned as ARRAY.  Type UNNAMED-STRING is returned as a CONS.  Types CONS
STRING, and ARRAY return copies of themselves.  Types FLONUM, FIXNUM, 
CHARACTER, and NIL return themselves.  Types SUBR, FSUBR, and FILE-STREAM
cause an error condition.

Objects have PNAME (print name) class instance variable, and Mikael 
Pettersson's :PRIN1 method for better display of objects.

Functions MODE MOVE DRAW and COLOR added for crude graphics.

Improved file functionality. OPEN function accepts :element-type keyword
(with values FIXNUM or CHARACTER) to allow binary files, :direction keyword
may have value :io.  Added Common Lisp functions FILE-LENGTH and 
FILE-POSITION.

Added Common Lisp functions: TIME ELT MAP POSITION-IF FIND-IF COUNT-IF
EVERY SOME NOTEVERY NOTANY NREVERSE SEARCH and COERCE.

APPLYHOOK now implemented, and *APPLYHOOK* now works as well.


***********Other Stuff

Definitions of strings internally changed to "char" from "unsigned char",
thus making C code look much cleaner. New macros getstringch and setstringch
added to fetch and store (unsigned) characters into a string. This also
made the code much more readable.

I'm trying to ANSI the definitions by adding function prototypes. It's not
perfect yet!

evfun() modified to reduce C stack usage in recursive functions.  The local
variable "name" replaced with "getname(fun)" where used; The call to xleval
was replaced with the contents of xleval. The local variable "type" in 
evform() was deleted since, although set, its value was never used.

Added improved garbage collection and performance enhancing macros of Johnny
Greenblatt.

The values for ADEPTH and EDEPTH changed to more reasonable values
(1000 and 650 respectively with a 16k stack). Befor the change, the processor
stack would overflow first, causing a crash.  These values are compiler
dependent, unfortunately.

The recursion flag (rflag) argument for xlread was deleted since it is no
longer used.  In xlread.c, the macro functions obtain but never use the macro
character "mch".  This local variable is now deleted.

All refereces to os?getc and os?putc changed to fgetc and fputc.  When
appropriate, fread or fwrite have been substituted for improved performance.

Compilation options put in for all extensions.

No documentation for function 'send-super', which exists instead of the 
two conflicting techniques in the documentation "A message can also be sent...
but the method lookup starts with the object's superclass" and the message
:SENDSUPER.  The instance variables for objects of class CLASS are not
described.

Documentation revised to match changes, and expanded where not clear.


Some extern declarations added to get past linting of ANSI compilers.
Added makefiles for Zortech C (Datalight C), Metaware High C 386, and
Microway NDP C-386 compilers. Some additional asm source files exist for the
two 386 compilers.
