README		 - this file
elf-04.txt	 - Version 0.4 Release Notes
elf-04.tar.Z	 - Version 0.4 of Elf (1 Jul 1993),
elf-examples.tar.Z  - Version 0.4 of Elf examples (unchanged from Version 0.3)
elf-tools.tar.Z  - Version 0.4 of Elf tools (one line changed from Version 0.3)
elp/		 - eLP announcements. 
		   TAR files are in now in /afs/cs/project/ergo/export/ess/
elf-papers/	 - compressed .dvi files for papers related to LF and Elf.
papers/		 - other papers.

The README file for Elf is included below.
----------------------------------------------------------------------
This is the README file for Elf, a logic programming language based on the LF
Logical Framework.  This implementation is a prototype interpreter and the
execution is slow compared to Prolog.  However, type-checking is quite
efficient and there are number of optimizations which make it practical for
small and medium-sized examples.  A few helpful hints on how to use the system
can be found in the file NOTES.

The principal contributors to this implementation of Elf are
  Frank Pfenning     --- main language implementation
  Ekkehard Rohwedder --- pretty printing and tools
  Spiro Michaylov    --- efficiency improvements
Thanks also to Conal Elliott and Ken Cline whose first Lisp prototype
was influential on the design of this SML implementation.

Besides the implementation, .dvi files with the papers which have been written
about Elf to-date are also available via anonymous ftp.  Note, however, that
these do not constitute "documentation".  This release also comes with a
number of different examples from logic and computer science.

The installation of Elf requires Standard ML of New Jersey, although it should
be easy to port to other implementations of Standard ML.  Versions 0.72 and
greater are more likely to work than older versions (we recommend version
0.93).  Currently, SML of NJ can be retrieved via anonymous ftp from
princeton.edu (net address 128.112.128.1), directory pub/ml.  For up-to-date
information on Standard ML of New Jersey, contact David MacQueen
<macqueen@research.att.com>.  It is available for a large number of machine
architectures.

There is a mailing list with announcements about Elf.  Please send mail to
elf-request@cs.cmu.edu to join the list.  For further information contact

Frank Pfenning
School of Computer Science
Carnegie Mellon University
Pittsburgh, PA 15213-3891
U.S.A.

Email: fp@cs.cmu.edu
Phone: +1 412 268-6343
Fax  : +1 412 681-5739
======================================================================
Retrieving Elf, Version 0.4, Thu Jul  1 16:11:53 1993

(alonzo.tip.cs.cmu.edu has internet address 128.2.209.194)

% ftp alonzo.tip.cs.cmu.edu
Name: anonymous
Password: (your e-mail address)
ftp> cd /afs/cs/user/fp/public
ftp> type binary
ftp> get elf-04.tar.Z
ftp> get elf-examples.tar.Z
ftp> get elf-tools.tar.Z   # if wanted
ftp> bye

% uncompress *.Z
% tar -xvf elf-04.tar
% tar -xvf elf-examples.tar
% tar -xvf elf-tools.tar  # if wanted
% rm *.tar

This will create a directory elf/ with the sources for the
implementation and examples in various subdirectories.

See the file elf/elf/INSTALL for further installation instructions.

The file  elf-papers/natsem91.dvi.Z  provides a tutorial introduction
to the Elf language.
