
		SGPC: Simple Genetic Programming in C
		by Walter Alden Tackett and Aviram Carmi
			(gpc@ipld01.hac.com)

Version 1.0
(c) 1993 by Walter Alden Tackett and Aviram Carmi
 
This code and documentation is copyrighted and is not in the public
domain.  All rights reserved.
 
Genetic Programming is a method of "Adaptive Automatic Program
Induction" originally created by John Koza and James Rice of Stanford
University.  SGPC is a C implementation of Genetic Programming: it is
a C program which writes LISP programs.  These programs are tailored
by the system to solve a problem specified by the user.  Koza and Rice
have provided to the public a version of Genetic Programming which is
written in LISP.  SGPC offers greater portability and about 25-50
times improvement in execution speed due to a highly optimized C
implementation.

For further information on Genetic Programming See: 

_Genetic_Programming_ by John R. Koza, MIT Press 1992

"Genetic Programming for Feature Discovery and Image Discrimination"
by Walter Alden Tackett in _Genetic_Algorithms:_Proceedings_of_the_
Fifth_International_Conference_ (GA93), S. Forrest Ed., Morgan-
Kaufman 1993.

To participate in our on-line Internet e-mail forum send your
subscription request to:
genetic-programming-request@cs.stanford.edu


Basically, the code does the same things that Koza & Rice's simple
LISP does and is set up to handle multiple populations as well (e.g.,
for co-evolution).  You need to provide three modules, setup.c,
fitness.c, and prob.h, in a subdirectory named PROBNAME, where
PROBNAME is some descriptive name of the problem.  E.G., in the
version we ship we include REGRESSION/setup.c and
REGRESSION/fitness.c, Which do Koza's simple regression problem.

setup.c contains functions to setup the function table, the terminals
table, and code for the functions in the function table.  prob.h
contains prototypes for the user defined functions.  fitness.c
contains functions to evaluate and validate populations and trees,
early termination, and definition of the fitness (training and test)
cases.

As a second example, for your enlightenment, we include the ADF
problem which shows you how to build a simple 2-class "dendritic"
classifier (see my paper in the sfi account).

You should not need to modify any of the other myriad files.


COMPILING

Source code for the kernel system is in the sub-directory `lib'.
Source code for problem depended modules are in sub-directories named
after the problem.

There is a Makefile in the top level directory which invokes the
Makefile in the problem specific directory, which invokes the Makefile
in the `lib' directory (if needed).  The source in the lib directory
is compiled into an object library file, which is then linked with the
problem specific objects.

Read the notes in the Makefiles in all the sub-directories, make any
necessary changes to fit your system, and then type:

make depend PROBLEM=PROBNAME
make PROBLEM=PROBNAME

where PROBNAME is the name of the subdirectory where the problem
specific setup.c and fitness.c files are.


EXECUTING

the executable is called gpcPROBNAME and will be in
the PROBNAME directory.

