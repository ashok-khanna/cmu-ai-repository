%
%                      Genetic Programming in Prolog
%                The Logical Solution to Genetic Algorithms
%
%                     Copyright (c) 1993  Simon Raik
%
%                            Date: July 5, 1993.

%
% Genetic Parameters
%
population_size(10).				% Number of individuals in population
maximum_generations(20).			% number of generations to perform
maximum_initial_depth(4).			% max initial depth of genetic programs
maximum_depth_after_crossover(15).	% like it says...
maximum_actions(30).				% Number of actions each individual is
									% allowed to perform in a life time.
grid_size(10).

% Dubbugging?
debug_on(off).

debug_info(Message) :-
	debug_on(on),
	write(Message), nl.
debug_info(_).


% Function & Terminal declarations
terminals([turn_left, turn_right, advance]).
functions([begin, if_sensor]).

%
% Terminals	Set
%
turn_left(Who) :-
	debug_info(turn_left),
	write('.'),
	
	% increment the action counter
	actions(Actions),
	Num is Actions + 1,
	retract(actions(Actions)),
	assert(actions(Num)),
	
	direction(Who, X),
	retract(direction(Who, X)),
	New is (X - 1) mod 4,	
	assert(direction(Who, New)).
	
turn_right(Who) :- 
	debug_info(turn_right),
	write('.'),
	
	% increment the action counter
	actions(Actions),
	Num is Actions + 1,
	retract(actions(Actions)),
	assert(actions(Num)),
	
	direction(Who, X),
	retract(direction(Who, X)),
	New is (X + 1) mod 4,	
	assert(direction(Who, New)).

advance(Who) :-
	debug_info(advance),
	write('.'),
	
	% increment the action counter
	actions(Actions),
	Num is Actions + 1,
	retract(actions(Actions)),
	assert(actions(Num)),

	% Move in the direction facing.
	direction(Who, Direction),
	adjustment(Direction, X, Y),
	x_pos(Who, OldX),
	y_pos(Who, OldY),
	
	grid_size(Grid),
	NewX is (OldX + X) mod Grid,
	NewY is (OldY + Y) mod Grid,
	   	
	% Debug
	debug_info('Direction: '), 
	debug_info(Direction),
	debug_info('Old X: '), 
	debug_info(OldX), 
	debug_info(' Y: '), 
	debug_info(OldY),
	debug_info('New X: '), 
	debug_info(NewX), 
	debug_info(' Y: '), 
	debug_info(NewY),
	 
	% Replace the new info into the database.
	retract(x_pos(Who, OldX)),
	retract(y_pos(Who, OldY)),
	assert(x_pos(Who, NewX)),
	assert(y_pos(Who, NewY)),
	
	possible_crumb(Who).

possible_crumb(Who) :-
	x_pos(Who, X),
	y_pos(Who, Y),
	
	% check if there is a crumb there.
	crumb(Who, X, Y),!,

	% Add to the fitness
	fitness(Who, Fitness),
	retract(fitness(Who, Fitness)),
	NewFitness is Fitness + 1,
	assert(fitness(Who, NewFitness)),
	
	% remove the crumb.
	retract(crumb(Who, X, Y)).

possible_crumb(_).
	
%
% Functions Set
%
begin. % No definition required,

% Returns true or false.
if_sensor(Who) :-
	% Check for the presence of a crumb in the direction facing.
	direction(Who, Direction),
	adjustment(Direction, X, Y),
	x_pos(Who, OldX),
	y_pos(Who, OldY),
	
	grid_size(Grid),
	NewX is OldX + X mod Grid,
	NewY is OldY + Y mod Grid,
	
	crumb(Who, NewX, NewY).

% Directional adjustment for x & y values.	
adjustment(0,  0,  1).
adjustment(1,  1,  0).
adjustment(2,  0, -1).
adjustment(3, -1,  0).

%
% Create genetic program - Create a random genetic program
%
create_genetic_program(GP) :-
	maximum_initial_depth(MaxDepth),
	create_random_program(GP, MaxDepth, 0).
	
create_random_program(GP, MaxDepth, 0) :-
	% First one, choose a function
	select_random_function(Function),
	create_random_args(Args, MaxDepth, 0),
	concat([Function], Args, GP),!.

create_random_program(Terminal, Depth, Depth) :-
	select_random_terminal(Terminal).

create_random_program(GP, MaxDepth, CurrentDepth) :-
	% inner node, function or terminal
	select_random_construct(Construct),
	function_or_terminal(Construct, GP, MaxDepth, CurrentDepth).

function_or_terminal(Construct, Construct, MaxDepth, CurrentDepth) :-
	% The construct is a terminal
	terminals(Terminals),
	member(Construct, Terminals).

