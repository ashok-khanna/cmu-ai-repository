;;; -*- Mode:LISP; Base:10; Syntax:Common-Lisp; -*-

;************************************************************
;                                                           *
;  William M. Spears					    *
;  Navy Center for Applied Research in AI                   *
;  Naval Research Laboratory                                *
;                                                           *
;  This software is the property of the Department of the   *
;  Navy. Permission is hereby granted to copy all or any    *
;  part of this program for free distribution, however      *
;  this header is required on all copies.		    *
;                                                           *
;************************************************************

Date: 9106.12

Summary:

	The enclosed Lisp code contains functions useful for
	experimentation in Genetic Algorithms. The system is
	called GAL. It is hopefully fully compatible with Lucid
	Common Lisp (also known	as Sun Common Lisp).

	There is no guarantee that the code will do what you
	expect or that it is error free. It is simply meant
	to provide a useful way to learn and experiment about
	some of the finer details of GA implementation.

	The implementation is a "standard" GA, similar to
	Grefenstette's work. Baker's SUS selection algorithm
	is employed, 2 point crossover is maintained at 60%,
	and mutation is very low. Selection is based on 
	proportional fitness. This GA uses generations.
	It is also important to note that this GA maximizes.

	There is no ranking, uniform crossover, adaptive
	operators, etc. We intend to explore these issues
	in future work.


The Evaluation Function:

	In order to use this code, the lisp function "myeval"
	must be defined. This is essentially the function that
	describes the space to be searched. Myeval takes one
	argument, namely the index of the individual to be evaluated.
	This individual is stored in an array *c* (for *current*
	population). As an example, I could create a separate
	file with this function:

	(in-package 'user)
	(proclaim '(special *c*))
	(defun myeval (ind)
	   (let ((bit4 (aref *c* ind 4))
		 (bit3 (aref *c* ind 3))
		 (bit2 (aref *c* ind 2))
		 (bit1 (aref *c* ind 1)))
		(some-function-of-the-above-bits)
	)  )

	See "myeval.lisp" for a complete example.

Termination:

	The GA will terminate when the function "termination?" (in
	term.lisp) returns true. This needs to be defined for any
	application of the GA. 

	The GA will start itself over if it hasn't terminated and
	has lost diversity.

To Compile the Code:

	For the Lucid/Unix world, a generic program is provided to compile
	the code. This program is in "compile-ga.lisp". A few paths
	may need to be changed for different sites, then the file
	is loaded into Lisp. Finally, the function (compile-ga) is run:

	-> (load "compile-ga")
	-> (compile-ga)


To Run the Code:

	Assuming that the myeval function has been created and loaded,
	a top level control loop must also be written. This control
	loop should initialize the GA structures, statistics, variables,
	and population. After a GA search, the variables and population
	are always reinitialized. Usually a certain number (n) of
	experiments are made. Also, a port should be provided to allow
	for output of useful information. A sample function would be:

	(defun run (population-size number-of-bits file n)
	   (let ((port (outfile file)))
	 	(init-ga-structures population-size number-of-bits)
		(init-ga-stats number-of-bits)
		(do  ((i 1 (1+ i)))
		     ((> i n) t)
		     (ga-search population-size number-of-bits port)
		     (format t "Experiment #~A~%" i)
		     (format port "Individual ")
		     (show-best-individual port)
		     (format port " found in ~A evaluations with score ~A~%"
				   *evals* *best*)
		     (drain port))
		(close port)))

	See file "run.lisp" for a complete example. A script "runga"
	is provided that loads all the necessary software and runs
	the GA.


Possible Bugs:

	Good question.
