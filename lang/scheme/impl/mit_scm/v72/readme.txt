-*- Indented-Text -*-

For information on installation, read the file INSTALL (also included
in the binary distribution for your machine).


		Description of the distribution files

MIT Scheme is being distributed as a set of compressed tar files.
Choose the files that are appropriate for your site.

For the moment, the distribution is only available for the machines
and operating systems listed below.  The compiler is currently ported
to six architectures: MC68020-40, HP Precision Architecture, MIPS
R2000+, DEC VAX, Intel i386/i486 and DEC Alpha.  However, the
preliminary 7.2 distribution is ready only for those processors and OS
combinations listed below.  If your machine contains one of those
processors but you are running on a different OS, AND you are willing
to do the work required to bring it up (a few hours), contact us at
the mailing address below.

For an MS-DOS distribution, look at the README.TXT file in the DOS-386
directory.

This is a preliminary release, provided now mostly because it runs on
more hardware than the 7.1 release.  This version is essentially a
snapshot of the system under development at MIT, and has not been
pounded on (on alternate hardware) as much as the 7.1 release.
In addition, the documentation listed below matches the 7.1 release,
not this version.  However, it is not terribly wrong.

This distribution is not currently available on magnetic tape from
MIT.

Important: The system CANNOT be brought up just from the sources.
You need Scheme binaries (not C/Unix binaries) for the architecture
(and endianness, when applicable) you are trying to bring it up on.

Archive File	Description
-------------	--------------------------------------------------
INSTALL		Installation instructions.  Also included in each
		binary distribution.		

i386.tar.Z	Binary distribution for Intel 386/486-based machines
		running some variant of Unix.
		Note: read the file INSTALL in this directory before
		transferring this file and attempting the installation.
i386-bci.tar.Z	Optional debugging information files for i386.tar.Z

pmax.tar.Z	Binary distribution for MIPS-based DecStations running Ultrix.
pmax-bci.tar.Z	Optional debugging information files for pmax.tar.Z

sgi.tar.Z	Binary distribution for Silicon Graphics (MIPS) running Irix 4.0
sgi-bci.tar.Z	Optional debugging information files for sgi.tar.Z

src.tar.Z	Source code for the distribution.
bootstrap.scm	File to build Scheme binaries from sources.

scheme.ps.Z	MIT Scheme Reference Manual, compressed PostScript.
scheme.dvi.Z	MIT Scheme Reference Manual, compressed DVI.
user.ps.Z	MIT Scheme User's Manual, compressed PostScript.
user.dvi.Z	MIT Scheme User's Manual, compressed DVI.
r4rs.ps.Z	Revised^4 Report on Scheme, compressed PostScript.
r4rs.dvi.Z	Revised^4 Report on Scheme, compressed DVI.

info.tar.Z	GNU Emacs Info files for the MIT Scheme Reference
		Manual and the MIT Scheme User's Manual.

doc.tar.Z	Texinfo source files for the MIT Scheme Reference
		Manual, the MIT Scheme User's Manual.  LaTeX source
		for R4RS.  Cursory documentation for (unsupported)
		macros and the SCode abstraction.

sicp.tar.Z	Compatibility package to run examples and exercises
		from "Structure and Interpretation of Computer
		Programs" by Abelson & Sussman, with Sussman.

compdoc.tar.Z	Documentation on internals of the compiler and porting
		guide (preliminary).

xscheme.el
xscheme.elc	GNU Emacs interface.  Do not use the "xscheme" files
		that come with Emacs -- use these instead.


For bug reports or comments to the MIT Scheme implementors, send
computer mail to

    bug-cscheme@zurich.ai.mit.edu (on the Arpanet/Internet)

or US Snail to

    Scheme Team
    c/o Prof. Hal Abelson
    545 Technology Sq. rm 410
    Cambridge MA 02139

Other relevant mailing lists:

info-cscheme@zurich.ai.mit.edu
	Questions, notices of bug fixes, etc.  This list is the same
	as the usenet news group "comp.lang.scheme.c".

	Send mail to "info-cscheme-request" to be added.

scheme@mc.lcs.mit.edu
	Applications, mostly for educational uses.  This list is the
	same as the usenet news group "comp.lang.scheme".

	Note that this mailing list is NOT MIT Scheme specific.  It
	covers general language issues, relevant to all the
	implementations of the scheme language (MIT Scheme, Yale
	University's T, Indiana University's Scheme84, Semantic
	Microsystems' MacScheme, and Texas Instruments' PC Scheme
	among others).

	Send mail to "scheme-request" to be added.
