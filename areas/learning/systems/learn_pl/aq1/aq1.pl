/******************************************************************/
/* aq1.pro            Last modification: Fri Jan 14 19:30:51 1994 */
/* Becker's implementation of AQ in Prolog                        */
/******************************************************************/
%
%    Copyright (c) 1985 Jeffrey M. Becker
%
/******************************************************************/
/*  reimpl. by  : Thomas Hoppe                                    */
/*                Mommsenstr. 50                                  */
/*                D-10629 Berlin                                  */
/*                F.R.G.                                          */
/*                E-Mail: hoppet@cs.tu-berlin.de                  */
/*                1986                                            */
/*                                                                */
/*  reference   : AQ-PROLOG: A Prolog Implementation of an        */
/*                Attribute-Based Learning System, Becker, J.M.,  */
/*                Reports of the Intelligent Systems Group,       */
/*                Department of Computer Science, University of   */
/*                Illinois at Urbana-Champaign, Report Number     */
/*                ISG 85-1, January 1985                          */
/*                                                                */
/*                Learning from Observation: Conceptual Clustering*/
/*                Michalski, R.S., Stepp, R.E., in: Machine       */
/*                Learning, Michalski, R.S., Carbonell, J.G.,     */
/*                Mitchell, T.M. (eds.), Tioga Publishing         */
/*                Company, Palo Alto, 1983.                       */
/*                                                                */
/*                Inductive Learning, Michalski, R.S., in: Machine*/
/*                Learning, Michalski, R.S., Carbonell, J.G.,     */
/*                Mitchell, T.M. (eds.), Tioga Publishing         */
/*                Company, Palo Alto, 1983.                       */
/*                                                                */
/* Update	: The clause parent contained a typing error.     */
/*		  Now its correct. Thanks to Werner Emde.         */
/*                                                                */
/*                TH: Made some minor modification                */
/*                                                                */
/******************************************************************/
/* Because the program as a size about 22k, this version is       */
/* nearly undocumented, only the top-level procedures and some    */
/* very special changes against the report are documented.        */
/* For a detailed documentation consult the report.               */
/*                                                                */
/* In general the following changes are implemented:              */
/*                                                                */
/*  - The top-level Routines are modified slightly.               */
/*  - Ambique named predicates are renamed.                       */
/*  - Some special UNSW-PROLOG predicates are removed.            */
/*  - Dependant on the 'bagof' predicate some cut's were necessary*/
/*  - Some ambiguity concerning atom comparision was removed.     */
/*  - The unused predicat 'pos_cover_or_events' was removed.      */
/*                                                                */
/* In the whole programm a destinction between < and @<, > and @> */
/* etc. was introduced, which originates in DEC-10 PROLOG.        */
/* The <,>,=< and >= rever to arithmetric comparisions whereas    */
/* @<,@>,@=< and @>= rever to comparisions of atoms. Dependant on */
/* you're local PROLOG system you have eventually to introduce    */
/* them.                                                          */
/******************************************************************/

:- op(700,xfx,'..').

/******************************************************************/
/*                                                                */
/*  call        : data (+FILENAME)                                */
/*                                                                */
/*  arguments   : FILENAME = dependent on you're local PROLOG     */
/*                                                                */
/*  side effects: Removes a previous loaded dataset               */
/*                                                                */
/******************************************************************/
/* Reads a dataset from the filesystem.                           */
/******************************************************************/

data(FILENAME) :- 
     clear, nl, write('===> loading '), write(FILENAME), nl, 
       see(FILENAME), repeat, 
          read(X), 
         (X = end_of_file, seen, asserta(dataset(FILENAME)), !;
          process(X), fail) .

process(domaintype(ATTR,D)) :- 
     assertz(domaintype(ATTR,D)), ! .
process(valueset(ATTR,VALSET)) :- 
     qsort(VALSET,VALS), assertz(valueset(ATTR,VALS)), ! .
process(range(ATTR,LOW,HIGH)) :- 
     assertz(range(ATTR,LOW,HIGH)), assertz(subtyp(ATTR,integer)), 
       ! .
process(order(ATTR,ORD)) :- 
     length(ORD,HIGH), assertz(order(ATTR,ORD)), 
       assertz(range(ATTR,1,HIGH)), 
       assertz(subtyp(ATTR,symbolic)), ! .
process(structure(ATTR,STRUC)) :- 
     explodestruc(ATTR,STRUC), assertz(structure(ATTR,STRUC)), ! .
process(classes(CLIST)) :- 
     storeclasses(CLIST), ! .
process(events(CLASS,EVENTLIST)) :- 
     encodeevents(EVENTLIST,ENCODEDEVENTS), 
       storeevents(CLASS,ENCODEDEVENTS), ! .
process(X) :- 
     write('===> Invalid Data: '), nl, write(X), ! .

storeclasses(CLIST) :- 
     member(CLASSNAME,CLIST), assertz(class(CLASSNAME)), fail .
storeclasses(_) .

storeevents(CLASS,EVENTLIST) :- 
     member(EVENT,EVENTLIST), assertz(event(CLASS,EVENT)), fail .
