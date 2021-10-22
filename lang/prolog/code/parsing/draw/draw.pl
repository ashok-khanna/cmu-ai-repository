/*-----------------------------------------------------------------------------*/
/*  This program was written by Mark Holcomb and is hearby released into the   */
/*  public domain provided this header remains intact.  As usual, no guarantee */
/*  is made as to the correctness of the code, the suitability of this code    */
/*  for any particular application, or that the code will be maintained.       */
/*  USAGE:                                                                     */
/*      The code expects (as input), the tree structure of a sentence in a     */
/*      form similar to:   s(np(d(the),n(dog)),vp(v(ran),np(d(the),n(house)))) */
/*      and prints an ascii diagram of the structure.                          */
/*                                                                             */
/*        eg.  draw(s(np(d(the),n(dog)),vp(v(ran),np(d(the),n(house))))).      */
/*									       */
/*                       s                                                     */
/*		         |                                                     */
/*          +-----------------+                                                */
/*    	    np                vp                                               */
/*	    |                 |                                                */
/*	 +------+      +----------+                                            */
/*	 d      n      v          np                                           */
/*	 |      |      |          |                                            */
/*	 |      |      |      +-------+                                        */
/*	 |      |      |      d       n                                        */
/*	 |      |      |      |       |                                        */
/*	 |      |      |      |       |                                        */
/*      the    dog    ran    the    house                                      */
/*                                                                             */
/*-----------------------------------------------------------------------------*/

/* ---- begin draw routine ----------------------------------------------------*/

:- ensure_loaded(library(lists)).

/* the 5 in add is the constant offset from the left edge of the screen */

draw(Struct) :- md(1,Struct,1,Depth),
		add(Depth,Struct,New_struct,5,_),
		Mod is Depth + 1,
		breadth(1,Mod,New_struct).

trunc(X,Y) :-
	name(X,NX),
	until_dot(NX,NY),
	rev(NY,RNY),
	name(Y,RNY).

until_dot(X,Res) :- until_dot_aux(X,[],Res).
until_dot_aux([],Res,Res) :- !.
until_dot_aux([46|_],Res,Res) :- !.
until_dot_aux([H|T],Sofar,Res) :- until_dot_aux(T,[H|Sofar],Res).

append([],X,X).
append([X1|X2],Y,[X1|Z]) :- append(X2,Y,Z).

wspaces(0).
wspaces(Num) :- New is Num - 1, write(' '), wspaces(New).

spaces(0,Tout,Tout).
spaces(Num,Tin,Tout) :- New is Num - 1,
			append(Tin,[32],Tmid),
			spaces(New,Tmid,Tout).

aux_lines(_,_,Max,Max) :- !. /* if this is the last level, don't print |'s */
aux_lines(Out,Begin,_,_) :- lines(Out,Begin).

lines([],_).
lines([H|T],Cur) :- New is H - Cur, wspaces(New),
		 	Next is H + 1,	
			write('|'), lines(T,Next). 

size(Term,Size) :- name(Term,List),len(List,Size). 

len([],0).
len([_|T],Length) :- len(T,J), Length is J + 1.

dummy(~,Tin,Tout) :- !,
		       append(Tin,[124],Tout). 

dummy(Name,Tin,Tout) :- name(Name,List), append(Tin,List,Tout).

prt([]).
prt(List) :- name(Text,List),write(Text).

post(0,_) :- !.
post(1,_) :- !. 
post(_,Dout) :- prt(Dout).

end([],[],[]):- !. /* empty list sent to end */
end([H],[],H) :- !,atomic(H). /* one element list */
end([H|T],[H|Out],End) :- end(T,Out,End).

cross(2,Din,Dout,Chars) :- !, single(Din,Dout,Chars).
cross(_,Din,Dout,Chars) :- aux_cross(Din,Dout,Chars).

ifs([],Dout,Dout) :- !.
ifs(32,Dout,Dout) :- !,nl,write('Error: blank end in ifs ').
ifs(End,Din,Dout) :- append(Din,[End],Dout).


