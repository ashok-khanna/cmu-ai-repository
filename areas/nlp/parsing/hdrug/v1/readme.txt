Hdrug (alfa version)
--------------------

Hdrug is an environment to develop logic grammars for natural
languages. The package is written in Sicstus Prolog and uses the
ProTcl interface (by M.Meier) to Tcl/Tk for the X-windows
environment. The package comes with a number of example grammars, 
parsers and generators (cf. below).

The package allows easy comparison of different parsers/generators;
extensive possibilities to compile feature equations into Prolog
terms; graphical (Tk), LaTeX and ordinary Prolog output of trees,
feature structures and Prolog terms (and combinations
thereof). Etc. Etc.

This package should be compared with Pleuk (by Jo Calder et al). One
of the things of Pleuk that I didn't like was the use of the GM
interface to Interviews (that comes standard with the Sicstus
library). Using ProTcl and the TkSteal package it is possible in Hdrug
to have Sicstus listen both to its ordinary input stream and to the Tk
buttons and menus. At every moment you can decide to give ordinary
prolog commands (keyboard), or rather use the mouse to get your parser
(or whatever) into action. Also, I believe the Tk widgets look much
nicer than the GM ones... :-).


Where can I get it?
-------------------

The package is available from anonymous ftp in directory:
ftp://tyr.let.rug.nl/pub/prolog-app/Hdrug/
http://tyr.let.rug.nl/~vannoord/prolog-app/Hdrug/

In this directory you will find the following sub-packages:
hdrug.tar.gz    : the main package including example grammars
library.tar.gz  : prolog library that is needed by Hdrug
protcl.tar.gz   : a slightly patched version of ProTcl
static.tar.gz   : small utilities to help build a statically compiled 
                  version of ProTcl
FSBox.tar.gz    : slightly patched version of FSBox.tcl by S.Delmas
matrix.sty      : macro for printing feature-structures in Latex

What is the status of this software?
------------------------------------

/*
 * Copyright (c) 1991-1994 Gertjan van Noord, University of Groningen
 * the CBCG package is (c) 1993-1994 Gosse Bouma University of Groningen
 *
 * All rights reserved.
 *
 * Permission is hereby granted, without written agreement and without
 * license or royalty fees, to use, copy, modify, and distribute this
 * software and its documentation for any purpose, provided that the
 * above copyright notice and the following two paragraphs appear in
 * all copies of this software.
 *
 * IN NO EVENT SHALL THE UNIVERSITY OF GRONINGEN BE LIABLE TO ANY PARTY FOR
 * DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT
 * OF THE USE OF THIS SOFTWARE AND ITS DOCUMENTATION, EVEN IF THE UNIVERSITY OF
 * GRONINGEN HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * THE UNIVERSITY OF GRONINGEN SPECIFICALLY DISCLAIMS ANY WARRANTIES,
 * INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
 * ON AN "AS IS" BASIS, AND THE UNIVERSITY OF GRONINGEN HAS NO OBLIGATION TO
 * PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.
 */

What do you need?
-----------------

In order to use this package you need:              INCLUDED?    FREE?    NECC?

1. Sicstus Prolog 2.1 (>= p8) from SICS in Sweden       -          -        +   
(Quintus might work too..)
2. v. Noord's library                                   +          +        +
   which in turn requires:
3. J. Ousterhout's Tcl/Tk                               -          +        +  1)
4. M.Meier's Prolog -- TK/TCL interface: ProTcl         +          +        +  1)
5. Sven Delmas' TkSteal package                         -          +        -  2)
6. Sven Delmas' FSBox.tcl                               +          +        +
7. dctree & Treemaker (only needed if you want
   trees printed via Latex ). From Univ.
   of Paderborn,  daniel@uni-paderborn.de               -          -        -  3)
8. matrix.sty                                           +          +        -  4)
9. documentation                                        -          +        +  :-)


notes:
1) Tcl/Tk and ProTcl are necc. if you want to use X-windows. At the cost at
   large reduction in functionality you can also use the hdrug without this..
2) Only if you want the Prolog stdin/stdout window to appear as a subwidget of
   the Tk widget. It looks nice, but is not strictly neccessary.
