This directory contains LaTeX files for a tutorial introduction to XLISP-STAT.
Run LaTeX on techreport.tex and then print the dvi file on a postscript
engine. The psfig system is used to include Macintosh postscript figures.
Getting this stuff to print is a nuissance; with our LaserWriter and dvi to
postscript conversion tool I use the command

        dvi-ps -r -i dvifix.ps -i mac68.pro -i figtex.pro techreport |lpr -Pps

to print things out; with a different dvi to postscript urility you may need to
use a different approach.

If you do have trouble with the pictures and can live without them uncomment
the line at the beginning of techreport.tex that reads

%\renewcommand{\special}[1]{}

LaTeX should then produce a document with spaces for the pictures but
without attempting to put in the pictures themselves.

I will try to make up to date copies of postscript versions of the tech
report available by anonymous ftp from umnstat.stat.umn.edu (128.101.51.1).
These should print on a LaserWriter but, because of the included Mac
pictures they may not print on other postscript engines. Also try to avoid
page reversal since that may put the header information in the wrong place.
