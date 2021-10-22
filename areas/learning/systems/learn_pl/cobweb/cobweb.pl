/******************************************************************/
/* cobweb.pro         Last modification: Fri Jan 14 19:32:01 1994 */
/* Gennari's incremental concept formation algorithm              */
/******************************************************************/
%
%    Copyright (c) 1989 Joerg-Uwe Kietz
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
%    Licensealong with this program; if not, write to the Free 
%    SoftwareFoundation, Inc., 675 Mass Ave, Cambridge, MA 02139, 
%    USA.
%
/******************************************************************/
/*  impl. by    : Joerg-Uwe Kietz                                 */
/*                F3-XPS                                          */
/*                Gesellschaft fuer Mathematik und Datenver-      */
/*                arbeitung                                       */
/*                Schloss Birlinghoven                            */
/*                5201 St. Augustin 1                             */
/*                E-Mail: kietz@gmdzi.gmd.de                      */
/*                1989                                            */
/*                                                                */
/*  reference   : Gennari, J.H., Langley, P., Fisher, D.          */
/*                Models of Incremental Concept Formation         */
/*                Artifical Intelligence, Vol 40, pp. 11-61,      */
/*                1989                                            */
/*                                                                */
/*  correction  : There is a bracket around the subtraction of    */
/*                the two double sums missing in formula (3) on   */
/*                p. 35.                                          */
/*		  In the case of Split-Node is the best, the call */
/*		  cobweb(N,I) leads to double incorporation of I  */
/*                into Node N.                                    */
/*                                                                */
/*  call        : learn                                           */
/*                                                                */
/*  parameter   : acuity/1 asserted in the dynamic DB allows to   */
/*                vary the acuity parameter (default is 0). It    */
/*                should be a real between 0 and 1.               */
/*                                                                */
/*  side effects: assertz and retracts clauses, hence not very    */
/*                efficient. Even less efficient, if Prolog       */
/*                dialect does not support first arg indexing.    */
/*                If a more efficient implementation (avoiding    */
/*                assert/retract) is needed, try to contact Kietz */
/*                directly.                                       */
/*                                                                */
/*  restrictions: Prolog-dialect must allow real arithmetic.      */
/*                                                                */
/******************************************************************/
% TH: Sat May 29 16:19:01 1993    prettyfied output
%                                 corrected bug in cobweb_3.pl 
%     Sat Jan  8 11:33:49 1994    removed incompatible predicate
%     Fri Jan 14 17:31:36 1994    avoidance of rounding errors
%                                 better handling of 'acuity'

/******************************************************************/
/* SWI-, YAP-, C- and M-Prolog specific declaration of dynamical  */
/* clauses.                                                       */
/******************************************************************/
:- dynamic root/2.
:- dynamic root/4.
:- dynamic node/3.
:- dynamic d_sub/2.
:- dynamic gensym_counter/2.
:- dynamic prediction_counter/2.
:- dynamic features/1.
:- dynamic case/1.
:- dynamic acuity/1.

/******************************************************************/
/* QUINTUS Prolog specific import of predicates `sqrt' and `abs'  */
/******************************************************************/
%:- use_module(library(math),[sqrt/2,abs/2]). 

/******************************************************************/
/*                                                                */
/*  call        : learn                                           */
/*                                                                */
/*  side effects: assertz and retracts clauses                    */
/*                                                                */
/*  restrictions: Prolog-dialect must allow real arithmetric.     */
/*                                                                */
/******************************************************************/
/* With the predicate 'learn' the cobweb algorithm is called in   */
/* batch mode. In this mode the data have to be present at call-  */
/* time in the internal database. They have to follow the format  */
/* shown in the example file. Because, cobweb is an incremental   */
/* concept formation system it retrieves first a datum from the   */
/* database (in Prolog's processing order) and integrates it in a */
/* growing concept tree. Before the learning process starts the   */
/* internal concept tree data structure is initialized. The       */
/* concept tree is asserted and modified at runtime.              */
/******************************************************************/

learn :- 
	initialize,
	get_case(X),
        cobweb(X), 
	nl, nl,
	show_classes,
	fail.
learn.
	
initialize :- 
	abolish(node,3),
	abolish(d_sub,2),
	abolish(root,2),
	abolish(root,4),
	abolish(prediction_counter,2), 
	abolish(gensym_counter,2), 
	!.

/******************************************************************/
/*                                                                */
/*  call        : learn_more                                      */
/*                                                                */
/*  side effects: assertz and retracts clauses                    */
/*                                                                */
/******************************************************************/
/* With the predicate 'learn_more' the cobweb algorithm is called */
/* in batch mode. In this mode the data have to be present at     */
/* call-time in the internal database. They have to follow the    */
/* format shown in the example file. Because, cobweb is an        */
/* incremental concept formation system it retrieves first a      */
/* datum from the database (in Prolog's processing order) and     */
/* integrates it in a growing concept tree. The data structure of */
/* the internal concept tree data structure is not initialized,   */
/* thus allowing to process large datasets in smaller parts. The  */
/* concept tree is asserted and modified at runtime. The user has */
/* to take care that the dataset is erased after each batch run,  */
/* to avoid that data are processed twice.                        */
/******************************************************************/

learn_more :- 
	get_case(X),
        cobweb(X), 
	fail.
learn_more.

/******************************************************************/
/* QUINTUS Prolog specific import of predicates `nth1' and        */
/* `nmember'. `nth1' for getting the nth-element of a list and    */
/* `nmember' for getting a member as well as its position.        */
/******************************************************************/

% :- use_module(library(lists),[nth1/3,nmember/3]).

