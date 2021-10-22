;;; Thu Jul 14 05:27:56 1994 by Mark Kantrowitz <mkant@GLINDA.OZ.CS.CMU.EDU>
;;; readme.txt -- 18439 bytes

**************************************************************************
*** PLEASE READ THIS FILE BEFORE RETRIEVING FILES FROM THE REPOSITORY. ***
**************************************************************************

Welcome to the CMU Artificial Intelligence Repository. 

This file contains important information concerning the repository and
conditions on use of the repository.  By retrieving files from the
repository, you signify your agreement to these conditions.

If you have not already read the file named 0.doc in this directory,
you should read it before this one.

*** [0] Table of Contents

This file is divided into the following sections:

    [1]  Conditions on Use of the AI Repository
    [2]  Introduction
    [3]  Retrieving Files by FTP and AFS
    [4]  Accessing the Repository by World Wide Web (WWW)
    [5]  Structure of the Repository
    [6]  Bug Reports
    [7]  Mailing List
    [8]  Contributing Files to the Repository
    [9]  CD-ROM
    [10] Miscellaneous
     

*** [1] Conditions on Use of the AI Repository

1. LACK OF WARRANTY. This software is made available "AS IS" and is
   distributed without warranties of any kind, either expressed or
   implied, including, without limitation, the implied warranties of
   merchantability and fitness for a particular purpose. No warranty is
   made about the software or its performance.

   Carnegie Mellon University and the repository maintainer(s) do not
   accept any responsibility to anyone for the consequences of using
   materials from the repository or for whether such materials serve any
   particular purpose or work at all.

   In no event will Carnegie Mellon University or the repository
   maintainer(s) be liable to you for damages, including lost profits,
   lost monies, or other special, incidental or consequential damages
   arising out of or in connection with the use or inability to use
   (including but not limited to loss of data or data being rendered
   inaccurate or losses sustained by third parties or a failure of the
   program to operate as documented) the program, even if you have been
   advised of the possibility of such damages, or for any claim by any
   other party, whether in an action of contract, negligence, or other
   tortious action.

   Carnegie Mellon University and the repository maintainer(s) are under
   no obligation to provide any services, by way of maintenance, update,
   or otherwise.

   Inclusion of materials in the repository does not constitute an
   endorsement of the materials and shall not be interpreted as such.
   
2. EXPERIMENTAL NATURE OF THE MATERIALS. The materials included in the
   repository are to be considered experimental in nature. You assume any
   and all risk involved in using the software and agree to indemnify
   Carnegie Mellon University and the repository maintainer(s) against
   any and all actions arising from its use.

3. FREELY DISTRIBUTABLE and FREE USAGE. Use and copying of the
   software and the preparation of derivative works based on this
   software are permitted. Public domain software and software covered by
   the GNU General Public License automatically meet this definition. (To
   save space, a single copy of the various versions of the GNU GPL
   have been placed in the directory copying/gpl/)

   Copyrighted software will be included if and only if the author(s)
   agree to let the software be distributed and used without fee. The
   authors of copyrighted software may place certain other restrictions
   on the software, such as restrictions against the commercialization of
   the software. See 4 for details.

4. OTHER CONDITIONS. Some of the software packages included in the
   repository contain additional restrictions on their use. Conditions
   specific to a particular program or system will be included in a file
   named LICENSE, COPYING, and/or COPYRIGHT in the tar file
   containing the program. You agree to adhere to these conditions.  Any
   copyright notice or file must be left intact and included with any
   copy of the software or materials.

   In particular, some packages may contain restrictions against the
   commercialization of the software. Separate licensing is often
   available for companies wishing to commercialize the software or to
   incorporate the software into a commercial product. Contact the
   author(s) for details.

   Other packages may go one step further, and restrict the software
   license to non-commercial (education, research, and personal use)
   purposes. There is an important difference between "restrictions on
   commercialization" and "prohibition of commercial use". If you just
   want to prevent folks from selling your program or incorporating it
   into a commercial product, we recommend using the former.

   If we feel that an author's conditions unduly restrict the ability to
   distribute, use, and modify the software, we will not include it in
   the repository. The file copying/non_gpl/template.txt contains a template 
   for an acceptable copyright notice if you're cooking up one from
   scratch (the GNU GPL is also acceptable). 

