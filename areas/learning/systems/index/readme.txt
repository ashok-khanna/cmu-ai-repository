%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Below follows an example session with INDEX, an experimental system for
% inductive data engineering. INDEX was implemented by Peter A. Flach.
% The system is described in the paper "Predicate Invention in Inductive
% Data Engineering", in Proc. ECML '93, P. Brazdil (ed.), LNAI 667,
% Springer Verlag.
% 
% INDEX runs on Quintus Prolog for Sun, and should be easily portable to
% similar Prologs like Sicstus or BIM. To run INDEX, start Prolog and
% consult or compile the file 'main'. After the necessary modules and
% libraries have been read, INDEX is ready to receive your commands.
%
% Please send questions, bug reports, suggestions etc. by email to
% Peter.Flach@kub.nl
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Everything following '? ' is user input.
% Everything following '% ' are annotations.

yoursun> prolog

Quintus Prolog Release 2.5.1 (Sun-4, SunOS 4.1)
Copyright (C) 1990, Quintus Computer Systems, Inc.  All rights reserved.
1310 Villa Street, Mountain View, California  (415) 965-7700

| ?- [main].
[consulting /export/home/flach/index/main...]
[Undefined procedures will just fail ('fail' option)]
 ...
? switch all.	% show all switches
switches ON:
	cwa	% Closed World Assumption for negative tuples
	debug	% display debugging information
	eval	% use heuristics for finding dependencies

switches OFF:
	horn	% don't display rules in Horn form

? switch eval.	% no heuristics; find exact set of dependencies
eval is now off.
? [train].	% get tuples from file
[consulting /export/home/flach/index/train...]
[train consulted 0.183 sec 2,732 bytes]
? get pos train.	% read into internal database
? show all.
positive tuples:
	train(utrecht,8,8,den-bosch)
	train(tilburg,8,10,tilburg)
	train(maastricht,8,10,weert)
	train(utrecht,8,25,den-bosch)
	train(utrecht,9,8,den-bosch)
	train(tilburg,9,10,tilburg)
	train(maastricht,9,10,weert)
	train(utrecht,9,25,den-bosch)
	train(utrecht,8,13,eindhoven-bkln)
	train(tilburg,8,17,eindhoven-bkln)
	train(utrecht,8,43,eindhoven-bkln)
	train(tilburg,8,47,eindhoven-bkln)
	train(utrecht,9,13,eindhoven-bkln)
	train(tilburg,9,17,eindhoven-bkln)
	train(utrecht,9,43,eindhoven-bkln)
	train(tilburg,9,47,eindhoven-bkln)
	train(utrecht,8,31,utrecht)

There are no negative tuples.
There are no integrity constraints.
? init ics train.	% initialise integrity constraints

   1. direction
   2. hour
   3. minutes
   4. stop1
Which dependencies? all.	% select all attributes as righthand-side
? show ics all.
integrity constraints:
	train:[]-->[direction,hour,minutes,stop1]	% fds
	train:[]->->[direction]				% mvds
	train:[]->->[hour]
	train:[]->->[minutes]
	train:[]->->[stop1]

? find ics.	% determine set of satisfied dependencies
	| evaluating mvd(train,[],[direction])
-train(utrecht,8,10,tilburg)	% negative tuple by CWA
	| 	result: refine
	| evaluating mvd(train,[],[hour])
-train(utrecht,9,31,utrecht)
	| 	result: refine
	| evaluating mvd(train,[],[minutes])
-train(tilburg,8,8,tilburg)
	| 	result: refine
	| evaluating mvd(train,[],[stop1])
-train(tilburg,8,10,den-bosch)
	| 	result: refine
	| evaluating fd(train,[],[direction])
	| 	result: refine
	| evaluating fd(train,[],[hour])
	| 	result: refine
	| evaluating fd(train,[],[minutes])
	| 	result: refine
	| evaluating fd(train,[],[stop1])
	| 	result: refine
	| evaluating mvd(train,[minutes],[direction])
-train(tilburg,8,10,weert)
	| 	result: refine
	| evaluating mvd(train,[stop1],[direction])
-train(utrecht,8,17,eindhoven-bkln)
	| 	result: refine
	| evaluating mvd(train,[minutes],[hour])
	| 	result: keep
	| evaluating mvd(train,[stop1],[hour])
	| 	result: keep
	| evaluating mvd(train,[direction],[minutes])
