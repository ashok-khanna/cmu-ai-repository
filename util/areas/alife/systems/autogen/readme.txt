Autogen v0.1					Date: 09/24/93

by George Kampis

University of Tubingen, Germany
ELTE University, Hungary
(kampis@ludens.elte.hu)


I. The Theory: From Homogeneous Systems to Autocatalytic Units

This program simulates the self-organizing behavior of a random catalytic 
chemical network of abstract molecules, starting from homogeneous initial 
conditions. It consists of a quadratic field where a point corresponds 
to a given type of molecule, and a third dimension, usually represented as 
color (but see II.(b) iii), corresponds to the amount of the given molecule.

Molecules can exert catalytic activity towards one or more of their 
"neighbours" (defined by the minimum of a city block or Manhattan metric over 
the field), and can develop or "forget" their catalytic properties during the 
simulated process, according to simple rules. New catalytic activity can be
interpreted as an effect attributed to the emergence of new substrates and/or 
the changing composition of the system.

Substrate recognition is not modelled in the present form of the system.
Any molecule can serve as the substrate for any catalytic reaction (a solution
not preferred by nature on grounds of stochiometry, among other things). As a 
result, we observe a materials transfer from regions of low catalytic activity
to regions of high catalytic activity, formed spontaneously. That leads to
various types of interesting behavior.

The detailed rules can be best defined in the form of a set of operators that 
act on the field:

	Produce		produce new components catalytically
	Consume		use components as substrates
	NewArrow	assign new catalytic properties
	Put		produce new components randomly (a sort of noise)
	Remove		remove components randomly
	Delete		garbage collection: delete catalytic activity of 
				killed components
	Display		well, display!

Each of the pairs Produce-Consume and Put-Remove conserves the overall amount 
of molecules in the system. Consume, Remove and Put use a uniform random 
integer decomposition algorithm to allocate molecules to their operation.
A simulation means the execution, in a given arbibrary order, of the full set
of operators in every time step.

In a wide range of initial conditions a stable autocatalytic limit organization 
is found to emerge. This illustrates the selective capability of systems 
with self-modifying properties. 


A simpler early simulation along similar lines was published in: 
	Csanyi, V. and Kampis, G. 1987: A Computer Model of Autogenesis,
	Kybernetes 16, 169-181.

A publication (with color plates) about the current system is:
	Kampis, G. 1993: Computing Beyond the Machine Metaphor,
	in: (Paton, R. ed.): Computing With Biological Metaphors,
	Chapman and Hall, London, to appear.


II. The Program

(a) This distribution contains the following files:

          2120 Sep 24 16:50 GNOME.doc		- the GNOME project
          7988 Sep 24 16:50 README		- this file
         13755 Sep 24 16:50 anim.exe		- player for flic animation
         78389 Sep 24 16:50 autogen.exe		- main simulation pgm
        289848 Sep 24 16:50 autogen.fli		- a 3D animated run
         49644 Sep 24 16:50 curgen.exe		- for alpha terminal only
         72596 Sep 24 16:50 f0100.zip		- archived results
        115389 Sep 24 16:50 f0101.zip		- archived results
        135344 Sep 24 16:50 f0503.zip		- archived results
          8464 Sep 24 16:50 flispeed.exe	- set fli animation speed
         19793 Sep 24 19:10 pkunzip.exe		- dearchiver
         45749 Sep 24 16:50 vgaplay.exe		- player for the "f" files
        101087 Sep 24 19:17 3Dray.zip		- 3D raytracing snapshot, big!

You need 1-2 MB room on the HD, depending on how much you want to install.

(b) There are three ways of viewing autogenesis to develop:

	i - run your own simulation

	Say "autogen" at the DOS prompt. Needs VGA or better! Yet you will
	be annoyed to see that the biggest simulation-field you can get is
	30x30 (60x60 on the screen). Autogen is no video game - it uses 
	combinatorial random algorithms, several cellular automata buffers, 
	and floating-poit arithmetics on large arrays. This v0.1 uses real 
	mode only.

	Command line options: autogen <prob1> <prob2> <stepno>
	Prob1 is the probability by which at time zero a molecule is assigned 
	acatalytic activity towards any particular neighbor.
	Prob2 is the probability that a molecule will develop a new catalytic
	activity (per one time step).
	Stepno is the number of simulation steps to be performed.
	Defaults are 0.5, 0.3, and 100, in the above order.

	What do you see: you see no connections (catalytic links) but molecule
	numbers, represented as color.

	Another possibility for running a simulation is to say "curgen"
	at the DOS prompt. Command line optinons are identicalas before.
	This gives you a 12x25 field that fills out the alphanumeric screen,
	with catalytic links represented as arrovs and arrow-like characters,
	and double links (elementary cross-catalytic loops) as H and =,
	respectively. In this form, the dynamics of interactiuons can be also
	studied.


	ii - play records of selected 100x100 simulations

	Currently, records of three test runs are supplied. Computation time
	for these was well in the order of a dozen minutes on a 17 MIPS 
	(6,5 MFLOP) machine.
	
	First you have to dearchive a few files. Say "pkunzip f*".
	This will produce f0100.bin, f0101.bin, f0503.bin.
	You need about 1 MB room on your HD.
	
	Then say "vgaplay file.bin", where "file" is one of these:

	f0100 = (prob1=0.1, prob2=0, stepno=20)
	f0101 = (prob1=0.1, prob2=0.1, stepno=40)
	f0503 = (prob1=0.5, prob2=0.3, stepno=50)

	Gives a nice view. Its a little slow - I did not want to
	progam my SVGA card directly. Next time (or never).


	iii - play a 3D animation

	Say "anim autogen.fli". It offers a §D view of a height field
	generated on the basis of simulations data. The vertical co-ordinate
	is the amount of a given type of molecule.

	If it is too slow/fast for you,
	just say "flispeed autogen.fli /S#", where # is a positive integer.
	1 gives maximal speed, but dont try that. Good choices are between 
	10 and 20. 

	If you want to have an impression of how this looks *in the original*,
	(on a UNIX workstation), view the file 3Dray.tiff. Its a 24-bit
	picture, most most viewers and most VGA and SVGA cards use "dirty 
	tricks" to produce a picture optically quite close to truecolor.
	Why this cant be animated on the PC, is the size of the files.
	After decompressing, this one is alone 800 kB big!


III. To Do

There exist versions of the Autogen system with 

	- prohibited double links
	- a variety of further initial conditions
	- built-in precursors (small autocatalytic loops at time zero)
	- a pipette to drop molecules and subsystems at runtime
	- larger simulation fields
	- slightly different rules

You get more info about these in the publications mentioned in I. 
PD versions and DOS ports are pending.

Still further versions are thinkable, such as more than two-dimensional
reaction fields, or reaction fields without a geometry. Alternatively, the
introduction of a spatial component is also entertained, and a still more 
advanced idea, that of multiple-level simulations is already in the progress.


IV. Further Research

(a) An Exercise

Write a program that automatically updates a README file such that the 
length of this README file in the directory listing (inlcuded in that very
README file) will be correct. Just as in this file. (No tricky solutions pls,
such as all README-s having the same length perforce, and the like.)

(b) An Open-Ended Problem

Elaborate the topics of autocatalysis, self-reprodcution, and self-reference.
What do they have to do with each other?
-----------------------------------------------------------------------------

Have fun! GK.
