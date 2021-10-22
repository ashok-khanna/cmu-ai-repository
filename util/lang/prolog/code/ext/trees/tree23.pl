% tree23.pl	Associates keys with values using 2-3 trees
%
% Author: Mark Johnson <mj@cs.brown.edu>
% Date: 21st August 1991
%
% The procedures in this file manipulate finite maps from keys to
% values.  Because 2-3 trees are used, they automatically rebalance
% after each insertion or deletion.
%
% Contents:
%
% empty_23(?Tree23) - Tree23 is the empty map
% gen_23(?Key, +Tree23, ?Value) - enumerate key-values in Tree23
% get_23(+Key, +Tree23, ?Value) - find Value associated with Key in Tree23
% list_to_23(+Pairs, -Tree23) - build a 2-3 tree for Pairs
% portray_23(+Tree23) - portray a 2-3 tree
% is_23(?Tree23) - test if Tree23 is a 2-3 tree
% put_23(+Key, +Old23, ?Value, -New23) - New23 is a 2-3 tree just like
%   Old23 except that it associates Key with Value.
% update_23(+Key, +Old23Tree, ?Val, ?Mode, -New23Tree) is exactly
%   the same as put_23(Key, Old23Tree, Val, New23Tree), except that
%   Mode = replace(OldVal) if a pair Key-OldVal appears in Old23Tree;
%   (in this case OldVal is replaced by NewVal in New23Tree), and
%   that Mode = insert if such a pair does not appear in Old23Tree.


empty_23(two_three).

% gen_23(?Key, +Tree23, ?Value)
% iff Key-Value appears in Tree23.  Use this to enumerate all pairs
% in Tree23.
gen_23(Key, Tree, Value) :-
	gen_23(Tree, Key-Value).

gen_23(two(Key), Key).
gen_23(two(T0,_,_), Key) :- gen_23(T0, Key).
gen_23(two(_,Key,_), Key).
gen_23(two(_,_,T1), Key) :- gen_23(T1, Key).
gen_23(three(Key,_), Key).
gen_23(three(_,Key), Key).
gen_23(three(T0,_,_,_,_), Key) :- gen_23(T0, Key).
gen_23(three(_,Key,_,_,_), Key).
gen_23(three(_,_,T1,_,_), Key) :- gen_23(T1, Key).
gen_23(three(_,_,_,Key,_), Key).
gen_23(three(_,_,_,_,T2), Key) :- gen_23(T2, Key).



% get_23(+Key, +Tree23, ?Val)
get_23(Key, Tree, Val) :-
	get_23(Tree, Key-Val).

% get_23(Tree23, Key)
% finds Key in Tree23, where compare_keys orders keys.
get_23(two(Key1), Key) :-
	compare_keys(=, Key, Key1),
	Key = Key1.
get_23(two(T0,K1,T1), Key) :-
	compare_keys(Rel, Key, K1),
	get_2(Rel, Key, T0, K1, T1).
get_23(three(K1,K2), Key) :-
	compare_keys(Rel, Key, K1, K2),
	get_3(Rel, Key, K1, K2).
get_23(three(T0,K1,T1,K2,T2), Key) :-
	compare_keys(Rel, Key, K1, K2),
	get_3(Rel, Key, T0, K1, T1, K2, T2).

get_2(<, Key, T0, _, _) :- get_23(T0, Key).
get_2(=, Key, _, Key, _).
get_2(>, Key, _, _, T1) :- get_23(T1, Key).

get_3(1, Key, Key, _).
get_3(2, Key, _, Key).

get_3(<, Key, T0, _, _, _, _) :- get_23(T0, Key).
get_3(1, Key, _, Key, _, _, _).
get_3(><, Key, _, _, T1, _, _) :- get_23(T1, Key).
get_3(2, Key, _, _, _, Key, _).
get_3(>, Key, _, _, _, _, T2) :- get_23(T2, Key).



% list_to_23(List, Tree23)
list_to_23(List, Tree23) :-
	list_to_23(List, two_three, Tree23).

list_to_23([], Tree, Tree).
list_to_23([E|Es], Tree0, Tree) :-
	put_23(Tree0, E, Tree1),
	list_to_23(Es, Tree1, Tree).




% portray_23(Tree23)
portray_23(Tree) :-
	is_23(Tree),
	portray_23_1(Tree).

