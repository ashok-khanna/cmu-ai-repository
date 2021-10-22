tutor.tar.Z
    Source from Jocelyn's book "The Logic Programming Tutor".
    Jocelyn Paine.

                         LOGIC PROGRAMMING TUTOR
                        Written by Jocelyn Paine
                  Shelved on the 4th of September 1992


This is the program described in my book "The Logic Programming Tutor" -
published by Intellect in the UK and Kluwer elsewhere. It is a front-end
designed to introduce novices to Prolog, and can accept facts and
questions in either Prolog or infix "Logic", translating between the
two. It has a simple number-editor (Basic-like), and a portable
screen-editor. It also comes with a set of eight "scripts". These are
lessons which it displays one section at a time, inviting the student to
try doing simple exercises, or to try experiments with Prolog. Finally,
there is some auxiliary software, including a trading game and a number
of example knowledge bases, plus the LaTeX source of the supplementary
exercises and notes from my book.

Four examples are shown below.


Example 1.
----------            

$ LOGIC LESSON1
THE LOGIC PROGRAMMING TUTOR

*** Section number 1  ***

                     LOGIC PROGRAMMING LESSON 1

Welcome to the Logic Programming Tutor. We're going to use it to teach
you logic programming and Prolog. Because full Prolog looks rather
frightening to the beginner, we'll start with a simpler version, which
looks more like English. But it isn't English, and to make the
distinction clear, we'll call it Logic.

You can tell the Tutor facts in Logic. You can also ask it questions. It
will try to answer these, by using its knowledge of the facts you've
typed. The connection between questions and facts may be quite
intricate, and the Tutor may have to do some rather involved reasoning
to find an answer. More of this later.

First though, you must learn to control the Tutor. You need to know
things like how to display the next section of this lesson, how to stop
when you've had enough, and how to repeat a section.

Please begin by waiting until you see a star (*) at the end of this
section. When you see it, type the word "next" and follow it with a
full-stop. Then hit the RETURN key. It is most important that you type
the full-stop, and that you hit RETURN. Otherwise, the Tutor won't do
anything.
* next.
*** Section number 2  ***

You have now given your first command to the Tutor. COMMANDS are
sentences that control the Tutor in some way; for example, by making it
move to the next section, or repeat the last section, or stop when
you've had enough.

Now, when you see a star appear at the end of this paragraph, please
type "next" again to move to the next section. As we said above, you
must follow the word by a full-stop, and you must then hit the RETURN
key. If you don't, the Tutor won't realise that you've finished your
sentence. Being stupid about such things, it won't act on its own
initiative (it has none). Instead, it will just sit and wait... and
wait... and wait.
* section 8.
*** Section number 8  ***

In this section, we start programming in logic, and we see how to
tell the Tutor facts about romances. In the context of logic
programming, FACTS are sentences about objects - these objects can be
people, or animals, or countries, or anything else.

When the "*" appears, type the following, ending as usual with a full
stop and RETURN:

      mary loves john.

You must use only lower-case letters, even though you're talking about
people's names. As we said in section 3, if you use upper-case, then the
Tutor will treat the names as variables, and they mean something quite
different.

When you've typed your fact, the Tutor will respond "ok - fact 10
recorded". It gives each fact a unique number, and we'll explain why
later. After that, type "next" as usual to see more instructions.
* mary loves john.
OK - fact 10 recorded.
* next.
*** Section number 9  ***

The Tutor has remembered the fact you typed. You can ask about it by
typing a sentence which ends in a question mark. Try

      mary loves john?

followed by RETURN. Make sure that both names start with a lower-case
letter.
* mary loves john?
Yes.
* mary marries bill.
OK - fact 20 recorded.
* sara loves mark.
OK - fact 30 recorded.
* sara marries mark.
OK - fact 40 recorded.
* debbie loves steve.
OK - fact 50 recorded.
* Who loves Whom?
Yes -
    Who=mary  Whom=john
    Who=sara  Whom=mark
    Who=debbie  Whom=steve
* X loves Y and X marries Y?
Yes -
    X=sara  Y=mark
* X loves Y
*... and X marries Z
*... and Z \B= Y?
Yes -
    X=mary  Y=john  Z=bill


Example 2.
----------

* bert loves bettie.
OK - fact 10 recorded.
* 1 adam loves ada.
OK - fact 1 inserted.
* 50 edward loves edna.
OK - fact 50 inserted.
* 40 dai loves davina.
OK - fact 40 inserted.
* 31 charles loves charles.
OK - fact 31 inserted.
* 31 charles loves charlotte.
OK - fact 31 replaced.
I am saving your facts.
* hendrik loves henriette.
OK - fact 60 recorded.
* 55 frank loves francis.
OK - fact 55 inserted.
* 56 giles loves gill.
OK - fact 56 inserted.
* show.
1    adam loves ada.
10   bert loves bettie.
31   charles loves charlotte.
40   dai loves davina.
50   edward loves edna.
55   frank loves francis.
56   giles loves gill.
60   hendrik loves henriette.
* X loves Y?
Yes -
    X=adam  Y=ada
    X=bert  Y=bettie
    X=charles  Y=charlotte
    X=dai  Y=davina
    X=edward  Y=edna
    X=frank  Y=francis
    X=giles  Y=gill
    X=hendrik  Y=henriette
