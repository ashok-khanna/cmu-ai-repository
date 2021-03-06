
Parallel Parlog V1.5
====================

(Note: Create a new directory before un-tarring the distribution file since
the files are created in the current directory.)


1. Introduction
---------------

Parallel Parlog is a portable implementation of Parlog designed to run on
shared memory multiprocessors. The implementation is based on an abstract
machine called the "JAM" (Jim's Abstract Machine).  The basic system
comprises a JAM emulator, written in C; a Parlog to JAM compiler, written
in Parlog, and a programming environment including a query interpreter also
written in Parlog.

The environment has been developed to provide a Prolog-like interface
similar to that provided by Quintus and Sicstus Prolog's, for example, most
builtin predicates are based on equivalent Prolog predicates.  Details of
the environment can be found in the Parallel Parlog User Manual.

Various utilities are provided with the system and some examples of Parlog
programs are also given. Finally, the distribution includes an object
oriented extension to Parlog called Polka.

Version 1.5 contains many bug fixes to version 1.4 as well as introducing
new primitives/features such as 

	* the "channel" abstraction for merging streams
	* recognition of escape characters within atoms
	* primitives to access environment variables
	* ability to define a search path for files
	* recognition of meta-characters in filenames
	* background processing
	* startup file processing

2. Contents of This Directory
-----------------------------

	README	  -	this file

	Makefile  -	makefile to create an executable system

	doc	  -	user manual

	emulator  -	the JAM emulator and some header files

	parlog.sed -	template file for the parlog script

	examples  -	example Parlog programs
		intro		- simple programs
		bench		- benchmark programs

	system	  -	Parlog system files including:
		boot.o		- the boot file
		comp		- compiler files
		env		- environment files

	utilities -	various Parlog utilities
		foreign		- make interfaces to C routines
		pshell		- a shell like user interface
		spm		- SPM compatibility routines
		tracer		- a Parlog tracer

	polka	  -	the Polka system
		doc		- Polka user manual
		examps		- simple Polka programs
		screen		- a larger example program


3. Installation
---------------

To make a working Parallel Parlog system, a 'parlog' shell script must be
generated that invokes the emulator, passing it the path of the "boot file"
which executes on startup.

The 'parlog' shell script can be generated by typing 'make parlog' in this
directory. The script will be placed in /usr/local/bin by default. The
destination directory can be changed by editing the BINDIR variable in the
Makefile or invoking make with 'make BINDIR=<destination> parlog'.

Should you wish to relocate this directory, you can do so by editing
the BASEDIR variable in the Makefile and then typing 'make install'.
This command will automatically generate the parlog script once the
files in this directory have been copied to their new location.

Typing 'make' alone will produce a summary of these make options.


======================


Contact:
Damian Chu (dac@doc.ic.ac.uk)
Dept. of Computing
Imperial College
180 Queens Gate
London  SW7 2BZ
UK

