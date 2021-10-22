**********************************************************************
   SNNS (Stuttgart Neural Network Simulator) Version 2.1 available
**********************************************************************

SNNS (Stuttgart Neural Network Simulator) is a  software simulator for
neural networks  on Unix  workstations developed at the Institute  for
Parallel  and  Distributed  High  Performance  Systems (IPVR)  at  the
University of Stuttgart.  The goal of the SNNS project is to create an
efficient  and  flexible  simulation  environment for research  on and
application of neural nets.

The SNNS simulator consists of two main components:

1) simultor kernel written in C
2) graphical user interface under X11R4 or X11R5

The simulator kernel operates  on the internal network data structures
of the neural nets and performs all operations of learning and recall.
It can also be used without the other parts as a C program embedded in
custom  applications. It supports arbitrary  network  topologies  and,
like RCS, supports the concept of  sites. SNNS can  be extended by the
user with user defined activation  functions, output  functions,  site
functions and learning  procedures, which  are  written  as  simple  C
programs and linked to the simulator kernel.

Currently the following learning procedures are included:

 * backpropagation
	vanilla (online) BP
	BP with momentum term and flat spot elimination
	batch BP
 * counterpropagation, 
 * quickprop
 * backpercolation 1
 * generalized radial basis functions (RBF)

Later  versions  will  include recurrent Elman networks, ART1, ARTMAP,
ART2, time delay networks (TDNN) and some other network paradigms.

The graphical  user interface XGUI (X Graphical User Interface), built
on top of the kernel, gives  a 2D and a 3D graphical representation of
the neural networks and controls the kernel during the simulation run.
In addition, the 2D user interface  has  an integrated  network editor
which  can be used to directly create, manipulate and visualize neural
nets in various ways.


**********************************************************************
	New features of SNNSv2.1
**********************************************************************

Version 2.1 of SNNS features the following improvements and extensions
over the earlier version 2.0:

 * fixes for a number of bugs in the software and documentation
 * improved font selection for easier installation
 * graphical representation of learning error development
 * improved and documented batch training and testing
 * inversion method as network analyzing tool for feedforward networks
 * improved file selection mechanism
 * improved display color selection
 * inclusion of a comprehensive radial basis functions package
 * postscript output of displayed networks
 * result file generation
 * standalone network result analyzing tools
 * weight display with hinton diagramms
 * graphical representation of unit activation and output functions
 * parallel kernel for MasPar MP-1 systems 
   (completed but not publicly available yet) 
 * more initialization, activation, update, and learning functions
 * changed calculation of network error during training 
   (factor 1/2 omitted in calculating the cumulative error)
 * new and improved manual


**********************************************************************
	Machine architectures on which SNNSv2.1 is available
**********************************************************************

We  have tested  SNNSv2.1  on  the  following  machines  and operating
systems:

machine type			OS    		user interface with
 
SUN Sparc SLC, ELC, SS2 GX, GS	SunOS 4.1.1	X11R4, X11R5, OW 3.0  
DECstation 2100,3100, 5000/200	Ultrix V4.2	X11R4, X11R5
IBM RS 6000/320, 320H		AIX V3.1	X11R4, X11R5
HP 9000/720, 730		HP/UX 8.0.7	X11R4, X11R5
IBM-PC 80386, 80486		Unix  		X11R4, X11R5

The current distribution supports color or B/W  Sun  4 (Sparc) systems
and DecStations under the original X11R4 or X11R5 (Athena widget  set,
twm,  MIT fonts) or Sun OpenWindows 3.0, IBM RS/6000  systems with AIX
and HP 9000/7xx systems with  HP/UX 8.0.7 and HP VUE  and 386  or  486
IBM-PC clones under Unix (e.g. Linux) and X11R4 or X11R5.


**********************************************************************
	SNNSv2.1 licensing terms (short)
**********************************************************************

SNNSv2.1 is available NOW free of charge for research purposes under a
GNU-style copyright  agreement. See the license agreement in  the user
manual and in the file Readme.license of the distribution for details.
SNNS is (C) Copyright Universitaet Stuttgart, IPVR.

SNNSv2.1 can only be  obtained by anonymous ftp over the Internet. See
the detailed  description of how  to obtain SNNS below. We  don't have
the  time  and capacity  to send tapes or floppy  disks, so don't ask.
SNNSv2.1 is also too large to be  mailed  by e-mail, so don't ask  for
that,  either.  You  may,  however,  obtain  the  unmodified  SNNSv2.1
distribution from other sites  which already have obtained  it,  under
the terms  of our license agreement, if you  are  unable to connect to
our machine.

Note that SNNS has not been tested  extensively  in different computer
environments and is a research tool with frequent substantial changes.
It should be obvious that WE DO NOT GUARANTEE ANYTHING. 

We  are also not staffed  to answer problems with SNNS or to  fix bugs
quickly.


**********************************************************************
	How to obtain SNNSv2.1
**********************************************************************

The SNNS simulator can be obtained via anonymous ftp from host

        ifi.informatik.uni-stuttgart.de  (129.69.211.1)

in the subdirectory        /pub/SNNS
as file
        SNNSv2.1.tar.Z			(0.826 MB)

or in several parts as files

        SNNSv2.1.tar.Z.aa  ...  SNNSv2.1.tar.Z.ae

These split files are each less than 300 KB and can be joined with the
Unix `cat' command  into one file SNNSv2.1.tar.Z .  Be sure to set the
ftp mode to binary before  transmission of the  files.  Also watch out
for possible higher version numbers,  patches  or Readme  files in the
above directory /pub/SNNS .  After successful transmission of the file
move it to the directory where you want  to  install  SNNS, uncompress
and extract the file with the Unix commands

        uncompress SNNSv2.1.tar.Z	
        tar -xvf SNNSv2.1.tar

The   SNNS  distribution  includes  full   source  code,  installation
procedures  for  supported  machine  architectures   and  some  simple
examples of trained networks.

The PostScript version of the user manual can be obtained as file 

	SNNSv2.1.Manual.ps.Z		(1.04 MB)

or in several parts as files

        SNNSv2.1.Manual.ps.Z.aa  ...  SNNSv2.1.Manual.ps.Z.ae
	
These must be  concatenated with 'cat', uncompressed and the resulting
file should then  print on any PostScript  printer with enough memory.
Again remember to set the ftp  mode to  binary before  transmission of
the file(s).

The full English  documentation as LaTeX source  code with  PostScript
images included can be found as file

	SNNSv2.1.Manual.src.tar.Z	(1.07 MB)

A printed version of  the manual of SNNSv2.1 is available  from  us at
the  cost  of printing and  postage  (DM  20.- in  Europe,  US $  20.-
overseas, this includes surface mail postage).


======================================================================
Dr. Andreas Zell                      zell@informatik.uni-stuttgart.de
Univ. Stuttgart, IPVR, Breitwiesenstr. 20-22, D-7000 Stuttgart 80, FRG
======================================================================

