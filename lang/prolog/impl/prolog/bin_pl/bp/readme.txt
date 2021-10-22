PERMISSION TO USE AND MODIFY THIS SOFTWARE IS GRANTED FREE OF CHARGES
FOR RESEARCH AN OTHER NON-PROFIT PURPOSES, PROVIDED THIS COPYRIGHT NOTICE
IS ADDED TO THE RESULTING VERSION.
 
BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT 
WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
REPAIR OR CORRECTION.

LICENSING FOR COMMERCIAL PURPOSES TO INDIVIDUALS AND ORGANISATIONS,
LICENSING OF THE SOURCE CODE OF THE ENGINE, PORTS TO OTHER ARCHITECTURES
AND EXTENDED VERSIONS OF THE PROGRAMMING ENVIRONMENT ARE AVAILABLE,
BUT NEED A SEPARATE AGREEMENT.

PLEASE CONTACT:

Paul Tarau
Dept. of Computer Science
Universite de Moncton
Moncton N.B.
Canada E1A-3E9
E-MAIL: tarau@info.umoncton.ca

----------------------------------------------------------------------
!!! ORIGINAL DISTRIBUTION: 

    ftp clement.info.umoncton.ca (139.103.16.2)

in /pub/BinProlog.

(clement.info.umoncton.ca is a Sparcstation ELC with SUNOS 4.1.1).

Please send comments and bug reports to binprolog@info.umoncton.ca.

BinProlog Copyright (C) Paul Tarau 1992-94 All rights reserved

---------------------------- INSTALLATION --------------------------
EITHER:

   Edit `Makefile'. Change BINDIR and comment out ARCH_AND_OS,
   for example:

   BINDIR = /usr/local/bin
   ARCH_AND_OS = sparc.sunos

   then TYPE:

      make install

OR:

  Copy or symbolically link bin/wam.<ARCH>.<OS>  to `bp'
  somewhere in your path, than type `bp'.

Normally the appropriate `wam' (a C-ified self contained executable) or
(for some old architectures) typing `ru wam.bp' (possibly a small `bp'
shell-script) are all you need to have BinProlog 3.00 running.  For
DOS/Windows 386/486 PCs you will have to type something like `go32
ru.386 wam.bp' (or a small bp.bat) file.

----------------------------------------------------------------------
MACHINES SUPPORTED

This distribution contains the Prolog source of the compiler and
executable emulators for:

  - Sparc - SunOS 4.x, Solaris 2.x;
  - DEC Alpha - 64 bit
  - 680xx NeXT - Mach; SUN3 - SunOS 4.x
  - MIPS - DEC;
  - 386-486 (MsDOS+Windows - with 32bits DOS-extender go32 ver. 1.10).
  - pc-linux

As the implementation makes no assumption about machine word size it is
likely to compile even on very strange machines that have a C-compiler.
Moreover, BinProlog's integers are inherited from the native C-system.
For example on DEC ALPHA machines BinProlog has 64-3=61 bit integers.
On 32-bit systems it has 32-2=30 bit integers.
Floating point is double (64 bits) and it is guaranteed that computations
in Prolog will always give the same results as in the underlying C.
As a matter of fact BinProlog does not really know that it has floats
but how this happens is rather long to explain here.

---------------------------------------------------------------------
FEATURES

This version includes real numbers and functions like sin, cos, exp, 
log etc. See progs/bp.pl for an application that makes use of them.

Although other Prolog's assert and retract primitives are emulated in
BinProlog, their highly overloaded functionality has been decomposed in
separate simpler operations that give also improved efficiency.

For permanent information BinProlog has a new, garbage-collected data
area ("the blackboard") where terms can be stored and accessed
efficiently with a a 2-key hashing function using something like

?-bb_def(likes,joe,[any(beer),good(vine),vegetarian(food)]).

and updated with something like

?-bb_set(likes,joe,nothing).

or ?-bb_rm(likes,joe).

To query it:

?-bb_val(likes,joe,What).

BinProlog 3.00 has also backtrackable global variables,
with 2-keyed names.

Try:

?- Person=joe, friend#Person=>mary, bb.

and then

?- friend # joe=>X.

The blackboard can be used either directly or
through an assert-retract style interface.

A small exercise:  if you want backtrackable behaviour of assert and
retract you can modify extra.pl and use A#B=>X style global variables
in their definition, instead of bb_def/3 etc.

The blackboard also gives constant-time sparse arrays and lemmas.

For example try:

?- for(I,1,99),bb_def(table,I,f(I,I)),fail.
?- bb.

BinProlog 3.00 has Edinburgh behaviour and tries to be close
to Sicstus and Quintus Prolog on the semantics of builtins
without being too pedantic on what's not really important.

All the basic Prolog utilities are now supported (dynamic clauses, a
metainterpreter with tracing facility, sort, setof, dynamic operators
floating point operations and functions).
ard.

These predicates offer generally faster and more flexible management of
dynamic state information than other Prolog's dynamic databases.

Mode is interactive by default (for compatibility with other Prologs) but if
you use a modern, windows based environment you may want to switch it
off with:

?- interactive(no).

and turn it on again with

?- interactive(yes).

--------------------------- EDITOR --------------------------------

To edit a file (with emacs) and then compile it use:

?- e(<file>).

To debug your code, R.O. Keefe's meta-interpreter with a basic tracing
mechanism is included. Using interactive(no) and greping and searching
through the output file is probably the best way to debug at this time.

To use it do:

?-reconsult(File).

and then

?-trace(Goal).

DCG-expansion is supported by the public domain file dcg.pl.


-------------------------- INCLUDED PROGRAMS ---------------------------

The directory progs contains a few BinProlog benchmarks and applications.

allperms.pl: permutation benchmarks with findall
bfmeta.pl:   breadth-first metainterpreter
bp.pl:       float intensive neural net learning by back-propagation
cal.pl:      calendar: computes the last 10000 fools-days
fcal.pl:     calendar: with floats
chat.pl:     CHAT parser
choice.pl:   Choice-intensive ECRC benchmark
cnrev.pl:    nrev with ^/2 as a constructor instead of ./2
cube.pl:     E. Tick's benchmark program
fibo.pl:     naive Fibonacci
ffibo.pl:    naive Fibonacci with floats
hello.pl:    example program to create stand-alone Unix application
knight.pl:   knight tour to cover a chess-board (uses the bboard)
lknight.pl:  knight tour to cover a chess-board (uses the lists)
ltak.pl:     tak program with lemmas
lfibo.pl:    fibo program with lemmas
lq8.pl :     8 queens using global logical variables
maplist.pl:  fast findall based maplist predicate
nrev.pl:     naive reverse
nrev30.pl:   small nrev benchmark to reconsult for the meta-interpreter
or.pl:       or-parallel simulator for binary programs (VT100)
other_bm*:   benchmark suite to compare Sicstus, Quintus and BinProlog
puzzle.pl:   king-prince-queen puzzle
q8.pl:       fast N-queens
qrev.pl:     quick nrev using builtin det_append/3
subset.pl:   findall+subset
tetris.pl:   tetris player (VT100)

--------------------------- DOCUMENTATION ------------------------------

Although BinProlog does contain a relatively slim documentation
(see the directory `doc') its Prolog is fairly standard.

Availability of source code for builtins and the compiler gives to the
Prolog programmer the possibility to configure and to adapt it easily.
