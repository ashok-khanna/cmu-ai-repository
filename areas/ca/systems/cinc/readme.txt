Cinc - The NeXT Creatures Simulator

Cinc is an implementation of the Creatures processing model for the NeXT. Creatures attempts to retain many of the attractive features of CA while allowing dynamic systems to be studied more easily. This is done by describing the active elements of a system, rather than the space in which they live.

Consider a simple model of road traffic - on a CA we must describe roads as either holding cars or not, then passing cars between them. The negotiation to support this rappidly swamps and cnsideration of what the CARS are doing. With Creatures we describe the cars - after all everyone knows what a car does!

The net result of this is a simulation environment that allows emergent behaviour to be studied easily, and models to be built rapidly without a great deal of programming experience - just describe what all the bits do, and what they do when they meet.

Once written and debugged on a NeXT, the same (or at least VERY similar) code may be run on  a CM-2(pretty fast) or a MasPar(very fast). This allows you to test models when very large numbers of elements are active.

Further details of Creatures may be ftp'd from shiraz.ohm.york.ac.uk.

Instalation
========
Cinc.app should be placed in an Apps drectory.
pancake and cinb should be placed in a bin.
The include directories indicated in Rules/makefile should be changed to point to Cinc.app.
Double click Cinc, then open Traffic.pos and Traffic.o from the positions and rules directories.
Click start.
Try the inspector...
Try some other rules/positions...

after that you should probably read the manual!

Get in touch if you think this software may be of use to you, as we may be able to offer some support to anyone interested in developing simulations.
Ian Stephenson
ian@ohm.york.ac.uk