-train(utrecht,8,8,eindhoven-bkln)
	| 	result: refine
	| evaluating mvd(train,[stop1],[minutes])
	| 	result: refine
	| evaluating mvd(train,[direction],[stop1])
	| 	result: refine
	| evaluating mvd(train,[minutes],[stop1])
	| 	result: refine
	| evaluating fd(train,[minutes],[direction])
	| 	result: refine
	| evaluating fd(train,[stop1],[direction])
	| 	result: refine
	| evaluating fd(train,[direction],[minutes])
	| 	result: refine
	| evaluating fd(train,[stop1],[minutes])
	| 	result: refine
	| evaluating fd(train,[direction],[stop1])
	| 	result: refine
	| evaluating fd(train,[minutes],[stop1])
	| 	result: refine
	| evaluating mvd(train,[stop1,minutes],[direction])
	| 	result: keep
	| evaluating mvd(train,[minutes,stop1],[direction])
	| 	result: keep
	| evaluating mvd(train,[stop1,direction],[minutes])
	| 	result: keep
	| evaluating mvd(train,[direction,stop1],[minutes])
	| 	result: keep
	| evaluating mvd(train,[minutes,direction],[stop1])
	| 	result: keep
	| evaluating mvd(train,[direction,minutes],[stop1])
	| 	result: keep
	| evaluating fd(train,[stop1,minutes],[direction])
	| 	result: keep
	| evaluating fd(train,[minutes,stop1],[direction])
	| 	result: keep
	| evaluating fd(train,[minutes,direction],[stop1])
	| 	result: keep
	| evaluating fd(train,[direction,minutes],[stop1])
	| 	result: keep
? show all.
positive tuples:
	train(utrecht,8,8,den-bosch)
	train(tilburg,8,10,tilburg)
	train(maastricht,8,10,weert)
	train(utrecht,8,25,den-bosch)
	train(utrecht,9,8,den-bosch)
	train(tilburg,9,10,tilburg)
	train(maastricht,9,10,weert)
	train(utrecht,9,25,den-bosch)
	train(utrecht,8,13,eindhoven-bkln)
	train(tilburg,8,17,eindhoven-bkln)
	train(utrecht,8,43,eindhoven-bkln)
	train(tilburg,8,47,eindhoven-bkln)
	train(utrecht,9,13,eindhoven-bkln)
	train(tilburg,9,17,eindhoven-bkln)
	train(utrecht,9,43,eindhoven-bkln)
	train(tilburg,9,47,eindhoven-bkln)
	train(utrecht,8,31,utrecht)

negative tuples:
	train(utrecht,8,8,eindhoven-bkln)
	train(utrecht,8,17,eindhoven-bkln)
	train(tilburg,8,10,weert)
	train(tilburg,8,10,den-bosch)
	train(tilburg,8,8,tilburg)
	train(utrecht,9,31,utrecht)
	train(utrecht,8,10,tilburg)

integrity constraints:				% satisfied dependencies:
	train:[minutes]->->[hour]		% mvds
	train:[stop1]->->[hour]
	train:[stop1,minutes]-->[direction]	% fds
	train:[minutes,direction]-->[stop1]

? check ics train:[]->->[hour].	% check if mvd is satisfied
train:[]->->[hour] is contradicted by:
	+train(utrecht,9,8,den-bosch)
	+train(utrecht,8,31,utrecht)
	-train(utrecht,9,31,utrecht)

? decomp train:[]->->[hour].	% vertical decomposition
part1 --- :			% regular cases
	train(maastricht,8,10,weert)
	train(maastricht,9,10,weert)
	train(tilburg,8,10,tilburg)
	train(tilburg,8,17,eindhoven-bkln)
	train(tilburg,8,47,eindhoven-bkln)
	train(tilburg,9,10,tilburg)
	train(tilburg,9,17,eindhoven-bkln)
	train(tilburg,9,47,eindhoven-bkln)
	train(utrecht,8,8,den-bosch)
	train(utrecht,8,13,eindhoven-bkln)
	train(utrecht,8,25,den-bosch)
	train(utrecht,8,43,eindhoven-bkln)
	train(utrecht,9,8,den-bosch)
	train(utrecht,9,13,eindhoven-bkln)
	train(utrecht,9,25,den-bosch)
	train(utrecht,9,43,eindhoven-bkln)

