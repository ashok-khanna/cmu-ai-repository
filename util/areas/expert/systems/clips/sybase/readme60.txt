Thanks for expressing interest in our customized CLIPS-to-Sybase interface.

A uuencoded file named clips2sybase.tar.uu contains the source code, a
makefile, and some documentation describing how to use the software.  The
documentation is in the file descrip.txt.

To unpack the code, do the following:

1.  Create a new directory, and go there.
2.  Copy clips2sybase.tar.uu to that directory.
3.  At the UNIX prompt, type
    uudecode clips2sybase.tar.uu
    This will create a file named "clips2sybase.tar" in your new directory.
4.  At the UNIX prompt, type
    tar -xf clips2sybase.tar
    This will create a subdirectory named "clips2sybase" in your new
    directory.  There should be 5 files in it:
    Filename               Contains
    --------               --------
    descrip.txt            Documentation describing the software
    dbfun.c                Source code for the Sybase functions
    main.c                 New version of CLIPS main.c, with new functions
    makefile.cc            Builds commandline CLIPS interface with "cc"
    create_deftemplate.sh  Utility (see descrip.txt for details)

To build the code, do the following:

1.  Copy all your CLIPS V6.01 sources (CLIPS itself; NOT our code) to
    an empty directory, and go to that directory.
2.  Copy our files (dbfun.c, main.c, and makefile.cc) to that directory.
3.  Check that the environment variable PROJECTDIR is not set (so SCCS
    won't get in your way).  Also check that there is no alias for
    "clips".
4.  At the UNIX prompt, type
    make -f makefile.cc clips
    I *hope* our makefile works for you.
5.  Edit the shell script create_deftemplate.sh.  It's short, and there
    are instructions right in the file.  Your changes will be very minor.
6.  Invoke the shell script create_deftemplate.sh.  It will create a
    file named "outfile," which will contain your deftemplates.
7.  Start up your new version of CLIPS.  At the CLIPS> prompt, type:
                              (load outfile)
    which will allow you to execute the new CLIPS function dbquery (it
    creates CLIPS facts from the result of a "select" on a table).
8.  Try the new Sybase functions (dbopen, dbcmd, adadd, dbquery, dbclose)
    right from the CLIPS> prompt.  No need to write a program first.  Use
    the file descrip.txt as an example.
9.  Have fun.  Send Email for help if you need to.

Regards,
Sherry Steib
(sherry@informatics.wustl.edu)
Medical Informatics Laboratory
Washington Univ. School of Medicine
St. Louis, MO

