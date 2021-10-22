/************************************************************
;                                                           *
;  William M. Spears					    *
;  Navy Center for Applied Research in AI                   *
;  Naval Research Laboratory                                *
;                                                           *
;  This software is the property of the Department of the   *
;  Navy. Permission is hereby granted to copy all or any    *
;  part of this program for free distribution, however      *
;  this header is required on all copies.		    *
;							    *
;************************************************************/

Date: 9106.12

Summary:

	The enclosed C code contains functions useful for
	experimentation in Genetic Algorithms. The system is
	called GAC.

	There is no guarantee that the code will do what you
	expect or that it is error free. It is simply meant
	to provide a useful way to learn and experiment about
	some of the finer details of GA implementation.

	The implementation is a "standard" GA, similar to
	Grefenstette's work. Baker's SUS selection algorithm
	is employed, n-point crossover is maintained at 60%,
	and mutation is very low. Selection is based on 
	proportional fitness. This GA uses generations.
	It is also important to note that this GA maximizes.

	A note on crossover is in order. This version of GAC
	allows for n-point crossover, where n is less than
	the length of an individual (although there is no 
	check for that). It is also possible to run uniform
	crossover (see discussion below).

	GAC will display run-time information as it executes.
	GAC also has the ability to output this information into
	files. These statistics include	best behavior, online/
	offline measurements, convergence, and the number of
	reevaluations per generation. At this time the code is
	commented out. The user can simply remove a few comment
	symbols to use this facility. See run.c and geval.c for
	details.
	
	There is no ranking, adaptive operators, etc. We intend
	to explore these issues in future work.


The Evaluation Function:

	In order to use this code, the C function "myeval"
	must be defined. This is essentially the function that
	describes the space to be searched. Myeval must be defined
	in a file named "myeval.c". Myeval takes one
	argument, namely the index of the individual to be evaluated.
	This individual is stored in an array c[][].
	As an example, I could create a separate file with this function:


	#include "header.h"

	/* One Max Problem */

	double myeval (i)
	int i;
	{
	   int j, temp;
	  
	   temp = 0;
	   solution = length;
	   for (j = 1; j <= length; j++) {
	     if (c[i][j] == 1) temp++;
	   }
	   return((double)temp);
	}


	See "myeval.c" for a complete example. It is assumed
	that myeval will always return a quantity that is
	greater than (or equal to) 0.0. Also, if all the
	individuals in a given generation return 0.0, problems
	will arise.

Termination:

	The GA will terminate when the function "termination" (in
	term.c) returns true. This needs to be defined for any
	application of the GA. 

	The GA will start itself over if it hasn't terminated and
	has lost diversity.

	An example termination function is:

	int termination () { return(best == solution); }

	if you know what the solution should be. A good place to
	define the variable solution is in the myeval function
	(see above). If you don't know the solution, a possible
	termination function would be:

	int termination () { return(evals >= 100000);}

To Compile the Code:

	In the Unix world, a Makefile is provided. An executable
	called "gac" will be created.

	There is no dynamic allocation in GAC, and the maximum
	individual length (MAX_BITS) and maximum population size
	(MAX_POP) are set at compile time in header.h. The user
	can modify these if need be.

To Run the Code:

	GAC is called in the following manner:

	gac population-size bit-length number-of-crossover-points
	    number-of-experiments log-file

	Example:

	gac 100 30 2 5 mylog

	This calls GAC with 100 individuals in the population. Each
	individual has 30 bits. The 2 refers to the number of crossover
	points. In this case it will run 2-point crossover. GAC will
	interpret a 0 as a request for uniform crossover. 5 experiments
	are run (in order to average the results). When the solution is
	found, the solution and the number of evaluations is dumped to mylog.
