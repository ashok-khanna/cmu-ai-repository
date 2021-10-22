From crabapple.srv.cs.cmu.edu!cantaloupe.srv.cs.cmu.edu!rochester!news.bbn.com!olivea!uunet!stanford.edu!CSD-NewsHost.Stanford.EDU!CS.Stanford.EDU!pehoushe Wed Dec  2 14:59:07 EST 1992
Article: 8733 of comp.lang.lisp
Path: crabapple.srv.cs.cmu.edu!cantaloupe.srv.cs.cmu.edu!rochester!news.bbn.com!olivea!uunet!stanford.edu!CSD-NewsHost.Stanford.EDU!CS.Stanford.EDU!pehoushe
From: pehoushe@CS.Stanford.EDU (Dan Pehoushek)
Newsgroups: comp.lang.lisp
Subject: Satisfiability Program
Message-ID: <1992Dec1.105309.11489@CSD-NewsHost.Stanford.EDU>
Date: 1 Dec 92 10:53:09 GMT
Sender: news@CSD-NewsHost.Stanford.EDU
Organization: Computer Science Department, Stanford University
Lines: 1503


A while ago, I posted a notice of the availability of a satisfiability
program, in common lisp.  The response was large enough to warrant
posting the source code for general use.  It is in comp.lang.lisp, but
should end up in a source code repository before long.


In many instances, the Quine Tree algorithm is quite fast.  It is
eminently suitable for small to moderate sized, and some large sized
propositional inference problems.  If you do anything with the
program, I'd be interested in receiving a quick summary.  Also, if you
let me know that you are using it, I may be able to send you patches,
upgrades, etc.  I expect some descendent of this code to be accessible
via the Lisp or AI FAQs, until a clearly better algorithm is found.

So, here's the original new group msg plus the source code.  If you
are into benchmarks, please check out 5-5-regular problems, as
described below. If you'd like some hard, random, small (180 var),
satisfiable, instances of 3-sat, I can send them to you.  They are of
the 5-5-regular type described below, and seem significantly harder
than MSL prblems.

It's not "production quality" code; it was not meant to be read by
other than myself, but I figured that I could save some people alot of
development time by making it available. It is supposed to work on any
boolean expression, but was mainly designed for 3sat.  If you have any
comments, please send them to me.  Distribute this code as you like. 

While I've oscillated on the P=NP question, I have to firmly commit
myself to the NEGATIVE, based on several years of effort on the
problem. That is, I believe P<>NP.  As fairly clear evidence to anyone
who thinks they have a poly-time algorithm, I offer the random, almost
always satisfiable, 5-5-regular instances described below.  There are
many highly structured, hard, unsatisfiable formula, but I think the
5-5-regular instances have much to offer investigators of sat
algorithms, because they are hard, small, and satisfiable.  

I'll be around intermittently until Christmas to answer questions and
fix bugs.  After that, my network connection will be tenuous at best.

Satisfactorially yours,
Dan Pehoushek


Earlier Newsgroup msg posted by me:

I am making the source code to a satisfiability program available, and
if there's enough interest, I will post it in comp.lang.lisp (1500
lines of code).

The program is competitive with the fastest complete
algorithms that I know of.  If you use a propositional inference
engine in your work, give this one a try.  If you haven't put a
significant amount of time an effort into your inference system, this
program is probably faster in a majority of cases.

On Mitchell, Selman, Levesque hard spot problems, the program takes
from 1 minute to 15 minutes on 150 variable instances, including
unsatisfiable instances, averaging under 10 minutes.  The program
appears to run in time N*2^(N/22) on MSL hard spot instances. 

Easy Instances: Using the program, the author (me) discovered
empirically that almost all randomly generated 4-regular graphs (and
indeed, almost all randomly generated k-regular graphs, with
sufficiently many vertices), are 3-colorable.  Instances with
thousands of vertices were translated to 3-sat and then colored.
There is a fairly simple counting argument that proves this empiricaal
result.  Empirically, the 3-coloring problem on almost all (in
Bollobas sense) 4-regular graphs is easy (near linear time).

However, the main potential practical result is that, given a random
instance of an NP-complete problem, and then translating it to 3-sat,
does not make the resulting instance hard. The program appears to run
in near O(N) time on almost all of these 3-coloring instances.  Please
note, however, these so-called "easy" instances appear to be quite
hard for the Davis-Putnam algorithm.


Fairly Hard Instances: There is a simple method to generate instances
that are significantly harder than the MSL hard spot.  Generate random
3-clauses such that each variable appears 5 times positively and 5
times negatively. The resulting 3-cnf formulae tend to be harder and
smaller than MSL hard spot formulae, but also tend to be almost always
satisfiable, given more than 100 or so variables.  The program tends
to run in time 2^(N/17) or so on these instances, but they could get
even harder as N gets larger.  These "5-5-regular" instances are the
hardest, almost always satisfiable, 3-CNF problems that I know of.

Hardest Known Instances: The hardest (based on size of 3-CNF formulae)
of any instances are 6-5-regular (each variable occurs 6 times
positively and 5 times negatively), with many of these being
unsatisfiable.  150 variable instances of these problems can take
several hours.


I'm very interested in "in practice" kinds of instances.  I wonder how
hard the NP-complete instances that actually arise in areas outside of
CS theory really are.

If you'd like to trade "hard" instances, let me know.

I may not be on the net after Christmas, because the job hunting
situation in this area is very bad.  So if you'd like the source code
for the program, let me know soon. Also, if you have any pointers to
"research programming" type jobs, I'd very much appreciate them.

Dan Pehoushek



Source code for Quine Tree Algorithm:

;;; Formal Notice: This satisfiability program may be used by anyone,
;;; anywhere, anywhen, for any reasonably good purposes; you may charge
;;; money for it, or not, as you like.  It is not gauranteed to be bug
;;; free, of course.
;;; Signed, Dan Pehoushek.
