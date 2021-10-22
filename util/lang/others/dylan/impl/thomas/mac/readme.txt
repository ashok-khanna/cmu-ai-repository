MacGambit is the Mac implementation of the Gambit Scheme 
interpreter and compiler, by Marc Feeley. This directory contains 
the sources for Gambit, as well as a version of Gambit customized 
as a Thomas interpreter.

----------
Content:

macgambit-1.9.1-interp.hqx     MacGambit interpreter only
macgambit-1.9.1-sources1.hqx   THINK-C 5.0 sources files for interpreter
macgambit-1.9.1-sources2.hqx   Rest of sources for compiler
macgambit-1.9.1-thomas.hqx     Standalone interpreter for DEC's Thomas system

Note: all of these files are (c) 1992, Universite de Montreal.  Check the
"About MacGambit" dialog box for details.
------------
Date: Thu, 26 Nov 92 11:51:59 -0500
From: gambit@trex.iro.umontreal.ca
To: gambit-users@trex.iro.umontreal.ca
Subject: Release 1.9.1 of Gambit for the Mac

MacGambit version 1.9.1 is now available via anonymous FTP from
trex.iro.umontreal.ca in the pub/gambit/gambit1.9.1 directory.  The
interpreter AND THINK-C 5.0 sources to the whole system (including the
compiler) are there.  There is also a version of MacGambit linked with
DEC's Thomas system release 1.1.

All of these programs are now in the public domain and may be
distributed to others as long as they are not sold or transferred for
compensation (other than a reasonable duplication fee).  The copyright
notice must also remain with the programs.

Please understand that these programs are the result of an UNFUNDED
group at the Universite de Montreal.  Users who enjoy the system
should consider sending a donation to our group so that we can fund
students to continue improving MacGambit.  Corporate funding is of
course welcome!

Marc Feeley

---------------
For the Thomas version I added code that throws the user back to the
toplevel Thomas REPL when an error occurs.  I also added a "load"
method that calls thomas->scheme on a file and then calls the Scheme
load procedure to load it in.
