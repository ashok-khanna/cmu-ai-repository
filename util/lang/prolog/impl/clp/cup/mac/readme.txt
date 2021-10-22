Files:

MacCup080c.sea.hqx     program, Bin Hexed and Self-Extracted
cup380d.tar.gz         program source for UNIX, Mac, and MS-DOS
djcup.lzh              MS-DOS program, running under DOS-extender
                        (386/486 cpu), compressed by LHA
                       (Caution: this is an OLD version (0.78w))
manual.tex             manual for OLDER version of MacCup
MacCup.doc             manual for 0.78w version of MacCup
                        (NOT included in MacCup*.sea.hqx)
djcup.doc              manual for 0.78w version of DJCup
                        (includede in djcup.lzh)
sample.p               sample program a la JPSG
util.p                 utility program

------------------------------------------------------------
Note:
MacCup is Macintosh version of CU-Prolog
DJCup is MS-DOS version of CU-Prolog compiled with DJ's gcc.
CU-Prolog has been developed at ICOT, Japan.
------------------------------------------------------------
Brief Introduction to MacCup:

  MacCup is a Macintosh version of CUP, Constraint Unification
Prolog, whose original version written in C with UNIX was developed by ICOT.
  The programming style in CUP looks like a usual Prolog system.

  However there are several differences:
  (1) use "<file name>" to load a program from a file instead of
 using [<file name>].
   (NOTE: after 0.79, :-[ file_name ].  is also supported.)
  (2) input program directly from keyboard after `_' prompt
instead of using [console].
  (3) use %d* to list defined predicates instead of :-listing.
    (NOTE: after 0.79, this is also supported.)
  (4) ';' has a different meaning from conventional Prolog.
  etc. etc.

To get MacCup from MacCup*.sea.hqx:
   Load (or FTP) to your Macintosh, use BinHex to decode,
Then just double-click the MacCupXXX.sea icon.

To run MacCup:
   Double-click  the MacCup icon, and wait about
10 seconds.  You will get MacCup window, and the following
message:

   ********   MacCup Ver. XXX   ********
    All Modular mode (help -> %h)

To quit:
   Input %Q, or :-halt., or Command-Q.

To load MacCup Programs:
   Click FILE menu and OPEN item (or use Command-O), select
the program file, and OPEN it.
   (or you can use :-[ ], consult/1, reconsult/1)

To get command lists:
   Input %h.
MacCup has several `commands' which are marked by `%' as in %h.

Note. 
1. Thanks to Dr. Emele,  I found a bug in MacCupV0.63, and
made MacCupV0.70.

The difference between them is that  the latter will deal with
PSTs in constraint transformation better than the former.

For example, 
p({c/C}) :- ab(C).
q({d/D,c/{a/D}}).
ab({a/1,b/0}).
ab({a/0,b/1}).

@ p(X),q(X).
will produce different results in V0.63 and V0.70.

HOWEVER, MacCup still returns incorrect answer for the
following:

ab({a/1,b/0}).
ab({a/0,b/1}).
r({c/C});ab(C).
s({d/D,c/X});X={a/D}.

:-r(X),s(X).

Frankly speaking, there is a trade-off between efficiency and
getting correct/strict answers.

MacCup078S takes efficiency, and MacCup078X takes correctness.
(MacCup078X is not distributed to public.)

2. You can interrupt MacCup by pressing COMMAND-`.'.
If you click the Abort button, the interrupted process
will be aborted.


I'd appreciate if you give any comments and/or suggestions.

--------------------------------------------------
Notes after 0.78w

The differences between Cup3.78/MacCup0.78 and Cup3.79/MacCup0.79 are
as follows:

1. (for MacCup only)
  MacCup0.79 was compiled with Think C 5.0.3/KanjiTalk 7.1.

2. MacCup will load the file named "cup.ini" if it is located under the same
folder where MacCup exists.
   Cup3.79 will load .cuprc file if it is located in your home directory.

3. The predicates, consult/1 and reconsult/1, are now built-in.

4. You can also load files in the following way:
        :-[ file1, - file2].
   whose meanings are same as conventional Prolog systems.

5. (for MacCup only)
  All fonts incorporated in your system will be displayed to choose.
  The initial font is Geneva.

6. 'user' is the special file name for the input from keyboard.

7. (for MacCup only)
  Window size will be enlarged according to your CRT size.

8. There is one more built-in predicate, subsume/2.
  subsume(X,Y) will succeed if X is more general than Y.
  For example, subsume(X,a) is TRUE, and subsume(a,X) is FALSE.

9. clause/3 will fail if the first argument is built-in predicate.

Apr 7, 1993
Hidetosi SIRAI
--------------------------------------------------

10. cup3.80a (Aug. 14, 1993)
(1) Bugs around the unification of PSTs are removed.
(2) M-solvability mode is the DEFAULT.  You can switch it to
All-modular mode by using %a.

11. cup3.80c (Aug. 26, 1993)
    I have introduced the mechanism to simplify the definitions
of the produced predicates in the constraint unification.
For example, in older version than 3.80c,  modularizing
        member(A,X), append(X,Y,Z)
will produce the followings:

solution = c0(A_0, Z_3, Y_2, X_1)
c0(V3_0, V2_1, V1_2, [Y_3 | Z_4]) :- c1(V2_1, V1_2, Y_3, Z_4, V3_0).
c0(V3_0, V2_1, V1_2, [V3_0 | Y_3]) :- c2(V2_1, V1_2, Y_3, V3_0).
c1([V2_0 | Z_1], V3_2, V2_0, V1_3, V0_4) :- c0(V0_4, Z_1, V3_2, V1_3).
c2([V0_0 | Z_1], V2_2, V1_3, V0_0) :- append(V1_3, V2_2, Z_1).

But now, 3.80c will produce the followings:

solution = c0(A_0, Z_3, Y_2, X_1)
c0(V3_0, [Y_1 | Z_2] , V1_3, [Y_1 | Z_4]) :- c0(V3_0, Z_2, V1_3, Z_4).
c0(V3_0, [V3_0 | Z_1], V1_2, [V3_0 | Y_3]) :- append(Y_3, V1_2, Z_1).

However it may cost much. So I introduce the %S switch.
This is a toggle switch. The default is the simplifier ON.

12. cup3.80d (Aug. 27, 1993)
   The default for the timer is changed (ON is the default).
(The following is UNIX-version only)
   Added %I option, and modified garbagecollect().
If you call %G, the system heap will increase 200K, and name heap
50K.
And you can increase the temporal area any time by using %I.
For example,
        %I c/100
make CU-work area by 100K.
------------------------------------------------------------
Hidetosi SIRAI
(email: sirai@csli.stanford.edu, or sirai@sccs.chukyo-u.ac.jp)
Chukyo University
101 Kaizu-cho, Tokodate, TOYOTA, Aichi
JAPAN
