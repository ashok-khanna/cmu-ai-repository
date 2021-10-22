/******************************************************************/
/* VS.PRO             Last Modification: Fri Jan 14 19:28:27 1994 */
/* Mitchell's bi-directional search strategy in the version space */
/******************************************************************/
%
%    Copyright (c) 1988 Luc De Raedt
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
/* impl. by     : Luc De Raedt, Katholieke Universiteit Leuven,   */
/*                Department of Computer Science,                 */
/*                Celestijnenlaan 200A,                           */
/*                B-3030 Heverlee,                                */
/*                Belgium                                         */
/*                E-Mail: lucdr@kulcs.uucp or lucdr@kulcs.bitnet  */
/*                1988                                            */
/*                                                                */
/*  reference   : ES2ML Tutorial Exercise                         */
/*                Version Space Algorithm                         */
/*                Luc De Raedt                                    */
/*                                                                */
/*                Generalization as Search,                       */
/*                Tom M. Mitchell,                                */
/*                Artificial Intelligence  18, 1982.              */
/*                                                                */
/*  call        : learn                                           */
/*                                                                */
/******************************************************************/
/* THIS VERSION LEARNS CONJUNCTIONS AND CONSTRUCTS EXAMPLES       */
/* FOR A SIMPLE ATTRIBUTE-VALUED GENERALISATION LANGUAGE          */
/*                                                                */
/* LEARN will learn a concept, it needs only one example it will  */
/* ask for the classification of further examples, which it will  */
/* construct itself. The first example must be a list of          */
/* attributes.                                                    */
/******************************************************************/
learn :-
        writeln('First positive example ?'),
        read(POS_EX),
        nl,
        initialize(POS_EX,G,S),
        versionspace(G,S).
 
/******************************************************************/
/*                                                                */
/*  call        : versionspace (+G_SET,+S_SET)                    */
/*                                                                */
/*  arguments   : G_SET = Set of most general concepts            */
/*                S_SET = Set of most special concepts            */
/*                                                                */
/*  side effects: terminal-I/O                                    */
/*                                                                */
/******************************************************************/
/* VERSIONSPACE succeeds if there is a consistent concept, which  */
/* is in the versionspace between g and s it will ask for the     */
/* classification of examples, which it generates.                */
/******************************************************************/
versionspace([],_) :-
     writeln('There is no consistent concept description in this language !'),
      !.
versionspace(_,[]) :-
     writeln('There is no consistent concept description in this language !'),
        !.
versionspace([CONCEPT],[CONCEPT]) :-
        ! ,
        writeln('The consistent generalization is : '),
        writeln(CONCEPT).
versionspace(G,S) :-
        writeln('The G-set is : '),
        writeln(G),
        writeln('The S-set is : '),
        writeln(S),
        nl,
        writeln('Next example :'),
        generate_ex(G,S,NEXT_EX),
        ! ,
        writeln(NEXT_EX),
        writeln('Classification of the example ? [p/n]'),
        read(CLASS),
        nl,
        adjust_versionspace(CLASS,NEXT_EX,G,S,NG,NS),
        versionspace(NG,NS).
versionspace(G,S) :-
        writeln('Impossible to generate relevant examples').
  
/******************************************************************/
/*                                                                */
/*  call        : adjust_versionspace(+CLASSIFICATION,            */
/*                                    +EXAMPLE,                   */
/*                                    +G_SET,                     */
/*                                    +S_SET,                     */
/*                                    -UPDATED_S_SET,             */
/*                                    -UPDATED_G_SET)             */
/*                                                                */
/*  arguments   : CLASSIFICATION = of the example p for positive  */
/*                                 or n for negative              */
/*                EXAMPLE        = the example itself             */
/*                G_SET          = the actual G-set               */
/*                S_SET          = the actual S-set               */
/*                UPDATED_G_SET  = the updated G-set              */
/*                UPDATED_S_SET  = the updated S-set              */
/*                                                                */
/******************************************************************/
/* ADJUST_VERSIONSPACE succeeds if UPDATED_G_SET and UPDATED_S_SET*/
/* specify the updated versionspace of G_SET and S_SET wrt EXAMPLE*/
/* and CLASSIFICATION.                                            */
/******************************************************************/
adjust_versionspace(p,EX,G,S,NG,NS) :-
        retain_g(G,NG,EX),
        generalize_s(S,S1,NG,EX),
        prune_s(S1,NS).
