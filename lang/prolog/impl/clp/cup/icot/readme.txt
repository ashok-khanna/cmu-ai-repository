	(C)1992 Institute for New Generation Computer Technology
	(Read COPYRIGHT for detailed information.)

ICOT Free Software
"Constraint Logic Programming Lanuguage	cu-Prolog"

1. Introduction
 cu-Prolog is an experimental constraint logic programming language.
Unlike most conventional CLP systems, cu-Prolog allows user-defined 
predicates as constraints and is suitable for implementing a natural 
language processing system based on the unification-based 
grammar. As an application of cu-Prolog, we developed 
a JPSG (Japanese Phrase Structure Grammar) parser 
with the JPSG Working Group (the chairman is Prof. GUNJI, Takao of
Osaka University) at ICOT. 

cu-Prolog is also the complete implementation of the constraint
unification and its name (cu) comes from the technique.

2. Environment
Originally, cu-Prolog is implemented in the C language of UNIX
4.2/3BSD. Later, prof.Sirai of Chukyo-University implemented cu-Prolog
in Apple Macintosh and DJ's GPP (80386/486 MS-DOS machine with the DOS
extender).

3. Content of this free software
INSTALL		README		doc/		
INSTALL.j	README.j	src/	/sample

doc/
cu3eman.bbl	cu3man.bbl	cup3.index	cup3e.xref
cu3eman.tex	cu3man.tex	cup3.xref

src/
defsysp.c	main.c		print.c		syspred1.c	unify.c
funclist.h	mainsub.c	read.c		syspred2.c	varset.h
globalv.h	makefile	refute.c	tr_split.c
include.h	modular.c	sysp.h		tr_sub.c
jpsgsub.c	new.c		syspdef.h	trans.c

sample/
eisele.p	jpsg.p		jpsg2.p		kasper.p	memap.p

4. How to install?
Read INSTSALL and doc/cu3eman.tex.
You have only to compile all the C programs by typing "make" after
UNIX shell prompt.

5. Porting Information
Originally, cu-Prolog is implemented in the C language of UNIX
4.2/3BSD. Later, prof.Sirai of Chukyo-University ported cu-Prolog
into Apple Macintosh and DJ's GPP (80386/486 MS-DOS machine with the
DOS extender).

(Caution)Macintosh/MS-DOS versions of cu-Prolog are available using
anonymous FTP from the following host.

FTP host name: 	csli.stanford.edu
Directory:	pub/MacCup 
File names (Aug 31, 1993): 
-rw-r--r--  1 184         47137 Aug 14 11:30 MacCup.doc
-rw-r--r--  1 184        124085 Aug 23 14:52 MacCup080b.sea.hqx
-rw-r--r--  1 184        124800 Aug 26 11:34 MacCup080c.sea.hqx
				(Apple Macintosh Version)
-rw-r--r--  1 184          6083 Aug 27 17:35 README
-rw-r--r--  1 184        102530 Aug 27 17:25 cup380d.tar.z
				(Unix version : extended)
-rw-r--r--  1 184         46137 Feb 17  1993 djcup.doc
-rw-r--r--  1 184        118300 Jan 27  1993 djcup.lzh
				(MS-DOS+DOS-extender version)
-rw-r--r--  1 184         27150 Aug 25  1991 manual.tex
-rw-r--r--  1 184         26169 Aug 14 13:00 sample.p
-rw-r--r--  1 184          2057 Jan 27  1993 util.p
226 ASCII Transfer complete.

6. Reference

Hiroshi Tsuda, Hasida Koiti and Sirai Hidetosi,
JPSG Parser on Constraint Logic Programming,
In Proceedings of 4th ACL European Chapter, pp 95--102, 1989.

Hiroshi Tsuda, Hasida Koiti and Sirai Hidetosi,
cu-Prolog and its application to a JPSG parser,
In K.Furukawa,H.Tanaka,and T.Fujisaki(eds.), Logic Programming'89,
pp.134--143, Springer-Verlag, LNAI-485.

Hiroshi Tsuda,
cu-Prolog for Constraint-Based Grammar, Proceedings of FGCS'92, 1992.

Hiroshi Tsuda, Hasida Koiti and Sirai Hidetosi,
cu-PrologIII system.
Technical Report ICOT-TM1160, 1992.

7. User's Group
In order to exchange information, we have cu-Prolog user's group and
its mailing list. To join the cu-Prolog user's group, please send an
e-mail to:
	cup-request@icot.or.jp

For bug information or questions about cu-Prolog, please send to:
	cup-bugs@icot.or.jp


8. Patch Information
Oct5-1992: main.c (set global vars)	:thanks to Mr.Horikawa.
	   syspred1.c (reaad_pred bug)	:thanks to Dr.Fontanini
	   cu3eman.tex	(delete lingmacros.sty) :thanks to Mr.Utsumi
Oct29-1992: main.c (reset termset log) :thanks to Dr.Sivand Lakmazaheri
Nov4-1992:  syspred1.c (general_assert): tanks to Dr.Sivand Lakmazaheri
	trans.c (sort body literals for folding): thanks to H.Sirai
May28-1993: syspred1.c, defsysp.c 	(thanks to Mr.H.Ono)
	abolish_pred/1  debug
	add project_cstr/2
Jul16-1993: defsysp.c                   (thanks to Mr.H.Ono)
Jul30-1993: main.c, mainsub.c, include.h, globalv.h, varset.h
	Add command arguments.
Aug3-1993: main.c, mainsub.c, new.c, tr_split.c
	speed up
Aug17-1993: cu-Prolog user's group information, unify.c (by H.Sirai)
Sep22-1993: main.c mainsub.c  (debug GC)
