       HDRUG: a Graphical User Environment for 
        Natural Language Processing in Prolog


                  Gertjan van Noord
              Alfa-informatica and BCN
              University of Groningen


CHANGES with version 1
----------------------

Many, many, many. See the CHANGES file for a subset of them.
Additions:
  - New: experimental port to HPSG grammar of ALE 2.0 (this
         grammar is written by Bob Carpenter and Gerald Penn).
  - New: uses BLT_graph widget for statistical output!
  - New: DOCUMENTATION has been added: 60+ pages (cf. Man directory)!
  - New: feature structures in TK widgets!
  - New: greatly simplified installation procedure!
  - New: trees with clickable buttons, configurable actions.

where
-----

The package is available from anonymous ftp in directory:

ftp://tyr.let.rug.nl/pub/prolog-app/Hdrug/

The newest version can be found as the gzipped tar-file 
hdrugSUF.tar.gz where SUF is the version number. 
Alternatively the same file is accessible through World Wide Web:

http://tyr.let.rug.nl/ vannoord/prolog-app/Hdrug/


What is Hdrug?
--------------

Hdrug is an environment to develop logic grammars / parsers /
generators for natural languages. The package is written in Sicstus
Prolog and uses the ProTcl as an interface between Sicstus
Prolog and Tcl/Tk. Tcl/Tk is a powerful script language to develop
applications for the X-windows environment. 

The package comes with a number of example grammars, including a
Categorial Grammar, a Tree Adjoining Grammar, a Unification Grammar in
the spirit of Head-driven Phrase Structure Grammar, an Extraposition
Grammar and a Definite Clause Grammar.

Each of the grammars comes with a set of parsers, such as Earley-like
chart parsers, left-corner parsers and head-driven parsers. Some
grammars come with variants of the head-driven generator. 

Hdrug allows for easy comparison of different parsers/generators; it
has extensive possibilities to compile feature equations into Prolog
terms; it can produce graphical (Tk),  and ordinary
Prolog output of trees, feature structures, Prolog terms (and
combinations thereof), plotted graphs of statistical information, and
 tables of statistical information. Etc. Etc.

Using just menu's and buttons it is possible to parse sentences,
generate sentences from logical form representations, view the parse
trees that are derived by the parser or generator, change a particular
version of the parser on the fly, compare the results of parsing the
same sentence(s) with a set of different parsers, etc.

It should not be difficult to adapt an existing NLP system written in
Sicstus to Hdrug. 



What example grammars/parsers/generators are provided?
------------------------------------------------------

Currently the following scripts are built:

NEW: 
[TA] : Ale 2.0 HPSG grammar, written by Bob Carpenter and Gerald
Penn. 

[TL] : HPSG grammar for Dutch using delayed evaluation techniques 
to implement recursive lexical rules (directory LexRules). 

[TT] : Small Tree Adjoining Grammar + 9 related head-corner 
parsing algorithms for headed Lexicalized and Feature-based TAG's 
(based on my paper on TAGs).

