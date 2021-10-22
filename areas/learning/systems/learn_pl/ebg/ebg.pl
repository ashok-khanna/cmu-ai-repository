/******************************************************************/
/* EBG.PRO            Last Modification: Fri Jan 14 19:23:23 1994 */
/* Different meta-interpreters for Mitchell's explanation-based   */
/* generalisation and partial evaluation                          */
/******************************************************************/
%
%    Copyright (c) 1988 Thomas Hoppe
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
%    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, 
%    USA.
%
/******************************************************************/
/*  impl. by    : Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1988                                            */
/*                                                                */
/*  reference   : Explanation-Based Generalisation as Resolution  */
/*                Theorem Proving, Smadar T. Kedar-Cabelli, L.    */
/*                Thorne McCharty, Proceedings of the Fourth      */
/*                International Workshop on Machine Learning,     */
/*                Irvine, Morgan Kaufmann Publishers, California, */
/*                1987                                            */
/*                                                                */
/*                Explanation-Based Generalisation = Partial      */
/*                Evaluation, van Harmelen, F., Bundy, A.,        */
/*                Research Note, AI 36, 1988.                     */
/*                                                                */
/******************************************************************/
% TH Sun May 30 00:06:23 1993  - made some minor modifications

/* This is YAP-Prolog specific */
% :- do_not_compile_expressions.

/******************************************************************/
/*                                                                */
/*  call        : prove_1 (+GOAL)                                 */
/*                                                                */
/*  arguments   : GOAL  = instantiated goal for a proof           */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_1 implements a PROLOG meta-interpreter, which succeds if */
/* GOAL is deducible from a PROLOG program.                       */
/* In opposite to the literature the last clause is necessary to  */
/* handle PROLOG built-in predicates corret.                      */
/******************************************************************/
prove_1((HEAD,REST)) :- 
     !, prove_1(HEAD), prove_1(REST) .
prove_1(FACT) :- 
     clause(FACT,true) .
prove_1(GOAL) :- 
     clause(GOAL,PREMISSES), prove_1(PREMISSES) .
prove_1(GOAL) :- 
     call(GOAL) .

/******************************************************************/
/*                                                                */
/*  call        : prove_2 (+GOAL,-PROOF)                          */
/*                                                                */
/*  arguments   : GOAL  = instantiated goal for a proof           */
/*                PROOF = proof tree for GOAL                     */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_2 is the extention of prove_1 to deliver the PROOF for   */
/* the GOAL, if GOAL is deducible from a PROLOG program.          */
/* In opposite to the literature the last clause is necessary to  */
/* handle PROLOG built-in predicates corret.                      */
/* On backtracking it gives the next possible prove.              */
/******************************************************************/
prove_2((HEAD,REST),PROOF) :- 
     !, prove_2(HEAD,HEAD_PROOF), prove_2(REST,REST_PROOF), 
       append(HEAD_PROOF,REST_PROOF,PROOF) .
prove_2(FACT,[FACT]) :- 
     clause(FACT,true) .
prove_2(GOAL,PROOF) :- 
     clause(GOAL,PREMISSES), not(PREMISSES == true),
       prove_2(PREMISSES,PREM_PROOF), 
       append([GOAL],[PREM_PROOF],PROOF) .
prove_2(GOAL,[GOAL]) :- 
     call(GOAL) .

/******************************************************************/
/*                                                                */
/*  call        : prove_3 (+GOAL,-PROOF)                          */
/*                                                                */
/*  arguments   : GOAL  = instantiated goal for a proof           */
/*                PROOF = proof tree for GOAL                     */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_3 is an extention of prove_2 to deliver generalized      */
/* PROOFS for the GOAL, if GOAL is deducible from a pure PROLOG   */
/* program.                                                       */
/* The call 'not (not clause(FACT,true))' is a special PROLOG     */
/* trick, which succeds if 'clause(FACT,true)' holds, without     */
/* instanciating GOAL.                                            */
/* A sublist of length 1 in the PROOF denotes a fact, which has   */
/* to be instanciated to fulfill the proof.                       */
/* The first element of a list is the subtree goal.               */
/* On backtracking it gives the next possible prove path.         */
/******************************************************************/
prove_3((HEAD,REST),PROOF) :- 
     !, prove_3(HEAD,HEAD_PROOF), prove_3(REST,REST_PROOF), 
       append(HEAD_PROOF,REST_PROOF,PROOF) .