adjust_versionspace(n,EX,G,S,NG,NS) :-
        retain_s(S,NS,EX),
        specialize_g(G,G1,NS,EX),
        prune_g(G1,NG).
 
/******************************************************************/
/*                                                                */
/*  call        : retain_g(+G_SET,-UPDATED_G_SET,+EXAMPLE)        */
/*                                                                */
/*  arguments   : G_SET          = the actual G-set               */
/*                UPDATED_G_SET  = the updated G-set              */
/*                EXAMPLE        = the example itself             */
/*                                                                */
/******************************************************************/
/* RETAIN_G succeeds if UPDATED_G_SET lists the elements of G_SET */
/* which cover the EXAMPLE                                        */
/******************************************************************/
retain_g([],[],_) :- ! .
retain_g([CONCEPT|G],[CONCEPT|NG],EX) :-
        covers(CONCEPT,EX),
        ! ,
        retain_g(G,NG,EX).
retain_g([CONCEPT|G],NG,EX) :-
        retain_g(G,NG,EX).
 
/******************************************************************/
/*                                                                */
/*  call        : retain_s(+S_SET,-UPDATED_S_SET,+EXAMPLE)        */
/*                                                                */
/*  arguments   : S_SET          = the actual S-set               */
/*                UPDATED_S_SET  = the updated S-set              */
/*                EXAMPLE        = the example itself             */
/*                                                                */
/******************************************************************/
/* RETAIN_S succeeds if UPDATED_S_SET lists the elements of S_SET */
/* which do not cover the EXAMPLE                                 */
/******************************************************************/
retain_s([],[],_) :- ! .
retain_s([CONCEPT|S],[CONCEPT|NS],EX) :-
        not covers(CONCEPT,EX),
        !,
        retain_s(S,NS,EX).
retain_s([CONCEPT|S],NS,EX) :-
        retain_s(S,NS,EX).
 
/******************************************************************/
/*                                                                */
/*  call        : generalize_s(+S_SET,-UPDATED_S_SET,             */
/*                             +G_SET,+EXAMPLE)                   */
/*                                                                */
/*  arguments   : S_SET          = the actual S-set               */
/*                UPDATED_S_SET  = the updated S-set              */
/*                G_SET          = the actual G-set               */
/*                EXAMPLE        = the example itself             */
/*                                                                */
/******************************************************************/
/* GENERALIZE_S succeeds if UPDATED_S_SET lists the minimal       */
/* generalizations of the elements in S_SET wrt EXAMPLE such that */
/* there is an element in G_SET which is more general.            */
/******************************************************************/
generalize_s(S,NS,NG,EX) :-
   setofnil(NCON,CON^(member(CON,S),
   valid_least_generalization(CON,EX,NCON,NG)),NS) .
 
/******************************************************************/
/*                                                                */
/*  call        : generalize_g(+G_SET,-UPDATED_G_SET,             */
/*                             +S_SET,+EXAMPLE)                   */
/*                                                                */
/*  arguments   : G_SET          = the actual G-set               */
/*                UPDATED_G_SET  = the updated G-set              */
/*                S_SET          = the actual S-set               */
/*                EXAMPLE        = the example itself             */
/*                                                                */
/******************************************************************/
/* GENERALIZE_G succeeds if UPDATED_G_SET lists the greatest      */
/* specializations of the elements in G_SET wrt EXAMPLE such that */
/* there is an element in S_SET which is more specific.           */
/******************************************************************/
specialize_g(G,NG,NS,EX) :-
        setofnil(NCONCEPT,CONCEPT^(member(CONCEPT,G),
        valid_greatest_specialization(CONCEPT,EX,NCONCEPT,NS)),NG) .
 
/******************************************************************/
/*                                                                */
/*  call        : valid_least_generalization(+CONCEPT,+EXAMPLE,   */
/*                                           -GENERALIZATION,     */
/*                                           +G_SET)              */
/*                                                                */
/*  arguments   : CONCEPT        = concept description            */
/*                EXAMPLE        = the example itself             */
/*                GENERALIZATION = a new generalization           */
/*                G_SET          = the actual G-set               */
/*                                                                */
/******************************************************************/
/* VALID_LEAST_GENERALIZATION succeeds if GENERALIZATION is a     */
/* least generalization of EXAMPLE and CONCEPT such that there is */
/* an element in G_SET which is more general than GENERALIZATION  */
/******************************************************************/
valid_least_generalization(CONCEPT,EX,NCONCEPT,NG) :-
        least_generalization(CONCEPT,EX,NCONCEPT),
        member(GENERAL,NG),
        more_general(GENERAL,NCONCEPT).
 
