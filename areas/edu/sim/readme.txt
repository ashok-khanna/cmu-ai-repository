#	This file is part of the software similarity tester SIM.
#	Written by Dick Grune, Vrije Universiteit, Amsterdam.
#	$Header: READ_ME,v 2.1 91/06/18 22:00:16 dick Exp $

These programs test for similar (or equal) stretches in one or more program
files and can be used to detect common code or plagiarism. See sim.1.
Checkers are available for C, Pascal, Modula-2, Lisp and natural text.

This READ_ME file describes the UNIX version. The MSDOS version is described
in the file READ.ME.

To compile and test, call "make", which will generate one executable called
sim, the checker for C, and will run two small tests to show sample output.

To install, examine the Makefile and reset BINDIR and MANDIR to sensible
paths, and call
	make install.sim			for C
	make install.sim_pasc			for Pascal
	make install.sim_m2			for Modula-2
	make install.sim_lisp			for Lisp
	make install.sim_text			for text
or
	make install.all			for everything.
These will also install the manual page.

To change the default run size or the page width, adjust the file params.h
and recompile.

To add another language L, write a file Llang.l along the lines of clang.l
and the other *lang.l files, extend the Makefile and recompile.
All knowledge about a given language L is located in Llang.l; the rest of
the programs expect each token to be a single character.

Available at present: clang.l pascallang.l m2lang.l lisplang.l text.l

					Dick Grune
					Vrije Universiteit
					de Boelelaan 1081
					1081 HV  Amsterdam
					the Netherlands
					email: dick@cs.vu.nl
					ftp://ftp.cs.vu.nl/pub/dick
					http://www.cs.vu.nl/users/staff/dick/home.html
