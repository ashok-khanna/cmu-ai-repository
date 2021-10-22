			IC PROLOG ][
			============

This is a beta-release of the IC-Prolog ][ system.

IC-Prolog ][ (or ICP for short) is a multi-threaded Prolog system.  Multiple
threads allow queries to be executed concurrently.  ICP also has an interface
to Unix TCP/IP system calls.  This interface together with multiple threads
enables distributed applications to be written in Prolog.

Parlog has been integrated with IC-Prolog ][ as a separate thread, so
applications may be written in either language depending on which is more
suitable.

Logic & Objects (L&O) is an object-oriented layer on top of Prolog.  This
gives a powerful structuring mechanism for Prolog programs as well as
providing a logical interpretation of inheritance and other object-oriented
features.

The system also includes a version of a simple expert system shell: skilaki.

The distribution has been tested on Sun-3 and Sun-4 (Sparcs) running
SunOS 4.1 or later.  For best results, it should be compiled using
gcc version 2.  Significant gains in performance (e.g. twice as fast)
can be obtained by using the '-O2' flag to gcc version 2.

The files/directories is this distribution are as follows :

	README		- this file
	INSTALLATION	- installation notes
	src		- C source for the emulator
	sun3,sun4	- contains links to src
	prolog		- run time system files for Prolog
	parlog		- run time system files for Parlog
	lo		- files relating to Logic & Objects system
	skilaki		- files relating to skilaki expert system shell
	makefile	- script for installing the IC-Prolog ][ system
	Makefile.m4	- script used by makefile
	install		- files needed for installation procedure
	doc		- documentation
	examples	- example programs
	ChangeLog	- history of changes

To install the system, check the variables in the top section of the
makefile and edit them if necessary.  The main decisions to be made
are the three installation directories (run-time system, binaries,
on-line info files) and the C compiler to use.

The destination directory for the installation should be specified
as INSTALLDIR in the makefile.  You will need up to a maximum total
of 12 megabytes to build the system for both Sun-3 and Sun-4
architectures.  If disk space is in short supply, after installing
the system you may delete everything except the runtime system.  The
complete run-time system for Sun-4 is under 3 megabytes, with an extra
1.6 megabytes needed for the Sun-3 system if required.

The directory doc contains texinfo files of the manual from which a 
hardcopy .dvi file may be generated for printing as well as `info' files
to be used in conjunction with GNU emacs or the info programs.  If you wish
to use these info files, you should edit the top level makefile to specify
your info directory (by default /usr/local/emacs/info) and then add the
entries 

	* ICP: (icp.info).          IC prolog ][
	* Parlog: (parlog.info).    Parlog

to the file `dir' in your info directory.

The documentation is incomplete at the moment.  There are gaps in the manual
and the new features are explained only in outline form.  This will be improved
as tutorials are being written and the manual is re-worked.  Future releases
will incorporate the new documentation.

Any bugs or comments should be send to :

Damian Chu (dac@doc.ic.ac.uk)
Dept. of Computing,
Imperial College,
180 Queen's Gate,
London  SW7 2BZ
UK

24th March 1993
