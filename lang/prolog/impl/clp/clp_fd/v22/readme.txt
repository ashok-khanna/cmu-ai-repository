                            clp(FD) version 2.2
                            -------------------




I- Introduction
---------------

clp(FD) is a constraint logic programming language over Finite
Domains. clp(FD) is based on the wamcc Prolog compiler.
wamcc is a Prolog Compiler which translates Prolog to C via the WAM.
wamcc has a syntax conform to the proposed ISO standard.
wamcc offers the most usual built-in predicates (but not all), a
top-level, a Prolog debugger and a WAM debugger, dynamic and compiled
code, modules, global variables...).
From an efficiency point of view, wamcc is between SICStus "emulated"
and SICStus "native code" on Sparc machines (1.5 times faster than SICStus
emulated, 1.5 times slower than SICStus "native code").

The extension to clp(FD) provides several constraints "a la CHIP" on
Finite Domains and some facilities to build new constraints. clp(FD)
is 4 times faster than CHIP on average.



II- Requirements
----------------

clp_fd reguires the GNU C compiler (gcc) version 2.4.5 or higher and is
available for:

   - Sun Sparc under SunOS (4.3.1)
   - dec ultrix,
   - sony mips (R3000) 
   - PC i386/i486 under linux (many thanks to Bill Hogan).



III- Installation
-----------------

Create a directory

   % mkdir clp_fd (or anything else)

select it as the current directory

   % cd clp_fd

get the file clp_fd2.2.tar.Z (ftp)
uncompress it

   % zcat clp_fd2.2.tar.Z | tar xvf -


The installation procedure first installs clp_fd locally in the path
give by ROOTPATH in Makefile (default: $(HOME)/clp_fd), after it copies
the appropriate files in 3 directories given by 

   INCPATH: includes  for compilations  (default: $(ROOTPATH)/include)
   LIBPATH: libraries for compilations  (default: $(ROOTPATH)/lib) 
   BINPATH: executables (compiler...)   (default: $(ROOTPATH)/bin) 

Only these 3 directories are necessary after the installation.

So modifiy these vairiables if necessary in the Makefile according to
which can of installation you want (if you only want a local
installation for do not modify anything).

   ex: ROOTPATH=/usr/local/lib/clp_fd

or

   ex: ROOTPATH=$(HOME)/prolog
       INCPATH=/usr/local/lib/include
       LIBPATH=/usr/local/lib
       INCPATH=/usr/local/bin



then install the compiler

   % make


add to your PATH environment variable (usually in ~/.login) the
directory corresponding to BINPATH if necessary (see Makefile)

   ex: setenv PATH "$PATH":/usr/local/lib/clp_fd/bin


Note: the file src/Makefile nherites INCPATH and LIBPATH from the
      "root" Makefile. So if you run directly this Makefile do not
      forget to pass with the command line the appropriate paths
      (e.g. make INCPATH=...  LIBPATH=...). You can also modify in
      src/Makefile the default definitions of INCPATH and LIBPATH
      to be the same as in Makefile (the root Makefile).



Problems:

If the installation fails (e.g. with old versions of gcc) you can try
to clean the current installation (make clean) and to reinstall it
after modifying CFLAGS in the src/Makefile as follows:

   CFLAGS = -O2 -DNO_REGS


If you have a problem with a library when compiling a Prolog file
(message like "libclp_fd.a: warning: table of contents for archive is
 out of date; rerun ranlib(1)")

use % ranlib LIBPATH/libclp_fd.a
and % ranlib LIBPATH/libclp_fd_pp.a

(where LIBPATH is defined in the Makefile)



IV- Documentation
-----------------

The directory doc contains a user's manual (LaTeX file).

wamc tries tries to be conform to the (future) ISO standard Prolog.
The draft ISO standard for Prolog is available by anonymous ftp from
ai.uga.edu:/pub/prolog.standard/ [128.192.12.9]. An unofficial summary
of the draft ISO Prolog standard is available from the same location
as isoprolog.tex or isoprolog.ps.Z.



V- Examples:
------------

If you have get the file prg.tar.Z you can expand it as follows:

   % cd clp_fd
   % zcat prg.tar.Z | tar xvf -

This creates a directory Examples which containts some examples of
clp_fd programs. 
To execute the programme xxx.pl use:

   % cd Examples
   % make -f xxx.mk
   % xxx

you can also interpret it under the top level (but it is longer):

   % clp_fd
   ...
   | ?- [xxx].
   ...


If you have a stack overflow message, consult the documentation.




VI- Bugs
--------

Please report (detailled) bugs to diaz@margaux.inria.fr



VII- Ports
----------

clp_fd can be easily ported on other machines. If you want to do this
do not hesitate to contact me (diaz@margaux.inria.fr).





