This directory contains a test suite for testing Common Lisp (CLtL1)
implementations.

In its original version (xcl-testsuite.tar.Z) it was built by

    Horst Friedrich, ISST of FhG         <horst.friedrich@isst.fhg.de>
    Ingo Mohr, ISST of FhG               <ingo.mohr@isst.fhg.de>
    Ulrich Kriegel, ISST of FhG          <ulrich.kriegel@isst.fhg.de>
    Windfried Heicking, ISST of FhG      <winfried.heicking@isst.fhg.de>
    Rainer Rosenmueller, ISST of FhG     <rainer.rosenmueller@isst.fhg.de>

at

    Institut f�r Software- und Systemtechnik der Fraunhofer-Gesellschaft
    (Fraunhofer Institute for Software Engineering and Systems Engineering)
    Kurstra�e 33
  D-O-1086 Berlin
    Germany

for their Common Lisp implementation named XCL.

What you see here is a version (testsuite.tar.Z) adapted to CLISP by

    Bruno Haible              <haible@ma2s2.mathematik.uni-karlsruhe.de>

at

    Universit�t Karlsruhe
    Mathematisches Institut II
    Kaiserstra�e 12
  D-W7500 Karlsruhe 1
    Germany


Operation:
----------

The files *.tst contain test forms and their corresponding results.
You may feed the test forms one by one to an interpreter and compare the
results you get with the predicted ones.

This tasks is automated by tests.lsp. Run

      > (load "tests")
      > (run-all-tests)

The differences between the results and the predicted ones are
recorded in *.erg files. Empty *.erg files are removed.
If you can't find any *.erg files after running the tests, then your
implementation has passed the tests!


Notes:
------

* The test suite covers only CLtL1.

* The test suite is not "complete" in any sense. Anyway, it may be useful:
  It has uncovered at least four severe bugs in CLISP.

* Some results are implementation dependent. When using other implementations
  than XCL and CLISP, you may wish to insert your "predicted results",
  protected by #+ and #-. Think twice before doing so as you may be
  deliberately ignoring a bug in your implementation.

* The tests "hash", "readtable", "tread", "tprint" are currently not used
  by test.lsp.

* Additions are welcome.


Copyright:
----------

This test suite is copyrighted by the ISST of FhG and may be distributed
under the terms of the GNU General Public License (see file GNU-GPL).

