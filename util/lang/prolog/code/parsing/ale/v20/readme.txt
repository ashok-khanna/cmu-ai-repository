Installing ALE
==============

ALE has been tarred and compressed to cut down on mail traffic.

To extract the ALE system, create a directory called 'ALE'.  Put the
mailed file with header 'alesystem' in a file called 'alesystem' in
directory ALE and cd to the ALE directory.  Then execute the following
commands:

  % uncompress *.Z
  % tar xvf *.tar

The following files will then be installed in the ALE directory:
  ale.pl
  cg.pl
  syllab.pl
  baby.pl
  hpsg.pl
  guide.tex

The primary system resides in the file ale.pl, the two grammars in
cg.pl and syllab.pl, a sample constraint puzzle in baby.pl, and an
HPSG grammar (complete through the first five chapters of Pollard &
Sag, 1994). The user's guide is in guide.tex.

After checking the contents of these files to make sure they were
created properly, it is safe to remove the file 'system.tar' and the
file 'tempfile'.


Printing the User's Guide
=========================

The user's guide should be processed through LaTeX twice to generate a
table of contents and process cross-references:

  % latex guide.tex; latex guide.tex

The .dvi file in guide.dvi should be ready for viewing on screen
and/or printing.


Reporting Bugs / Mailing List
=============================

Please report all bugs (and any other comments) to:

   Bob Carpenter  carp@lcl.cmu.edu
   Gerald Penn    penn@lcl.cmu.edu

If there is enough interest, I'll set up a mailing list.


Quintus Patches
===============

It turns out that ALE doesn't run directly in Quintus.  But John
Griffith and Thilo Goetz of the Seminar fuer Sprachwissenschaft
at the Universitaet Tuebingen ported it with three changes.  Their
e-mail is: 
  {griffith,tg}@earley.sns.neuphilologie.uni-tuebingen.de


Changes 
-------

(These changes were used successfully with Quintus 3.1.1)

1. The first problem had to do with the precedence of operators, I
think.  We had to enclose the postfix instances of 'if_h' in
parentheses or quintus thought that the following ':-' was part of the
argument.  It was interpreting the 'if_h' as the infix version.  I
don't understand why this didn't work in quintus and did work in
sicstus since they both have the same precedences for ':-'.  I guess
that sicstus is a little smarter in this respect.  The same problem
occurred with the calls to 'multi_hash()' where the arity of the second
argument was separated by a '/'.  I just put the predicate name in
parentheses and it seemed to work fine.

2. The second problem was that quintus (at least 3.1.1) wants the
arity of a predicate in 'abolish()' to be a separate argument
separated by a comma and not a '/'.

3. The last problem was that quintus has 'append()' as a builtin
predicate and doesn't allow it to be redefined, so I simply commented
it out.

Here's the diff:

(ale.pl.orig is the original version)

harris:/programs/ALE 13>diff ale.pl.orig ale.pl
116c116
< sub_type(Type,Type) if_h :-
---
> (sub_type(Type,Type) if_h) :-
118c118
< sub_type(Type,TypeSub) if_h :-
---
> (sub_type(Type,TypeSub) if_h) :-
130c130
< unify_type(Type1,Type2,TypeLUB) if_h :-
---
> (unify_type(Type1,Type2,TypeLUB) if_h) :-
217c217
< approp(Feat,Type,ValRestr) if_h :-
---
> (approp(Feat,Type,ValRestr) if_h) :-
901c901
< lex(Word,Tag,SVs) if_h :-
---
> (lex(Word,Tag,SVs) if_h) :-
1081,1082c1081,1082
<   abolish(empty/1), abolish(rule/2), abolish(lex_rule/2), abolish(lex_rule/6),
<   abolish('--->'/2), abolish(sub/2), abolish(if/2), abolish(macro/2),
---
>   abolish(empty,1), abolish(rule,2), abolish(lex_rule,2), abolish(lex_rule,6),
>   abolish('--->',2), abolish(sub,2), abolish(if,2), abolish(macro,2),
1093c1093
<   abolish(sub/2),
---
>   abolish(sub,2),
1103c1103
<   abolish(sub/2),
---
>   abolish(sub,2),
1190,1191c1190,1191
<   abolish(empty/1), abolish(rule/2), abolish(lex_rule/2),
<   abolish(lex_rule/6), abolish('--->'/2),
---
>   abolish(empty,1), abolish(rule,2), abolish(lex_rule,2),
>   abolish(lex_rule,6), abolish('--->',2),
1202c1202
<   abolish(lex_rule/2), abolish(lex_rule/6),
---
>   abolish(lex_rule,2), abolish(lex_rule,6),
1210,1211c1210,1211
<     abolish(lex_rule/6)
<   ; multi_hash(0,lex_rule/6)
---
>     abolish(lex_rule,6)
>   ; multi_hash(0,(lex_rule)/6)
1215c1215
<   abolish('--->'/2),
---
>   abolish('--->',2),
1227c1227
<   abolish(empty/2),
---
>   abolish(empty,2),
1235c1235
<   abolish(rule/2),
---
>   abolish(rule,2),
1246c1246
<     multi_hash(0,rule/4)
---
>     multi_hash(0,(rule)/4)
1250c1250
<   abolish(if/2),
---
>   abolish(if,2),
1938,1940c1938,1940
< append([],L,L).
< append([H1|T1],L2,[H1|T3]):-
<   append(T1,L2,T3).
---
> %append([],L,L).
> %append([H1|T1],L2,[H1|T3]):-
> %  append(T1,L2,T3).


