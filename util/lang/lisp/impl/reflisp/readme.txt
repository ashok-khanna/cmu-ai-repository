;;; ****************************************************************
;;; RefLisp ********************************************************
;;; ****************************************************************

RefLisp is a small Lisp interpreter written by Bill Birch. Versions
exist for MS-DOS and UNIX (AIX). The MS-DOS version supports
CGA/EGA/VGA graphics and the Microsoft Mouse.  The interpreter is a
shallow-binding, reference counting design making it suitable for
experimenting with real-time and graphic user interface programming.
Common Lisp compatibility macros are provided, and most of the
examples in "Lisp" by Winston & Horn have been run on RefLisp.
RefLisp comes with an ASCII manual and many demonstration programs,
including an analogue clock which never stops for garbage collection.
It is written in ANSI C and is in the public domain.

This copy of the distribution was obtained from the Lisp Utilities
Repository by anonymous ftp from ftp.cs.cmu.edu in the directory
   user/ai/lang/lisp/impl/reflisp/
as the files reflisp1_3, reflisp2_3, reflisp3_3 and reflisp_README.

   reflisp1_3 is a shar file containing the C source files and documentation
   reflisp2_3 is a shar file containing demo lisp programs
   reflisp3_3 is a uuencoded file containing a MS-DOS binary executable

For further information, contact the author by writing to Peter
William Birch, 23 Marlins Turn, Gadebridge, Hemel Hempstead, HP1 3LQ,
Great Britian, calling +44 442 230 654, or sending email to
B.Birch@uk03.bull.co.uk.

Version 2.67 of RefLisp will be the last version for some time, as the
author is emigrating to Australia, and will be off the Internet for
the immediate future. This version of RefLisp cures several memory
leakage bugs, and fixes bugs introduced along with DEFCONSTANT. In
addition there are Lisp modules for lexical scope and for running
indefinite extent Scheme programs. There is also a program profiler.


;;; *EOF*
