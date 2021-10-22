This message announces the availability of Scheme release scm4e0.

[Note: scm4e0 is compatible with only slib2a0.]

New in scm4e0 are:

	* scmfig.h: was config.h (too generic).
	* scm.c (main run_scm) repl.c (repl_driver init_init): now take
	initpath argument.  IMPLINIT now used in scm.c
	* eval.c (ceval m_cont IM_CONT): @call-with-current-continuation
	special form for tail recursive call-with-current-continuation
	added.  call_cc() routine removed.
	* eval.c (ceval m_apply IM_APPLY apply:nconc-to-last): @apply
	special form for tail-recursive apply added.  ISYMs reactivated.
	* Init.scm ((read:sharp c port)): defined to handle #', #+, and
	#-.
	* repl.c (lreadr): Now calls out to Scheme function read:sharp
	when encountering unknown #<char>.
	* sys.c (sym2vcell intern sysintern): now use internal strhash().
	* scl.c sys.c (hash hashv hashq strhash()): added.
	* Link.scm (*catalog*): catalog entries for db (wb),
	turtle-graphics, curses, regex, rev2-procedures, and
	rev3-procedures added.
	* crs.c (nodelay): added.  In NODELAY mode WGETCH returns
	eof-object when no input is ready.
	* scm.h (LENGTH): now does unsigned shift.
	* sys.c (gc_mark mark_locations): now externally callable.
	* scm.h (ARRAY_NDIM): #define ARRAY_NDIM NUMDIGS changed to
	#define ARRAY_NDIM(x) NUMDIGS(x) to correct problem on Next.
	* dynl.c MANUAL Init.scm (init_dynl): dynamic linking modified for
	modern linux.

	From: Shiro KAWAI <kawai@sail.t.u-tokyo.ac.jp>
	* eval.c (ceval apply): under flag CAUTIOUS, checks for applying
	to non-lists added.

	From: rshouman@chpc.utexas.edu (Radey Shouman)
	* unif.c: 0d arrays added.  Serial array mapping functions and
	ARRAY-SIMPLE? added.
	* sys.c eval.c setjump.h setjump.s (longjump setjump): full
	continuations now work on Cray YMP.

	From: ucs3028@aberdeen.ac.uk (Al Slater)
	* makefile.acorn repl.c (set_erase): Port to acorn archimedes.
	This uses Huw Rogers free unix function call library for the
	archimedes - this is very very widely available and should pose no
	problem to anyone trying to find it - its on every archimedes ftp
	site.

	From: hugh@cosc.canterbury.ac.nz (Hugh Emberson)
	* dynl.c Link.scm: Dynamic Linking with SunOS.

	From: fred@sce.carleton.ca (Fred J Kaudel)
	* unif.c (ra_matchp ramapc): patch to unif.c avoids two problems
	(K&R C does not allow initialization of "automatic" arrays or
	structures).  This was not use in 4d2 or previously, and the
	following patch ensures that such initialization only occurs for
	ANSI C compilers (Note that K&R C compilers need to explicitly
	assign the values).

Files in these directories are compressed with patent-free gzip (no
relation to zip).  The program to uncompress them is available from
prep.ai.mit.edu:pub/gnu/gzip-1.2.4.tar
prep.ai.mit.edu:pub/gnu/gzip-1.2.4.shar
prep.ai.mit.edu:pub/gnu/gzip-1.2.4.msdos.exe

Scm conforms to Revised^4 Report on the Algorithmic Language Scheme
and the IEEE P1178 specification.  Scm is written in C and runs under
Amiga, Atari-ST, MacOS, MS-DOS, OS/2, NOS/VE, Unicos, VMS, Unix and
similar systems.  ASCII and EBCDIC are supported.

Documentation is included explaining the many Scheme Language
extensions in scm, the internal representation and how to extend or
include scm in other programs.

SCM can be obtained via FTP (detailed instructions follow) from:
altdorf.ai.mit.edu:archive/scm/scm4e0.tar.gz
prep.ai.mit.edu:pub/gnu/jacal/scm4e0.tar.gz
nexus.yorku.ca:pub/scheme/new/scm4e0.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/scm4e0.tar.gz