5. COURTESIES. Producing free software takes time, effort, and money.
   There are certain courtesies that the authors request, and we
   strongly urge you to adhere to:

      -  If requested by the author(s), send a short E-mail note to
         them if you're actively using the software. Provide details
         if you have made any noteworthy uses of the material. This
         helps satisfy their curiousity, and can also help them
         justify their research to funders (or tenure committees).

      -  Sending changes, bug-fixes, and improvements to the author(s)
         to let them incorporate them into the original. This helps
         prevent the creation of many similar but divergement
         versions. Some authors ask that changes to the software be
         clearly documented in a change log.

      -  All materials developed as a consequence of the use of the
         software or other materials shall duly acknowledge such use,
         in accordance with the usual standards of acknowledging
         credit in academic research. Failure to give proper credit
         may be considered plagiarism.

6. REPOSITORY COPYRIGHT. 

   The Repository is Copyright (c) 1993-94 by Mark Kantrowitz. 
   All rights reserved. 

   Individual files in the CMU AI Repository are owned by their
   respective copyright holders. No copyright is claimed on the
   individual files, with the exception of files written by Mark
   Kantrowitz, including the 0.doc files.  We do not claim any form of
   compilation copyright.

   Files from the repository, including the 0.doc files, may be freely
   redistributed, subject to any conditions placed on the files by
   their copyright holders. The 0.doc files may not be sold for profit
   or included in commercial documents (e.g., published on CD-ROM,
   floppy disks, books, magazines, or other print form) without the
   prior written permission of the copyright holder.

   Permission is expressly granted for major sections of the
   repository to be made available for file transfer (mirrored) from
   installations offering unrestricted anonymous file transfer on the
   Internet, provided the readme.txt file is included intact. 

   The purpose of this copyright notice is to

      (1) ensure that sales of any CD-ROMs containing the AI Repository 
          in whole or in significant part contribute to the expansion of 
          the repository, and

      (2) ensure that any for-profit publication of the repository adheres
          to the copyright restrictions placed on the individual files 
          by their authors/owners. 
   
*** [2] Introduction

The Artificial Intelligence Repository was established by Mark
Kantrowitz in 1993 to collect files, programs and publications of
interest to Artificial Intelligence researchers, educators, and
students. It is an outgrowth of the Lisp Utilities Repository
established by Mark in 1990 and his work on the FAQ (Frequently Asked
Questions) postings for the AI, Lisp, Scheme, and Prolog newsgroups.
The Lisp Utilities Repository has been merged into the AI Repository.

We'd like to thank Rich Morin of Prime Time Freeware and Raj Reddy of
Carnegie Mellon University for their enthusiastic support of this
project.

The AI Repository is accessible by anonymous FTP and AFS without
charge. A subset of the contents of the repository will also be
published by Prime Time Freeware as an inexpensive mixed-media
(Book/CD-ROM) publication.

The repository contains
   -  AI programming language implementations, including Lisp, Prolog,
      and Scheme

   -  Software in all areas of AI, including (but not limited to)

	AI Architectures      		Natural Language Generation
	Analogical Reasoning		Natural Language Understanding
	Artificial Life     		Neural Networks           
	Case Based Reasoning		Parsing                 
	Classical AI Programs		Planning
	Corpora              		Probabilistic Reasoning
	Distributed AI        		Qualitative Reasoning
	Expert Systems        		Robotics
	Fuzzy Logic         		Search
	Game Playing        		Speech Synthesis
	Genetic Algorithms      	Speech Understanding  
	Knowledge Representation	Theorem Proving
	Legal Reasoning         	Truth Maintenance
	Machine Learning        	Vision
	Medical Reasoning         

   -  Announcements of current conferences, courses, talks, and workshops, 
      including calls for papers.

   -  Technical reports, abstracts, bibliographies, theses, books,
      book reviews, survey articles, and frequently asked questions (FAQ)
      postings. 

   -  Archives of mailing lists and newsgroups.

