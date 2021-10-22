

Introduction
============

This directory contains routines for solving binary constraint satisfaction
problems.  The files do not contain a complete program, but simply contain
functions which are to be compiled and accessed as a library.  See the
explanations of the functions below along with a sample.

This software is provided free of charge on an ``as is'' basis.  All I
ask in return is that, if you use the software, you send me e-mail letting
me know and that you provide me with any bug fixes or enhancements that
you make.  Address correspondence to:

	Peter van Beek
	Department of Computing Science
	University of Alberta
	Edmonton, Alberta, Canada  T6G 2H1

	vanbeek@cs.ualberta.ca



Installation
============

1.  Change the following two lines in the Makefile:
	LIB     = $(HOME)/src/csp/lib
	INCLUDE = $(HOME)/src/csp/lib
    to be the directory that you have saved this code in.

2.  Type
	make lib
    to compile the library.

3.  Type
	make main
    to compile the sample program main.c that uses the library.



Directory Contents
==================

BJ.c            Backjumping routine.
BM-BJ.c         Backmarking with backjumping routine.
BM-CBJ.c        Backmarking with conflict-directed backjumping routine.
BM-GBJ.c        Backmarking with graph-based backjumping routine.
BM.c            Backmarking routine.
BT.c            Simple chronological backtracking routine.
CBJ.c           Conflict-directed backjumping routine.
FC-BJ.c         Forward checking with backjumping routine.
FC-CBJ.c        Forward checking with conflict-directed backjumping routine.
FC-GBJ.c        Forward checking with graph-based backjumping routine.
FC.c            Simple forward checking routine.
FCarc.c         Forward checking using arc consistency routine.
FCpath.c        Forward checking using path consistency routine.
GBJ.c           Graph-based backjumping routine.
analyze.c       Analyze the proportion of values in the matrix.
arc.c           Arc consistency preprocessing routines.
domain.c        Routines to order the domains according to various heuristics.
generate.c      Generate different types of problems to solve.
global.h        Type, function, and macro definitions.
limit.c         Routines to set a time limit for solving a problem.  The
		   search for a solution is aborted after a set amount of time.
main.c		Sample main program for calling library routines.
path.c          Path consistency preprocessing routines.
process.c       Sample function for processing network solution.
solve.c		Interface to backtracking routines.
timer.c         Routines to control stopwatches for recording how long it
		   takes to find a solution.
variable.c      Routines to order the variables according to various heuristics
                   as well as various ordering methods.



Solving Methods
===============

Fourteen backtracking methods were implemented for solving constraint
satisfaction problems.  Individual references for the algorithms are included
below with each method.  Fuller references are given at the end of this
file.  We made extensive use of Prosser's paper (1993) in understanding the
different algorithms well enough to implement them.

 1) Simple backtracking (BT).  Reference: Golomb and Baumert, 1965; Bitner
    and Reingold, 1975.

 2) Backjumping (BJ).  Backjumping jumps past variables while backtracking
    whose instantiations would not affect the results of some inconsistency
    for the first time, and then continues simple backtracking further if
    required.  Reference: Gaschnig, 1978.

 3) Conflict-directed backjumping (CBJ).  Conflict-directed backjumping jumps
    past variables while backtracking whose instantiations would not affect
    the results of some inconsistency.  Reference: Prosser, 1993.

 4) Graph-based backjumping (GBJ).  Graph-based backjumping uses a "parent
    graph" to backjumping past variables while backtracking whose
    instantiations would not affect the results of some inconsistency.
    Reference: Dechter, 1990.

 5) Backmarking with simple backtracking (BM).  Backmarking prevents
    unnecessary consistency checks from being performed between variables if
    previous backtracking has not gone back far enough to prevent a conflict
    from re-occurring.  Reference: Gaschnig, 1977.

 6) Backmarking with backjumping (BM_BJ).  A hybrid algorithm that combines
    the effects of both backmarking and backjumping.  Reference: Prosser, 1993.

 7) Backmarking with conflict-directed backjumping (BM_CBJ).  A hybrid
    algorithm that combines the effects of backmarking and conflict-directed
    backjumping.  Reference: Prosser, 1993.

 8) Backmarking with graph-based backjumping (BM_GBJ).  A hybrid algorithm
    that combines the effects of backmarking and graph-based backjumping.
    Reference: Manchak, 1993.

 9) Forward checking with simple backtracking (FC).  Forward checking
    compares the instantiation of the current variable with all future
    variables to see which domain values can be eliminated from the future
    variables.  Forward checking can be seen as a combination of tree search
    and truncated arc consistency.  Reference: Haralick and Elliott, 1980.

