#Installation Guide
0. Requirements to install and run the EuLisp->C compiler
    - approximately 25Mbytes disk space
    - GNU unzip
    - GNU c compiler gcc 2.2 or later
    - FranzAllegro 4.1
1. Uncompress the distribution file using gunzip:
   gunzip eu2c-93-12.tar.gz 
2. Create the distribution  directory named Lisp (or something like that) and
   copy the uncompressed distribution archive into that directory.
3. Un-tar the distribution archive:
   tar -xf eu2c-93-12.tar
4. Define an environment variable Eu2CROOT which points to that directory.
5. Define an environment variable ACL which contains the full path of the
   Franz Allegro 4.1 image.
6. Run the command boot.apply, which takes depending on your hardware a few
   minutes. A new image of FranzAllegro containing the Apply EuList ->C
   compiler will be created. It has the name apply.
7. Change to subdirectory ApplyC and run the procedure
   create_libs.eu2c
   to rebuild the libraries apply.a ... containing all files needed for gc.

   Due to an intermediate state of some parts of Apply the following warnings 
   will occur:

   card.c: In function `set_type_descriptor':
   card.c:59: warning: assignment from incompatible pointer type
   card.c: In function `describe_type':
   card.c:75: warning: comparison of distinct pointer types lacks a cast
   card.c:89: warning: assignment from incompatible pointer type
   Nevertheless the programs are correct because the return values are not 
   needed.
   
   Now return to the distribution directory.

8. In order to compile an EuLisp Module into C call the procedure
   eu2c.application <path expression> [auxilairy C files]:
   compile.apply ApplyModules/tm-umdrehen.am
   the result with the memory management system. The produced image has the 
   name of the EuLisp Module:
   compile.apply ApplyModules/tm-umdrehen.am
   -> tm-umdrehen.c 	: the C code  
   -> tm-umdrehen.inst 	: description of instances
   -> tm-umdrehen	: image

Please, send bug reports concerning the installation to
ulrich.kriegel@isst.fhg.de

---------------------------------------------------------
Dr. E.Ulrich Kriegel, ulrich.kriegel@isst.fhg.de, (++49 30) 20372-346 
Fraunhofer Institute for Software Engineering and Systems Engineering
(FhG ISST), Kurstrasse 33, D-10117 Berlin, FRG
fax:   (++49 30) 20372-207
=====================================================================


