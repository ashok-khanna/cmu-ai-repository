                            clp(FD) version 2.1
                            -------------------




I- Introduction
---------------

clp(FD) is a constraint logic programming language over Finite
Domains. clp(FD) is based on the wamcc Prolog compiler.
wamcc is a Prolog Compiler which translates Prolog to C via the WAM.
wamcc use the (quasi) standard edinbourgh. wamcc offers the most usual
built-in predicates (but not all), a top-level, a Prolog debugger and
a WAM debugger. wamcc is designed to be easily extended (e.g. clp(FD)
is a constraint logic language over Finite Domains designed on wamcc).
From an efficiency point of view, wamcc is between SICStus "emulated"
and SICStus "native code" on Sparc machines (1.5 times faster than SICStus
emulated, 1.5 times slower than SICStus "native code").

The extension to clp(FD) provides several constraints "a la CHIP" on
Finite Domains and some facilities to build new constraints. clp(FD)
is 4 times faster than CHIP on average.



II- Requirements
----------------

clp(FD) requires GNU C compiler (gcc) version 2.4.5 or higher 
        and it is available for Sparc workstations.



III- Installation
-----------------

Create a directory

   % mkdir clp_fd (or anything else)

select it as the current directory

   % cd clp_fd

get the file clp_fd.tar.Z (ftp)
uncompress it

   % zcat clp_fd.tar.Z | tar xvf -

modify the folowing variables in the clp_fd/Makefile

   ex ROOTPATH=/usr/local/lib/clp_fd

eventually the variables INCPATH, LIBPATH and BINPATH

install the compiler

   % make


add to your PATH environment variable (usually in ~/.login) the
directory corresponding to BINPATH (see Makefile) 

   ex: setenv PATH "$PATH":/usr/local/lib/clp_fd/bin


You only need the files contained in INCPATH, LIBPATH and BINPATH.


Problems:

If the installation fails (e.g. with old versions of gcc) you can try
to clean the current installation (make clean) and to reinstall it
after modifying CFLAGS in the src/Makefile as follows:

   CFLAGS = -O2 -DNO_REGS


If you have a problem with a library when compiling a Prolog file
(message like "libwamcc.a: warning: table of contents for archive is
 out of date; rerun ranlib(1)")

use %ranlib LIBPATH/libwamcc.a
and %ranlib LIBPATH/libwamcc_pp.a

(where LIBPATH is defined in the Makefile)




IV- Documentation
-----------------

The directory doc contains a user's manual (LaTeX file).



V- Bugs
-------

Please report (detailled) bugs to diaz@margaux.inria.fr



VI- Ports
---------

clp_fd can be easily ported on other machines. If you want to do this
do not hesitate to contact me (diaz@margaux.inria.fr).