function_or_terminal(Construct, GP, MaxDepth, CurrentDepth) :-
	% Must be a function.
	create_random_args(Args, MaxDepth, CurrentDepth),
	concat([Construct], Args, GP).

create_random_args(Args, MaxDepth, CurrentDepth) :-
	% Two args cause all functions have 2 arguments.
	% Not very generic.
	NewDepth is CurrentDepth + 1,
	create_random_program(Arg1, MaxDepth, NewDepth),
	create_random_program(Arg2, MaxDepth, NewDepth),
	concat([Arg1], [Arg2], Args).
	
select_random_terminal(Terminal) :-
	terminals(Terminals),
	length(Terminals, Length),
	Rand is irand(Length),
	index(Terminals, Rand, Terminal).

select_random_function(Function) :-
	functions(Functions),
	length(Functions, Length),
	Rand is irand(Length),
	index(Functions, Rand, Function).

select_random_construct(Construct) :-
	terminals(Terminals),
	functions(Functions),
	concat(Terminals, Functions, Constructs),
	length(Constructs, Length),
	Rand is irand(Length),
	index(Constructs, Rand, Construct).

%
% Create Individual - create the data base elements for individuals
%
create_individual(Id, GP) :-
	% Assert the initial state
	asserta(x_pos(Id, 0)),
	asserta(y_pos(Id, 0)),
	asserta(fitness(Id, 0)),
	asserta(direction(Id, 0)),
	
	asserta(genetic_program(Id, GP)),
	
	% Make the environment.
	asserta(crumb(Id, 0, 1)),
	asserta(crumb(Id, 1, 1)),
	asserta(crumb(Id, 2, 1)),
	asserta(crumb(Id, 2, 2)),
	asserta(crumb(Id, 2, 3)),
	asserta(crumb(Id, 2, 5)),
	asserta(crumb(Id, 3, 6)),
	asserta(crumb(Id, 4, 5)),
	asserta(crumb(Id, 5, 4)),
	asserta(crumb(Id, 5, 2)),
	asserta(crumb(Id, 6, 2)),
	asserta(crumb(Id, 7, 2)),
	asserta(crumb(Id, 9, 3)),
	asserta(crumb(Id, 9, 4)),
	asserta(crumb(Id, 8, 5)),
	asserta(crumb(Id, 8, 7)),
	asserta(crumb(Id, 9, 9)).

%
% Create initial population
%
create_initial_population :-
	population_size(PopulationSize),
	add_individuals(PopulationSize).

add_individuals(0).
add_individuals(PopulationSize) :-
	Id is PopulationSize - 1,
	create_genetic_program(GP),
	create_individual(Id, GP),
	add_individuals(Id).

%
% Create new population - generate a new populartion of recombination.
%
create_new_population(0,[]).
create_new_population(PopulationSize, [Gene|Rest]) :-
	Id is PopulationSize - 1,
	create_individual(Id, Gene),
	create_new_population(Id, Rest).
	
%
% Crossover - perform crossover on two genetic programs
%
crossover(Parent1, Parent2, Offspring) :-
	% Select a random point in each parent
	number_of_nodes(Parent1, Node1),
	number_of_nodes(Parent2, Node2),
	
	% Select random nodes in each
	Rand1 is irand(Node1),
	Rand2 is irand(Node2),

	% Get the node of the second parent and sub it into the first
	get_expression(Parent2, Rand2, Expression),

	%pretty_print(Parent1),nl, 
	%write('Node Number: '), write(Rand1), nl,
	%write('Expression: '), write(Expression), nl,

	asserta(gp_nodes(0)),
	swap([Parent1], Rand1, Expression, [Offspring|_]),
	kill(gp_nodes),!.

swap([], _, _, []).
swap([H|T], Node, E, [E|O]) :-
	gp_nodes(Current),
	Node =:= Current,
	swap(T, 999, E, O).

swap([H|T], Node, E, [H|O]) :-
	atom(H),	
	inc_nodes,
	swap(T, Node, E, O).

swap([H|T], Node, E, [H2|T2]) :-
	swap(H, Node, E, H2),
	swap(T, Node, E, T2).
	
get_expression(GP, Node, E) :-
	asserta(gp_nodes(0)),
	ge([GP], Node, E),
	retract(gp_nodes(Node)).

ge([], _, _).

ge([H|T], Node, H) :-
	gp_nodes(Node).

ge([H|T], Node, E) :-
	atom(H),
	inc_nodes,
	ge(T, Node,E).
	
ge([H|T], Node, E) :-
	cdr(H, Cdr),
	inc_nodes,
	ge(Cdr, Node, E),
	cont(T, Node, E).
	
