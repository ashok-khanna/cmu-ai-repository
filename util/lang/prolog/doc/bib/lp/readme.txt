This directory contains the references to most of the proceedings of
the last 

   - ICLP  (International Conference on LP)
   - SLP   (Symposium on LP)
   - NACLP (North American Conference on LP) 

in bibtex format. 

The directory "bibtex" contains the ".bib" database files. All files
are in compressed format: therefore use "binary" mode to transfer
files and

      uncompress <file>

on your local host to retain the uncompressed version.

Our ftp server supports "tar'ing" on the fly: if you type

        get bibtex.tar

you'll get a tar'ed version of directory "bibtex".



The files "patch<n>.Z" are provided, to allow you to fetch only the
differences to previous releases: if you already have a distribution
with patchlevel <n> then you can bring it to patchlevel <n+1> by only
fetching the file "patch<n+1>.Z". Then "cd" to the directory where
your ".bib" files are, uncompress "patch<n+1>" and simply type:

     csh patch<n+1>

This procedure only works if you have already installed the "patch"
program by Larry Wall.

You can find out which patchlevel you have by looking into the file
"patchlevel" in directory "bibtex" (if there is no file named
"patchlevel" you have got patchlevel 0).

Support of patch files is due to Andreas Kagedal <aka@ida.liu.se>, who
provided us with a nice shell script to generate them.


We are interested in any kind of feedback. So if you have any
comments, suggestions, found some typing errors, inconsistencies or
errors, please let us know, especially if you already have recorded
some of the missing proceedings or issues of the Journal of LP. You
can directly mail to:

        rscheidhauer@dfki.uni-sb.de


Following the list of changes:
 

June, 30  1994 (patchlevel 14):
    
     - updated @Proceedings-Entry of EPIA93.bib
     - added PEPM91 and PEPM93 (thanks to Harald Sondergaard <harald@cs.mu.OZ.AU>)
     - Fixed some bugs in JICSLP92, PLILP90, PLILP91, PLILP92, RTA89,
       ILPS93, SLP86
     - Changed address field of of @proceedings entry of ILPS93 to "Vancouver".
     - Cleanups in JSC91/92, JLP91/92/93: "\&" replaced by "and",
       number and month entries adjusted
     - Cleaned up and completed JLP93
     - Added JSC93, JAR93

January,27  1994 (patchlevel 13):

     - Fixed typos in ICLP90, EPIA89, FGCS92, ICLP88
     - Added FAC.bib (thanks to Michael Jampel <jampel@cs.city.ac.uk>)
     - Added two missing entries to NACLP89 (thanks to Peter Szeredi <szeredi@iqsoft.hu>)
     - Newest version of IANDC.bib included
     - JSC92, ICLP82: cite keys made unique
     - added ILPS93.bib (International LP Symposium)


September, 10 1993 (patchlevel 12):

     - Fixed a typo in ICLP93.bib
     - Added EPIA91, EPIA93, EAIA90 (thanks to Joaquim Baptista <px@fct.unl.pt>)



September, 3 1993 (patchlevel 11):

     - Added RTA93.bib(thanks to uwe@mpi-sb.mpg.de (Uwe Waldmann))
     - Separated entries in PLILP92.bib by newlines
     - Added ICLP93.bib

     
April, 27 1993 (patchlevel 10):

     - Fixed some typos (thanks to px@fct.unl.pt and spa@fct.unl.pt)
     - Added number 5 and 6 to JSC92.bib
     - Added TAPSOFT93.bibi (thanks to Uwe Waldmann <uwe@mpi-sb.mpg.de>)


February, 15 1993 (patchlevel 9):

     - Added IANDC.bib and TACS91.bib (thanks to "Ralf Treinen"
       <treinen@dfki.uni-sb.de> )
     - Added PLILP92.bib (thanks to Anne.Mulkers@cs.kuleuven.ac.be)
     - Made cite key of Shapiro89 in EPIA89.bib unique


February, 11, 1993 (patchlevel 8):

    - Added CTRS92.bib (thanks to "Uwe Waldmann" <uwe@mpi-sb.mpg.de>)
    - Added EPIA89.bib (thanks to "Joaquim Baptista" <px@fct.unl.pt>)
    - To remove a source of confusion: managed that the file
      "patchlevel" always contains the actual number of the current
      patchlevel (so you didn't miss anything if your old file says
      that you were on patchlevel 6, and the new one says "patchlevel
      8")


February, 3, 1993 (patchlevel 7):

    - Renamed ICOT92.bib to FGCS92.bib (including cite keys, sorry)
    - Removed LICS90.bib and added lics.bib from
      theory.lcs.mit.edu:/pub/meyer, which contains the complete and
      official LICS bibliography. This file will be updated once a
      week from now on.
    - Completed JSC91
    - Added JAR92.bib, JSC92.bib, JLP93.bib, JLP93.bib
    - Fixed some typos
    - Changed cite key for "Robinson86" in ICLP86.bib, to make it
      unique with "lics.bib"
     

January, 13, 1993 (patchlevel 6):

   - Added ALP90.bib ALP92.bib CADE90.bib CADE92.bib CTRS90.bib
     LICS90.bib UNIF89.bib 
     (thanks to Uwe Waldmann <uwe@mpi-sb.mpg.de>)


November, 30, 1992 (patchlevel 5):

   - Added JICSLP92



October, 30, 1992 (patchlevel 4):

   - Added ICOT92
   - Removed double editor field in @proceedings entry of ICLP82
   - Added ALPUK91 and LP88 (thanks to Tim Duncan <timd@aiai.edinburgh.ac.uk>)
   - Added PLILP91 (thanks to Gregor Meyer <GMEYER@DS0LILOG>)


February, 13, 1992 (patchlevel 3):

   - Added JAR91 and JSC91
   - Added entries to JLP91 for volume 11
   - Fixed various typos due to comments of Andreas Kagedal <aka@ida.liu.se>
   - Made all cite keys unique (thanks again to Andreas Kagedal)



December, 13, 1991 (patchlevel 2):

   - SLP87: replaced fields booktitle, year, publisher, address and month
     in every @InProceedings entry by the crossref feature
   - 
   - added SLP84
   - modified the directory structure, added patch files and a
     complete tar file
   - added or changed the @proceedings entry of (due to some comments 
     of Andreas Kagedal <aka@ida.liu.se>):
         ICLP*, SLP87, NACLP*, PLILP90
   - added address entry to NACLP89
   - added organization entry to NACLP90
   - changed address entry of @proceedings entry of NACLP90, ICLP91, 
     SLP91, SLP87
   - fixed typos in entry for NACLP89, ICLP87, ICLP88, SLP85, JLP85,
     SLP91
   


November, 11, 1991:

  - added JLP85.bib, ..., JLP91.bib
  - added SLP91.bib
  - added ICLP84.bib
  - added ICLP82.bib


October, 2, 1991:

  - added SLP86


September, 30, 1991:
   
  - added RTA89 (thanks to Nachum Dershowitz <nachum@cs.uiuc.edu>)
  - added PLILP90 (thanks to Hans-Guenther Hein <hein@dfki.uni-kl.de>)


September, 26, 1991:

  - moved the "@Proceedings" entry to the end of the files
  - fixed some typing errors
  - added NACLP89 (thanks to Hans-Guenther Hein <hein@dfki.uni-kl.de>)
  - added SLP85, SLP87
  - all files now in compressed format
  - augmented "@Proceedings" entries


