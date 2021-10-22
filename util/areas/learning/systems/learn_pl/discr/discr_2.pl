ex2 :- 
     exc2, derivation(term(t1::t2)<-const(t1)&const(t2),app), 
       derivation(term(t1::t2)<-termv(t1)&termc(t2),rej), 
       generate_discriminants(term(t1::t2),_,_) .

exc2 :- 
     abolish('::',2), 
       assertz(c1::term(X)<-(X1::X2):=X&term(X1)&term(X2)), 
       assertz(c2::term(X)<-termc(X)), 
       assertz(c3::term(X)<-termv(X)), 
       assertz(c4::termc(X)<-(X1::X2):=X&termc(X1)&termc(X2)), 
       assertz(c5::termc(X)<-const(X)), 
       assertz(c6::termv(X)<-(X1::X2):=X&termv(X1)), 
       assertz(c7::termv(X)<-(X1::X2):=X&termv(X2)), 
       assertz(c8::termv(X)<-var(X)), 
       assertz((c9::X1:=X2<-true:-X1:=X2)) .

?- ex2.