storeevents(_,_) .

/******************************************************************/
/*                                                                */
/*  call        : clear                                           */
/*                                                                */
/******************************************************************/
/* Erases the actual dataset.                                     */
/******************************************************************/

clear :- 
     clause(dataset(X),true), abolish(domaintype,2), 
       abolish(valueset,2), abolish(range,3), abolish(order,2), 
       abolish(structure,2), abolish(class,1), abolish(event,2), 
       abolish(subtyp,2), abolish(ancest,3), nl, write('===> Data '), 
       write(X), write(' deleted.'), nl, abolish(dataset,1) .
clear .

/******************************************************************/
/*                                                                */
/*  call        : listdata                                        */
/*                                                                */
/******************************************************************/
/* Display's the actual dataset                                   */
/******************************************************************/

listdata :- 
     nl, clause(dataset(DATA_SET_NAME),true), 
       write('===> Datenset '), write(DATA_SET_NAME), 
       write(:), nl, printdomaininfo, nl, printevents, ! .

printdomaininfo :- 
     clause(domaintype(VAR,DTYPE),true), 
       write('===> Variable '), write(VAR), 
       write(' of type '), write(DTYPE), write('.'), nl, 
       fail .
printdomaininfo .

printevents :- 
     clause(class(CLASS),true), clause(event(CLASS,EVENT),true), 
       printcomplex(EVENT), write(' ::> '), write(CLASS), nl, 
       fail .
printevents .

/******************************************************************/
/*                                                                */
/*  call        : start                                           */
/*                                                                */
/******************************************************************/
/* Start is the top-level loop of AQ-PROLOG. AQ can compute in    */
/* three different modes ic: Intersecting Covers, dc: Disjoint    */
/* Covers and vl: VL mode (a sequential  one).                    */
/******************************************************************/

start :- 
     nl, 
       write('===> Maximal number of Stars in the next run ?'), 
       nl, read(MAX_STAR), nl, nl, repeat, 
       write('===> Which mode in the next run ?'), nl, nl, 
       write('      ic: Intersecting Covers'), nl, 
       write('      dc: Disjoint Covers'), nl, 
       write('      vl: VL mode (sequential)'), nl, 
       read(MODE), nl, abolish(cover,2), nl, 
       makecovers(MODE,MAX_STAR), showcovers, nl, nl, nl, 
       write('===> You wanna try a different mode (yes,no) ?'), 
       nl, read(RETRY), nl, RETRY==no, write('===> OK'), nl, ! .

makecovers(ic,MAX_STAR) :- 
     clause(class(CLASS),true), posevents(CLASS,EPOS), 
       negevents(CLASS,ENEG), 
       aq(EPOS,ENEG,EPOS,EPOS,MAX_STAR,[[]],COVER), 
       storecover(CLASS,COVER), fail .
makecovers(ic,_) :- 
     ! .
makecovers(dc,MAX_STAR) :- 
     clause(class(CLASS),true), posevents(CLASS,EPOS), 
       neg_cover_or_events(CLASS,ENEG), 
       aq(EPOS,ENEG,EPOS,EPOS,MAX_STAR,[[]],COVER), 
       storecover(CLASS,COVER), fail .
makecovers(dc,_) :- 
     ! .
makecovers(vl,MAX_STAR) :- 
     clause(class(CLASS),true), posevents(CLASS,EPOS), 
       followingevents(CLASS,ENEG), 
       aq(EPOS,ENEG,EPOS,EPOS,MAX_STAR,[[]],COVER), 
       storecover(CLASS,COVER), fail .
makecovers(vl,_) :- 
     ! .
makecovers(X,_) :- 
     nl, write('===> ERROR - only the modes ic, dc or vl'), 
       write(' are valid !'), nl, fail .

storecover(CLASS,COVER) :- 
     member(COMPLEX,COVER), assertz(cover(CLASS,COMPLEX)), fail .
storecover(_,_) .

posevents(CLASS,EPOS) :- 
     findset(EVENT,clause(event(CLASS,EVENT),true),EPOS), ! .

negevents(CLASS,ENEG) :- 
     findset(EVENT,negevent(CLASS,EVENT),ENEG), ! .

negevent(CLASS,EVENT) :- 
     clause(event(NEG_CLASS,EVENT),true), not(NEG_CLASS=CLASS) .

cover_or_event(CLASS,COMP) :- 
     clause(cover(CLASS,COMP),true) .
cover_or_event(CLASS,COMP) :- 
     clause(event(CLASS,COMP),true) .

/******************************************************************/
/* Against the AQ-PROLOG document the cut in neg_cover_or_events  */
/* is necessary to prevent backtracking, when the first clause of */
/* makecovers fails.                                              */
/******************************************************************/

neg_cover_or_events(CLASS,NEG_COMPS) :- 
     findset(COMP,negcomp(CLASS,COMP),NEG_COMPS), ! .

negcomp(CLASS,COMP) :- 
     cover_or_event(NEG_CLASS,COMP), not(NEG_CLASS=CLASS) .

