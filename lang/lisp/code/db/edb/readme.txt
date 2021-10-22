This directory contains EDB, a database program for GNU Emacs.
EDB was written by Michael Ernst <mernst@theory.lcs.mit.edu>.
EDB is in beta test, but is reasonably stable.
It is possible that this directory contains a prerelease of the next
version of EDB, but that should not affect you.

The following files are available:

README		This file.  The code/ and examples/ directories have README
		files of their own.

edb.tar.Z	A compressed tar file of the entire package.  This is the
code/		file you probably want in order to get started with EDB.
		To extract the files, create a new directory for EDB (such
		as ~/emacs/edb), move edb.tar.Z there, and issue the
		following commands:
		  uncompress edb.tar.Z
		  tar xvf edb.tar
		Then read the README file that was just created.  (It is
		different from from this README file!)  All of the files in
		the tar file are also available from the code subdirectory
		of this directory; this is useful if you have no uncompress
		or tar program, or if you only want to get a more recent
		version of a few files.

database.dvi	The bulk of the EDB documentation is in the texinfo file
database.ps	database.texi, which is included in edb.tar.Z and can also
database.info	be found as code/database.texi.  This file uses version 2
database.info-1	of texinfo, but not everyone has upgraded to texinfo 2, so
database.info-2	pre-processed versions for printing and for use in the Info
database.info-3	hypertext documentation browser are provided.
database.info-4
database.info-5

examples.tar.Z	Contains example databases for use with EDB.  The files in
examples/	this tar archive are also available in the examples
		subdirectory of this directory.

changelog	All the release notices since version 0.20 (April 26, 1992).

diffs/		Patches from previous versions of EDB to the current one.

19-regexp.fix	A message describing how to correct EDB's sometimes very
		slow parsing of format files under Emacs 19.