10) Forward checking with backjumping (FC_BJ).  A hybrid algorithm that
    combines the effects of forward checking and backjumping.  Reference:
    Prosser, 1993.

11) Forward checking with conflict-directed backjumping (FC_CBJ).  A hybrid
    algorithm that combines the effects of forward checking and
    conflict-directed backjumping.  Reference: Prosser, 1993.

12) Forward checking with graph-based backjumping (FC_GBJ).  A hybrid
    algorithm that combines the effects of forward checking and graph-based
    backjumping.  Reference: Manchak, 1993.

13) Full arc consistency forward checking with simple backtracking (FCarc).
    Full arc consistency forward checking performs full arc consistency on
    future variables whenever the current variable is instantiated.  Simple
    backtracking is used since it too difficult to determine which point to
    back up to with full arc consistency.  Reference: Mackworth, 1977 was one
    of the first to suggest combining tree search and consistency techniques.
    Nadel, 1989 and Van Hentenryck, 1989 have pursued this idea.

14) Full path consistency forward checking with simple backtracking (FCpath).
    Forward checking performs full path consistency on future variables
    whenever the current variable is instantiated.  Simple backtracking is used
    since it too difficult to determine which point to back up to with full
    path consistency.  Reference: Mackworth, 1977; Manchak, 1993.



Variable Ordering Heuristics
============================

Three variable ordering heuristics exist in this directory:

1) convexity: Order the variables only in descending order by their convexity
   number over all edges with which the variable is associated.

2) degree: Order the variables in descending order by their degree.

3) satisfiability: Order the variables in descending order by the number of
   zeros in the edges associated with a variable.



Variable Ordering Techniques
============================

Three domain ordering techniques exist in this directory:

1) glf: Order the variables using a greedy largest first heuristic where the
   width between associated variables is minimized.

2) gsl: Order the variables using a greedy smallest last heuristic where the
   width between associated variables is minimized.

3) sort: Sort the variables using a one-time sort.



Domain Ordering Heuristics
==========================

Three domain ordering heuristics exist in this directory:

1) convexity: Order the domains only in ascending order by their convexity
   number over all edges with which the domain is associated.

2) degree: Order the domains in ascending order by their degree.

3) satisfiability: Order the domains in ascending order by the number of zeros
   in the edges associated with a domain.



Available Functions
===================

Generation of Problems
----------------------
1) generate_C(C, n, k, p) to generate graph coloring problems.
2) generate_Q(C, n, k) to generate n-queens problems.
3) generate_R(C, n, k, p, q) to generate totally random problems.
4) generate_S(C, n, k, p, q) to generate random problems with a solution.

Meaning of variables:
        C = constraint network of type "NETWORK"
        n = number of variable in network
        k = number of values in each of the domains
        p = probability of a non-trivial edge (an integer representing the
            percentage)
        q = probability of an allowable pair in a constraint (an integer
            representing the percentage)


Preprocessing
-------------
1) pre_arc(C, n, k) for arc consistency preprocessing.
2) pre_path(C, n, k) for path consistency preprocessing.

If neither are called, no preprocessing is done.
Meaning of variables:
        C = constraint network of type "NETWORK"
        n = number of variable in network
        k = number of values in each of the domains


Heuristic Ordering
------------------
1) order_domains(heuristic, C, n, k) to order the domains.
2) order_variables(heuristic, technique, C, n, k) to order the variables.

If neither are called, no heuristic ordering is done.
Meaning of variables:
        heuristic = type of heuristic to apply (domain_convexity,
                    domain_degree, or domain_satisfy for domain ordering and
                    variable_convexity, variable_degree, or variable_satisfy
                    for variable ordering)
        technique = type of ordering technique to apply for variable ordering
                    (one of sort, glf, or gsl)
        C = constraint network of type "NETWORK"
        n = number of variable in network
        k = number of values in each of the domains


Solving with Backtracking
-------------------------
solve( method, C, n, k, solution, number, found )

The meaning of the variables are as follows:
        method = backtracking method to use (one of BT, BJ, CBJ, GBJ, BM, BM_BJ,
                 BM_CBJ, BM_GBJ, FC, FC_BJ, FC_CBJ, FC_GBJ, FCarc, or FCpath)
        C = constraint network of type "NETWORK"
        n = number of variables in network
        k = number of values in each of the domains
        solution = solution to problem (of type "SOLUTION")
        number = number of solutions to find (1 means find only the first
                 solution, anything else means find all solutions)
        found = integer passed by address, upon return indicates whether a
		solution was found or not


Time Limits
--------------
set_limit( type, limit ) to set a time limit on the search for a solution.