portray_23_1(_) :- write('23 Tree{'), nl, fail.
portray_23_1(Tree23) :-
	gen_23(Tree23, Key),
	tab(2),
	write(Key),
	nl,
	fail.
portray_23_1(_) :-
	write('}').

is_23(two_three).
is_23(two(_)).
is_23(two(_,_,_)).
is_23(three(_,_)).
is_23(three(_,_,_,_,_)).




% put_23(Key, Old23Tree, Val, New23Tree) iff
% New23Tree is the tree obtained by replacing the value of Key in
% Old23Tree with Val.  Key need not be defined in Old23Tree.

put_23(Key, Old23Tree, Val, New23Tree) :-
	put_23(Old23Tree, Key-Val, New23Tree).

% put_23(Old23Tree, Key, New23Tree) iff New23Tree is the tree
% obtained by replacing a key K in Old23Tree with Key,
% such that compare_keys(=, K, Key), or inserting Key if
% there is no such K in Old23Tree

put_23(two_three, Key, TwoThree) :- 
	!,
	TwoThree = two(Key).
put_23(Old, Key, New) :-
	put_23(Old, Key, New1, EKey, ETree),
	put_23_top(ETree, New1, EKey, New).

put_23_top(none, New1, _, New) :-
	!,
	New=New1.
put_23_top(ETree, Tree0, EKey, two(Tree0,EKey,ETree)).

put_23(two(Key1), Key, New, _, none) :-
	compare_keys(Rel, Key, Key1),
	put_2(Rel, Key, Key1, New).
put_23(two(Tree0,Key1,Tree1), Key, New, _, none) :-
	compare_keys(Rel, Key, Key1),
	put_2(Rel, Key, Tree0, Key1, Tree1, New).
put_23(three(Key1,Key2), Key, NewTree, ExtraKey, ExtraTree) :-
	compare_keys(Rel, Key, Key1, Key2),
	put_3(Rel, Key, Key1, Key2, NewTree, ExtraKey, ExtraTree).
put_23(three(Tree0,Key1,Tree1,Key2,Tree2), Key, New, EKey, ETree) :-
	compare_keys(Rel, Key, Key1, Key2),
	put_3(Rel, Key, Tree0, Key1, Tree1, Key2, Tree2, New, EKey, ETree).

put_2(=, Key, _, two(Key)).
put_2(<, Key, Key1, three(Key,Key1)).
put_2(>, Key, Key1, three(Key1,Key)).

put_2(=, Key, Tree0, _, Tree1, two(Tree0,Key,Tree1)).
put_2(<, Key, OldTree0, Key1, Tree1, New) :-
	put_23(OldTree0, Key, NewTree0, ExtraKey, ExtraTree),
	put_2_l(ExtraTree, NewTree0, ExtraKey, Key1, Tree1, New).
put_2(>, Key, Tree0, Key1, OldTree1, New) :-
	put_23(OldTree1, Key, NewTree1, ExtraKey, ExtraTree),
	put_2_r(ExtraTree, Tree0, Key1, NewTree1, ExtraKey, New).

put_2_l(none, Tree0, _, Key1, Tree1, two(Tree0,Key1,Tree1)) :- 
	!.
put_2_l(ETree, Tree0, EKey, Key1, Tree1, 
			three(Tree0,EKey,ETree,Key1,Tree1)).

put_2_r(none, Tree0, Key1, Tree1, _, two(Tree0,Key1,Tree1)) :- 
	!.
put_2_r(ETree, Tree0, Key1, Tree1, EKey,
			three(Tree0,Key1,Tree1,EKey,ETree)).

put_3(1, Key, _, Key2, three(Key,Key2), _, none).
put_3(2, Key, Key1, _, three(Key1,Key), _, none).
put_3(<, Key, Key1, Key2, two(Key), Key1, two(Key2)).
put_3(><, Key, Key1, Key2, two(Key1), Key, two(Key2)).
put_3(>, Key, Key1, Key2, two(Key1), Key2, two(Key)).

put_3(1, Key, Tree0, _, Tree1, Key2, Tree2,
		three(Tree0, Key, Tree1, Key2, Tree2),
		_, none).
put_3(2, Key, Tree0, Key1, Tree1, _, Tree2,
		three(Tree0, Key1, Tree1, Key, Tree2),
		_, none).
