This directory contains binaries and sources for T3.1.  Currently available
versions are for Dec3100(pmax), Sun4(sparc),Sun3, Vax/Unix, Encore, Hp 
workstation, Apollo and Mac/Aux.
You need the binaries for your machine and tfix5.t and ofix5.t.  For machines
based on the 680x0 processor (Sun,Hp,Apollo,Mac) you must get m68fix.t as well
and modify tfix5.t to load this file in addition to ofix5.t.  The shell
variable TSYSTEM should be defined to be the directory containing these files.
You can compile the fix files if you want to. The online version of the T 
manual is also here as well as release notes for T3.0 and T3.1.  For Sun and 
Vax you may want foreign.tex which explains the C/Unix interface to T.
Send your e-mail address to t-project@cs.yale.edu so you can be informed
of fixes, new releases, etc.  Bug reports to t3-bugs@cs.yale.edu.

Note:  Ignore files such as sunbuild.t unless you want to rebuild the T system
from sources.

The following improvements are available in the pmax and sparc versions:

There is a faster garbage collector.  By default it doesn't print anything to
the terminal.  (set (gc-noisily?) '#t) will restore the old behavior.

The compiler writes an additional file (.mld on pmax and .sd on sparc) used
to get local variable information and source for compiled code.  As a result,
most crawl commands work on stack frames for compiled code.

There is a new form (TRACE-IF predicate proc-to-trace).  This prints
trace information for proc-to-trace if predicate applied to the arguments
is true.

There are new forms BREAK, UNBREAK, and BREAK-IF corresponding to trace.
Instead of printing trace information they give a breakpoint. (ret) will
continue the computation.  RET with an argument will cause another break after
the procedure returns.


