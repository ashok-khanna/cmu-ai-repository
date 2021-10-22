
----------------------------------------------------------------------
This is ECoLisp (ECL), an Embeddable Common Lisp implementation.

ECL is an implementation of Common Lisp designed for being embeddable
into C based applications.

ECL uses standard C calling conventions for Lisp compiled functions,
which allows C programs to easily call Lisp functions and
viceversa. No foreign function interface is required: data can be
exchanged between C and Lisp with no need for conversion.

ECL is based on a Common Runtime Support (CRS) which provides basic
facilities for memory managment, dynamic loading and dumping of binary
images, support for multiple threads of execution.  The CRS is built
into a library that can be linked with the code of the application.
ECL is modular: main modules are the program development tools (top
level, debugger, trace, stepper), the compiler, and CLOS.  A native
implementation of CLOS is available in ECL: one can configure ECL with
or without CLOS.  A runtime version of ECL can be built with just the
modules which are required by the application.

The ECL compiler compiles from Lisp to C, and then invokes the GCC
compiler to produce binaries.

ECL has been ported so far on:

 - Sun workstations with SunOS 4.x
 - Silicon Graphics with IRIX 4.x
 - IBM PC with DOS/go32.
 - IBM PC with Linux 1.0.

The newest versions are available via anonymous ftp from:

 - ftp.icsi.berkeley.edu [128.32.201.7], directory /pub/ai/ecl
 - ftp.di.unipi.it [131.114.4.36], directory /pub/lang/lisp

The distribution is in compressed tar file named like ecl-XX.tar.gz
where XX is the version number.
Once you have obtained the distribution, you should extract its content
with the command:

	zcat ecl-XX.tar | tar xf -

This will create the directory 'ecl'.
Among the files in this directory you will find one named INSTALL which
gives further instructions to proceed with the installation.

For information, comments, bug reports, send mail to:

	attardi@di.unipi.it

Giuseppe Attardi
  Dipartimento di Informatica
  corso Italia 40
  I-56125 Pisa, Italy

----------------------------------------------------------------------