single(Din,Dout,Chars) :- end(Din,Dmid,End),
					  /* if [] add char - 1 spaces
					     if + append + and char - 1 spaces
					     if | append | and char - 1 spaces 
					     if anything else, I messed up */
			ifs(End,Dmid,Dmid2),
			New is Chars - 1,
			spaces(New,Dmid2,Dmid3),
			append(Dmid3,[124],Dout). /* add a '|' to Dout */

dashes(0,Dout,Dout) :- !.
dashes(Num,Din,Dout) :- New is Num - 1,
			append(Din,[45],Dmid),
			dashes(New,Dmid,Dout). 

cont(32,Chars,Din,Dout) :- !,dashes(Chars,Din,Dout).
			/* if ' ' append char dashes */
				
			
cont(End,Chars,Din,Dout) :- 	New is Chars - 1,
				ifs(End,Din,Dmid),
				spaces(New,Dmid,Dmid1),
				append(Dmid1,[43],Dout).

				/* if [] add char - 1 spaces and +
				if + append + and char - 1 spaces and +	
				if | append | and char - 1 spaces and +
				if anything else, I messed up */

aux_cross(Din,Dout,Chars) :- 	end(Din,Dmid1,End),
				cont(End,Chars,Dmid1,Dmid2),
			/* since we are in a --- always end with a ' ' */
				append(Dmid2,[32],Dout).

choose(32,Din,Dout) :- append(Din,[43],Dout).
choose(End,Din,Dout) :-  ifs(End,Din,Dout).

check(In) :- In>0,!.
check(In) :- In=<0,write('Error: label overlap detected; suggest increasing base node seperation in loc'),nl, fail.
						
breadth(Max,Max,_) :- !.
breadth(Level,Max,Struct) :-
			New is Level + 1,
			at(Level,1,Struct,0,_,[],Out,[],Tout,[],Dout), 
			/* print dashes, nl, text, nl, lines, nl */
			post(Level,Dout), nl,
	 		prt(Tout), nl,
	 		aux_lines(Out,0,New,Max),nl,
			breadth(New,Max,Struct).

at(1,Arity,Struct,Cur,Pos,In,Out,Tin,Tout,Din,Dout) :- !,
			functor(Struct,Name,_),
			arg(1,Struct,Spaces), 
			Actual is Spaces - Cur,
			check(Actual), 
			spaces(Actual,Tin,Tmid),
			T is Cur + Actual,
			size(Name,Size), Pos is T + Size,
			M is (Size+1)/2, trunc(M,V),
			L is T + V - 1,
			len(Din,Len),
			Chars_needed is ((L + 1) - Len),
			cross(Arity,Din,Dout,Chars_needed),
			append(In,[L],Out),
			dummy(Name,Tmid,Tout).


at(Level,_,Struct,Cur,Pos,In,Out,Tin,Tout,Din,Dout) :- 
				functor(Struct,_,Arity),
				Next_lev is Level - 1,
	for_each(1,Arity,Struct,Next_lev,Cur,Pos,In,Out,Tin,Tout,Din,Dout).

for_each(Same,Same,_,_,X,X,Y,Y,Z,Z,Din,Dout) :- !, end(Din,Mid,End),
						choose(End,Mid,Dout).
					/* if End is ' ' then append '+'
					else append End */

for_each(Begin,End,Struct,Level,Cur,New_Pos,In,Out,Tin,Tout,Din,Dout) :-
				Count is Begin + 1, 
				arg(Count,Struct,Sub),
			at(Level,End,Sub,Cur,Pos,In,Mid,Tin,TMid,Din,Dmid),
      for_each(Count,End,Struct,Level,Pos,New_Pos,Mid,Out,TMid,Tout,Dmid,Dout).

/* ------ end draw  ------------- max depth begin --------------------------*/

md(Level,Struct,Cur,Level) :- functor(Struct,_,0), Level >= Cur, !.
md(Level,Struct,Cur,Cur) :- functor(Struct,_,0), Cur < Level, !.

