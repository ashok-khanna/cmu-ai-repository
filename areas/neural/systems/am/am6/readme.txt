
The following describes a neural network simulation environment
made available free from the MITRE Corporation. The software
contains a neural network simulation code generator which generates
high performance ANSI C code implementations for modular backpropagation 
neural networks. Also included is an interface to visualization tools.

		  FREE NEURAL NETWORK SIMULATOR
			   AVAILABLE

		        Aspirin/MIGRAINES 

			   Version 6.0

The Mitre Corporation is making available free to the public a
neural network simulation environment called Aspirin/MIGRAINES.
The software consists of a code generator that builds neural network
simulations by reading a network description (written in a language
called "Aspirin") and generates an ANSI C simulation. An interface 
(called "MIGRAINES") is provided to export data from the neural
network to visualization tools. The previous version (Version 5.0)
has over 600 registered installation sites world wide.

The system has been ported to a number of platforms:

Host platforms:
	convex_c2	/* Convex C2 */
	convex_c3	/* Convex C3 */
	cray_xmp        /* Cray XMP */
	cray_ymp        /* Cray YMP */
	cray_c90        /* Cray C90 */
	dga_88k         /* Data General Aviion w/88XXX */
	ds_r3k          /* Dec Station w/r3000 */
	ds_alpha        /* Dec Station w/alpha */
	hp_parisc       /* HP w/parisc */ 
	pc_iX86_sysvr4  /* IBM pc 386/486 Unix SysVR4 */
	pc_iX86_sysvr3  /* IBM pc 386/486 Interactive Unix SysVR3 */
	ibm_rs6k        /* IBM w/rs6000 */
	news_68k        /* News w/68XXX */
	news_r3k        /* News w/r3000 */
	next_68k	/* NeXT w/68XXX */
	sgi_r3k 	/* Silicon Graphics w/r3000 */
	sgi_r4k 	/* Silicon Graphics w/r4000 */
	sun_sparc	/* Sun w/sparc */
	sun_68k		/* Sun w/68XXX */
 
Coprocessors:
	mc_i860		/* Mercury w/i860 */
	meiko_i860	/* Meiko w/i860 Computing Surface */



Included with the software are "config" files for these platforms. 
Porting to other platforms may be done by choosing the "closest"
platform currently supported and adapting the config files.


New Features
------------
		- ANSI C ( ANSI C compiler required! If you do not
		  have an ANSI C compiler,  a free (and very good) 
		  compiler called gcc is available by anonymous ftp
		  from prep.ai.mit.edu (18.71.0.38). ) 
		  Gcc is what was used to develop am6 on Suns.

		- Autoregressive backprop has better stability
		  constraints (see examples: ringing and sequence),
		  very good for sequence recognition

		- File reader supports "caching" so you can
		  use HUGE data files (larger than physical/virtual
		  memory).

		- The "analyze" utility which aids the analysis
		  of hidden unit behavior (see examples: sonar and
		  characters)

		- More examples

		- More portable system configuration
		  for easy installation on systems
		  without a "config" file in distribution
Aspirin 6.0
------------

The software that we are releasing now is for creating, 
and evaluating, feed-forward networks such as those used with the 
backpropagation learning algorithm. The software is aimed both at 
the expert programmer/neural network researcher who may wish to tailor
significant portions of the system to his/her precise needs, as well
as at casual users who will wish to use the system with an absolute
minimum of effort. 

Aspirin was originally conceived as ``a way of dealing with MIGRAINES.''
Our goal was to create an underlying system that would exist behind
the graphics and provide the network modeling facilities.
The system had to be flexible enough to allow research, that is, 
make it easy for a user to make frequent, possibly substantial, changes
to network designs and learning algorithms. At the same time it had to 
be efficient enough to allow large ``real-world'' neural network systems
to be developed. 

Aspirin uses a front-end parser and code generators to realize this goal. 
A high level declarative language has been developed to describe a network.
This language was designed to make commonly used network constructs simple 
to describe, but to allow any network to be described.  The Aspirin file 
defines the type of network, the size and topology of the network, and 
descriptions of the network's input and output. This file may also include
information such as initial values of weights, names of user defined 
functions.

The Aspirin language is based around the concept of a "black box".
A black box is a module that (optionally) receives input and
(necessarily) produces output.  Black boxes are autonomous units
that are used to construct neural network systems.  Black boxes
may be connected arbitrarily to create large possibly heterogeneous 
network systems. As a simple example, pre  or post-processing stages 
of a neural network can be considered black boxes that do not learn.

