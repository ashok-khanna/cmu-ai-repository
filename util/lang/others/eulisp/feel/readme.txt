This directory contains the EuLisp definition, Feel, which is
intended as a reference implementation of EuLisp, an implementation
of the EuLisp object system in Common Lisp and an implementation in
Scheme.

The major features of the language are: an integrated object system, a
module system, and support for parallelism.  Feel is known to run on
the following machines with support for parallelism:
o Sun3/4
o Stardent Titan
o Alliant Concentrix 2800
o Orion clippers
o HP 730 and similar
o KSR-1 
  [Actually this version doesn't work. Contact pab@maths.bath.ac.uk]

Feel is partly a C-based interpreter and partly a bytecode
interpreter.  An out-of-core compiler system is also available.

The distribution includes:
o an interface to the PVM library
o support for TCP/ip sockets.
o libraries for futures, Linda, CSP and other bits and pieces

Please let us know if bits of these don't work. All have been used,
but some may be suffering from bit rot...

This code is made freely available for copying and further
distribution. Providing you don't delete the copyright messages that
is.

o defn-0.75.dvi.Z
  defn-0.75.ps.Z
	Version 0.75 of the eulisp definition.
	Note that feel's version numbers are unrelated to the 
        definition's version numbers. It is just a coincidence when
        they are the same.

o defn-0.95.dvi.Z
  defn-0.95.ps.Z
        Version 0.95 of the eulisp definition.
        Still quite a lot of work to do.
        Note that 0.95 is an interim edition to garner comments.

o defn-0.99.dvi.Z
  defn-0.99.ps.Z
        Version 0.99 of the eulisp definition.
        Almost there (we hope) in terms of content, but quite of lot
        of editorial work needed before 1.0 (spelling, layout, style
        consistency, some minor technical issues).

o feel-0.75.zip 
	MS-DOS source code for Feel. Look at README.386 for details. 
	Note that this is out of date. It should be relatively simple to 
	build the latest version on a PC.

o feel-0.85.tar.Z
	Source plus examples for Feel (Free and Eventually EuLisp)

o feel0.85b.tar.Z
	As above, but revised.

o feel-0.89.tar.Z
        Source of Feel.  About 90% consistent with the definition.

o comp-0.01.tar.Z
	Early version of the compiler. There are some problems with this,
	wait for 0.02

o comp0.85.tar.Z
	Simple compiler for Eulisp. You need to compile bytecode support into 
	feel to use this. Code executes a few times faster.

o telos-cl.lsp.Z
  telos-cl2.8.lsp.Z
        The EuLisp Object System in Common Lisp.  All comments and
        questions to Russell Bradforf (see below).

o ReadMe-1.00f
  telosis-1.00f.tar.Z
        The EuLisp Object System in Scheme.  See ReadMe-1.00f for
        further information.

Comments and questions on the definition should be addressed to Julian
Padget (jap@maths.bath.ac.uk). Comments on Feel should go to both
Julian Padget and Russell Bradford (rjb@maths.bath.ac.uk).

Enjoy....
