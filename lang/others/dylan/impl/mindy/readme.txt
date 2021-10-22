
Mindy is an implementation of a language that is very much like the language
described in the Dylan(tm) Interim Reference Manual (DIRM).  The name
"Mindy" is derived from "Mindy Is Not Dylan Yet", and as the name implies,
Mindy is incomplete.  Mindy is incomplete for the following reasons:

   1] We do not implement everything in the DIRM.
   2] The DIRM does not specify all that Apple(tm) intends Dylan to be.
   3] At present there is no validation procedure for Dylan and no
      procedure for licensing the use of the trademarked Dylan name.

However, Mindy does implement most of what we believe Dylan will be.

Mindy was developed by the Gwydion Project at Carnegie Mellon University for
our own internal use as a development tool while we work on our "real"
high-performance Dylan implementation.  We have decided to make Mindy
available for other people who want to learn about Dylan.  However, the
amount of effort that we can put into maintaining Mindy is strictly limited.

Mindy will never be an industrial-strength implementation, and nobody should
depend on it for real work.  We will make future releases from time to time
as we add new features and fix bugs, but this is strictly a sideshow for us.
We would appreciate receiving bug reports (especially those accompanied by
code patches) and suggestions for improvements, but we may not fix every bug
reported in a timely manner, or fix it at all.  Our work on development of
the "real" Gwydion/Dylan must take precedence.

We hope that nobody will draw any conclusions about the performance of our
future Gwydion/Dylan compiler or the performance attainable in Dylan from
experience using Mindy.  It's not designed to be fast.

Mindy comprises two C programs, a compiler that produces byte-codes and a
byte-code interpreter.  Currently, building Mindy requires Gcc, Gmake, Flex,
and Bison.  We do not distribute these.  If you do not have GNU tools, you
can ftp them from:
   prep.ai.mit.edu  in the directory pub/gnu

We have built and tested Mindy under MACH on the DECstation and HP-UX on HP
700's.  We have built and run Mindy, but not tested it extensivly, under
OSF1 on the Alpha and Irix on the SGI.

The Mindy release also includes some rough documentation, various libraries
(Streams, Collection-extensions, and Random-numbers), and a Dylan mode for
Gnu-emacs.  Questions, comments, and suggestions should go to
"gwydion-bugs@cs.cmu.edu"

You can get Mindy from our public WWW page:
   http://legend.gwydion.cs.cmu.edu:8001/gwydion/
You can also get Mindy by anonymous ftp from legend.gwydion.cs.cmu.edu in
the following file:
   /afs/cs.cmu.edu/project/gwydion/release/mindy.tar.gz
Due to CMU security measures, if you use the ftp 'cd' command, then you must
'cd' to the release directory in one 'cd command line; for example, do not
try to 'cd' to "/afs/cs/project/gwydion/".  In the release area, there also
is a file named mindy-1.0.tar.gz which is the same file as mindy.tar.gz.

Questions, comments, and suggestions should go to "gwydion-bugs@cs.cmu.edu"

NOTE: MINDY IS MADE AVAILABLE WITHOUT CHARGE ON AN "AS-IS" BASIS.  NEITHER
THE AUTHORS NOR CARNEGIE MELLON UNIVERSITY OFFER ANY WARRANTY WHATSOEVER
CONCERNING THIS SOFTWARE, ITS PERFORMANCE, ITS USABILITY, OR ITS CONFORMITY
TO ANY SPECIFICATION.

Have fun and hope you enjoy,
Gwydion Project
