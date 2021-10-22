From crabapple.srv.cs.cmu.edu!bb3.andrew.cmu.edu!news.sei.cmu.edu!magnesium.club.cc.cmu.edu!pitt.edu!gatech!howland.reston.ans.net!noc.near.net!uunet!pipex!uknet!edcastle!aisb!aisb.ed.ac.uk!peter Sat Jul 10 14:20:25 EDT 1993
Article: 955 of comp.ai.genetic
Xref: crabapple.srv.cs.cmu.edu comp.ai.genetic:955
Path: crabapple.srv.cs.cmu.edu!bb3.andrew.cmu.edu!news.sei.cmu.edu!magnesium.club.cc.cmu.edu!pitt.edu!gatech!howland.reston.ans.net!noc.near.net!uunet!pipex!uknet!edcastle!aisb!aisb.ed.ac.uk!peter
From: peter@aisb.ed.ac.uk
Newsgroups: comp.ai.genetic
Subject: Pseudo-parallel GA s/w available by FTP
Message-ID: <1993Jul9.124740.15224@aisb.ed.ac.uk>
Date: 9 Jul 93 12:47:40 GMT
Sender: news@aisb.ed.ac.uk (Network News Administrator)
Reply-To: peter@aisb.ed.ac.uk ()
Organization: Dept AI, Edinburgh University, Scotland
Lines: 176


