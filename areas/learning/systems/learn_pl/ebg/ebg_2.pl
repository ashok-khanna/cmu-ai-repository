on(o1,o2).
isa(o1,box).
isa(o2,endtable).
color(o1,red).
color(o2,blue).
volume(o1,1).
density(o1,2).
isa(o3,box).
volume(o3,6).
density(o3,2).

save_to_stack(X,Y) :- lighter(X,Y).
weight(O,W) :- volume(O,V), density(O,D), W is V * D.
lighter(O1,O2) :- weight(O1,W1), weight(O2,W2), W1 < W2.
weight(O,5) :- isa(O,endtable).

?- ( ebg(save_to_stack(o1,o2),L),
     write(L), fail
   ; true ).

