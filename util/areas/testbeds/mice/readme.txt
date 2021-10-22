MICE version 2.0/MacMICE version 3.0

The Michigan Intelligent Coordination Experiment (MICE) testbed is a
tool for experimenting with coordination between intelligent systems
under a variety of conditions.   MICE simulates a two-dimensional
grid-world in which agents may move, communicate, and affect their
environment.  MICE is essentially a discrete-event simulator that helps
control the domain and a graphical representation, but provides
relatively few constraints on the form of the domain and the agents'
abilities.  Users may specify the time consumed by various agent activities,
the constraints on an agents' sensors, the configuration of the domain
and its properties, etc.

MICE runs under Xwindows on Un*x boxes, on Macs, and on TI Explorers, with
relatively consistent graphical displays.  Source code, documentation,
and examples are available via anonymous ftp to ftp.eecs.umich.edu
in the compressed, tar'd file software/Mice/Mice.tar.Z . A MICE that runs
on Macs with graphics user interface was recently added and is available
via anonymous ftp to ftp.eecs.umich.edu in the compressed, tar'd file
software/Mice/MacMICE.tar.Z .

MICE was produced by the University of Michigan's Distributed Intelligent
Agent Group (UM DIAG).  The contact address for information/help is :
        umdiagmice@caen.engin.umich.edu

Here's the reference for a paper describing MICE :

@inproceedings{montgomery:90,
         author = "Thomas A. Montgomery and Edmund H. Durfee",
         title = "Using {MICE} to Study Intelligent Dynamic Coordination",
         booktitle = "Proc. IEEE Conf. on Tools for AI",
         month = nov,
         year = 1990
        }

;  Copyright 1991, 1992, 1994
;  Regents of the University of Michigan
;  
;  Permission is granted to copy and redistribute this software so long as
;  no fee is charged, and so long as the copyright notice above, this
;  grant of permission, and the disclaimer below appear in all copies made.
;  
;  This software is provided as is, without representation as to its fitness
;  for any purpose, and without warranty of any kind, either express or implied,
;  including without limitation the implied warranties of merchantability and fitness
;  for a particular purpose.  The Regents of the University of Michigan shall not
;  be liable for any damages, including special, indirect, incidental, or
;  consequential damages, with respect to any claim arising out of or in
;  connection with the use of the software, even if it has been or is hereafter
;  advised of the possibility of such damages.


If you use this software, please let us know so that we can keep you abreast
of changes, bug fixes, etc.  If you have anything to report, feel free.
Hope you enjoy MICE!

                                     -  The UM-DIAG

Email address: umdiagmice@caen.engin.umich.edu

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

MICE documentation is provided in the MICE manual, which is in Latex and 
PostScript form in this directory (miceman.tex and miceman.ps).  If you 
need a hardcopy of this manual because you cannot generate Latex documents 
or cannot print PostScript files at your site, let us know.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


<> How to install MICE on UNIX platforms

   1. First ftp Mice_README and Mice.tar.Z 
      (You already did this. Don't forget to set ftp to binary mode)

	$ ftp -i ftp.eecs.umich.edu
	ftp> binary
	ftp> cd software/Mice
 	ftp> mget Mice_README Mice.tar.Z
	ftp> quit
      
   2. Uncompress Mice.tar.Z and tar Mice.tar

	$ uncompress Mice.tar.Z
	$ tar xvf Mice.tar 

   3. Tar creates directory called 'Mice', and you're ready to compile.

   4. Change directory to Mice and run your Common Lisp.

	$ cd Mice
	$ cl       --> Run your common lisp
	<cl> (load "compilemice.lisp")

   5. Load Mice.

	<cl> (load "loadmice.lisp")

   6. You can test example files in the subdirectory EXAMPLES. 
      
      6.1 If you are running Mice in a X-window environment, you don't have to 
          modify the example file. If you are running Common Lisp on remote
          machine, and want to display Mice on your screen, set the *hostname*
          variable to your hostname. You can find an example in the 
          cnet-Start.lisp file. eg. (setf *hostname* "my-machine") 

      6.2 If you are running Mice on a plain terminal (e.g. vt100), you have 
	  to set the  *graphics?* variable to nil. 
          Edit cnet-Start.lisp file, find the line (setf *graphics?* t), 
          and change it to (setf *graphics?* nil).

	<cl> ;;(setf *hostname* "my-machine")
	<cl> (chdir "EXAMPLES")
        <cl> (load "cnet-Start.lisp")
	<cl> (mice "pursuit.env") or just (run)
	<cl> ;; Enjoy Mice

   
<> How to install MICE on Mac 

MICE currently runs on Macintosh Allegro Common Lisp (MACL) Version 1.3.2.
A new version which runs on MCL version 2.0 is also available. 

<> How to install MICE for MCL 2.0 on Mac

Loading Guide:

   1. First ftp Mice_README and Mice.tar.Z to a UNIX machine.
      (You already did this. Don't forget to set ftp to binary mode)

	$ ftp -i ftp.eecs.umich.edu
	ftp> binary
	ftp> cd software/Mice
 	ftp> mget Mice_README MacMICE.tar.Z
	ftp> quit
      
   2. Uncompress MacMICE.tar.Z and tar MacMICE.tar

	$ uncompress MacMICE.tar.Z 
	$ tar xvf MacMICE.tar 

   3. Now, you have a directory called 'MacMICE' on your UNIX machine.
      In this directory you will find:
      1) MacMICE.sea.hqx - self-extracting MacBinary folder contining MacMICE in BinHex.
      2) Mice_README - this file.
      3) micemaillist.txt - a list of people to contact if you have problems.
      4) miceman.ps - MICE manual in Postscript format.
      5) miceman.tex - MICE manual in LaTex format.

   4. Download the file MacMICE.sea.hqx to your Macintosh.
      (if you are using FTP, use ascii mode to transfer.)

   5. Use BinHex 4.0 of higher to convert MacMICE.sea.hqx into MacMICE.sea .

   6. Double click on MacMICE.sea to self-extract MacMICE.
      A folder called MacMICE will be created.

   7. Please read the file "MacMICE User Manual" inside the MacMICE folder for
      proper installation and further information.