The output of the Aspirin parser is sent to the appropriate code 
generator that implements the desired neural network paradigm. 
The goal of Aspirin is to provide a common extendible front-end language 
and parser for different network paradigms. The publicly available software
will include a backpropagation code generator that supports several
variations of the backpropagation learning algorithm.  For backpropagation
networks and their variations, Aspirin supports a wide variety of 
capabilities: 
	1. feed-forward layered networks with arbitrary connections
        2. ``skip level'' connections 
	3. one and two-dimensional weight tessellations
        4. a few node transfer functions (as well as user defined)
	5. connections to layers/inputs at arbitrary delays,
	   also "Waibel style" time-delay neural networks
	6. autoregressive nodes.
	7. line search and conjugate gradient optimization

The file describing a network is processed by the Aspirin parser and
files containing C functions to implement that network are generated.
This code can then be linked with an application which uses these
routines to control the network. Optionally, a complete simulation 
may be automatically generated which is integrated with the MIGRAINES
interface and can read data in a variety of file formats. Currently
supported file formats are:
	Ascii
	Type1, Type2, Type3 Type4 Type5 (simple floating point file formats)
	ProMatlab

Examples
--------

A set of examples comes with the distribution:

xor: from RumelHart and McClelland, et al,
"Parallel Distributed Processing, Vol 1: Foundations",
MIT Press, 1986, pp. 330-334.

encode: from RumelHart and McClelland, et al,
"Parallel Distributed Processing, Vol 1: Foundations",
MIT Press, 1986, pp. 335-339.

bayes: Approximating the optimal bayes decision surface
for a gauss-gauss problem.

detect: Detecting a sine wave in noise.

iris: The classic iris database.

characters: Learing to recognize 4 characters independent
of rotation.

ring: Autoregressive network learns a decaying sinusoid
impulse response.

sequence: Autoregressive network learns to recognize
a short sequence of orthonormal vectors.

sonar: from  Gorman, R. P., and Sejnowski, T. J. (1988).  
"Analysis of Hidden Units in a Layered Network Trained to
Classify Sonar Targets" in Neural Networks, Vol. 1, pp. 75-89.

spiral: from  Kevin J. Lang and Michael J, Witbrock, "Learning
to Tell Two Spirals Apart", in Proceedings of the 1988 Connectionist
Models Summer School, Morgan Kaufmann, 1988.

ntalk: from Sejnowski, T.J., and Rosenberg, C.R. (1987).  
"Parallel networks that learn to pronounce English text" in 
Complex Systems, 1, 145-168.

perf: a large network used only for performance testing.

monk: The backprop part of the monk paper. The MONK's problem were
the basis of a first international comparison
of learning algorithms. The result of this comparison is summarized in
"The MONK's Problems - A Performance Comparison of Different Learning
algorithms" by S.B. Thrun, J. Bala, E. Bloedorn, I.  Bratko, B.
Cestnik, J. Cheng, K. De Jong, S.  Dzeroski, S.E. Fahlman, D. Fisher,
R. Hamann, K. Kaufman, S. Keller, I. Kononenko, J.  Kreuziger, R.S.
Michalski, T. Mitchell, P.  Pachowicz, Y. Reich H.  Vafaie, W. Van de
Welde, W. Wenzel, J. Wnek, and J. Zhang has been published as
Technical Report CS-CMU-91-197, Carnegie Mellon University in Dec.
1991.

wine: From the ``UCI Repository Of Machine Learning Databases 
and Domain Theories'' (ics.uci.edu: pub/machine-learning-databases).

Performance of Aspirin simulations
----------------------------------

The backpropagation code generator produces simulations
that run very efficiently. Aspirin simulations do
best on vector machines when the networks are large,
as exemplified by the Cray's performance. All simulations 
were done using the Unix "time" function and include all 
simulation overhead. The connections per second rating was
calculated by multiplying the number of iterations by the
total number of connections in the network and dividing by the
"user" time provided by the Unix time function. Two tests were 
performed. In the first, the network was simply run "forward" 
100,000 times and timed. In the second, the network was timed
in learning mode and run until convergence. Under both tests
the "user" time included the time to read in the data and initialize
the network.

Sonar:

