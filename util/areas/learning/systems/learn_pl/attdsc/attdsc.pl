/******************************************************************/
/* ATTDSC.PRO         Last Modification: Fri Jan 14 19:22:05 1994 */
/* Bratko's simple algorithm for attributional descriptions.      */
/******************************************************************/
%
%    Copyright (c) 1990 Ivan Bratko
%
/******************************************************************/
/*  reimpl. by  : Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1991                                            */
/*                                                                */
/*  reference   : Chapter 18,                                     */
/*                Ivan Bratko                                     */
/*                Prolog                                          */
/*                2nd extend edition                              */
/*                Addison-Wesley, 1990                            */
/*                                                                */
/*  call        : learn(+ClassName)                               */
/*                                                                */
/*  argument    : ClassName = name of the class, whose descrip-   */
/*              	      tion should be learned              */ 
/*                                                                */
/******************************************************************/
/* The representation used:                                       */
/*   Attribute = attributes(AttributeName,ListOfPossibleValues)   */
/*   Example   = example(ClassName,ListOfAttributeValues)         */
/*   AttributeValues = Attribute = Value                          */
/*                                                                */
/* learn induces class descriptions of the form:                  */
/*                                                                */
/*	Class <== ListOfAttributeValues                           */
/*                                                                */
/* with the meaning: An object is an Class, if it fulfills the    */
/* class description given by ListOfAttributeValues.              */  
/*                                                                */
/******************************************************************/
% TH Sat May 29 23:45:01 1993  - Made some minor modifications

:- op(300,xfx,<==).

/******************************************************************/
/* Some M-, C- and YAP-Prolog dependent declarations.             */
/******************************************************************/
:- dynamic '<=='/2.

/******************************************************************/
/*                                                                */
/*  call        : learn(+Class)                                   */
/*                                                                */
/*  arguments   : Class = class name to be learned                */
/*                                                                */
/*  side effects: asserts classification rules in the database    */
/*                                                                */
/******************************************************************/
/* 'learn' collects all examples into a list, constructs and out- */
/* puts a description for Class, and asserts the corresponding    */
/* rule about Class.                                              */
/******************************************************************/
learn(Class) :-
	bagof(example(ClassX,Obj),example(ClassX,Obj),Examples),
	learn(Examples,Class,Description),
	nl,
	write(Class), write('<=='), nl,
	writelist(Description),
	assert(Class<==Description).

/******************************************************************/
/*                                                                */
/*  call        : learn(+Examples,+Class,-Description)            */
/*                                                                */
/*  arguments   : Examples    = list of all available examples    */
/*                Class       = class name to be learned          */
/*                Description = induced concept description       */
/*                                                                */
/******************************************************************/
/* Description covers exactly the positive examples of Class in   */
/* list Examples. If no examples exist for Class, an empty De-    */
/* scription is returned. After a conjunction was learned the     */
/* examples matching the conjunction are removed from Examples    */
/* and for remaining RestExamples a further conjunct is learned.  */
/******************************************************************/
learn(Examples,Class,[]) :-
	not(member(example(Class,_),Examples)).
learn(Examples,Class,[Conj|Conjs]) :-
	learn_conj(Examples,Class,Conj),
	remove(Examples,Conj,RestExamples),
	learn(RestExamples,Class,Conjs).
	
/******************************************************************/
/*                                                                */
/*  call        : learn_conj(+Examples,+Class,-Conj)              */
/*                                                                */
/*  arguments   : Examples = list of all available examples       */
/*                Class    = class name to be learned             */
/*                Conj     = list of attribute/value pairs        */
/*                                                                */
/******************************************************************/
/* Conj is a list of attribute/value pairs are satisfied by some  */
/* examples of class Class and no other classes. If there is no   */
/* other Example of a different class covered, the empty Conj is  */
/* returned. Otherwise, we choose the best attribute/value pair   */
/* according to the evaluation criterion used in 'score' and      */
/* filter out all examples, that cover this attribute/value pair. */
/******************************************************************/
learn_conj(Examples,Class,[]) :-
	not((member(example(ClassX,_),Examples),
	     not(ClassX == Class))), !.
learn_conj(Examples,Class,[Cond|Conds]) :-
	choose_cond(Examples,Class,Cond),
	filter(Examples,[Cond],Examples1),
	learn_conj(Examples1,Class,Conds).
	