/******************************************************************/
/* Watch out, this is the only occurence of 'bagof' for a correct */
/* instantiation of CLASSES to an unmodified ordering see the     */
/* discussion of 'bagof' below.                                   */
/******************************************************************/

followingevents(CLASS,SEVENTS) :- 
     bagof(CLASS_NAME,clause(class(CLASS_NAME),true),CLASSES), 
       following(CLASS,CLASSES,FCLASSES), 
       findset(EVENT,followev(FCLASSES,EVENT),SEVENTS), ! .

followev(FCLASSES,EVENT) :- 
     member(CLASS,FCLASSES), clause(event(CLASS,EVENT),true) .

aq(_,_,[],_,_,_,[]) :- 
     ! .
aq(ELIST,FLIST,UN_COVERED,[],MAX_STAR,BOUND,RESULT) :- 
     write('===> Please wait a moment ...'), nl, !, 
       aq(ELIST,FLIST,UN_COVERED,UN_COVERED,MAX_STAR,BOUND,RESULT
           ) .
aq(ELIST,FLIST,UN_COVERED,SEED_LIST,MAX_STAR,BOUND,[BEST|COVER]) :- 
     !, first(SEED_LIST,SEED), 
       star(SEED,FLIST,MAX_STAR,[ELIST,UN_COVERED],BOUND,STAR), 
       lef(LEF), 
       selectbest(STAR,1,LEF,[ELIST,UN_COVERED],[BEST_COMP]), 
       coveredbycomplex(BEST_COMP,UN_COVERED,COVERED_EVENTS), 
       trim(BEST_COMP,COVERED_EVENTS,BEST), 
       knockout1(BEST,UN_COVERED,NEW_UN_COVERED), 
       knockout(STAR,SEED_LIST,NEW_SEED_LIST), 
       aq(ELIST,FLIST,NEW_UN_COVERED,NEW_SEED_LIST,MAX_STAR,BOUND
           ,COVER), ! .

/******************************************************************/
/* I'am not sure if the last cut in aq is necessary, but it works */
/* correctly with it.                                             */
/******************************************************************/

star(_,[],_,_,PSTAR,PSTAR) :- 
     ! .
star(E,[F|FTAIL],MAX_STAR,LEF_ARGS,PSTAR,NEW_PSTAR) :- 
     !, extendagainst(E,F,ESTAR), multiply(PSTAR,ESTAR,F,EP_STAR), 
       absorb(EP_STAR,MAX_STAR,AP_STAR), 
       lef(LEF), 
       selectbest(AP_STAR,MAX_STAR,LEF,LEF_ARGS,REDUCED_STAR), 
       star(E,FTAIL,MAX_STAR,LEF_ARGS,REDUCED_STAR,NEW_PSTAR) .

multiply(COM_SET,PSTAR,NEG_EVENT,EP_STAR) :- 
     findset(NEW_COMPS,(member(COMP,COM_SET),dis_or_mult(COMP,
         PSTAR,NEG_EVENT,NEW_COMPS)),EP_LIST), 
       appendx(EP_LIST,EP_STAR), ! .

/******************************************************************/
/* DIS_OR_MULT was introduced, because in AQ-PROLOG the definition*/
/* of multiply is heavily dependant on UNSW-PROLOG. The definition*/
/* serves the purpose of a substitution for the '->' operator,    */
/* which seems to be the IF-THEN-ELSE definition in UNSW-PROLOG.  */
/******************************************************************/

dis_or_mult(COMP,_,NEG,ERG) :- 
     disjointcomps(COMP,NEG), ERG=[COMP], ! .
dis_or_mult(COMP,PSTAR,_,NEW) :- 
     findset(A,(member(P,PSTAR),product(COMP,P,A)),NEW), ! .

absorb(STAR,MAX_STAR,ASTAR) :- 
     length(STAR,N), N>MAX_STAR, !, absourbr(STAR,[],STAR1), 
       absourbr(STAR1,[],ASTAR) .
absorb(STAR,_,STAR) .

absourbr([],S,S) :- 
     ! .
absourbr([C|S],B,AR_STAR) :- 
     !, knockout1(C,S,RS), absourbr(RS,[C|B],AR_STAR) .

selectbest(PSTAR,MAX_SIZE,_,_,PSTAR) :- 
     length(PSTAR,L), L=<MAX_SIZE, ! .
selectbest(PSTAR,MAX_SIZE,[CT|CTX],LEF_ARGS,REDUCED_STAR) :- 
     !, reduce(PSTAR,CT,LEF_ARGS,RSTAR), 
       selectbest(RSTAR,MAX_SIZE,CTX,LEF_ARGS,REDUCED_STAR) .
selectbest(PSTAR,MAX_SIZE,[],_,RSTAR) :- 
     firstn(PSTAR,MAX_SIZE,RSTAR), ! .

