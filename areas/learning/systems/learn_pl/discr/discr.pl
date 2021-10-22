/******************************************************************/
/* DISCR.PL          Last Modification: Fri Jan 14 19:22:58 1994 */
/* Brazdil's generation of discriminants from derivation trees    */
/******************************************************************/
%
%    Copyright (c) 1989 Thomas Hoppe
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
/*  impl. by    : Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1989                                            */
/*                                                                */
/*  reference   : problem 93                                      */
/*                chapter 9                                       */
/*                PROLOG by example                               */
/*                Helder Coelho, Jose' C. Cotta                   */
/*                Berlin, Heidelberg, New York                    */
/*                Springer-Verlag, 1988                           */
/*                                                                */
/*  call        : ex1, ex2                                        */
/*                                                                */
/******************************************************************/
/* One of the common errors in learning is over generalisation:   */
/* a given term Q is applicable in certain contexts instead of    */
/* failing. The purpose of the following programm is to correct   */
/* this. This can be done by computation of a discriminant, which */
/* can be used to backup from an overgeneralisation. For this     */
/* purpose we need two kind of contexts:                          */
/*                                                                */
/*    - an application context (app) in which the proof of Q      */
/*      should suceed, and                                        */
/*    - a rejection context (rej) in which the proof should fail. */
/*                                                                */
/* All clauses determining what Q is (this can be viewed as the   */
/* background knowledge) and how it is related to the contexts    */
/* (app and rej) (this can be viewed as the user-given examples)  */
/* should also be given. The expression generated which is        */
/* applicable in the application context (app) only is referred   */
/* to as discriminant, and the process of generating the          */
/* discriminat (obviously) as discrimination.                     */ 
/******************************************************************/
/* The programm assumes that clauses are represented in the       */
/* following way:                                                 */
/*                                                                */
/*      cn :: HEAD <- PRED1 & PRED2 & ..... PREDN                 */
/*                                                                */
/* where cn is a unique name for every single clause, <- denotes  */
/* implication and & denotes conjunction. PREDN can be a PROLOG   */
/* build-in predicate, which is evaluated in the normal fasion.   */
/* See discr_1.pro and discr_2.pro. Sorry I haven't yet some nice */
/* examples.                                                      */
/******************************************************************/
% TH Sat May 29 23:58:27 1993  - made some minor modifications
 
/******************************************************************/
/* SWI-, YAP-, C- and M-Prolog specific declaration of dynamical  */
/* clauses.                                                       */
/******************************************************************/
:- dynamic '::'/2.

:-op(150,yfx,::).
:-op(145,xfx,<-).
:-op(140,xfy,&).
:-op(135,xfx,:=).

/******************************************************************/
/*                                                                */
 /*  call        : derivation(+EXPRESSION,+TYP)                   */
/*                                                                */
/*  arguments   : EXPRESSION = Expression of the form P <- C      */
/*                TYPE       = context type                       */
/*                                                                */
/*  side effects: Asserting derivation trees in the database      */
/*                                                                */
/******************************************************************/
/* The generation of all possible derivation trees of an          */
/* EXPRESSION of the form P <- C, whose truth/falsity should be   */
/* established, is done with this predicate. TYPE is the context  */
/* type (app or rej).                                             */
/******************************************************************/
derivation(P<-C,TYP) :- 
     name(a1,NAME), add_context(NAME,C), 
       generate_goal_ids(P,ID1,1,I1), 
       expand_derivation(P,P2,ID1,ID2,I1::ID1,I2::DERIVATION), 
       assertz(TYP::DERIVATION), write(TYP::DERIVATION), nl, fail .
derivation(_,_) :- 
     name(a1,[N1,N2]), del_context([N1,_]) .

/******************************************************************/
/*                                                                */
/*  call        : add_context(+CLAUSENAME,+EXPRESSION)            */
/*                                                                */
/*  arguments   : CLAUSENAME = List of charaters                  */
/*                EXPRESSION = Conjunction of Facts               */
/*                                                                */
/*  side effects: Asserting contexts in the database              */
/*                                                                */
/******************************************************************/
/* The assertion of contexts is done with this predicate. CLAUSE- */
/* NAME is a list of characters of length 2, and EXPRESSION a     */
/* conjunction of Facts.                                          */
/******************************************************************/
add_context([N1,N2],P1&P2) :- 
     !, name(C,[N1,N2]), assertz(C::P1<-true), N3 is N2+1, 
       add_context([N1,N3],P2) .
add_context([N1,N2],P1) :- 
     name(C,[N1,N2]), assertz(C::P1<-true) .

