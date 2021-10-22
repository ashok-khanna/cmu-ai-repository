Installing ALE
==============

ALE has been tarred and compressed.  When ftp-ing, be sure to use
binary mode.  ALE resides in the file:

    j.gp.cs.cmu.edu:/usr1/carp/ftp/ale2.0.2.tar.Z

Put this file in the directory in which the ALE directory should
reside.  Then execute the following commands:

  % uncompress *.Z
  % tar xvf *.tar

The following files will then be installed in the ALE directory:

  ale.pl
  baby.pl
  cg.pl
  guide.tex
  hpsg.pl
  syllab.pl

The primary system resides in the file ale.pl, the two grammars in
cg.pl and syllab.pl, a sample constraint puzzle in baby.pl, and an
HPSG grammar (complete through the first five chapters of Pollard &
Sag, 1994). The user's guide is in guide.tex.

After checking the contents of these files to make sure they were
created properly, it is safe to remove the file 'system.tar'.


Printing the User's Guide
=========================

The user's guide should be processed through LaTeX twice to generate a
table of contents and process cross-references:

  % latex guide.tex; latex guide.tex

The .dvi file in guide.dvi should be ready for conversion to
postscript, for dvi viewing, or for printing. 


Reporting Bugs / Mailing List
=============================

Please report all bugs (and any other comments) to:

   Bob Carpenter  carp@lcl.cmu.edu
   Gerald Penn    penn@lcl.cmu.edu



