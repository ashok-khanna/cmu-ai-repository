	PTN - Parse Tree Notation
	------------------------

This directory contains the distribution image for PTN, a language used
for creating and manipulating parse trees, and the means to write 
sophisticated translators for various languages. 

Files in this directory:

README - (ascii)
	this file

ptn.tar.Z - (binary)
	A compressed Unix tar image of the PTN code.

ptn_paper.ps.Z - (binary)
	A compressed postcript version of a paper describing PTN

To set up PTN at your site, set ftp to image mode (ftp command 'binary'), 
and fetch ptn.tar.Z (ftp command 'get ptn.tar.Z').

Installing PTN 
-----------
Use the Unix command 

	zcat ptn.tar.Z | tar xvf -

to detar the PTN distribution and create the directory './ptn'.

Change directory to ptn/src and run make

Running an example
------------------
Change directory to ptn/apps and choose one of the examples to run,

for example - module

	cd module

Instructions are in the README file.


More Information
----------------

Uncompress and print the paper in ptn_paper.ps 

	"Parse Tree Notation", Davison, A., Haywood, E.


Contact:

Andrew Davison or Elizabeth Haywood
Dept. of Computer Science
University of Melbourne
Melbourne, Victoria 3052
Australia
Email: {ad,liz}@cs.mu.oz.au
Fax: +61 3 348 1184
Phone: +61 3 287 9172 / 9101
Telex: AA 35185


