/******************************************************************/
/* IDT.PRO            Last modification: Wed Feb  9 14:20:27 1994 */
/* Torgos ID3-like system based on the gain-ratio measure         */
/******************************************************************/
%
%    Copyright (c) 1989 Luis Torgo
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
/* impl. by     : Luis Torgo, Laboratorio Inteligencia Artificial */
/*                e Ciencas de Computacao,                        */
/*                Universidade do Porto,                          */
/*                Rua Campo Alegre 823,                           */
/*                4100 Porto,                                     */
/*                Portugal                                        */
/*                1989                                            */
/*                                                                */
/*                Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1990                                            */
/*                                                                */
/*  reference   : Learning Efficient Classification Procedures    */
/*                and Their Application to Chess End Games,       */
/*                Quinlan, J. R., in: Machine Learning,           */
/*                Michalski, R.S., Carbonell, J.G., Mitchell, T.M.*/
/*                (eds.), Tioga Publishing Company, Palo Alto,    */
/*                1983.                                           */
/*                                                                */
/*                Induction of Decision Trees, J. Ross Quinlan    */
/*                Machine Learning 1(1), 81-106, 1986             */
/*                                                                */
/*  call        : idt                                             */
/*                                                                */
/******************************************************************/
% TH: Sat May 29 16:41:25 1993  - made some minor changes
%     Mon Feb  7 22:12:43 1994  - for portability with Sicstus input 
%                                 files are no longer consulted. 
%     Wed Feb  9 13:42:44 1994  - log computations are modified for
%                                 compatibility with Quintus-Prolog
%                               - Zero-division bug in common
%                                 calculations removed 

/******************************************************************/
/* SWI-, YAP-, C- and M-Prolog specific declaration of dynamical  */
/* clauses.                                                       */
/******************************************************************/
:- dynamic node/3.
:- dynamic decision_tree/1.
:- dynamic example/3.
:- dynamic attributes/1.
:- dynamic classes/1.
:- dynamic current_node/1.
:- dynamic table/3.
:- dynamic found/1.

% Comment this out if you use Quintus Prolog
log(X,Y) :- 
	Y is log(X).

/******************************************************************/
/* Quintus-Prolog specific declaration.                           */
/******************************************************************/
% :- ensure_loaded(library(math)).  
% :- ensure_loaded(library(basics)).  

/******************************************************************/
/*                                                                */
/*  call        : idt                                             */
/*                                                                */
/*  side effects: assertz and retracts clauses                    */
/*                                                                */
/******************************************************************/
/* idt reads a filename from the terminal, initializes the know-  */
/* base, consults the correponding file builds a decision tree    */
/* and displays the tree.                                         */
/* The program assertz the following predicates, which must be    */
/* declared as dynamic in some Prolog dialects:                   */
/* node/3, decision_tree/1, example/3, attributes/1, classes/1,   */
/* current_node/1 and table/3.                                    */
/******************************************************************/
idt :-
    repeat,
    	nl,
        write('Which file to use ? '),
        read(FileName),nl,
        initialize_kb,
        readfile(FileName),
        build_decision_tree,
        show_decision_tree,
        nl,
        write('Quit (y/n) ? '),
        read(y).

initialize_kb :-
    abolish(node,3),
    abolish(decision_tree,1),
    abolish(example,3),
    abolish(attributes,1),
    abolish(classes,1),
    abolish(current_node,1), !.

readfile(FileName) :-
	concat(FileName,'.pl',File),
	see(File),
	repeat,
	read(Term),
	( Term = end_of_file ->
	      !, seen
	; assert(Term),
	  fail ).

build_decision_tree :-
    generate_node_id(_),
    clause(attributes(Attributes),true),
    findbag(Ex,clause(example(Ex,_,_),true),Exs),
    idt(Exs,Attributes,Node),
    assert(decision_tree(Node)), !.

generate_node_id(Y) :-
    clause(current_node(X),true), !,
    retract(current_node(X)),
    Y is X + 1,
    assert(current_node(Y)).
generate_node_id(0) :-
    assert(current_node(0)).

/******************************************************************/
/*                                                                */
/*  call        : idt(+Examples,+Attributes,-Class)               */
/*                                                                */
/*  arguments   : Examples   = List of Examples                   */
/*                Attributes = List of Attributes                 */
/*                Class      = Node ID of Class or leaf(Class)    */
/*                                                                */
/******************************************************************/
/* IDT determines an attribute-value pair which best splits the   */
/* examples according to the information-theoretical 'gain-ration'*/
/* measure. The attribute-value pair is deleted from the set of   */
/* all attribute-value pairs and the process of generating a sub- */
/* decision tree is called recursively with the according to the  */
/* attribute-value pair splitted examples. The recursion          */
/* terminates either if there is no more example to process or if */
/* all examples belong to the same class. In the last case        */
/* leaf(Class) is returned insteed of the SubtreeIDs.             */
/* In the end for every generated subtree an ID is generated and  */
/* the tree structure is asserted in the database.                */
/******************************************************************/
idt([],_,[]).
idt(Exs,_,[leaf(Class)]) :-
    termination_criterion(Exs,Class).
