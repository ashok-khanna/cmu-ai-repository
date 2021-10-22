%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Wild_LIFE is here at last!

The Wild_LIFE interpreter is the first implementation of the LIFE
language available to the general public.  It is a product of the
Paradise project at the DEC Paris Research Laboratory.

LIFE (Logic, Inheritance, Functions, and Equations) is an experimental
programming language with a powerful facility for structured type
inheritance. It reconciles styles from functional programming, logic
programming, and object-oriented programming. It subsumes, and fully
contains the functionality of, the precursor languages LOGIN and Le_Fun.
The syntax of Wild_LIFE has been kept as close as possible to that of the
Edinburgh family of Prolog so that Prolog compatibility is easy to
achieve.

From a theoretical point of view, LIFE implements a constraint logic
programming language with equality (unification) and entailment (matching)
constraints over order-sorted feature terms. The interplay of unification
and matching provides an implicit coroutining facility thanks to an
automatic suspension mechanism.  This allows interleaving interpretation
of relational and functional expressions which specify structural
dependencies on objects.

The Wild_LIFE interpreter is a fully functional implementation of the
LIFE language.  It has been extensively tested on DECstations running
Ultrix, and it has been ported to other Unix workstations (including
SPARCstations).  It should not be hard to port to workstations running
BSD-lookalikes.  It has a comfortable user interface with incremental
query extension ability.  It contains an extensive set of built-in
operations as well as an X Windows interface.

This release contains the following:

1. The C and LIFE source code of Wild_LIFE.

2. A set of non-trivial example programs including an incremental Gaussian
   equation solver, a PERT scheduler, a full LIFE parser, a flower-drawing
   program that handles X events, uses an X toolkit and a 3D turtlegraphics
   package written in LIFE and compiles rewrite rules into LIFE.

3. A draft user manual.
 
4. An extensive test suite to verify the correct working of the interpreter.

The system is available by anonymous ftp from gatekeeper.dec.com.
After logging in, enter the command "cd pub/plan" to go to the right
directory, and then "bin" to go to binary transfer mode.  Then enter
the command "get Life0.91.tar.Z" to get the system.  Uncompress and untar
this file to obtain the Life/ directory.  Read Life/README for further
instructions.

The Paradise project has written many articles and research reports on
various aspects of LIFE.  Read Life/README for instructions on how to
get copies.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Relevant electronic mail addresses:

   Here are email addresses that are relevant to LIFE and Paradise:

   life-users@prl.dec.com

      This is a mailing list of people using LIFE or interested in
      specific aspects of LIFE, whether theory, implementation, or
      applications. It is meant as a public forum to answer FAQ's and
      share programs and ideas. It is not meant to report bugs, although
      it may be used to ask public opinions about surprising behavior of
      Wild_LIFE that may turn out to be a bug and to warn others against
      confirmed bugs.

   life-request@prl.dec.com

      This address is to be used to request to be be put on, or removed
      from, the life-users mailing list.

   life-bugs@prl.dec.com

      When you strongly suspect a bug (i.e., after reading the manual,
      the life-users' FAQ's, and polling life-users's opinion about the
      symptoms), try to find the *smallest* program that illustrates the
      bug and mail it to this address together with a script that shows
      the bug.

   paradise@prl.dec.com

      This is PRL's local LIFE community. That is, all the PRL people
      involved in some activity in the Paradise project at PRL. Use this
      for general communication of matters of interest to this group
      alone. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

----------------------------------------------------------------
Peter Van Roy
Digital Equipment Corporation          Net: vanroy@prl.dec.com
Paris Research Laboratory              Tel: (33) (1) 47 14 28 65
85, avenue Victor Hugo                 Fax: (33) (1) 47 14 28 99
92500 Rueil-Malmaison Cedex           Home: (33) (1) 30 61 41 29
France
----------------------------------------------------------------