choose_cond(Examples,Class,AttVal) :-
	findall(AV/Score,score(Examples,Class,AV,Score),AVs),
	best(AVs,AttVal).
	
best([AttVal/_],AttVal).
best([AV0/S0,AV1/S1|AVSlist],AttVal) :-
	S1 > S0, !,
	best([AV1/S1|AVSlist],AttVal);
	best([AV0/S0|AVSlist],AttVal).
	
/******************************************************************/
/*                                                                */
/*  call        : score(+Examples,+Class,-AttVal,-Score)          */
/*                                                                */
/*  arguments   : Examples = list of all available examples       */
/*                Class    = class name to be learned             */
/*                AttVal   = chosen attribute/value pair          */
/*                Score    = value of AttVal                      */
/*                                                                */
/******************************************************************/
/* 'score' determines an suitable attribute/value pair, determines*/
/* how many examples are covered and computes a value for the     */
/* chosen attribute/value pair.                                   */
/* Remark: In the current implementation at least one example has */
/* to be covered. Thus, in some cases it can happen, that rules   */
/* are generated, which cover exactly one example. Hence, we do   */
/* not benefite from learning. This can be changed by requiring   */
/* that at least two examples should be covered.                  */
/******************************************************************/
score(Examples,Class,AttVal,Score) :-
	candidate(Examples,Class,AttVal),
	filter(Examples,[AttVal],Examples1),
	length(Examples1,N1),
	count_pos(Examples1,Class,NPos1),
	NPos1 > 0,
	Score is 2 * NPos1 - N1.
	
candidate(Examples,Class,Att=Val) :-
	clause(attribute(Att,Values),true),
	member(Val,Values),
	suitable(Att=Val,Examples,Class).
	
suitable(AttVal,Examples,Class) :-
	% atleast one neg. example must not match AttVal
	member(example(ClassX,ObjX),Examples),
	not(ClassX == Class),
	not(satisfy(ObjX,[AttVal])), !.
	
/******************************************************************/
/*                                                                */
/*  call        : count_pos(+Examples,+Class,-N)                  */
/*                                                                */
/*  arguments   : Examples = list of all available examples       */
/*                Class    = class name to be learned             */
/*                N        = number of covered examples           */
/*                                                                */
/******************************************************************/
/* N is the number of positive examples of Class                  */
/******************************************************************/
count_pos([],_,0).
count_pos([example(ClassX,_)|Examples],Class,N) :-
	count_pos(Examples,Class,N1),
	(ClassX = Class, !, N is N1 + 1; N = N1).
	
/******************************************************************/
/*                                                                */
/*  call        : filter(+Examples,+Cond,-Examples1)              */
/*                                                                */
/*  arguments   : Examples  = list of all available examples      */
/*                Cond      = attribute/value pair                */
/*                Examples1 = list of examples with attr/val      */
/*                                                                */
/******************************************************************/
/* Examples1 contains elements of Examples that satisfy Condition */
/******************************************************************/
filter(Examples,Cond,Examples1) :-
	findall(example(Class,Obj),
		(member(example(Class,Obj),Examples),
		 satisfy(Obj,Cond)),
		Examples1).
		
/******************************************************************/
/*                                                                */
/*  call        : remove(+Examples,+Conj,-RestExamples)           */
/*                                                                */
/*  arguments   : Examples     = list of all available examples   */
/*                Conj         = list of attribute/value pair     */
/*                RestExamples = list of examples not matching    */
/*                               Conj                             */
/*                                                                */
/******************************************************************/
/* removing from Examples those examples that match Conj gives    */
/* RestExamples .                                                 */
/******************************************************************/
remove([],_,[]).
remove([example(Class,Obj)|Es],Conj,Es1) :-
	satisfy(Obj,Conj), !,
	remove(Es,Conj,Es1).
remove([E|Es],Conj,[E|Es1]) :-
	remove(Es,Conj,Es1).
	
satisfy(Object,Conj) :-
	not((member(Att=Val,Conj),
	     member(Att=ValX,Object),
	     not(ValX == Val))).
	    
match(Object,Description) :-
	member(Conj,Description),
	satisfy(Object,Conj).
	
writelist([]).
writelist([X|L]) :-
	tab(2), write(X), nl, writelist(L).

help :- write('Load data set and start learning with command: [Filename].'), 
	nl.

:- help.
