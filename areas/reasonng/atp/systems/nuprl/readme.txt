The file nuprl-3-2.tar.Z is a compressed tar file containing the most
recent distribution.  Use "binary" mode when retrieving it.  Once retrieved, 
do the following 

   uncompress nuprl-3-2.tar.Z
   tar xf nuprl-3-2.tar

You will now have a single directory tree with root named "nuprl".  To
complete the installation of Nuprl, follow the instructions in the
file nuprl/doc/installating-nuprl.text (ignoring anything referring to
tapes).

Following is a short "announcement" of Nuprl 3.2.

------------------------------------------------------------------

Version 3.2 of the Nuprl Proof Development System is now available.
Version 3.2 is the same as 3.1 and 3.0 except for a few bug fixes.
The major difference between version 3.0 and the previous release is
the addition of an interface to X-windows.  It now should be possible
to run Nuprl on any Unix machine running X-windows and a commercial
Common Lisp with CLX (the standard interface from Common Lisp to
X-windows).  There are also interfaces to Symbolics Lisp Machines and
Suns running the SunView window system, but these are considered
obsolete and will not be further supported.

We have tested Nuprl 3.2 with various versions of Allegro and Sun
(Lucid) Common Lisp.  We have also tested Nuprl with AKCL Version
1.530 on a Sparcstation.  AKCL is the Austin version of KCL and is
available via anonymous ftp from cli.com.

To cover our costs, we are charging new recipients of Nuprl $150 for
the distribution package.  The package includes a tape and the book
"Implementing Mathematics with the Nuprl Proof Development
System".  The tape includes the source code for Nuprl, some of the
Nuprl libraries that have been constructed at Cornell, and some
documentation files that supplement the book.  Those who have paid for
a previous distribution package can obtain a Nuprl 3.2 tape free of
charge.

When requesting a copy of the system, please specify what kind of tape
you would like: a cartridge in Symbolics' "carry" format, a tar-format
cartridge, or tar-format reel.  Please make any cheque payable to "Nuprl
Project".

Nuprl 3.2 is distributed as a research system.  We would like to hear
about problems you have with the system and will try to fix bugs
promptly, but we make no guarantees whatsoever regarding support for
or correctness of the system.

Please direct all correspondence to:

Elizabeth Maxwell, maxwell@cs.cornell.edu
Nuprl Distribution Coordinator
Department of Computer Science, Upson Hall
Cornell University
Ithaca, NY 14853. 