This network is a two layer fully connected network
with 60 inputs: 2-34-60. 
				Millions of Connections per Second
	Forward:               
	  SparcStation1:                    1
	  IBM RS/6000 320:                  2.8
	  HP9000/720:                       4.0
	  Meiko i860 (40MHz) :              4.4
	  Mercury i860 (40MHz) :            5.6
	  Cray YMP:                         21.9
	  Cray C90:                         33.2
	Forward/Backward:
	  SparcStation1:                    0.3
	  IBM RS/6000 320:                  0.8
	  Meiko i860 (40MHz) :              0.9
	  HP9000/720:                       1.1
	  Mercury i860 (40MHz) :            1.3
	  Cray YMP:                         7.6
	  Cray C90:                         13.5

Gorman, R. P., and Sejnowski, T. J. (1988).  "Analysis of Hidden Units
in a Layered Network Trained to Classify Sonar Targets" in Neural Networks,
Vol. 1, pp. 75-89.

Nettalk:

This network is a two layer fully connected network
with [29 x 7] inputs: 26-[15 x 8]-[29 x 7]
				Millions of Connections per Second
	Forward:               
	  SparcStation1:                      1
	  IBM RS/6000 320:                    3.5
	  HP9000/720:                         4.5
	  Mercury i860 (40MHz) :              12.4
	  Meiko i860 (40MHz) :                12.6
	  Cray YMP:                           113.5
	  Cray C90:                           220.3
	Forward/Backward:
	  SparcStation1:                      0.4
	  IBM RS/6000 320:                    1.3
	  HP9000/720:                         1.7
	  Meiko i860 (40MHz) :                2.5
	  Mercury i860 (40MHz) :              3.7
	  Cray YMP:                           40
	  Cray C90:                           65.6

Sejnowski, T.J., and Rosenberg, C.R. (1987).  "Parallel networks that
learn to pronounce English text" in Complex Systems, 1, 145-168.

Perf:

This network was only run on a few systems. It is very large
with very long vectors. The performance on this network
is in some sense a peak performance for a machine.

This network is a two layer fully connected network
with 2000 inputs: 100-500-2000
				Millions of Connections per Second
	Forward:               
	 Cray YMP               103.00
	 Cray C90               220
	Forward/Backward:
	 Cray YMP               25.46
	 Cray C90               59.3

MIGRAINES 
------------

The MIGRAINES interface is a terminal based interface
that allows you to open Unix pipes to data in the neural
network. This replaces the NeWS1.1 graphical interface
in version 4.0 of the Aspirin/MIGRAINES software. The
new interface is not a simple to use as the version 4.0
interface but is much more portable and flexible.
The MIGRAINES interface allows users to output
neural network weight and node vectors to disk or to
other Unix processes. Users can display the data using
either public or commercial graphics/analysis tools.
Example filters are included that convert data exported through
MIGRAINES to formats readable by:

	- Gnuplot 3
	- Matlab
	- Mathematica
	- Xgobi

Most of the examples (see above) use the MIGRAINES
interface to dump data to disk and display it using
a public software package called Gnuplot3.

Gnuplot3 can be obtained via anonymous ftp from:

>>>> In general, Gnuplot 3  is available as the file gnuplot3.?.tar.Z 
>>>> Please obtain gnuplot from the site nearest you. Many of the major ftp
>>>> archives world-wide have already picked up the latest version, so if
>>>> you found the old version elsewhere, you might check there.
>>>> 
>>>> NORTH AMERICA:
>>>> 
>>>>      Anonymous ftp to dartmouth.edu (129.170.16.4)
>>>>      Fetch
>>>>         pub/gnuplot/gnuplot3.?.tar.Z
>>>>      in binary mode.

>>>>>>>> A special hack for NeXTStep may be found on 'sonata.cc.purdue.edu' 
>>>>>>>> in the directory /pub/next/submissions. The gnuplot3.0 distribution 
>>>>>>>> is also there (in that directory).
>>>>>>>>
>>>>>>>> There is a problem to be aware of--you will need to recompile. 
>>>>>>>> gnuplot has a minor bug, so you will need to compile the command.c
>>>>>>>> file separately with the HELPFILE defined as the entire path name
>>>>>>>> (including the help file name.) If you don't, the Makefile will over
>>>>>>>> ride the def and help won't work (in fact it will bomb the program.)

NetTools
-----------
We have include a simple set of analysis tools
by Simon Dennis and Steven Phillips.
They are used in some of the examples to illustrate
the use of the MIGRAINES interface with analysis tools.
The package contains three tools for network analysis:

	gea - Group Error Analysis
	pca - Principal Components Analysis
	cda - Canonical Discriminants Analysis