nmember(E,[E|L],1).
nmember(E,[_|R],P1) :-
	nmember(E,R,P),
	P1 is P + 1.
	
nth1(1,[X|_],X).
nth1(P1,[_|R],X) :-
	P1 > 1,
	P is P1 - 1,
	nth1(P,R,X).	

/******************************************************************/
/*                                                                */
/*  call        : get_case(+Case)                                 */
/*                                                                */
/*  arguments   : Case = unique case identificator                */     
/*                                                                */
/******************************************************************/
/* This is a new version of get_case/1 called by COBWEB. This     */
/* version is independent from the data set. Using this version   */
/* one can change the data-set (i.e consult a different data file)*/
/* without changing the access operations (especially the number  */
/* of arguments)                                                  */
/******************************************************************/

get_case(CaseID):-
	case([CaseID|_]),
	nl, nl, write(' Processing case '),
	write(CaseID), write(' ...').

/******************************************************************/
/*                                                                */
/*  call        : get_case_features(+Case,+Type,-AttVall)         */
/*                                                                */
/*  arguments   : Case   = unique case identificator              */     
/*                Type   = type description of value              */     
/*                AttVal = Attribute-Value Pair                   */     
/*                                                                */
/******************************************************************/
/* This is a new version of get_case_features/3 called by COBWEB. */
/* This version is independent from the data set. Using this      */
/* version one can change the data-set (i.e consult a different   */
/* case file) without changing the access operations (especially  */
/* the number of arguments)                                       */
/******************************************************************/

get_case_feature(CaseId,Type,[Feature,Val]):-
        case([CaseId|CaseDescription]), 
        features(FeatureDescription),  
	% backtrack through all feature description and
        nmember([Type,Feature],FeatureDescription,Pos),
	% get corresponding feature value
	nth1(Pos,CaseDescription,Val).
	
/******************************************************************/
/*                                                                */
/*  call        : cobweb(+Case)                                   */
/*                                                                */
/*  arguments   : Case = unique case identificator                */     
/*                                                                */
/*  side effects: assertz and retracts clauses                    */
/*                                                                */
/******************************************************************/
/* cobweb processes a case always completely. The case identifi-  */
/* cator is used as pointer to the case. Every case must have a   */
/* unique case identificator, accessible over the predicate       */
/* get_case(Case). The three cases of asserting a case as initial */
/* root node, as new terminal node in the tree, or integrating    */
/* the case into a node and processing the subtree's are handled. */
/******************************************************************/

cobweb(Case) :-
	% if the tree is empty
	\+(get_node(_)),
	init_node,
	% generate root from Case
        node(Root,root,1,1),
	new_node_from_case(Case,Root),
	assert_node(Root),
	msgs([nl,' Root initialized with case: ',Root]),
	!.
cobweb(Case) :-
	% if root is terminal:
        node(OldRoot,root,1,1),
	remove_node(OldRoot),
	!,
	% first, make a copy of root
        copy_node_to_new_node(OldRoot,New),
	node(New,_,1,1),
	assert_node(New),
	msgs([nl,' Root node: ',OldRoot,' used as new terminal node: ',New]),
	assert_d_sub(OldRoot,New),
	% second, make a node of Case
	new_node_from_case(Case,New2),
	node(New2,_,1,1),
	assert_node(New2),
	msgs([nl,' Case ',Case,' becomes new terminal ',New2]),
	assert_d_sub(OldRoot,New2),
	% third, incorporate Case into root
        incorporate_case_into_node(Case,OldRoot),
	node(NewRoot,root,2,_),
	assert_node(NewRoot),
	msgs([nl,' Root changed to: ',NewRoot]),
	!.
cobweb(Case) :-
	% if root is not terminal: 
	node_name(OldRoot,root),
	remove_node(OldRoot),
	!,
	% first, incorporate Case into root
	incorporate_case_into_node(Case,OldRoot),
	node_objects(OldRoot,Objects),
	NewObjects is Objects + 1,
	node(NewRoot,root,NewObjects,_),
	assert_node(NewRoot),
	msgs([nl,' Root changed to: ',NewRoot]),
	% second, compute new subtree
	cobweb(NewRoot,Case),
	!.

cobweb(none,_).
cobweb(Parent,Case) :-
	best_child(Parent,Case,Best,IBest,Next,DoneRest,RestPred,PartSize,
		   IncPrediction),
	!,
	new_child(Parent,Case,Best,Next,RestPred,PartSize,New,NewPrediction),
	!,
	merge_child(Parent,Case,Best,Next,RestPred,PartSize,Merge,
		    MergePrediction),
	!,
	% Correction of the reference: In the case of Split-Node is the best, 
	% The call cobweb(N,I) leads to double incorporating I into Node N.
	split_child(Parent,Case,Best,IBest,Next,DoneRest,RestPred,PartSize,
		    SplitPrediction),
	!,
 	max_of([IncPrediction,NewPrediction,MergePrediction,SplitPrediction],
	       BestPrediction),
	!,
        (BestPrediction = IncPrediction,
	 	do_incorp(IBest,Best,Merge,New,Case,NewParent);
         BestPrediction = SplitPrediction,
                do_split(Best,IBest,New,Merge,Parent,NewParent);
         BestPrediction = MergePrediction,
                do_merge(Best,Next,Merge,Parent,IBest,New,NewParent);
         BestPrediction = NewPrediction,
                do_new(Parent,New,IBest,Merge,NewParent)),
        !,
        cobweb(NewParent,Case).

