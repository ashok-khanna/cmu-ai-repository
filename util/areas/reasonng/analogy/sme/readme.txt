The full SME user's guide may be found in users-guide.tex

To configure SME to your site, a handful of variables storing
system directory information must be edited and set to the appropriate
values. These variables appear in config.lisp, a separate file for
this purpose.

In most Common Lisp implementations, one package exists for general user
definitions and another exists for the lisp implementation. It is important
to notify SME what these are for the Common Lisp in use. For example, on a
Symbolics, the lisp package (*the-lisp-package*) is called "lisp" and the
user package (*the-user-package*) is called "user". These are the default
settings.

Description groups, the core input to SME, are generally stored in files
with a "dgroup" extension. Some samples from the SME papers are provided.

Rules files, which control the mapping operation of SME, are generally
stored in files with a "rules" extension. Some samples are provided.

If you have any questions at all, please feel free to contact Brian
Falkenhainer: falkenhainer@parc.xerox.com or (415) 494-4706.

============================================================

Addendum: 3/11/91: This directory contains a version which
has been slightly augmented and specialized for Mac II's running Allegro
Common Lisp.  In addition to the normal SME procedures, a character-oriented
menu system is included which simplifies running SME somewhat.  It will be
loaded as a default part of the system.  To access it, type (sme::toplevel).
Typing "q" quits a level, "?" gets help, "0" repeats options.  (Yes, it is
very unMacintosh.  However, it runs on ANY Common Lisp without changes.)
The file charsme.lisp also has some other useful utilities for inspecting
descriptions and matches. 


Some code which I've used for simple match displays on IBM RT's is also
included.  This has not been Macified.  If anyone wants to build a snappier
interface and inspection facility for the Mac, Dedre or I would be happy to
kibbitz.

             Ken Forbus

             forbus@ils.nwu.edu
             voice: (708) 491-7699 