reduce(PSTAR,[CRIT_FN,N,D],[EPLUS,UN_COV_EPLUS],RSTAR) :- 
     GET_CRIT_FN=..[CRIT_FN,COMP,EPLUS,UN_COV_EPLUS,V], 
       findset(VC,(member(COMP,PSTAR),GET_CRIT_FN,VC=[V,COMP]),
           VLIST), minmax(VLIST,MIN,MAX), 
       TOL is MIN + (N * (MAX - MIN)) / D, 
       findset(C,(member([V,C],VLIST),V=<TOL),RSTAR), ! .

minmax([[X,_],[Y,_]|R],MIN,MAX) :- 
     X=<Y, !, lohi([X,Y|R],MIN,MAX) .
minmax([[X,_],[Y,_]|R],MIN,MAX) :- 
     !, lohi([Y,X|R],MIN,MAX) .

lohi([X,Y,[Z,_]|R],MIN,MAX) :- 
     !, min([X,Z],A), max([Y,Z],B), lohi([A,B|R],MIN,MAX) .
lohi([X,Y],X,Y) :- 
     ! .

numbercovered(COMP,_,EVENTS,N) :- 
     coveredbycomplex(COMP,EVENTS,COVERED_E), length(COVERED_E,P), 
       N is - P, ! .

numberofselectors(COMP,_,_,N) :- 
     length(COMP,N), ! .

lef([[numbercovered,0,1],[numberofselectors,0,1]]) .

knockout(OUTER_COMPS,INNER_COMPS,UN_COV_COMPS) :- 
     !, 
       findset(IN_COMP,call((member(IN_COMP,INNER_COMPS),
           nonecover(OUTER_COMPS,IN_COMP))),UN_COV_COMPS) .

nonecover([],IN_COMP) :- 
     ! .
nonecover([COMP|CX],IN_COMP) :- 
     !, not(covers(COMP,IN_COMP)), nonecover(CX,IN_COMP) .

knockout1(OUTER_C,INNER_COMPS,UN_COV_COMPS) :- 
     !, 
       findset(IN_C,call((member(IN_C,INNER_COMPS),not(covers(
           OUTER_C,IN_C)))),UN_COV_COMPS) .

coveredbycomplex(COMPLEX,EVENTS,COVERED_E) :- 
     findset(E,(member(E,EVENTS),covers(COMPLEX,E)),COVERED_E), 
       ! .

newselector([A1=V1|T1],A1=V2,[A1=V2|T1]) :- 
     ! .
newselector([A1=V1|T1],A2=V2,[A1=V1|T3]) :- 
     A1@<A2, !, newselector(T1,A2=V2,T3) .
newselector([A1=V1|T1],A2=V2,[A2=V2,A1=V1|T1]) :- 
     A1@>A2, ! .
newselector([],SEL,[SEL]) :- 
     ! .

covers([A=OUT_VAL|OUT_C],[A=IN_VAL|IN_C]) :- 
     !, includes(A=OUT_VAL,A=IN_VAL), covers(OUT_C,IN_C) .
covers([A1=OUT_V|OUT_C],[A2=IN_V|IN_C]) :- 
     !, A2@<A1, covers([A1=OUT_V|OUT_C],IN_C) .
covers([],_) :- 
     ! .

includes(ATTR=OUT_VALS,ATTR=IN_VALS) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       subset(IN_VALS,OUT_VALS) .
includes(ATTR=OUT_VALS,ATTR=IN_VALS) :- 
     clause(domaintype(ATTR,linear),true), !, 
       includeslin(OUT_VALS,IN_VALS) .
includes(ATTR=OUT_VALS,ATTR=IN_VALS) :- 
     clause(domaintype(ATTR,structured),true), !, 
       supremum(ATTR,OUT_VALS,IN_VALS) .

disjointcomps([A=V1|T1],[A=V2|T2]) :- 
     !, disjointsel(A=V1,A=V2) .
disjointcomps([_|T1],[_|T2]) :- 
     !, disjointcomps(T1,T2) .

disjointsel(ATTR=VALS1,ATTR=VALS2) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       disjoint(VALS1,VALS2) .
disjointsel(ATTR=VALS1,ATTR=VALS2) :- 
     clause(domaintype(ATTR,linear),true), !, 
       disjointlin(VALS1,VALS2) .
disjointsel(ATTR=VALS1,ATTR=VALS2) :- 
     clause(domaintype(ATTR,structured),true), !, 
       not(supremum(ATTR,VALS1,VALS2)), 
       not(supremum(ATTR,VALS2,VALS1)) .

negate(COMPLEX,NEG_COMPS) :- 
     findset(NEGC,(member(SEL,COMPLEX),negatesel(SEL,NSEL),NEGC=
         [NSEL]),NEG_COMPS), ! .

negatesel(ATTR=VALS,ATTR=NEG_VALS) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       clause(valueset(ATTR,ALL_VALS),true), 
       difference(ALL_VALS,VALS,NEG_VALS), not(NEG_VALS = []) .
negatesel(ATTR=VALS,ATTR=NEG_VALS) :- 
     clause(domaintype(ATTR,linear),true), !, 
       negatelin(ATTR,VALS,NEG_VALS), not(NEG_VALS = []) .

