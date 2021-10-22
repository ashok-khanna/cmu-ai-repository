/******************************************************************/
/* INVERS.PL        Last Modification: Fri Jan 14 19:24:41 1994 */
/* Two versions of the two main operators for inverse resolution. */
/******************************************************************/
%
%    Copyright (c) 1989,1990 Thomas Hoppe
%
%    This program is free software; you can redistribute it and/or 
%    modify it under the terms of the GNU General Public License 
%    Version 1 as published by the Free Software Foundation.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public 
%    License along with this program; if not, write to the Free 
%    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, 
%    USA.
%
/******************************************************************/
/* impl. by     : Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1989/90                                         */
/*                                                                */
/*  reference   : Muggleton, S., Buntine, W., Machine Invention   */
/*                of First-order Predicates by Inverting Resolu-  */
/*                tion, Proceedings of the International Workshop */
/*                on Machine Learning, Ann Arbor, Morgan Kaufmann */
/*                1988.                                           */
/*                                                                */
/*                Rouveirol, C., Puget, J.-F., A Simple Solution  */
/*                For Inverting Resolution, in: K. Morik, Procee- */
/*                dings of the 4th European Working Session on    */
/*                Machine Learning, Montpellier, Pitman Publishing*/
/*                1989.                                           */
/*                                                                */
/*  call        : see invers_1.pro                                */
/*                                                                */
/*                of First-order Predicates by Inverting Resolu-  */
/*                tion, Proceedings of the International Workshop */
/*                on Machine Learning, Ann Arbor, Morgan Kaufmann */
/*                1988.                                           */
/*                                                                */
/*                Rouveirol, C., Puget, J.-F., A Simple Solution  */
/*                For Inverting Resolution, in: K. Morik, Procee- */
/*                dings of the 4th European Working Session on    */
/*                Machine Learning, Montpellier, Pitman Publishing*/
/*                1989.                                           */
/*                                                                */
/*  call        : see invers_1.pro                                */
/*                                                                */
/******************************************************************/
/*  This file contains two versions for the main operators of     */
/*  inverse resolution, absorption and intra-construction, as     */
/*  they are described by Stephen Muggleton and Wray Buntine.     */
/*                                                                */
/*  The versions numbered 1 are working on definite Horn-clauses  */
/*  without function symbols. The versions numbered 2 are working */
/*  on definite Horn-clauses with function symbols. The basic     */
/*  difference is made up by the predicates 'flatten' and         */
/*  'unflatten', and is described in Rouveirol & Puget.           */
/*                                                                */
/*  The main predicates 'absorption1', 'absorption2', 'intra-     */
/*  construction1' and 'intra-construction2' use some predicates  */
/*  importet from the library entry 'logic', which should be      */
/*  consulted befor runing the examples.                          */ 
/*                                                                */
/*  Instead of using a generalisation algorithm based on the      */
/*  'dropping condition rule' as described by Rouveirol & Puget   */
/*  I have developed a 'fast' generalisation routine, which in the*/
/*  end gives the same results as 'dropping condition'. Its nice  */
/*  advantage is that it delivers the first generalisation in     */
/*  linear time, although this is an exponential problem. Of      */
/*  course in general, exponentiallity cannot be avoided.         */
/*  But through delaying it, we can save some time in easy cases. */ 
/******************************************************************/
% TH Tue Feb 23 12:38:06 1993 
%	- added missing definition of element_v
%	- introduced dynamic/2 (below) for making system dependency 
%	  more obvious
% TH Fri Mar  5 11:40:21 1993
%       - removed some findall/3 calls, since it's not built-in in 
%         C-Prolog, introduced instead findbag, which is bagof with
%         reversed list order 
%       - numbervars is not built-in in C-Prolog, thus I included
%         instvars, although the output is now ugly, it works
% TH Sun May 30 14:20:37 1993
%       - made some minor modifications

/******************************************************************/
/* Some SWI-, C-, M- and YAP-Prolog dependent declarations.       */
/******************************************************************/
:- dynamic flat/1.
:- dynamic internal/1.