3) Only for Latex/Xdvi output of trees (Tk output of trees works without this)
4) Only for Latex/Xdvi output of feature-structures (Prolog output of feature
   structures works without this, Tk output of feature structures is not 
   implemented yet).

The program has been tested for HP-UX 9000/710 730 and Linux (1.0). 
As long as you manage to get ProTcl to work, you should be all set 
(maybe except for some minor problems that I don't yet foresee). Note
that both on HPUX and Linux I did not manage to get ProTcl to work well
if I used dynamic loading of the c code (note that Sicstus makes you believe
that dynamic loading should work on these machines). It does however work 
smoothly if I load the ProTcl c-code statically. I have included a small
directory with a Makefile that makes this easier. It is also explained -
of course - in the Sicstus manual.

How to install?
---------------

To install, you should have installed seperately:
- tk
- protcl
- tksteal
- fsbox (in tk library, should be auto-loadable)
- dctree, treemaker, matrix.sty (should be in a directory that
Latex can find)

Note that I have included a way to compile ProTcl statically into Sicstus.
Ordinary dynamic loading did not work for both HP-UX and LINUX. If you want
to build a static version, cf. directory Static. The included ProTcl is only
minimally different to the version as released by M.Meier, cf. the file 
ProTcl/README.GJ

To install this package itself, edit the Makefile for appropriate
paths etc, then do
	make
	make install
This should be it!

This builds a number of commands, that are actually very simple shell-scripts.
Each of these start TkHdrug + one of the example grammars that are provided.

The commands optionally takes the argument `tksteal'. This entails that the
prolog input/output is `inside' the main window.

The commands optionally takes the argument `notk'. This calls the saved-state
/ script loading the exmaple grammar, but it does not yet start the menu
ssytem. Type x. if you want to start it anyway. 


What example grammars/parsers/generators are provided?
------------------------------------------------------

Currently the following scripts are built:
TL : HPSG grammar for Dutch using delayed evaluation techniques to implement recursive
     lexical rules (directory LexRules). Cf. the paper by G. van Noord for Coling 1994.

	@misc{coling94,
	author = "Gertjan van Noord and Gosse Bouma",
	title = "Adjuncts and the Processing of Lexical Rules",
	year = "1994",
	note = "accepted for Coling 94"
	}

TT : Small Tree Adjoining Grammar + 9 related head-corner parsing algorithms for
     headed TAG's (based on a paper by G. van Noord to appear in Computational
     Intelligence).

	@misc{vannoord-tag,
	author = "Gertjan van Noord",
	title = "Head Corner Parsing for TAG",
	year = "1993",
	note = "accepted for Computational Intelligence"
	}

TG : Small DCG for Dutch, originally used as illustration for semantic-head-driven
     generation. Furthermore, some of the parsers were used for the timings of
     the paper co-authored with G. Bouma on the potential efficiency of head-driven
     parsing.

	@incollection{gen-book,
	author = "Gertjan van Noord",
	title = "An overview of head-driven bottom-up generation",
	booktitle = "Current Research in Natural Language Generation",
	editor = "Robert Dale and Chris Mellish and Michael Zock",
	year = "1990",
	publisher = "Academic Press"
	}

	@inproceedings{bouma-gertjan,
	author = "Gosse Bouma and Gertjan van Noord",
	title = "Head-driven Parsing for Lexicalist Grammars: Experimental Results",
	year = "1993",
	booktitle = eacl93,
	address = "Utrecht"
	}

TC : Constraint-based Categorial Grammar for English written by G.Bouma, slightly
adopted by G. van Noord for TkHdrug. Cf. the paper in ACL 94:

	@misc{acl94,
	author = "Gosse Bouma and Gertjan van Noord",
	title = "Constraint-based Categorial Grammar",
	year = "1994",
	note = "Accepted for ACL 94"
	}

TD: The smallest possible DCG. Illustration what you need to do minimally
to adapt a grammar / parser to TkHdrug.

TX: Extraposition grammar based on the paper by Pereira. Can also be used to
find out what you need to do to include a grammar into TkHdrug.

	@article{xgs,
	author = "Fernando C.N. Pereira",
	year = "1981",
	title = "Extraposition Grammars",
	journal = cl,
	volume = "7",
	number = "4"
	}