/******************************************************************/
/*                                                                */
/*  call        : valid_greatest_specialization(+CONCEPT,+EXAMPLE,*/
/*                                              -SPECIALIZATION,  */
/*                                              +S_SET)           */
/*                                                                */
/*  arguments   : CONCEPT        = concept description            */
/*                EXAMPLE        = the example itself             */
/*                SPECIALIZATION = a new specialization           */
/*                S_SET          = the actual S-set               */
/*                                                                */
/******************************************************************/
/* VALID_GREATEST_SPECIALIZATION succeeds if SPECIALIZATION is a  */
/* greatest specialization of CONCEPT wrt EXAMPLE such that there */
/* is an element in S_SET which is more specific than             */
/* SPECIALIZATION                                                 */
/******************************************************************/
valid_greatest_specialization(CONCEPT,EX,NCONCEPT,NS) :-
        greatest_specialization(CONCEPT,EX,NCONCEPT),
        member(SPECIFIC,NS),
        more_general(NCONCEPT,SPECIFIC).

/******************************************************************/
/*                                                                */
/*  call        : prune_s(+S_SET,-PRUNED_S_SET)                   */
/*                                                                */
/*  arguments   : S_SET          = the actual S-set               */
/*                PRUNED_S_SET   = the pruned S-set               */
/*                                                                */
/******************************************************************/
/* PRUNE_S succeeds if PRUNED_S_SET is the set of non-redundant   */
/* elements in S_SET. An element is non-redundant if there is no  */
/* element in S_SET which is more specific. PRUNE_S using an      */
/* accumulating parameter to store intermediate results.          */
/******************************************************************/
prune_s(S,NS) :-
        prune_s_acc(S,S,NS).
prune_s_acc([],_,[]) :- ! .
prune_s_acc([SPECIFIC|S],ACC,NS) :-
        member(SPECIFIC1,ACC),
        not(SPECIFIC1 == SPECIFIC),
        more_general(SPECIFIC,SPECIFIC1 ),
        ! ,
        prune_s_acc(S,ACC,NS).
prune_s_acc([SPECIFIC|S],ACC,[SPECIFIC|NS]) :-
        prune_s_acc(S,ACC,NS).
 
/******************************************************************/
/*                                                                */
/*  call        : prune_s(+G_SET,-PRUNED_G_SET)                   */
/*                                                                */
/*  arguments   : G_SET          = the actual G-set               */
/*                PRUNED_G_SET   = the pruned G-set               */
/*                                                                */
/******************************************************************/
/* PRUNE_G succeeds if PRUNED_G_SET is the set of non-redundant   */
/* elements in G_SET an element is non-redundant if there is no   */
/* element in G_SET which is more general. PRUNE_G using an       */
/* accumulating parameter to store intermediate results.          */
/******************************************************************/
prune_g(G,NG) :-
        prune_g_acc(G,G,NG).
prune_g_acc([],_,[]) :- ! .
prune_g_acc([GENERAL|G],ACC,NG) :-
        member(GENERAL1,ACC),
        not(GENERAL == GENERAL1),
        more_general(GENERAL1,GENERAL),
        ! ,
        prune_g_acc(G,ACC,NG).
prune_g_acc([GENERAL|G],ACC,[GENERAL|NG]) :-
        prune_g_acc(G,ACC,NG).
 
/******************************************************************/
/* GENERATION OF EXAMPLES                                         */
/******************************************************************/
/*                                                                */
/*  call        : allcovers(+CONCEPT_LIST,+EXAMPLE)               */
/*                                                                */
/*  arguments   : CONCEPT_LIST = list of concepts                 */
/*                EXAMPLE      = the actual example               */
/*                                                                */
/******************************************************************/
/* ALLCOVERS succeeds if all elements of CONCEPT_LIST cover       */
/* EXAMPLE                                                        */
/******************************************************************/
allcovers([],_) :- ! .
allcovers([CON|REST],EX) :-
        covers(CON,EX),
        allcovers(REST,EX).
 