part2 --- :			% exception
	train(utrecht,8,31,utrecht)

Proceed? yes.
partial relation:
	train(maastricht,8,10,weert)
	train(maastricht,9,10,weert)
	train(tilburg,8,10,tilburg)
	train(tilburg,8,17,eindhoven-bkln)
	train(tilburg,8,47,eindhoven-bkln)
	train(tilburg,9,10,tilburg)
	train(tilburg,9,17,eindhoven-bkln)
	train(tilburg,9,47,eindhoven-bkln)
	train(utrecht,8,8,den-bosch)
	train(utrecht,8,13,eindhoven-bkln)
	train(utrecht,8,25,den-bosch)
	train(utrecht,8,43,eindhoven-bkln)
	train(utrecht,9,8,den-bosch)
	train(utrecht,9,13,eindhoven-bkln)
	train(utrecht,9,25,den-bosch)
	train(utrecht,9,43,eindhoven-bkln)

relation name? reg_train.
partial relation:
	train(utrecht,8,31,utrecht)

relation name? irreg_train.
Decompose irreg_train? no.
Decompose reg_train? yes.	% horizontal decomposition
attributes:
	hour

relation name? hour.
attributes:
	direction
	minutes
	stop1

relation name? reg_train1.
? show all.
positive tuples:
	hour(8)
	hour(9)
	reg_train1(maastricht,10,weert)
	reg_train1(tilburg,10,tilburg)
	reg_train1(tilburg,17,eindhoven-bkln)
	reg_train1(tilburg,47,eindhoven-bkln)
	reg_train1(utrecht,8,den-bosch)
	reg_train1(utrecht,13,eindhoven-bkln)
	reg_train1(utrecht,25,den-bosch)
	reg_train1(utrecht,43,eindhoven-bkln)
	irreg_train(utrecht,8,31,utrecht)

negative tuples:
	train(utrecht,8,8,eindhoven-bkln)
	train(utrecht,8,17,eindhoven-bkln)
	train(tilburg,8,10,weert)
	train(tilburg,8,10,den-bosch)
	train(tilburg,8,8,tilburg)
	train(utrecht,9,31,utrecht)
	train(utrecht,8,10,tilburg)

integrity constraints:
	train=[irreg_train,reg_train]		% vertical composition
	reg_train=hour><reg_train1		% horizontal composition (join)
	train:[minutes]->->[hour]		% mvds
	train:[stop1]->->[hour]
	train:[stop1,minutes]-->[direction]	% fds
	train:[minutes,direction]-->[stop1]

? switch horn.	% display rules in Horn form
horn is now on.
? show all.
positive tuples:
hour(8).
hour(9).
reg_train1(maastricht,10,weert).
reg_train1(tilburg,10,tilburg).
reg_train1(tilburg,17,eindhoven-bkln).
reg_train1(tilburg,47,eindhoven-bkln).
reg_train1(utrecht,8,den-bosch).
reg_train1(utrecht,13,eindhoven-bkln).
reg_train1(utrecht,25,den-bosch).
reg_train1(utrecht,43,eindhoven-bkln).
irreg_train(utrecht,8,31,utrecht).

negative tuples:
train(utrecht,8,8,eindhoven-bkln).
train(utrecht,8,17,eindhoven-bkln).
train(tilburg,8,10,weert).
train(tilburg,8,10,den-bosch).
train(tilburg,8,8,tilburg).
train(utrecht,9,31,utrecht).
train(utrecht,8,10,tilburg).

integrity constraints:
train(A,B,C,D) :-		% vertical composition
        (   irreg_train(A,B,C,D)
        ;   reg_train(A,B,C,D)
        ).
reg_train(A,B,C,D) :-		% horizontal composition (join)
        hour(B),
        reg_train1(A,C,D).
train(A,B,C,D) :-		% mvds
        train(E,B,C,F),
        train(A,G,C,D).
train(A,B,C,D) :-
        train(E,B,F,D),
        train(A,G,C,D).
A=B :-				% fds
        train(A,C,D,E),
        train(B,F,D,E).
A=B :-
        train(C,D,E,A),
        train(C,F,E,B).

? halt.		% 'abort' returns to Prolog, 'run' starts INDEX from Prolog
yoursun> 

% End of example session.
