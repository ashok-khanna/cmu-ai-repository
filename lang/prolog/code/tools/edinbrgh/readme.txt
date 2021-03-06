tools.tar.Z
    Edinburgh DEC-10 library.
    AI Applications Institute, Edinburgh University.

                         EDINBURGH PROLOG TOOLS
   Contributed by the AI Applications Institute, Edinburgh University
                   Received on the 14th of April 1988
                     Shelved on the 6th of July 1988


UNIVERSITY OF EDINBURGH                                   AIAI/PSG103/87

AI APPLICATIONS INSTITUTE

PROGRAMMING SYSTEMS GROUP                                      Issued by
Note No. 103                                                 Ken Johnson
                                                              Robert Rae
Structure and Contents of the Prolog library          12th November 1987
________________________________________________________________________

The DEC-10 Prolog Library was an extraordinary and catholic collection
of Prolog routines, largely written by research workers and students in
Professor Alan Bundy's Mathematical Reasoning Group at the Department of
Artificial Intelligence at the University of Edinburgh. In summer 1987
we sifted through the enormous amount of material in this library,
grouping similar material together and converting some of the more used
programs into Edinburgh Prolog.

These programs are all examples of Prolog programming to deal with
objects and problems of many kinds. (Some of these examples are very
good examples, others are not so; some are well commented, some have
separate documentation, some have none.) You may be able to load tools
for low-level operations into your code ready-made, or you may gain
insight into how to write good Prolog (as we did) through just browsing
amongst the source code here.

It is difficult to sort things into categories. We have tried to do it
and to avoid a rag-bag "Miscellaneous" category, but undoubtedly there
will be files that you'll think have been put into the wrong place.

The top level directories that we have identified are data, demo, io,
prolog, tools and util. Most of these are reasonably self-explanatory:

     data contains files relating to data structure definition and
     manipulation;

     demo contains files of demonstration and teaching material;

     io contains files relating to input and output of structured and
     unstructured data;

     prolog contains files of common extensions to the Prolog language
     and definitions of parts of the Prolog system in Prolog;

     tools contains files relating to the development of Prolog
     programs;

     util: all the files in this directory are links to files which
     already exist in some other part of the library. They were
     identified originally for use with the PRESS system and were
     grouped together for convenience. They have proved useful to other
     systems since.

_______________________________________________________________________
These files are all supplied "as is", with NO guarantee of any kind. If
things don't work, fix them and mail the fix to us, if you can.
Otherwise complain and we will fix them if we can. Obviously we cannot
undertake to do this within any particular time limit.

Electronic mail to nip@uk.ac.ed will reach us.

These files are all in the "public domain" so you can use them freely,
copy them, incorporate them into programs of your own and so forth
without payment. The work of producing them in the first place and of
organising them as detailed here has been funded over the years at
Edinburgh University mainly by the Science and Engineering Research
Council. Their dissemination has been encouraged by the Alvey Special
Interest Group: Artificial Intelligence. We would appreciate it if you
were to acknowledge these bodies when you use or re-distribute any of
these files.
_______________________________________________________________________
The files of the original DEC-10 Prolog Library have been divided up
into categories to give the following directory structure:

    [omitted. JNP]

This is the contents of the Prolog Library in alphabetical order of file
name. Any files whose names end in .HLP are text files which explain
another Prolog file, and they are not listed below. All the others are
listed with a one-line description.

advice.pl           Interlisp like advice package.

ANDOR.pl            Meta circular interpreter maintaining extended and-or tree.

applic.pl           Function application routines based on "apply".

ARC3.pl             Mackworth's AC-3 algorithm.

ARCH1.PRB           Winston arch domain. Inference version.

ARCH3.PRB           Winston arch domain.

ARHC2.PRB           Winston arch domain, with inference rules.

arith.ops           Arithmetic operator declarations.

arith.pl            Arithmetic operations.

arrays.pl           Updateable arrays.

