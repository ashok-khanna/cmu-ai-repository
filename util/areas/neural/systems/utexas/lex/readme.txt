*** Self-organizing DISLEX, a double feature map model of the lexicon ***

What is it?
-----------

This package contains the code and data for self-organizing a lexicon
which consists of a feature map for lexical symbol representations, a
feature map of semantic concept representations, and associative
connections between them. A good reference for feature maps is e.g.

@Article{kohonen:map,
  author = 	"Teuvo Kohonen",
  title = 	"The Self-Organizing Map",
  journal = 	"Proceedings of the IEEE",
  year = 	"1990",
  volume = 	"78",
  number = 	"9",
  pages = 	"1464--1480"
}

The DISLEX model and the particular data in this package is discussed in:
@InProceedings{miikkulainen:dislex,
  author = 	"Risto Miikkulainen",
  title = 	"A Distributed Feature Map Model of the Lexicon",
  booktitle = 	"Proceedings of the 12th Annual Conference of the
		 Cognitive Science Society",
  year = 	"1990",
  publisher = 	"Erlbaum",
  address = 	"Hillsdale, NJ"
}

The same code was also used to develop the lexicon for DISCERN. This
implementation is discussed, and the code is documented and annotated in:
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

   - There are two square 2-D networks: lexical and semantic map
   - Input vectors representing symbols and concepts are read from a
     file and presented to the two maps simultaneously
   - Random initial input weights on both maps and on assoc connections
   - Response of a unit inversely proportional to the euclidian distance
     between the input vector and the weight vector of the unit
   - Global selection of the maximally responding unit on both maps
   - The input weights on the feature maps are changed toward the input
     within a neighborhood of this unit
   - The assoc weights are changed between units in active neighborhoods
     through Hebbian learning

The simulation consists of phases during which the neighborhood size and
learning rate are linearly decreased. Snapshots of the simulation can be
saved to a file and the simulation can be later continued by reading in
the current state of the network from the save file. Snapshots and
endpoints of phases are defined in epochs.

The display works through HP starbase graphics or through generic
alphanumeric output. For each unit in each map, the best input vector is
shown; in HP graphics mode, the current maximally responding unit for
each input vector is also shown. In the alphanumeric mode, the strongest
association for each image unit is shown. In HP graphics mode, in
addition it is possible to browse through the associative connections of
all or specified units. The connection strengths are displayed as scaled
squares.

Graphics can also be turned off and network can be developed as a
background job, saving snapshots along the way. When the save file is
later read in (with display on), the first input after the network has
reached its saved state is displayed.

The program also computes statistics on how accurately the maps
represent input vectors, and how accurate the associations are. The
association statistics do not make much sense when the mapping is
ambiguous (as is the case with the sample DISLEX data). They make more
sense with DISCERN where the mapping is one-to-one. Statistics can be
turned off during training to reduce overhead.


What do I need to run it?
-------------------------

Files needed: simufile   = simulation and network configuration parameters
                           and snapshots of the simulation (appended)
			   see README.parameters for explanation
	      inpfile    = specifies the lexical - semantic pairs for training
	      lvectorfile= representation vectors for lexical symbols
              llabelfile = character strings corresponding to lexical symbols
	      svectorfile= representation vectors for semantic concepts
              slabelfile = character strings identifying the concepts
              cmapfile   = colormap

The software was developed on HP9000 workstations, but runs at least on
Sparcstations, Decstation 5000/200, and on the Cray Y-MP. Unfortunately,
the graphics routines are based on the HP Starbase Graphics Library and
only run on the HPs (if someone ports the graphics to X, please let me
know!).

To compile it, say "make" to compile it without the graphics, and "make
lexhp" to compile it with the graphics (on an HP). The simufile contains
the final state of the simulation described in the above paper: To run
it, say "lex simu".



Credits etc.
------------

Copyright (C) 1990 - 1991 Risto Miikkulainen

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
