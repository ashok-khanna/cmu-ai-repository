
The Meta Class System (MCS) is a portable object-oriented extension
of Common Lisp. MCS is highly efficient and integrates the
functionality of CLOS, the Common Lisp Object System, and TELOS, the
object system of LeLisp Version 16 and EULISP. Additionally, MCS
provides a metaobject protocol which the user can specialize.

MCS has been used successfully for the development of the commercial
software product babylon: an expert system development workbench
including a hybrid knowledge representation language and many tools
like editors, browsers, etc. Based on experiences made with building
such a large and complex software system, MCS has been improved on
abstract classes and mixin classes to support a better style of
object-oriented modelling. Furthermore, these improvements allow
significant internal optimizations.

The sources and documentation of MCS are available as freeware via
anonymous FTP from host ftp.gmd.de (IP address: 129.26.8.90) in
the directory /pub/lisp/mcs .

----------------------------------------------------------------------

This directory contains the following files and directories:

doc.dvi.Z
contains the compressed dvi file of the documentation of the
Meta Class System (MCS).


mcs1.3
is a directory and contains the MCS sources.

mcs1.3.tar.Z
is the compressed tar file archive of the MCS sources.
First, perform  'uncompress v1.3.tar.Z'  and then
'tar xf v1.3.tar'  to extract the files. 

mcs1.3.sit.hqx
is a Macintosh archive of the MCS sources. You need BinHex
and StuffIt to extract the files.


The same files may exist for new versions of MCS.


The MCS Sources have the following structure:
mcs/
mcs/source/
mcs/source/access-m.lisp
mcs/source/cl-boot.lisp
mcs/source/cl-core.lisp
mcs/source/class-m.lisp
mcs/source/gfn-boot.lisp
mcs/source/gfn-comp.lisp
mcs/source/gfn-core.lisp
mcs/source/gfn-look.lisp
mcs/source/globals.lisp
mcs/source/low-it.lisp
mcs/source/low.lisp
mcs/source/macros.lisp
mcs/source/mcs.lisp
mcs/source/mcsmenus.lisp
mcs/source/optimize.lisp
mcs/source/patches.lisp
mcs/source/redefine.lisp
mcs/source/slot-val.lisp
mcs/source/system-m.lisp
mcs/source/util.lisp
mcs/README
mcs/binary/

If you use MCS send me a short email. So you will be notified
when updates are available.
Comments, bug reports, etc. are welcome.

----------------------------------------------------------
Juergen Kopp                    email: juergen.kopp@gmd.de
German National Research Center for Computer Science (GMD)
P.O. Box 1316       D-5205 Sankt Augustin 1        Germany
----------------------------------------------------------
