BELIEF is a package of Common Lisp functions which are designed to
manipulate graphical belief models.  It uses the Shenoy and Shafer
version of the algorithm, so one of its unique features is that it
supports both probability distributions and belief functions.  It also
has limited support for second order models (probability distributions
on parameters).  

Keywords:  Belief functions (Dempster-Shafer), Bayesian Probability,
Graphical Models (Bayes Nets), 2nd order models.

Two versions are currently available via anonymous ftp from
ftp.stat.washington.edu (128.95.17.34).

BELIEF 1.1 --- Old version ran under Lucid Lisp 3.0, with some
incomplete attempts at ports to AKCL and VaxLisp.  Written before
Steele[1990] (CLtL-2)  Some known bugs and portions of code which were
written but not fully debuged.

BELIEF 1.2 --- Attempt to track changes from X3J13 and be compatable
with Allegro's multiprocessing stuff.  Works well on Allegro 4.0, but
I haven't tried it on any other version of Lisp.  More thoroughly
tested, no known bugs (but some unknown ones).

There will probably be annoying little problems on other lisps, many
of them having to do with the fact that ANSI Common LISP is still
rather a moving target.  I will be happy to give email support to
people trying to get it up on other versions of LISP  (I'm
particularly interested in problems installing the new version on
Lucid Lisp, which I don't have.)

Currently, I'm working on a project called "GRAPHICAL-BELIEF."  This
will be a commercial version of BELIEF which will include interactive
graphical displays and bundled knowledge acquisition tools.  After
GRAPHICAL-BELIEF becomes more solid, I hope to re-release the core
inference engine back into the public domain as BELIEF 2.0.

I continue to be interested in corresponding with anybody who is doing
graphical modelling with BELIEF or belief functions.


			Russell Almond			   
StatSci (a division of MathSoft, Inc.)
1700 Westlake Ave., N Suite 500		
Seattle, WA  98109			
(206) 283-8802				
almond@statsci.com			