do_incorp(IBest,Best,Merge,New,Case,NewParent):-
        msgs([nl,' Incorporating case ',Case,' into node: ',IBest]),
        move_subs(Best,IBest),
        delete_node(Merge),
        delete_node(New),
        if(terminal_node(Best),
	   (% if Best is a terminal node we have the case from the paper,
            % where N is terminal before incorporating the new case.
            % first: make Best to an subnode of IBest
            ins_node(IBest,Best,[]),
            msgs([nl,' using old node: ',Best,' as terminal node.']),
            % second: generate a new terminal node from Case
            new_node_from_case(Case,New2),
            node(New2,_,1,1),
            assert_node(New2),
            msgs([nl,' New terminal node: ',New2]),
            % and make it to an subnode of IBest, too
            ins_node(IBest,New2,[]),
            % than all is done, because Best and NewNode2 are terminal.
            NewParent = none),
           (delete_node(Best),
            NewParent = IBest)).

do_split(Best,IBest,New,Merge,Parent,Parent):-
         msgs([nl,' Case splits node: ',Best]),
         % The next call also copies the d_subs from Best to Parent
         delete_node(Best),
         delete_node(IBest),
         delete_node(New),
         delete_node(Merge).

do_merge(Best,Next,Merge,Parent,IBest,New,Merge):-
         msgs([nl,' Case merges nodes: ',Best,' and ',Next,nl,
               ' into ',Merge]),
         ins_node(Parent,Merge,[Best,Next]),
         % Possible optimization:
         % We could remember that Best is the best_child for
         % incorporate and Next is the second best, RestP = 0, ...,
         % i.e. we already know what best_child will produce in the 
	 % next recursion.
         delete_node(IBest), 
         delete_node(New).

do_new(Parent,New,IBest,Merge,none):-
         % all is done, because New is terminal.
         ins_node(Parent,New,[]),
         msgs([nl,' New terminal node: ',New]),
         delete_node(IBest),
         delete_node(Merge).

best_child(Parent,Case,Best,IBest,Next,DoneRest,RestPred,PartSize,
	   IncPrediction) :-
	findall(Child,get_d_sub(Parent,Child),[C1,C2|DoRest]),
	length([C1,C2|DoRest],PartSize),
	copy_and_inc(C1,Case,IC1),
	copy_and_inc(C2,Case,IC2),
	compare_partitions(C1,IC1,C2,IC2,DoRest,[],Parent,
	        	   First,IFirst,Second,ISecond,FirstRestP),
	!,
	best_childs(Parent,Case,DoRest,[],First,IFirst,Second,ISecond,
		    FirstRestP,Best,IBest,Next,DoneRest,RestPred),
	sum_score([IBest],[Next],Parent,RestPred,IncScore),
        node_prediction(Parent,NormPrediction),
        IncPrediction is (IncScore - NormPrediction) / PartSize.

best_childs(_,_,[],DoneRest,Best,IBest,Next,_INext,RestP,Best,IBest,
	    Next,DoneRest,RestP) :-
	delete_node(_INext),
	!.
best_childs(Parent,Case,[Try|DoRest],DoneRest,First,IFirst,Second,ISecond,
	    FirstRestP,Best,IBest,Next,NewDoneRest,RestP) :-
	copy_and_inc(Try,Case,ITry),
	if(compare_partitions(Second,ISecond,Try,ITry,DoRest,[First|DoneRest],
			      Parent,Second,ISecond,Try,ITry,_),
	   (% Try is weaker than our Second, 
	    % Delete ITry from memory
            % put Try to done, use the old Results
	    delete_node(ITry),
	    best_childs(Parent,Case,DoRest,[Try|DoneRest],
	                First,IFirst,Second,ISecond,FirstRestP,
		        Best,IBest,Next,NewDoneRest,RestP)),
	   (% Try is stronger than our Second, 
            % Delete ISecond from memory, put Second to done
            % compare Try with First, use the new Results
	    delete_node(ISecond),
	    compare_partitions(First,IFirst,Try,ITry,
	                       DoRest,[Second|DoneRest],Parent,NFirst,
		               NIFirst,NSecond,NISecond,NFirstRestP),
	    !,
	    best_childs(Parent,Case,DoRest,[Second|DoneRest],NFirst,NIFirst,
	    		NSecond,NISecond,NFirstRestP,Best,IBest,Next,
			NewDoneRest,RestP))).

new_child(Parent,Case,Best,Next,RestPred,PartSize,New,NewPrediction) :-
	new_node_from_case(Case,New),
	% Prediction from New is equal to 1
	node(New,_,1,1),
	assert_node(New),
	sum_score([New],[Best,Next],Parent,RestPred,NewPredictionSum),
        node_prediction(Parent,NormPrediction),
        NewPrediction is (NewPredictionSum - NormPrediction)
                / (PartSize + 1),
	!.

merge_child(_Parent,_Case,_Best,_Next,_RestPred,2,Merge,-10000) :-
	new_node(Merge),
	assert_node(Merge),
	!.
merge_child(Parent,Case,Best,Next,RestPred,PartSize,Merge,MergePrediction) :-
	% first, copy BestNode Attributes to MergeNode
	copy_node_to_new_node(Best,Merge),
        % second, merge NextNode Attributes into MergeNode 
        merge_node_into_node(Next,Merge),
	% third, incorporate Case into MergeNode 
	incorporate_case_into_node(Case,Merge),
        % compute the rest of MergeNode
        node_objects(Best,BestO),
	node_objects(Next,NextO),
        MergeObjects is BestO + NextO + 1,
	node_objects(Merge,MergeObjects),
	compute_prediction(Merge),
	assert_node(Merge),
        sum_score([Merge],[],Parent,RestPred,MergePredictionSum),
        node_prediction(Parent,NormPrediction),
        MergePrediction is (MergePredictionSum - NormPrediction) / 
	                   (PartSize - 1), % completed W.E.
	!.


