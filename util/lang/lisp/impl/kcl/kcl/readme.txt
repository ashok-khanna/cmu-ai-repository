     Files on the directory cli.com:/pub/kcl/

kcl.faq is a list of frequently asked questions about KCL and AKCL.

README this file.

compress.tar is a tar file for building the compress function that was
used to make kcl.tar.Z.  Included is the uncompress function that
undoes compression.

gabriel.tar.Z contains a version of the benchmarks assembled by Dick
Gabriel.  After uncompressing and untarring, all you need to do is
to invoke, for the <lisp> you want to test:
% make LISP=<lisp>
 except for CMULISP which requires
% make LISP=cmulisp QUIT="(quit)"
The times will be recorded in a file called times.  All files will be
proclaimed, and compiled automatically.  (This automation of running
of the Gabriel test suite was put together by Schelter.)  This set
of benchmarks is great for comparison purposes but not necessarily
for computing "official" Gabriel times; apparently some of the
tests are aggregated in other than the official groupings.

kcl-mail-archive is where all the mail for the KCL mailing list is
stored.  To be added to the list, send a message to
kcl-request@cli.com.

kcl-mailing-list is the list of addresses comprising the KCL Internet
mailing list.  Messages send to kcl@cli.com are forwarded to the names
on this list.  To have a name added (or removed) from this list, send
a note to kcl-request@cli.com.

kcl-report.doc is an on-line readable version the KCL Report.

kcl-report.tex is a LaTeX version of the KCL Report.  Warning: there
are about 600 lines of TeX complaints about over and under-full boxes
produced when this document is LaTeXed.  Ignore these messages.

kcl.broadcast contains current information about obtaining Kyoto Common
Lisp (KCL), including licensing information.

kcl.broadcast.orig is the original message describing how to obtain
KCL by Internet ftp.

kcl.tar.Z is a compressed tar file of KCL.  See kcl.broadcast for
licensing information. checksum info produced by sum for kcl.tar.Z is
00452  1168

kcl.tar.Z-split is a directory containing files of about 200,000
characters each whose conCATenation is kcl.tar.Z.
kcl.tar.Z-split/README contains checksum information to help you find
transmission errors.  See kcl.broadcast for licensing information.
kcl.tar.Z may also be obtained by anonymous ftp from
orville.nas.nasa.gov [128.102.20.2]

loop.lisp is a Common Lisp version of the Maclisp/Zetalisp loop macro.
This is apparently no license for this software, though there is an MIT
copyright.  See the front of the file for details.

sloop.lisp is Bill Schelter's Common Lisp version of the
Maclisp/Zetalisp loop macro.  It's much better than loop because it is
very extensible, just as was the original Interlisp I.S.OPR FOR macro,
the inspiration for loop.  There is no license required to take or use
this file, though there is a copyright (see the head of the file).

split.c is the code that was used to break kcl.tar.Z into the files
found in kcl.tar.Z-split.  A useful piece of software for those
offering large systems for public access.  There are apparently no
copyright or license requirements associated with this file.

