
 This is a CORAL Release 1.0 ! (dated Apr 26th 1993)

 This directory contains the compressed tar files for 
 the CORAL deductive database system.

 Please send mail to coral@cs.wisc.edu if you have
 any questions regarding CORAL. We would also
 appreciate it if you could let us know what 
 applications you intend to use CORAL for.

 The documentation accompanying the release is
 in the coral/doc directory which is created after
 untarring the tar file. The installation
 instructions are in the file install.chap
 in the ftp directory.

 The files of interest in this directory are :
	README                :: (we are, after all, into recursion :-])
	install.chap          :: installation document for CORAL
	coral.1.nobin.tar.Z   :: contains src code for CORAL, but no binaries
	coral.1.mipsbin.tar.Z :: contains MIPS binaries for CORAL
	coral.1.sun4bin.tar.Z :: contains SUN4 binaries for CORAL
	coral.1.hpbin.tar.Z   :: contains HP700 binaries for CORAL

 Split file versions of the three tar files are also provided.
 Please ensure that you are in binary mode when ftping binaries.

 RELEASE NOTICE
 --------------
 The CORAL deductive database/logic programming system developed
 at the University of Wisconsin-Madison is now available via
 anonymous ftp from ftp.cs.wisc.edu.  The distribution includes
 source code compatible with both ATT C++ (version 2.0 and later)
 and g++, executable versions of the system, the CORAL User Manual,
 and some related papers containing a language overview and 
 implementation details.

 CORAL can be compiled and executed on SUN4/SPARC workstations, DECstations
 and HP-700 series workstations. Executable binaries for all three
 are included in the release.

 NOTE: The current version for the HP700 machines does not support
 incremental loading, and the timer statistics are incorrect. The
 binary tar file for HP700 does not contain the Explain tool.

 About CORAL ::
 --------------
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


