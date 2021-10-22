*************** Forming a 2-d feature map of unit square *******************

What is it?
-----------

This package contains the code and data for forming a 2-d (or 1-d)
feature map of uniformly distributed data on a unit square (x,y e [0 1]).
A good reference for feature maps is e.g.

@Article{kohonen:map,
  author = 	"Teuvo Kohonen",
  title = 	"The Self-Organizing Map",
  journal = 	"Proceedings of the IEEE",
  year = 	"1990",
  volume = 	"78",
  number = 	"9",
  pages = 	"1464--1480"
}

Simulations based on this particular implementation are discussed in

@InProceedings{miikkulainen:selforganizing,
  author = 	"Risto Miikkulainen",
  title = 	"Self-Organizing Process Based on Lateral Inhibition and
		 Synaptic Resource Redistribution",
  booktitle = 	"Proceedings of the International Conference on Artificial
		 Neural Networks (ICANN-91), Espoo, Finland",
  publisher = 	"North-Holland",
  address = 	"Amsterdam",
  year = 	"1991"
}



What does it do?
----------------

   - 2-D (or 1-d) network with variable number of units in each dimension
   - input uniformly distributed on a 2-D unit square
   - initial input weights uniformly distributed on the unit square
   - response of a unit inversely proportional to the euclidian distance
     between the input vector and the weight vector of the unit
   - global selection of maximally responding unit
   - weights changed toward the input within a neighborhood of this unit

The simulation consists of phases during which the neighborhood size and
learning rate are linearly decreased. Snapshots of the simulation can be
saved to a file and the simulation can be later continued by reading in
the current state of the network from the save file. Snapshots and
endpoints of phases are defined in numbers of input samples.

Generated inputs, response of the network to the current input and the
current organization of the network are graphically displayed during
simulation (on starbase graphics on the HPs). Display can also be turned
off and network can be developed as a background job, saving snapshots
along the way. When the save file is later read in (with display on),
the first input after the network has reached its saved state is
displayed.



What do I need to run it?
-------------------------

Files needed: simufile = simulation and network configuration parameters
                         and snapshots of the simulation (appended)
			 see README.parameters for explanation
              cmapfile = colormap

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
