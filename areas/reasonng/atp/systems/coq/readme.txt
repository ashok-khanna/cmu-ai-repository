This is Coq Version 5.8.3, the Calculus of Inductive Constructions in
Caml-Light.

The official distribution of Coq V5.8 is available from
ftp.inria.fr:INRIA/coq/V5.8.3

To run Coq, you need a system with:
- a C compiler (required),
- a X library (libX11.a) and its includes (/usr/include/X11) (optional).
- the Caml-Light system, version 0.5 or version 0.6.
- the CAML-Light UNIX compatibility library (contrib/libunix)
  (this is NOT optional!)

If you do not have Caml-Light, you can get it from
ftp.inria.fr:lang/caml-light.

To install, read the file INSTALL.  If you encounter problems, please
contact the Coq hotline (coq@pauillac.inria.fr).  The binaries for sun4
are provided, but you will still need to manually edit the "coql"
script, as indicated in INSTALL.

If you have a problem with running Coq after it is built, please verify
that the environment variable ARCH is set to your architecture, e.g.
"sun4" for sparcs, "alpha" for a DEC Alpha.

Directories:
- SRC		The Constructions source code
- LIB		Various utility libraries of CAML-Light code
- RELEASED	a tree of symlinks to executables for various architectures
            ONLY the sun4 executables are provided - for the others,
            please do a build, as specified in the file INSTALL.
- THEORIES	library of Coq Vernacular scripts
- DOC       The Coq User's Guide, in dvi and ps formats
- MAC       The directory containing a binary-only BinHex'd
            CompactPro archive of Coq V5.8 for the Macintosh

Files:
- coql		shell to execute Coq (released version)

The paper version of the Coq User's Guide may be ordered from INRIA
as Rapport Technique No 154, Mai 1993.
