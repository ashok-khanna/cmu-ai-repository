This file last changed on 3/31/94

This directory contains the knowledge tools distribution as maintained
by the University of Rochester Computer Science Dept.

See file readme.rhet for more details on Rhet and this distribution.

See file cl-lib.readme for more details on cl-lib specifically.

See file tg-ii.readme for more details on TimeGraph II specifically.

Note: *.Z in this directory uses the bsd compress(1) program; *.gz uses the gnu 
gzip(1) program, which you can ftp from ftp.uu.net amoung others. It uncompresses
faster, and the compressed file is smaller, so future versions will use only
this format. We use gnu tar to tar the files, though that should be compatible 
with standard tar programs.

Compatibility notes:

cl-lib-3-33, rhet-20-25, tempos-3-6, and timelogic-5-0 will run on Symbolics
(genera 8.1.1 or later) and Allegro Common Lisp (4.1 or later). The Explorer
is no longer supported, except by Cl-lib and timelogic, though some minor
porting may be needed. A version of the explorer window interface is still 
available in the rhet hierarchy; look under window-interface.

After the above release, we turned off our Symbolics machines. The current 
versions should still work on symbolics machines (and we will accept patches
if provided) but have no longer been tested in that environment.

Specific release notes are kept with each product. Timelogic will
run standalone, rhet requires cl-lib, tempos requires rhet and timelogic
and cl-lib, and rprs requires all of the above. 

TimeGraph-II (tg-ii) is standalone; it contains necessary functions from cl-lib, 
though you can also use it with cl-lib if you like. It will automatically configure
itself on build (with/without full cl-lib distribution).

Enjoy!
Brad Miller
miller@cs.rochester.edu

REMEMBER, you can get on rhet discussion lists rhet and 
rhet-bugs@cs.rochester.edu by sending mail to
rhet-request@cs.rochester.edu

If you have any comments regarding code in this directory (good, bad, things
you'd like to see, problems with installation), please pass them on. We
can't promise we'll address every issue, but we do promise to read your
note!


