This directory contains a collection of files related to Tcl and
Tk, which are available for anonymous FTP.  Below is a description
of what is in the various files in this directory:

tk3.6.tar.Z -		This is the latest and most stable release of the
			Tk toolkit, released in November 1993.  It includes
			the sources for the Tk library and the "wish"
			windowing shell, plus reference manual entries and
			a number of demonstration scripts.

tk3.6p1.patch -		Patch file that fixes bugs in Tk version 3.6.
			See the beginning of the patch file for information
			about the bugs it fixes and how to apply it.

tcl7.3.tar.Z -		This is the latest and most stable release of the
			Tcl library, released in November 1993.  It includes
			the sources for the Tcl library and the "tclsh"
			application, plus reference manual entries.

tclX7.3a.tar.Z -	Extended Tcl (or NeoSoft Tcl), created by Mark
			Diekhans and Karl Lehenbauer, which adds a number
			of useful facilities to the base Tcl release.
			Among the things in Extended Tcl are a Tcl shell,
			many new commands for things like UNIX kernel
			call access, keyed lists, and time conversion, and an
			on-line help facility.  This package works with Tcl
			versions 7.3 or later and Tk versions 3.6 or later.

mx.tar.Z -		Sources and documentation for a mouse-based text
			editor (mx) and terminal emulator (tx) based on
			Tcl.  This is a very old release:  it uses an old
			version of Tcl (which is included) and doesn't
			even use Tk;  it uses an ancient toolkit called
			"Sx".  These tools will eventually be replaced
			with new tools based on Tk and the newest Tcl.

mx-2.5.tar.Z - 		Newer version of mx (see above) that uses the
			standard X selection mechanism rather than the
			homegrown mechanism used by previous versions. 
			Version 2.5 is not backwards compatible with 
			previous versions (you can't cut and paste between
			the two). Still uses sx and an old version of 
			Tcl (both of which are included).

mx-2.5.patch.Z -	Patch file for converting mx 2.4 sources into 2.5.
			Invoke patch in the top-level mx directory
			with the "-p1" switch and an uncompressed version of
			this file, e.g. "patch -p1 < mx-2.5.patch".

book.p1.ps.Z		Compressed Postscript for a draft of the first part
			of an upcoming book on Tcl and Tk to be published in
			1994 by Addison-Wesley.  This part of the book
			describes the Tcl language and how to write scripts
			in it.  About 130 pages in length.

book.p2.ps.Z		Compressed Postscript for a draft of the second part
			of an upcoming book on Tcl and Tk to be published in
			1994 by Addison-Wesley.  This part of the book
			describes how to write Tcl scripts for Tk.  About
			125 pages in length.

book.p3.ps.Z		Compressed Postscript for a draft of the third part
			of an upcoming book on Tcl and Tk to be published in
			1994 by Addison-Wesley.  This part of the book
			describes how to write Tcl applications in C, using
			the Tcl library procedure.  64 pages in length.

book.p4.ps.Z		Compressed Postscript for a draft of the last part
			of an upcoming book on Tcl and Tk to be published in
			1994 by Addison-Wesley.  This part of the book
			describes how to write new widgets and geometry
			managers in C, using the Tk library procedure.  About
			70 pages in length.

tclUsenix90.ps -	Postscript for a paper on Tcl that appeared in the
			Winter 1990 USENIX Conference.

tkUsenix91.ps -		Postscript for a paper on Tk that appeared in the
			Winter 1991 USENIX Conference.

tkF10.ps -		Postscript for Figure 10 of the Tk paper.

tut.tar.Z -		A collection of materials from a full-day tutorial
			on Tcl and Tk.  Includes viewgraphs from five one-hour
			talks plus a sample widget.

tclCover.tar.Z -	Winning entries in the Tcl/Tk book cover contest
			(unpacks to about 5 Mbytes).

tc-tcl93.ps.gz -	PostScript formatted copy of Tcl Compiler paper
			presented at the Tcl'93 Workshop.
tc-tcl93.tex.gz -	LaTeX source for the Tcl Compiler paper presented
			at the Tcl'93 Workshop.

In addition, there may be older releases of some or all of the above
files;  look for files with earlier release numbers.

Be sure to retrieve files in image mode (type "type image" to FTP)
in order to make sure that you don't lose bits.

Most of these files are compressed tar files;  to get back the
original directory hierarchies, type a command like the following for
each file you retrieved:
		zcat tk3.6.tar.Z | tar xf -
This will create a directory named tk3.6 with all the source files and
documentation for that release.  There will be a README file in the
tk3.6 subdirectory that tells what to do next.

Any file with a .gz extension is a file compressed with gzip, the gnu
portable compression standard.  To get a copy, ftp to prep.ai.mit.edu and 
look in pub/gnu.  For example, to uncompress tc-tcl93.ps.gz, type

    gunzip tc-tcl93.ps.gz

once you've retrieved the file.  This will produce a file named "tc-tcl93.ps".

Each of the releases has a README file in the top-level directory that
describes how to compile the release, where to find documentation, etc.

Questions or problems with any of these distributions should be directed
to John Ousterhout (ouster@cs.berkeley.edu).
