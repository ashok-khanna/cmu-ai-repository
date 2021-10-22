/******************************************************************/
/* testcalls for different implementation levels                  */
/******************************************************************/
test1 :- split((A < succ(succ(A)) :- B < succ(B)),Head,BodyList),
         join(Head,BodyList,Rule).
	 
test2 :- flatten((B < succ(B) :- true),K,L),
         flatten((A < succ(succ(A)) :- true),U,V).

test1(Q) :- 
	X = (mother(A,B) :- sex(A,female),parent(A,B)),
	write('Clause: '), write(X), nl, 
	Y = (grandfather(D,F) :- father(D,E),sex(E,female),parent(E,F)),
	write('Resolvent: '), write(Y), nl, 
	absorption1(X,Y,Q).

test2(Q) :- 
	X = (B < C :- succ(B,C)),
	write('Clause: '), write(X), nl, 
	Y = (A < D :- succ(A,E), succ(E,D)),
	write('Resolvent: '), write(Y), nl, 
	absorption1(X,Y,Q).

test3(Q) :- 
	X = (mother(A,B) :- sex(A,female),daugther(B,A)),
	write('Clause: '), write(X), nl, 
	Y = (grandfather(a,c) :- father(a,m),sex(m,female),daugther(c,m)),
	write('Resolvent: '), write(Y), nl, 
	absorption2(X,Y,Q).

test4(Q) :- 
	X = (B < succ(B) :- true),
	write('Clause: '), write(X), nl, 
	Y = (A < succ(succ(A)) :- true),
	write('Resolvent: '), write(Y), nl, 
	absorption2(X,Y,Q).

test5(Q) :- 
	X = (grandfather(D,E) :- father(D,F),mother(F,E)),
	write('Resolvent: '), write(X), nl, 
	Y = (grandfather(A,B) :- father(A,C),father(C,B)),
	write('Resolvent: '), write(Y), nl, 
	intra_construction1(X,Y,Q).

test6(Q) :- 
	X = (grandfather(D,E) :- father(D,F),mother(F,E)),
	write('Resolvent: '), write(X), nl, 
	Y = (grandfather(A,B) :- father(A,C),father(C,B)),
	write('Resolvent: '), write(Y), nl, 
	intra_construction2(X,Y,Q).

test7(Q) :- 
	X = (min(D,[succ(D)|E]) :- min(D,E)),
	write('Resolvent: '), write(X), nl, 
	Y = (min(F,[succ(succ(F))|G]) :- min(F,G)),
	write('Resolvent: '), write(Y), nl, 
	intra_construction2(X,Y,Q).

test8(Q) :- 
	X = (B < succ(B) :- true),
	write('Resolvent: '), write(X), nl, 
	Y = (A < succ(succ(A)) :- true),
	write('Resolvent: '), write(Y), nl, 
	intra_construction2(X,Y,Q).