idt(Exs,Attributes,ID) :-
    get_best_attribute(Attributes,Exs,BestAttribute),
    split_values(BestAttribute,Exs,DividedValues),
    delete(BestAttribute,Attributes,NewAttributes),
    generate_subtrees(DividedValues,NewAttributes,SubtreeIDs),
    generate_node_id(ID),
    assert(node(ID,BestAttribute,SubtreeIDs)).

termination_criterion([Ex|Exs],Class) :-
    clause(example(Ex,Class,_),true),
    !,
    all_in_same_class(Exs,Class).

all_in_same_class([],_).
all_in_same_class([Ex|Exs],C) :-
    clause(example(Ex,C,_),true),
    !,
    all_in_same_class(Exs,C).

get_best_attribute(Attributes,Exs,BestAttribute) :-
    construct_contingency_table(Attributes,Exs),
    common_calculations(MC,N),
    calculate_parameter_classification(Attributes,MC,N,Values),
    get_best(Attributes,Values,BestAttribute).

construct_contingency_table(Attributes,Exs) :-
    clause(classes(Lc),true),
    length(Lc,NroColTab),
    abolish(table,3),
    create_list_of_zeros(NroColTab,List),
    initialize_contingency_tables(Attributes,List),
    construct_contingency_tables(Attributes,Exs).

initialize_contingency_tables([],_).
initialize_contingency_tables([A|As],List) :-
    assert(table(A,[],List)),
    initialize_contingency_tables(As,List).

create_list_of_zeros(0,[]).
create_list_of_zeros(N,[0|R]) :- 
     N > 0,
     N1 is N - 1,
     create_list_of_zeros(N1,R).

construct_contingency_tables([],_).
construct_contingency_tables([Attribute|Attributes],ExampleList) :-
    contingency_table(Attribute,ExampleList),
    !,
    construct_contingency_tables(Attributes,ExampleList).

contingency_table(_,[]).
contingency_table(Attribute,[Ex|Exs]) :-
     value(Attribute,Ex,V),
     position_of_class(Ex,Pc),
     update_table(Attribute,V,Pc),
     !,
     contingency_table(Attribute,Exs).

value(A,[A = V|_],V) :- !.
value(A,[_|Sels],V) :- 
      value(A,Sels,V).
value(A,No,V) :-
      clause(example(No,_,Ex),true),
      value(A,Ex,V).

position_of_class(Ex,Pc) :-
     clause(example(Ex,C,_),true),
     clause(classes(Classes),true),
     position(C,Classes,Pc).

position(X,L,P) :- 
	position(X,1,L,P).

position(X,P,[X|_],P).
position(X,N,[_|R],P) :- 
	N1 is N + 1,
	position(X,N1,R,P).

update_table(Attribute,V,Pc) :-
     retract(table(Attribute,TabLines,TotClass)),
     modify_table(TabLines,V,Pc,NewLines),
     increment_position_list(1,Pc,TotClass,NewTotal),
     assert(table(Attribute,NewLines,NewTotal)).

modify_table([],V,Pc,[(V,Values,1)]) :-
     clause(classes(Classes),true),
     length(Classes,NoOfColums),
     create_list_of_zeros(NoOfColums,L),
     increment_position_list(1,Pc,L,Values).
modify_table([(V,Nums,Tot)|Rest],V,Pc,[(V,NewNums,NewTot)|Rest]) :-
     NewTot is Tot + 1,
     increment_position_list(1,Pc,Nums,NewNums).
modify_table([X|Rest1],V,Pc,[X|Rest2]) :-
     modify_table(Rest1,V,Pc,Rest2).

increment_position_list(N,N,[X|R],[Y|R]) :-
     Y is X + 1.
increment_position_list(N1,N,[X|R1],[X|R2]) :-
     N2 is N1 + 1,
     increment_position_list(N2,N,R1,R2).

common_calculations(MC,N) :-
    clause(table(_,_,Xjs),true),
    common_calculations(Xjs,0,0,MC,N).

common_calculations([],TotalSum,N,MC,N) :-
    log(N,NLog),
    MC is (-1 / N) * ( TotalSum - N * NLog ).
common_calculations([0],S,N,S,N) :- !.
common_calculations([Xj|Xjs],Ac1,Ac2,MC,N) :-
    log(Xj,XjLog),
    NAc1 is Ac1 + Xj * XjLog,
    NAc2 is Ac2 + Xj,
    common_calculations(Xjs,NAc1,NAc2,MC,N).

calculate_parameter_classification([],_,_,[]).
calculate_parameter_classification([A|As],MC,N,[V|Vs]) :-
    gain_ratio(A,MC,N,V),
    calculate_parameter_classification(As,MC,N,Vs).

gain_ratio(A,MC,N,GR) :-
    clause(table(A,Lines,_),true),
    calculate_factors_B_and_IV(Lines,N,0,0,B,IV),
    IM is MC - B,
    ( IV > 0 -> 
	  GR is IM / IV 
    ; GR = 1 ).

