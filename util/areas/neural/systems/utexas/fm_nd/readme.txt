*** Forming a 2-d topological feature map of n-d input vector data ***

What is it?
-----------

This package contains the code and data for forming a 2-d (or 1-d)
feature map of n-dimensional vector data. A good reference for feature
maps is e.g.

@Article{kohonen:map,
  author = 	"Teuvo Kohonen",
  title = 	"The Self-Organizing Map",
  journal = 	"Proceedings of the IEEE",
  year = 	"1990",
  volume = 	"78",
  number = 	"9",
  pages = 	"1464--1480"
}

This particular implementation has been used to illustrate word
representation data developed by FGREP, discussed in

@Article{miikkulainen:natural,
  author = 	"Risto Miikkulainen and Michael G. Dyer",
  title = 	"Natural Language Processing with Modular Neural
		 Networks and Distributed Lexicon",
  journal = 	"Cognitive Science",
  volume =      "15",
  number =      "3",
  year = 	"1991"
}

The code is documented and annotated in:
@PhdThesis{miikkulainen:phd,
  author = 	"Risto Miikkulainen",
  title = 	"DISCERN: {A} Distributed Artificial Neural Network Model
		 of Script Processing and Memory",
  school = 	"Computer Science Department, University of California,
	 	 Los Angeles",
  year = 	"1990",
  note = 	"Technical Report UCLA-AI-90-05"
}


What does it do?
----------------

   - 2-D (or 1-d) network with variable number of units in each dimension
   - Input vectors read from the file and cycled through
   - Random initial input weights
   - Response of a unit inversely proportional to the euclidian distance
     between the input vector and the weight vector of the unit
   - Global selection of maximally responding unit
   - Weights changed toward the input within a neighborhood of this unit

The simulation consists of phases during which the neighborhood size and
learning rate are linearly decreased. Snapshots of the simulation can be
saved to a file and the simulation can be later continued by reading in
the current state of the network from the save file. Snapshots and
endpoints of phases are defined in epochs.

The display works through HP starbase graphics or through generic
alphanumeric output. For each unit, the best input vector is shown; in
HP graphics mode, the current maximally responding unit for each input
vector is also shown. Graphics can also be turned off and network can be
developed as a background job, saving snapshots along the way. When the
save file is later read in (with display on), the first input after the
network has reached its saved state is displayed.



What do I need to run it?
-------------------------

Files needed: simufile   = simulation and network configuration parameters
                           and snapshots of the simulation (appended)
			   see README.parameters for explanation
              labelfile  = contains the character strings corresponding to 
                           vector names
	      vectorfile = the input vectors
              cmapfile   = colormap

The software was developed on HP9000 workstations, but runs at least on
Sparcstations, Decstation 5000/200, and on the Cray Y-MP. Unfortunately,
the graphics routines are based on the HP Starbase Graphics Library and
only run on the HPs (if someone ports the graphics to X, please let me
know!).

To compile it, say "make" to compile it without the graphics, and "make
sofmhp" to compile it with the graphics (on an HP). The simufile
contains the final state of the simulation described in the above paper:
To run it, say "sofm simu".



Credits etc.
------------

Copyright (C) 1987 - 1991 Risto Miikkulainen

This software can be copied and distributed freely for educational and
research purposes, provided that the source is acknowledged in any
materials and reports that result from its use. It may not be used for
commercial purposes.

I would appreciate if you would let me know of any attempts to use this
software. You can send questions, comments, bug reports and suggestions
to risto@cs.utexas.edu. However, the software is provided as is, and I
am under no obligation to maintain it. You should know that this is
software that I have used in my research, and I have not made a great
effort to clean it up for public use. If you expect to see a
polished-up, user-friendly and complete package, you'll be disappointed.
