This is a compressed tar file containing the Tierra software and documentation.

To get the file, use ftp in the binary mode.  Once you have the file,
you can expand it in two steps:

uncompress tierra.tar.Z
tar oxvf tierra.tar

This will create the following file and directories:

README          beagle/         overview/
alcomm/         doc/            tierra/

The README file is this file.

beagle/  contains a DOS only tool for analysis of the output generated
by running Tierra.  This is a very nice tool and I recommend using it even
if you run Tierra on a Unix system.  If you have lots of disk space on
your DOS machine, and if you can transfer large files between your Unix
and DOS systems you are set.

alcomm/ and overview/  contain a Unix/Xwindows only tool for the observation
of the Tierra system while it is actually running.  This tool would normally
be run on a different machine from the one running Tierra.  They establish
communications over the network using sockets, and the tool displays a
memory map of the Tierra simulation showing the births and deaths of the
organisms and a few other things.  Very nice tool.  This tool was developed
by a student, Marc Cygnus, and I can not support it.

doc/  contains hundreds of pages of documentation, and also, several
manuscripts describing the Tierra research.

tierra/  contains the source code for Tierra itself.  Actually this is
the only directory that is essential to using Tierra (though you will
probably want the tierra.doc file from the doc/ directory as well).

				Tom Ray
				March 16, 1994
