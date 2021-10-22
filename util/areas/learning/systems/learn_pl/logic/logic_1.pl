test1 :- substitution(f(g(A),B),f(g(h(a)),i(b)),ERG), write(ERG),nl.

test2 :- lgg(f(g(3),3,j(6)),f(g(2),2,j(h(6))),ERG), write(ERG),nl.

test3a :- covers([mem(3,[4,3])],[(mem(A,[A|_]) :- true),
                                 (mem(A,[_|B]) :- mem(A,B))]).

test3b :- covers([mem(3,[4,5])],[(mem(A,[A|_]) :- true),
                                 (mem(A,[_|B]) :- mem(A,B))]).

test4a :- psubsumes([(mem(A,[A|_]) :- true),(mem(B,[_|C]) :- mem(B,C))],
                    [(mem(D,[_,_|E]) :- mem(D,E))]).

test4b :- psubsumes([(mem(A,[A|_]) :- true),(mem(B,[_|C]) :- mem(B,C))],
                   [(mem(D,[_,_|E]) :- mem(D,E)),
		    (mem(D,[_,_,_|E]) :- mem(D,E))]).

test4c :- psubsumes([(mem(A,[A|_]) :- true),(mem(B,[_|C]) :- mem(B,C))],
                    [(mem(D,[_,_|E]) :- mem(X,E))]).

test4d :- psubsumes([(mem(B,[_|C]) :- mem(B,C))],
                    [(mem(D,[_,_|E]) :- mem(D,E))]).

test5 :- p_subsumes([(cuddly_pet(X) :- small(X), fluffy(X), pet(X))],
		    [(pet(X) :- cat(X)), 
		     (pet(X) :- dog(X)),
		     (small(X) :- cat(X))] ,
                    [(cuddly_pet(X) :- small(X), fluffy(X), dog(X)),
		     (cuddly_pet(X) :- fluffy(X), cat(X))]).

