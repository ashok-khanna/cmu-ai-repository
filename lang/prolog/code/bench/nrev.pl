/*  NREV.PL                                                          */
/*  Prolog naive reverse benchmark.                                  */
/*  Norbert Fuchs, Department of Computer Science, Zurich University */

/*  Benchmark for reversing lists by the "naive" (2-argument)        */
/*  form of reverse.                                                 */

/*  Runs in Edinburgh Prolog.                                        */
/*  To port, change 'T0 is cputime' inside bench(Count)              */

/* Prolog Benchmark Naive Reverse (CProlog version) */
/* To execute the benchmark call the goal lots      */

lots :- 
   eg_count(Count),
   bench(Count),
   fail.
lots.

eg_count(10).
eg_count(100). 
eg_count(200).

bench(Count) :-
   T0 is cputime,
   dodummy(Count),
   T1 is cputime,
   dobench(Count),
   T2 is cputime,
   report(Count, T0, T1, T2).

dodummy(Count) :-
   data(List),
   nrepeat(Count),
   dummy(List, _),
   fail.
dodummy(_).

dummy(_, _).

dobench(Count) :-
   data(List),
   nrepeat(Count),
   nrev(List, _),
   fail.
dobench(_).

data([1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
   21, 22, 23, 24, 25, 26, 27, 28, 29, 30]).

report(Count, T0, T1, T2) :-
   Time1 is T1-T0,
   Time2 is T2-T1,
   Time is Time2-Time1,
   calculate_lips(Count, Time, Lips, Units),
   nl,
   write(Lips), write('   lips for  '), write(Count),
   write('   iterations taking   '), write(Time),
   write('   '), write(Units), write('   ('),
   write(Time2-Time1), write(')'),
   nl.

calculate_lips(Count, Time, Lips, 'secs') :-
   Lips is (496*Count)/Time.
   /*  The 496 is the number of logical inferences involved in
       reversing a 30-element list.
   */

nrepeat(_).
nrepeat(N) :-
   N>1,
   N1 is N-1,
   nrepeat(N1).

nrev([], []).
nrev([X|Rest], Ans)  :-
   nrev(Rest, L),
   app(L, [X], Ans).

app([], L, L).
app([X|L1], L2, [X|L3]) :-
   app(L1, L2, L3).