% Dependent on your Prolog dialect (whether it requires dynamic 
% declarations or not, you may need to substitute the Body of the 
% following clause with `true'.

dynamic(N,A) :- 
%	true.
	dynamic N/A.

% C-Prolog doesn't know numbervars (quite strange, isn't it?)
% Thus it needs to be emulated (see comment at the end) ! 

%numbervars(T,Min,Max) :-
%	instvars(T,Min,Max).

% SWI-Prolog nows only of numbervars/4, but that's no problem with 
% the following clause

numbervars(T,Min,Max) :-
	numbervars(T,'$VAR',Min,Max).

:- [logic].

/******************************************************************/
/*                                                                */
/*  call        : absorption1(+Clause,+Resolvent,-InducedClause)  */
/*                                                                */
/*  arguments   : Clause        = definite clause                 */
/*                Resolvent     = definite clause                 */
/*                InducedClause = induced definite clause         */
/*                                                                */
/******************************************************************/
/* works on definite clauses without function-symbols             */
/******************************************************************/
absorption1(Clause,Resolvent,InducedClause) :-
    split(Clause,ClauseHead,ClauseBody),
    split(Resolvent,ResolventHead,ResolventBody),
    step_1(ClauseBody,ResolventBody,RestClauseBody,Subst_2),
    subst([ClauseHead],Subst_2,[NewClauseHead]),
    step_2(NewClauseHead,RestClauseBody,IntermediaryBody),
    join(ResolventHead,IntermediaryBody,IntermediaryClause),
    copy(IntermediaryClause,InducedClause).
        
split((Head :- true),Head,[]) :- !.
split((Head :- Body),Head,BodyList) :-
    split(Body,_,BodyList), !.
split((Prem,Prems),_,[Prem|RestPrems]) :-
    split(Prems,_,RestPrems), !.
split(Prem,_,[Prem]).

join(Head,PremList,(Head :- Prems)):-
    join(PremList,Prems).

join([Prem],Prem) :- !.
join([Prem|Prems],(Prem,RestPrems)) :-
    join(Prems,RestPrems).

step_1(ClauseBody,ResolventBody,ResolventRest,Subst) :-
    choose_common_parts(ResolventBody,ClauseBody,Beta1,Beta2),
    not(not(subset(Beta1,ClauseBody))),
    substitution(ClauseBody,Beta1,Subst), 
    subtract_v(Beta1,ResolventBody,ResolventRest).

/********************************************************************/
/* Determination of the most special subsets of two non-ground      */
/* predicate sets, on backtracking it delivers the next more general*/
/* subsets. The nice property, of this routine is, that the first   */
/* common_subpart is found in linear time, although the determina-  */
/* tion of all common_subparts needs exponential time.              */
/********************************************************************/
choose_common_parts(List1,List2,Sublist1,Sublist2) :-
    findbag(MGT,(member(Pred,List1),
                        functor(Pred,N,A),
		        functor(MGT,N,A)),MGTS1),
    findbag(MGT,(member(Pred,List2),
                        functor(Pred,N,A),
		        functor(MGT,N,A)),MGTS2),
    !,
    dropping_condition_intersection(MGTS1,MGTS2,MGTS),
    copy(MGTS,Sublist1),
    copy(MGTS,Sublist2), 
    subset(Sublist1,List1),
    subset(Sublist2,List2).

dropping_condition_intersection([],_,[]).
dropping_condition_intersection([X|R],Y,[X|Z]) :-
     member(X1,Y), not(not(X = X1)), !,
     dropping_condition_delete(X,Y,Y1),
     dropping_condition_intersection(R,Y1,Z).
dropping_condition_intersection([X|R],Y,Z) :-
     dropping_condition_intersection(R,Y,Z).
     
dropping_condition_delete(X,[Y|Ys],Ys) :- 
     not(not(X = Y)), !.
dropping_condition_delete(X,[Y|Ys],[Y|Zs]) :- 
     dropping_condition_delete(X,Ys,Zs) . 

step_2(ClauseHead,RestClauseBody,IntermediaryBody) :-
% Union_v helps us to avoid some redundant premisses 
    union_v([ClauseHead],RestClauseBody,IntermediaryBody).
    
/******************************************************************/
/*                                                                */
/*  call        : absorption2(+Clause,+Resolvent,-InducedClause)  */
/*                                                                */
/*  arguments   : Clause        = definite clause                 */
/*                Resolvent     = definite clause                 */
/*                InducedClause = induced definite clause         */
/*                                                                */
/******************************************************************/
/* works on definite clauses with function-symbols                */
/******************************************************************/
absorption2(Clause,Resolvent,InducedClause) :-
    flatten(Clause,ClauseHead,ClauseBody),
    flatten(Resolvent,ResolventHead,ResolventBody),
    step_1(ClauseBody,ResolventBody,RestClauseBody,Subst_2),
    subst([ClauseHead],Subst_2,[NewClauseHead]),
    step_2(NewClauseHead,RestClauseBody,IntermediaryBody),
    unflatten([ResolventHead],IntermediaryBody,IntermediaryClause),
    copy(IntermediaryClause,InducedClause).

/********************************************************************/
/* Representation change procedures for inverse resolution.         */
/* The basic idea behind these procedures is to re-represent n-ary  */
/* function symbols by n+1-ary predicate symbols, where the         */
/* additional argument delivers the value of the function. A        */
/* discussion of this can be found in Rouveirol & Puget's paper.    */
/********************************************************************/
flatten((Conclusion :- Conjunction),NewConclusion,NewPremisses) :-
    flatten(Conclusion,[NewConclusion],FunctionPrems1,Dictionary),
    flatten(Conjunction,Prems,FunctionPrems2,Dictionary),
    union_v(FunctionPrems1,FunctionPrems2,FunctionPrems), 
    union_v(FunctionPrems,Prems,NewPremisses), !.

flatten((Prem,Prems),NewPremisses,FunctionPrems,Dictionary) :-
    flatten(Prem,NewPrem,FunctionPrems1,Dictionary),
    flatten(Prems,NewPrems,FunctionPrems2,Dictionary),
    union_v(NewPrem,NewPrems,NewPremisses),
    union_v(FunctionPrems1,FunctionPrems2,FunctionPrems), !.

flatten([],[],[],_).
flatten([Const|Terms],[Var|NewVars],ResultPrems,Dictionary) :-
    atomic(Const),
    lookup(Const,Dictionary,Var),
    conc(Const,'_p',NewName),
    flat_assertion(NewName,Const),
    Pred =..[NewName,Var],
    flatten(Terms,NewVars,NewPrems,Dictionary), !,
    union_v([Pred],NewPrems,ResultPrems).
flatten([Term|Terms],[Term|NewVars],NewPrems,Dictionary) :-
    var(Term), !,
    flatten(Terms,NewVars,NewPrems,Dictionary).
flatten([Term|Terms],[NewVar|NewVars],NewPrems,Dictionary) :-
    Term =.. [N|Args],
    conc(N,'_p',NN),
    flatten(Args,NewTerms,Prems,Dictionary),
    append(NewTerms,[NewVar],NewArgs),
    NewTerm =.. [NN|NewArgs],
    flat_assertion(NN,NewTerms,N,NewTerms),
    flatten(Terms,NewVars,NP,Dictionary), !,
    union_v([NewTerm],NP,ERG),
    union_v(Prems,ERG,NewPrems).

flatten(true,[],[],_) :- !.
flatten(false,[],[],_) :- !.
flatten(not(Pred),[not(NewPred)],NewPrems,Dictionary) :-
    !, flatten(Pred,[NewPred],NewPrems,Dictionary).
flatten(Pred,[Pred],[],Dictionary) :-
    atomic(Pred), !.
flatten(Pred,[NewPred],NewPrems,Dictionary) :-
    !,
    Pred =.. [N|Args],
    flatten(Args,NewArgs,NewPrems,Dictionary),
    NewPred =.. [N|NewArgs].

flat_assertion(Name,Term) :-
    NewRelation =.. [Name,Term],
    copy(NewRelation,NR),
    skolemize([NR],0,_),
    clause(flat(NR),true),
    clause(flat(NewRelation),true), !.
flat_assertion(Name,Term) :-
    NewRelation =.. [Name,Term],
    asserta(flat(NewRelation)), !.

flat_assertion(Name1,Args,Name2,Terms):-
    OldTerm =.. [Name2|Terms],
    append(Args,[OldTerm],NewArgs),
    NewRelation =.. [Name1|NewArgs],
    copy(NewRelation,NR),
    skolemize([NR],0,_),
    clause(flat(NR),true),
    clause(flat(NewRelation),true), !.
flat_assertion(Name1,Args,Name2,Terms):-
    OldTerm =.. [Name2|Terms],
    append(Args,[OldTerm],NewArgs),
    NewRelation =.. [Name1|NewArgs],
    asserta(flat(NewRelation)).

unflatten([Head],BodyList,(Head :- Body)) :-
    unflatten(BodyList,Body), !.
    
unflatten([],true).
unflatten([Prem],Prem) :-
    functor(Prem,N,A),
    functor(P,N,A),
    not(clause(flat(P),true)), !,
    not(clause(flat(Prem),true)), !.
unflatten([Prem|Prems],(Prem,RestPrems)) :-
    functor(Prem,N,A),
    functor(P,N,A),
    not(clause(flat(P),true)), !,
    not(clause(flat(Prem),true)), 
    unflatten(Prems,RestPrems), !.
unflatten([Prem|Prems],RestPrems) :-
    clause(flat(Prem),true),
    unflatten(Prems,RestPrems).    
	    
/******************************************************************/
/*                                                                */
/*  call        : intra_construction1(+Resolvent1,+Resolvent2,    */
/*                                    -InducedRules)              */
/*                                                                */
/*  arguments   : Resolvent1   = definite clause                  */
/*                Resolvent2   = definite clause                  */
/*                InducedRules = list of three induced definite   */
/*                               clauses                          */
/*                                                                */
/******************************************************************/
/* works on definite clauses without function-symbols             */
/******************************************************************/
intra_construction1(Resolvent1,Resolvent2,InducedRules) :-
    split(Resolvent1,Resolvent1Head,Resolvent1Body),
    split(Resolvent2,Resolvent2Head,Resolvent2Body), 
    step_1(Resolvent1Head,Resolvent1Body,Resolvent2Head,Resolvent2Body,
           ClauseHead,Alpha,Resolvent1BodyRest,Resolvent2BodyRest,
	   Subst1,Subst2),
    step_2(ClauseHead,Alpha,Resolvent1BodyRest,Subst1,
                            Resolvent2BodyRest,Subst2,Vars),
    step_3_1(ClauseHead,Vars,Alpha,Resolvent1BodyRest,Subst1,
                                   Resolvent2BodyRest,Subst2,
				   InducedRules).

step_1(Resolvent1Head,Resolvent1Body,Resolvent2Head,Resolvent2Body,
       [ClauseHead],Alpha,Resolvent1BodyRest,Resolvent2BodyRest,
       Subst1,Subst2)  :-
    choose_common_parts(Resolvent1Body,Resolvent2Body,AlphaTheta1,AlphaTheta2),
% if AlphaTheta is empty we gain nothing, thus
    length(AlphaTheta1,X), 
    length(AlphaTheta2,X), 
    X > 0,
    subtract_v(AlphaTheta1,Resolvent1Body,Resolvent1BodyRest),
    subtract_v(AlphaTheta2,Resolvent2Body,Resolvent2BodyRest),
% lgg doesn't take the order of literals into account, initially it was
% only designed for terms, that doesn't matter because choose_common_subpart 
% ensures a common predicate order through copying the MGT and instantiating 
% afterwards.
    lgg([Resolvent1Head,AlphaTheta1],
        [Resolvent2Head,AlphaTheta2],[ClauseHead,Alpha]),
% At least we determine the substitutions theta 1 and theta 2
    substitution([ClauseHead,Alpha],[Resolvent1Head,AlphaTheta1],Subst1),
    substitution([ClauseHead,Alpha],[Resolvent2Head,AlphaTheta2],Subst2).

step_2(ClauseHead,Alpha,Resolvent1BodyRest,Subst1,
                        Resolvent2BodyRest,Subst2,Vars) :-
    varlist(Resolvent1BodyRest,RBR1Vars),
    varlist(Resolvent2BodyRest,RBR2Vars),
    varlist(ClauseHead,CHVars),
    varlist(Alpha,AVars),
    inv_subst(RBR1,Subst1,RBR1Vars),
    inv_subst(RBR2,Subst2,RBR2Vars),
% The head and the generalized body part must have (at least) 
% a variable in common
    (CHVars = [];
     intersection_v(CHVars,AVars,XI), not(XI == [])),
% This is different as in the paper of Rouveirol/Puget. If we would
% use their method, we couldn't even obtain their results, but
% with this it works. This error was confirmed by Celine Rouveirol
    union_v(CHVars,AVars,Xs),
    union_v(RBR1,RBR2,RBRU),
    intersection_v(RBRU,Xs,Vars), 
    !.

step_3_1([ClauseHead],Vars,Alpha,Resolvent1BodyRest,Subst1,
                               Resolvent2BodyRest,Subst2,
	                       [R1,R2,R3]) :-
    gensym(Name,'P'),
    X =.. [Name|Vars],
    subst([X],Subst1,[X1]),
    subst([X],Subst2,[X2]),
    join(X1,Resolvent1BodyRest,QR1),
    join(X2,Resolvent2BodyRest,QR2),
    copy(QR1,NQR1),
    copy(QR2,NQR2),
    numbervars(NQR1,0,_),
    numbervars(NQR2,0,_),
    nl,
    write(' Predicate invention'), nl, nl,
    tab(3), write(NQR1), nl,
    tab(3), write(NQR2), nl, nl,
    write(' Has this predicate a meaning (y/n)? '),
    read(Answer), nl,
    (Answer = n, !, fail; Answer = y, !),
    write(' How shall I name the predicate ? '),
    read(NewName), nl,
    NP =..[NewName|Vars],
    subst([NP],Subst1,[NP1]),
    subst([NP],Subst2,[NP2]),
    join(NP1,Resolvent1BodyRest,R1),
    join(NP2,Resolvent2BodyRest,R2),
    append([NP],Alpha,ClauseBody),
    join(ClauseHead,ClauseBody,R3),
    !.
    
/******************************************************************/
/*                                                                */
/*  call        : intra_construction2(+Resolvent1,+Resolvent2,    */
/*                                    -InducedRules)              */
/*                                                                */
/*  arguments   : Resolvent1   = definite clause                  */
/*                Resolvent2   = definite clause                  */
/*                InducedRules = list of three induced definite   */
/*                               clauses                          */
/*                                                                */
/******************************************************************/
/* works on definite clauses with function-symbols                */
/******************************************************************/
intra_construction2(Resolvent1,Resolvent2,InducedClauses) :-
    flatten(Resolvent1,Resolvent1Head,Resolvent1Body),
    flatten(Resolvent2,Resolvent2Head,Resolvent2Body),
    step_1(Resolvent1Head,Resolvent1Body,Resolvent2Head,Resolvent2Body,
           ClauseHead,Alpha,Resolvent1BodyRest,Resolvent2BodyRest,
	   Subst1,Subst2),
    step_2(ClauseHead,Alpha,Resolvent1BodyRest,Subst1,
                            Resolvent2BodyRest,Subst2,Vars),
    step_3_2(ClauseHead,Vars,Alpha,Resolvent1BodyRest,Subst1,
                                   Resolvent2BodyRest,Subst2,
				   InducedClauses).
    
step_3_2(ClauseHead,Vars,Alpha,Resolvent1BodyRest,Subst1,
                               Resolvent2BodyRest,Subst2,
	                       [R1,R2,R3]) :-
    gensym(Name,'P'),
    X =.. [Name|Vars],
    subst([X],Subst1,X1),
    subst([X],Subst2,X2),
    unflatten(X1,Resolvent1BodyRest,QR1),
    unflatten(X2,Resolvent2BodyRest,QR2),
    copy(QR1,NQR1),
    copy(QR2,NQR2),
    numbervars(NQR1,0,_),
    numbervars(NQR2,0,_),
    nl,
    write(' Predicate invention'), nl, nl,
    tab(3), write(NQR1), nl,
    tab(3), write(NQR2), nl, nl,
    write(' Has this predicate a meaning (y/n)? '),
    read(Answer), nl,
    (Answer = n, !, fail; Answer = y, !),
    write(' How shall I name the predicate ? '),
    read(NewName), nl,
    NP =..[NewName|Vars],
    subst([NP],Subst1,NP1),
    subst([NP],Subst2,NP2),
    unflatten(NP1,Resolvent1BodyRest,R1),
    unflatten(NP2,Resolvent2BodyRest,R2),
    append([NP],Alpha,ClauseBody),
    unflatten(ClauseHead,ClauseBody,R3),
    !.
    
/********************************************************************/
/* Some predicates for substituting and for inverse substituting    */
/* terms according to a given Subst.                                */
/********************************************************************/
subst([],_,[]).
subst([X|Xs],Subst,[Y|Ys]) :-
    member(U/V,Subst), X==U, Y=V,
    subst(Xs,Subst,Ys), !.
subst([Prem|Prems],Subst,[NewPrem|NewPrems]) :-
    Prem =..[F|Args],
    subst(Args,Subst,NewArgs),
    NewPrem =.. [F|NewArgs],
    subst(Prems,Subst,NewPrems), !.
subst([X|Xs],Subst,[X|Ys]) :-
    subst(Xs,Subst,Ys).

inv_subst([],_,[]).
inv_subst([X|Xs],Subst,[Y|Ys]) :-
    member(U/V,Subst), Y==V, X=U,
    inv_subst(Xs,Subst,Ys), !.
inv_subst([Prem|Prems],Subst,[NewPrem|NewPrems]) :-
    NewPrem =.. [F|NewArgs],
    inv_subst(Args,Subst,NewArgs),
    Prem =..[F|Args],
    inv_subst(Prems,Subst,NewPrems), !.
inv_subst([X|Xs],Subst,[X|Ys]) :-
    inv_subst(Xs,Subst,Ys).

/******************************************************************/
/* Some set theoretical predicates, variables are not unified     */
/******************************************************************/
union_v([],X,X).
union_v([X|R],Y,Z) :-
      member(U,Y), U==X, !, union_v(R,Y,Z).
union_v([X|R],Y,[X|Z]) :-
      union_v(R,Y,Z).

intersection_v([],_,[]).
intersection_v([X|R],Y,[X|Z]) :-
     member(U,Y), U==X, !, intersection_v(R,Y,Z).
intersection_v([X|R],Y,Z) :-
     intersection_v(R,Y,Z).

subset([],[]).
subset([X|Subset],[X|List]) :-
    subset(Subset,List).
subset(Subset,[_|List]) :-
    subset(Subset,List).
    
subtract_v([X|Xs],Ys,Zs) :- member(Y,Ys), X == Y, delete_v(X,Ys,Y1s),
     subtract_v(Xs,Y1s,Zs), !.
subtract_v([X|Xs],Ys,Zs) :- 
     subtract_v(Xs,Ys,Zs).
subtract_v([],Xs,Xs).

delete_v(X,[Y|Ys],Ys) :- X == Y, !.
delete_v(X,[Y|Ys],[Y|Zs]) :- delete_v(X,Ys,Zs) . 
    
/******************************************************************/
/* Creation of unique identifiers                                 */
/******************************************************************/
count(VAR,X) :-
     dynamic(VAR,1),
     P1 =.. [VAR,N], 
     retract(P1), 
     X is N+1, 
     P2 =.. [VAR,X], 
     assert(P2), ! .
count(VAR,1) :- 
     dynamic(VAR,1),
     P =.. [VAR,1], 
     assert(P).

gensym(SYM,N) :-
     count(N,X), conc(N,X,SYM).

/******************************************************************/
/* Making a copy of the variables occuring in a Prolog term       */
/******************************************************************/
copy(A,B) :- 
     (assert(internal(A)), retract(internal(B)), !;
      retract(internal(_)), fail) .

/******************************************************************/
/* Construction and retrieval of an dictionary                    */
/******************************************************************/
lookup(Key,d(Key,X,Left,Right),Value) :-
     !, X = Value.
lookup(Key,d(Key1,X,Left,Right),Value) :-
     Key @< Key1, lookup(Key,Left,Value).
lookup(Key,d(Key1,X,Left,Right),Value) :-
     Key @> Key1, lookup(Key,Right,Value).

/******************************************************************/
/* Concatenation of atoms                                         */
/******************************************************************/
conc(STR1,STR2,STR3) :- 
     nonvar(STR1), nonvar(STR2), name(STR1,S1), name(STR2,S2),
     append(S1,S2,S3), name(STR3,S3).
conc(STR1,STR2,STR3) :- 
     nonvar(STR1), nonvar(STR3), name(STR1,S1), name(STR3,S3),
     append(S1,S2,S3), name(STR2,S2).
conc(STR1,STR2,STR3) :- 
     nonvar(STR2), nonvar(STR3), name(STR2,S2), name(STR3,S3),
     append(S1,S2,S3), name(STR1,S1).

/******************************************************************/
/* Determination of the set of vars occuring in a Prolog expression*/
/******************************************************************/
varlist(X,L) :-
   varlist(X,[],L), !.
   
varlist(T,L,LO) :- 
   nonvar(T), 
   T =..[F|A], !, varlist1(A,L,LO).
varlist(X,L,L) :- 
   var(X), element_v(X,L), !.
varlist(X,L,[X|L]) :- 
   var(X), !.

varlist1([T|A],L,LO) :- 
   varlist1(A,L,L1), !, varlist(T,L1,LO).
varlist1([],L,L).

element_v(Element1,[Element2|Tail]) :- 
	Element1 == Element2.
element_v(Element,[_|Tail]) :-
    element_v(Element,Tail).

/******************************************************************/
/* We cannot use bagof/3 since it reverses the output list order !*/
/******************************************************************/

findbag(X,G,_) :-                              
     asserta(yk_found(mark)), call(G),         
       asserta(yk_found(X)), fail .            
findbag(_,_,L) :-                              
     yk_collect_found([],L) .                     
                                               
yk_collect_found(Acc,L) :-                       
     yk_getnext(X), yk_collect_found([X|Acc],L) .      
yk_collect_found(X,X) .                        
                                               
yk_getnext(X) :-                               
     retract(yk_found(X)), !, not (X == mark).

/******************************************************************/
/* instvars instantiates variables by a '_'(<Number>) structure.  */
/* Unfortunately a pretty print will result in uglier terms in    */
/* some Prolog dialects                                           */
/******************************************************************/

% instvars(REXPR,MIN,MAX) :- 
%      REXPR =.. [_|ARGS], yap_instvar(ARGS,MIN,MAX), ! .
%
% yap_instvar([],N,N) .
% yap_instvar([FIRST|REST],N,N_OUT) :- 
%      var(FIRST), !, Y =.. ['_',N], FIRST = Y,
%        N_PLUS_1 is N + 1, yap_instvar(REST,N_PLUS_1,N_OUT) .
% yap_instvar([FIRST|REST],N,N_OUT) :- 
%      skel(FIRST), !, FIRST =.. [_|SKEL_ARGS], 
%        yap_instvar(SKEL_ARGS,N,N_PLUS_M), 
%        yap_instvar(REST,N_PLUS_M,N_OUT) .
% yap_instvar([_|REST],N,N_OUT) :- 
%      yap_instvar(REST,N,N_OUT) .
%
% skel(Z) :- 
%      nonvar(Z),
%      (list(Z), !, length(Z,N), N>0;
%       Z =.. [_|LIST], length(LIST,N), N>0), ! .
%
% list([]).
% list([A|B]) :- list(B) .

help :- write('Load example calls with command: [Filename].'), nl,
	write('Run example with command: test1(X).'), nl,
	write('Run example with command: test2(X).'), nl,
	write('Run example with command: test3(X).'), nl,
	write('Run example with command: test4(X).'), nl,
	write('Run example with command: test5(X).'), nl,
	write('Run example with command: test6(X).'), nl,
	write('Run example with command: test7(X).'), nl,
	write('Run example with command: test8(X).'), nl.

:- help.
