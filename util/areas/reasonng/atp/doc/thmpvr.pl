From mgv@usceast.cs.scarolina.edu Tue Feb  8 23:20:26 EST 1994
Article: 9596 of comp.lang.prolog
Xref: glinda.oz.cs.cmu.edu comp.lang.prolog:9596
Path: honeydew.srv.cs.cmu.edu!fs7.ece.cmu.edu!europa.eng.gtefsd.com!howland.reston.ans.net!darwin.sura.net!opusc!usceast!usceast!not-for-mail
From: mgv@usceast.cs.scarolina.edu (Marco Valtorta)
Newsgroups: comp.lang.prolog
Subject: Re: PROLOG implementations of Theorem Provers
Date: 7 Feb 1994 09:47:01 -0500
Organization: University of South Carolina - Columbia - Computer Science
Lines: 57
Message-ID: <2j5k95$776@poplar.cs.scarolina.edu>
References: <13296@obelix.icce.rug.nl>
NNTP-Posting-Host: poplar.cs.scarolina.edu

peter@icce.rug.nl () writes:

>Hello,

>I'm currently writing a thesis on Default Logic. One of my
>objectives is to write a top down resolution theorem prover
>for a subset of default logic (normal defaults) as proposed
>in "Reiter, A Logic for Default Reasoning". But before I'm
>going to disembark on a project like this I would like
>to study some implementations of resolution based theorem
>provers written in Prolog. I checked the FAQ but didn't
>find much there except for Plaisted's theorem prover.
>For starters I would like to see something that isn't
>too advanced (e.g. only propositional logic) and next move
>to more sophisticated algorithms.

>Is there anyone who can provide with some pointers or
>better yet actual code?

Here are three pointers.  The first contains a complete first-order logic 
theorem provers, based on Loveland and Stickel's "Hole in Goal Trees" paper.
The second paper contains an incomplete first-order theorem prover that is
well-suited for diagnostic applications.  The third reference contains a
propositional resolution-based theorem prover.  Prolog code is given in all
three references.

[Poole, Goebel, and Aleliunas, 1987]
Poole, David, Randy Goebel, and Romas Aleliunas.
``Theorist: A Logical Reasoning System for Defaults and Diagnosis.''
In:
Cercone, Nick, and Gordon McCalla.
{\em The Knowledge Frontier: Essays in the Representation of Knowledge}.
New York: Springer-Verlag, 1987, pp.~331--352.

[Friedrich and Nejdl, 1990] Friedrich, Gerhard and Wolfgang Nejdl.  ``MOMO:
Model-Based Diagnosis for Everybody.''  {\em Proceedings of the 6th IEEE
Conference on AI Applications}, Santa Barbara, CA, March 1990, 206-213.
Reprinted in {Readings in Model-Based Diagnosis}, eds. Walter Hamscher, Luca
Console, and Johan de Kleer.  Morgan Kaufmann, San Mateo, CA, 1992.

Bratko, Ivan.
.ul
Prolog Programming for Artificial Intelligence,
second edition.
Addison-Wesley, 1990.

>Thanks.

You are welcome!

>Peter Bouthoorn

>  _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _
>  | Steal a little and they throw you in jail     | Peter Bouthoorn   |
>  | Steal a lot and they make you king            | peter@icce.rug.nl |
>  |                                    Bob Dylan  | Linux addict      |
>  - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


