
			  Lambda Prolog V2.7
			       July 1988

			___         __________
		       |   |       |    __    |
		       |   |       |   |__|   |
		       |   |       |   _______|
		       |   |___    |   |
		       |       |   |   |
		       |_______|   |___|


		  An experimental implementation of a
			 higher-order logic
			programming lanugage.



			     DALE MILLER
		   Computer and Information Science
		      University of Pennsylvania
			Philadelphia, PA 19104
			    (215) 898-1593
		       dale@linc.cis.upenn.edu


			   GOPALAN NADATHUR
		     Computer Science Department
			   Duke University
			  Durham, NC  27706
			    (919) 684-3048
			 gopalan@cs.duke.edu



	     (c) 1988 by Dale Miller and Gopalan Nadathur



This version of lambda Prolog is an amended form of Version 2.6. It
also contains the source code for bringing up lambda Prolog under
Quintus Prolog (Version 2.0). The following comments, made in the
context of Version 2.6, provide a background to our efforts in the
context of lambda Prolog.


Comments on lambda Prolog (From Version 2.6)
============================================

Version 2.6 of lambda Prolog is the first version that is intended for
distribution. This version, as also the ones from which it is derived,
was intended as an experimental environment in which we could test out
some of our recent ideas regarding extensions to logic programming. It
is important to note that our extensions have generally been based on
extensions to the underlying logical foundations of logic programming.
We did not set out to provide features which solved certain software
development/engineering/verification goals, although we do hope that
these extensions will provide some insight into these aspects of logic
programming.  Rather, our primary curiousity has been about the
extensions to the logic in and of themselves.  We wanted to know if we
could learn to write programs in these extensions and, if so, to
discover how these new programs might be different from those written
in other programming paradigms. We now believe that significant new
programs can be written in the extensions that we have incorporated
into Lambda Prolog.  Some evidence to this effect is present in the
papers described in the documentation on Lambda Prolog.

Although this version of Lambda Prolog is not our final one, it
represents about as far as we wish to go using C-Prolog (or any other
dialect of Prolog) as the implementation language. This version
provides a clean implementation of many things (although some things
also had rather ugly implementations).  However, almost nothing has
been implemented efficiently, owing first to the fact that this has
not been a major concern and then to the fact that C-Prolog does not
provide us with a satisfactory set of data structures for doing so.
While efficiency will be a primary concern in our future
implementations, this experimental and slow implementation has taught
us a lot.  Hopefully, others might learn from it also.

There has been a wide spread belief that higher-order unification
(which is implemented in v2.6) is a very inefficient mechanism.  We
have not come up with an implementation which would be considered
efficient, say, by WAM standards.  We have also not come up with
control mechanisms for the search which occurs inside unification.  We
have, however, learned the following things about higher-order
unification:

(1) It is a necessary feature in certain programming tasks.  We see
    programming in the area of proof systems, program transformations, 
    and natural language understanding systems as areas which require 
    this operation or something which is closely related to it.

(2) The use of higher-order unification can provide very clear, simple
    and provably correct implementations in the areas just listed.
    If the first concern is understanding and specifying programs in 
    such areas, then lambda Prolog should provide a useful tool. 
    Furthermore, following the adage that "If you really understand 
    something well, you can make it faster", we believe that issues of
    efficiency may be dealt with later.

(3) Lambda reduction, and not higher-order unification, seems to be the
    major bottleneck in our implementation.  There are several well-known
    schemes that may be used for implementing lambda reduction more 
    efficiently. These generally involve the use of pointers, something
    not available in C-Prolog, and experimenting with them might very well
    provide an acceptable implementation of Lambda Prolog.

(4) Higher-order unification, as a computation mechanism, is often
    difficult to use.  This is, of course, largely due to the fact 
    that it is relatively new.  There have been only a handful of papers 
    on the subject and, that too, only during the past 15 years.  Once 
    more examples have been studied, it should be easier to put this 
    mechanism to work in programs.



About this version
==================

The collection of files which form this version of lambda Prolog
are available from duke at the locations indicated below:

~ftp/pub/lp2.7/README
	This document.

~ftp/pub/lp2.7/src/*.pro
	These are the C-Prolog sources which implement
	the lambda Prolog interpreter

~ftp/pub/lp2.7/src-quintus/*.pl
        The Quintus Prolog (Version 2.0) sources that implement
        the lambda Prolog interpreter

~ftp/pub/lp2.7/sysmods/*.mod
	These are the "system modules," that is, lambda Prolog modules
	which are be loaded at start-up time.

~ftp/pub/lp2.7/examples/
	Contains several subdirectories with sample lambda Prolog 
        programs.  Most	subdirectories contain a README file describing 
        the examples and providing a pointer to where more detailed 
        information may be found.

~gopalan/lp2.7/doc
	Contains documentation on lambda Prolog: Some features of the 
        system are explained, a guide to installing it under either 
        C-Prolog or Quintus is provided and papers that are of relevance 
        to lambda Prolog are listed.



Acknowledgements
================

We are indebted to Conal Elliott, Amy Felty and Frank Pfenning for
their willingness to use early versions of lambda Prolog at a stage
when even we found it difficult to do so. Their comments and also
those of John Hannan and Elsa Gunter have been extremely useful in the
updates that resulted in this version. The conversion from C-Prolog to
Quintus is due largely to Fernando Pereira. Nadathur is grateful to
acknowledge the support received from NSF grant MCS-82-19196 during
the early stages of this work and over the last year and a half from a
Burroughs Contract.  Miller is grateful to acknowledge the support
received from ARO grant DAAG-29-84-K-0061 and DARPA grant
N000-14-85-K-0018.


