attribute(size,[small,large]).
attribute(shape,[long,compact,other]).
attribute(holes,[none,1,2,3,many]).

example(nut,[size=small,shape=compact,holes=1]).
example(screw,[size=small,shape=long,holes=none]).
example(key,[size=small,shape=long,holes=1]).
example(nut,[size=small,shape=compact,holes=1]).
example(key,[size=large,shape=long,holes=1]).
example(screw,[size=small,shape=compact,holes=none]).
example(nut,[size=small,shape=compact,holes=1]).
example(pen,[size=large,shape=long,holes=none]).
example(scissors,[size=large,shape=long,holes=2]).
example(pen,[size=large,shape=long,holes=none]).
example(scissors,[size=large,shape=other,holes=2]).
example(key,[size=small,shape=other,holes=2]).

?- learn(nut).
?- learn(key).
?- learn(scissors).
