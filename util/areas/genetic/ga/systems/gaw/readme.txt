FILE
	README - introduction to the genetic algorithm workbench disk

Copyright (C) Mark Hughes 1989. All rights reserved.

WHAT IS THIS?
-------------

This file is distributed with a compressed archive containing a
program call the Genetic Algorithm Workbench and its documentation.

The program is an interactive tool/demonstration for experimentation with
genetic algorithms (see next).  It enables you to set problems (i.e. draw
a function f(x) using a mouse) and to try out different flavours of genetic
algorithm to see how well they can find the global maximum of the function.

WHAT IS A GENETIC ALGORITHM?
----------------------------

The documentation gives a far more useful explanation, but briefly:

A genetic algorithm is an optimisation/search technique based on evolution.
They are extremely effective algorithms for solving very complex multi-variable
optimisation problems and have generated interest in a wide range of
engineering fields.

HOW DO I USE THIS SOFTWARE?
---------------------------

To run the program, you must have access to an IBM compatible personal
computer running MS-DOS or PC-DOS, a mouse and an EGA compatible display.
It will work in VGA mode, but unless the VGA display is put into EGA
emulation will give a squashed display.

If you have access to such a machine, you will need to extract the files from
the archive. To extract the files, you either need a PC with one hard and one
floppy drive, or a PC with two floppy drives, one of which must be high
capacity (i.e. 1.2M or 1.44M).

If you have a hard disk, make a new directory and ensure there is at least
550K of free space on the disk. Assuming that your floppy drive is drive a:,
change to the new hard disk directory and extract the files by inserting
the distribution disk in drive a: and typing

	a:pkunzip a:gaw.zip

If you have a 1.2M drive as drive a:, and a 360K drive as drive b:, you
should insert a blank formatted (1.2M) disk in drive a:, insert the
distribution disk in drive b: and type

	a:
	b:pkunzip b:gaw.zip

The extraction should result in the following files being created in the
current directory:

	gaw.exe	- the Genetic Algorithm Workbench program

	gaw.n	- gaw manual (Unformatted ASCII text, uses Unix me macros/tbl)

	gaw.ps	- gaw manual (Postscript format)
	fig1.ps	- figure 1 for insertion in the manual (Postscript format)

	gaw.fx	- gaw manual (Epson FX80 format)
	fig1.fx	- figure 1 (Epson FX80 format)

If you have plenty of disk space, you can extract the files by copying the
file gaw.zip into an empty directory and typing

	pkuzip gaw.zip

This will have the same effect, but requires enough disk space for both the
extracted files and the archive.

The manual gives details of how to run the program.  The ".ps" files should
print out directly on any Postscript compatible printer, and the ".fx" files
should print out on an Epson FX80 or compatible dot matrix printer.

If you can't print any of these out, the file "gaw.n" is reasonably readable
with

	type gaw.n | more

or your favourite file viewer.

Apologies for the need to paste the figure into the manual by hand. Isn't 
technology wonderful?

Have fun,

Mark Hughes
256 Milton Road, Cambridge, CB4 1LQ.
mrh@camcon.co.uk

TERMS UNDER WHICH YOU MAY USE/DISTRIBUTE THIS SOFTWARE:
-------------------------------------------------------

The Genetic Algorithm Workbench program and its documentation are copyright
and may not be copied or distributed without written permission from the
author with the following exceptions:

(1) Copies of the software and this documentation may be made and passed
on to any third party provided that all the files on the distribution disk
are distributed together in unmodified form, and providing that no profit is
made from such distribution.

(2) A reasonable number of copies may be made of the software for the purpose
of archiving to guard against corruption of the working copy of the software.

The software can be used without restriction or payment, but you are
encouraged to send an appropriate contribution in sterling to the author
if you feel that the program has been of use.  See above for the author's
address.

No warranty is given that this software is fit for any purpose, nor that it
will perform as described in this manual.  You use it entirely at your own
risk.

END OF FILE: README
