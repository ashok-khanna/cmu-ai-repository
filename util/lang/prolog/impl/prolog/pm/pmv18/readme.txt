PM        file : README

    AUTHOR
         IRISA/Universite de Rennes I
           35042 Rennes Cedex - France
         Phone : (33) 99 84 71 00       Fax : (33) 99 38 38 32

    This software has been designed and programmed by P Brisset & O Ridoux
    at IRISA. For further information or comments, email to: pm@irisa.fr
    or write to:
       IRISA, Campus Universitaire de Beaulieu,
       35042 RENNES Cedex, FRANCE

    COPYRIGHT
         Both this software name PM and its documentation are

             Copyrighted 1992 by IRISA /Universite de Rennes I - France,
                        all rights reserved.

         Permission is granted to copy, use, and distribute
         for any commercial or noncommercial purpose under the terms
         of the GNU General Public license, version 2, June 1991
         (see file : Licensing).

         NOTE :
         This software has not been endorsed by the Free Software Foundation,
         ( 675 Mass Ave, Cambridge, MA 02139, USA ),
         the creator of the GNU license,
         and IRISA is NOT affiliated with that organization.


WHAT IS PM :

              PM is a compiler for the logic programming language LambdaProlog
              which is an extension of standard Prolog where terms are simply
              typed lambda-terms.
              Possible applications are those of standard Prolog, with a real
              plus for those where scoping of variables is important, e.g.
              theorem-proving, implementation of type systems, formal
              transformation on structured programs ...


PROGRAM HISTORY AND CREDITS :

              LambdaProlog, a logic programming language defined by Miller,
              is an extension of Prolog where terms are simply typed
              lambda-terms and clauses are higher order hereditary Harrop
              formulas. The main novelties are universal quantification on
              goals and implication.  

              For a detailed presentation of LambdaProlog, see :
               . Miller D.A. and Nadathur G. "Higher-roder logic programming",
              3rd International Conference on Logic Programming, pp 448-462,
              London 1986.
               . Nadathur G. "A Higher-Order Logic as a Basis for Logic
              Programming", Thesis, University of Pennsylvania, 1987.

              The system is a compiler (written in Prolog/Mali) which produces
              C code.  The execution scheme uses Mali (an abstract memory for
              representing terms with efficient space management).

              For a detailed presentation of our compiler, see :
               . Brisset P. "Compilation de LambdaProlog", Thesis, Rennes I,
              mars 92.
               . Ridoux O., Brisset P. "The compilation of LambdaProlog with
		Mali",
              Research Report, IRISA/INRIA, to appear.
               . Ridoux O. and Brisset P. "Naive reverse can be linear", 8th
              International Conference on Logic Programming, Paris 1992.
              

AFFILIATION OF AUTHORS :

Institut de Recherche en Informatique et Systemes Aleatoires
IRISA, Campus Universitaire de Beaulieu, 35042 RENNES Cedex, FRANCE
Tlx: Unirisa 950 473 F, Fax: (33) 99 38 38 32, Tel: (33) 99 84 71 00


Institut National de Recherche en Informatique et Automatique
INRIA, Domaine de Voluceau-Rocquencourt, BP 105, 78153 LE CHESNAY Cedex, FRANCE
Tlx: 697 033 F, Fax: (33) (1) 39 63 53 30, Tel: (33) (1) 39 63 55 11


HOW TO USE IT ?

A short user's manual is included in the delivery. It is in the DVI
file called "smalldoc.dvi" (in man directory).

A more complete manual is delivered in the separate file 
"draft_manual.ps.Z".

IMPORTANT REQUIREMENT :

As PM uses the MALI-V06 abstract memory, it is necessary in order to compile
PM, to compile MALI first. MALI is also available by anonymous ftp on host
"ftp.irisa.fr" in directory "local/maliv06".


CONTENTS

README    : this file
LICENSING : GNU general public license, Vers. 2, June 91. A listing
            of it is enclosed in an annex to this document.
draft_manual.ps.Z : a compressed PostScript file containing the user (draft)
                    manual.
pm.tar.Z  : a compressed archive containing the compiler, its libraries,
	    a short manual and some examples.
            After uncompressing and untaring pm.tar.Z, you'll find the 
            directory pm containing sources (C, PM) and a Makefile for 
            installing the compiler. In this directory, a 'make' command 
            will guide you in the installation of the system.
pm_sparc.tar.Z : a compressed archive containing a precompiled version for 
                 sparc machines of Prolog/Mali.
xdbg_sparc.tar.Z : a compressed archive containing a precompiled version for 
                   sparc machines of a windowed tracing environment for 
                   Prolog/Mali.
INRIA_RR_1831_93.ps.Z and iclp93.ps.Z : compressed PostScript files containing
            reports and paper on our work on LambdaProlog.

HOW TO KEEP IN TOUCH ?

If you have any trouble with PM or if you want to share your
experience with PM, please send your remarks to the mailing list
"prolog-mali@irisa.fr".  If you wish to be on this list, please send
mail to "prolog-mali-request@irisa.fr".


DISCLAIMER

PM COMES WITH ABSOLUTELY NO WARRANTY.
THESE FILES ARE PROVIDED FOR YOUR PLEASURE ONLY.
USE AT YOUR OWN RISK.