split_child(_Parent,_Case,Best,_IBest,_Next,_DoneRest,_RestPred,_PartSize,
	    -10000) :-
	terminal_node(Best),
	% we cannot split Best if it is terminal
	!.
split_child(Parent,Case,Best,_IBest,Next,DoneRest,_RestPred,PartSize,
	    SplitPrediction) :-
        % best_child of the partition resulting from split 
        % (i.e. best of: Parent-Childs union Best-Childs without Best)
	findall(Child,get_d_sub(Best,Child),[C1|DoRest]),
	length([C1|DoRest],CPartSize),
	copy_and_inc(C1,Case,IC1),
	copy_and_inc(Next,Case,INext),
	compare_partitions(C1,IC1,Next,INext,DoRest,DoneRest,Parent,
			   First,IFirst,Second,ISecond,FirstRestP),
	!,
	best_childs(Parent,Case,DoRest,DoneRest,First,IFirst,Second,ISecond,
		    FirstRestP,_CBest,CIBest,CNext,_,RPred),
	sum_score([CIBest],[CNext],Parent,RPred,SplitPredictionSum),
        node_prediction(Parent,NormPrediction),
        SplitPrediction is (SplitPredictionSum - NormPrediction) / 
	                   (PartSize + CPartSize -1 ), 	
	delete_node(CIBest),
	!.
	
/******************************************************************/
/* compare_partitions                                             */
/******************************************************************/

compare_partitions(C1,IC1,C2,IC2,DoRest,DoneRest,Parent,First,IFirst,
		   Second,ISecond,RestP) :-
	sum_score(DoRest,DoneRest,Parent,0,RestP),
	sum_score([C1],[IC2],Parent,RestP,IC2_Score),
	sum_score([IC1],[C2],Parent,RestP,IC1_Score),
	( IC2_Score > IC1_Score ->
	     First = C2,
	     IFirst = IC2,
	     Second = C1,
	     ISecond = IC1
	; First = C1,
	  IFirst = IC1,
	  Second = C2,
	  ISecond = IC2 ),
	!.

/******************************************************************/
/* basic node operations                                          */
/******************************************************************/

copy_and_inc(Node,Case,INode) :-
	new_node(INode),
	!,
	% first, copy all Node Attributes to INode
        copy_node_to_new_node(Node,INode),
        % second, incorporate Case into INode
	incorporate_case_into_node(Case,INode),
	node_objects(Node,Objects),
	IObjects is Objects + 1,
	node_objects(INode,IObjects),
	compute_prediction(INode),
	assert_node(INode),
	!.

/******************************************************************/
/* basic node attribute operations                                */
/******************************************************************/

merge_node_into_node(Node,MergeNode) :-
	(get_node_nominal_attr(Node,Attr,ValuesCounter),
	 if((remove_node_nominal_attr(MergeNode,Attr,MergeValuesCounter),
	     sum_value_counter(ValuesCounter,MergeValuesCounter,
	                       NewValuesCounter),
	     assert_node_nominal_attr(MergeNode,Attr,NewValuesCounter)),
            fail);
	 true),
	(get_node_numeric_attr(Node,Attr,N,SumXiPow2,SumXi),
	 if((remove_node_numeric_attr(MergeNode,Attr,MergeN,
	 			      MergeSumXiPow2,MergeSumXi),
	     NewN is N + MergeN,
	     NewSumXiPow2 is SumXiPow2 + MergeSumXiPow2,
	     NewSumXi is SumXi + MergeSumXi,
	     assert_node_numeric_attr(MergeNode,Attr,NewN,NewSumXiPow2,
	     			      NewSumXi)),
             fail);
	 true),
	!.

new_node_from_case(Case,Node) :-
	new_node(Node),
	(get_case_feature(Case,nominal,[Attr,Val]),
	 if(assert_node_nominal_attr(Node,Attr,[Val-1]),
	    fail);
         true),
	(get_case_feature(Case,numeric,[Attr,Val]),
	 if((SumXiPow2 is Val * Val,
	     assert_node_numeric_attr(Node,Attr,1,SumXiPow2,Val)),
	    fail);
         true),
	!.

copy_node_to_new_node(Node,NewNode) :-
	new_node(NewNode),
	(get_node_nominal_attr(Node,Attr,ValuesCounter),
	 if(assert_node_nominal_attr(NewNode,Attr,ValuesCounter),
	    fail);
	 true),
	(get_node_numeric_attr(Node,Attr,N,SumXiPow2,SumXi),
	 if(assert_node_numeric_attr(NewNode,Attr,N,SumXiPow2,SumXi),
	    fail);
	 true),
	!.

incorporate_case_into_node(Case,Node) :-
	(get_case_feature(Case,nominal,[Attr,Val]),
	 if((remove_node_nominal_attr(Node,Attr,ValuesCounter),
	     sum_value_counter(ValuesCounter,[Val-1],NewValuesCounter),
	     assert_node_nominal_attr(Node,Attr,NewValuesCounter)),
	    fail);
         true),
	(get_case_feature(Case,numeric,[Attr,Val]),
	 if((remove_node_numeric_attr(Node,Attr,N,SumXiPow2,SumXi),
	     NewN is N + 1,
	     NewSumXiPow2 is SumXiPow2 + (Val * Val),
	     NewSumXi is SumXi + Val,
	     assert_node_numeric_attr(Node,Attr,NewN,NewSumXiPow2,NewSumXi)),
	    fail);
         true),
	!.
	
/******************************************************************/
/* sum_value_counter(+ValuesCounter,+ValuesCounter,-ValuesCounter)*/
/******************************************************************/