cont(_, _, E) :-
	nonvar(E).

cont(T,Node, E) :-
	ge(T, Node, E).


%
% Display stats - show some running statistics.
%
display_stats(Gen) :-
	write('----------------- Generation '),
	write(Gen),
	write(' ----------------------------'), nl,
	
	fitness_list(FitnessList),
	sort(FitnessList, SortedList),
	write(SortedList), nl.
	
%
% Evaluate - Evaluate a genetic program
%
evaluate(Who, GP) :-
	% test the actions limit. Keep executing as long as not yet reached.
	actions(Actions),
	maximum_actions(MaxActions),
	Actions < MaxActions,
	
	debug_info('Actions:'), 
	debug_info(Actions),
	
	% Gather some stats
	x_pos(Who, Xpos),
	y_pos(Who, Ypos),
	fitness(Who, Fitness),
	debug_info(['      X: ', Xpos]),
	debug_info(['      Y: ', Ypos]),
	debug_info(['Fitness: ', Fitness]),
	
	
	% Run the genetic program
	eval(Who, GP),
	!,
	
	% Do it again...
	evaluate(Who, GP).
	
evaluate(Who, GP) :-
	debug_info('Evaluate Failed: '),
	debug_info(Who), debug_info(GP).

%
% Eval
%
eval(_, []).

eval(Who, [if_sensor, Arg1, Arg2]) :-
	if_sensor(Who),
	eval(Who, Arg1).
	
eval(Who, [if_sensor, Arg1, Arg2]) :-
	!,
	eval(Who, Arg2).
	
eval(Who, [begin, Arg1, Arg2]) :-
	eval(Who, Arg1),
	eval(Who, Arg2).
	
eval(Who, GP) :-
	atom(GP),
		
	% test the actions limit.
	actions(Actions),
	maximum_actions(MaxActions),
	Actions < MaxActions,
	
	% make up the function call.
	functor(C, GP, 1),
	arg(1, C, Who),
	call(C).

eval(_,_).
% :-
%	debug_info('Eval Error').

% 
%
% Execute generations - run the simulation.
%
execute_generations(Generation) :-
	maximum_generations(MaxGens),
	MaxGens =:= Generation.

execute_generations(Generation) :-
	recombine(Generation),
	debug_info('...Before Fitness Test...'),
	
	fitness_test(0),
	display_stats(Generation),
	
	Next is Generation + 1,
	execute_generations(Next).
	

%
% Fitness test - execute individuals to obtain fitness.	
%
fitness_test(Who) :-
	% Exit condition
	population_size(Size),
	Who < Size,
	
	debug_info('...Fitness Testing...'),
	
	% get the genetic program.
	genetic_program(Who, GP),
	
	% reset the actions counter
	kill(actions),
	assert(actions(0)),
	
	write('--------------------------------------------------------'),nl,
	write('Evaluate Individual No. '), write(Who), nl,
	pretty_print(GP), 
	
	evaluate(Who, GP),
	
	fitness(Who, Fitness),
	nl,
	write('Fitness:'), 
	write(Fitness),nl,
	write('--------------------------------------------------------'),nl,


	Next is Who + 1,
	!,
	fitness_test(Next).
	
fitness_test(_) :-
	debug_info('Fitness Test Failed').


%
% Number of Nodes - Number of possible swap nodes in a genetic program
%
number_of_nodes(GP, Nodes) :-
	asserta(gp_nodes(0)),
	nn([GP]),
	gp_nodes(Nodes),
	retract(gp_nodes(Nodes)), !.

inc_nodes :-
	gp_nodes(Nodes),
	retract(gp_nodes(Nodes)),
	NewNodes is Nodes + 1,
	asserta(gp_nodes(NewNodes)).
	

nn([]).

nn([H|T]) :-
	atom(H),
	inc_nodes,
	nn(T).
	
nn([H|T]) :-
	cdr(H, Cdr),
	inc_nodes,
	nn(Cdr),
	nn(T).
		
%
% Pretty Print - format genetic programs for debugging.
%
pretty_print(GP) :-
	pp([GP], 0), nl.
		
pp([], _) :-
	write(')').

pp([H|T], Tab) :-
	atom(H), nl,
	tab(Tab),
	write(H), 
	pp(T, Tab).
	
pp([H|T], Tab) :-
 	nl, 
	tab(Tab),
	car(H, Car),
	cdr(H, Cdr),
	write('('), write(Car), 
	NewTab is Tab + 4,
	pp(Cdr, NewTab),
	pp(T, Tab).

%
% Progam Depth - Measures the maximum depth of a genetic program.
%
program_depth(GP, Depth) :-
	asserta(gp_depth(0)),
	traverse([GP], 0),
	gp_depth(Depth),
	retract(gp_depth(Depth)).
	