SLIB is a portable Scheme library which SCM uses:
altdorf.ai.mit.edu:archive/scm/slib2a0.tar.gz
prep.ai.mit.edu:pub/gnu/jacal/slib2a0.tar.gz
nexus.yorku.ca:pub/scheme/new/slib2a0.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/slib2a0.tar.gz

JACAL is a symbolic math system written in Scheme:
altdorf.ai.mit.edu:archive/scm/jacal1a4.tar.Z
prep.ai.mit.edu:pub/gnu/jacal/jacal1a4.tar.Z
nexus.yorku.ca:pub/scheme/new/jacal1a4.tar.Z
ftp.maths.tcd.ie:pub/bosullvn/jacal/jacal1a4.tar.Z

HOBBIT is a compiler for SCM code:
altdorf.ai.mit.edu:archive/scm/hobbit2.tar.gz
nexus.yorku.ca:pub/scheme/new/hobbit2.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/hobbit2.tar.gz

SCMCONFIG contains additional files for the SCM distribution to build
SCM on Unix machines using GNU autoconf.
altdorf.ai.mit.edu:archive/scm/scmconfig4e0.tar.gz
prep.ai.mit.edu:pub/gnu/jacal/scmconfig4e0.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/scmconfig4e0.tar.gz

SLIB-PSD is a portable debugger for Scheme (requires emacs editor):
altdorf.ai.mit.edu:archive/scm/slib-psd1-2.tar.gz
prep.ai.mit.edu:pub/gnu/jacal/slib-psd1-2.tar.gz
nexus.yorku.ca:pub/scheme/new/slib-psd1-2.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/slib-psd1-2.tar.gz

SMG-SCM is an SMG interface package which works with SCM on VMS.
altdorf.ai.mit.edu:archive/scm/smg-scm2a1.zip
prep.ai.mit.edu:pub/gnu/jacal/smg-scm2a1.zip
ftp.maths.tcd.ie:pub/bosullvn/jacal/smg-scm2a1.zip
A VMS version of Unzip is available by anonymous FTP from
ftp.spc.edu:[ANONYMOUS.MACRO32]UNZIP.EXE.

TURTLSCM is a turtle graphics package which works with SCM on MSDOS
or X11 machines:
altdorf.ai.mit.edu:archive/scm/turtlegr.tar.gz
prep.ai.mit.edu:pub/gnu/jacal/turtlegr.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/turtlegr.tar.gz

WB is a disk based, sorted associative array (B-tree) library for SCM.
Using WB, large databases can be created and managed from SCM.
altdorf.ai.mit.edu:archive/scm/wb1a2.tar.gz
nexus.yorku.ca:pub/scheme/new/wb1a2.tar.gz
ftp.maths.tcd.ie:pub/bosullvn/jacal/wb1a2.tar.gz

XSCM is a X windows interface package which works with SCM:
altdorf.ai.mit.edu:archive/scm/xscm1.05.tar.Z
prep.ai.mit.edu:pub/gnu/jacal/xscm1.05.tar.Z

  ftp altdorf.ai.mit.edu [18.43.0.152] (anonymous)
  bin
  cd archive/scm
  get scm4e0.tar.gz
  get slib2a0.tar.gz
or
  ftp prep.ai.mit.edu (anonymous)
  bin
  cd pub/gnu/jacal
  get scm4e0.tar.gz
  get slib2a0.tar.gz

`scm4e0.tar.gz' is a gzipped tar file of the C code distribution.
`slib2a0.tar.gz' is a gzipped tar file of a Scheme Library.

Remember to use binary mode when transferring the files.
Be sure to get and read the GNU General Public License (COPYING).
It is included in scm4e0.tar.gz.

To receive an IBM PC floppy disk with the source files and MSDOS
and i386 MSDOS executables send $99.00 to:
   Aubrey Jaffer, 84 Pleasant St. Wakefield MA 01880, USA.

If you like scm you can support the developement and maintainence of
it by buying a disk from me or by sending money to the above address.