put_3(<, Key, OldTree0, Key1, Tree1, Key2, Tree2, New, NEKey, NETree) :-
	put_23(OldTree0, Key, NewTree0, EKey, ETree),
	put_3_l(ETree, NewTree0, EKey, Key1, Tree1, Key2, Tree2, 
		New, NEKey, NETree).
put_3(><, Key, Tree0, Key1, OldTree1, Key2, Tree2, New, NEKey, NETree) :-
	put_23(OldTree1, Key, NewTree1, EKey, ETree),
	put_3_m(ETree, Tree0, Key1, NewTree1, EKey, Key2, Tree2, 
		New, NEKey, NETree).
put_3(>, Key, Tree0, Key1, Tree1, Key2, OldTree2, New, NEKey, NETree) :-
	put_23(OldTree2, Key, NewTree2, EKey, ETree),
	put_3_r(ETree, Tree0, Key1, Tree1, Key2, NewTree2, EKey,
		New, NEKey, NETree).

put_3_l(none, Tree0, _, Key1, Tree1, Key2, Tree2,
		three(Tree0,Key1,Tree1,Key2,Tree2),
		_, none) :-
	!.
put_3_l(ETree, Tree0, EKey, Key1, Tree1, Key2, Tree2,
		two(Tree0,EKey,ETree),
		Key1, two(Tree1,Key2,Tree2)).

put_3_m(none, Tree0, Key1, Tree1, _, Key2, Tree2,
		three(Tree0,Key1,Tree1,Key2,Tree2),
		_, none) :-
	!.
put_3_m(ETree, Tree0, Key1, Tree1, EKey, Key2, Tree2,
		two(Tree0,Key1,Tree1),
		EKey,
		two(ETree,Key2,Tree2)).

put_3_r(none, Tree0, Key1, Tree1, Key2, Tree2, _,
		three(Tree0,Key1,Tree1,Key2,Tree2),
		_, none) :-
	!.
put_3_r(ETree, Tree0, Key1, Tree1, Key2, Tree2, EKey,
		two(Tree0,Key1,Tree1),
		Key2,
		two(Tree2,EKey,ETree)).

% compare_keys(Rel, Key, Key1, Key2) assumes that Key1 < Key2,
% then Rel = < iff Key < Key1
%            1     Key = Key1
%            ><    Key1 < Key < Key2
%            2     Key = Key2
%            >     Key2 < Key
% with respect to the pairwise order of the relation compare_keys/3.

compare_keys(Rel, Key, Key1, Key2) :-
	compare_keys(Rel1, Key, Key1),
	compare_keys1(Rel1, Key, Key2, Rel).

compare_keys1(=, _, _, 1).
compare_keys1(<, _, _, <).
compare_keys1(>, Key, Key2, Rel) :-
	compare_keys(Rel2, Key, Key2),
	compare_keys1(Rel2, Rel).

compare_keys1(=, 2).
compare_keys1(<, ><).
compare_keys1(>, >).

% compare_keys(Rel, Key0, Key1) is a total order on Keys that is used
% to structure the 23-trees.

compare_keys(Rel, Key0-_, Key1-_) :-
	compare(Rel, Key0, Key1).

% update_23(+Key, +Old23Tree, ?Val, ?Mode, -New23Tree) is exactly
% the same as put_23(Key, Old23Tree, Val, New23Tree), except that
% Mode = replace(OldVal) if a pair Key-OldVal appears in Old23Tree;
% (in this case OldVal is replaced by NewVal in New23Tree), and
% that Mode = insert if such a pair does not appear in Old23Tree.

update_23(Key, Old23Tree, Val, Mode, New23Tree) :-
	var(Mode), !,
	update_23(Old23Tree, Key-Val, Mode0, New23Tree),
	update_mode(Mode, Mode0).
update_23(Key, Old23Tree, Val, Mode, New23Tree) :-
	update_mode(Mode, Mode0),
	update_23(Old23Tree, Key-Val, Mode0, New23Tree).

update_mode(insert, insert).
update_mode(replace(Val), replace(_-Val)).