sum_value_counter(ValuesCounter,[],ValuesCounter) :- !.
sum_value_counter([],ValuesCounter,ValuesCounter).
sum_value_counter([Val-C1|R1],[Val-C2|R2],[Val-SumC|Rest]) :-
	SumC is C1 + C2,
	!,
	sum_value_counter(R1,R2,Rest).
sum_value_counter([Val1-C1|R1],[Val2-C2|R2],[Val1-C1|Rest]) :-
	Val1 @< Val2,
	!,
	sum_value_counter(R1,[Val2-C2|R2],Rest).
sum_value_counter([Val1-C1|R1],[Val2-C2|R2],[Val2-C2|Rest]) :-
	Val2 @< Val1,
	!,
	sum_value_counter([Val1-C1|R1],R2,Rest).

/******************************************************************/
/* sum_score(+NodeList,+NodeList,+NormNode,+BaseScore,-FinalScore)*/
/******************************************************************/

%% This follows Fisher 1987 in the ML Journal but this seems to be
%% wrong
%sum_score([],[],_,Score,Score).
%sum_score([],[Node|Rest],NormNode,Score,Sum_Score):-
%       node(Node,_,Objects,Prediction),
%       node(NormNode,_,NormObjects,NormPrediction),
%       ZScore is ((Objects / NormObjects) * (Prediction - NormPrediction))
%                  + Score,
%       !,
%       sum_score([],Rest,NormNode,ZScore,Sum_Score).
%sum_score([Node|Rest],ToDo,NormNode,Score,Sum_Score):-
%       node(Node,_,Objects,Prediction),
%       node(NormNode,_,NormObjects,NormPrediction),
%       ZScore is ((Objects / NormObjects) * (Prediction - NormPrediction))
%                  + Score,
%       !,
%       sum_score(Rest,ToDo,NormNode,ZScore,Sum_Score).

%% According to Gennari, et. al. 1989 and the COBWEB/3 implementation
%
%sum_score([],[],_,Score,Score).
%sum_score([],[Node|Rest],NormNode,Score,Sum_Score) :-
%	node(Node,_,Objects,Prediction),
%        node_objects(NormNode,NormObjects),
%	ZScore is ((Objects / NormObjects) * Prediction) 
%                  + Score,
%	!,
%	sum_score([],Rest,NormNode,ZScore,Sum_Score).
%sum_score([Node|Rest],ToDo,NormNode,Score,Sum_Score) :-
%	node(Node,_,Objects,Prediction),
%        node_objects(NormNode,NormObjects),
%	ZScore is ((Objects / NormObjects) * Prediction) 
%                  + Score,
%	!,
%	sum_score(Rest,ToDo,NormNode,ZScore,Sum_Score).

% According to Kietz 93 this implementation avoids rounding errors 
% in certain Prolog dialects.
%
% The first clause realizes a normalization, which seems to be 
% integrated already in certain callers of this routine. If you like 
% to use it, it needs to replace the following clause. Except for 
% smaller caller code size, there seems to be no other advantage of
% using the commented clause. Anyway I include its code, if someone 
% likes to clean up the callers. Note, that such a modification might 
% conflict compare_partitions/12 !
%
% sum_score([],[],NormNode,Score,NormScore):-
%	node_prediction(NormNode,NormPrediction),
%	NormScore = Score - NormPrediction,
%	!.
sum_score([],[],_,Score,Score).
sum_score([],[Node|Rest],NormNode,Score,Sum_Score) :-
	node(Node,_,Objects,Prediction),
        node_objects(NormNode,NormObjects),
	ZScore is ((Objects  * Prediction) / NormObjects)
                  + Score,
	!,
	sum_score([],Rest,NormNode,ZScore,Sum_Score).
sum_score([Node|Rest],ToDo,NormNode,Score,Sum_Score) :-
	node(Node,_,Objects,Prediction),
        node_objects(NormNode,NormObjects),
	ZScore is ((Objects * Prediction) / NormObjects) 
                  + Score,
	!,
	sum_score(Rest,ToDo,NormNode,ZScore,Sum_Score).

/******************************************************************/
/* compute the prediction of Node                                 */
/******************************************************************/

%compute_prediction(Node) :-
%	node_objects(Node,Objects),
%	asserta(prediction_counter(0,0)),
%	get_node_nominal_attr(Node,_,ValuesCounter),
%	if(retract(prediction_counter(Sum,Count)),true),
%	NCount is Count + 1,
%	asserta(prediction_counter(Sum,NCount)),
%	member(_-C,ValuesCounter),
%	if(retract(prediction_counter(NNSum,NCount)),true),
%	NSum is NNSum + ((C / Objects) * (C / Objects)),
%	asserta(prediction_counter(NSum,NCount)),
%	fail.
%compute_prediction(Node) :-
%	get_node_numeric_attr(Node,_,N,SumXiPow2,SumXi),
%	if(retract(prediction_counter(Sum,Count)),true),
%	NCount is Count + 1,
%	DeviationPow2 is (SumXiPow2/N) - ((SumXi*SumXi)/(N*N)),
%	abs(DeviationPow2,PosDeviationPow2),
%	sqrt(PosDeviationPow2,Deviation),
%	% Deviation of one Instance is 0, so we use a minimum deviation of 1
%	% Here 'acuity' is hardcoded !
%	max_of([Deviation,1],ScoreDeviation),
%	NSum is Sum + 1/ScoreDeviation,
%	asserta(prediction_counter(NSum,NCount)),
%	fail.
%compute_prediction(Node) :-
%	% Normalize the Prediction against the Number of Attributes
%	retract(prediction_counter(Prediction,Count)),
%	NormPrediction is Prediction / Count,
%	node_prediction(Node,NormPrediction),
%	!.

