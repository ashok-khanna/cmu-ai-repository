Accel is an experimental system developed by Hwee Tou Ng as part of
his Ph.D. dissertation. More detailed description of the system can be
found in the following publications:

Ng, H.  T., \& Mooney, R.  J.  (1991).  An Efficient First-Order
Horn-Clause Abduction System Based on the ATMS.  {\em
Proceedings of the Ninth National Conference on Artificial
Intelligence} (pp. 494--499). Anaheim, CA.

Ng, H.  T., \& Mooney, R.  J.  (1990).  On the Role of Coherence in
Abductive Explanation.  {\em Proceedings of the Eighth National
Conference on Artificial Intelligence} (pp. 337--342).  Boston, MA.

Ng, H.  T., \& Mooney, R.  J.  (1990).  The Role of Coherence in
Constructing and Evaluating Abductive Explanations.  {\em Working
Notes of the AAAI Spring Symposium on Automated Abduction}.  Stanford,
CA.

Ng, H.  T., \& Mooney, R.  J.  (1989).  Occam's Razor Isn't
Sharp Enough: The Importance of Coherence in Abductive Explanation.
{\em Working Notes of the Second AAAI Workshop on Plan Recognition},
International Joint Conference on Artificial Intelligence.  Detroit,
MI.

Ng, H. T., \& Mooney, R. J. (1992). Abductive Plan Recognition and 
Diagnosis: A Comprehensive Empirical Evaluation. To appear as 
Technical Report, Artificial Intelligence Laboratory, Department of 
Computer Sciences, University of Texas at Austin.

Ng, H. T. (1992). A General Abductive System with Application to 
Plan Recognition and Diagnosis. Ph.\ D.\ Thesis. To appear as 
Technical Report, Artificial Intelligence Laboratory, Department of 
Computer Sciences, University of Texas at Austin.

Ng, H.  T., \& Mooney, R.  J.  (1991).  An Efficient First-Order
Abduction System Based on the ATMS.  Technical Report AI91-151,
Artificial Intelligence Laboratory, Department of Computer Sciences,
University of Texas at Austin.

Ng, H.  T., \& Mooney, R.  J.  (1989).  Abductive Explanation
in Text Understanding: Some Problems and Solutions.  Technical Report
AI89-116, Artificial Intelligence Laboratory, Department of Computer
Sciences, University of Texas at Austin.

For copyright issues, refer to the README file in the directory
~ftp/pub/mooney/accel. In particular, note that the use of this
software is restricted to non-commercial purposes only. Please
send a note to the author (htng@cs.utexas.edu) when you retrieve
this software via ftp.

Information on running Accel:
-----------------------------

(load "init.lisp")
(load "run.lisp")

; Compile and load the files. Or use (sun-load) to just load the files.
(sun-cal)

; Prepare to run Accel, by loading the appropriate KB and data files.
; Other possibilities include (prep-brain), (prep-adder), (prep-tc), (prep-wb).
(prep-pr)

The actual commands to run Accel are:

(aaa::abduce *e1* *a1*)  ; Plan recognition training example 1.
(aaa::abduce *t1* *at1*) ; Plan recognition test example 1.
(aaa::abduce *p1* *a1*)  ; Diagnosis of brain disorders for patient 1.
(run-adder-expt (first *experiments*)) ; Diagnosis of adder scenario 1.
(run-expts '(*tc1*)) ; Diagnosis of temp. controller scenario 1.
(run-expts '(*cadh+*)) ; Diagnosis of kidney water balance system scenario 1.

The last two commands will include profiling and report the run time and
inference count incurred. To include profiling for the first four commands,
embed the respective commands in: 
(with-profiling (aaa::compute-label) ..command..)

For further questions regarding the Accel system, send email to
htng@cs.utexas.edu. Thanks.

Hwee Tou Ng
June 5, 1992
