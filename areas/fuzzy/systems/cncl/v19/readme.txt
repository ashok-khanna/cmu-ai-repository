                                                         -*- Indented-Text -*-
This is CNCL $Revision: 0.19 $.


  |_|_|_  |_|_    |_    |_|_|_  |_		     C O M M U N I C A T I O N
|_        |_  |_  |_  |_        |_		               N E T W O R K S
|_        |_  |_  |_  |_        |_		                     C L A S S
  |_|_|_  |_    |_|_    |_|_|_  |_|_|_|_	                 L I B R A R Y


Copyright (C) 1992/1993   Communication Networks
                          Aachen University of Technology
                          D-52056 Aachen
                          Germany
                          Email: mj@dfv.rwth-aachen.de (Martin Junius)

This library is free software; you can redistribute it and/or modify
it under the terms of the GNU Library General Public License as
published by the Free Software Foundation; either version 2 of the
License, or (at your option) any later version.  This library is
distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Library General Public
License for more details.  You should have received a copy of the GNU
Library General Public License along with this library; if not, write
to the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139,
USA.



CNCL is a C++ library with the following features:

Universal classes:

	* Tree structured class hierarchy, similar to NIHCL.

	* Classes for general purposes such as arrays, linked lists,
	  strings.

	* Interface classes for UNIX system calls: pipes, select.

Simulation:

	* Event driven simulation.

	* Statistical evaluation.

	* Random number generators and distributions.

Fuzzy logic:

      	* Fuzzy sets, fuzzy variables, fuzzy rules and inference
	  engine for building fuzzy controllers and expert systems.

EZD:

	* Interface classes for DEC's ezd graphics server.


See directory doc/ for more documentation on CNCL.


------------------------------------------------------------------------------


Compiling and installing CNCL:

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!! You MUST have perl (Larry Wall's script language) installed in order   !!
!! to use the CNgenclass and CNarray scripts (which are written in perl). !!
!! Having perl is a good idea anyway, so install perl now!!! ;-)          !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

(Compiling CNCL without perl using this distribution should work
nevertheless.)


	* Edit the file `make.conf' in this directory:

	  prefix	the prefix for all directories
	  bindir	directory for installing binaries and scripts
	  libdir	directory for installing libraries
	  includedir	directory for installing header files
			(the header files are actually installed in
			$(includedir)/CNCL)
	  infodir	directory for installing info files

	  CC		C++ compiler
	  DEBUG		default flags for compiling CNCL

	  The other definitions should be left as is.


	* If you have perl installed, compile to whole thing by
	  entering:

		make NewWorld

	  If you don't, install perl first! ;-) If you still aren't
	  convinced to do this, you may compile CNCL by typing:

		make World

	  But in this case the CNxxxxx scripts won't be updated
	  according to your configuration. Well, you can't use them
	  anyway, without perl! ;-)


	* Compiling CNCL takes a while, so either get a very fast
	  machine or a cup of coffee now. If everything worked well
	  so far, there should be a file

		libcncl.a

	  in the lib directory, size approximately 3MB.


	* You should now compile the CNCL test programs by entering:

		make tests

	  If this succeeded you may execute some of the test programs
	  in lib/test and lib/*/test.


	* Finally install CNCL by entering:

		make install

	  This will install the libraries, header files, support
	  binaries, and scripts in the appropiate directories.


	* There are special targets for compiling different version of
	  the library:

		cd lib; make lib_o

	  compiles an optimized (-O6) version of the library

		cd lib; make lib_g

	  compiles a debugging (-g) version of the library

		cd lib; make lib_p

	  compiles a profiling (-pg, gprof) version of the library
	  `make install' will install these libraries as well.



------------------------------------------------------------------------------

This version of CNCL is known to compile and run on the following
systems:

	* SUN SPARCstation, SUNOS 4.1.3,
	  GNU g++ 2.3.3 / 2.4.5 / 2.5.4 / 2.5.5 / 2.5.7 / 2.5.8,
	  libg++ 2.3 / 2.4 / 2.5.1 / 2.5.2 / 2.5.3

	* SUN 3/60, SUNOS 4.1.1,
	  GNU g++ 2.3.3 / 2.4.5,
	  libg++ 2.3 / 2.4

	* LINUX 0.99.13 / 0.99.14,
	  GNU g++ 2.4.5,
	  libc 4.4.1 / libc 4.4.4 + libg++ 2.4