% According to Kietz 93 this implementation avoids rounding errors
% in certain Prolog dialects, and allows a better treatment of the
% 'acuity'.
compute_prediction(Node) :-
	node_objects(Node,Objects),
	asserta(prediction_counter(0,0)),
	get_node_nominal_attr(Node,_,ValuesCounter),
	if(retract(prediction_counter(Sum,Count)),true),
	NCount is Count + 1,
	asserta(prediction_counter(Sum,NCount)),
	member(_-C,ValuesCounter),
	if(retract(prediction_counter(NNSum,NCount)),true),
	NSum is NNSum + ((C * C) / (Objects * Objects)),
	asserta(prediction_counter(NSum,NCount)),
	fail.
compute_prediction(Node) :-
	get_node_numeric_attr(Node,_,N,SumXiPow2,SumXi),
	if(retract(prediction_counter(Sum,Count)),true),
	NCount is Count + 1,
	DeviationPow2 is (SumXiPow2/N) - ((SumXi*SumXi)/(N*N)),
	abs(DeviationPow2,PosDeviationPow2),
	sqrt(PosDeviationPow2,Deviation),
	Pi is pi, sqrt(Pi,S), Const is 1/4*S,
	% Deviation of one Instance is 0, so we use a minimum deviation of 1
	% Here 'acuity' isn't longer hardcoded, instead an value is retieved 
	% from the database. A minimal acuity Const is used to ensure that 
	% Const/ScoreDeviation is in the interval [0,1]!
	get_acuity(Acuity),
	max_of([Deviation,Acuity,Const],ScoreDeviation),
	NSum is Sum + Const/ScoreDeviation,
	asserta(prediction_counter(NSum,NCount)),
	fail.
compute_prediction(Node) :-
	% Normalize the Prediction against the Number of Attributes
	retract(prediction_counter(Prediction,Count)),
	NormPrediction is Prediction / Count,
	node_prediction(Node,Prediction),
	!.

get_acuity(Accuity) :- 
	clause(acuity(Accuity),true),
	!.
get_acuity(0).

/******************************************************************/
/* Internal Data Structures are:                                  */
/*                                                                */
/*    node(Node,Objects) with                                     */
/*         Node = Atom and Objects = Integer                      */
/*    node(Attribute,[Val-Count|...]) with                        */
/*         Attribute = Atom, Val = Atom and Count = Integer       */
/*    d_sub(Parent,Child) with                                    */
/*         Parent = Atom and Child = Atom                         */
/******************************************************************/

init_node:-
        abolish(root,2),
        abolish(root,4),
        (retract(gensym_counter(node_,_));true),
        (retractall(node(root,_,_));true),
        (retractall(d_sub(root,_));true),
        (retractall(d_sub(_,root));true),
        !.

new_node(node(Node,_,_)) :-
	nonvar(Node).
% QUINTUS-Prolog specific initialization
%new_node(node(Node,_,_)):-
%        var(Node),
%        gensym(node_,Node),
%        abolish(Node,2),
%        abolish(Node,4),
%        (retractall(node(Node,_,_));true),
%        (retractall(d_sub(Node,_));true),
%        (retractall(d_sub(_,Node));true),
%        !.
% SWI- YAP-, C- and M-Prolog specific initialization with declaration  
% of dynamical clauses.
new_node(node(Node,_,_)):-
        var(Node),
        gensym(node_,Node),
        dynamic(Node/2),
	dynamic(Node/4),
        abolish(Node,2),
        abolish(Node,4),
        (retractall(node(Node,_,_));true),
        (retractall(d_sub(Node,_));true),
        (retractall(d_sub(_,Node));true),
        !.

delete_node(Node) :-
	remove_node(Node),
	node_name(Node,NodeName),
	abolish(NodeName,2),
	abolish(NodeName,4),
        % This asumes that there is mostly one ParentNode
	(remove_d_sub(Parent,Node),
	 remove_d_sub(Node,Child),
	 assert_d_sub(Parent,Child),
	 fail;
         true),
	!.

terminal_node(Node) :-
	node_objects(Node,1).

move_subs(Source,Dest) :-
	remove_d_sub(Source,Child),
	assert_d_sub(Dest,Child),
	fail.
move_subs(Source,Dest) :-
	remove_d_sub(Parent,Source),
	assert_d_sub(Parent,Dest),
	!.

ins_node(Parent,New,[]) :-
	 assert_d_sub(Parent,New),
	 !.
ins_node(Parent,New,[Child|Rest]) :-
	(remove_d_sub(Parent,Child);true),
	assert_d_sub(New,Child),
	!,
	ins_node(Parent,New,Rest).

/******************************************************************/
/* node(Node:Atom,Objects:Integer,Prediction:Real)                */
/******************************************************************/

node_name(node(Name,_,_),Name) :-
	nonvar(Name),
	!.

node_objects(node(Name,Objects,_),Objects) :-
	nonvar(Name),
	if(var(Objects),get_node(node(Name,Objects,_)),true),
	!.

node_prediction(node(Name,Objects,Pred),Pred) :-
	nonvar(Name),
	(var(Pred), get_node(node(Name,Objects,Pred)); 
	 true),
	if(var(Pred),compute_prediction(node(Name,Objects,Pred)),true),
	!.

node(node(Name,Objects,Pred),Name,Objects,Pred) :-
	nonvar(Name),
	if(var(Objects),get_node(node(Name,Objects,_)),true),
	(var(Pred), get_node(node(Name,Objects,Pred)); 
	 true),
	if(var(Pred),compute_prediction(node(Name,Objects,Pred)),true),
	!.	

