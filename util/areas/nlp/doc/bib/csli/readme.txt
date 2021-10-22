lingbib.csli is a linguistics bibliography database in bib/tib/refer
format, presently containing some 3,300 entries, heavily slanted
towards phonetics/phonology but with a fair amount of morphology,
syntax, and semantics thrown in, especially if your interests are
computational. We recommend you use it with James Alexander's tib
bibliography system, which is Copyright (C) James Alexander
(jca.lakisis.umd.edu) but available for the public by anonymous ftp
from minos.inria.fr (128.93.39.5) among other places. A typical entry
looks like this: 

%A George A. Miller
%A Noam Chomsky
%D 1963
%T Finitary models of language users
%E R. Duncan Luce
%E Robert R. Bush
%E Eugene Galanter
%B Handbook of mathematical psychology
%I Wiley
%C New York
%P 419-491

Tib can generate TeX/LaTeX formatted code that conforms to the
cititation style requirements of various journals. The style file
for Language, called ling.tib (and the related ling.ttx file) created
by Jeff Goldberg (goldberg@csli.stanford.edu) is enclosed with this
distribution. Tib can also interactively look up entries in the 
database -- see its man page for details.

If you wish to make addittions to lingbib.csli please send your 
contribution (which will become CSLI copyleft) to kornai@csli.
Make sure that 

-- you don't send full articles, just the references
-- the entry is a new entry, not a correction to an
   existing one. (Corrections are also welcome, just send 
   them separately)
-- the entry is maximally informative (e.g. put in full first names 
   if you know them)
-- the file is in the correct tib format (order of fields does not 
   matter) 

If you use the slow and clumsy BibTeX system, you might wish to
convert to tib -- use the bibtex2ref script by Bernd Fritzke
(fritzke@immd2.informatik.uni-erlangen.de) to convert your bibtex
bibliography files. Please do NOT send anything in bibtex format.

To take full advantage of the lingbib.csli database (e.g. to run
interactive searches) you probably want to install the tib package
even if you don't use TeX/LaTeX. However, the database is in no way
tied to tib, and you are welcome to use it as a plain text file, to
search it by grep or other utilities, or to put it under your own DBMS
system as long as you abide by the terms and conditions of the 
CSLI General Public License which requires that you maintain the
License and Copying files together with the lingbib.csli file.
(For other terms and conditions and for a NO WARRANTY statement 
see the License file.) 