/******************************************************************/
/*                                                                */
/*  call        : generate_ex(+G_SET,+S_SET,+EXAMPLE)             */
/*                                                                */
/*  arguments   : G_SET   = the actual G-set                      */
/*                S_SET   = the actual S-set                      */
/*                EXAMPLE = the actual example                    */
/*                                                                */
/******************************************************************/
/* GENERATE_EX succeeds if EXAMPLE is a relevant example. A       */
/* relevant example is one whose classification cannot be derived */
/* from s and g                                                   */
/******************************************************************/
generate_ex([GENERAL|G],S,EX) :-
        find_ex(GENERAL,EX),
        not allcovers(S,EX).
generate_ex([GENERAL|G],S,EX) :-
        generate_ex(G,S,EX).
 
/******************************************************************/
/*                                                                */
/*  call        : find_ex(+CONCEPT,+EXAMPLE)                      */
/*                                                                */
/*  arguments   : CONCEPT = general concept                       */
/*                EXAMPLE = the actual example                    */
/*                                                                */
/******************************************************************/
/* FIND_EX succeeds if EXAMPLE is an example in the language of   */
/* the versionspace such that it is covered by the element in     */
/* EXAMPLE.                                                       */
/******************************************************************/
find_ex([],[]) :- ! .
find_ex([GENERAL|G],[LEAF|EX]) :-
        isa(LEAF,GENERAL),
        leaf(LEAF),
        find_ex(G,EX).
 
/******************************************************************/
/* LANGUAGE DEPENDENT PREDICATES                                  */
/******************************************************************/
/*                                                                */
/*  call        : initialize(+EXAMPLE,-G_SET,-S_SET)              */
/*                                                                */
/*  arguments   : EXAMPLE = the positive example                  */
/*                G_SET   = initial G-set                         */
/*                S_SET   = initial S-set                         */
/*                                                                */
/******************************************************************/
/* INITIALIZE succeeds if G_SET is the g-set and S_SET is the     */
/* s-set derived from the positive example                        */
/******************************************************************/
initialize(POS_EX,[TOP],[POS_EX])  :-
        max(TOP,POS_EX).
 
/******************************************************************/
/*                                                                */
/*  call        : covers(+CONCEPT,+EXAMPLE)                       */
/*                                                                */
/*  arguments   : CONCEPT = concept description                   */
/*                EXAMPLE = example                               */
/*                                                                */
/******************************************************************/
/* COVERS succeeds if CONCEPT covers EXAMPLE                      */
/******************************************************************/
covers([],[]) .
covers([C|CONCEPT],[E|EXAMPLE]) :-
        isa(E,C),
        covers(CONCEPT,EXAMPLE).
 
/******************************************************************/
/*                                                                */
/*  call        : least_generalization(+CONCEPT1,+EXAMPLE,        */
/*                                     -CONCEPT2)                 */
/*                                                                */
/*  arguments   : CONCEPT1 = concept description                  */
/*                EXAMPLE  = example                              */
/*                CONCEPT2 = concept description                  */
/*                                                                */
/******************************************************************/
/* LEAST_GENERALIZATION succeeds if CONCEPT2 is the least         */
/* generalization of CONCEPT1 and CONCEPT2                        */
/******************************************************************/
least_generalization([],[],[]) .
least_generalization([CONCEPT|C],[EX|E],[NCONCEPT|N]) :-
        lge(CONCEPT,EX,NCONCEPT),
        least_generalization(C,E,N).
 
/******************************************************************/
/*                                                                */
/*  call        : greatest_specialization(+CONCEPT1,+EXAMPLE,     */
/*                                        -CONCEPT2)              */
/*                                                                */
/*  arguments   : CONCEPT1 = concept description                  */
/*                EXAMPLE  = example                              */
/*                CONCEPT2 = concept description                  */
/*                                                                */
/******************************************************************/
/* GREATEST_SPECIALIZATION succeeds if CONCEPT2 is the greatest   */
/* specialization of CONCEPT1 and CONCEPT2                        */
/******************************************************************/
greatest_specialization([CONCEPT|C],[EX|E],[NCONCEPT|C]) :-
        gsp(CONCEPT,EX,NCONCEPT).
greatest_specialization([CONCEPT|C],[EX|E],[CONCEPT|N]) :-
        greatest_specialization(C,E,N).

/******************************************************************/
/*                                                                */
/*  call        : more_general(+CONCEPT1,+CONCEPT2)               */
/*                                                                */
/*  arguments   : CONCEPT1 = concept description                  */
/*                CONCEPT2 = concept description                  */
/*                                                                */
/******************************************************************/
/* MORE_GENERAL succeeds if CONCEPT1 is more general than CONCEPT2*/
/******************************************************************/
more_general(CONCEPT1,CONCEPT2) :-
        covers(CONCEPT1,CONCEPT2).
 