get_node(node(Node,Objects,Pred)) :-
	clause(node(Node,Objects,Pred),true).

assert_node(node(Node,Objects,Pred)) :-
	nonvar(Node),
	asserta(node(Node,Objects,Pred)).

remove_node(node(Node,Objects,Pred)) :-
	retract(node(Node,Objects,Pred)).

/******************************************************************/
/* node(Attr:Atom,[Val:Atom-Count:Integer|...])                   */
/******************************************************************/

get_node_nominal_attr(node(Node,_,_),Attr,ValuesCounter) :-
	nonvar(Node), nonvar(Attr),
 	Call =.. [Node,Attr,ValuesCounter],
	(clause(Call,true);
	 if(var(ValuesCounter),ValuesCounter = [])),
	!.
get_node_nominal_attr(node(Node,_,_),Attr,ValuesCounter) :-
	nonvar(Node), var(Attr),
	Call =.. [Node,Attr,ValuesCounter],
	clause(Call,true).

assert_node_nominal_attr(_,_,[]).
assert_node_nominal_attr(node(Node,_,_),Attr,ValuesCounter) :-
	nonvar(Node), nonvar(Attr), nonvar(ValuesCounter),
	Call =.. [Node,Attr,ValuesCounter],
	asserta(Call).

remove_node_nominal_attr(node(Node,_,_),Attr,ValuesCounter) :-
	nonvar(Node), nonvar(Attr),
	Call =.. [Node,Attr,ValuesCounter],
	(retract(Call);
	 if(var(ValuesCounter),ValuesCounter = [])),
	!.
remove_node_nominal_attr(node(Node,_,_),Attr,ValuesCounter) :-
	nonvar(Node),
	Call =.. [Node,Attr,ValuesCounter],
	retract(Call).

/******************************************************************/
/* node(Attr:Atom,N:Integer,SumXiPow2:Integer,SumXi:Integer)      */
/******************************************************************/

get_node_numeric_attr(node(Node,_,_),Attr,N,SumXiPow2,SumXi) :-
	nonvar(Node), nonvar(Attr),
	Call =.. [Node,Attr,N,SumXiPow2,SumXi],
	(clause(Call,true);
	 if(var(N),(N = 0, SumXiPow2=0, SumXi=0))),
	!.
get_node_numeric_attr(node(Node,_,_),Attr,N,SumXiPow2,SumXi) :-
	nonvar(Node), var(Attr),
	Call =.. [Node,Attr,N,SumXiPow2,SumXi],
	clause(Call,true).

assert_node_numeric_attr(_,_,0,_,_).
assert_node_numeric_attr(node(Node,_,_),Attr,N,SumXiPow2,SumXi) :-
	nonvar(Node), nonvar(Attr), nonvar(N), nonvar(SumXiPow2), nonvar(SumXi),
	Call =.. [Node,Attr,N,SumXiPow2,SumXi],
	asserta(Call).

remove_node_numeric_attr(node(Node,_,_),Attr,N,SumXiPow2,SumXi) :-
	nonvar(Node), nonvar(Attr),
	Call =.. [Node,Attr,N,SumXiPow2,SumXi],
	(retract(Call);
	 if(var(N),(N = 0,SumXiPow2=0,SumXi=0))),
	!.
remove_node_numeric_attr(node(Node,_,_),Attr,N,SumXiPow2,SumXi) :-
	nonvar(Node),
	Call =.. [Node,Attr,N,SumXiPow2,SumXi],
	retract(Call).

/******************************************************************/
/* d_sub(SuperNode:Atom,SubNode:Atom)                             */
/******************************************************************/

get_d_sub(node(SuperNode,_,_),node(SubNode,_,_)) :-
	clause(d_sub(SuperNode,SubNode),true).

assert_d_sub(node(SuperNode,_,_),node(SubNode,_,_)) :-
	asserta(d_sub(SuperNode,SubNode)).

remove_d_sub(node(SuperNode,_,_),node(SubNode,_,_)) :-
	retract(d_sub(SuperNode,SubNode)).

/******************************************************************/
/* Miscealenous definitions                                       */
/******************************************************************/

max_of([F|R],Max) :-
	max_of(R,F,Max),
	!.
max_of([],Max,Max).
max_of([F|R],Best,Max) :-
	F =< Best,
	!,
	max_of(R,Best,Max).
max_of([F|R],_,Max) :-
	max_of(R,F,Max).

msgs([]) :- !.
msgs([First|Rest]) :-
        msg(First),
        msgs(Rest).

msg(node(ID,Obj,Pred)) :-
	!, write(ID), write('(obj='), 
	write(Obj), write(',pred='),
	write(Pred), write(')').
msg(Var) :-
	var(Var),
	!,
	write(Var).
msg(nl) :-
        !, nl.
msg(nl(N)) :-
        !, msg_repeat(N,nl).
msg(sp) :-
        !,
        write(' ').
msg(sp(N)) :-
        !, msg_repeat(N,outterm(' ')).
msg(q_(O)) :-
        !,
        write(O).
msg(X) :-
        !,
        write(X).

% msg_repeat Call N times.
msg_repeat(N,_) :-
        N < 1,
        !.
msg_repeat(N,Call) :-
        Call,
        N1 is N - 1,
        msg_repeat(N1,Call).

save_kb(FN) :-
	concat(FN,'.pl',Y),
	tell(Y),
        print_kb,
        told,
        !.

load_kb(FN) :-
	clear_kb,
	concat(FN,'.pl',Y),
	consult(Y),
        !.