/******************************************************************/
/*                                                                */
/*  call        : del_context(+CLAUSENAME)                        */
/*                                                                */
/*  arguments   : CLAUSENAME = List of charaters                  */
/*                                                                */
/*  side effects: Retracting contexts from the database           */
/*                                                                */
/******************************************************************/
/* The deletion of contexts is done with this predicate. CLAUSE-  */
/* NAME is a list of characters of length 2.                      */
/******************************************************************/
del_context([N1,N2]) :- 
     C::P1<-true, name(C,[N1,_]), retract(C::P1<-true), fail .
del_context(_) .

/******************************************************************/
/*                                                                */
/*  call        : generate_goal_ids(+GOALCONJUNCTION,             */
/*                                  -IDCONJUNCTION,               */
/*                                  +ID1,                         */
/*                                  -ID2)                         */
/*                                                                */
/*  arguments   : GOALCONJUNCTION = actual conjunction of goals   */
/*                IDCONJUNCTION   = conjunction of goal ids       */
/*                ID1             = last used id                  */
/*                ID2             = updated last used id          */
/*                                                                */
/******************************************************************/
/* Given a conjunction of goals this predicate generates goal     */
/* identifiers (integers) using the information of the last used  */
/* id and returning the last new identifier.                      */
/******************************************************************/
generate_goal_ids(P1&P2,I1&I2,I1,I4) :- 
     !, I3 is I1+1, generate_goal_ids(P2,I2,I3,I4) .
generate_goal_ids(P1,I1,I1,I4) :- 
     I4 is I1+1 .

/******************************************************************/
/*                                                                */
/*  call        : expand_derivation(+GOALCONJUNCTION1,            */
/*                                  -GOALCONJUNCTION2,            */
/*                                  +IDCONJUNCTION1,              */
/*                                  -IDCONJUNCTION2,              */
/*                                  +DERIVATION1,                 */
/*                                  -DERIVATION2)                 */
/*                                                                */
/*  arguments   : GOALCONJUNCTION1 = actual conjunction of goals  */
/*                GOALCONJUNCTION2 = reduced conjunction of goals */
/*                IDCONJUNCTION1   = actual goal id conjunction   */
/*                IDCONJUNCTION2   = reduced goal id conjunction  */
/*                DERIVATION1      = actual derivation tree       */
/*                DERIVATION2      = expanded derivation tree     */
/*                                                                */
/******************************************************************/
/* Given a conjunction of goals (GOALCONJUNCTION1), a conjunction */
/* of the corresponding goal ids (IDCONJUNCTION1) and a previous  */
/* derivation (DERIVATION1) this predicate generates the expanded */
/* derivation tree (DERIVATION2) while solving (in a backward-    */
/* chaining manner) a goal of GOALCONJUNCTION1. It returns the    */
/* still unsolved goals in GOALCONJUNCTION2 and their             */
/* corresponding goal ids in IDCONJUNCTION2. Notice, this is a    */
/* kind of PROLOG meta-interpreter, which collect the derivation  */
/* tree. Derivation tree's in the sense of this programm are      */
/* ordered, ::-connected lists.                                   */
/******************************************************************/
expand_derivation(true,true,ID1,ID1,D1,D1) :- 
     ! .
expand_derivation(true&P3,P3,ID1&ID3,ID3,D1,D1) :- 
     ! .
expand_derivation(P1&P3,P5,ID1&ID3,ID5,D1,D3) :- 
     expand_derivation_(P1,P2,ID1,ID2,D1,D2), 
       join_goals(P2&P3,P4,ID2&ID3,ID4), 
       expand_derivation(P4,P5,ID4,ID5,D2,D3) .
expand_derivation(P1,P5,ID1,ID5,D1,D3) :- 
     not P1=_&_, expand_derivation_(P1,P2,ID1,ID4,D1,D2), 
       expand_derivation(P2,P5,ID4,ID5,D2,D3) .

expand_derivation_(P1,P2,ID1,ID2,I1::D1,I2::D2) :- 
     C::P1<-P2, generate_goal_ids(P2,ID2,I1,I2), 
       D2=D1::C::ID1<-ID2 .

/******************************************************************/
/*                                                                */
/*  call        : join_goals(+GOALCONJUNCTION1,-GOALCONJUNCTION2, */
/*                           +IDCONJUNCTION1,-IDCONJUNCTION2)     */
/*                                                                */
/*  arguments   : GOALCONJUNCTION1 = actual conjunction of goals  */
/*                GOALCONJUNCTION2 = joined conjunction of goals  */
/*                IDCONJUNCTION1   = actual goal id conjunction   */
/*                IDCONJUNCTION2   = joined goal id conjunction   */
/*                                                                */
/******************************************************************/
/* The joining of goals is done by this predicate.                */
/******************************************************************/
join_goals(P1&P2&P3,P1&P5,ID1&ID3&ID3,ID1&ID5) :- 
     !, join_goals(P2&P3,P5,ID2&ID3,ID5) .
