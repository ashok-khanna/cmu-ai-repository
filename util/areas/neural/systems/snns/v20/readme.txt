**********************************************************************
	How to obtain SNNS
**********************************************************************

The SNNS simulator can be obtained via anonymous ftp from host

        ifi.informatik.uni-stuttgart.de  (129.69.211.1)

in the subdirectory

        /pub/SNNS

as file

        SNNSv2.0.tar.Z

or in several parts as files

        SNNSv2.0.tar.Z.aa ... SNNSv2.0.tar.Z.ae

These split files are each less than 500 KB and can be joined with the
Unix `cat' command  into one file SNNSv2.0.tar.Z .  Be sure to set the
ftp mode to binary before  transmission of the  files.  Also watch out
for possible higher version numbers,  patches  or Readme  files in the
above directory /pub/SNNS .  After successful transmission of the file
move it to the directory where you want  to  install  SNNS, uncompress
the file with the Unix command

        uncompress SNNSv2.0.tar.Z

and then use the command

        tar -xvf SNNSv2.0.tar

This will extract SNNS in the current directory. The SNNS distribution
includes  full  source  code, installation  procedures  for  supported
machine architectures, some  simple examples  of  trained networks and
the  full  English documentation as LaTeX source  code with PostScript
images included.

A PostScript version of the documentation of SNNS is also available in
the same SNNS ftp directory as file

	SNNSv2.0.Manual.ps.Z

It must  be  uncompressed  and  should  then  print on any  PostScript
printer.  Again  remember  to  set  the  ftp  mode  to  binary  before
transmission of the file.


**********************************************************************
	End of Readme "How to obtain SNNS"
**********************************************************************
