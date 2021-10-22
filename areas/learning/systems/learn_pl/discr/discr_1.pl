ex1 :- 
     exc1, derivation(q<-u&v,app), derivation(q<-w&v,rej), 
       generate_discriminants(q,_,_) .

exc1 :- 
     abolish('::',2), assertz(c1::q<-s&r), assertz(c2::s<-t), 
       assertz(c3::s<-w), assertz(c4::t<-u), assertz(c5::r<-v) .

?- ex1.
