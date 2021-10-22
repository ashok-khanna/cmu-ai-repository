Description:

 	GENESIS (GEneral NEural SImulation System) is a general purpose
simulation platform which was developed to support the simulation of neural
systems ranging from complex models of single neurons to simulations of
large networks made up of more abstract neuronal components.  Most current
GENESIS applications involve realistic simulations of biological neural
systems.  Although the software can also model more abstract networks, other
simulators are more suitable for backpropagation and similar connectionist
modeling.

GENESIS and its graphical front-end XODUS are written in C and run on SUN
and DEC graphics work stations under UNIX (Sun version 4.0 and up, Ultrix
3.1, 4.0 and up), and X-windows (versions X11R3, X11R4, and X11R5).  The
current version of GENESIS has also been used with Silicon Graphics (Irix
4.0.1 and up) and the HP 700 series (HPUX).  The distribution includes full
source code and documentation for both GENESIS and XODUS as well as fourteen
tutorial simulations.  Documentation for these tutorials is included, along
with three papers that describe the general organization of the simulator. 
 
Improvements and New Features:

	The version of GENESIS which you will find here (ver. 1.4.1, August
1993), is greatly improved over the original July 1990 distribution which was
previously available at this site.

Over the past two years, there have been significant improvements in the
numerical methods which may be used with GENESIS.  There are now eleven
methods for numerical integration in GENESIS, including two fast implicit
methods which use Hines' method.  The use of these last two methods greatly
increases the speed, stability and accuracy of GENESIS simulations.

When choosing a neural simulator, the reliability and accuracy of the
simulator is an even more important consideration than its speed.  For this
reason, we have developed the "Rallpacks" suite of benchmarks for speed and
accuracy.  [Bhalla, et al. (1992) Trends Neurosci. 15: 453-458.]  These are
also available on this ftp site.  The three sets of benchmarks model a
linear passive cable with many compartments, a highly branched cable, and a
linear axon containing Hodgkin-Huxley channels.  The simulator results may
be compared to the exact analytic solutions (for the first two cases) and to
the results given by GENESIS and by NEURON, another popular neural
simulator.  (The results for these two simulators show nearly identical
speed and accuracy.)

In addition to numerous bug fixes, this new GENESIS release has a printable
reference manual and much-improved on-line help, the ability to be compiled
with X11R5 and Openwindows, and an easier installation procedure than the
old one.  Many improvements have been made to the Neurokit cell building
environment and the associated cell reader, which allows cells to be
constructed from a data file.  The library of channel models taken from
experimental data has been greatly extended, and new features for channel
editing have been added.

There have been many additions to the libraries of basic simulation
components ("objects") and built-in functions.  Some of the more important
ones are:

    table-driven channels and gates which allow one to create
    voltage-dependent channels with properties taken from experimetal data,
    rather than from approximate fits to functions of the Hodgkin-Huxley
    form,

    ojects for creating concentration-dependent channel conductances, such as
    Ca-dependent K channels,

    dendro-dendritic synapses,

    objects to provide magnesium blocking for NMDA channels,

    objects to simulate a population of ion channel proteins (pores) which
    undergo Markov kinetics,

    new routines for use in searches of large parameter spaces.

Finally, there have been many additions to the collection of simulation
scripts in the Scripts directory.  In addition to demonstrations which
illustrate GENESIS features and techniques for programming simulations,
there are a number of interactive tutorials for teaching concepts in
neurobiology and neural modeling.  As their use requires no knowldge of
GENESIS programming, they are suitable for use in a computer simulation
laboratory which would accompany upper division undergraduate and graduate
neuroscience courses.  Each of these has on-line help and a number of
suggested exercises or "experiments" which may be either assigned as
homework or used for self-study.  These tutorials may also be taken apart
and modified to create your own simulations, as they are reasonably well
commented.  Several of them are derived from existing research simulations.

These tutorial simulations form the basis of Part I of "The Book of GENESIS"
by James M. Bower and David Beeman, to be published in early 1994 by
TELOS/Springer-Verlag.  Part II is intended to teach the use of the GENESIS
script language for the construction of one's own simulations.  This part
will be useful for self-study by researchers who wish to do neural modeling,
as well as by students.

For a detailed listing of the changes from the original distribution, see the
file README.changes in the unpacked GENESIS distribution.

GENESIS Users Group (BABEL):

	Due to the large number of requests for GENESIS, we are not able to
provide help or support for those who acquire GENESIS through this ftp site.
Therefore, we strongly encourage serious users of GENESIS to join the
GENESIS Users Group, BABEL.  Members of BABEL are entitled to access the
BABEL directories and email newsgroup.  These are used as a repository for
the latest contributions by GENESIS users and developers.  These include new
simulations, libraries of cells and channels, additional simulator
components, new documentation and tutorials, bug reports and fixes, and the
posting of questions and hints for setting up GENESIS simulations.  As the
results of GENESIS research simulations are published, many of these
simulations are being made available through BABEL.  New developments are
announced in a newsletter which is sent by email to all members.

Membership in BABEL requires that a one time $200 registration fee payable
to the California Institute of Technology be sent c/o Jim Bower,
Computational Neural Systems Program, 216-76, Caltech, Pasadena, CA, 91125.
In addition to providing your name, institution, mailing address and phone
number (optional), please provide the email address at which you would like
to receive communications from BABEL.  In order to set up an account for you
on the BABEL computer, we will also need a user name of eight characters or
less.

 Installation:

	The first step is to use ftp to download the file 'genesis.tar.Z'.
After using ftp to connect to genesis.cns.caltech.edu, and giving your login
name and password, give the ftp command "binary".  Then give the command
"get genesis.tar.Z".  The file may take a while to transfer if you do this
at a time when networks are busy.  You may download the 'rallpack.tar.Z'
benchmark set in a similar manner.  Finally, give the "quit" command.

Next, change to the directory in which you wish the GENESIS directory tree
to reside and give the unix command "zcat genesis.tar.Z | tar xvf -".  This
will create the directory 'genesis' and a number of subdirectories.  Begin
by reading the README file in the 'genesis' directory.  Directions for
compiling and installing the software may be found in the README file
contained in the 'src' subdirectory.  Directions for printing and using the
documentation may be found in 'Doc/README'.  The 'Scripts/README' file
describes the demonstration and tutorial simulations which are included with
this distribution.

Copyright notice:

Copyright (c) 1993 by California Institute of Technology (Caltech).

Permission to use, copy, modify, and distribute this software and
documentation for any purpose and without fee is hereby granted, provided
that the above copyright notice appear in all copies and that both that
copyright notice and this permission notice appear in supporting
documentation, and that the name of Caltech not be used in advertising or
publicity pertaining to distribution of the software without specific,
written prior permission.  Caltech makes no representations about the
suitability or merchantability of this software for any purpose.  It is
provided "as is" without express or implied warranty.
