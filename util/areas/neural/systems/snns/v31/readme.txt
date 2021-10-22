**********************************************************************
   SNNS (Stuttgart Neural Network Simulator) Version 3.1 available
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
	time delay BP
 * counterpropagation, 
 * quickprop
 * backpercolation 1
 * generalized radial basis functions (RBF)
 * RProp
 * ART1
 * ART2
 * ARTMAP
 * Cascade Correlation
 * Recurrent Cascade Correlation
 * Dynamic LVQ
 * Backpropagation through time (for recurrent networks)
 * batch backpropagation through time (for recurrent networks)
 * Quickpropagation through time (for recurrent networks)
 * Kohonen feature maps


The graphical  user interface XGUI (X Graphical User Interface), built
on top of the kernel, gives  a 2D and a 3D graphical representation of
the neural networks and controls the kernel during the simulation run.
In addition, the 2D user interface  has  an integrated  network editor
which  can be used to directly create, manipulate and visualize neural
nets in various ways.


**********************************************************************
	                New features of SNNSv3.1
**********************************************************************

Version 3.1 of SNNS features the following improvements and extensions
over the earlier version 3.0:

 * implementation of the Kohonen learning algorithm
 * improved weight display; scrolling and scaling now possible
 * improved window positioning
 * extensive bug removal


**********************************************************************
	 Machine architectures on which SNNSv3.1 is available
**********************************************************************

We  have tested  SNNSv3.1  on  the  following  machines  and operating
systems:

machine type			OS    		user interface with
 
SUN Sparc SLC, ELC, SS2 GX, GS	SunOS 4.1.1	X11R4, X11R5, OW 3.0  
DECstation 2100,3100, 5000	Ultrix V4.2	X11R4, X11R5
IBM RS 6000/320, 320H		AIX V3.1	X11R4, X11R5
IBM RS 6000/520, 		AIX V3.2	X11R4, X11R5
HP 9000/720, 730		HP/UX 8.0.7	X11R4, X11R5
IBM-PC 80386, 80486		Linux  		X11R4, X11R5

The current distribution supports color or B/W  Sun  4 (Sparc) systems
and DecStations under the original X11R4 or X11R5 (Athena widget  set,
twm,  MIT fonts) or Sun OpenWindows 3.0, IBM RS/6000  systems with AIX
and HP 9000/7xx systems with  HP/UX 8.0.7 and HP VUE  and 386  or  486
IBM-PC clones under Unix (e.g. Linux) and X11R4 or X11R5.


**********************************************************************
	          SNNSv3.1 licensing terms (short)
**********************************************************************

SNNSv3.1 is available NOW free of charge for research purposes under a
GNU-style copyright  agreement. See the license agreement in  the user
manual and in the file Readme.license of the distribution for details.
SNNS is (C) Copyright Universitaet Stuttgart, IPVR.

SNNSv3.1 can only be  obtained by anonymous ftp over the Internet. See
the detailed  description of how  to obtain SNNS below. We  don't have
the  time  and capacity  to send tapes or floppy  disks, so don't ask.
SNNSv3.1 is also too large to be  mailed  by e-mail, so don't ask  for
that,  either.  You  may,  however,  obtain  the  unmodified  SNNSv3.1
distribution from other sites  which already have obtained  it,  under
the terms  of our license agreement, if you  are  unable to connect to
our machine.

Note that SNNS has not been tested  extensively  in different computer
environments and is a research tool with frequent substantial changes.
It should be obvious that WE DO NOT GUARANTEE ANYTHING. 

We  are also not staffed  to answer problems with SNNS or to  fix bugs
quickly. For questions and/or comments concerning SNNS we refer you to 
the SNNS mailing list. To subscribe, send a mail to 
  
	listserv@informatik.uni-stuttgart.de

With the one line message (in the mail body, not in the subject)

	subscribe snns <your full name>



**********************************************************************
	              How to obtain SNNSv3.1
**********************************************************************

The SNNS simulator can be obtained via anonymous ftp from host

        ftp.informatik.uni-stuttgart.de  (129.69.211.2)

in the subdirectory        /pub/SNNS
as file
        SNNSv3.1.tar.Z			(1.61 MB)

or in several parts as files

        SNNSv3.1.tar.Z.aa  ...  SNNSv3.1.tar.Z.ae

These  split  files  are  each 400 KB and can be joined  with the Unix 
`cat' command  into one  file  SNNSv3.1.tar.Z . Be sure to set the ftp
mode to binary before  transmission  of the files.  Also watch out for
possible higher version  numbers, patches or Readme files in the above
directory  /pub/SNNS .  After successful transmission of the file move
it to the  directory  where  you want to  install SNNS, uncompress and
extract the file with the Unix commands

        uncompress SNNSv3.1.tar.Z	
        tar xvf SNNSv3.1.tar

The   SNNS  distribution  includes  full   source  code,  installation
procedures  for  supported  machine  architectures   and  some  simple
examples of trained networks.

The PostScript version of the user manual can be obtained as file 

	SNNSv3.1.Manual.ps.Z		(1.29 MB)

or in eight parts as files

        SNNSv3.1.Manual.part1.ps.Z  ...  SNNSv3.1.Manual.part8.ps.Z
	
These parts are all under 1 MB in size when uncompressed and should be
printable on any PostScript printer.Again remember to set the ftp mode 
to binary before transmission of the file(s).

The full English  documentation as LaTeX source  code with  PostScript
images included can be found as file

	SNNSv3.1.Manual.src.tar.Z	(1.38 MB)

Since the changes to the SNNS  manual are minor ( except for the self-
organizing maps ), the new version of  the manual is available only in
PostScript form.  A printed version of the manual of  SNNSv3.0 plus an
extension report is  available from us at  the cost  of  printing  and 
postage (DM  20.- in Europe, US $ 20.- overseas, this includes surface 
mail postage). 

The extension report can also be found in the ftp directory as file 
	SNNSv3.1.Manual.extensions.ps.Z

 -------------------------------------------------------------------------
|Guenter W. Mamier                      mamier@informatik.uni-stuttgart.de|
|University of Stuttgart, IPVR			                          |
|Breitwiesenstrasse 20-22, 						  |
|70565 Stuttgart, Germany                           Tel.: +49 711 7816-510|
 -------------------------------------------------------------------------

