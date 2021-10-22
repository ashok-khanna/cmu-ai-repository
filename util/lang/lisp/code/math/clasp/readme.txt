From dhart@cs.umass.edu Fri Jan 21 16:32:47 EST 1994
Article: 11832 of comp.lang.lisp
Xref: glinda.oz.cs.cmu.edu comp.lang.lisp:11832
Path: honeydew.srv.cs.cmu.edu!nntp.club.cc.cmu.edu!news.sei.cmu.edu!cis.ohio-state.edu!magnus.acs.ohio-state.edu!usenet.ins.cwru.edu!howland.reston.ans.net!europa.eng.gtefsd.com!MathWorks.Com!uhog.mit.edu!news.mtholyoke.edu!nic.umass.edu!ymir.cs.umass.edu!titanic!dhart
From: dhart@cs.umass.edu (Dave Hart)
Newsgroups: comp.lang.lisp
Subject: CLIP/CLASP software release
Date: 20 Jan 1994 20:01:25 GMT
Organization: Univ of Massachusetts, Comp Sci Dept
Lines: 115
Sender: dhart@earhart (Dave Hart)
Distribution: world
Message-ID: <2hmnulINNgdq@ymir.cs.umass.edu>
Reply-To: dhart@cs.umass.edu (Dave Hart)
NNTP-Posting-Host: earhart.cs.umass.edu


The CLIP/CLASP Package

Experimental Knowledge Systems Laboratory
Computer Science Department, LGRC
University of Massachusetts
PO Box 34610 
Amherst, MA  01003-4610

CLIP/CLASP is an online laboratory environment for the analysis of
Artificial Intelligence programs.  Using CLIP/CLASP the experimenter
can:
	- collect and filter data while a program runs 
	- define and automatically run experiments to evaluate a program's
	  behavior in different conditions
	- transform, filter and partition data in powerful ways
	- examine data graphically and statistically 
	- run parametric and computer-intensive tests

CLIP/CLASP is comprised of two tools: the Common Lisp Instrumentation
Package (CLIP) for data collection and experiment design, and the
Common Lisp Analytical Statistics Package (CLASP) for data
manipulation and statistical analysis.  CLIP/CLASP was developed in
the Experimental Knowledge Systems Laboratory to support the empirical
analysis of AI program behavior, and is now being used in a number of
AI laboratories.

Using CLIP the experimenter defines and manages "alligator clips" to
collect data while the program runs.  CLIP writes this data to files
in a format specified by the experimenter, who may choose from among a
variety of commonly used data formats or use a format customized for
CLASP analysis.  Once defined, clips may be saved for reuse in other
experiments.

CLIP also includes facilities to support experiment design, such as
definition of experimental factors, scenario scripting, and automatic
factorial combination of independent variables.  CLIP automatically
collects summary data at the end of each experiment trial, and can
also collect and filter time-series and event-based data for periodic
and/or non-periodic events specified by the experimenter.  CLIP allows
partially completed experiments to be restarted from the point of
interruption.

CLASP provides an interactive environment for data manipulation and
statistical analysis that is fully integrated with Common Lisp and the
Common Lisp Interface Manager (CLIM).  CLASP has all the descriptive
and hypothesis-testing statistics one expects of a moderately powerful
statistics packge, plus it includes many features that facilitate
exploratory data analysis.  CLASP's unique and most powerful feature
is its user interface, complete with a "notebook" that is both a
"desktop" for icons and a lisp interactor pane.  CLASP uses SciGraph,
a scientific graphing package from Bolt Beranek and Newman Inc.
SciGraph is a publicly available and extensible CLIM-based system.
CLASP includes powerful facilities for data manipulation, exploratory
data analysis, assessing confidence intervals and testing hypotheses.

It has a clearly-defined programmer interface and can be extended by
the user with the addition of new features.

Data Manipulation: Data can be transformed in many ways using CLASP,
such as smoothing time series to reduce noise, or applying log
transforms to straighten learning curves.  Data can be filtered by
many criteria.  Unlike many statistical packages, CLASP provides
powerful partitioning facilities to complement CLIP's ability to run
large experiments automatically in many different conditions,
collecting many data.

Exploratory Data Analysis: CLASP's graphical facilities, provided by
SciGraph, support histograms, lineplots, scatterplots, spin plots, and
the essential exploratory technique of coloring partitions.  CLASP
also provides descriptive statistics including: mean, median, trimmed
mean, variance, interquartile range, correlation, simple regression,
and multiple regression.

Tests: CLASP supports confidence intervals on most statistics, with
the option of using either parametric or bootstrap methods.  Bootstrap
versions of several tests are supported.  Statistical tests in CLASP
include t-tests, chi-square, one- and two-way analysis of variance,
and degree of fit in simple and multiple regression.  New tests,
specifically designed for AI applications (e.g., tests of censored
data, dependency detection in execution traces), are under
development.

User Interface: CLASP has a powerful user interface that combines the
desktop-style accessibility of all data objects with full integration
into the underlying lisp environment.  Commands are menu selectable or
can be entered by hand.  Command arguments, such as datasets,
variables, previous results, and even graphic objects, are all mouse
sensitive.  All session activity appears in a notebook that can be
saved for future use or record-keeping.  The notebook is also a lisp
interactor pane, giving the user the full access to lisp language
constructs for specialized needs not provided by CLASP.

Programmer Interface: CLASP's data manipulation functions, statistical
tests, and graphical functions (through SciGraph) are directly
accessible to the programmer for inclusion in other programs.  The
programmer interface is fully documented in the CLIP/CLASP User
Manual.

Extensions: CLASP (and CLIP) are distributed with source code, and
their modular design allows for easy addition of user-desired
features.

CLIP/CLASP is written in Common Lisp, CLOS and CLIM and runs on
several platforms, including Suns, Alpha's and Decstations.  It is
distributed with a User Manual and with a tutorial for CLASP.
CLIP/CLASP is available through anonymous ftp at ftp.cs.umass.edu.
CLIP can be found under the directory pub/eksl/clip, CLASP under
pub/eksl/clasp, and a tutorial on CLASP under pub/eksl/clasp-tutorial.
 
Development of CLIP/CLASP continues, and is largely driven by user
demand.  Comments, bugs and new feature requests can be sent to
clasp-support@cs.umass.edu.  For more information about CLIP/CLASP,
contact David Hart (dhart@cs.umass.edu, 413-545-3278) .


Dave Hart                                                               
Experimental Knowledge Systems Laboratory       413-545-3278
Computer Science Dept., LGRC                    413-545-1249 (fax)
University of Massachusetts                             dhart@cs.umass.edu
Box 34610
Amherst, MA  01003-4610
