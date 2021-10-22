---------------------------------------------------------------------
 Copyright (C) 1993 Christian-Albrechts-Universitaet zu Kiel, Germany
---------------------------------------------------------------------
 Projekt  : APPLY - A Practicable And Portable Lisp Implementation
            ------------------------------------------------------
 Funktion : README for CLiCC on DOS

------------------------------------------------------------------

Please read README first.
This file contains information on the DOS-386 Version only.

The DOS-386 package has three parts. CLiCC itself and two supporting
software components: CLISP by Bruno Haible and DJGPP, the GNU-C port 
by D.J.Delorie.

To use this package a 386 system is required! 8 MB of RAM is recomended.

Installation
~~~~~~~~~~~~
To install the DOS-386 Version follow these steps:

1) Unpack the archives on the diskettes using UNZIP on disk 1.
   (If you use PKUNZIP don't forget to supply the -d option.)
   
   unzip a:clicc062.zip

   mkdir \clisp
   unzip a:clispeng

   unzip a:djgpp110.zip
 
2) Change your AUTOEXEC.BAT file to reflect the settings in file
   clicc062\setenv.bat:

          set CLICCROOT=C:/CLICC062
          set DJGPP=C:/DJGPP
          set CLISP=C:/CLISP
          PATH C:\CLISP;C:\CLICC062\BIN;C:\DJGPP\BIN;%PATH%
          
          set COMPILER_PATH=%DJGPP%/bin
          set C_INCLUDE_PATH=%DJGPP%/include
          set LIBRARY_PATH=%DJGPP%/lib
          set TMPDIR=c:/tmp
          set GO32TMP=c:/tmp
          set GO32=ansi emu %DJGPP%/emu387/emu387
          SET TEMP=C:\

   You may need to increase your environment space for this.


Usage
~~~~~
There are BATCH files to compile application programs in /clicc062/bin. 
They are similar to the shell scripts we use under UNIX.

Here is how to compile the test in /clicc062/src/test:

cd \clicc062\src\test

clicc testmain            ; from Lisp to C
cl testmain               ; from C to machine code

go32 testmain             ; run test suite  (2 failed test are ok, see README)



Further Information
~~~~~~~~~~~~~~~~~~~
Read the other documentation files for further information.