calculate_factors_B_and_IV([],N,Sum1,Sum2,B,IV) :-
    log(N,NLog),
    B  is ( -1 / N ) * ( Sum1 - Sum2 ),
    IV is ( -1 / N ) * ( Sum2 - N * NLog ).
calculate_factors_B_and_IV([(_,L,TotL)|Rest],N,Ac1,Ac2,B,IV) :-
    sum_of_lines(L,0,SL),
    log(TotL,TotLog),
    NAc1 is Ac1 + SL,
    NAc2 is Ac2 + TotL * TotLog,
    calculate_factors_B_and_IV(Rest,N,NAc1,NAc2,B,IV).

sum_of_lines([],X,X).
sum_of_lines([0|Ns],Ac,Tot) :- 
    sum_of_lines(Ns,Ac,Tot).
sum_of_lines([N|Ns],Ac,Tot) :-
    log(N,NLog),
    Nac is Ac + N * NLog,
    sum_of_lines(Ns,Nac,Tot).

get_best([A|As],[V|Vs],Result) :-
    best_value(As,Vs,(A,V),Result).

best_value([],[],(A,_),A).
best_value([A|As],[V|Vs],(_,TV),Result) :-
    V > TV,
    best_value(As,Vs,(A,V),Result).
best_value([_|As],[_|Vs],(TA,TV),Result) :-
    best_value(As,Vs,(TA,TV),Result).

split_values(Attribute,Exs,Result) :-
    get_values(Attribute,Exs,Values),
    split_examples(Attribute,Values,Exs,Result).

get_values(Attribute,Exs,Vals) :-
    findbag(V,(member(Ex,Exs),value(Attribute,Ex,V)),Vs),
    remove_duplicates(Vs,Vals).

split_examples(_,[V],Exs,[(V,Exs)]).
split_examples(A,[V|Vs],Exs,[(V,VExs)|Rest]) :-
    findbag(Ex,(member(Ex,Exs),value(A,Ex,V)),VExs),
    difference(VExs,Exs,RestEx),
    split_examples(A,Vs,RestEx,Rest).

generate_subtrees([],_,[]).
generate_subtrees([(Value,Exs)|Rest1],Attributes,[(Value,Id)|Rest2]) :-
    idt(Exs,Attributes,Id),
    !,
    generate_subtrees(Rest1,Attributes,Rest2).

/******************************************************************/
/*                                                                */
/*  call        : show_decision_tree                              */
/*                                                                */
/******************************************************************/
/* A simple pretty-print procedure for displaying decision trees. */
/* In steed of this procedure, we can also generate rules from the*/
/* decision tree by traversing every path in the tree until a     */
/* leaf node was reached and collecting the attribute-value pairs */
/* of that path. Then the leaf node forms the head of a Horn-     */
/* formula and the set of attribute-value pairs of the path forms */
/* the body of the clause.                                        */
/******************************************************************/
show_decision_tree :-
	nl,
	clause(decision_tree(Node),true),
	show_subtree(Node,0), !.

show_subtree(NodeNo,Indent) :-
	clause(node(NodeNo,Attribute,SubtreeList),true),
	show_subtrees(SubtreeList,Attribute,Indent).
	
show_subtrees([],_,_) :- nl.
show_subtrees([(Value,[leaf(X)])|Brothers],Attribute,Indent) :- 
	write(Attribute=Value), write(' '),
	write(' ==> '), write(class = X), nl,
	space(Indent),
	show_subtrees(Brothers,Attribute,Indent).	
show_subtrees([(Value,NodeNo)|Brothers],Attribute,Indent) :-
	name(Attribute,List1), length(List1,N1),
	name(Value,List2), length(List2,N2),
	write(Attribute=Value),
	write(' and '), 
	Offset is Indent + N1 + 3 + N2 + 5,
	show_subtree(NodeNo,Offset),
	space(Indent),
	show_subtrees(Brothers,Attribute,Indent).

/******************************************************************/
/* Utility predicates                                             */
/******************************************************************/
space(0).
space(N) :-
    	N > 0, write(' '), N1 is N - 1, space(N1).

remove_duplicates([],[]).
remove_duplicates([X|Xs],Ys) :-  
      member(X,Xs),
      remove_duplicates(Xs,Ys).
remove_duplicates([X|Xs],[X|Ys]) :- 
      remove_duplicates(Xs,Ys).

%length([],0).
%length([L|Ls],N) :- 
%      length(Ls,N1),
%      N is N1 + 1.

delete(X,[X|Xs],Xs).
delete(X,[Y|Ys],[Y|Zs]) :- 
    delete(X,Ys,Zs).

difference(L1,L2,L3) :-
    findbag(N,(member(N,L2),\+(member(N,L1))),L3).

findbag(X,G,_) :-                                              
     asserta(found(mark)), call(G),                         
       asserta(found(X)), fail .                            
findbag(_,_,L) :-                                              
     collect_found([],L) .                                     
                                                              
collect_found(L,L1) :-                                       
     getnext(X), collect_found([X|L],L1) .                      
collect_found(L,L) .                                        
                                                              
getnext(X) :-                                               
     retract(found(X)), !, \+(X == mark) .                

help :- write('Start IDT with command: idt.'), nl.

:- help.


