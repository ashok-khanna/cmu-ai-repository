From lpratt@slate.mines.colorado.edu Tue Oct 12 16:42:08 EDT 1993
Article: 12707 of comp.ai.neural-nets
Xref: crabapple.srv.cs.cmu.edu comp.ai.neural-nets:12707 comp.ai.edu:1369
Newsgroups: comp.ai.neural-nets,comp.ai.edu,csm.local,csm.mathcs.general
Path: crabapple.srv.cs.cmu.edu!honeydew.srv.cs.cmu.edu!das-news.harvard.edu!noc.near.net!howland.reston.ans.net!vixen.cso.uiuc.edu!sdd.hp.com!col.hp.com!csn!slate!lpratt
From: lpratt@slate.mines.colorado.edu (Lorien Pratt)
Subject: Announcing availalility of Motif-based neural network animator
Message-ID: <1993Oct11.174759.60727@slate.mines.colorado.edu>
Sender: lpratt@slate.mines.colorado.edu (Lorien Pratt)
Date: Mon, 11 Oct 1993 17:47:59 GMT
Organization: Colorado School of Mines
Lines: 115


                     -----------------------------------
				 Announcing 
			   the availability of an
		  X-based neural network hyperplane animator
				Version 1.01
			      October 10, 1993
                     -----------------------------------

			Lori Pratt and Steve Nicodemus
		Department of Mathematical and Computer Sciences
			  Colorado School of Mines
			      Golden, CO  80401
				    USA
			  lpratt@mines.colorado.edu


    Understanding neural network behavior is an important goal of many
    research efforts.  Although several projects have sought to
    translate neural network weights into symbolic representations, an
    alternative approach is to understand trained networks
    graphically.  Many researchers have used a display of hyperplanes
    defined by the weights in a single layer of a back-propagation
    neural network.  In contrast to some network visualization schemes,
    this approach shows both the training data and the network
    parameters that attempt to fit those data.  At NIPS 1990, Paul
    Munro presented a video which demonstrated the dynamics of
    hyperplanes as a network changes during learning.  The program
    displayed ran on a Stardent 4000 graphics engine, and was
    implemented at Siemens.

    At NIPS 1991, we demonstrated an X-based hyperplane animator,
    similar in appearance to Paul Munro's, but with extensions to allow
    for interaction during training.  The user may speed up, slow down,
    or freeze animation, and set various other parameters.  Also, since
    it runs under X, this program should be more generally usable.

    An openwindows version of this program was made available to the
    public domain in 1992.   This announcement describes a version of
    the hyperplane animator that has been rewritten for Motif.  It was
    developed on an IBM RS/6000 platform, and so is written in ANSI C.
    The remainder of this message contains more details of the
    hyperplane animator and ftp information.

------------------------------------------------------------------------------

1. What is the Hyperplane Animator?

The Hyperplane Animator is a program that allows easy graphical display
of Back-Propagation training data and weights in a Back-Propagation
neural network [Rumelhart, 1987].  It implements only some of the
functionality that we eventually hope to include.  In particular, it
only animates hyperplanes representing input-to-hidden weights.

Back-Propagation neural networks consist of processing nodes
interconnected by adjustable, or ``weighted'' connections.  Neural
network learning consists of adjusting weights in response to a set of
training data.  The weights w1,w2,...wn on the connections into any one
node can be viewed as the coefficients in the equation of an
(n-1)-dimensional plane.  Each non-input node in the neural net is thus
associated with its own plane.  These hyperplanes are graphically
portrayed by the hyperplane animator.  On the same graph it also shows
the training data.

2. Why use it?

As learning progresses and the weights in a neural net alter,
hyperplane positions move.  At the end of the training they are in
positions that roughly divide training data into partitions, each of
which contains only one class of data.  Observations of hyperplane
movement can yield valuable insights into neural network learning.

3. Platform information

The Animator was developed using the Motif toolkit on an IBM RS6000
with X-Windows.  It appears to be stable on this platform, and has not
been compiled on other platforms.  However, Dec5000 and SGI workstations
have been succesfully used as graphics servers for the animator.

How to install the hyperplane animator:

  You will need a machine which has X-Windows, and the Motif libraries.

  1. copy the file animator.tar.Z to your machine via ftp as follows:

     ftp mines.colorado.edu (138.67.1.3)
     Name: anonymous
     Password: (your ID)
     ftp> cd pub/software/hyperplane-animator
     ftp> binary
     ftp> get hyperplane-animator.tar
     ftp> quit

  2. Extract files from hyperplane-animator.tar with:
     tar -xvf hyperplane-animator.tar

  3. Read the README file there.  It includes information about
     compiling.  It also includes instructions for running a number of
     demonstration networks that are included with this distribution.

DISCLAIMER:
  This software is distributed as shareware, and comes with no warantees 
whatsoever for the software itself or systems that include it.  The authors 
deny responsibility for errors, misstatements, or omissions that may or 
may not lead to injuries or loss of property.  This code may not be sold 
for profit, but may be distributed and copied free of charge as long as 
the credits window, copyright statement in the program, and this notice 
remain intact.

-------------------------------------------------------------------------------
-- 
L. Y. Pratt                           Dept. of Math and Computer Science
lpratt@franklinite.mines.colorado.edu Colorado School of Mines    
(303) 273-3878 (work)                 402 Stratton                
(303) 278-4552 (home)                 Golden, CO 80401, USA      


