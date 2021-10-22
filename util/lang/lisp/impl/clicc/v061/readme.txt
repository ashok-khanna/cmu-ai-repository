---------------------------------------------------------------------
 Copyright (C) 1993 Christian-Albrechts-Universitaet zu Kiel, Germany
---------------------------------------------------------------------
 Projekt  : APPLY - A Practicable And Portable Lisp Implementation
            ------------------------------------------------------
 Funktion : README for CLiCC

 $Revision: 1.3 $
 $Id: README,v 1.3 1993/07/30 11:19:00 wg Exp $
------------------------------------------------------------------

 CLiCC is a Common Lisp to C Compiler.  It generates C-executables 
 from Common Lisp application programs. CLiCC is not a Common Lisp 
 system.  Hence it does  not  include any  program  development or 
 debugging support.  CLiCC is intended to  be used as an  addon to 
 existing Common Lisp systems for generating portable applications.
 
 CLiCC supports a subset of Common Lisp + CLOS, which we call CL_0
 (CommonLisp_0).  CL_0  is a strict and very large  subset of full
 Common Lisp + CLOS, without  (EVAL ...) and friends.  At present,
 CL_0 is based on CLtL1,  but  we  are  working towards  CLtL2 and
 ANSI-CL.
 
 The target language is a subset of C. CLiCC is adaptable to gene-
 rate ANSI-C or K&R-C by using a compiler option.  The generated C 
 code is compilable using  a conventional C compiler on the target 
 machine,  and must be  linked with the  CLiCC runtime library  in
 order to generate executables. 
 
 -----------------------------------------------------------------
 
           CLiCC is available via anonymous ftp from
 
           ftp.informatik.uni-kiel.de  (134.245.15.113) 
           file: kiel/apply/clicc-0.6.1.tar.Z
 
 -----------------------------------------------------------------
 
 See at the file COPYRIGHT for copyright and  warranty conditions.
 The file INSTALL describes the installation of CLiCC and the file
 src/compiler/README describes the usage of the compiler.
 
 Look into the directory doc for papers about CL_0,  the generated 
 C code, the used intermediate representation of programs, and the
 migration of Common Lisp programs to CL_0.
 
 If you have any problems using CLiCC, please contact us. You will 
 find our  e-mail  and  mail  addresses below.  Any suggestions or 
 ideas to improve  CLiCC  are welcome.  We are very interested  in
 hearing about you, even if you just used CLiCC successfully.
 
 -----------------------------------------------------------------
 
            Wolfgang Goerigk, wg@informatik.uni-kiel.de
            Ulrich Hoffman, uho@informatik.uni-kiel.de
            Heinz Knutzen, hk@informatik.uni-kiel.de
 
 
              Christian-Albrechts-Universitaet zu Kiel, 
         Institut fuer Informatik und Praktische Mathematik
                         Preusserstr. 1-9
                      D-24105 Kiel, Germany
 
 -----------------------------------------------------------------
 
  (*) This work was supported by the German Federal Ministry for
  Research and Technology (BMFT) within the joint project APPLY.