extendagainst([A=VP|P],[A=VN|N],[[A=VX]|X]) :- 
     extendref(A=VP,A=VN,A=VX), !, extendagainst(P,N,X) .
extendagainst([AP=VP|P],[AN=VN|N],X) :- 
     AP@<AN, !, extendagainst(P,[AN=VN|N],X) .
extendagainst([AP=VP|P],[AN=VN|N],X) :- 
     !, extendagainst([AP=VP|P],N,X) .
extendagainst([],_,[]) :- 
     ! .
extendagainst(_,[],[]) :- 
     ! .

extendref(ATTR=POS_VALS,ATTR=NEG_VALS,ATTR=EXT_VALS) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       disjoint(POS_VALS,NEG_VALS), 
       negatesel(ATTR=NEG_VALS,ATTR=EXT_VALS) .
extendref(ATTR=POS_VALS,ATTR=NEG_VALS,ATTR=EXT_VALS) :- 
     clause(domaintype(ATTR,linear),true), !, 
       disjointlin(POS_VALS,NEG_VALS), 
       negatelin(ATTR,NEG_VALS,NN_VALS), 
       extendedlin(POS_VALS,NN_VALS,EXT_VALS) .
extendref(ATTR=POS_VAL,ATTR=NEG_VAL,ATTR=EXT_VAL) :- 
     clause(domaintype(ATTR,structured),true), !, 
       supremum(ATTR,EXT_VAL,POS_VAL), 
       not(supremum(ATTR,EXT_VAL,NEG_VAL)), 
       parent(ATTR,EXT_VAL,EXT_PARENT), 
       supremum(ATTR,EXT_PARENT,NEG_VAL) .

refunion([C1,C2|T],REFU) :- 
     !, refu(C1,C2,C3), refunion([C3|T],REFU) .
refunion([COMP],COMP) :- 
     ! .

refu([A=V1|C1],[A=V2|C2],[A=VU|CU]) :- 
     selunion(A=V1,A=V2,A=VU), !, refu(C1,C2,CU) .
refu([A1=V1|C1],[A2=V2|C2],U) :- 
     A1@<A2, !, refu(C1,[A2=V2|C2],U) .
refu([A1=V1|C1],[A2=V2|C2],U) :- 
     !, refu([A1=V1|C1],C2,U) .
refu([],_,[]) :- 
     ! .
refu(_,[],[]) :- 
     ! .

selunion(ATTR=VALS1,ATTR=VALS2,ATTR=UVALS) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       union(VALS1,VALS2,UVALS), 
       clause(valueset(ATTR,ALL_VALS),true), 
       not(equals(UVALS,ALL_VALS)) .
selunion(ATTR=VALS1,ATTR=VALS2,ATTR=UVALS) :- 
     clause(domaintype(ATTR,linear),true), !, low(VALS1,L1), 
       low(VALS2,L2), min([L1,L2],LOW), highest(VALS1,H1), 
       highest(VALS2,H2), max([H1,H2],HIGH), 
       clause(range(ATTR,MIN,MAX),true), not(LOW=MIN), 
       not(HIGH==MAX), UVALS==[LOW..HIGH], ! .
selunion(ATTR=VAL1,ATTR=VAL2,ATTR=UV_AL) :- 
     clause(domaintype(ATTR,structured),true), 
       supremum(ATTR,UV_AL,VAL1), supremum(ATTR,UV_AL,VAL2) .

product([A=V1|T1],[A=V2|T2],[A=V3|T3]) :- 
     !, selproduct(A=V1,A=V2,A=V3), !, product(T1,T2,T3) .
product([A1=V1|T1],[A2=V2|T2],[A1=V1|T3]) :- 
     A1@<A2, !, product([A2=V2|T2],T1,T3) .
product([A1=V1|T1],[A2=V2|T2],[A2=V2|T3]) :- 
     !, product([A1=V1|T1],T2,T3) .
product(X,[],X) :- 
     ! .
product([],X,X) :- 
     ! .

selproduct(ATTR=VALS1,ATTR=VALS2,ATTR=PROD_VALS) :- 
     clause(domaintype(ATTR,nominal),true), !, 
       intersection(VALS1,VALS2,PROD_VALS), not(PROD_VALS = []) .
selproduct(ATTR=VALS1,ATTR=VALS2,ATTR=PROD_VALS) :- 
     clause(domaintype(ATTR,linear),true), !, 
       productlin(VALS1,VALS2,PROD_VALS), not(PROD_VALS = []) .
selproduct(ATTR=VALS1,ATTR=VALS2,ATTR=VALS1) :- 
     clause(domaintype(ATTR,structured),true), 
       supremum(ATTR,VALS2,VALS1), ! .
selproduct(ATTR=VALS1,ATTR=VALS2,ATTR=VALS2) :- 
     clause(domaintype(ATTR,structured),true), 
       supremum(ATTR,VALS1,VALS2), ! .

trim(COMP,COVERED_EVENTS,TRIMMED_COMP) :- 
     !, refunion(COVERED_EVENTS,REFU), 
       trimcomp(COMP,REFU,TRIMMED_COMP) .

