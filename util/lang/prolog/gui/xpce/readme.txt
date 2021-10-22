This directory contain:

     * General info in the file INFO

     * Licence agreement in licence.tex and licence.ps.Z.  To apply
       for XPCE, print this licence, fill it out and send two copies
       to:

       	        Ms. L. Zandvliet
		SWI
		University of Amsterdam
		Roetersstraat 15
		1018 WB  Amsterdam
		The Netherlands

       Afterwhich you will receive an invoice.  See also "INFO".

     * Demo version of XPCE/SWI-Prolog for PC/Linux.  See
       sub-directory linux.  This version has the complete
       functionality of the regular version and is updated
       regulary (at least as long as I run Linux at home, which
       will be for a while as it is a very good system).

     * PostScript version of the XPCE-4 documentation:

	# doc/userguide/userguide-*-*.ps.gz
	``Programming in PCE/Prolog''
 	Introduction in programming PCE/Prolog Split into 15 page units
	for printers with limited memory.

	# doc/overview/overview-*-*.ps.gz
	``PCE-4 Functional overview''
	General overview of PCE's functionality.

	# doc/classes/classes-*-*.ps.gz
	``User Defined Classes Manual''
 	Interface for defining PCE classes from Prolog.  (Draft).

	# doc/refman/refman-*-*.ps.gz
	``XPCE Reference Manual'', DRAFT Edition 0 for xpce-4.5.10
	INCOMPLETE Draft of the reference manual.  Covering graphics,
	text and unix interaction.

        # doc/interface/interface.ps.gz
	``Interfacing PCE to a Programming Language''
	Explains how PCE may be connected to another (symbolic)
	programming language.  This connection is established through C.

	# doc/lisp/pce-lisp.ps.gz
	``PCE / Common Lisp Interface''
 	Interface definition between PCE and Lisp implementations
	adhering to the Common Lisp standard (Steele II).  Implemented
	for Lucid Common Lisp and Harlequin LispWorks.

     *  lisp-interface.tar.gz
	Sources for the XPCE interfaces to Lucid CommonLisp and
	LispWorks.

PACKING/FORMATS

	* All files called .z or .gz are compressed using gzip.
	gzip is available from many ftp sites, including this
	one (/pub/gnu/gzip-1.2.2.tar.Z, *compress*'ed format).

	* All files called .tgz are gzipped tar images.  Using
	GNU-tar they may be extracted by

		% tar zxf file.tgz

	Using gzip and tar this becomes

		% gunzip < file.tgz | tar xf -

	* All files called .tar are tar(1) archive files

	* All files called .ps are TeX generated PostScript files
	for a 300 DPI PostScript printer.

     
    
