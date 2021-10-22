INSTALLATION
How to install Mobal 3.0b (Beta release) for SunOS 4.1.* and X11 

1. Select a directory that is to become Mobal's home directory.
This should be an empty new directory in which the different Mobal
subdirectories will go.

2. Set the environment variable MOBALHOME to the full name of the
chosen directory, e.g. in a csh:
   % setenv MOBALHOME <full name of Mobal's home directory>
This variable needs to be set whenever you want to run Mobal.  You should
therefore place the above command in your init file (.cshrc or similar).

3. Copy the files Mobal3.0b.tar.gz and userguide20u.tar.gz via
   anonymous FTP into $MOBALHOME, e.g. in a csh:
   % cd $MOBALHOME
   % ftp ftp.gmd.de
   enter 'anonymous' and your complete e-mail address as password
   ftp> cd /GMD/mlt/Mobal
   ftp> binary
   ftp> get Mobal3.0b.tar.gz
   ftp> get userguide20u.tar.gz
   ftp> bye


4. Change directory into $MOBALHOME, and uncompress and untar Mobal3.0b.tar, 
eg. in a csh
   % cd $MOBALHOME
   % gunzip Mobal3.0b.tar.gz
   % gunzip userguide20u.tar.gz
   % tar -xvf Mobal3.0b.tar
   % tar -xvf userguide20u.tar

5. That's it! You can now try Mobal with the command
   % mobalrt

INSTALLATION FROM FLOPPY DISKS

Perform steps 1 and 2 as above.  Then change into $MOBALHOME
   % cd $MOBALHOME
Instead of 3., do

3a. Insert the first floppy disk (order does not matter):
   % tar -xvf /dev/rfd0 
   % eject

Repeat these commands for each of the included disks.  Then proceeed with
steps 4 and 5 above.

Note: The name of your disk drive may be different than /dev/rfd0.
Note: There may be other tarfiles on the floppy disks.  If so, unpack
each one of them using the commands
   % gunzip <name of tarfile.gz>
   % tar -xvf <name of the tarfile>

EXTERNAL TOOLS

Mobal 3.0b comes with interfaces to several external learning tools
developed outside of GMD.  The tools themselves are not included in
the Mobal distribution, so you must obtain them directly from their
authors.  Some tools have also been placed in the ML-Archive at GMD,
so you can obtain them there.  For Foil and Golem, there are binary
versions which should run on SparcStations under SunOS 4.1.*:
   - Foil: [by Ross Quinlan and Mike Cameron-Jones, Univ. of Sydney]
     - if you already have an executable of FOIL6.1, 
       - then: rename it to 'foil' and place it in 
         $MOBALHOME/tools/bin
       - otherwise 
         obtain /MachineLearning/general/software/foil6.1/foil.gz,
         place it in $MOBALHOME/tools/bin, and
         % gunzip $MOBALHOME/tools/bin/foil.gz
         % chmod +x foil
   - Golem:  [by Stephen Muggleton and Cao Feng, Oxford University]
     - obtain /MachineLearning/ILP/public/software/golem/golem.Z
     - place it in $MOBALHOME/tools/bin
     - % uncompress $MOBALHOME/tools/bin/golem.Z
       % chmod +x golem

If the compiled binaries do not work, follow the instructions in
the ml-archive tools' README files to obtain the sources and compile 
your own version.

INCOMPATIBILITY NOTICE

In Mobal 2.*, the default presentation syntax was "prolog_switched",
and Prolog syntax (variables uppercase) was available as an option.
Prolog syntax is now the standard in Mobal3.0, so make sure you pay
attention to this when entering items into the scratchpad.  This
change does not affect your stored domains; they will automatically be
displayed in the new format when you load them.  You must, however,
convert old scratchpad files (*.scr) before you use them (unless you
have always been using Prolog syntax).  To this end, get ScrConverter.tar
from our server, which contains an automatic converter program.

USER GUIDE

the enclosed postscript copy of the user guide
($MOBALHOME/man/guide20u.ps, found in userguide20u.tar.gz) refers to
Mobal Release 2.2, the last OpenWindows/HyperNeWS release of the
system.  The major change between version 2.2 and the current version
3.0 is the change in user interface technology: the new release is
based on X11, so you do not need OpenWindows/HyperNeWS any more.
Consequently, some of the remarks in this user guide that refer to the
window system, and some of the screendumps, are no longer current.

The user guide also lacks descriptions of some of the additional
facilities that have been added since Release 2.2, e.g. the extended
external tools concept.  Otherwise, this version of the guide is fine
as a basis for working with the system.  We are presently updating the
user guide, and you will find the updated version on our FTP server.

COPYRIGHT Notice

Mobal is copyrighted by GMD (Copyright 1989-1994).

Mobal can be licensed and used free of charge for academic, educational, or
non-commercial uses.  We do require, however, that you send us e-mail
(address below) so we know where Mobal is going.  This will also get
you access to MobalNews, our mailing list where we let all registered
Mobal users know about updates, bug fixes, etc.  Please also acknowledge
Mobal and GMD in publications about any work where you have used the
system.  Thank you!

Please do not make Mobal available to others without giving them
a copy of this file, and asking them to register with us.

Good luck, and let us know about your experiences with Mobal!

Our e-mail address is

   mobal@gmd.de

Ciao,

The ML Team at GMD 

current group members:

    research scientist:
        Werner Emde
        Joerg-Uwe Kietz
        Edgar Sommer
        Stefan Wrobel (group leader)

    students:
        Roman Englert
        Marcus Luebbe

    consultant:
        Katharina Morik (University of Dortmund)
    

GMD (German National Research Center for Computer Science)
Institute of Applied Information Technology (I3)
I3.KI
53754 Sankt Augustin
Germany
Fax: +49/2241/14-2889
