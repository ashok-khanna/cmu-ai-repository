General Remarks
===============
0. Requirements to install and run the EuLisp->C compiler
---------------------------------------------------------
    - approximately 43 Mbytes disk space for all variants of the eu2c-system,
      which are 
      - basic compiler image (14Mb), compiler sources (1.5 Mb) and 
        compiled compiler sources ( 4Mb) 
      - precompiled eulisp-level-0 module (0.5 Mb)
      - compiler image with precompiled eulisp-level-0 module loaded (15 Mb)
    - GNU unzip
    - GNU c compiler gcc 2.2 or later
    - FranzAllegro 4.1 or 4.2

I. Installation Procedure
-------------------------
1. Create a distribution  directory named Eu2C (or something like that) and
   copy the compressed distribution archive into that directory.
2. Move to that directory.
3. Uncompress the distribution archive using gunzip:
   gunzip eu2c-94-07.tar.gz
4. Un-tar the distribution archive:
   tar -xf eu2c-94-07.tar
5. Define an environment variable Eu2CROOT to be  the path of the distribution 
   directory.
6. Define an environment variable ACL which contains the full path of the
   Franz Allegro 4.x image.
7. For complete installation, run the command make without any arguments,
   which takes depending on your hardware a few minutes. 
   The following will happen:
   a) ACL starts and the source files of the eu2c-compiler will be compiled.
   b) ACL starts again, reads the compiled compiler sources and creates a
      new image of FranzAllegro containing the  EuLisp -> C compiler. 
      If you have defined an environment variable Eu2CIMAGENAME, the value of 
      that variable will be used as the new name of the ACL image with the 
      eu2c compiler loaded, otherwise the name will be "eu2c".
   c) The libraries with different incarnations of Mem4C, an application 
      independent conservative garbage collector will be created. Depending 
      on the C-compiler you use, it may happen, that the C-compiler signals a 
      few warnings.
   d) The eu2c-compiler is started first time to compile the basic module which      is in the default case the module "eulisp-level-0".
   e) The eu2c-compiler is started again to be enhanced with the precompiled 
      eulisp-level-0 module. A new ACL image is created. Its name is composed
      of the name of the eu2c-compiler and the name of the
      basic module. Therefore, he default name will be 
      eu2c.eulisp-level-0.


II. Compilation of EuLisp-Modules
--------------------------------
There are 2 different strategies for the compilation of EuLisp modules:
- total compilation of an application including all the runtime modules
- total compilation of an application using a precompiled runtime system, 
  eg. eulisp-level-0.
The former produces very efficient code but the compilation is very cpu-
intensive. The code produced by the second variant is a little bit less 
efficient since optimization across the interface between application an 
runtime system is not possible, but due to the precompiled runtime-system 
the compilation process is much faster. 

A general compiler-driver "eu2c.application" is provided which controls the 
compilation process.  
In order to compile an EuLisp Module into C and then create an application 
simply call  
     eu2c.application [switches] <path expression> [C-compiler switches
and additional C files]
, e.g.
eu2c.application -bs eulisp-level-0 ./Examples/tm-hello.am.

The compilation of the EuLisp-Module tm-hello.am with precompiled runtime 
system is started. The following files will be created:
   -> tm-umdrehen.c 	: the C code  
   -> tm-umdrehen.inst 	: description of instances, will be 
                          included from tm-hello.c   
   -> tm-umdrehen	: image

The following switches are of special interest:
-C : compiles and links the C code of the EuLisp-module (a somewhat specialized
 driver for ANSI-C compiler and Linker)

-L : compiles the given EuLisp-Module to C and stops(runs the Eu2C compiler 
 only).

Omitting both -L and -C will call the Eu2C compiler first nad then the ANSI-C compiler and linker to produce an application.

-g : sets the debug-Option for the C-compiler and suppress al C-level 
 optimizations

