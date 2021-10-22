This file describes the Hierarchical Interval Constraint (HIC)
temporal reasoning system distribution.  Note that this system was
constructed for research purposes, and is likely unsuitable for
serious applications.

The following files are included:

hic.cl		- The HIC system
standard.cl	- Misc. extentions to CL
transfinite.cl	- Arithmetic functions supporting +/- infinity
range.cl	- Support for "ranges" i.e. closed intervals
test.cl		- Some simple tests of the HIC system
hic-bench.cl	- Benchmark for HICs vs. timepoint graphs
projector.cl	- Simple temporal projector using HICs
ptest.cl	- Test code for the temporal projector

All these files use the antiquated CL provide/require functionality,
which may not be part of ANSI CL.  If available, one just loads the
appropriate file (e.g. hic.cl) and everything else gets loaded
automatically.  If this doesn't work for you, you're on your own.

The main HIC interface funcitons are described in the file hic.doc.

Questions or comments to:

	Mike Williamson <mikew@cs.washington.edu>
