CASLOG version 1.0, alpha release 12/20/92

Copyright (c) 1992. All rights reserved.

CASLOG is a semi-automatic complexity analysis system for logic programs.
It can perform the worst-case complexity analysis for complexity measures:
argument size complexity, number of solutions complexity, and time complexity.
CASLOG is written by Nai-Wei Lin at the Department of Computer Science,
the University of Arizona. This directory contains an alpha release of
CASLOG; there is NO WARANTEE for the system. 

The directory source contains the source codes of CASLOG 1.0 .

The directory doc contains a preliminary manual and a paper describing CASLOG.

The directory benchmark contains a set of benchmarks.

CASLOG is running on top of SICStus Prolog and C. 
To install CASLOG,

1. set the following aliases in your .login file

alias prolog 'the command for the SICStus Prolog interpreter in your system'
alias cc 'the command for the C compiler in your system'

2. type "make" (at directory caslog)

This command will compile the Prolog and C source codes, 
and save the initial system state in a new file caslog.init.

To run CASLOG,

1. type "caslog filename" (at directory caslog)

This command will restore the initial system state saved in caslog.init,
and perform complexity analysis on the program file filename.
To run CASLOG at other directories, the file caslog, which is a csh script
file, can be updated appropriately.

Address inquiries and bug reports to naiwei@cs.arizona.edu
