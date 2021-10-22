       The SLG system is now available by anonymous FTP

The SLG system is a meta interpreter implementation of the
well-founded semantics of normal logic programs [Van Gelder, Ross, and
Schlipf, JACM, Vol. 38, July 1991]. It is developed by Weidong Chen
and David Scott Warren, and is freely available by anonymous ftp from
Southern Methodist University <seas.smu.edu> or SUNY at Stony Brook
<sbcs.sunysb.edu>. (See instructions at the end of this message.) The
implementation of the SLG system is supported in part by the National
Science Foundation under Grants No. IRI-9212074 and No. CCR-9102159.

The SLG system is written in Prolog and allows integration of regular
Prolog execution with SLG resolution. SLG resolution is a method for
goal-oriented query evaluation of normal logic programs under the
well-founded semantics [Chen & Warren, PODS'93]. It handles both
positive and negative loops, and terminates for all programs with the
so-called bounded-term-size property. For function-free programs,
polynomial data complexity is guaranteed.

The SLG system is a meta interpreter implementation of full SLG resolution
with the following features:

  1. Positive and negative loops are detected efficiently by incremental 
     maintenance of dependencies among subgoals. This ensures that only
     subgoals relevant to a query are evaluated.

  2. Negative loops are handled by delaying ground negative literals that
     are selected. Delayed literals are fully simplified away when their 
     truth values are known.

  3. Prolog execution is integrated with SLG resolution. Predicates executed
     by SLG resolution can call Prolog predicates and vice versa.

The SLG system is an EXPERIMENTAL system, and carries significant
overhead as a meta interpreter on top of Prolog. You may take it and
use it at your own risk. The algorithms implemented in the SLG system
are described in a paper available from the authors. The subset of SLG
for modularly stratified programs and its integration with Prolog has
been implemented by the XSB system (that is freely available by
anonymous ftp from <sbcs.sunysb.edu>).

We would appreciate any feedback concerning the system and its use. 
We will try to be responsive to any comments/requests/bugs/etc.

   Weidong Chen
   Computer Science and Engineering
   Southern Methodist University
   Dallas, Texas 75275-0122, USA
   (214) 768-3097
   <wchen@seas.smu.edu>

   David Scott Warren
   Department of Computer Science
   SUNY at Stony Brook
   Stony Brook, NY 11794-4400, USA
   (516) 632-8454
   <warren@cs.sunysb.edu>

HOW to ftp:

1) Issue ftp command to connect to SMU ftp server:

      ftp seas.smu.edu 

   or SUNY/SB ftp server:

      ftp sbcs.sunysb.edu

   When asked for name, respond with "anonymous";
   When asked for password, respond with "ident".

2) Change directory to where the SLG system is:

      cd pub
	(on cs.sunysb.edu, use cd pub/XSB)

3) Set transfer mode to binary:

      binary

4) Retrieve the SLG system:

      get slg.tar.gz
	(on cs.sunysb.edu, use get slg.tar.Z)

5) Exit the ftp program

      quit

6) Uncompress and untar the file:

      gzip -cd slg.tar.gz | tar xvf -
	(on cs.sunysb.edu, use uncompress -c slg.tar.Z | tar xvf - )

   This command creates a subdirectory slg in the current
   directory and uncompresses the files into that directory.
   There should be six files: README, slg_doc, slg.pl, and
   three example files, namely win.pl, expr.pl, loop.pl.

   (gzip binaries can be obtained from seas.smu.edu in
    /pub as well as from the official cite, namely prep.ai.mit.edu
    in /pub/gnu.)

7) (Optional) Remove the compressed SLG system

      rm slg.tar.gz
	(on cs.sunysb.edu, use rm slg.tar.Z)

8) Have fun with the SLG system ...

/* --------------------- End of README --------------------- */