/******************************************************************/
/* APPLICATION DEPENDENT PREDICATES                               */
/******************************************************************/
/*                                                                */
/*  call        : max(+CONCEPT,+EXAMPLE)                          */
/*                                                                */
/*  arguments   : CONCEPT = concept description                   */
/*                EXAMPLE = example                               */
/*                                                                */
/******************************************************************/
/* MAX succeeds if CONCEPT is a most general concept description  */ 
/* which covers EXAMPLE                                           */
/******************************************************************/
max([],[]) :- ! .
max([TOP|T],[EX|E]) :-
        top(TOP,EX),
        max(T,E).
 
/******************************************************************/
/*                                                                */
/*  call        : top(+CONCEPT,+EXAMPLE)                          */
/*                                                                */
/*  arguments   : CONCEPT = concept description                   */
/*                EXAMPLE = example                               */
/*                                                                */
/******************************************************************/
/* TOP succeeds if CONCEPT is a most general concept description  */
/* which covers EXAMPLE in a taxonomy                             */
/******************************************************************/
top(TOP,EX) :-
        isa(EX,TOP),
        not son(TOP,Z).
 
/******************************************************************/
/*                                                                */
/*  call        : leaf(+X)                                        */
/*                                                                */
/*  arguments   : X = leaf of a taxonomy                          */
/*                                                                */
/******************************************************************/
/* LEAF succeeds if X is a leaf in the taxonomy                   */
/******************************************************************/
leaf(X) :- 
 	not son(Y,X).

/******************************************************************/
/*                                                                */
/*  call        : isa(X,Y)                                        */
/*                                                                */
/*  arguments   : X = knot of a taxonomy                          */
/*                Y = knot of a taxonomy                          */
/*                                                                */
/******************************************************************/
/* Inheritance                                                    */
/******************************************************************/
isa(X,X) .
isa(X,Y) :-
        son(X,Z),
        isa(Z,Y).
 
/******************************************************************/
/*                                                                */
/*  call        : lge(X,Y,Z)                                      */
/*                                                                */
/*  arguments   : X = knot of a taxonomy                          */
/*                Y = knot of a taxonomy                          */
/*                Z = knot of a taxonomy                          */
/*                                                                */
/******************************************************************/
/* LGE succeeds if Z is least generalization of X and Y in a      */
/* taxonomy.                                                      */
/******************************************************************/
lge(X1,X2,X1) :-
        isa(X2,X1),
        ! .
 
lge(X1,X2,L) :-
        son(X1,F),
        lge(F,X2,L).
 
/******************************************************************/
/*                                                                */
/*  call        : gsp(X,Y,Z)                                      */
/*                                                                */
/*  arguments   : X = knot of a taxonomy                          */
/*                Y = knot of a taxonomy                          */
/*                Z = knot of a taxonomy                          */
/*                                                                */
/******************************************************************/
/* GSP succeeds if Z is greatest specialization of X and Y in a   */
/* taxonomy.                                                      */
/******************************************************************/
gsp(X1,X2,X1) :-
        not isa(X2,X1),
        ! .
 
gsp(X1,X2,G) :-
        son(S,X1),
        gsp(S,X2,G).
 
/******************************************************************/
/* UTILITIES : comments are trivial                               */
/******************************************************************/
writeln(X) :-
        display(X),
        nl.
 
member(X,[X|Y]).
member(X,[Y|Z]) :-
        member(X,Z).
 
append([],X,X).
append([X|Y],Z,[X|W]) :-
        append(Y,Z,W).
 
/******************************************************************/
/*                                                                */
/*  call        : setofnil(-X,+Y,-Z)                              */
/*                                                                */
/*  arguments   : X = variable                                    */
/*                Y = relational expression                       */
/*                Z = list                                        */
/*                                                                */
/******************************************************************/
/* SETOFNIL succeeds if Z lists all possible instantiations of X  */
/* for which Y is true. A^B means existential quantification.     */
/******************************************************************/
setofnil(X,Y,Z) :-
        setof(X,Y,Z),
        ! .
setofnil(X,Y,[]).
 
help :- write(' Start VS with command: learn.'), nl.

:- help.