* 1.
OK - fact 1 deleted.
* delete 10/40.
OK - fact 10 deleted.
OK - fact 31 deleted.
OK - fact 40 deleted.
I am saving your facts.
* delete 1.
There are no facts within this range so I haven't deleted any.
* 55.
OK - fact 55 deleted.
* delete hendrik loves henrietta.
I can't find this fact so haven't deleted it.
* show.
50   edward loves edna.
56   giles loves gill.
60   hendrik loves henriette.
* delete hendrik loves henriette.
OK - fact 60 deleted.
* X loves Y?
Yes -
    X=edward  Y=edna
    X=giles  Y=gill
* delete all.
OK - fact 50 deleted.
OK - fact 56 deleted.
* X loves Y?
No.


Example 3.
----------

* dave thinks declaratively.
OK - fact 10 recorded.
* perry thinks procedurally.
OK - fact 20 recorded.
* P writes pop11 if P thinks procedurally.
OK - fact 30 recorded.
I am saving your facts.
* P writes prolog if P thinks declaratively.
OK - fact 40 recorded.
* prolog.
OK - mode changed to prolog.
* show.
10   thinks(dave, declaratively).
20   thinks(perry, procedurally).
30   writes(P, pop11) :-
         thinks(P, procedurally).
40   writes(P, prolog) :-
         thinks(P, declaratively).
* thinks(X,Y)?
X = dave
Y = declaratively
More (y/n)? y

X = perry
Y = procedurally
More (y/n)? y

no

* 50 thinks(charles,clumsily).
OK - fact 50 recorded.
* writes(P,cobol) :- thinks(P,clumsily).
OK - fact 60 recorded.
* show.
10   thinks(dave, declaratively).
20   thinks(perry, procedurally).
30   writes(P, pop11) :-
         thinks(P, procedurally).
40   writes(P, prolog) :-
         thinks(P, declaratively).
50   thinks(charles, clumsily).
60   writes(P, cobol) :-
         thinks(P, clumsily).
* logic.
OK - mode changed to logic.
* show.
10   dave thinks declaratively.
20   perry thinks procedurally.
30   P writes pop11 if
         P thinks procedurally.
40   P writes prolog if
         P thinks declaratively.
50   charles thinks clumsily.
60   P writes cobol if
         P thinks clumsily.
* fred thinks foolishly.
OK - fact 70 recorded.
* P writes fortran if P thinks foolishly.
OK - fact 80 recorded.
* prolog.
OK - mode changed to prolog.
* writes(Who,What)?
Who = dave
What = prolog
More (y/n)? y

Who = perry
What = pop11
More (y/n)? y

Who = charles
What = cobol
More (y/n)? y

Who = fred
What = fortran
More (y/n)? y

no


Example 4.
----------

* idi hates X.
OK - fact 10 recorded.
* Everything is_in the_universe.
OK - fact 20 recorded.
* P commits suicide if P kills P.
OK - fact 30 recorded.
I am saving your facts.
* A is_a good_samaritan if A helps N and N not_friend_of A.
OK - fact 40 recorded.
* X is_jealous_of Y if X loves Z and Y loves Z.
OK - fact 50 recorded.
* P is_a commuter
*... if P lives_in Home and P works_in Office and Home \B= Office.
OK - fact 60 recorded.
* analyse.
10   For all X,
     idi hates X.
20   For all Everything,
     Everything is_in the_universe.
30   For all P,
     P commits suicide if
         P kills P.
40   For all A,
     A is_a good_samaritan if
         there exists N such that
         A helps N and
         N not_friend_of A.
50   For all X and Y,
     X is_jealous_of Y if
         there exists Z such that
         X loves Z and
         Y loves Z.
60   For all P,
     P is_a commuter if
         there exist Home and Office such that
         P lives_in Home and
         P works_in Office and
         Home \B= Office.


SIZE: 1.7 megabytes.                    

CHECKED ON EDINBURGH-COMPATIBLE (POPLOG) PROLOG : written for it!          

PORTABILITY : Good. It will help if you read the book, but I have
commented all the portability problems in the code, and supplied
portable versions of all the library predicates you might need.

INTERNAL DOCUMENTATION : Specification of all predicates exported from
modules and of most others; comments on all important aspects of the
implementation. Read the book for background information.

