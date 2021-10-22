This directory contains files for various standard inductive learning
algorithms that all use the same basic data format and same interface.  It also
includes automatic testing software for running learning curves that compare
multiple systems and utilities for plotting and statistically evaluating the
results. 

Comments at the begining of universal-tester.lisp help define the data format
and interface standards used.  Commenting elsewhere can be sparse.

See comments in the universal-tester.lisp file and the trace in
sample-univ-tester-trace to see how to use the universal tester.

Sample data sets are dna-standard.lisp and labor-neg.lisp.  DATA-UTILITIES.LISP
includes a function for converting a data file suitable for Quinlan`s C4.5 to
the "ml-prog" format.

Raymond J. Mooney
Assistant Professor
Department of Computer Sciences
University of Texas at Austin