trimcomp([A=V1|C1],[A=VU|CU],[A=VT|CT]) :- 
     !, selproduct(A=V1,A=VU,A=VT), trimcomp(C1,CU,CT) .
trimcomp([A1=V1|C1],[A2=VU|CU],CT) :- 
     A2@<A1, !, trimcomp([A1=V1|C1],CU,CT) .
trimcomp([A1=V1|C1],[A2=VU|CU],[A1=V1|CT]) :- 
     !, trimcomp(C1,[A2=VU|CU],CT) .
trimcomp(X,[],X) :- 
     ! .
trimcomp([],_,[]) :- 
     ! .

encodeevents([],[]) :- 
     ! .
encodeevents([E|REST],[EE|ENCODE_REST]) :- 
     !, encodeevent(E,[],EE), encodeevents(REST,ENCODE_REST) .

encodeevent([],EVENT,EVENT) :- 
     ! .
encodeevent([SEL|E],PARTIAL_EV,NEW_PARTIAL_EV) :- 
     !, encodesel(SEL,ENCODED_SEL), 
       newselector(PARTIAL_EV,ENCODED_SEL,PPEV), 
       encodeevent(E,PPEV,NEW_PARTIAL_EV) .

encodesel([ATTR=VAL],ATTR=[VAL]) :- 
     clause(domaintype(ATTR,nominal),true), ! .
encodesel([ATTR=VAL],ATTR=[VAL..VAL]) :- 
     clause(domaintype(ATTR,linear),true), 
       clause(subtyp(ATTR,integer),true), ! .
encodesel([ATTR=SYM],ATTR=[ORD..ORD]) :- 
     clause(domaintype(ATTR,linear),true), 
       clause(subtyp(ATTR,'symbolic'),true), !, ord(ATTR,SYM,ORD) .
encodesel([ATTR=VAL],ATTR=VAL) :- 
     clause(domaintype(ATTR,structured),true), ! .
encodesel(S,_) :- 
     write('===> ERROR - unknown selector type: '), write(S) .

showcovers :- 
     clause(class(CLASS),true), showcover(CLASS), fail .
showcovers .

showcover(CLASS) :- 
     nl, nl, write('===> Cover of class '), write(CLASS), 
       write(':'), !, nl, clause(cover(CLASS,COVER),true), 
       printcomplex(COVER), nl, fail .
showcover(_) .

printcomplex(COMPLEX) :- 
     member(SELECTOR,COMPLEX), printselector(SELECTOR), fail .
printcomplex(_) :- 
     ! .

printselector(ATTR=VALS) :- 
     clause(domaintype(ATTR,nominal),true), !, write('['), 
       write(ATTR), write(' = '), prinlist(VALS), write(']') .
printselector(ATTR=VALS) :- 
     clause(domaintype(ATTR,linear),true), 
       clause(subtyp(ATTR,integer),true), !, write('['), 
       write(ATTR), write(' = '), prinlin(VALS), write(']') .
printselector(ATTR=VALS) :- 
     clause(domaintype(ATTR,linear),true), 
       clause(subtyp(ATTR,'symbolic'),true), !, write('['), 
       write(ATTR), write(' = '), prinsym(ATTR,VALS), write(']') .
printselector(ATTR=VAL) :- 
     clause(domaintype(ATTR,structured),true), !, write('['), 
       write(ATTR), write(' = '), write(VAL), write(']') .

intersection([A|B],[A|C],[A|X]) :- 
     !, intersection(B,C,X) .
intersection([A|B],[C|D],X) :- 
     A@<C, !, intersection([C|D],B,X) .
intersection([A|B],[C|D],X) :- 
     !, intersection([A|B],D,X) .
intersection(Y,[],[]) :- 
     ! .
intersection([],Y,[]) :- 
     ! .

difference([A|B],[A|C],X) :- 
     !, difference(B,C,X) .
difference([A|B],[C|D],[A|X]) :- 
     A@<C, !, difference(B,[C|D],X) .
difference([A|B],[C|D],[C|X]) :- 
     !, difference([A|B],D,X) .
difference(Y,[],Y) :- 
     ! .
difference([],Y,[]) :- 
     ! .

union([A|B],[A|C],[A|X]) :- 
     !, union(B,C,X) .
union([A|B],[C|D],[A|X]) :- 
     A@<C, !, union([C|D],B,X) .
union([A|B],[C|D],[C|X]) :- 
     !, union([A|B],D,X) .
union(Y,[],Y) :- 
     ! .
union([],Y,Y) :- 
     ! .

disjoint([A|B],[C|D]) :- 
     A@<C, !, disjoint([C|D],B) .
disjoint([A|B],[C|D]) :- 
     C@<A, !, disjoint([A|B],D) .
disjoint(_,[]) :- 
     ! .
disjoint([],_) :- 
     ! .

subset([A|B],[A|C]) :- 
     !, subset(B,C) .
subset([A|B],[C|D]) :- 
     A@>C, !, subset([A|B],D) .
subset([],_) :- 
     ! .

equals(X,Y) :- 
     X=Y, ! .