The meaning of the variables are:
        type = type of time limit (REAL or VIRTUAL).  Real time is clock
	       time; Virtual time is CPU time.
        limit = timer limit (in seconds and given as an integer)


Timing Routines
--------------
1) start_timers() to start the stopwatches.
2) elapsed_time( type ) to retrieve the time elapsed since start_timers
	was called.  Returns a double containing number of seconds
	that have elapsed.

The meaning of the variables are:
        type = type of time (REAL or VIRTUAL).  Real time is clock
	       time; Virtual time is CPU time.


Other Global Information
------------------------
1) Variable "checks" which maintains the number of consistency checks
   performed.
2) Variable "count" which maintains the number of solutions found.
3) Function "process_solution(C, n, solution)" which by default verifies the
   solution (with the parameters defined as above).
4) Function "analyze(C, n, k, p, q)" which calculates the real value of "p"
   and "q" for a given constraint network (note that p and q should be passed
   as pointers to doubles).



Sample Main Program
===================

/*
 *  Note that to use the library correctly, the "global.h" file must be
 *  included in all files which use its information (such things as
 *  functions calls, data structures, etc.).  In addition, the "srandom"
 *  command must be issued before calling any generate routines.  All the
 *  routines assume that the constraint network is specified by (0-1)-matrices.
 */

#include "global.h"

#define TIME_LIMIT  1200    /* 20 minutes */
#define N_TESTS       10    /* number of tests at each value of p, q */


main( argc, argv )
    int     argc;
    char    *argv[];
{
    int         n, k, p_orig, q_orig, tests, found, consistent;
    NETWORK     C;
    SOLUTION    solution;
    double      p, q;


    srandom( 0 );

    n = 50;
    k =  5;

    for( p_orig = 10; p_orig <= 100; p_orig += 2 )
    for( q_orig = 10; q_orig <= 100; q_orig += 2 ) {

        for( tests = 1; tests <= N_TESTS; tests++ ) {

            generate_R( C, n, k, p_orig, q_orig );
            analyze( C, n, k, &p, &q );

            start_timers();
            set_limit( REAL, TIME_LIMIT );

            consistent = pre_arc( C, n, k );

            if( !consistent ) {
                printf( "0\t0\t%0.0f\t%0.0f\t%0.2f\n",
                    p, q, elapsed_time( VIRTUAL ) );
            }
            else {
                order_variables( variable_satisfy, sort, C, n, k );
                order_domains( domain_satisfy, C, n, k );

                solve( FCarc, C, n, k, solution, 1, &found );
                printf( "%d\t%d\t%0.0f\t%0.0f\t%0.2f\n",
                    checks, count, p, q, elapsed_time( VIRTUAL ) );
            }

            fflush( stdout );
        }
    }

    exit( 0 );
}



References
==========

J. R. Bitner and E. M. Reingold.
Backtrack Programming Techniques.
Comm. ACM, 18:651-655, 1975.

R. Dechter.
Enhancement Schemes for Constraint Processing: Backjumping, Learning,
  and Cutset Decomposition.
Artificial Intelligence, 41:273-312, 1990.

J. Gaschnig.
A General Backtracking Algorithm that Eliminates Most Redundant Tests.
Proceedings of the Fifth International Joint Conference on
  Artificial Intelligence, p. 457, Cambridge, Mass., 1977.

J. Gaschnig.
Experimental Case Studies of Backtrack vs. Waltz-type vs. New
  Algorithms for Satisficing Assignment Problems.
Proceedings of the Second Canadian Conference on Artificial
  Intelligence, pp. 268-277, Toronto, Ont., 1978.

S. Golomb and L. Baumert.
Backtrack programming.
J. ACM, 12:516-524, 1965.

R. M. Haralick and G. L. Elliott.
Increasing Tree Search Efficiency for Constraint Satisfaction
  Problems.
Artificial Intelligence, 14:263-313, 1980.

A. K. Mackworth.
Consistency in Networks of Relations.
Artificial Intelligence, 8:99-118, 1977.

D. Manchak.
Undergraduate student,
Department of Computing Science, University of Alberta.

U. Montanari.
Networks of Constraints: Fundamental Properties and Applications to
  Picture Processing.
Inform. Sci., 7:95-132, 1974.

B. A. Nadel.
Constraint Satisfaction Algorithms.
Computational Intelligence, 5:188-224, 1989.

P. Prosser.
Hybrid Algorithms for the Constraint Satisfaction Problem.
Computational Intelligence, 9:268-299, 1993.

P. Van Hentenryck.
Constraint Satisfaction in Logic Programming.
MIT Press, 1989.