Analyze
-------
"analyze" is a program inspired by Denis and Phillips'
Nettools. The "analyze" program does PCA, CDA, projections, 
and histograms. It can read the same data file formats as are 
supported by "bpmake" simulations and output data in a variety 
of formats. Associated with this utility are shell scripts that 
implement data reduction and feature extraction. "analyze" can be
used to understand how the hidden layers separate the data in order to
optimize the network architecture.


How to get Aspirin/MIGRAINES
-----------------------

The software is available from two FTP sites, CMU's simulator
collection and UCLA's cognitive science machines.  The compressed tar
file is a little less than 2 megabytes.  Most of this space is
taken up by the documentation and examples. The software is currently
only available via anonymous FTP.

> To get the software from CMU's simulator collection:

1. Create an FTP connection from wherever you are to machine "pt.cs.cmu.edu"
(128.2.254.155). 

2. Log in as user "anonymous" with password your username.

3. Change remote directory to "/afs/cs/project/connect/code".  Any
subdirectories of this one should also be accessible.  Parent directories
should not be. ****You must do this in a single operation****:
	cd /afs/cs/project/connect/code

4. At this point FTP should be able to get a listing of files in this
directory and fetch the ones you want.

Problems? - contact us at "connectionists-request@cs.cmu.edu".

5. Set binary mode by typing the command "binary"  ** THIS IS IMPORTANT **

6. Get the file "am6.tar.Z"

7. Get the file "am6.notes"

> To get the software from UCLA's cognitive science machines:

1. Create an FTP connection to "ftp.cognet.ucla.edu" (128.97.8.19)
(typically with the command "ftp ftp.cognet.ucla.edu")

2. Log in as user "anonymous" with password your username.

3. Change remote directory to "pub/alexis", by typing the command "cd pub/alexis"

4. Set binary mode by typing the command "binary"  ** THIS IS IMPORTANT **

5. Get the file by typing the command "get am6.tar.Z"

6. Get the file "am6.notes"

Other sites
-----------

If these sites do not work well for you, then try the archie
internet mail server. Send email:
	To: archie@cs.mcgill.ca
	Subject: prog am6.tar.Z
Archie will reply with a list of internet ftp sites
that you can get the software from.

How to unpack the software
--------------------------

After ftp'ing the file make the directory you
wish to install the software. Go to that
directory and type:

	zcat am6.tar.Z | tar xvf - 

	      -or-

	uncompress am6.tar.Z ; tar xvf am6.tar

How to print the manual
-----------------------

The user documentation is located in ./doc in a 
few compressed PostScript files. To print 
each file on a PostScript printer type:
	uncompress *.Z
	lpr -s *.ps

Why?
----

I have been asked why MITRE is giving away this software.
MITRE is a non-profit organization funded by the
U.S. federal government. MITRE does research and
development into various technical areas. Our research
into neural network algorithms and applications has
resulted in this software. Since MITRE is a publically
funded organization, it seems appropriate that the
product of the neural network research be turned back
into the technical community at large.

Thanks
------

Thanks to the beta sites for helping me get
the bugs out and make this portable.

Thanks to the folks at CMU and UCLA for the ftp sites.

Copyright and license agreement
-------------------------------

Since the Aspirin/MIGRAINES system is licensed free of charge,
the MITRE Corporation provides absolutely no warranty. Should
the Aspirin/MIGRAINES system prove defective, you must assume
the cost of all necessary servicing, repair or correction.
In no way will the MITRE Corporation be liable to you for
damages, including any lost profits, lost monies, or other
special, incidental or consequential damages arising out of
the use or in ability to use the Aspirin/MIGRAINES system.

This software is the copyright of The MITRE Corporation. 
It may be freely used and modified for research and development
purposes. We require a brief acknowledgement in any research
paper or other publication where this software has made a significant
contribution. If you wish to use it for commercial gain you must contact 
The MITRE Corporation for conditions of use. The MITRE Corporation 
provides absolutely NO WARRANTY for this software.

October, 1992 


  Russell Leighton                                *     *                     
  MITRE Signal Processing Center      ***        ***   ***      ***           
  7525 Colshire Dr.                 ******       ***   ***    ******          
  McLean, Va. 22102, USA           *****************************************  
                                           *****    ***   ***        ******   
  INTERNET: taylor@world.std.com,            **     ***   ***          ***    
            leighton@mitre.org                       *     *                  

