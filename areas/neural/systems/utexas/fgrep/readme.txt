******************* FGREP - simulation package ***********************

What is it?
-----------

This package contains the code and data for nonrecurrent FGREP
simulation in the case-role assignment task, i.e. in mapping sentence
constituents into case roles, simultaneously developing distributed
representations for the words. The primary reference for the FGREP
mechanism and the data included in this package is:

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
  title = 	"DISCERN: A Distributed Artificial Neural Network Model
		 of Script Processing and Memory",
  school = 	"Computer Science Department, University of California,
	 	 Los Angeles",
  year = 	"1990",
  note = 	"Technical Report UCLA-AI-90-05"
}


What does it do?
----------------

The simulation consists of phases with different learning rates.
Snapshots of the simulation can be saved to a file and the simulation
can be later continued by reading in the current state of the network
from the save file. Snapshots and endpoints of phases can be defined in
seconds (i.e. "run until lunch") or in epochs.  Average error is printed
on the standard output after each epoch.  Network activity, weights and
representations are plotted on real time.  Display can also be turned
off and the network developed as a background job, saving snapshots along
the way. When the save file is later read in (with display on), the
first input after the network has reached its saved state is displayed.


What do I need to run it?
-------------------------

Files needed: simufile = simulation and network configuration parameters
                         snapshots of the simulation appended to simufile
			 see README.parameters for explanation
              wordfile = contains the character strings corresponding to 
                         word indeces
              cmapfile = colormap
              inputfile= sentence I/O data

Related programs:
              gbryw256  = generate 8-bitplane color map
              gener     = generate sentence I/O
              categ     = display the word categories on screen
              testfgrep = compute performance statistics

The software was developed on HP9000 workstations, but runs (with proper
conditionalization) at least on Sparcstations, Decstation 5000/200, and
on the Cray Y-MP. Unfortunately, the graphics routines are based on the
HP Starbase Graphics Library and only run on the HPs (if someone ports
the graphics to X, please let me know!).

To compile it, set the hp switch properly and say "make" to compile it
without the graphics, and "make fgrephp" to compile it with the graphics
(on an HP). The simufile contains the final state of the simulation
described in the above paper: To run it, say "fgrep simu".



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