prove_3(FACT,[FACT]) :- 
     not (not clause(FACT,true)) .
prove_3(GOAL,PROOF) :- 
     clause(GOAL,PREMISSES), not(PREMISSES == true),
       prove_3(PREMISSES,PREM_PROOF), 
       append([GOAL],[PREM_PROOF],PROOF) .
prove_3(GOAL,[GOAL]) .

/******************************************************************/
/*                                                                */
/*  call        : prove_4 (+GOAL,-FACTS)                          */
/*                                                                */
/*  arguments   : GOAL  = uninstantiated goal for a proof         */
/*                FACTS = List of FACTS which must hold for a     */
/*                        proof of GOAL                           */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_4 is an extention of prove_3 to delivers the generalized */
/* FACTS that must be true for a proof of GOAL, if GOAL is        */
/* deducible from a pure PROLOG program.                          */
/* With this predicat a partial evaluation of the theory according*/
/* to the GOAL is possible                                        */
/* On backtracking it gives the next partial evaluation.          */
/******************************************************************/
prove_4((HEAD;REST),PROOF) :- 
     !, (prove_4(HEAD,PROOF); prove_4(REST,PROOF)) . 
prove_4((HEAD,REST),PROOF) :- 
     !, prove_4(HEAD,HEAD_PROOF), prove_4(REST,REST_PROOF), 
       append(HEAD_PROOF,REST_PROOF,PROOF) .
prove_4(FACT,[FACT]) :- 
     not sys(FACT), not (not clause(FACT,true)) . 
prove_4(GOAL,PROOF) :- 
     not sys(GOAL), clause(GOAL,_), !, 
     clause(GOAL,PREMISSES), not(PREMISSES == true), 
     prove_4(PREMISSES,PROOF) .
prove_4(GOAL,[GOAL]) .

/******************************************************************/
/*                                                                */
/*  call        : prove_5 (+GOAL,-PROOF,-FACTS)                   */
/*                                                                */
/*  arguments   : GOAL  = uninstantiated goal for a proof         */
/*                PROOF = proof tree for GOAL                     */
/*                FACTS = List of FACTS which must hold for a     */
/*                        proof of GOAL                           */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_5 is a combination of prove_3 and prove_4 to delivers the*/
/* generalized FACTS that must be true for a proof of GOAL and the*/
/* proof path, if GOAL is deducible from a pure PROLOG program.   */
/* So one can get the information which predicates must be        */
/* instantiated to a particular prove path.                       */
/* On backtracking it gives the next possible prove path and the  */
/* predicats that must be instanciated.                           */
/******************************************************************/
prove_5((HEAD,REST),[PROOF_HEAD|PROOF_REST],LIST) :- 
     !, prove_5(HEAD,PROOF_HEAD,PROOF_LIST1), 
       prove_5(REST,PROOF_REST,PROOF_LIST2), 
       append(PROOF_LIST1,PROOF_LIST2,LIST) .
prove_5(FACT,[FACT],[FACT]) :- 
     not (not clause(FACT,true)) .
prove_5(GOAL,[GOAL,PROOF],LIST) :- 
     clause(GOAL,PREMISSES), not(PREMISSES==true), 
       prove_5(PREMISSES,PROOF,LIST) .
prove_5(GOAL,[GOAL],[GOAL]) .