cardinality(X,N) :- 
     !, length(X,N) .

ord(ATTR,SYM,N) :- 
     clause(order(ATTR,L),true), at(SYM,L,N,1), ! .

at(SYM,[SYM|X],N,N) .
at(SYM,[_|X],N,I) :- 
     J is I + 1, at(SYM,X,N,J), ! .
at(_,_,_,_) :- 
     write('===> ERROR - symbol undeclared') .

low([L..H|_],L) .

highest([L..H],H) .
highest([L..H|X],HIGH) :- 
     !, highest(X,HIGH) .

includeslin(_,[]) .
includeslin([LO..HO|XO],[LI..HI|XI]) :- 
     HO@<LI, !, includeslin(XO,[LI..HI|XI]) .
includeslin([LO..HO|XO],[LI..HI|XI]) :- 
     !, LO@=<LI, HO@>=HI, includeslin([LO..HO|XO],XI) .

disjointlin([],_) :- 
     ! .
disjointlin(_,[]) :- 
     ! .
disjointlin([L1..H1|X1],[L2..H2|X2]) :- 
     H1@<L2, !, disjointlin(X1,[L2..H2|X2]) .
disjointlin([L1..H1|X1],[L2..H2|X2]) :- 
     H2@<L1, !, disjointlin(X2,[L1..H1|X1]) .

negatelin(ATTR,[LP..HP|XP],N) :- 
     !, neglinlow(ATTR,LP,LOW), neglinmid([LP..HP|XP],HI,MID), 
       neglinhi(ATTR,HI,HIGH), appendx([LOW,MID,HIGH],N) .

neglinlow(ATTR,LP,[]) :- 
     clause(range(ATTR,LP,_),true), ! .
neglinlow(ATTR,LP,[LOW..H]) :- 
     !, clause(range(ATTR,LOW,_),true), H is LP - 1 .

neglinmid([L..H],H,[]) :- 
     ! .
neglinmid([L1..H1,L2..H2|X],HI,[L..H,N]) :- 
     L2 > H1 + 1, !, L is H1 + 1, H is L2 - 1, 
       neglinmid([L2..H2|X],HI,N) .
neglinmid([L1..H1,L2..H2|X],HI,N) :- 
     !, neglinmid(X,HI,N) .

neglinhi(ATTR,HI,[]) :- 
     clause(range(ATTR,_,HI),true), ! .
neglinhi(ATTR,HI,[L..HIGH]) :- 
     !, clause(range(ATTR,_,HIGH),true), L is HI + 1 .

extendedlin(_,[],[]) :- 
     ! .
extendedlin([],_,[]) :- 
     ! .
extendedlin([LP..HP|XP],[LN..HN|XN],XVALS) :- 
     HN@<LP, !, extendedlin([LP..HP|XP],XN,XVALS) .
extendedlin([LP..HP|XP],[LN..HN|XN],XVALS) :- 
     HP@<LN, !, extendedlin(XP,[LN..HN|XN],XVALS) .
extendedlin([LP..HP|XP],[LN..HN|XN],[LN..HN|XVALS]) :- 
     !, LN@=<LP, HN@>=HP, extendedlin(XP,XN,XVALS) .

productlin([],_,[]) :- 
     ! .
productlin(_,[],[]) :- 
     ! .
productlin([L1..H1|X1],[L2..H2|X2],P) :- 
     H1@<L2, !, productlin(X1,[L2..H2|X2],P) .
productlin([L1..H1|X1],[L2..H2|X2],P) :- 
     H2@<L1, !, productlin(X2,[L1..H1|X1],P) .
productlin([L1..H1|X1],[L2..H2|X2],[L..H|P]) :- 
     !, max([L1,L2],L), min([H1,H2],H), productlin(X1,X2,P) .

prinlin([A]) :- 
     !, prinseg(A) .
prinlin([A,B]) :- 
     !, prinseg(A), write(' v '), prinlin(B) .
prinlin([]) :- 
     !, write('===> ERROR - null RHS in linear selector') .

prinseg(L..H) :- 
     L=H, write(L), ! .
prinseg(A) :- 
     write(A), ! .

prinsym(ATTR,[A]) :- 
     !, prinsymseg(ATTR,A) .
prinsym(ATTR,[A|B]) :- 
     !, prinsymseg(ATTR,A), write(','), prinsym(ATTR,B) .
prinsym(_,[]) :- 
     !, write('===> ERROR - null RHS in linear selector') .

prinsymseg(ATTR,L..H) :- 
     L=H, ord(ATTR,SYM,L), write(SYM), ! .
prinsymseg(ATTR,L..H) :- 
     ord(ATTR,SYML,L), ord(ATTR,SYMH,H), write(SYML..SYMH), ! .

/******************************************************************/
/* In AQ-PROLOG the procedure 'predecessor' is called 'ancestor'. */
/* Because in some (I think the most) PROLOG dialects a build-in  */
/* predicate 'ancestor' exists, I preferred to rename it.         */
/******************************************************************/