% update_23(+Old23Tree, +Key, ?Mode, -New23Tree) iff 
%   (i) Old23Tree contains a key K such that compare_keys(=, K, Key),
%       Mode = replace(K), and New23Tree = Old23Tree - {K} + {Key}, or
%  (ii) Old23Tree does not contain a key K such that compare_keys(=, K, Key),
%       Mode = insert, and New23Tree = Old23Tree + {Key}.

update_23(two_three, Key, Mode, TwoThree) :- 
	!,
	Mode = insert,
	TwoThree = two(Key).
update_23(Old, Key, Mode, New) :-
	update_23(Old, Key, Mode, New1, EKey, ETree),
	put_23_top(ETree, New1, EKey, New).

update_23(two(Key1), Key, Mode, New, _, none) :-
	compare_keys(Rel, Key, Key1),
	update_2(Rel, Key, Key1, Mode, New).
update_23(two(Tree0,Key1,Tree1), Key, Mode, New, _, none) :-
	compare_keys(Rel, Key, Key1),
	update_2(Rel, Key, Tree0, Key1, Tree1, Mode, New).
update_23(three(Key1,Key2), Key, Mode, NewTree, ExtraKey, ExtraTree) :-
	compare_keys(Rel, Key, Key1, Key2),
	update_3(Rel, Key, Key1, Key2, Mode, NewTree, ExtraKey, ExtraTree).
update_23(three(Tree0,Key1,Tree1,Key2,Tree2), Key, Mode, New, EKey, ETree) :-
	compare_keys(Rel, Key, Key1, Key2),
	update_3(Rel, Key, Tree0, Key1, Tree1, Key2, Tree2, 
                     Mode, New, EKey, ETree).

update_2(=, Key, Key1, replace(Key1), two(Key)).
update_2(<, Key, Key1, insert, three(Key,Key1)).
update_2(>, Key, Key1, insert, three(Key1,Key)).

update_2(=, Key, Tree0, Key1, Tree1, replace(Key1), two(Tree0,Key,Tree1)).
update_2(<, Key, OldTree0, Key1, Tree1, Mode, New) :-
	update_23(OldTree0, Key, Mode, NewTree0, ExtraKey, ExtraTree),
	put_2_l(ExtraTree, NewTree0, ExtraKey, Key1, Tree1, New).
update_2(>, Key, Tree0, Key1, OldTree1, Mode, New) :-
	update_23(OldTree1, Key, Mode, NewTree1, ExtraKey, ExtraTree),
	put_2_r(ExtraTree, Tree0, Key1, NewTree1, ExtraKey, New).

update_3(1, Key, Key1, Key2, replace(Key1), three(Key,Key2), _, none).
update_3(2, Key, Key1, Key2, replace(Key2), three(Key1,Key), _, none).
update_3(<, Key, Key1, Key2, insert, two(Key), Key1, two(Key2)).
update_3(><, Key, Key1, Key2, insert, two(Key1), Key, two(Key2)).
update_3(>, Key, Key1, Key2, insert, two(Key1), Key2, two(Key)).

update_3(1, Key, Tree0, Key1, Tree1, Key2, Tree2, replace(Key1),
		three(Tree0, Key, Tree1, Key2, Tree2),
		_, none).
update_3(2, Key, Tree0, Key1, Tree1, Key2, Tree2, replace(Key2),
		three(Tree0, Key1, Tree1, Key, Tree2),
		_, none).
update_3(<, Key, OldTree0, Key1, Tree1, Key2, Tree2, 
                                            Mode, New, NEKey, NETree) :-
	update_23(OldTree0, Key, Mode, NewTree0, EKey, ETree),
	put_3_l(ETree, NewTree0, EKey, Key1, Tree1, Key2, Tree2, 
		New, NEKey, NETree).
update_3(><, Key, Tree0, Key1, OldTree1, Key2, Tree2, 
                                             Mode, New, NEKey, NETree) :-
	update_23(OldTree1, Key, Mode, NewTree1, EKey, ETree),
	put_3_m(ETree, Tree0, Key1, NewTree1, EKey, Key2, Tree2, 
		New, NEKey, NETree).
update_3(>, Key, Tree0, Key1, Tree1, Key2, OldTree2, 
                                             Mode, New, NEKey, NETree) :-
	update_23(OldTree2, Key, Mode, NewTree2, EKey, ETree),
	put_3_r(ETree, Tree0, Key1, Tree1, Key2, NewTree2, EKey,
		New, NEKey, NETree).




