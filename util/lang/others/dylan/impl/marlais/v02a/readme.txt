Marlais 0.2a (an interpreter for a Dylan-like language written in C)
has been made available at travis.csd.harris.com in the /pub
directory.

	marlais-0.2a.tar.gz - distribution in gzip format
	marlais-0.2a.tar.Z  - distribution in Unix compress format

NEW
===

* A new garbage collector has replaced the old one.  Marlais should
now run on the following machines.

	    Sun 3
	    Sun 4 under SunOS 4.X or Solaris2.X
	    Vax under 4.3BSD, Ultrix
	    Intel 386 or 486 under OS/2 (no threads) or Linux.
	    Sequent Symmetry  (no concurrency)
	    Encore Multimax   (no concurrency)
	    MIPS M/120 (and presumably M/2000) (RISC/os 4.0 with BSD libraries)
	    IBM PC/RT  (Berkeley UNIX)
	    IBM RS/6000
	    HP9000/300
	    HP9000/700
	    DECstations under Ultrix
	    SGI workstations under IRIX
	    Sony News
	    Apple MacIntosh under A/UX

* Symbols and Keywords are now case insensitive.

* <deque> type added.

* Quasiquote, unquote, and unquote splicing added with their
associated read macros "`", "," and ",@".

* <array> type added.

* The functions car, cdr and cons have been added for transition ease. 
 
* Numerous bug fixes.


README
======
Marlais is a simple-minded interpreter for a program language strongly
resembling Dylan [1].  It is not intended as a final release, but
rather to fill a perceived void where Dylan implementations are
concerned.  This is a "hackers release" and is intended as a vehicle
for education, experimentation and also to encourage people to port it
to different architectures, add features, and fix bugs.  Marlais is
alpha software and should not be used by people desiring
reliability!!!

See INSTALL for information on installing Marlais.

See MACHINES for a list of supported machines.

See PORTING for information on porting Marlais to another
architecture. 

See BUGS for information on how to report bugs.

See DIFFERENCES for information on some of the differences between
Marlais and Dylan.

See HACKING for information on adding to and fixing Marlais.

See ADDED for information on new features in this release.

---
[1] Andrew Shalit.  "Dylan: an object oriented dynamic language".
Apple Computer, Inc.  1992.

INFO
====

Problems and questions to brent@ssd.csd.harris.com.
