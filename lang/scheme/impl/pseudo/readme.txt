-*- Mode: Text; -*-

Copyright (c) 1991-1994 Jonathan Rees / See file COPYING
1 Feb 1994

This is Pseudoscheme, developed by Jonathan Rees at the MIT AI Lab and
the Cornell Robotics and Vision Laboratory (jar@cs.cornell.edu).

Send mail to info-clscheme-request@mc.lcs.mit.edu to be put on a
mailing list for announcements.

The major change with version 2.10 is that it uses separate Scheme
READ and WRITE procedures not shared by Common Lisp.

----------

Here is some documentation.


INSTALLATION.

This version (version 2.10) of Pseudoscheme was developed using CMU
Common Lisp.  Earlier versions of Pseudoscheme have been tested in Sun
(Lucid) Common Lisp, Symbolics CL, VAX LISP under VMS, Explorer CL,
and a few other Common Lisps.  If you're installing Pseudoscheme in
some other version of Common Lisp, you may have to customize a few
things:
  - edit the definitions of SOURCE-FILE-TYPE and OBJECT-FILE-TYPE
    in "clever.lisp" as appropriate;
  - edit the definition of PREFERRED-CASE in "loadit.lisp" as appropriate
    for your file system;
  - rename file "clever.lisp" if necessary so that your Common Lisp's LOAD
    can find it given just the name "clever".
Please send your customizations to jar@cs.cornell.edu so that they
can be distributed to other users.


RUNNING PSEUDOSCHEME.

To load Pseudoscheme into a Common Lisp system, first load the file
"loadit.lisp", then do

    (load-pseudoscheme "<dir>")

where <dir> is the directory in which Pseudoscheme is located.  Under
Unix, <dir> should include a final /, e.g. "/u/gjs/pseudo/".  The
first time the system is loaded, it will compile itself.

Once the system is loaded, enter Scheme with

    (ps:scheme)

and leave Scheme with

    (quit)

(ps:scheme) and (quit) merely change the package and readtable, so
you can exit and re-enter as you wish.

The Scheme environment has definitions for everything that's in the
Revised^4 Report on the Algorithmic Language Scheme, although some
definitions are incomplete or approximate.  See under "limitations,"
below.

If you are using a Symbolics system, the first line of every Scheme source
file should be the following:

    ;-*- Mode: Scheme; Syntax: Scheme; Package: Scheme; -*-


EXTENSIONS.

The following nonstandard procedures are defined:

    quit              - leaves Scheme.
    compile-file      - compiles a file of Scheme code.  Arguments are as
			in Common Lisp's compile-file function.
    compile           - compiles one procedure, like Common Lisp's
			compile function.
    translate-file    - translates a file of Scheme code into Common Lisp.
			Output is written to a file with type ".pso"
			("Pseudoscheme output").  In general there's
			no need to use translate-file since
			compile-file will do the whole job in one step.
    pp                - prints something with
			  (let ((lisp:*print-pretty* t)) ...). 
    error             - signals an error.  Compatible with T, MIT Scheme,
		        and Common Lisp.
    benchmark-mode    - cause Revised^4 Scheme primitives to be
			inlined.  Analogous to (declare (usual-integrations))
			in MIT Scheme.

There are other useful features internally, notably a record package
and a rudimentary module system.  These are currently undocumented.

To (mostly) get compatibility with the Scheme dialect used in the book
Structure and Interpretation of Computer Programs, load file sicp.scm.


LIMITATIONS.

Tail recursion will work for ordinary loops written using LETREC,
internal DEFINE, and named LET; in other cases, however, you will have
true tail recursion only if the underlying Common Lisp supports it.

CALL-WITH-CURRENT-CONTINUATION is implemented using Common Lisp BLOCK
and is therefore not as general as in a true Scheme.

Arithmetic is Common Lisp's, not Scheme's, so the exact/inexact
distinction isn't implemented quite right.

Identifiers beginning with & may produce warnings or not work when
running under some Common Lisp implementations.  E.g. Lucid will say
"Error: (&FOO) is an ill-formed lambda-list" for (lambda (&foo) &foo).
[Fixed?]

Certain Common Lisp implementations represent some instances of the
Lisp FUNCTION type as conses; in this case, the PAIR? procedure may
return #T for some procedures.

The Common Lisp reader rejects the identifier "...".  In SYNTAX-RULES,
use "---" instead.
[Fixable by doing (defvar *use-scheme-read* t) before calling
LOAD-PSEUDOSCHEME.]

The WRITE procedure will generate incorrect output for compound data
(lists and vectors) containing #T, #F, and ().
[Fixable by doing (defvar *use-scheme-write* t) before calling
LOAD-PSEUDOSCHEME.]


INTERACTION BETWEEN SCHEME AND COMMON LISP.

You can generally call Common Lisp functions from Scheme programs by
using package prefixes, e.g.

    (define (openit)
      (lisp:open "foo.txt" :direction :output))

