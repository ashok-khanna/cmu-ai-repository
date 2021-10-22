This is the README file of the COLAB system.

The COmpilation LABoratory (COLAB) is a piece of research software
(read the COPYRIGHT NOTICES).

It is a hybrid knowledge representation system emphasizing the
horizontal and vertical compilation of knowledge bases. It has been
designed as a COmpilation LABoratory aiming at a synergetic
collaboration of different knowledge representation and reasoning
formalisms.  It is comprised of subsystems dealing with different kinds
of knowledge and that can also be used as stand-alone systems.  The
COLAB representation architecture splits into two main parts, an
affirmative part, sometimes also called `assertional', and a taxonomic
part.

The affirmative part provides efficient reasoning with different kinds
of relational or functional knowledge using tailored inference
engines.  For affirmative knowledge represented as constraint nets
COLAB supplies constraint propagation techniques (CONTAX). Relational
knowledge in the form of Horn rules is processed by forward (FORWARD)
and backward (RELFUN) chaining.  The backward component is also suited
for expressing (non-deterministic) functional dependencies.  Taxonomic
knowledge is represented by intensional concept definitions which are
automatically arranged in a subsumption hierarchy (TAXON).  Dynamic
cooperation of the subsystems is organized through access primitives
providing an interface to the respective reasoning services.

The COLAB software, developed at DFKI and the University of
Kaiserslautern, is now available for experimental use.  On the basis of
COMMON LISP.

Address for ordering the entire COLAB system:
Dr. Harold Boley
DFKI
Postfach 2080
W-6750 Kaiserslautern
Germany
Phone: +49-631-205-3459
Fax:   +49-631-205-3210
Email: boley@informatik.uni-kl.de


			INSTALLATION GUIDE
			==================

1) Read the copyright notices.

2) You should have the file colab.tar.Z 

3) Execute
	uncompress colab.tar.Z
	tar xf colab.tar
   to generate the directory-tree colab in your current working
   directoy.

4) Edit the file colab/colab-init.lisp and replace XXXX by the absolute
   pathname of the colab directory.

5) Start your LISP system and load the file colab/colab-init.lisp
   
6) Execute the LISP-function (compile-colab)
   This will first load all subsystem and will then compile them.

7) Leave your LISP system.

8) Start your LISP system and load the file colab/colab-init.lisp
   Execute (colab). You should see the prompt
       colab>
   of the COLAB toplevel. For Documentation of COLAB and its subsystems
   refer to the directories colab/*/docu/* (in particular, the ps files
   colab/*/docu/manual/*).
   For sample knowledge bases and scripts of sessions you are referred
   to colab/*/demo/  .
   Files with the suffix .script are scripts of sample sessions.
   Files ending with .bat are batch files to be executed through the
   COLAB toplevel..

9) Next time you want to start COLAB you just need step (8)




----------------------------COPYRIGHT NOTICES---------------------------
COLAB is a protoypical knowledge-representation and compilation lab.
COLAB is a piece of research software.

Address for ordering the entire COLAB system:
Dr. Harold Boley
DFKI
Postfach 2080
W-6750 Kaiserslautern
Germany
Phone: +49-631-205-3459
Fax:   +49-631-205-3210
Email: boley@informatik.uni-kl.de

For documentation and samples see the directories colab/*/doc and colab/*/demo .

The COLAB software is subject to the following general copyright notice:

;;; Copyright Notice
;;;
;;; This software is distributed for non-profit and research purposes only.
;;; Non-profit redistribution of the current version or parts of the
;;; current version is permitted if this copyright notice is included unchanged.
;;; There is no warranty of any kind for this prototype. It will be further
;;; improved as time permits.


The RELFUN system located in colab/New-RFM and colab/RFM is subject to the following copyright notice

;;; Copyright Notice
;;;
;;; This software is distributed for non-profit and research purposes only.
;;; I retain the exclusive right of producing a commercial version from it.
;;; Non-profit redistribution of the current version or parts of the
;;; current version is permitted if this copyright notice is included
;;; unchanged.  I give no warranty of any kind for this prototype. It will be
;;; further improved as time permits.
;;;
;;; Copyright (c) 1985-1992 by Harold Boley


The following is the copyright notice for GAMA, located at colab/RFM/gama/:

;;; GAMA - a general abstract machine assembler
;;; (including the GWAM, a port of the NyWAM)
:::
;;; Copyright Notice
;;;
;;; This software is distributed for non-profit and research purposes only.
;;; I retain the exclusive right of producing a commercial version from it.
;;; Non-profit redistribution of the current version or parts of the
;;; current version is permitted if this copyright notice is included
;;; unchanged.  I give no warranty of any kind for this prototype. It will be
;;; further improved as time permits.
;;;
;;; Copyright (c) 1992 by Michael Sintek


The following is the copyright notice for the indexing concept and
algorithms used in colab/RFM/index:

;;; Copyright Notice
;;;
;;; This software is distributed for non-profit and research purposes only.
;;; I retain the exclusive right of producing a commercial version from it.
;;; Non-profit redistribution of the current version or parts of the
;;; current version is permitted if this copyright notice is included
;;; unchanged.  I give no warranty of any kind for this prototype. It will be
;;; further improved as time permits.
;;;
;;; Copyright (c) 1991/1992 by Michael Sintek and Werner Stein


The following is the copyright notice for the files lisp2pro.lisp
and pro2lisp.lisp:

;;; Copyright Notice
;;;
;;; This software is distributed for non-profit and research purposes only.
;;; Non-profit redistribution of the current version or parts of the
;;; current version is permitted if this copyright notice is included unchanged.
;;; I give no warranty of any kind for this prototype. It will be further
;;; improved as time permits.  
;;;
;;; Michael Herfert, 1992
 

The following is the copyright notice for the NyWAM, of which parts were
used in the program colab/RFM/gama/gwam:

; NyWAM
; A WAM emulator  Common Lisp
;
; Author: Sven-Olof Nystroem
; Summer 1985 and May 1989
;
; Copyright (c) May 1989 by Sven-Olof Nystroem and Uppsala University.
; Permission to copy all or part of this material is granted, provided that
; the copies are not made or redistributed for resale, and that the copyright
; notice and reference to the source file appear.


The software in colab/top/defsystem.lisp is subject to the following
copyright notice:

;;; DEFSYSTEM Utility
;;;
;;; Copyright (c) 1986 Regents of the University of California
;;; 
;;; Permission to use, copy, modify, and distribute this software and its
;;; documentation for any purpose and without fee is hereby granted,
;;; provided that the above copyright notice appear in all copies and
;;; that both that copyright notice and this permission notice appear in
;;; supporting documentation, and that the name of the University of
;;; California not be used in advertising or publicity pertaining to
;;; distribution of the software without specific, written prior
;;; permission.  The University of California makes no representations
;;; about the suitability of this software for any purpose.  It is
;;; provided "as is" without express or implied warranty.
;;; 

The psgrapher in colab/taxon/front-end/psgraph.lisp is subject to the
following notices:

(from psgraph.lisp)

    ;;; ****************************************************************
    ;;; PostScript DAG Grapher *****************************************
    ;;; ****************************************************************
    ;;; Written by Joseph Bates, CMU CSD, March 1988. jbates+@cs.cmu.edu
    ;;;
    ;;; The PSGrapher is a set of Lisp routines that can be called to produce
    ;;; PostScript commands that display a directed acyclic graph.
    ;;;

and (from psgraph.doc)

    Here is a brief summary of how to use the PSgrapher.

    The PSgrapher is a set of Lisp routines that can be called to
    produce Postscript commands to display a directed acyclic graph.
    It uses the same basic algorithm as the ISI Grapher.  It is slower
    than the ISI grapher, but produces much prettier output than using
    Xdump to copy an ISI Grapher screen image to a Postscript printer.
    It also allows arbitrary information to be displayed with a node,
    and can print as many output pages as are necessary to accomodate
    large graphs (subject to Postscript printer limits, typically one
    or two thousand nodes).

    The PSgrapher is small enough and easy enough to use to be included
    in other systems without pain.  It is also free and not
    copyrighted.

    ...	

