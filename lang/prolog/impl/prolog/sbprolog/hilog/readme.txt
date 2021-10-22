A prototype implementation of SB-HiLog is now available from SUNY Stony
Brook via anonymous FTP.  This implementation currently runs under
Quintus Prolog and SB-Prolog.

To retrieve the distribution, ftp to sbcs.sunysb.edu (130.245.1.15).
Use "anonymous" for the login name, and your own login for the password
(although I have found that "guest" works just as well).  Then get
pub/hilog/hilog.tar.Z (remember to use binary mode for the transfer).
This is a compressed tar file that contains the contents of the hilog
distribution directory.  The files in that directory are the following:

	COPYING		license and distribution information
	README		this file
	hilog.doc	how to run HiLog
	intro.tex	an introduction to the HiLog language
	example.hl	some HiLog examples

	hilog.pl	HiLog to Prolog processor
	h_read.pl	HiLog read
	h_write.pl	HiLog write

	qhilog.pl	top-level load file for Quintus Prolog
	sbhilog.pl	top-level load file for SB-Prolog

	h_read		h_read.pl  compiled for SB-Prolog
	h_write		h_write.pl compiled for SB-Prolog
	reconsult.pl	implementation of reconsult/1 for SB-Prolog
	reconsult	reconsult.pl compiled for SB-Prolog

The HiLog system has been run successfully under Quintus Prolog release
2.4.2 on various Sun-3s with SunOS 3.4 and under SB-Prolog 3.0 on an
SGI Iris 4D/120 with IRIX System V Release 3.3.1.

You may report bugs and suggestions to kroe@sbcs.sunysb.edu.
