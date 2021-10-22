        This directory contains a version in C of the program FOIL - FOIL5.1

	(FOIL5.1 is a modification to FOIL5.0 to fix a recently discovered 
bug which dates back to FOIL2).

        The file "MANUAL" contains an explanation of the form of the input and
the options. The file "OVERVIEW" contains a description of the method used
by FOIL.

        The executable version of the program may be made with the command
"make foilgt" (or "make foil5" for the slower version for debugging).

        A trivial example input file, "list.d", is provided to demonstrate
the program, and may be used with the command "foil5 < list.d". The output
from this is given in "list.out" - as it contains execution time information,
the results from your system may well differ in this respect! Further comments
on list.d and list.out are provided in list.explain.

        Several other example files (*.d) are also provided for your use. The
names of these should be sufficiently mnemonic to enable recognition from
the literature.

	In addition to the example input files, the program c4tofoil.c
for converting files from the format used by C4.5 to that used by FOIL is also 
provided to enable use of input files in the C4.5 format, now that FOIL
can handle continuous variables and missing values. An example file
(Quinlan's credit example data) has been provided, with a names file augmented
as required to demonstrate the use of this additional program. For further
details on use of the program, see its header.

        This version of FOIL was produced by Mike Cameron-Jones deriving from
the original by Ross Quinlan. Hence, queries, bug reports, improvements,
etc should be sent to me, Mike Cameron-Jones (mcj@cs.su.oz.au), in the first
instance. In the event that I don't reply to you adequately quickly, get
in touch with Ross Quinlan (quinlan@cs.su.oz.au).

	I'd appreciate it if you could mail me to let me know you've taken
a copy of FOIL, so that we have some idea who has copies.

                Mike Cameron-Jones, 10th May 1993.