*** [3] Retrieving Files

The AI Repository is kept in the Andrew File System (AFS) directory 
   /afs/cs.cmu.edu/project/ai-repository/ai/
and its subdirectories. Files may be retrieved using either AFS or
anonymous FTP.

If your site runs AFS, you can just cd to this directory and copy the
files directly. Many schools, laboratories and corporations now run
AFS.  Further information about AFS can be obtained by sending email
to afs-sales@transarc.com.

If your site does not run AFS, you can still get the files by
anonymous ftp from
   ftp.cs.cmu.edu:/user/ai/   [128.2.206.173] 
Use username "anonymous" (without the quotes) and typing your email
address (in the form "user@host") as the password. 

(If you try to cd to the /afs/cs.cmu.edu/project/ai-repository/ai/
directory while connected via anonymous ftp, you must cd in one atomic
operation, as the CMU security mechanisms prevent access to superior
directories from an anonymous ftp. If you use the /user/ai/ alias you
won't have any problems.)

The following is an example of using ftp to retrieve the software:

   % ftp ftp.cs.cmu.edu
   Connected to MULBERRY.SRV.CS.CMU.EDU.
   220 MULBERRY.SRV.CS.CMU.EDU FTP server (Version 4.105 of 10-Jul-90 12:07) \
   ready.
   Name (ftp.cs.cmu.edu:mkant): anonymous
   331 Guest login ok, send username@node as password.
   Password:
   230-Filenames can not begin with "/.." .
   230-Other than that, everything is ok.
   230 User anon logged in.
   ftp> cd /user/ai
   250 Directory path set to /user/ai.
   ftp> pwd
   257 "/afs/cs.cmu.edu/project/ai-repository/ai" is current directory.
   ftp> ls
   200 PORT command successful.
   150 Opening data connection for ls (128.2.222.137,4585).
   areas
   copying
   doc
   events
   file_ext.txt
   lang
   ls-Rla.gz
   new
   ptfai
   pubs
   readme.txt
   todo.txt
   util
   226 Transfer complete.
   1152 bytes received in 0.6 seconds (1.9 Kbytes/s)
   ftp> quit
   221 Goodbye.

If you will be transfering compressed (gzipped) files, be sure to type
the "binary" command before retrieving the files. The "get" command is
used to get a single file, and "mget" to retrieve multiple files using
wildcards.  If you're using the "mget" command, you might want to turn
off prompting first by using the "prompt" command.

*** [4] Accessing the Repository by World Wide Web (WWW)

The AI Repository's home page is
   http://www.cs.cmu.edu:8001/Web/Groups/AI/html/repository.html

*** [5] Structure of the Repository

The main directories of the AI Repository are as follows:

   readme.txt		This file.
   ls-Rla.gz		The results of doing ls -Rla on the repository.
   areas/               AI software and other materials organized according 
                        to topic or field. 
   copying/             Copies of the GNU GPL and various other copyright
                        notices.
   doc/                 Information related to ftp sites, bitftp,
                        ftpmail, etc.
   events/		Calendar of events, including conferences,
			workshops, and other meetings and announcements. 
   file_ext.txt		File extensions in use in the repository.
   html/                Mosaic-related documents, FAQ files, etc.
   lang/		Programming language implementations, including
			Lisp, Scheme, and Prolog.
   ls-Rla.gz		The results of running ls -Rla on the repository.
   ptfai/		Administrative materials related to the AI CD-ROM
   pubs/		Publications including technical reports, FAQ
			postings, theses, mailing list archives, etc.
   util/		Compression and archiving software (gzip, tar, etc.)

The repository has standardized on using 'tar' for producing archives
of files and 'gzip' for compression. For example, shell archives have
been replaced with tar files, and compressed files (.Z) recompressed
using GZIP (.gz). GZIP uses the Lempel-Ziv algorithm (LZ77), and
generally achieves better compression than LZW (compress), Huffman
coding (pack) and adaptive Huffman coding (compact), and is patent
free. Implementations exist for VMS, MSDOS, OS/2, Atari, Unix, and
Macintosh; see the util/ directory for copies of the sources.

Packages that are intended solely for use on a PC or Macintosh may be
archived using the formats common on those machines, such as zip, sit,
cpt, and hqx. The util/ directory contains tools for manipulating
these files on other systems.

Due to its size, the repository is split among several disk
partitions. So cding to a directory may actually move you to a
different partition. Nevertheless, each partition mimics the entire
directory structure, so that
   cd .. 
will actually work as expected.

Further information on a package, such as a description of the
contents, mailing lists, E-mail addresses for bug reports, and so on,
will be included in a file named 0.doc in the package's directory. 

*** [6] Bug Reports

Bug reports, comments, questions and suggestions concerning the repository
should be sent to Mark Kantrowitz <AI.Repository@cs.cmu.edu>. Bug
reports, comments, questions and suggestions concerning a particular
software package should be sent to the address indicated by the author.

Bug reports, comments, questions and suggestions concerning programs
in the Lisp section of the repository should also be CCed to
Lisp-Utilities-Request@cs.cmu.edu. Please send us copies of any
changes or improvements you make to the software, so that we may merge
them into the originals. Please be patient -- Mark is an nth-year
graduate student, so his thesis work takes priority. But as time
permits, he'll try to incorporate your suggestions and improvements
into the programs included in the repository.

*** [7] Mailing Lists

The mailing list Lisp-Utilities@cs.cmu.edu is a moderated low-volume
mailing list for matters concerning the Lisp section of the
repository. It is primarily intended for notification of updates to
the repository, but other relevant messages may also be included, at
the discretion of the moderator.

If you use any of the programs included in the Lisp section of the
repository, you should join this mailing list. To subscribe, send a
message to Lisp-Utilities-Request@cs.cmu.edu with your name, your
Internet email address, and your affiliation (e.g., company name,
university, etc.) if any, in the following format:

   first-name middle-initials last-name, affiliation <email-address>

Matters concerning the repository as a whole or other sections of the
repository will be posted to the relevant newsgroups.

*** [8] Contributing Files to the Repository

For a program to be included in the Repository, it must be "freely
distributable". The author(s) may retain a copyright on the programs,
but must allow anybody to copy and use the files without charge. If
the author(s) later decide to commercialize the program, the version
included in the Repository will remain available for free.

Programs that have been placed in the public domain (e.g., by the
author publicly announcing "I place this program in the public
domain") may also be included in the repository, since by placing a
program in the public domain, the author has given up all rights to
the program.

A package must, in general, include the source code in the distribution
for us to consider adding it to the repository. 

If you would like to contribute a program or other files to the
Repository, send a message to AI.Repository@cs.cmu.edu. 

*** [9] CD-ROM

A portion of the contents of the repository will also be published by
Prime Time Freeware on two ISO-9660 CD-ROMs bound into a
200-page book. It will sell (list) for $60 US.  Each CD-ROM will
contain approximately 600 megabytes of gzipped archives (more than 2
gigabytes uncompressed and unpacked).  Sales of the CD-ROM(s) will
help support the future expansion of the repository. For further
information on the CD-ROM, please contact

   Prime Time Freeware
   370 Altair Way, Suite 150
   Sunnyvale, CA 94086, USA
   Tel: +1 408-433-9662
   Fax: +1 408-433-0727 
   E-mail: ptf@cfcl.com

We expect to have the CD-ROMs ready for AAAI-94.

*** [10] Miscellaneous

If you find a particular program or publication to be extremely
useful, consider donating money to or otherwise supporting the
university or laboratory that produced the software, to help them fund
further research.

If you are interested in supporting the development of free software,
the Free Software Foundation (675 Massachusetts Avenue, Cambridge, MA
02139, e-mail gnu@prep.ai.mit.edu, phone +1 617-876-3296) is a leader
in the field.

;;; *EOF*
