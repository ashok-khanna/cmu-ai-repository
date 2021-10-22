
This is a CORAL Release 0.1 ! (dated Jan 25th 1993)

This directory contains the compressed tar file for 
the CORAL deductive database/logic programming system.
If your site is unable to transfer the entire tar file
due to network restrictions, there is a split directory
that contains split files of the tar file.

The directory g++.prerelease contains a pre-release of
version 1.0 of CORAL that is compatible with g++. A 
proper release of version 1.0 will happen towards the end
of summer 1993.
Till then, there may be some bugs in the pre-release.
The g++ directory has its own install.chap and README.
It has separate binary tar files for SUN/SPARC, DECstations
and HP700 machines.

Please send mail to coral@cs.wisc.edu if you have
any questions regarding CORAL. We would also
appreciate it if you could let us know what 
applications you intend to use CORAL for.

The documentation accompanying the release is
in the coral/doc directory which is created after
untarring the tar file. A copy of the latest version
of the User Manual is in manual.ps in the ftp directory.
The installation instructions are in the file install.chap
in the ftp directory.


 RELEASE NOTICE
 --------------
 The CORAL deductive database/logic programming system developed
 at the University of Wisconsin-Madison is now available via
 anonymous ftp from ftp.cs.wisc.edu.  The distribution includes
 source code compatible with ATT C++ (version 2.0 and later),
 the CORAL User Manual, and some related papers containing a
 language overview and implementation details.

 Executable binaries for Sun4s and DECstations are included.

 The CORAL declarative language is based on Horn-clause rules with
 extensions like SQL's group-by and aggregation operators, and uses
 a Prolog-like syntax.  Some notable features of the system are
 listed below.

	*  Many evaluation techniques are supported, including 
	    bottom-up fixpoint evaluation and top-down backtracking.

	*  A module mechanism is available.  Modules are separately
	    compiled; different evaluation methods can be used in
	    different modules within a single program.

	*  A broad class of programs with negation and set-generation is
	    supported that includes the class of ``modularly-stratified
	    programs'',  

	*  The data types supported include numeric and string
	   constants, functor-terms, lists, sets, multisets, 
	   arrays and non-ground terms (e.g. difference-lists).

	*  Disk-resident data is supported via an interface to the
	   Exodus storage manager.

	*  There is an ``explanation'' package based on Interviews
	   that allows users to examine ``derivation trees'' for
	   facts using a graphical menu-driven interface.

	*  A good interface to C++ is provided.  Relations defined
	   using the declarative language can be manipulated from
	   C++ code, and relations defined using C++ code can be
	   used in declarative rules.  C++ code defining relations
	   can be incrementally loaded.

	*  There is an on-line help facility.  The manual is
	   tutorial in nature, and contains several programs, all
	   of which are available as part of the distribution.
	   Several additional examples are included as well.