-bs <name>: use the precompiled runtime-system with name <name> for compilation
 The default is without precompiled runtime system, i.e. all runtime system 
 modules needed system is compiled together with the application. As a tradeoff
 between compilation time and runtime we stronly recommend to use a precompiled
 runtime system for compilation. There is a module "eulisp-level-0" containing 
 all the stuff defined in level-0 of EuLisp0.99. In addition we provide a 
 module "eulis0x" which exposes "eulisp-level-0" and contains the following 
 enhancements: command-line-interface and the base of an interface to C.

-security: Links with a gc-library which is compiled with special 
 security features. In the default case a gc-library with security features off
 is used. 

-threads: The precompiled runtime system eulisp-level0 supports threads. 
 However, threads require special care during memory management activities like
 allocation of space. For the sake of efficiency we decided to assume as a 
 default case that there are single threaded applications only. If one insist 
 to use threads then one has to use the -threads switch which ensures that the
 correct gc-library will be linked to your application.(Using that library with
 single threaded applications would reduce the application efficiency by about 
 10%).

-cards <start number of cards>: eu2c relies on a conservative memory management
 system Mem4C[++],which allocates memory portions on cards of size 4096 bytes.
 The switch -cards determines the initial number of cards allocated during 
 system initialization. As a default we use a value of 16. That means one 
 starts with a heap size of 64 kBytes which will be increased on demand in 
 correspondence  with the configuration of the Mem4C[++]-library.

III. Examples
-------------
In the subdirectory $Eu2CROOT/Examples some example EuLisp programms are given,
some of them require to be compiled with the module "eulisp-level-0" and some 
must be compiled with the "eulisp0x"-module. 

A bsic system with precompiled eulisp0x can be generated by calling make with
	make basic_module=eulisp0x
.
IV. Makefile
-------------
For the easy installation we provide a script for make. The following makros 
are used:
basic_image: The name of the ACL image containing the eu2c compiler. If the 
environment variable $Eu2CIMAGENAME is defined, its value will be used, 
otherwise the name is assumed to be "eu2c".

basic_module: The name of the EuLisp-module which contain the basic runtime 
system. The default value is "eulisp-level-0". Another possible basic module is
"eulisp0x".

The following targets for make are defined:

basic_system: compiles the basic runtime-system and creates a new ACL-image 
 with basic runtime system loaded.

compile_basic_system: compiles a basic-runtime system.

load_basic_system: loads a precompiled runtime system and builds a new ACL-
 image with that system precompiled.

<basic_image>: compiles all compiler sources, loads them and creates an ACL-
image  with name <basc_image> which contains the pure eu2c compiler without 
any precompiled runtime ressources.

libs: creates the libraries for the memory management system.

clean_basic_system: removes the precompiled runtime system and ACL-image 
containing precompiled runtime system (approximately 16MB)

clean_compiler_sources: deletes all source files of the eu2c compiler 
(approx. 5.3 MB).

clean_runtime_sources: deletes the eulisp source files of the runtime system
(approx. 1 MB).
clean_eu2c_image: deletes the ACL-image containing the eu2c-compiler.
(approx. 14 MB).

clean_libs: deletes the libraries for the memory management system

clean_c_sources: deletes all c source files of the memory management
system.

remove_sources: removes all sources. Should only be used if you have created 
an ACL-image with a precompiled runtime system (approximately 21 MB).

If you plan to use Eu2C with the precompiled basic system we recommend to run 
make with the targets clean_runtime_sources and clean_eu2c_image.

 
IV. Restricted Support
-----------
Please, send bug reports concerning the installation to
ulrich.kriegel@isst.fhg.de

---------------------------------------------------------
Dr. E.Ulrich Kriegel, ulrich.kriegel@isst.fhg.de, (++49 30) 20372-346 
Fraunhofer Institute for Software Engineering and Systems Engineering
(FhG ISST), Kurstrasse 33, D-10117 Berlin, FRG
fax:   (++49 30) 20372-207
=====================================================================


