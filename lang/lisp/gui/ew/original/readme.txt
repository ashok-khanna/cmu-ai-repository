



Hopefully you have already successfully loaded everything into a directory
on your sun.  

Refer to ./doc/installation.text for information on how to install and run Express Windows.





Description of the Sub Directories.

clos	- The files for PCL from Xerox Parc.
clx	- The files for CLX from Texas Instruments as distributed with the
	  MIT X11-R3 tape.
code	- The source code and binaries for Express Windows.
doc	- Minimal documentation of Express Windows.

Description of the Files in the top directory:

load-ew.lisp	- The File for loading EW.

Other important files to look at.

./code/defsystem.lisp - definition of loading procedure of EW code.

./code/symbols.lisp - definition of symbols necessary for EW.

./code/sym-comp.lisp - definition of macros and symbols to make EW compatible with
Symbolics.

NOTE: between ./code/symbols.lisp and ./code/sym-comp.lisp you can make a complete listing
of the interesting symbols defined by EW.



Refer to the file ./code/READ_ME for brief descriptions of the files in that directory.

NOTE:
When using EW it helps to have your program in its own package that does not inherit from
USER.  Define your package like the following:

(in-package 'simulator :use 'lisp)

(import '(fpcl:defmethod fpcl:defflavor pcl:make-instance)
	'simulator)

(import '(ew::formatting-table
	   ew::formatting-row ew::formatting-cell
	   ew:define-presentation-to-command-translator
	   ew:accept ew:present ew:boolean
	   ew:define-presentation-type
	   ew:define-presentation-translator
	   ew:self
	   ew:send
	   )
	'simulator)


Don't forget to set the variable below to the name of the host
for the display.  It's original definition is in
code/x-interface.lisp
(defvar ew::*Default-Host* "Electro")
