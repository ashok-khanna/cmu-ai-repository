This is the ftp readme for Common Music. You can get the newest
release via anonymous ftp from either ftp.zkm.de (192.101.28.17)
or ccrma-ftp.stanford.edu (36.49.0.93) in the pub/ or pub/Lisp
directories, respectively.

        cm.README		this file
	cm.tar.Z		Unix archive, use also for Mac
	cm.zip			DOS archive (pkunzip -d)

If you use Common Music on the Mac, take cm.tar.Z and also:

	macunix.sit.hqx

which contains two utilities, MacCompress and Tar, for
uncompressing and untarring unix tar.Z files on the Mac. Restore
macunix.sit.hqx using the Macintosh Stuffit utility and then see
the enclosed readme for more information.

--------------------------------------------------------------------

HOW TO RESTORE THE SOURCES

First, make a new directory to restore the sources to. It does
not matter where the directory resides. On Unix or DOS you can use
the mkdir command:

	mkdir <directory>

where <directory> is replaced by whatever directory name you use.
If you are reinstalling Common Music, its still best to delete
or move the current sources and reinstall to an empty directory
because the new archive may contain renamed files or a different
directory structure
Next, move the ftp archive from wherever it currently is to the
new source directory:

Unix:
	mv cm.tar <directory>
DOS:
	move cm.zip <directory>

Then move to the source directory and restore the archive:

Unix:
	cd <directory>
	zcat cm.tar.Z | tar xvf -
DOS:
	cd <directory>
	pkunzip -d cm.zip

This restores all the sources into the source direcory.  Ignore any
warning message you see.  Once the sources have been restored you
may delete the archive or save it as a backup:

Unix:
	rm cm.tar.Z
DOS
	del cm.zip

Then see Common Music's README file for further instructions about
installing the system.

---------------------------------------------------------------------

HOW TO USE ANONYMOUS FTP

FTP only works if your computer is connected to the internet.
Use the ftp command to connect to either ftp.zkm.de or
ccrma-ftp.stanford.edu. Then login with the name:

	anonymous

and password:

	user@host

where user@host is your actual login name and location.
Then type:

	cd pub

to move to the ftp pub directory.  Next type:

	bin

to set the transfer mode to binary. Don't forget to do this!
Then type:

	get cm.tar.Z

to transfer the archive file to your machine. Once ftp notifies
you that the transfer is complete (the transfer itself may take
a very long time...) type:

	quit

to exit from the ftp program. That't it!


	Rick Taube
	Zentrum fuer Kunst und Medientechnologie
	Ritterstr. 42    7500 Karlsruhe 1    Germany
	hkt@zkm.de, hkt@ccrma.stanford.edu
