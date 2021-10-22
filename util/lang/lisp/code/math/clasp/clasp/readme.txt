Clasp release 1.3.2 is available via anonymous ftp from
ftp.cs.umass.edu.  It is in the directory /pub/clasp.  To build
clasp, download the file clasp-1.3.2.tar.Z and uncompress it using
the unix command:

uncompress clasp-1.3.2.tar.Z

untar it using the unix command:

tar -xvf clasp-1.3.2.tar

This will create a directory hierarchy under the directory clasp.  In
clasp/Docs/clasp-1.3.2 are two files, manual.ps is the clasp
manual, and release-notes.ps are the release notes, with full
instructions for building clasp.

Clasp runs on DecStation and SPARCstation plaforms running Lucid
Common Lisp with Clim 1.1.  The release notes have full information
regarding platforms and compatible lisp versions.

This directory contains the following files:
clasp-1.3.2.tar.Z             - compressed tar file w/ Clasp 1.3.2 sources and
				documentation
clasp-1.3.2-release-notes.txt - Clasp 1.3.1 release notes in text format
clasp-1.3.2-release-notes.ps  - Clasp 1.3.1 release notes in Postscript format
manual.ps                     - Clasp 1.3.1 manual in Postscript format
ps-fix.sed                    - used to fix postscript files produced
                                by Clasp (see the print command in the manual)
old/                          - older versions of Clasp