/******************************************************************/
/*                                                                */
/*  call        : prove_6 (+GOAL1,+GOAL2,-FACTS)                  */
/*                                                                */
/*  arguments   : GOAL1 = instantiated goal for a paticular proof */
/*                GOAL2 = generalized goal                        */
/*                FACTS = List of FACTS which must hold for a     */
/*                        proof of GOAL                           */
/*                                                                */
/*  properties  : backtrackable                                   */
/*                                                                */
/******************************************************************/
/* prove_6 is an extention of prove_4 to handle the operationality*/
/* criterion mentioned by Mitchell/Keller/Kedar-Cabelli (1986).   */
/* It delivers the generalized FACTS that must be true for a      */
/* paticular proof of GOAL1, if GOAL1 is deducible from a PROLOG  */
/* program.                                                       */
/* On backtracking it gives the next possible prove path.         */
/******************************************************************/
prove_6((HEAD,REST),(GEN_HEAD,GEN_REST),LIST) :- 
     !, prove_6(HEAD,GEN_HEAD,LIST1), 
       prove_6(REST,GEN_REST,LIST2), append(LIST1,LIST2,LIST) .
prove_6(GOAL,GEN_GOAL,[GEN_GOAL]) :- 
     operational(GOAL), ! .
prove_6(GOAL,GEN_GOAL,LIST) :- 
     not operational(GOAL), clause(GEN_GOAL,GEN_PREMISSES), 
       copy((GEN_GOAL:-GEN_PREMISSES),(GOAL:-PREMISSES)), 
       prove_6(PREMISSES,GEN_PREMISSES,LIST) .

/******************************************************************/
/*                                                                */
/*  call        : listify (LIST,PREMISSES)                        */
/*                                                                */
/*  arguments   : LIST      = normal PROLOG list                  */
/*                PREMISSES = normal PROLOG and-concatenated      */
/*                            premisse_list                       */
/*                                                                */
/*  properties  : backtrackable, symmetric                        */
/*                                                                */
/******************************************************************/
/* listify builds a PROLOG and-cocatenated premisse list out of   */
/* every normal list, respecively vice versa.                     */
/* One predicat must be instantiated.                             */
/******************************************************************/
listify([H],H) .
listify([H|R],(H,S)) :- 
     listify(R,S) .

/******************************************************************/
/*                                                                */
/*  call        : copy (+TERM1,-TERM2)                            */
/*                                                                */
/*  arguments   : TERM1 = normal PROLOG term                      */
/*                TERM2 = normal PROLOG term                      */
/*                                                                */
/******************************************************************/
/* copy makes copy's of every PROLOG-Term, with the special       */
/* database trick to ensure that new variables are generated in   */
/* the output term.                                               */
/******************************************************************/
copy(TERM1,TERM2) :- 
%	inst(TERM1,TERM2),
	assert(internal(TERM1)), retract(internal(TERM2)),
	! .

/******************************************************************/
/*                                                                */
/*  call        : operational (+TERM)                             */
/*                                                                */
/*  arguments   : TERM = normal PROLOG term                       */
/*                                                                */
/******************************************************************/
/* operational is an predicat for the decision of operaionality   */
/* in EBL-based algorithms. It's definition must be changed       */
/* depending on the operationality criterion's of a particular    */
/* implementation.                                                */
/* The first clause ensures that normal PROLOG facts are          */
/* operational.                                                   */
/* The second clause is a check for built-in predicats which are  */
/* not defined, but can be evaluated.                             */
/******************************************************************/
operational(A) :- 
     clause(A,true) .
operational(A) :- 
     not clause(A,_), call(A) .

/******************************************************************/
/*                                                                */
/*  call        : ebg (GOAL,RULE)                                 */
/*                                                                */
/*  arguments   : GOAL = a goal which is to be proven             */
/*                RULE = a generalized rule for the proof         */
/*                                                                */
/******************************************************************/
/* ebg is a predicate which first proves a goal to find a         */
/* solution, and afterwards it takes the solution and generates a */
/* rule out of the proof tree. The solution is returned as a      */
/* generalisation for the prove tree.                             */
/******************************************************************/

ebg(GOAL,RULE) :- 
     functor(GOAL,F,N), functor(COPY,F,N), 
     call(GOAL), prove_6(GOAL,COPY,ZWERG1), 
       listify(ZWERG1,ZWERG2), RULE = (COPY :- ZWERG2) .

help :- write('Load example theories and start EBG with command: [Filename].'),
	nl.

:- help.
