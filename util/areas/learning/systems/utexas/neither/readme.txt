
======================================================================
		   NEITHER Theory Refinement System

			Machine Learning Group
		  The University of Texas at Austin
======================================================================

WHAT IS NEITHER?
----------------
NEITHER, which stands for "New EITHER", is an extension of the EITHER
theory refinement system. Theory refinement systems are used to modify
a set of rules which are incomplete or incorrect. Given a set of
examples, the rules are refined until the rule base is consistent with
the examples. One example of the use of theory refinement is the
knowledge acquisition phase of expert system construction.
Specifically, it may be relatively simple to develop a set of rules to
cover most of a problem but difficult to generate a complete solution.
Often, additional examples can be generated easily and given with the
partially correct theory to a system like NEITHER. The result is an
improved set of rules.


HOW TO DOWNLOAD NEITHER
-----------------------
Presumeably, if you've gotten this file then you know how to use 
anonymous ftp to download files from the cs.texas.edu archive. The
next file to get is the "neither.tar.Z" file, which must be downloaded
in binary format. Once you've downloaded that, move the file to the
directory where you want the neither code to reside. Then do the
following two steps:

% uncompress neither.tar.Z
% tar xvf neither.tar 

This will take all the files out of the tar format and place them in
the current directory.


HOW TO RUN NEITHER
------------------
Once you've "untarred" neither, there will be a file called 
EXAMPLE-LOAD-AND-RUN in the directory. It illustrates a session
showing how to compile and run the NEITHER program. Once you've loaded
up your common lisp program, you should be able to follow this example
to compile and run NEITHER.
