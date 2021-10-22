This is the version of Franz Lisp Opus 38.92 hacked up for both 
SunOS 3.5 and 4.0.3 at UC Davis.  You don't need to run "lispconf"
anymore.  Simply change the pathnames in the main Makefile to reflect
your site, and comment/uncomment the appropriate ifdefs for the
operating system in question.  A "make clean" followed by 
"make slow >& LOG &"  and "make install" will then make franz for your local 
configuration.

	John Van Tassel
	(jvt@uk.ac.cam.cl)
	20.12.89
