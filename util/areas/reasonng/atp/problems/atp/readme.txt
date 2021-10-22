problem-set/README
created : 06/30/88
revised : 08/15/88

Contents of 'problem-set' :
---------------------------

NOTE : This database is formatted into several directories and each of
those into subdirectories, grouped by the type of problem treated.  There
are separate directories for areas of mathematics, puzzles, and other uses
of automated reasoning programs.  Here is a brief list of the
subdirectories :
 
Main Directory Headings
----------------------------------------------------------------------

README : You are currently here; a description of all the directories in
	the directory problem-set/.

algebra : algebra problems in the fields of boolean algebras, category 
	theory, group theory, henkin models, modular lattices, and ring 
	theory.	

analysis : analysis problems in the field of limit theorems.

circuits : circuit design and validation problems.

geometry : geometry problems in the field of tarskian geometry.

logic.problems : logic problems in Equivalential Calculus and Relevance
	logic.

miscellany : miscellaneous problems.

pelletier : problems submitted by Francis Pelletier, from "75 Problems for 
	Testing ITP".

prog.verification : problems in program verification.

puzzles : puzzles formulated for the theorem prover to solve.

set.theory : set theory problems using naive set theory and Godel's axioms.

topology : topology problems. 

----------------------------------------------------------------------

Inside each of the above subdirectories, you will find several files:

1) a README file, similar in format to this one, giving short explanations
	of what the problems are about;

2) .desc files, which are slightly longer English descriptions of the
	problems, and credits for their creation;

3) .clauses files, which are the commentary and clauses for the problems;

4) .in files, which are OTTER input files, with inference rules specified;

5) .out files, which are actual OTTER output.

Note that there may be several versions of each problem, which may differ
only in inference rules used, or may have different axioms or a different
choice of the set of support.  Also, the date which appears at the top of
the .out files is the version date of OTTER which was used to produce that
output file.

----------------------------------------------------------------------

For each problem, there are several standard files, which include one
probname.desc file and at least one of each of probname.ver#.in,
probname.ver#.clauses, and probname.ver#.out.  These contain the
following: 

probname.desc : contains the Natural Language Description of the
	problem, where available, credits for problem formulation, 
	and complete details on each formulation and each version.  

probname.ver#.in : contains the problem specification, input clauses, and
	strategy for OTTER; this file is ready to run.

probname.ver#.clauses : contains the description, commentary, and the
	actual clauses (including the denial of the conclusion) used for
	probname.ver#.in, without any strategy; note that comments always are 
	on lines beginning with a %, preceding the clauses to which they
	refer, and that clauses terminate with periods.

probname.ver#.out : contains the output from running probname.ver#.in
	with OTTER, with proof if one is found, and with statistics on 
	the clauses generated and CPU time used.



HOW TO RUN :
----------------------------------------------------------------------

Invoke OTTER by using the following command :

	otter < probname.ver#.in    [ > outfile ]   [ & ]

NOTE : '> outfile' may be used to send all output to a file named outfile;
	'&' may be used to run the program in the background.