[I tried to post this last week but our systems were in flux,
 I don't think it got out to the world..]

Folks on comp.ai.genetic might be interested in the s/w described
below, which is available by anonymous ftp from ftp.dai.ed.ac.uk
(192.41.104.152) in
     ftp.dai.ed.ac.uk:pub/pga-2.4/pga-2.4.tar.Z
The compressed tarfile is about 44Kb. The software has been used
for teaching and as the basis of a number of projects. It's not
a miracle of beautiful coding but is pretty robust and useful
for basic explorations of a range of GA-related topics. For example,
you should be able to explore the interetsing interplay between
chromosome length and the likelihod of premature convergence when
trying to maximise the number of 1 bits; or the interplay between
block size and population size in the royal road functions
(which are Mitchell+Forrest's RR1); or deme effects, in which having
P populations of size N with periodic migration work better than
a single population of size P*N.

The reproduction operator named `one' in the README below
is of course modelled on Genitor.

Hope you find it useful,


Peter Ross               peter@aisb.ed.ac.uk
Department of AI
University of Edinburgh
Edinburgh EH1 1HN

.................................................................


PGA, the Parallel Genetic Algorithms testbed -- version 2.4
-----------------------------------------------------------

Posted by Peter Ross, peter@aisb.ed.ac.uk, June 93
Original version by Geoffrey H. Ballinger, geoff@ed.ac.uk
Current version developed/maintained by Peter Ross, peter@aisb.ed.ac.uk 


WHAT IT IS

PGA is a simple testbed for basic explorations in genetic algorithms.
Command line arguments control a range of parameters, there are a
number of built-in problems for the GA to solve. The current set
consists of:
  - maximise the number of bits set in a chromosome
  - De Jong's functions DJ1, DJ2, DJ3, DJ5
  - binary F6, used by Schaffer et al
  - a crude 1-d knapsack problem; you specify a target and a set of
    numbers in an external file, GA tries to find a subset that sums
    as closely as possible to the target
  - the `royal road' function(s); a chromosome is regarded as
    a set of consecutive blocks of size K, and scores K for each
    block entirely filled with 1s
and it's easy to add your own problems (see below). Chromosomes are
represented as character arrays, so you are not (quite) stuck with
bit-string problem encodings.

PGA allows multiple populations, with periodic migration between
them, and a range of other options. For example, you can choose
the chromosome length independently of the choice of problem.
The command-line options are summarised by the `-h' flag:
    % pga -h
    PGA: parallel genetic algorithm testbed, version 2.4
         -P<n>    Set number of populations. (5)
         -p<n>    Set number of chromosomes per population. (50)
         -n<n>    Set chromosome length. (32)
         -l<n>    Set # of generations per stage. (100)
         -i<n>    Set reporting interval in generations. (10)
         -M<n>    Interval between migrations. (10)
         -m<n>    Set mutation rate. (0.05)
         -c<n>    Set crossover rate (only for `gen'). (0.6)
         -b<n>    Set selection bias. (1.5)
         -a       Flip adaptive mutation flag (only for `one') (FALSE)
         -C<op>   Set crossover operator. (two)
         -s<op>   Set selection operator. (rank)
         -r<op>   Set reproduction operator. (one)
         -e<fn>   Set evaluation function. (max)
         -h       Display this information.
         <file>   Also log output in <file>. (none)

         Crossover operators ... one, two, uniform.    
         Selection operators ... rank, fitprop.
         Reproduction operators ... one, gen.
         Evaluation functions ... max, dj1, dj2, dj3,
                                  dj5, bf6, knap,
                                  rrK (K=integer > 1).


The output is curses-based, with optional output to file for later
plotting or analysis using a tool such as (g)awk. The screen layout
looks like this:

    .................................................................
     (A)gain, (C)ontinue, (Q)uit:  
               Populations: 5            Chromosomes per pop: 50
                                           Chromosome length: 32
     Generations per stage: 100                 Reproduction: one
        Reporting interval: 10                Crossover type: two-point
        Migration interval: 10                Crossover rate: n/a
             Eval function: knap               Mutation rate: 0.05
                 Selection: rank
            Selection bias: 1.50                  Generation: 1000
                                          Evaluations so far: 5000
                  Pop.......Average..........Best.(max = 1.0)
                  0   =       0.3333333        0.3333333
                  1           0.3366667        0.5000000
                  2   =       0.3333333        0.3333333
                  3           0.4876190        1.0000000
                  4           0.2609524        0.3333333
    .................................................................

The `A' option restarts with new randomly-chosen chromosomes. The `C'
option continues for a further number of generations, as determined
by the `-l' flag (`generations per stage' in the above display).
The `=' opposite populations 0 and 2 show that they appear to have
converged, because the average fitness and best fitness are equal.
If you have specified output to file too, then you also get the
option of saving the chromosomes to a file called filename.chr.

INSTALLING IT

There is a very simple Makefile, which doesn't even install it for you!
Source consists of one C file and one header file, using K+R C. The code
was developed on a Sun-4. The curses usage is pretty simple, so it
should be easy to adapt it to your own system. I don't have access to a
range of machines, so I haven't provided lots of system-dependents
switches. This distribution contains the following files:
    Makefile     ... the makefile?
    QUESTIONS    ... some practical questions for you to investigate
    README       ... this file, you're reading it
    graph1.awk   ... example of how to use (g)awk to plot output
    graph2.awk   ... fancier example, plot each population on same graph
    pga.c        ... the source
    pga.h        ... the header, mainly defines screen display locations
    pga.p        ... the man page
    pga.tex      ... LaTeX document, 6 pages
    weights      ... example weights file for crude knapsack problem


ADDING NEW PROBLEMS

To add a new problem to pga:
  - create a new eval_whatever function, alongside the others;
    put any problem-specific auxiliary functions there too (eg
    read_weights_file is used in knpasack problem, is beside eval_knap).
    Remember that eval_whatever has to increment evals each time it is
    called.
  - declare eval_whatever at top of file
  - declare any problem-specific globals and other data-reading
    functions at top of file
  - go to procedure handle(), case 'e', add the branch which sets
    eval to be eval_whatever, and sets maxfitness (a string) and
    eval_name (a string) appropriately
  - in main, just after handle() is called, you may need to add any
    problem-specific setup stuff that cannot be done until all arguments
    are processed (eg see the bit which says if(eval == eval_knap).. )


PROBLEMS, QUESTIONS

PGA has been used for teaching for a couple of years now, and has been
used as a starting point by a fair number of people for their own
projects. So it's reasonably reliable. However, if you find bugs, or have
useful contributions to make, Tell Me!

Peter Ross
Dept of AI
University of Edinburgh
80 South Bridge
Edinburgh EH1 1HN

peter@aisb.ed.ac.uk