[TG] : DCG for Dutch, originally used as illustration for 
semantic-head-driven generation (sh-gen,cl,gen-book.
Furthermore, some of the parsers were used for the timings of
the paper co-authored with G. Bouma on the potential efficiency of 
head-driven parsing.

[TC] : Constraint-based Categorial Grammar for English written 
by G.Bouma, slightly adopted by G. van Noord for Hdrug. acl94.

[TD]: The smallest possible DCG. Illustration what you need to 
do minimally to adapt a grammar / parser to Hdrug. 

[TX]: Extraposition grammar based on the paper by Pereira. Can also 
be used to find out what you need to do to include a grammar into Hdrug.



Comparison
----------

This package might be compared with Pleuk (by Jo Calder et al). One of
the things of Pleuk that I didn't like was the use of the GM interface
to Interviews (that comes standard with the Sicstus library). Using
ProTcl it is possible in Hdrug to have Sicstus listen both to its
ordinary input stream and to the Tk buttons and menus. At every moment
you can decide to give ordinary prolog commands (keyboard), or rather
use the mouse to get your parser (or whatever) into action. Also, I
believe the Tk widgets look much nicer than the GM ones... :-), as
Tcl/Tk provides `the Motif look and feel'.

But note that Pleuk contains some functionality that is not (yet)
available in Hdrug, such as a nice graphical derivation checker.


Where to get it?
----------------


The package is available from anonymous ftp in directory:

ftp://tyr.let.rug.nl/pub/prolog-app/Hdrug/

The newest version can be found as the gzipped tar-file 
hdrugSUF.tar.gz where SUF is the version number. 
Alternatively the same file is accessible through World Wide Web:

http://tyr.let.rug.nl/ vannoord/prolog-app/Hdrug/


What other software do you need?

In order to use the full functionality of Hdrug you need the 
following programs: (apart from the requirement that you have some
UNIX machine running the X window system).


Package                                           Free?   Really neccessary?
Sicstus Prolog 2.1.8 (or higher)                    -              + 
Tcl 7.3 / Tk 3.6 (by J. Ousterhout) Tcl/Tk          +              + 
ProTcl 1.1 (or higher) (by Micha Meier)             +              +
TkSteal (Tk extension by Sven Delmas)               +              - (1) 
BLT library 1.7 (extensions of Tcl/Tk)              +              - (2)
Latex and Xdvi                                      +              - (3)
Treemaker (Tex extension)                           -              - (4)


ad (1)
Only if you want the Prolog stdin/stdout window to appear as a
subwidget of the Tk widget. It looks nice, but is not strictly
neccessary. It also seems less stable.

ad (2)
Only for Tk output of viewing the statistics of a comparion of
different parsers, if you don't have
it, you can use an alternative (less pretty) by using the file
st_tk.pl instead of st_blt.pl

ad(3)
Only for LaTeX/Xdvi output.

ad(4)
Only for Xdvi output of trees (Tk output of trees works without
this) From Univ. of Paderborn, contact daniel@uni-paderborn.de. It
costs around DM 50. Better than other things I've seen.








The program has been tested for HP-UX 9000/710 730, Linux (1.0,
1.1) and Sun.  As long as you manage
to get ProTcl to work, you should be all set.  Note that both on HP-UX
and Linux I did not manage to get ProTcl to work if I used
dynamic loading of the C code. It does however
work smoothly if I load the ProTcl C code statically. I have included
a small directory with a Makefile that makes this easier. 


How to install?
---------------


First, of course, determine in which directory you want to unpack the
package. Let's assume that you decide to use directory 
/usr/local/src. In that case, unpack the tar file in this
directory. This should give you a directory Hdrug, with
something like the following contents:

Applications/        Makefile.defs.hpux   README.bugs
Changes              Makefile.defs.linux  README.todo
Hdrug.ad             Man/                 Static/
Installation         ProTcl/              Tcl/
Makefile             Prolog/              Tex/
Makefile.defs        README               dirs.pl


The building of the system consists of the creation of a number of
sub-parts of the system. Each of these parts refer to the same
configuration file. This is the file Makefile.defs. Therefore,
the single most important step of the installation procedure is to
edit this file to suite your local setup and your personal
preferences. 

Makefile.defs
-------------

This file contains a number of variable assignments. These variables can
roughly be characterized as belonging to one of a number of groups:
General options, Sicstus options, Hdrug options, ProTcl options and
Static options. These options are discussed now as follows.

PREFIX 			/usr/local  
The setting of this variable is not
strictly neccessary but is useful in making the definitions of the
following variables simpler. 
quote

CWD 			$(PREFIX)/src/Hdrug  
The full path to the current working directory. 

BINDIR 			(PREFIX)/bin  
The directory in which the executables will be installed. 

APPDEFS 		(PREFIX)/lib/X11/app-defaults  
The directory in which the application defaults file
will be installed. 

ADSUFFIX 		c  
`c' for color displays and `bw' for black and white.

SICSTUS 		sicstus  
Name of Sicstus command. 

PLFLAGS 		
Copy this from the Makefile of Sicstus.

STATEORSCRIPT 		state  
If the value is state, then a Sicstus
saved state is built for each application. If the value is 
script then a script will be built as executable. Starting the
application is in the former case much faster, but saved states can be
huge. 


Installing Hdrug and the Hdrug applications
-------------------------------------------

If the configuration file Makefile.defs is properly edited, then the
installation procedure simply consists of a make of each of the
subdirectories.  If you re-install, then you should make sure that
existing dirs.pl files are removed if neccessary (or more safely do a
make all-clean in the Hdrug directory).  

Note that you should add the ./Tex directory both to your TEXINPUTS
environment variable. Alternatively you can move the syle files from
the ./Tex directory to a directory that can find.

It is probably best to start by making the Hdrug system and a simple 
application, to find out if you have an appropriate Makefile.defs and
if the system runs on your machine. To this end, you can do a
+make test+. This builds Hdrug, and the application.

To build the whole package, you might try a + make all+.
tes (Applications/*/state). If you don't want to build
all applications, you can also do a make <AppNam> where 
AppName is the name of the application, typically something like 
TA, TC, TD


Install the application defaults file. Note that Hdrug will expect
that the directory in which this application defaults file is
installed, is accessible via one of the environment variables 
XUSERFILESEARCHPATH, XFILESEARCHPATH, XAPPLRESDIR. Also note that
Hdrug does not understand conventions in these variable names
such as n.


Install the applications. This installs the shell scripts TA TC
TD  into your binary directory.
enumerate

Note that by default a Sicstus saved-state is 
generated for each grammar. These saved states are huge 
( Meg is not an exception). If you are short of diskspace you can try:
itemize

in the Makefile define STATEORSCRIPT to script This entails that
no saved states are built, but the application is started by a
script. Of course for large grammars there is a severe cost in speed
of startup.


use the Sicstus built-in mechanism for building compressed saved
states. This is done by setting the environment variable
et start the menu
sytem. Type x. if you want to start it anyway. 

Note that these options are NOT preceded by the usual dash, as
Sicstus does not allow you to (all dashed options are interpreted by
Sicstus internally).


Copyright notice
----------------


Hdrug 2.0: A graphical User Environment for NLP in Prolog

all files, except:
./Applications/Ale/*
./Applications/CBCG/*
are (C) 1994 Gertjan van Noord RUG

The CBCG directory is (C) 1994 Gertjan van Noord and Gosse Bouma RUG

Except for the Ale directory, the following applies:

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

cf. the file COPYING