gpcPROBNAME  npops ngen (pop0_pfile|`none')... [seed]

NOTE: you must have a parameters file name for each population.


EXAMPLE

gpcREGRESSION 2 100 none pop1_file 12345

will run gpcREGRESSION with 2 pops 100 gens with pop0 using the
default values, pop1 using values from pop1_file, and 12345 as the
initial random seed.


On startup default values for the runtime parameters are assigned from
hard-coded values, then if a file called "default.in" exists in the
current directory, values are read from it and override the hard-coded
values.  If a parameters file name for a population is present on the
command line, values from this file override the previous values for 
that population, else if `none' is specified on the command line, the
parameters will retain the default values.  Remember you must specify
either a population params file or `none' on the command line for
each population.

Note: since the random seed value is not a population parameter but it
can be specified in the population parameters file, if there are
multiple populations, and no seed value was specified on the command
line, the value read from the last population parameters file will be
used.


Some salient points about the modules which are provided for you:

The main() is located in lib/gpc.c 

The top-level loop which iterates over the generations is in generations.c 
The data structures which you must work with are in the file gpc.h 
Expressions (trees) are evaluated via calls to eval(tree *t) in eval.c.
Trees are operated on using routines in treeops.c and can be read/written
using operations in treeio.c.

You will get some tutorial feel for using the data structures involved
by examining the initializations which take place in populations.c and
generations.c.

In general, the modules are descriptively named: e.g., selection.c,
crossover.c, mutation.c.


CREATING YOUR OWN PROBLEMS

First create a sub-directory under the top-level sgpc directory and
name it a descriptive name. Copy the Makefile and optionally the 
fitness.c setup.c and prob.h files to the new directory.  


FITNESS.C

Here are the functions you must include in the fitness.c module:

/* 
 assigns standardized fitness  values to all members of each population 
 pop[0]...pop[numpops-1]
*/
void evaluate_fitness_of_populations ( 
  int numpops, 		/* number of populations */
  int numgens, 		/* number of generations */
  pop_struct *pop 	/* the population array */
  );


/* 
 returning != 0 from this routine halts SGPC at the end of the generation, 
 eg, if a "perfect" (ha!) individual is found
*/
int terminate_early ( 
  int numpops,
  int numgens,
  pop_struct *pop
  );


/* 
 creates the array of fitness cases, or does other startup peculiar 
 to your problem 
*/
void define_fitness_cases ( 
  int numpops,
  int numgens,
  pop_struct *pop
  );


/* 
this routine is used to test the best-of-generation individual against
a separate set of test cases which were not used in training (i.e., in
generating the fitness values which drive selection).  The best-of-run
individual is determined using the figure returned from this function
*/
float validate_fitness_of_tree( 
     int	numpops,
     int	numgens,
     pop_struct *pop,
     tree 	*t
     )


SETUP.C

Here are the functions you must include in the setup.c module:

/* 
 assigns function pointers, print names, arity, macro-flag, etc, to 
 function table entries for all populations 
*/
void make_function_table ( 
  pop_struct *pop
  );


/* 
 assigns function pointers, print names, arity, macro-flag, etc, 
 to terminal table entries for all populations 
*/
void make_terminal_table ( 
  pop_struct *pop
  );

In addition, you declare all of the actual function code for you
function set in setup.c.  A declared function can either be a
function or a macro: a function has an array of values (eg float
*args;) passed into it as arguments, whereas a macro has an array of
unevaluated expressions passed in, so that some of them may remain
unevaluated to prevent side-effects.

Here is how the properties of a function are assigned in
make_function_table(pop_struct *pop):

  pop[0].function_table[0].arity = 2;
  pop[0].function_table[0].macro = FALSE;
  pop[0].function_table[0].enabled = TRUE;
  pop[0].function_table[0].printname = "+";
  pop[0].function_table[0].code = plus;

Here is the assignment of a macro:

  pop[0].function_table[4].arity = 4;
  pop[0].function_table[4].macro = TRUE;
  pop[0].function_table[4].enabled = TRUE;
  pop[0].function_table[4].printname = "IFLTE";
  pop[0].function_table[4].code = iflte;

Here is how the functions they point to are declared:

For the function plus:

GENERIC plus(GENERIC *args)
{
  return args[0]+args[1];
}

For the macro iflte:

/* note that args are unevaluated trees, not GENERIC values */
GENERIC iflte(tree **args)
{
  return ((eval(args[0]) < eval(args[1])) ? eval(args[2]) : eval(args[3]));
}

Note that in the code above, the type generic can be set by the TYPE
definition set to the make file: default is #define GENERIC float.


TERMINAL TABLE:
We play some games here.  Here is the definition of a terminal from
make_terminal_set(pop_struct *pop):

  pop[0].terminal_table[0].val = 0;
  pop[0].terminal_table[0].printname = "X";
  pop[0].terminal_table[0].constant_generator = random_constant;

If we declare that there are N terminals in the terminal set, then there
a total of N+1 entries 0...N, where entry N is the randomly generated
constant, which should always be declared as follows:

  pop[0].terminal_table[pop[0].terminal_table_size].val = 0;
  pop[0].terminal_table[pop[0].terminal_table_size].printname = FORMAT;
  pop[0].terminal_table[pop[0].terminal_table_size].constant_generator =
    random_constant;

Here, FORMAT is #defined to be the format string associated with the 
GENERIC type, eg if GENERIC == float then FORMAT == "%f".


SAMPLE POPULATION PARAMETERS FILE:

seed = 11287			# use this if no value for seed on command line
population_size = 100		
max_depth_for_new_trees = 6   
max_depth_after_crossover = 17
max_mutant_depth = 4
grow_method = RAMPED		# FULL GROW
selection_method = FITNESSPROP	# TOURNAMENT
tournament_K = 6		# used only if TOURNAMENT is selected
crossover_func_pt_fraction = 0.2
crossover_any_pt_fraction = 0.2
fitness_prop_repro_fraction = 0.1
parsimony_factor = 0.00000


CHECKPOINTING:

To enable checkpointing, a non zero value for checkpoint_frequency 
must be specified in the default parameters file, e.g.,

checkpoint_frequency = 10

Remember that if you specify value in the population's parameters
file, the value read from the last parameters file will be used as the
checkpoint frequency for all the populations.

The generated ckptfile is named gpc_`hostid'_`pid'.ckpt.Z, 
i.e. it is compressed using the compression utility specified in the 
makefile

(Note: ignore ckpt files that are not compressed, the process could
have crashed while writing the uncompressed file and it is probably
corrupted.  Of course, this is assuming that you have `compress' on
your system.)

To recover from a crash, just uncompress the ckpt file and type in:

gpc -r ckpt_file_name

As a bonus you can now extend a run for more generations (only if
checkpointing is enabled, i.e. checkpoint_frequency is greater than
zero. Set it to a large value if you do not want checkpointing to slow
you down, but do want a checkpoint file for the last generation).  To
do this, just edit the ckpt file and change the value ONLY for the
following line (it should be the fourth line in the file):

number_of_generations = 100
                        ^^^
to the new total number of generations, i.e. to extend the run by 10 gens
replace 100 by 110.








