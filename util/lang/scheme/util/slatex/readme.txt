readme
SLaTeX Version 2.2
(c) Dorai Sitaram, Rice University, 1991, 1994
dorai@cs.rice.edu

Subj. Read me first

Sec. 1. A brief description of SLaTeX

SLaTeX is a Scheme program that allows you to write
program code (or code fragments) "as is" in your LaTeX
or TeX source.  SLaTeX is particularly geared to the
programming languages Scheme (R4RS) and other Lisps,
e.g., Common Lisp.  The formatting of the code includes
assigning appropriate fonts to the various tokens in
the code (keywords, variables, constants, data), at the
same time retaining the proper indentation when going
to the non-monospace (non-typewriter) fonts provided by
TeX.  SLaTeX comes with two databases that recognize
the identifier conventions of Scheme and CL
respectively.

While it is certainly possible to get by with a minimal
knowledge of SLaTeX commands, the package comes with a
variety of features for manipulating output
positioning, modifying/enhancing the database, changing
the fonting defaults, adding special symbols, and
selective disabling of SLaTeX.  For a detailed
documentation of SLaTeX, run slatex on the file
slatex-d.tex in the SLaTeX distribution after finishing
the installation process.

Sec. 2.  Obtaining SLaTeX

SLaTeX is available via anonymous ftp from cs.rice.edu
(or titan.cs.rice.edu).  Login as anonymous, give your
userid as password, change to the directory
public/dorai, convert to bin mode, and get the file
slatex.tar.z.  Ungzipping and untarring produces a
directory slatex, containing the SLaTeX files.  (The
file "manifest" lists the files in the distribution --
make sure nothing is missing.)

Sec. 3.  Requisites for installing SLaTeX

SLaTeX is implemented in R4RS-compliant Scheme --
macros are not needed.  The code uses the non-standard
procedures delete-file, file-exists? and flush-output,
but a Scheme without these procedures can also run
SLaTeX.  The configuration defines the corresponding
variables to be dummy procedures, since they are not
crucial.  The distribution comes with code to allow
SLaTeX to run also on Common Lisp.  The dialects that
SLaTeX has run successfully on are: Chez Scheme, Ibuki
Common Lisp, MIT C Scheme, Elk, Scheme-to-C, Scm and
UMB Scheme on Unix; and MIT C Scheme, Scm (compiled
using djgpp gcc), Austin Kyoto Common Lisp and CLisp on
MSDOS.  (All trademarks.)

Sec. 4.  Installing SLaTeX

Refer to the file "install" for configuring SLaTeX to
your dialect and ways of invoking it on your (La)TeX
files.

Sec. 5. Using SLaTeX

The file slatex-d.tex is a manual describing "How to
Use SLaTeX".  A version of the corresponding .dvi file,
slatex-d.dvi, is included in the distribution, but you
could create your own (and thereby check that SLaTeX
works on your system).  Save the provided slatex-d.dvi
file in case your setup doesn't work, and type

  slatex slatex-d

You may create a file slatex-d.ind that arranges the
index information from the file slatex-d.idx generated
by LaTeX.  Run LaTeX on slatex-d another time to sort
out the index and the citations.

If you have run Scheme (or CL) on config.scm (Sec. 1 of
install) but haven't been able to decide how to set up
the paths or the shell/bat script or the most suitable
invoking method (Sec.  2 and 3 of install), perform the
following actions (in the directory where you unpacked
the distribution) to get slatex-d.dvi:

    1. Start up Scheme (or CL).

    2. Type (load "slatex.ss").

    3. Type (SLaTeX.process-main-tex-file "slatex-d").

    4. Exit Scheme (or CL).

    5. Call latex on slatex-d.tex.  (Use makeindex to
    generate slatex-d.ind, if possible.  Call latex a
    second time to get the citations right and to
    generate an index if available.)

Sec. 6. Bugs etc.

Bug reports, flames, contributions, job offers,
criticisms, this-should-have-been-that's are most
welcome -- send to

Dorai Sitaram
dorai@cs.rice.edu
2 Chatham Place
Worcester, MA 01609
