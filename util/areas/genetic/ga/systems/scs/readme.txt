A Simple Classifier System (SCS):
	from Appendix D of "Genetic Algorithms in Search, Optimization, and
	Machine Learning" by David E. Goldberg.  
	Rewritten in C by Erik Mayer  emayer@uoft02.utoledo.edu

Compilation requires the following files:

	scs.c		SCS main program
	declare.scs	global variable declarations
	initial.scs	initialization routines
	detector.scs	environmental-to-classifier detectors
	report.scs	classifier system reporting
	timekeep.scs	time coordination routines
	environ.scs	6-multiplexer environment
	perform.scs	rule and message system
	aoc.scs		apportionment of credit routines
	effector.scs	classifer-to-environment effectors
	reinforc.scs	reinforcement routines
	advance.scs	iteration update routines
	ga.scs		genetic algorithm
	utility.scs	computational utilities
	io.scs		input and output utilities


Input data is in the following files:

	classifers.data		contains list of classifiers, population data 
	environ.data		environmental data
	reinf.data		reinforcement data
	time.data		timekeeping data
	ga.data			genetic algorithm data

Output is written to the following files:

	report.out	Total report of SCS activity.
	plot.out	contains percent correct and percent last 50 correct
			for plotting performance graphs.


Program is run by typing RUN SCS and giving the program a random number seed.

The following is a short description on the operation of the simple
classifier system:

	The classifier system randomly generates a starting population
	of classifiers.  The program then generates a random signal to
	the environment (in this case the multiplexer).  The multiplexer
	responds with the environmental message.  The program then attempts
	to match the random signal with the classifiers and those that match
	are allowed to bid.  The strengths of the matching classifiers are
	deducted by the amount that is to be bid specified by the CBID variable
	and the effective bids of the classifiers are compared.  The classifer
	with the largest effective bid (the bid modified by EBID) wins and the
	classifier message is compared with the enviromental message.  If the
	messages match, the classifier is given a reward.  If the bucketbrigade
	flag is activated, the classifier will post a reward to be given to 
	the last matching classifier.  The genetic algorithm is activation at
	the iteration interation specified by the variable GAPERIOD.  Pairs of 
	classifiers are chosen randomly according to their strengths.  Bad
	performing classifiers are replaced according to their similarities
	to the new offsprings.  Data about the population and its parameters
	is recorded in REPORT.OUT at periodic intervals.  

