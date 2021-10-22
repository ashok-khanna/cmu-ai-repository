From pk@talitiainen.cs.tut.fi Mon Oct 11 18:26:17 EDT 1993
Article: 7593 of comp.lang.scheme
Xref: crabapple.srv.cs.cmu.edu comp.lang.scheme:7593
Newsgroups: comp.lang.scheme
Path: crabapple.srv.cs.cmu.edu!honeydew.srv.cs.cmu.edu!rochester!udel!news.udel.edu!darwin.sura.net!europa.eng.gtefsd.com!uunet!pipex!sunic!news.funet.fi!news.cs.tut.fi!news.cs.tut.fi!pk
From: pk@talitiainen.cs.tut.fi (Kellom{ki Pertti)
Subject: Announcing Psd - The Portable Scheme Debugger, version 1.1
Message-ID: <PK.93Oct8134620@talitiainen.cs.tut.fi>
Sender: usenet@news.cs.tut.fi (#Kotilo NEWS system )
Nntp-Posting-Host: talitiainen.cs.tut.fi
Organization: Tampere University of Technology
Date: Fri, 8 Oct 1993 11:46:20 GMT
Lines: 75

A new release of Psd is available for anonymous ftp, place to look at
is cs.tut.fi:/pub/src/languages/schemes/psd-1.1.tar.Z.

Here's the README
----------------------------------------------------------------------
PSD - THE PORTABLE SCHEME DEBUGGER 
VERSION 1.1, October 1993

This is psd, the portable Scheme debugger. It does source code
debugging for any R4RS compliant Scheme interpreter when run in a
GNU Emacs buffer (either version 18 or 19). With psd you can
 * set and clear breakpoints
 * single step evaluation
 * examine and change the variables of the debugged program
 * follow execution in an editor window
 * run a program until a run time error occurs, and examine the state
   of the program

You can find the latest version of psd in
cs.tut.fi:/pub/src/languages/schemes. It is also available in the
Scheme repository at nexus.yorku.ca and its mirror sites, at least
ftp.inria.fr and faui80.informatik.uni-erlangen.de.

TO INSTALL AND RUN: see the manual in doc/

Psd is known to work with Aubrey Jaffer's scm, but porting to other
Schemes should be easy.  In fact, for a R4RS Scheme you should not
have "port" it at all. It works also with Elk v. 1.5 and the sci
interpreter in the Scheme->C system.

Files in the distribution:

 README			this file
 COPYING		the GNU General Public License
 doc/article.tex	a technical description of psd
 doc/article.bbl	LaTeX bibliography
 doc/article.ps		PostScript file derived from article.tex
 doc/manual.tex		a user's manual
 doc/manual.bbl		bibliograpy
 doc/manual.ps		user's manual in PostScript
 doc/quick-intro.	tex quick reference for psd
 doc/quick-intro.ps

 psd.el			psd minor mode for Emacs

 psd.scm		the generic main file that takes care of loading psd
 psd-slib.scm		main file to be used with slib
 psd-scm.scm    	ditto for scm without slib (you should really get slib)
 psd-sci.scm		ditto for sci (tested with version 28sep90jfb)
 instrum.scm		the instrumentation code
 pexpr.scm		definition of pexps, which are sexps with position
			information 
 read.scm		the reader for psd
 runtime.scm		runtime support for debugging
 primitives.scm 	runtime support that has to know about primitive
			procedures 
 version.scm    	announces the psd version
 qp.scm	        	print any Scheme object in one line, truncating if
			necessary. Normally this comes from slib.
 cmuscheme.el		the CMU Scheme mode for GNU Emacs by Olin Shivers. 
 comint.el		support for cmuscheme.el

Comments, suggestions and bug reports are welcome.

	    Pertti Kellom\"aki (TeX format), pk@cs.tut.fi
		     Tampere Univ. of Technology
			 Software Systems Lab
			       Finland

--
Pertti Kellom\"aki (TeX format)  #       These opinions are mine, 
  Tampere Univ. of TeXnology     #              ALL MINE !
      Software Systems Lab       #  (but go ahead and use them, if you like)




