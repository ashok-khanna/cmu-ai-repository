%****************************************************************************
%
% NAME MALIv06                        file : README
%
%     AUTHOR
%          INRIA, Domaine de Voluceau-Rocquencourt, BP 105, 78153 LE CHESNAY Cedex, FRANCE
%          Tlx: 697 033 F, Fax: (33) (1) 39 63 53 30, Phone: (33) (1) 39 63 55 11
%
%          This software has been designed and programmed by Olivier Ridoux 
%          at IRISA.  For further information or comments, e-mail to
%          maliv06@irisa.fr
%          or write to
%          IRISA, Campus Universitaire de Beaulieu, 35042 RENNES Cedex, FRANCE
%          Tlx: Unirisa 950 473 F, Fax: (33) 99 38 38 32, Phone: (33) 99 84 71 00
%
%     COPYRIGHT
%          Both this software, named MALIv06, and its documentation are
%
%              Copyrighted 1992 by INRIA, all rights reserved.
%
%          Permission is granted to copy, use, and distribute
%          for any commercial or noncommercial purpose under the terms
%          of the GNU General Public license, version 2, June 1991
%          (see file : LICENSING).
%
%          NOTE :
%          This software has not been endorsed by the Free Software Foundation,
%          ( 675 Mass Ave, Cambridge, MA 02139, USA ),
%          the creator of the GNU license,
%          and neither IRISA nor INRIA are affiliated with that organization.
%**************************************************************************/


W H A T   I S   M A L I V 0 6 ?

MALI (M\'{e}moire Adapt\'{e}e aux Langages Ind\'{e}terministes) is an
abstract memory which provides an efficient management of data types
useful for implementing logic programming systems.  MALIv06 is a
software implementation of the abstract memory.

MALI's memory management principles have been reported in several
places (see references in the tutorial contained in the delivery).
The idea is to control the representation of the fundamental features
of logic programming systems (search and logical variable) in order to
insure an efficient memory management.  An implementation of MALI
(e.g. MALIv06) comprizes a memory manager obeying the principles
described in the tutorial and a representation manager for the data
types provided for encoding search-states and logical variables.

MALIv06's data types and operations have been designed to be well
suited for implementing compiled logic programming systems.  Its
memory management is sequential, non-real-time.  MALIv06 is
implemented in C and provides a set of declarations and definitions
usable in C programs.


P R O G R A M   H I S T O R Y   A N D   C R E D I T S 

MALI's principles are due to Yves Bekkers, Bernard Canet, Olivier
Ridoux, and Lucien Ungaro.

First versions up to MALIv04 were defined and written from 1986 to
1989 by Bernard Canet.  Versions MALIv05 and MALIv06 were defined and
written from 1989 to 1991 by Olivier Ridoux.  See references in the
tutorial.

The program is registered by APP ("Agence pour la Protection des
Programmes") under number 87-12-005-01.


A F F I L I A T I O N   O F   A U T H O R S 

Institut de Recherche en Informatique et Systemes Aleatoires

IRISA, Campus Universitaire de Beaulieu, 35042 RENNES Cedex, FRANCE

Tlx: Unirisa 950 473 F, Fax: (33) 99 38 38 32, Tel: (33) 99 84 71 00


Institut National de Recherche en Informatique et Automatique

INRIA, Domaine de Voluceau-Rocquencourt, BP 105, 78153 LE CHESNAY Cedex, FRANCE

Tlx: 697 033 F, Fax: (33) (1) 39 63 53 30, Tel: (33) (1) 39 63 55 11


O T H E R   O R G A N I S A T I O N S 

Agence pour la Protection des Programmes

APP, 119 rue de Flandre, 75019 PARIS, FRANCE

Fax: (33) (1) 40 38 96 43, Tel: (33) (1) 40 35 03 03


H O W   T O   U S E   I T ?

A reference manual and tutorial is included in the delivery.  It is in
the DVI file called "mali.dvi".


C O N T E N T S 

LICENSING : GNU general public license, Vers. 2, June 91

README : This file.

mali.descr : A description file for machine-dependent compilation.
Update it to match your environment.

mali.dvi.Z : A tutorial and reference manual in compressed DVI format.

source.tar.Z : A compressed and tarred directory containing the source
files of MALIv06.

tools.tar.Z : A compressed and tarred directory containing tools.

Makefile : A script for installing MALIv06.  Copy the 7 files and
directories in a directory and issue command "make install" in this
directory.  The script will produce in this directory files "mali.h"
(a definition file to be included in every application file using
MALIv06), "mali.o" (a library file to be linked with every application
using MALIv06), and "Dmali.o" (a library file to be used in place of
"mali.o" for debugging purpose).

For some architectures <arch> the generation of "mali.h", "mali.o" and
"Dmali.o" is already done.  Fetch them in subdirectories
"ready_made/<arch>" after having issued "make install" or 
"make fetch".  The latter is the faster.  After having issued 
"make fetch", do not issue "make install".  Use "make mali" and 
"make Dmali" instead.

In short,

INSTALLATION = ("make install" | "make fetch") ("make mali" | "make Dmali")*


H O W   T O   G E T   T H E   F I L E S ?

To get information on ftp      man ftp

Connect to                     ftp.irisa.fr (131.254.254.2)
Enter login name               ftp                        (or anonymous)
Enter password                 <your e-mail address>
Select proper directory        cd maliv06
Get the files                  get ...
Select proper architecture     cd <arch>                  (<arch> is the name of
                                                           an architecture)
Get the files                  get ...


H O W   T O   K E E P   I N   T O U C H ?

A mailing list named "maliv06@irisa.fr" has been created.  
Send any request to "maliv06-request@irisa.fr".