print_kb:-
	if(Call = d_sub(SuperNode,SubNode),true),
        clause(Call,true),
        if((writeq(Call),
            write(.),
            nl),
           fail).
print_kb:-
	get_node(Node),
	if((writeq(Node),
            write(.),
            nl), 
           fail).
print_kb:-
	get_node(Node),
	if((node_name(Node,Name),
            Call =.. [Name,Attr,ValuesCounter]),
	   true),
	clause(Call,true),
	if((writeq(Call),
            write(.),
            nl), 
           fail).
print_kb:-
	get_node(Node),
	if((node_name(Node,Name),
            Call =.. [Name,Attr,N,SumXiPow2,SumXi]),true),
	clause(Call,true),
	if((writeq(Call),
            write(.),
            nl), 
           fail).
print_kb.

clear_kb:-
	get_node(Node),
	if((node_name(Node,Name),
	    abolish(Name,2),
	    abolish(Name,4)),
	   fail).
clear_kb:-
	abolish(node,3),
	abolish(d_sub,2),
        (retract(gensym_counter(node_,_));true),
        assert(gensym_counter(node_,0)),
	!.

show :- 
	collect_tree(root,Tree,all),
	display_tree(Tree), 
	!.

show_classes :- 
	collect_tree(root,Tree,classes),
	display_tree(Tree), 
	!.

collect_tree([],[],_).
collect_tree([Node|Nodes],[SubTree|SubTrees],Type) :-
	collect_tree(Node,SubTree,Type),
	!,
	collect_tree(Nodes,SubTrees,Type).
collect_tree([_|Nodes],SubTrees,classes) :-
	% Terminals are ignored here 
	!,
	collect_tree(Nodes,SubTrees,classes).
collect_tree(Node,[Node,Obj,SubTrees],Type) :-
	clause(node(Node,Obj,_),true),
	( setof(Sub,clause(d_sub(Node,Sub),true),Subs)
	; Type = all, Subs = [] ),
	!,  
	collect_tree(Subs,SubTrees,Type).

display_tree([Node,Obj,SubTrees]) :-
	write('Number of cases processed: '), write(Obj), nl,
	write(Node), 
	name(Node,String), length(String,Offset),
	display_tree(SubTrees,Offset).

display_tree([Node],Offset) :-
	!,
	display_tree_node(Node,Offset).
display_tree([Node|Subtrees],Offset) :-
	!,
	display_tree_node(Node,Offset),
	tab(Offset),
	display_tree(Subtrees,Offset).

display_tree_node([Node,Obj,[]],Offset) :-
	!,
	write(' <-- '), write(Node), write(' = '), write(Obj), 
	nl.
display_tree_node([Node,Obj,Subtree],Offset) :-
	write(' <-- '), write(Node), write(' = '), write(Obj), 
	name(Node,String1), length(String1,SLength),
	name(Obj,String2), length(String2,NLength),
	NewOffset is Offset + 5 + SLength + 3 + NLength,
	display_tree(Subtree,NewOffset).

show_node(Node) :-
	collect_attribute_values(Node,Nominal,Numeric),
	display_node(Node,Nominal,Numeric).

collect_attribute_values(Node,NominalAttValueList,NumericAttValueList) :-
	NominalAttValues =.. [Node,NominalAtt,NominalVals],
	NumericAttValues =.. [Node,NumericAtt,Number,X,Y],
	findall(NominalAttValues,call(NominalAttValues),NominalAttValueList),
	findall(NumericAttValues,call(NumericAttValues),NumericAttValueList).

/******************************************************************/
/* utility predicates                                             */
/******************************************************************/

if(Cond,Then) :-
	call(Cond), !, call(Then).
if(_,_).

if(Cond,Then,Else) :-
	call(Cond), !, calltrue(Then).
if(_,_,Else) :- 
	calltrue(Else).
	
calltrue(Call) :- 
	call(Call), !.
calltrue(_).

count(VAR,X) :- 
	retract(gensym_counter(VAR,N)), 
	X is N+1, 
	assert(gensym_counter(VAR,X)), ! .
count(VAR,1) :- 
	assert(gensym_counter(VAR,1)) .

gensym(SYM) :-
	gensym(SYM,g).
     
gensym(N,Sym) :-
	count(N,X), 
	name(N,S1), name(X,S2),
        append(S1,S2,S3), name(Sym,S3).

retractall(HEAD) :-
     var(HEAD), !, fail.
retractall((HEAD :- BODY)) :- 
     var(BODY), !, 
       (retract((HEAD :- true)), fail;
        true),
       (retract((HEAD:-_)), fail;
        true). 
retractall((HEAD :- true)) :- 
     retract((HEAD :- true)), fail .
retractall((HEAD :- BODY)) :- 
     retract((HEAD:-BODY)), fail .
retractall(_) .

/******************************************************************/
/* YAP-Prolog specific declaration.                               */
/******************************************************************/

abs(X,Y) :- 
	X < 0, Y is X * -1, !.
abs(X,X).

sqrt(X,Y) :- 
	Y is sqrt(X).

help :- write(' Load data set                    : load_kb(Filename).'), nl,
	write(' Process single   file            : learn.'), nl,
	write(' Process multiple files           : learn_more.'), nl,
	write(' Show hierarchy (classes & cases) : show.'), nl,
	write(' Show hierarchy (classes only)    : show_classes.'), nl,
	write(' Show node      (not yet impl.)   : show_node(NodeID).'), nl,
	write(' Print  result  (cryptical)       : print_kb.'), nl,
	write(' Store  result                    : save_kb(Filename).'), nl,
	write(' Forget result                    : clear_kb.'), nl.

:- help.

