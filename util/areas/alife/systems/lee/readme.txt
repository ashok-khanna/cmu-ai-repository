==========================
LEE release 1.1
Latent Energy Environments
==========================

This directory contains materials related to the Latent Energy
Environments (LEE) software package. LEE is an artificial life 
simulator which can be used to evolve populations of neural
networks adapting to environments of increasing complexity.

The files in this directory are maintained by fil@ucsd.edu
and correspond to the latest LEE Release. The same source code 
(written in C) works for both the Unix and Macintosh platforms.
The only difference is that the Macintosh version requires a
few extra files.

Below follows a descriptions of the files in the directory.
You must use the Unix 'unshar' utility to retrieve the source
and/or executable files. 

LEE is (c) University of California, San Diego. 
Authors: Richard Belew and Filippo Menczer. Please send 
important comments, suggestions, and bugs to the latter
(fil@ucsd.edu). You may freely copy/distribute the software, 
except for commercial purposes, and as long and the notices 
in the source headers are preserved.

Filename         Format                 Content
----------------------------------------------------------------
README           ASCII                  general info (this file)
lee.doc          ASCII                  documentation
pinep.ps.Z       compressed PostScript  LEE model/results paper
lee11.Unix.sh    ASCII shar archive     LEE 1.1 Unix source
lee11.Mac.sh     mixed shar archive     LEE 1.1 Mac add'l source
lee11exe.Mac.sh  binhexed shar archive  LEE 1.1 Mac executables
----------------------------------------------------------------

LIST OF RELATED PAPERS (as of February 1994)
============================================

Menczer F and Belew RK 'Latent Energy Environments: A Model
for Artificial Life Complexity' Technical Report CS93-298,
July 1993, University of California, San Diego

Menczer F and Belew RK 'Latent Energy Environments: A Tool
for Artificial Life Simulations' Technical Report CS93-301,
July 1993, University of California, San Diego

Menczer F 'Changing Latent Energy Environments: A Case
for the Evolution of Plasticity' Technical Report CS94-336,
January 1994, University of California, San Diego

(*) Menczer F and Belew RK 'Latent Energy Environments' to appear
in "Plastic Individuals in Evolving Populations", Santa Fe
Institute Studies in the Sciences of Complexity, Addison-Wesley

(*) This paper is available on this ftp site as
    'pinep.ps.Z'. You can use 'uncompress paper.ps' to get 
    the Postscript format, and 'lpr paper.ps' to print.
    An abstract follows:

A novel ALife model and simulator, called LEE, is introduced
and described. The motivation lies in the need for a measure
of complexity across different ALife experiments. This goal is
achieved through a careful characterization of environments in
which different forms of energy are well-defined and
conserved. A steady-state genetic algorithm is used to model
the evolutionary process. Organisms in the population are
modeled by neural networks with non-Lamarckian learning during
life. Behaviors are shown to be crucial in the interactions
between organisms and their environment. The flexibility of
LEE for the study of a variety of problems related to complex
evolutionary systems is illustrated by some general emerging
properties of the model, and by preliminary results of a
number of experiment currently under way.

	===
        Filippo Menczer and Richard K. Belew
	Cognitive Computer Science Research Group
	Dept. of Computer Science and Engineering, 0114
	University of California, San Diego
	La Jolla, CA 92093-0114 USA
	Fax: (619)534-7029
	Email: fil@ucsd.edu
	===
