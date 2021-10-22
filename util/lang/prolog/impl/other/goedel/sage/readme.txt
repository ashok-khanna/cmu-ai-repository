From corin@cogsci.ed.ac.uk Tue Feb  8 23:27:36 EST 1994
Article: 9607 of comp.lang.prolog
Xref: glinda.oz.cs.cmu.edu comp.lang.prolog:9607
Newsgroups: comp.lang.prolog
Path: honeydew.srv.cs.cmu.edu!bb3.andrew.cmu.edu!news.sei.cmu.edu!cis.ohio-state.edu!magnus.acs.ohio-state.edu!math.ohio-state.edu!howland.reston.ans.net!pipex!uknet!festival!edcogsci!corin
From: corin@cogsci.ed.ac.uk (Corin Gurr)
Subject: A Self-Applicable Partial Evaluator for Goedel
Message-ID: <CKx268.43K@cogsci.ed.ac.uk>
Summary: Announcement of Phd thesis available by ftp.
Keywords: Partial evaluation, self-application, ground representation, Goedel
Organization: Centre for Cognitive Science, Edinburgh, UK
Date: Tue, 8 Feb 1994 17:36:01 GMT
Lines: 116


Partial evaluation is a program specialisation technique that has
been shown to have great potential in logic programming, particularly for
the specialisation of meta-interpreters by the so-called
``Futamura Projections''. Meta-interpreters and other meta-programs are
programs which use another program as data.  This message announces the
availability of a recent Phd thesis which describes the development and
implementation of a self-applicable partial evaluator for meta-programs
in the logic programming language Goedel.

@phdthesis{sage,
   author = {C A Gurr},
   school = {Department of Computer Science, University of Bristol},
   title  = {A Self-Applicable Partial Evaluator for the
             Logic Programming Language Goedel},
   month  = jan,
   year   = {1994}
   }

Goedel is a declarative, general-purpose language which provides a number
of higher-level programming features, including extensive support for
meta-programming with a ground representation. The ground representation is
a standard tool in mathematical logic in which object level variables are
represented by ground terms at the meta-level.

This thesis extends the basic techniques of partial evaluation to
the facilities of the full Goedel language. Particular attention is given
to the specialisation of the inherent overheads of meta-programs which use
a ground representation and the foundations of a methodology for Goedel
meta-programs are laid down. The soundness of the partial evaluation
techniques is proved and these techniques are incorporated into a declarative
partial evaluator.

We describe the implementation and provide termination and correctness
proofs for the partial evaluator SAGE, an automatic program specialiser
based upon sound finite unfolding. Preliminary results are presented for
the First, Second and Third Futamura projections.

How to obtain the Phd thesis
------------------------------

This thesis and two related papers are available by ftp. The ftp site is

ftp.cs.bris.ac.uk     (137.222.102.102).

At this site is the file:

/goedel/Gurr-PhD-Thesis.tar.Z

This tar-compressed file contains the files  ReadMe, GurrThesis.dvi,
GurrAbstract.dvi and GurrTR30.dvi

The file ReadMe contains this message.

The file GurrThesis.dvi contains the thesis.

The file GurrAbstract.dvi contains a draft paper:

@techreport{gurr94,
   author      = {C A Gurr},
   institution = {Human Communication Research Centre,
                  University of Edinburgh},
   number      = {Draft copy},
   title       = {A Self-Applicable Partial Evaluator for the
                  Logic Programming Language Goedel (Extended Abstract)},
   year   = {1994}
   }

which provides a summary of this Phd thesis.

The file GurrTR30.dvi contains the paper:

@techreport{gurr92,
   author      = {C A Gurr},
   institution = {Department of Computer Science, University of Bristol},
   number      = {CSTR-92-30},
   title       = {Specialising the Ground Representation in the Logic
                  Programming Language Goedel,
   year = {1992}
   }

and is to appear in the proceedings of LoPSTr'93, Springer-Verlag.


How to obtain Goedel
- --------------------

The system is available by anonymous ftp.  The ftp sites are

ftp.cs.kuleuven.ac.be     (134.58.41.2)

and

ftp.cs.bris.ac.uk     (137.222.102.102).

At the Leuven site, the file README in the directory

/pub/logic-prgm/goedel

gives further instructions on how to obtain the system.  For the Bristol site,
the README file is in the directory

/goedel.

- ----------------------------------------------------------------------
Corin Gurr
Human Communication Research Centre   Tel.: +41 31 650 4448
Edinburgh University                  Email: corin@cogsci.ed.ac.uk
2 Buccleuch Place                     FAX: +41 31 650 4587
Edinburgh EH8 9LW
Scotland
-- 
Corin Gurr
Human Communication Research Centre   Tel.: +41 31 650 4448
Edinburgh University                  Email: corin@cogsci.ed.ac.uk
2 Buccleuch Place                     FAX: +41 31 650 4587