<> How to install MICE for MACL Version 1.3.2 on Mac

To run MICE on the Mac, you need to have MACL properly installed with the
"Library" and "Examples" folders of MACL properly in place.  Specifically,
it is expected that the following files are in the "Library" folder under
MACL:  TRAPS.lisp, RECORDS.lisp, and QUICKDRAW.lisp

Do not try to place any files inside the 'MICE Folder' elsewhere unless
you are comfortable with MACL programming and can customize the file
"mac-mice-init.lisp" to your needs.

Loading Guide:

   1. First ftp Mice_README and Mice.tar.Z to a UNIX machine.
      (You already did this. Don't forget to set ftp to binary mode)

	$ ftp -i ftp.eecs.umich.edu
	ftp> binary
	ftp> cd software/Mice
 	ftp> mget Mice_README Mice.tar.Z
	ftp> quit
      
   2. Uncompress Mice.tar.Z and tar Mice.tar

	$ uncompress Mice.tar.Z 
	$ tar xvf Mice.tar 

   3. Now, you have a directory called 'Mice' on your UNIX machine.

   4. On your MAC, create the following folders:
      1) A folder called 'MICE Folder'.
      2) A sub-folder inside the 'MICE Folder' called 'MICE'.
      3) A sub-folder inside the 'MICE Folder' called 'MICE Examples. 

   5. Transfer the MICE files inside the 'Mice' directory on your UNIX machine
      to the Macintosh folders you have just created as follows:
      (Transfer can be done by Mac Telnet or other text file transfer programs
       such as Kermit)
      1) Transfer all files in the 'Mice' directory to the 'MICE' folder inside
         the 'MICE Folder'(except the ones inside the 'EXAMPLES' subdirectory
         under the UNIX 'Mice' directory).
      2) Transfer all files in the 'EXAMPLES' subdirectory to the 
         'MICE Examples' folder.
      3) Now, move the "mac-mice-Init.lisp" file inside the Macintosh 'MICE' 
         folder out of that folder and to the parent 'MICE Folder'.

   6. Now, run MACL and 'Open' the "mac-mice-Init.lisp" file, and 'Save' it. 
      This will change the file type from TEXT to MACL. Quit MACL. From now on,
      you need only double click on "mac-mice-Init.lisp" file to start off 
      MACL and MICE.

   7. Double click on "mac-mice-Init.lisp" to start off MACL and load MICE.

   8. Ignore warning messages.

   9. A dialogue box asking whether to automatically load MICE will appear.
      Press the 'YES' button.

   10. A dialogue box asking whether to automatically load the demo files
      (Contract-net example of pursuit task) will appear.  Respond as you
      wish.

   11. For better performace, load in the "mac-compilemice.lisp" file 
       which can be found inside the 'MICE' folder. This automatically compiles
       the MICE files into "fast-loadable" form.

<> How to install MICE on TI Explorer

   1. First ftp Mice_README and Mice.tar.Z 
      (You already did this. Don't forget to set ftp to binary mode)

	$ ftp -i ftp.eecs.umich.edu
	ftp> binary
	ftp> cd software/Mice
 	ftp> mget Mice_README Mice.tar.Z
	ftp> quit
      
   2. Uncompress Mice.tar.Z and tar Mice.tar

	$ uncompress Mice.tar.Z 
	$ tar xvf Mice.tar 

   3. Now, you have a directory called 'Mice'.

   4. Copy across to your TI explorer.

   5. Edit the defsystem file to point to the appropriate pathname.

   6. Load the defsystem file.

   7. Make the mice system (  (make-system 'mice)  ).

   8. To try out the example, load in cnet-Start.lisp from
      the EXAMPLES.CNET directory, and type "(run)"
