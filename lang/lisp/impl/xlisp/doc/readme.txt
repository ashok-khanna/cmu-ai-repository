This directory (folder) contains the distributions of XLISP v2.0 for
IBM PC (and other MSDOS machines), Atari ST, and Macintosh.  XLISP was
developed by David Betz, and it is distributed free of charge.  Please
refer to the appropriate XLISP.DOC file for details and restrictions.

You do not need to retrieve all of the files in this directory.  These
files are stored in several formats, so choose the one appropriate for
your uses.  The *.arc files are in ARC format, which is a compressed,
binary archive format which can be unpacked using any of several
widely available shareware or public domain programs.  The *.ua? files
are the same *.arc files encoded as 7-bit ASCII files (see below for
unpacking instructions).  Similarly, the *.fit files are Macintosh
"StuffIt" (binary) archives, and the *.hq?  encoded versions of the
*.fit files (again, see below).  The *.txt files are plain text.

Here is a list of the various files in the distribution, along with
descriptions of their contents:

ibmpcsrc.arc	PC/MSDOS system specific sources
xlispshar.??.Z	The pieces necessary to build a Unix port of XLISP,
			in compressed shell archive format.  Note
			that the uxstuff.c from v1.7 and the ststuff.c
			from v2.0 are provided as examples for one to
			build a uxstuff.c for v2.0 (see Makefiles, too).
xlisplsp.arc	Example LISP files
xlisplsp.fit		(same)
xlispmac.fit	Macintosh executable, doc, and system specific sources
xlisppc.arc	PC/MSDOS executable and doc
xlispref.txt	Tim Mikkelsen's Reference manual (very nice)
xlispsrc.arc	Generic source code
xlispsrc.fit		(same)
xlispst.arc	Atari ST executable, doc, and system specific sources


Again, refer to the legend above to determine which .arc or .fit files
you need.  If you can do binary file transfers of arbitrary size, then
you will be best off requesting the .arc or .fit files themselves.
Otherwise (e.g. if the .arc or .fit files are not present, or your
transfer medium can't handle them), you must to retrieve the .ua?
or .hq? files which correspond to the things you want, and then
reconstitute them from the pieces you retrieve.

As noted above, all of the .arc files have been encoded as text using
a modified version of uuencode.  If you have a version of Dumas' "uud"
you can use that to unpack the .arc file from the .ua? files which
make it up.  If you only have the vanilla (Unix-style) uudecode
program, you must concatenate the .ua? files into a single file,
removing the lines (the 'include' line through the 'begin' line,
inclusive) between the pieces, and pass the result through the
normal uudecode program to produce the .arc file.

The .fit files have been encoded as text using BINHEX 4.0, and sliced
up into pieces smaller than 32k in size.  These pieces (the .hq?
files) must be concatenated (editing out the "cut here" lines and any
junk between pieces) to produce a .hqx file which can then be decoded
using BINHEX to produce the .fit file.

If you have problems with retrieving or unpacking this distribution,
please contact the administrator of this area.  If you cannot get
help from them, then you may contact me at the address below.

-- 
Marion Hakanson         Domain: hakanson@cs.orst.edu
                        UUCP  : {hp-pcd,tektronix}!orstcs!hakanson