ask.pl              Ask questions that have a one-character answer.

assoc.lists.pl      Association lists.


BACKUP.pl           Rename a file according to a back-up convention.

bagutl.pl           Utilities for "bags".

between.pl          Generate successive integers.

bfs.pl              Missionaries and Cannibals: breadth first search.

BREADTH_FIRST.pl    Define a schema for breadth-first search.

BUNDLE.pl           Bundle and unbundle files.


CC.pl               Conditional compilation.

CLAUSE.pl           Convert a formula in FOPC to clausal form.

CONN                Operator definitions for logical connectives.

Contents            This file.

count.pl            Information about a valid Prolog file.

CRYPTA.pl           Solve cryptarithmetic puzzles.

CTYPES.pl           Character classification.


DCSG.ex             Example grammar for DCSG.pl.

DCSG.pl             Definite Clause Slash Grammar.

DEC10.pl            DEC-10 compatibility file for C-Prolog 1.4a.

DECONS.pl           Construct and take apart Prolog control structures.

depth.pl            Find or check the depth of a term.

DEPTH_FIRST.pl      Define a schema for a depth-first search.

dfs.pl              Missionaries and Cannibals depth first search.

DISTFIX.ex          Load DISTFIX.pl and define some examples.

DISTFIX.pl          Read Prolog terms with extended syntax.


edit.pl             Invoke an editor and return to Prolog.

EIGHT_PUZZLE.pl     Illustrate the searching methods.

evans.pl            Evans geometric analogy program.

expand.pl           Simple macro expansion.

EXPON.pl            Synthesis of an exponentiation routine.


figure.pl           Figures for the Evans program.

files.pl            Routines for playing with files.

flags.pl            Global variables.

flat.pl             Flatten trees to lists and back.

FOCUS               Reconstruction of Winston learning program.

FEACH.pl            Redefine foreach/5.


GELRAN.pl           Random number package.

gensym.pl           Create new atoms.

getfile.pl          Prompt for a file name.

graphs.pl           Graph processing utilities.

GUESS_FIRST.pl      Define a schema for a guess-first search.


heaps.pl            Implement "heaps".

HELP.pl             Prints extracts from help files.

HELP2.pl            Extracts predicate names and descriptions from files.

HELPER.pl           Prints extracts from help files.

help_directories.txtList of directories that contain ".HLP" files.

heu.pl              Missionaries and Cannibals: Heuristic search version.


IDBACK.def          Unit interface clauses for IDBACK.pl.

IDBACK.pl           Intelligent backtracking.

IMISCE.pl           Miscellaneous interpreted routines.

INFER               Inference package for focus program.

INVOCA.pl           Fancy control structures.

ISOLAX.PRB          Description space for learning isolate rule.

ixref.def           Definitions for ixref.pl.

ixref.pl            Interactive cross referencer.


keep.pl             Keep predicate(s) in a file.


lazy.pl             Lazy lists.

LEARN               Part of Winston's program.

LIB.pl              Version of Vax "lib" predicate.

LIB2.pl             Version of Vax "lib" predicate.

listut.pl           List handling utilities.

logarr.pl           Arrays with logarithmic access time.

logodb.pl           Logo-like inference package.

long.pl             Rational arithmetic.


MAKERC              Make records from lists of relations.

MAKE_UTIL           Create the utilities baseload from this library.

map.pl              Implement finite maps.

medic.pl            Mode error diagnosis in interpreted code.

metutl.pl           Meta logical operations.

MODULE.pl           Elementary module system for DEC-10 Prolog.

multil.pl           List-of-lists utilities.

mycin.pl            Version of the "mycin" program.


NOT.pl              Suspicious negation.


OCCUR.pl            Routines for checking number and place of occurrence.

order.pl            Define the "ordered" predicates.

ordset.pl           Ordered set manipulation.

OXO.pl              Noughts and crosses production system.