supremum(ATTR,HI_NODE,LO_NODE) :- 
     clause(ancest(ATTR,LO_NODE,ALIST),true), 
       member(HI_NODE,ALIST) .
supremum(ATTR,X,X) .

parent(ATTR,NODE,PARENT) :- 
     clause(ancest(ATTR,NODE,[PARENT|_]),true) .

explodestruc(ATTR,STRUCTUR_SPEC) :- 
     allnodes(STRUCTUR_SPEC,NODE_LIST), member(NODE,NODE_LIST), 
       predecessorlist(NODE,STRUCTUR_SPEC,ALIST), 
       assertz(ancest(ATTR,NODE,ALIST)), fail .
explodestruc(_,_) .

allnodes([],[]) :- 
     ! .
allnodes([parent(SIBS,P)|X],NODE_LIST) :- 
     !, qsort(SIBS,L1), union(L1,[P],L2), allnodes(X,L3), 
       union(L2,L3,NODE_LIST) .

/******************************************************************/
/* In AQ-PROLOG the procedure 'predecessorlist' is called         */
/* 'ancestorlist' Because I wanna be a little bit consistend in   */
/* the naming of predicates and 'ancestor' was already renamed    */
/* I preferred to rename this predicate too.                      */
/******************************************************************/

predecessorlist(NODE,STRUCTUR_SPEC,[P|X]) :- 
     father(NODE,STRUCTUR_SPEC,P), !, 
       predecessorlist(P,STRUCTUR_SPEC,X) .
predecessorlist(_,_,[]) :- 
     ! .

father(NODE,[parent(SIBS,P)|X],P) :- 
     member(NODE,SIBS), ! .
father(NODE,[_|X],P) :- 
     father(NODE,X,P), ! .

first([A|B],A) :- 
     ! .

appendx(X,Y) :- 
     findset(A,(member(B,X),member(A,B)),Y), ! .

firstn(_,0,[]) :- 
     ! .
firstn([A|B],N,[A|C]) :- 
     !, M is N - 1, firstn(B,M,C) .
firstn([],_,[]) :- 
     ! .

following(X,[X|AFTER_X],AFTER_X) :- 
     ! .
following(X,[_|LIST],AFTER_X) :- 
     !, following(X,LIST,AFTER_X) .
following(X,[],[]) :- 
     ! .

qsort(L0,L) :- 
     qsort(L0,L,[]), !.

qsort([X|L],R,R0) :-
     partition(L,X,L0,L1),
       qsort(L1,R1,R0),
       qsort(L0,R,[X|R1]).
qsort([],R,R) :-
     !.

partition([X|L],Y,[X|L0],L1) :-
     X @=< Y, !,
       partition(L,Y,L0,L1) .
partition([X|L],Y,L0,[X|L1]) :-
     !, partition(L,Y,L0,L1) .
partition([],_,[],[]) .

remove(X,[],[]) :- 
     ! .
remove(X,[X|B],C) :- 
     !, remove(X,B,C) .
remove(X,[A|B],[A|C]) :- 
     !, remove(X,B,C) .

prinlist([A]) :- 
     write(A), ! .
prinlist([A|B]) :- 
     !, write(A), write(' v '), prinlist(B) .
prinlist([]) :- 
     write('===> Nothing to print'), ! .

min([X,Y|T],Z) :- 
     X@=<Y, !, min([X|T],Z) .
min([X,Y|T],Z) :- 
     !, min([Y|T],Z) .
min([X],X) :- 
     ! .

max([X,Y|T],Z) :- 
     X@>=Y, !, max([X|T],Z) .
max([X,Y|T],Z) :- 
     !, max([Y|T],Z) .
max([X],X) :- 
     ! .

findset(X,G,L) :- 
     findall(X,G,ZWERG), sort(ZWERG,L) .

/******************************************************************/
/* This is adopted from the Clocksin/Mellish definition of        */
/* 'bagof', if you're local PROLOG system does not know 'findall' */
/* you should use this definition. AQ is ensured to work correctly*/
/* with this definition. In the case that your local Prolog       */
/* dialect has 'findall' as built-in and AQ will give no result,  */
/* it is likely that the problem depends on the 'findall'         */
/* definition. You should rename the 'findalls' of AQ and try it  */
/* again.                                                         */
/******************************************************************/
/* findall(X,G,_) :-                                              */
/*      asserta(yk_found(mark)), call(G),                         */
/*        asserta(yk_found(X)), fail .                            */
/* findall(_,_,L) :-                                              */
/*      yk_collect_found(L) .                                     */
/*                                                                */
/* yk_collect_found([X|L]) :-                                     */
/*      yk_getnext(X), yk_collect_found(L) .                      */
/* yk_collect_found(nil) .                                        */
/*                                                                */
/* yk_getnext(X) :-                                               */
/*      retract(yk_found(X)), !, not (X == mark) .                */
/******************************************************************/

help :- nl, nl, write('===> AQ-PROLOG'), nl, 
	write('===> Load data with command: data(fn)'), nl, 
	write('===> Show data with command: listdata'), nl, 
	write('===> Start AQ  with command: start'), nl, nl .

:- help.
