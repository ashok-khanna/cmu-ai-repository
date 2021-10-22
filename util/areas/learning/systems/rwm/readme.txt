

                               R W M
                               =====

What is RWM?
------------
RWM (Refinement With Macros) is an interactive system for learning
problem solving strategies. RWM incorporates two techniques, namely
Refinement and Macro Generation. The input to the RWM is the definition
of a problem, the output is a strategy for solving the given problem.
A strategy is a sequence of subproblems which are easier then the original
problem, and when solved in the the given order it yields a solution
for the original problem.


Where does it run?
------------------
This version of RWM has been implemented in Common Lisp, and tested in
Lucid Common Lisp 4.0. It should run without any difficulty in any
Common Lisp environment.


What files are included?
-----------------------
You must have the following files under the directory you have created
for RWM:

DDKB/
INPUTS/
OUTPUTS/
PROBLEMS/
README
print-stage-all.lisp
rwm.lisp

DDKB:            ; Some Domain Dependent Knowledge Bases
GENERIC.lisp
INC-3.lisp

INPUTS:          ; Example input commands for some problems
DOMINO
EIGHT
INS
MB-mc
MB-mx
MB-sg
MOD-3
PYRAMINX
RC-2
RM
THP-3

OUTPUTS:           ; Output strategies corresponding to inputs in INPUTS
DOMINO
EIGHT
INS
MB-mc
MB-mx
MB-sg
MOD-3
PYRAMINX
RC-2
RM
THP-3

PROBLEMS:             ; Example problem definitions
DOMINO.lisp
EIGHT.lisp
INS.lisp
MB.lisp
MOD-3.lisp
PYRAMINX.lisp
RC-2.lisp
RM.lisp
THP-3.lisp


How to start
------------

First start your lisp environment. Then compile 3 files (only once) as follows:
>(compile-file "rwm")
....
>(compile-file "DDKB/GENERIC")
....
>(compile-file "DDKB/INC-3")
....
Then load rwm as follows:
>(load "rwm")
....
To test the input sequences provided (e.g., RC-2: 2x2x2 Rubik's Cube) type:
>(load "INPUTS/RC-2")
.... trace of the learning proces ....
Then to quit type
>(quit)

Now, you will find a file called "output" in the RWM directory which is a log
of the learning process. This file must be the same as the file "OUTPUTS/RC-2".


How can I run rwm interactively?
-------------------------------
RWM commands are single letter function names. They are:
(i "problem-definition-file") : initialize rwm to the problem in the file.
(p n) : show the nth problem. The original problem is the 0th problem.
        if you create subproblems for operator preconditions they will be
        numbered 1, 2,  and so on.
(s n m) : show the mth stage of the nth problem.
(r n m) : refine the mth stage of the nth problem.
(m n m) : generate new macros for the mth stage of the nth problem.
(c n m '(o)) : create a new problem for the operator o to be used in solving
               the mth stage of the nth problem.
(x) : show the complete strategy and exit.


How can I learn more about RWM?
------------------------------
Some references:

H. A. Guvenir and G. W. Ernst, "Learning Problem Solving Strategies Using
Refinement and Macro Generation", Artificial Intelligence, Vol. 44, No. 1-2,
July, 1990. pp. 209-243.

H. A. Guvenir and V. Akman, "Problem Representation for Refinement", Mind and 
Machines, Vol. 2, No. 3, August 1992. pp 267-282.

H. A. Guvenir and G. W. Ernst, "A Method for Learning Problem Solving
Strategies", Proceedings of the AAAI Spring Symposium Series, Stanford
University, March 1988. pp 31-35.