Most data types correspond closely: Scheme pairs are Lisp conses,
procedures are functions, ports are streams, etc.  The main difference
is that Scheme boolean false (#F) is different from Lisp boolean false
(NIL).  You should therefore beware of any use of booleans in calls
out to Common Lisp.  The functions PS:TRUE? and PS:TRUEP can be
used to handle coercions between the two: PS:TRUE? turns LISP:NIL
into #F, and PS:TRUEP turns #F into LISP:NIL.

Common Lisp special forms and macros may or may not work in Scheme
code, because of transformations performed by the translator.  Usually
a special form works if it has the syntax of a function call (as do
e.g. LISP:UNWIND-PROTECT and LISP:CATCH).  If you need to know, you
can see what the translator does by doing (LISP:MACROEXPAND
'<scheme-expression>).

You can do Common Lisp special binding from Scheme code using LET or
LAMBDA if the variable is not in the SCHEME package and is proclaimed
special, e.g.

    (let ((lisp:*print-level* 10)) ...)

While Scheme is running, *PACKAGE* is ordinarily bound to the SCHEME
package.


REBUILDING THE TRANSLATOR.

To rebuild the translator (.pso files) from sources (the .scm files),
follow the directions at the top of file bootit.scm.


BUG.

LETRECs like the following one don't compile properly.

  (letrec ((even?
	    (lambda (n) (if (zero? n) #t (odd? (- n 1)))))
	   (odd?
	    (lambda (n) (if (zero? n) #f (even? (- n 1))))))
    (even? 88))

The problem is that this translates into a Common Lisp PROG that binds
the variable N twice.  The translator needs to either coalesce the two
into a single variable, or generate two variables with distinct names.


NEW IN VERSION 2.10.

Version 2.10 adds a little bit of support for CMU Common Lisp.  Also,
the CLtL II support that was present in 2.9 has now been exercised a
bit, so I think Pseudoscheme might be compliant now.  That should be
good news for Mac CL as well.


NEW IN VERSION 2.9.

- Revised^5 Scheme features (see Lisp Pointers, July--Sept 1992):
    VALUES, CALL-WITH-VALUES
    DYNAMIC-WIND
    EVAL, INTERACTION-ENVIRONMENT, SCHEME-REPORT-ENVIRONMENT

- LET-SYNTAX and LETREC-SYNTAX now work.

- Somewhat different package setup internally.


NEW IN VERSION 2.8.

- #f and () are distinct values, and () is not treated as false for
  the purpose of conditionals (IF, COND, NOT, etc.).  Among other
  things, this means that (null? #f) and (not '()) are now #f instead
  of #t.

- The dialect supported is Revised^4 Scheme, not Revised^3 Scheme.
  This means that a few things have gone away (T, NIL, LAST-PAIR), a
  few things have changed (arguments to NUMBER->STRING and
  STRING->NUMBER), and there are a few new features (PEEK-CHAR,
  LIST?).

- As required by the Scheme report, the built-in Scheme procedures are
  not integrated by default.  This means that you can SET! or DEFINE
  any name (except for the syntactic keywords).  It also means,
  however, that programs will run more slowly than they would have
  under version 2.7.  To obtain better performance at the expense of
  the ability to redefine built-ins, evaluate (benchmark-mode).

- DEFINE-SYNTAX and SYNTAX-RULES are implemented, as described in the
  Revised^4 Scheme report appendix.  Unfortunately, there's no way to
  represent the "..." token; for this reason, --- is provided as an
  alternative.

- RATIONALIZE now works as per the Revised^4 Report, except that the
  result is always exact.

Bug fixes & minor improvements in version 2.8a:

- LETREC strategy analysis fixed for OR, AND, CASE, COND
  [ (do ((i 0 (+ i 1))) ((> i 10)))  was compiling as a LABELS instead
    of as a PROG]
- LIST? fixed  [(list? '(a b)) was returning false]
- In Lucid, warnings about missing IN-PACKAGE's are now muzzled.
  This is a fragile fix; may break in later Lucid versions.

- Record print function inconsequentially improved
- ERROR liberalized; first arg can be a Common Lisp condition type name.
- WRITE applied directly to 'FOO prints 'FOO instead of (QUOTE FOO)
- New procedures GET and PUT in sicp.scm


New in versions 2.8b, 2.8c, 2.8d:

- Various bugs fixed in DEFINE-SYNTAX.

- VALUES, CALL-WITH-VALUES, and DYNAMIC-WIND are implemented, as
  described in
     altdorf.ai.mit.edu: archive/scheme-reports/june-92-meeting.tar.Z.

  The multiple return value implementation is inherited from Common
  Lisp, so its error checking is correspondingly more lax.
  E.g., (+ (values 1 2) 3) is an error in Scheme, but yeilds 4 in
  Common Lisp.

  DYNAMIC-WIND does not of course support upwards continuations
  (because CALL-WITH-CURRENT-CONTINUATION doesn't), so the "before"
  thunk will only ever be executed once.
