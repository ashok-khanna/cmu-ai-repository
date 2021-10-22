 Copyright (C) 1991 AG Siekmann, 
                      Fachbereich Informatik, Universitaet des Saarlandes, 
                      Saarbruecken, Germany

This file is part of Markgraf Karl Refutation Procedure (MKRP).

MKRP is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY.  No author or distributor
accepts responsibility to anyone for the consequences of using it
or for whether it serves any particular purpose or works at all,
unless he says so in writing.  

Everyone is granted permission to copy, modify and redistribute
MKRP, but only if the it is not used for military purposes or any
military research. It is also forbidden to use MKRP in nuclear plants
or nuclear research, and for verifying programs in military 
and nuclear research.  A copy of this license is
supposed to have been given to you along with MKRP so you
can know your rights and responsibilities.  
Among other things, the copyright notice
must be preserved on all copies.

This directory contains the source code for the Markgraf Karl Refutation
Procedure.  

MKRP is known to run in Lucid Common Lisp (4.0) and on Symbolics Lisp
machines.  It has also run in Kyoto Common Lisp, Coral Common Lisp and
POPLOG.

Note that this version of MKRP will not be able to use the sorted logic
package (that requires a different Lisp environment).

FILES in this Directory:
  mkrp.tar.Z: tar'd and compressed version of the source code itself.  This
              uncompressed will take about 5MB disk space.
  manual.tar.Z: tar'd and compressed version of the MKRP manual.  You need
                LaTeX to make the manual.  This uses about 750KB disk space.
  examples.tar.Z: tar'd and compressed example files.  These take up 20MB
                  of disk space.

RETRIEVING a copy:
 Make a local directory where you will put MKRP.  For example,
 % mkdir /usr/mkrp
 % cd /usr/mkrp
 % ftp js-sfbsun.cs.uni-sb.de
 login as user anonymous, and with your mailing address as password.  
 Then use the following commands:
 ftp> cd pub/mkrp
 ftp> binary
 ftp> get README
 ftp> get mkrp.tar.Z
 ftp> get manual.tar.Z
 ftp> get examples.tar.Z
 ftp> quit
 You definitely need mkrp.tar.Z.  manual.tar.Z and examples.tar.Z are
 optional.

BUILDING mkrp:
 % zcat mkrp.tar.Z | tar xvpf -
 This will create the subdirectories prog and sys.
 To create the manual and examples subdirectories, type (resp.)
 % zcat manuals.tar.Z | tar xvpf -
 % zcat examples.tar.Z | tar xvpf -

Now start your lisp, e.g.:
 % cl
 (load "sys/cl-boot")
 (in-package "MKRP")
 (mkrp-boot)
 ; here type 4 and return
 ; next type Y or N and return depending on if you want to save a 
 ; copy of the 
 ; files will be loaded and compiled
 ; when that is finished, you can save a core dump of mkrp with the name
 ; of "mkrp" by typing
 (mkrp-dumper)

Thereafter you will be able to run MKRP by simply typing
 % /usr/mkrp/mkrp

Making a manual:
 Assuming that you have retrieved and uncompressed manual.tar.Z
 % cd /usr/mkrp/manual
 % latex rahmen
 % bibtex rahmen
 % ./makeindex
 % latex rahmen
 That should make a rahmen.dvi file for you to view or print.

NOTE:  MKRP is not actively supported, but if you have comments or suggestions
please send them to mkrp@cs.uni-sb.de.  We can't, however, promise any
bug fixes.

Our mailing address:
 Prof. Joerg Siekmann
 Fachbereich Informatik
 Uni. des Saarlandes
 W-6600 Saarbruecken 11
 Germany

