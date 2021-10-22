
>IMPORTANT REMARK (02/02/94) --------------------------------------
>AKCL IS BEING MIGRATED TO GO32 1.11
>The current version will compile with go32 1.09, perhaps with 1.10
>------------------------------------------------------------------

To install an executable of akcl you will need
to take

go32sexe.zip
akclexe.zip

and if you dont have a current version of unzip

unzip50.exe

Under dos do
c:
cd  \

mkdir akcl
cd akcl

unzip50 go32sexe.zip
unzip50 akclexe.zip

[you may place things in a directory other than c:\akcl
by specifying this in the akcl.bat file which you unzip]

akcl.bat should invoke the image.

This image was compiled to have ctrl-c interrupt work
correctly which required changes to djgpp's go32.  The
altered source is on math.utexas.edu

In order to be able to compile lisp files, you will need a copy
of the C compiler gcc.    To install this look at the file
BUILD.DOS in this directory.




