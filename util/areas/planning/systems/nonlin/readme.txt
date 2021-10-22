Department of Computer Science
University of Maryland at College Park

NONLIN COMMON LISP IMPLEMENTATION - General Notes
(Version 1.2 - 2/5/92)

This directory contains the source files for a CommonLisp
implementation of the NONLIN planning system originally designed and
implemented by Austin Tate.  The implementation is relatively faithful
to the methodology of the original NONLIN, although some name changes
have been made within the operators to conform more closely to more
recent usage in the planning community.  The brief manual provided
(see below) describes these differences and reports on how to load and
run the program.  We also provide some files with simple examples that
are described in the document (useful for debugging and for learning
to use the system).  The system has been tested in several Commonlisp
implementations, but of course we cannot guarantee that it will work
in all implementations.  Finally, we should note that an ability to
make extensions to or to debug this code will require greater
familiarity with NONLIN than is provided in the documentation
provided.  The original conference papers and technical reports on
NONLIN (cited in the documentation) are required reading for anyone
wishing to hack this code.
   -Subrata Ghosh, James Hendler, Subbarao Kambhampati, Brian Kettler

----------------------
INSTALLATION

To obtain the necessary files:

1) anonymous ftp the necessary files:

	FTP to cs.umd.edu (128.8.128.8)
	login as anonymous
	cd /pub/nonlin
	binary
	get nonlin-files.tar.Z
	get nonlin.tex.Z (or nonlin.ps.Z)

   <note: Those without the ability to ftp this code should contact Professor 
    Hendler (see address below), to make special arrangements>

2) Uncompress the files via "uncompress <filename>".

3)  The source code files should be extracted from the file
    "nonlin-files.tar" via "tar xvf nonlin-files.tar".
    This will install the files in a subdirectory named "Nonlin".

The user manual describing the implementation and how to run NONLIN
is contained in the files:
   nonlin.tex   (latex version)
   nonlin.ps   (PostScript version)
(These document files should first be uncompressed as described above).

------------------------------
SUPPORT (such as it is)

This project is being distributed free of charge with no implied
warranty or support.  To allow communication between users, we have
set up some mailing lists which can be used for reporting bugs and
getting reports of bug fixes.  Announcements of patches and updates
will be made via these mailing lists.  We request that anyone ftp'ing
this code send a message to "nonlin-users-request@cs.umd.edu" 
(US internet) letting us know you have a copy, and also letting us
know if you wish to subscribe to the list "nonlin-users@cs.umd.edu".
Information, new examples, etc. are expected to be shared via the
nonlin-users mailing list, so we would recommend subscribing.

Reports of bugs found in the implementation, and we are sure there are
some, can be sent to "nonlin-bugs@cs.umd.edu" which will be read by
the implementors and others who are familiar with the source code.  If
you wish to receive this mailing list, you may also send mail to
"non-users-request@cs.umd.edu" although we ask that you be serious
about participating.  The nonlin-users list will be used to report
bugs found via this mailing list as well as fixes to those bugs.


The following mailing lists have been set up for this implementation of
of NONLIN:
   nonlin-bugs@cs.umd.edu           (to report bugs in the implementation)
   nonlin-users@cs.umd.edu          (users of this implementation)
   nonlin-users-request@cs.umd.edu  (for requests from users)

----------------------------------------------------------
correspondence can be addressed to
   Prof. James Hendler
   Department of Computer Science 
   University of Maryland 
   College Park, Md. 20742
   hendler@cs.umd.edu (US internet)
or
  nonlin-users-request@cs.umd.edu

-----------------------------------------------------------------------
NOTES ON VERSION 1.2 (2/5/92):

This latest release does not add much in terms of functionality to
NONLIN. 

Rather, the main purpose of this release is to fix several
bugs reported by alert users.  An effort was made to fix as many of
these as possible.  As a result, almost all of the NONLIN files contain
changes.  These changes have been tested on our Macintosh Common Lisp
implementation and should work on other Common Lisps.

In addition, the PACKAGE statements have been removed from the source
files as they have hindered the porting of the source code between
different Lisps.

NONLIN now writes various info to some global variables.  This was done
to facilite the use of NONLIN by other applications.  These variables
are described in the User Manual (Appendix F).

Finally, additions have been made to the User Manual.  A new section,
"Tips for Working with Operator Schemas", has been added (new
additions to this section are welcome from NONLIN users!!).  The 
blocks world operator schema examples have been annotated in some
detail.  Other minor corrections have been made.  Lastly, the 
notes on the (unsupported) DEVISER extensions, which were incorporated
the previous (and this) release, have been added as an appendix.


Please report any bugs found to nonlin-bugs@cs.umd.edu.

Any comments or requests should be sent to 
   nonlin-users-request@cs.umd.edu.

Happy Planning!