md(Level,Struct,Cur,Max) :- functor(Struct,_,Arity),
				Next is Level + 1,
				foreach(0,Arity,Struct,Cur,Max,Next).

foreach(Same,Same,_,Max,Max,_) :- !.

foreach(Begin,End,Struct,Cur,Max,Level) :- Count is Begin + 1,
					arg(Count,Struct,Sub),
					md(Level,Sub,Cur,Cmax),
	 			       foreach(Count,End,Struct,Cmax,Max,Level).
/*--- max depth end ----------------------------------------------------------*/

/* the 4 in "New is (Cur + Size) + 4" below is the spacing between base nodes
   of the tree.  If you are having label overlap problems, increase it and
   they might go away */

loc(Struct,Cur,New,New_struct,Adj) :-   size(Struct,Size), 
					New is (Cur + Size) + 4,
					functor(Struct,Name,Arity),
					NArity is Arity + 1,
					functor(New_struct,Name,NArity),
					M is (Size + 1)/2, trunc(M,V), 
					Adj is Cur + (V - 1). 

al(0,Struct,New_struct,Cur,New,Adj) :- loc(Struct,Cur,New,New_struct,Adj),
					arg(1,New_struct,Cur).

/* everytime I get to bottom of branch, and level is not equal to maxdepth,
   add a level */

al(Needed_Depth,Struct,New_struct,Cur,Npos,Adj)  :- New is Needed_Depth - 1, 
					al(New,Struct,Tstruct,Cur,Npos,Adj),
					functor(New_struct,'~',2),
				        arg(2,New_struct,Tstruct),
					arg(1,New_struct,Adj).

/* this is the case where we are at the leaf and it is the right depth */

add(1,Struct,New_struct,Cur,New) :- !,
					loc(Struct,Cur,New,New_struct,_),
					arg(1,New_struct,Cur).

/* this is the case where the leaf is not deep enough (add dummys) */
add(Depth,Struct,New_struct,Cur,New)  :- functor(Struct,_,0),!,
				Next is Depth - 1,
				/* insert add dummy structs here and return
				   the result as New_struct */
                                al(Next,Struct,New_struct,Cur,New,_).

add(Depth,Struct,New_struct,Cur,New) :- functor(Struct,_,Arity),
				Next is Depth - 1, 
			fore(0,Arity,Struct,Next,New_struct,Cur,New,_,_).

fore(Same,Same,Struct,_,New_struct,Cur,Cur,First,Size) :- !,
						functor(Struct,Name,Arity), 
						NArity is Arity + 1,
						functor(New_struct,Name,NArity),
/*the pos of this struct is (first + cur)/2 or first depending on single
  or multiple sub structures */
						size(Name,Nsize),
					case(Same,Cur,Size,First,Pos,Nsize),
						 arg(1,New_struct,Pos).

fore(Begin,End,Struct,Cur_depth,New_struct,Cur,New,Ifst,Isize) :- 
						Count is Begin + 1,
						arg(Count,Struct,Sub),
					add(Cur_depth,Sub,Sub1,Cur,Mid),
						arg(1,Sub1,Spos),
						functor(Sub1,Name,_),
						size(Name,Nsize),
				first(Count,Spos,Isize,Nsize,Size,Ifst,First),
	fore(Count,End,Struct,Cur_depth,New_struct,Mid,New,First,Size),
						Newcount is Count + 1,
						arg(Newcount,New_struct,Sub1).

first(1,Cur,_,Size,Size,_,Cur) :-!.
first(_,_,Size,_,Size,Same,Same).

/* single or multiple subargs; if End is 1, then single, else multiple */ 

case(1,_,Size,First,Pos,Nsize) :- !,T is First + ((Size+1)/2),
				trunc(T,V), Mid is V - 1, 
				T2 is ((Nsize+1)/2) - 1,
				trunc(T2,T3),
				Pos is Mid - T3.

case(_,Cur,_,First,Pos,_) :- Temp is ((Cur - 4) + First + 1)/2,
			trunc(Temp,V), Pos is V - 1.

