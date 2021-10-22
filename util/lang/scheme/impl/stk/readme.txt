ANNOUNCING STk 2.1
------------------

STk is a Scheme interpreter which can access to the Tk graphical package.
Concretely it can be seen as the J. Ousterhout's Tk package where
the Tcl language has been replaced by Scheme. STk also provides a full OO
system, called STklos, which is close from CLOS or Dylan. 


Features of STk
---------------

* interpreter is conform to R4RS

* Clos/Dylan syntax like OO extension named STklos. STklos provides 
  multiple inheritance, generic functions, multi methods, a true meta object
  protocol. This extension is written in C and is usable now (this was far to
  be the case in previous releases  :->  )

* Interpreter can be easily extended by adding new C modules.

* All the commands defined by the Tk toolkit are available to the STk
  interpreter (tk commands are seen as a special type of objects by the
  interpreter).  

* Callback are expressed in Scheme 

* supports Tk 3.6

* Tk variables (such are -textvariable) are reflected back into Scheme 
  as Scheme variables.

* A set of STklos classes have been defined to manipulate Tk commands 
  (menu, buttons, scales, canvas, canvas items) as Scheme objects.

* New widgets can easily be built in Scheme by composition of existing
  widgets.

* On Sun hardware running SunOs 4.1.x: 
       - Ability to dynamically load '.o' file
       - Ability to create file images to store the interpreter state

Machines
--------

STk runs on the following machines

	- Sparc (SunOs 4.1.x && Solaris 2.3)
	- Dec 5xxx (Ultrix 4.2)
	- SGI (IRIX 4.05 and IRIX 5.1.1)  -- Thanks to Steve Olson 
					     (olson@juliet.ll.mit.edu)
	- DEC Alpha 3000/400 (OSF-1 V1.3) -- Thanks to Dirk Grunwald
					     (grunwald@foobar.cs.colorado.edu)
	- Linux 1.0

Difference from previous releases
---------------------------------

Version 2.1
This is a major release version. 
    
	- STklos (the object layer) is now written in C. It is more than 120
	  times faster than before and it uses less memory (~ 100)!!!!
	- Improvement of STklos 
	- STklos classes have been written for all the Tk library widgets
	- Composites widgets can be easily defined in STklos. Access to those
	  widgets is identical to C written one.
	- bindings can be now true lambda expression with their own
	  environment (rather than list which are evaluated in the global 
	  environment).
	- Hash tables have been added.	
	- Small constants are coded on a pointer rather than a cell
    	- Support for dynamic loading on SunOs (4 and 5). Dynamic loading
      	  uses shared objects (it should work also on OSF1)
	- Dump creates now smaller images.
	- Modification of configure and Makefiles to correct of a lot 
	  of installation problems.
	- Runs on Solaris 2.3
	- Bugs corrections 
	- Some modification to the error notifier
	- ...


Version 2.0 
This version contains a completely rewritten Scheme interpreter. This new
interpreter is
        - R4RS
        - faster than previous release (~ 3 or 4 times)
        - less bugged (I hope :-) )
        - implements integers (32 bits and bignum) and floats
        - cleaner with macros 

This version contains also a prototype of a graphical inspector which permits
to see/modify a variable value. For widgets variables it permits to modify
interactively their behaviour. 

Mailing list
------------

There is now a mailing list for STk. To subscribe the mailing list just send
a mail at stk-request@kaolin.unice.fr with the word "subscribe" in the
Subject: line.


Distribution
------------

You can take a release of STk on kaolin.unice.fr (193.48.229.225) by anonymous
ftp in /pub/STk-2.1.tar.gz

Please send comments, ideas, bug reports (or better: bug fixes) to eg@unice.fr

Enjoy.
 

-------------------------------------------------------------------------------
Erick Gallesio					  tel : (33) 92-96-51-53
ESSI - I3S					  fax : (33) 92-96-51-55
Universite de Nice - Sophia Antipolis		email : eg@unice.fr
Route des colles
BP 145
06903 Sophia Antipolis CEDEX
-------------------------------------------------------------------------------