PIM.PRB             Artificial inference testing example for focussing.

PORSTR.pl           Portray lists of characters as strings.

pp.pl               Prolog pretty printer.

PROJEC.pl           Select k'th argument of each element of a list.

PROLOG.TYP          Definition of Prolog types for typecheck.pl.

PUTSTR.pl           Write out large blocks of text.


QUEENS.pl           Solve the N queens problem.

queues.pl           Queue operations.


random.pl           Random number generator.

RDTOK.gen           Tokeniser in reasonably standard Prolog.

RDTOK.pl            Reads tokens up to next ".".

READ.pl             Read Prolog terms in DEC-10 syntax.

read_in.pl          Read in a sentence as a list of words.

read_sent.pl        A flexible input facility.

RECON.pl            Version of consult and reconsult.

royalty.pl          Royal family data base.

RULES.pl            Production rules system.


samsort.pl          A sorting routine that exploits existing order.

setof.pl            Implementations of setof, bagof and findall.

setutl.pl           Set manipulation utilities.

solution.txt        Solution printed by Evans' program.

SORTS.pl            Definition of keysort and sort.

STRIO.pl            Prolog input and output to character strings.

struct.pl           General term hacking.

SUBTRA.pl           Production rules for subtraction by borrowing.

SUM.SOL.pl          Cryptarithmetic solution.

SUM1.pl             Example sum for use with RULES and SUBTRA.

SUM2.pl             Example sum for use with RULES and SUBTRA.

SUM3.pl             Example sum for use with RULES and SUBTRA.

SYSTEM.pl           Table of built-in predicates.

system_preds.pl     Table of built-in predicates.


termin.pl           Test for missing base cases.

TEST.pl             Test compiled routines by interpreting them.

tidy.pl             Algebraic expression simplifier.

TIMING.pl           Time execution of predicate.

TIMING.POP          Time execution of predicate (POP2 component).

TOPLEVEL.pl         Prolog top level.

trace.pl            Produce tracing messages.

TREES.pl            Updateable binary trees.

trysee.pl           Search directories and extensions to find a file.

type.pl             Command to display files.

typecheck.pl        Prolog type checker.


UNFOLD.pl           Unit resolution.

UPDATE.pl           For updating data base relations.

UTIL                Utilities for focussing program.

util.ops            Operator declarations for utilities package.

util.sav            Saved state for Edinburgh Prolog ver 1.5.01 (14 Aug 1987).


VCHECK.pl           Check for mis-spelt variables.


WINST               Consult all focussing files.

WINST.MIC

WINST.REF           Focussing cross reference.

WINST2.CMD

WPLANC.pl           Conditional plan generator.

WPO.pl              Operator declarations for WPLANC.pl.

writef.pl           Formatted write.


XGPROC.pl           Translate XGs to Prolog.

XREF.DEF            Cross referencer definitions.

XREF.pl             Cross referencer.

XRF.pl              Cross referencer program.

XRFCOL.pl           Collecting-up module of the cross referencer.

XRFDEF.pl           Handles .def files for the cross referencer.

XRFMOD.pl           Update declarations in Prolog source file.

XRFOUT.pl           Output module for the cross referencer.

XRFTST.BAR          Cross referencer test file.

XRFTST.FOO          Cross referencer test file.

XRFTTY.pl           Terminal interaction for cross referencer.
[AIAI]


TOTAL SIZE :  1122 kilobytes.


CHECKED ON EDINBURGH-COMPATIBLE (POPLOG) PROLOG : I have used some of
them, but by no means all.


PORTABILITY : I haven't examined them in detail, but some will need
modification. For example, many assume the availability of 'record',
which you may lack. Also, many depend on predicates such as 'append' and
'member' from other libraries in the same set. If your own libraries are
structured differently, you will face some problems in making the two
compatible.


DOCUMENTATION : It varies. Some have detailed internal comments and help
files; others have almost nothing.

