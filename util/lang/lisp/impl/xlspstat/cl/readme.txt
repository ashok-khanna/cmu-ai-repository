This directory contains Lisp-Stat 1.0 Alpha 1, a first attempt at
producing a Common Lisp version of Lisp-Stat. This version contains NO
graphics, but should implement all the non-graphical facilities of
Lisp-Stat.

The implementation uses C code from XLISP-STAT for linear algebra and
probability distributions, so this code is dependent an a CL's foreign
function interface. At this time, three CL's are supported: AKCL (at
least verision 1-600) for UNIX systems, Franz' Allegro CL for UNIX
systems, and Macintosh CL (version 2.0b1). Separate README files
describe each version

The object system is the system described in the Lisp-Stat book. Its
implementation is in the file lsobjects.lsp in this directory and also
included in the tar file.

On A DEC 3100 or 5000 the AKCL version of Lisp-Stat runs about half as
fast as xlispstat on a standard battery of tests if xlispstat is given
an (expand 30) command. I seem to recall that on a sun3 this the AKCL
code and xlispstat code run at about the same speed. I have not yet
confirmed this. If so, then the relative performance of the AKCL
version to xlispstat may be quite hardware-dependent. The Allegro
version on a DEC 5000 is considerably slower and larger than the AKCL
version, but I have not yet figured out how to tune Allegro's memory
management. The Macintosh CL version seems to run at least as fast as
xlispstat on the Macintosh.

To port this code to another CL, you need to

	Edit defsys.lsp to add any necessary definitions

	Add a top level to lstoplevel.lsp (this is only needed if you
	want to recover the history mechanism, which is broken by
	shadowing *, etc.)

	Write versions of the lisp and/or C glue files to interface to
	the C code in lib.

	Experiment with tuning the memory management to run reasonably
	in statistical applications.

If you do port this code to another CL, please let me know so I can
add it to this distribution.

Luke Tierney
School of Statistics
University of Minnesota
Minneapolis, MN 55455
luke@umnstat.stat.umn.edu
