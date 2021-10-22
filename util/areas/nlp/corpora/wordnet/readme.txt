
	*** Update: WordNet Version 1.4 is now available ***

(Release notice, users' mailing list information and README file)

WordNet Version 1.4 is now available.  The WordNet database is close
to 13.5 megabytes, exclusive of the search code.  The entire package
is approximately 17.5 megabytes.  The WordNet search code is
distributed in binary form only, and is presently available for Sun-3,
Sun-4, NeXT, DECstation, RS-6000, Silicon Graphics, Solaris 2.3,
Macintosh and PC architectures.  An X Windows interface is available
for Sun-3, Sun-4, DECstation, RS-6000, Silicon Graphics, Solaris,
Linux and NeXT (please note that this is NOT a NeXTStep application -
you must have X Windows for the NeXT in order to use the X Windows
interface).  A Microsoft Windows interface is available for the PC.  A
command line interface is also provided for all architectures except
the Macintosh.

If you are currently using an earlier version of WordNet you are
strongly encouraged to upgrade to version 1.4.  Small bugs and
inconsistencies in both the database and search software have been
corrected, and the database coverage has been expanded.  Attributes
have been added with this release.

New with release 1.4 is a semantic concordance: a textual corpus
linked to a lexicon with semantic tags.  The concordance consists of
103 files from the Brown Corpus annotated with pointers to word senses
in the WordNet 1.4 database.  An X Windows application, Escort, is
provided for searching the concordance files for occurrences and
co-occurrences of semantic tags.  Escort has been ported to the Sun-4,
NeXT and DECstation platforms.  You must install WordNet 1.4 before
installing and using the semantic concordance package.  The semantic
concordance package is approximately 20 megabytes. 

Summary of changes:

	Updates to database - additional coverage, cleanup
	Addition of attributes
	Port to RS-6000
	New semantic concordance package

We prefer that you ftp the WordNet system via anonymous ftp from one
of the following ftp sites:
	In the US: clarity.princeton.edu [ 128.112.144.1 ]
	In Europe: ftp.ims.uni-stuttgart.de [141.58.127.61]

**************************************************************************
* IF YOU FTP WordNet, PLEASE SEND MAIL TO wordnet@princeton.edu SO WE    *
* CAN UPDATE OUR RECORDS AND KEEP TRACK OF OUR USERS FOR FUTURE MAILINGS *
* AND RELEASES.  EVEN IF YOU ARE A CURRENT USER WHO IS UPDATING, IT IS   *
* USEFUL TO US TO KNOW THAT YOU HAVE UPGRADED TO 1.4.                    *
**************************************************************************

***** REMEMBER TO FTP IN "binary" MODE!!! *****

On clarity.princeton.edu the packages are located in the subdirectory
'pub'.  This is the README file in this directory.  Information about
ftping from ftp.ims.uni-stutgart.de follows later in this message.

To ftp the UNIX version of WordNet 1.4, ftp the following file:

	wn1.4unix.tar.Z	WordNet Version 1.4 for UNIX systems
			in compressed tar format.  This includes 
			the WordNet database, binary installation 
			of search code for Sun-4, DECstation, RS-6000
			and NeXT, and documentation.  Installation 
			instructions and a Makefile are included.  
			Man pages are provided as unformatted troff 
			files.

	wn1.4sun3.tar.Z	WordNet Version 1.4 binaries for Sun-3 only.
			Does not include the database, Makefile, or
			documentation.  If you are using a Sun-3, 
			you should ftp 'wn1.4unix.tar.Z' and
			'wn1.4sun3.tar.Z', and install the Sun-3
			binaries in the desired 'bin' directory.
	
	wn1.4sgi.tar.Z	WordNet Version 1.4 binaries for Silicon
			Graphics only.  Does not include the database,
			Makefile, or documentation.  If you are using
			an SGI workstation, you should ftp
			'wn1.4unix.tar.Z' and 'wn1.4sgi.tar.Z', and
			install the SGI binaries in the desired
			'bin' directory.  See 'readme.sgi' for more
			information.

	wn1.4sol2.tar.Z	WordNet Version 1.4 binaries for Solaris 2.3
			only.  Does not include the database,
			Makefile, or documentation.  If you are
			running Solaris 2.3, you should ftp
			'wn1.4unix.tar. Z' and 'wn1.4sol2.tar.Z', and
			install the Solaris binaries in the desired
			'bin' directory. 
			
	wn1.4linux.tar.Z WordNet Version 1.4 binaries for Linux 0.99
			only.  Does not include the database,
			Makefile, or documentation.  If you are
			running Linux, you should ftp
			'wn1.4unix.tar. Z' and 'wn1.4linux.tar.Z', and
			install the Linux binaries in the desired
			'bin' directory. 
			

To ftp the PC (DOS) version of WordNet 1.4, ftp the following files:

	readme.pc	README file for PC installation.

	wn14.arc	PC version in ARC format.  This includes the
			WordNet database, binary installation of
			search code (command line and Microsoft
			Windows interfaces), and documentation.  
			Installation instructions and installation 
			batch file, and a batch file for running 
			WordNet are included.  Man pages are provided 
			in a format which can be sent to the line 
			printer or viewed on the screen.

	arc.exe		arc program needed to 'unarc' the PC version.
			If you already have this on your PC you do
			not need to ftp this file.

To ftp the Macintosh version of WordNet 1.4, ftp the following files:

	readme.mac	README file for Macintosh installation.

	MacWordNet1.4.sit.bin	
			Macintosh version in Stuffit format.  
			This includes the WordNet database, binary 
			installation of search code, and documentation.
p			Man pages are provided in Postscript format.

	UnStuffit-Deluxe-TM.bin	
			Unstuffit program needed to unpack the
			Macintosh version.  If you already have
			UnStuffit on your Macintosh, you don't
			need to ftp this file.

Semantic concordance:

	wn1.4semcor.tar.Z
			Semantic concordance package in compressed tar
			format.  Includes the semantically tagged
			files, Escort searching	application for
			Sun-4, DECstation and NeXT, and documentation.
			Installation instructions and a Makefile are
			included.  Man pages are provided as
			unformatted troff files.

Papers and WordNet documentation only:

        wn1.4man.tar.Z 	WordNet 1.4 documentation (man pages) only
			as unformatted troff files.

	5papers.tar.Z 	troff paper describing WordNet project in
                        compressed tar format ("Five Papers on
			WordNet").  A Makefile for formatting and
			printing the papers is included.

	5papers.ps	"Five Papers on WordNet" in PostScript
			format ready for printing.

If you need a PC or Macintosh version on diskette we will provide
WordNet on magnetic media.  There is a charge of $25 for PC diskettes
(high density only, either 3 1/2" or 5 1/4"), $25 for Macintosh
diskettes (high density 3 1/2" only), and $30 for 8mm tape.  Please
send a check, payable to Princeton University, along with a request
for a specific format to:

	Princeton University
	Cognitive Science Laboratory
	221 Nassau Street
	Princeton, NJ 08544-2093
	Attn: WordNet

If you have received an earlier version of WordNet on magnetic media,
you may return the media to us and receive an upgrade for $10.

To receive a printed copy of "Five Papers on WordNet", please send $6
to the address above.  (We do prefer that you ftp this document if
possible.)

If you are running on an unsupported platform or have a need for the
source to the WordNet search code, please send mail to
wordnet@princeton.edu.  We will consider requests for source code on
an individual basis.

Please address all email concerning WordNet to wordnet@princeton.edu.
We will try to respond in a timely manner.  If you have received this
message via email and do not wish to remain in the user database,
please send a request to be deleted.

***********************************************************************

Information about ftp site ftp.ims.uni-stuttgart.de:


  Host:      ftp.ims.uni-stuttgart.de [141.58.127.8]
  Login:     ftp
  Password:  Your e-mail address
  Directory: WordNet
             ('ls' sometimes doesn't work properly, 'dir' shows everything).

Due to the size of the WordNet distribution, please restrict
downloading to time frames outside office hours Central European Time
(i.e. outside 9 a.m. - 6 p.m.).

We didn't modify the original files in any way, but used the GNU gzip
utility for compression (this saves almost 3MB). Additionally, the two
huge files (wn1.4semcor.tar.gz and wn1.4unix.tar.gz) have been split
in 500k chunks for easier downloading. The directory contains the
following files:
  
  -rw-r--r--  1 oli         92849 Aug 25 08:10 5papers.tar.gz
  -rw-r--r--  1 oli          8446 Aug 25 08:10 README
  -rw-r--r--  1 oli          1990 Aug 25 08:35 README.WordNet-mirror
  -rw-r--r--  1 oli           722 Aug 25 08:10 README.bug
  -rw-r--r--  1 oli          8262 Apr 23 10:45 WordNet-Mailing-List
  -rw-r--r--  1 oli         19933 Aug 25 08:10 wn1.4man.tar.gz
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.aa
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ab
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ac
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ad
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ae
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.af
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ag
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4semcor.tar.gz.ah
  -rw-r--r--  1 oli        216953 Aug 25 08:16 wn1.4semcor.tar.gz.ai
  -rw-r--r--  1 oli         41843 Aug 25 08:10 wn1.4src.tar.gz
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4unix.tar.gz.aa
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4unix.tar.gz.ab
  -rw-r--r--  1 oli        524288 Aug 25 08:16 wn1.4unix.tar.gz.ac
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.ad
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.ae
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.af
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.ag
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.ah
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.ai
  -rw-r--r--  1 oli        524288 Aug 25 08:17 wn1.4unix.tar.gz.aj
  -rw-r--r--  1 oli        264233 Aug 25 08:17 wn1.4unix.tar.gz.ak

Please read all README* files. The file 'README.WordNet-mirror' is
appended at the end of this mail.

In case you shouldn't already have gzip, please ask you system
administrator to download it from prep.ai.mit.edu or one of the
numerous ftp sites which mirror GNU software.

---------------------------------------------------------------------------
Oliver Christ
Institute for Natural Language Processing, University of Stuttgart, Germany
oli@ims.uni-stuttgart.de/christ@is.informatik.uni-stuttgart.de
---------------------------------------------------------------------------

==================== README.WordNet-mirror ====================


In accordance with Randee Tengi <rit@clarity.Princeton.EDU> we keep a copy of
the current WordNet distribution here.

This directory contains WordNet Version 1.4 originally from
clarity.princeton.edu:/pub/ (transferred from there on Aug 25, 1993).

The original files are unmodified, but are compressed with the GNU gzip
compression utility instead of standard 'compress' which was used to build the
original distribution.

Interested parties downlaoding the software from here are kindly requested to
inform Randee under the following email address

          wordnet@princeton.edu

if they install WordNet (through that they will be put on the WordNet mailing
list to inform them of any changes, patches and updates).

Anyone who wants to make this tar file available on an ftp server should ask
Randee in advance and should include a similar request.

Due to the size of the WordNet distribution, please restrict downloading to time
frames outside office hours Central European Time (i.e. outside 9 a.m. - 6
p.m.).

In order to facilitate easier downloading, the files wn1.4semcor.tar.gz and
wn1.4unix.tar.gz have been split into 500k chunks. To rebuild the distribution,
download all parts, and 'cat' them into one tar.gz file, for example with the
following commands:

  cat wn1.4semcor.tar.gz.a* > wn1.4semcor.tar.gz
  cat wn1.4unix.tar.gz.a* > wn1.4unix.tar.gz

The .gz files can then be unpacked with the 'gunzip' utility. You may also use a
pipe:

  cat wn1.4semcor.tar.gz.a* | gunzip | tar xf -
  cat wn1.4unix.tar.gz.a* | gunzip | tar xf -


All queries regarding the installation of the system, its use and
maintenance should go to Randee, and _not_ to us. We're just providing
disk space here.


Oli
---------------------------------------------------------------------------
Oliver Christ
Institute for Natural Language Processing, University of Stuttgart, Germany
oli@ims.uni-stuttgart.de
---------------------------------------------------------------------------

		******* WordNet users' mailing list **********

We have (finally) set up a WordNet users' mailing list that will be
administered here at Princeton.  Items addressed to the mailing list
will be automatically forwarded to all users on the list.  Please note
that this mailing list is separate from the user database.  In order
to participate in the mailing list, you must specifically request to
be added.  We hope that the mailing list will be a place for useful
discourse about WordNet to take place.  We at Princeton are always
interested to hear what our users are doing with WordNet, and we
imagine many users wonder what other users are using it for.
Hopefully this mailing list will help to bring researchers together to
exchange their ideas, experiences, code and philosophies.

To post a message to the mailing list, address mail to
'wn-users@princeton.edu'.  Requests to be added to or removed from the
mailing list should be sent to 'wn-users-request@princeton.edu'.
Although you have received this announcement, you will only be added
to the mailing list if you send a request to
'wn-users-request@princeton.edu'.  Please be sure to include your
correct e-mail address in the body of your request.  Also, to help us
keep our records up to date, if you are a current WordNet user it
would be helpful to us if you would include the version of WordNet you
are using (the latest release is 1.4) and the platform(s) that you are
running on.

If you have code or various flavors of the WordNet database that you
would like to share with others, at the present time we prefer that
you keep the data at your site, announce it to users via the mailing
list, and make it available to interested parties either via 'ftp' or
e-mail.  If your site does not allow anonymous ftp, then we will
consider moving the data to Princeton.  Requests of this sort should
be addressed to 'wn-users-request@princeton.edu'.

To help with the administrative end of things, items sent to
'wn-users-request@princeton.edu' should use the 'Subject' of the
message to convey the intent of the request.  To be added to the
mailing list, please specify a subject of 'Add user'.  Similarly, to
be removed from the list, specify a subject of 'Remove user'.  Other
types of requests should attempt to make intelligent use of the
message subject.

PS.  Administrative requests may only be handled once a week so please
be patient. 
