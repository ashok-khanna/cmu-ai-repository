		       ISABELLE-92 (beta release)

Isabelle is a generic theorem prover.  New logics are introduced by
specifying their syntax and rules of inference.  Proof procedures can be
expressed using Standard ML.

We are pleased to announce a new version of Isabelle supporting type
classes.  This type system lies between that of ML and Haskell.  It allows
the definition of polymorphic object-logics with overloading and automatic
type inference.  Isabelle-92 includes many other improvements, great and
small, over previous versions.  Unfortunately, the new release is NOT
upwards compatible with Isabelle-91 its predecessors.  

Isabelle-92 provides a high degree of automation:

* A generic package supports classical reasoning in first-order logic, set
theory, etc.

* A generic simplifier performs rewriting by reflexive/transitive
relations like = and <->.  It solves rewritten goals by application of
a user-supplied tactic.  It handles conditional rewrite rules and can
perform automatic case splits.  It also supports contextual extraction of
rewrite rules.

Isabelle-92 can support a wide variety of logics, and comes with several
built-in ones:

* many-sorted first-order logic, constructive and classical versions
* higher-order logic, similar to that of Gordon's HOL
* Zermelo-Fraenkel set theory
* an extensional version of Martin-L\"of's Type Theory
* the classical first-order sequent calculus LK
* the modal logics T, S4, and S43
* the Logic for Computable Functions, LCF
* the Lambda Cube

Isabelle's Zermelo-Fraenkel set theory derives a theory of functions,
well-founded recursion, and several recursive data structures (including
mutually recursive trees and forests).  Higher-order logic has similar
features.  Both logics are sufficiently developed to support high-level proofs.

Isabelle-92 includes comprehensive (although preliminary) documentation:

* "Introduction to Isabelle" explains the basic concepts at length, and
gives examples. (61 pages)

* "The Isabelle Reference Manual" documents nearly all most of Isabelle's
facilities, apart from particular object-logics. (78 pages)

* "Isabelle's Object-Logics" describes the various logics supplied with
Isabelle. (145 pages)

The electronic mailing list isabelle-users@cl.cam.ac.uk provides a forum
for Isabelle users to discuss problems and exchange information.  To join,
send a message to isabelle-users-request@cl.cam.ac.uk.

---------------------------------------------------------------------------

Isabelle-92 is available by anonymous ftp from the University of Cambridge.
Instructions:

* Connect to host ftp.cl.cam.ac.uk [128.232.0.56]
* Use login id "ftp" with your internet address as password
* put ftp in BINARY MODE ("binary") 
* go to directory ml (by typing "cd ml")
* "get" the desired files from that directory.  

The following files are relevant:

intro.dvi.Z		"Introduction to Isabelle"
ref.dvi.Z		"The Isabelle Reference Manual"
logics.dvi.Z		"Isabelle's Object-Logics"
Isabelle92.tar.Z	the Isabelle-92 beta distribution

Here is a sample dialog:

   ftp
   ftp> open ftp.cl.cam.ac.uk
   Name: ftp
   Password: <your internet address>
   ftp> binary
   ftp> cd ml
   ftp> get intro.dvi.Z
   ftp> get ref.dvi.Z
   ftp> get logics.dvi.Z
   ftp> get Isabelle92.tar.Z
   ftp> quit

Isabelle-92 is also available from the Technical University of Munich.
Instructions:

* Connect to host ftp.informatik.tu-muenchen.de [131.159.0.110]
* Use login id "ftp" with your internet address as password
* put ftp in BINARY MODE ("binary") 
* go to directory lehrstuhl/nipkow (by typing "cd lehrstuhl/nipkow")
* "get" the desired files from that directory.  

NOTE: the addresses 128.232.0.56 and 131.159.0.110 are supplied for
convenience and are correct as of 25/8/92, but such addresses are subject
to change over time.  The names ftp.cl.cam.ac.uk and
ftp.informatik.tu-muenchen.de are preferable.

---------------------------------------------------------------------------

Once transferred, the files can be unpacked at your local site.

The files intro.dvi.Z, ref.dvi.Z and logics.dvi.Z should be uncompressed
before printing, using the command

   uncompress intro.dvi.Z ref.dvi.Z logics.dvi.Z

The file Isabelle92.tar.Z should be uncompressed, then extracted using tar:

   uncompress -c Isabelle92.tar.Z | tar xf -

This will add a directory called 92 (for Isabelle-92) to the current
directory.  The new directory should contain around 30 files, including 10
subdirectories.  Its total size is under 1.6 megabytes.

The file COPYRIGHT contains the Copyright notice and Disclaimer of Warranty.

The file README contains instructions for compiling Isabelle.

---------------------------------------------------------------------------

Lawrence C Paulson		E-mail: Larry.Paulson@cl.cam.ac.uk 
Computer Laboratory 		Phone: +44-223-334600
University of Cambridge 	Fax:   +44-223-334678
Pembroke Street 
Cambridge CB2 3QG 
England

Tobias Nipkow 		  	E-mail: Tobias.Nipkow@informatik.tu-muenchen.de
Institut f\"ur Informatik	Phone: +49-89-21052690
TU M\"unchen			Fax:   +49-89-21058183
Postfach 20 24 20
D-8000 M\"unchen 2
Germany
