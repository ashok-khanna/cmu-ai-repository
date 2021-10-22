#*---------------------------------------------------------------------*/
#*    Copyright (c) 1994 by Manuel Serrano. All rights reserved.       */
#*                                                                     */
#*                                     ,--^,                           */
#*                               _ ___/ /|/                            */
#*                           ,;'( )__, ) '                             */
#*                          ;;  //   L__.                              */
#*                          '   \    /  '                              */
#*                               ^   ^                                 */
#*                                                                     */
#*                                                                     */
#*    This program is distributed in the hope that it will be useful.  */
#*    Use and copying of this software and preparation of derivative   */
#*    works based upon this software are permitted, so long as the     */
#*    following conditions are met:                                    */
#*           o credit to the authors is acknowledged following current */
#*             academic behaviour                                      */
#*           o no fees or compensation are charged for use, copies, or */
#*             access to this software                                 */
#*           o this copyright notice is included intact.               */
#*      This software is made available AS IS, and no warranty is made */
#*      about the software or its performance.                         */
#*                                                                     */
#*      Bug descriptions, use reports, comments or suggestions are     */
#*      welcome Send them to                                           */
#*        <Manuel.Serrano@inria.fr>                                    */
#*        Manuel Serrano                                               */
#*        INRIA -- Rocquencourt                                        */
#*        Domaine de Voluceau, BP 105                                  */
#*        78153 Le Chesnay Cedex                                       */
#*        France                                                       */
#*---------------------------------------------------------------------*/

This directory contains the source files of Bigloo, a Scheme system
which includes a compiler generating C code and an interpreter. Bigloo
is the tool of choice for the construction of small autonomous applications
in Scheme. Bigloo is conformant to
IEEE Scheme standard with some extensions:
        Rgc, a lex facility ,
        Match, a pattern-matching compiler.
	Foreign languages interface.
	Module language.
	Extension package system.

To install Bigloo, see the INSTALL file.  An ANSI C is required. The
original version has been developped with GNU CC version 2.2.1
(Copyright (C) 1988, 1989, 1992 Free Software Foundation, Inc). The
Bigloo's boot requires 25 MegaBytes of disk space. Ones it is booted,
the Bigloo system can be reduced to 5 MegaBytes.

The compiler distribution consists of several directories:

	bin 		will contain the compiler executable.

	lib		will contain the Bigloo's libraries.

	comptime1.6	contains the sources of the compiler.

	runtime1.6	contains the sources of the runtime system.

	examples	contains several Bigloo's examples.

	recette		contains compiler and runtime test programs.

	documentation	contains the documentation of the Bigloo system.

	etc		contains a emacs-lisp file, an icon for emacs
			and the orignal package of the garbage collector.

	tools		contains severals tools files required for the boot
			of Bigloo.

I thank all the people who helped me while writing Bigloo, specialy
Hans J. Boehm (boehm@parc.xerox.com) who wrote the garbage collector,
Jean-Marie Geffroy (Jean-Marie.Geffroy@inria.fr) who found many bugs and
which written `Match', Christan Queinnec (Christian.Queinnec@inria.fr),
Stephen J Bevan (bevan@computer-science.manchester.ac.uk), Joris Heirbaut
(pheirba@tinf3.vub.ac.be) who ported Bigloo under Solaris,
Drew Whitehouse (Drew.Whitehouse@anu.edu.au) which ported Bigloo
under Iris Indigo, Luc Moreau (moreau@montefiore.ulg.ac.be), Pascal Petit
(petit@litp.ibp.fr), Joel Masset (jmasset@dmi.ens.fr) and Thierry Saura
(Thierry.Saura@inria.fr), Thomas Neumann (tom@smart.bo.open.de) who ported
Bigloo under NeXT and Olaf Burkart (burkart@zeus.informatik.rwth-aachen.de)
for its comments on Bigloo.