join_goals(true&P3,P3,ID1&ID3,ID3) :- 
     ! .
join_goals(P1,P1,ID1,ID1) .

/******************************************************************/
/*                                                                */
/*  call        : :=(ARG1,ARG2)                                   */
/*                                                                */
/*  arguments   : ARG1 =                                          */
/*                ARG2 =                                          */
/*                                                                */
/******************************************************************/
/* I'm sorry in the original program this was only documented as: */
/*                                                                */
/*   Predicate T1:=T2                                             */
/*                                                                */
/* so I can only speculate, what semantic this predicate has.     */
/* It seems that this is a kind of value assignment statement     */
/* (known from procedural languages), with the following          */
/* properties, if T1 matches T2 and T2 is more special than T1    */
/* (in the sense that a most general unifier exists) then match   */
/* T1 with T2. Whereas T2 is more special than T1 if T2 unifies   */
/* under skolemization with T1.                                   */ 
/******************************************************************/
T1:=T2 :- 
     not (not T1=T2), not (not spec(T1,T2)), T1=T2 .

spec(T1,T2) :- 
     ground(T2,1,_), T1=T2 .

ground(skolem_function(N1),N1,N2) :- 
     !, N2 is N1+1 .
ground(T,N1,N2) :- 
     T=..[_|TS], TS==[], ! .
ground(T,N1,N2) :- 
     T=..[_|TS], grounds(TS,N1,N2) .

grounds([T|TS],N1,N3) :- 
     ground(T,N1,N2), grounds(TS,N1,N2) .
grounds([],N1,N1) .

/******************************************************************/
/*                                                                */
/*  call        : generate_discriminants(+EXPRESSION,             */
/*                                       -DISCRIMINANT1,          */
/*                                       -DISCRIMINANT2)          */
/*                                                                */
/*  arguments   : EXPRESSION    = Expression to be specialized    */
/*                DISCRIMINANT1 =                                 */
/*                DISCRIMINANT2 =                                 */
/*                                                                */
/*  side effects: Asserting discriminants in the database         */
/*                                                                */
/******************************************************************/
/* Generates all possible discriminants an asserts them in the    */
/* database. More than one discriminant can be generated, if more */
/* the EXPRESSION is computable from more than one derivations.   */
/* See discr_2.pro for an example. All discriminants generated    */
/* should be specific enough so that they would fail in all       */
/* rejection contexts. As we can see from discr_2.pro this is not */
/* the case for the second discriminant !.                        */
/******************************************************************/
generate_discriminants(P,PA,PR) :- 
     generate_goal_ids(P,ID,1,_), 
       determine_discriminant(P::ID::P::ID,PA::IA::PR::IR), 
       assertz(disc::PA), 
       write(disc::PA), nl, fail .
generate_discriminants(_,_,_) .

determine_discriminant(PA1::IA1::PR1::IR1,P3) :- 
     not PA1=PR1, !, P3=PA1::IA1::PR1::IR1 .
determine_discriminant(true&PA3::_&IA3::true&PR3::_&IR3,P3) :- 
     !, P3=PA3::IA3::PR3::IR3 .
determine_discriminant(PA1&PA3::IA1&IA3::PR1&PR3::IR1&IR3,P3) :- 
     determine_discriminant(PA1::IA1::PR1::IR1,PA2::IA2::PR2::IR2),
       join_goals(PA2&PA3,PA5,IA2&IA3,IA5), 
       join_goals(PR2&PR3,PR5,IR2&IR3,IR5), 
       P3=PA5::IA5::PR5::IR5 .
determine_discriminant(PA1&PA3::IA1&IA3::PR1&PR3::IR1&IR3,P3) :- 
     determine_discriminant(PA3::IA3::PR3::IR3,PA4::IA4::PR4::IR4),
       P3=PA1&PA4::IA1&IA4::PR1&PR4::IR1&PR4 .
determine_discriminant(P1,P3) :- 
     not P1=_&_::_&_::_&_::_&_, 
     determine_discriminant_(P1,P2), 
     determine_discriminant(P2,P3) .

determine_discriminant_(P1,P3) :- 
     P1=PA1::IA1::PR1::IR1, CA::PA1<-PA2, app::DA, 
       in_derivation_p(CA::IA1<-IA2,DA), CR::PR1<-PR2, rej::DR, 
       in_derivation_p(CR::IR1<-IR2,DR), P3=PA2::IA2::PR2::IR2 .

in_derivation_p(X::C,DER::X::C) :- 
     ! .
in_derivation_p(X::C,DER::_) :- 
     in_derivation_p(X::C,DER) .

help :- write('Load data set with command: [Filename].'), nl.

:- help.
