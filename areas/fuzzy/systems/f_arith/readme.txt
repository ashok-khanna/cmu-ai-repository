
			FUZZY ARITHMETIC LIBRARY
			     (alpha version)

	This package contains a very simple implementation of a fuzzy
number representation using confidence intervals, together with the basic
arithmetic operators and trigonometrical functions.


	The library is written in the C++ language and has been tested
with Borland C++ 3.1 and djgpp 1.11 under Ms-Dos, and with gcc 2.5.8 under
Linux and Hp-Ux. Provided codes, although tested, are to be considered as
alpha version: USE THEM AT YOUR OWN RISK.


	No manual is available yet. Print and read carefully the paper
provided into paper.dvi: it contains a brief explanation of our work and
points out the critical cases. In particular, see section 2.4. about
the multiple occurrence problem: at Dipartimento di Matematica we 
implemented the described algorithms in a previous FORTRAN libray but 
I did not ported them into the current C++ library yet. 
You can also refer to the book

		A. Kaufmann, M.M. Gupta
		Introduction to Fuzzy Arithmetic: Theory and Applications
		Van Nostrand Reinhold
		New York, 1991


	The library is available by anonymous FTP from the server of
Dipartimento di Matematica (Universita' di Catania, Italy):

  -	ftp to mathct.dipmat.unict.it (151.97.252.1), 
	log on as 'anonymous' and give your user ID as password.

  -	change directory into 'fuzzy' (the system is a VAX running VMS)
	and change trasmission method to binary.

  -	get the files fznum*.zip (msdos) or fznum*.taz (unix tar and
	compress) or fznum*.tgz (unix tar and gzip).


	The library IS NOT FREE SOFTWARE: you can freely use and
distribute it provided that:

  -	you cite me (Salvatore Deodato) and Dipartimento di Matematica
	of Universita' di Catania (Italy) in all your derived works.

  -	you send me an e-mail writing what is your interest in fuzzy
	arithmetic, your comments on the package and your use of it.

	
	I would be grateful for bug reports (even better, fixes): I will
try to support you as well as my current job will allow me that. Do
send me your enhancements too, and I will try to incorporate them in
future releases.

------------------------------------------------------------------
Salvatore Deodato, October 1994

Dipartimento di Matematica
Universita' di Catania
viale Andrea Doria,6
I-95125 CATANIA (Italy)

e-mail: deodato@dipmat.unict.it