new_depth(Depth) :-
	gp_depth(Current),
	Depth > Current,
	kill(gp_depth),
	asserta(gp_depth(Depth)).
new_depth(_).

traverse([], D).
traverse([H|T], Depth) :- 
	atom(H),
	traverse(T, Depth).	
traverse([H|T], Depth) :- 
	New is Depth + 1,
	new_depth(New),
	traverse(H, New),
	traverse(T, Depth).

%
% Recombine - Select individuals proportionate to fitness and 
%             make a new population.
%
recombine(0).
	% don't recombine first generation. No point.
	% bagof(GeneticProgram, Id^(genetic_program(Id, GeneticProgram)), GP).
	
recombine(_) :-
	%debug_info('...Recombination...'),
	
	% Make a list of gp's, sorted by fitness.
	fitness_list(FitnessList),
	%debug_info('Fitness list obtained'),
	%debug_info(FitnessList),
	
	sort(FitnessList, SortedList),
	%debug_info('Fitness list sorted:'),
	%debug_info(SortedList),
	
	total_fitness(SortedList, TotalFitness),
	%debug_info('Total fitness caculated:'),
	%debug_info(TotalFitness),
	
	% Mate them.
	population_size(Size),
	make_new_genes(Size, SortedList, TotalFitness, NewPop),
	
	%debug_info('The new population:'),
	%debug_info(NewPop),	
	
	% kill the old and make a new.
	kill_old_population,
	create_new_population(Size, NewPop).

total_fitness([], 0).
total_fitness([H|Rest], Total) :-
	total_fitness(Rest, SoFar),
	car(H, Fitness),
	Total is Fitness + SoFar.
	
kill_old_population :-	
	kill(fitness),
	kill(crumb),
	kill(x_pos),
	kill(y_pos),
	kill(direction),
	kill(actions),
	kill(genetic_program).

make_new_genes(0, SortedList, TotalFitness, []).
make_new_genes(Id, SortedList, TotalFitness,  [Baby|T]) :-
	% select two gp's proportionate to fitness
	select_random_individual(Person1, SortedList, TotalFitness),
	select_random_individual(Person2, SortedList, TotalFitness),
	
	%debug_info('Selected Person 1:'),
	%debug_info(Person1),
	%debug_info('Selected Person 2:'),
	%debug_info(Person2),
		
	% perform crossover and keep the offspring.
	genetic_program(Person1, Gene1),
	genetic_program(Person2, Gene2),
	crossover(Gene1, Gene2, Baby),

	Next is Id - 1,
	make_new_genes(Next, SortedList, TotalFitness, T).
					   
% Each element is the pair [Id, Fitness].
fitness_list(L) :-
	population_size(PopSize),
	First is PopSize -1,
	make_fitness_list(First, L),!.
	
make_fitness_list(0, [H|[]]) :-
	fitness(0, Fitness),
	concat([Fitness], [0], H).
	
make_fitness_list(Id, [H|T]) :-
	fitness(Id, Fitness),
	concat([Fitness], [Id], H),
	New is Id - 1,
	make_fitness_list(New, T).

%
% Select random indivdual - Fitness proportionate selection.
%
select_random_individual(Individual, SortedList, TotalFitness) :-
	% Select an individual (first element) from the list proportionate 
	% to their fitness(second element).
	Random is irand(TotalFitness),
	debug_info('Random Fitness selected:'),
	debug_info(Random),
	s_r_i(Individual, SortedList, 0, Random).

s_r_i(_,[],_,_) :-
	write('Individual Selection Error').

s_r_i(Id, [H|T], FitnessSoFar, Rnd) :-
	car(H, Fitness),
	NewFitness is FitnessSoFar + Fitness,
	Rnd =< NewFitness,
	cdr(H, IdList),
	car(IdList, Id).

s_r_i(Id, [H|T], FitnessSoFar, Rnd) :-
	car(H, Fitness),
	NewFitness is FitnessSoFar + Fitness,
	s_r_i(Id, T, NewFitness, Rnd).
	
	
%
% Test Harness
%	
gp :-
	kill_old_population,
	create_initial_population,
	execute_generations(0).


k :-
	kill(fitness),
	kill(crumb),
	kill(x_pos),
	kill(y_pos),
	kill(direction),
	kill(genetic_program).
%
% Auxilliary Procedures
%
car([H|_], H).
cdr([_|T], T).

index([Element|List], Index, Element) :-
	Index =:= 0.
index([Element|List], Index, E) :-
	NewIndex is Index - 1,
	index(List, NewIndex, E).

member(E, [E|_]).
member(E, [_|T]) :- member(E, T).
	
