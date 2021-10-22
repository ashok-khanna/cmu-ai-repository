From honeydew.srv.cs.cmu.edu!magnesium.club.cc.cmu.edu!news.mic.ucla.edu!library.ucla.edu!agate!diva.EECS.Berkeley.EDU!jang Fri Sep 10 02:51:21 EDT 1993
Article: 12229 of comp.ai.neural-nets
Xref: honeydew.srv.cs.cmu.edu comp.ai.fuzzy:1123 comp.ai.neural-nets:12229
Path: honeydew.srv.cs.cmu.edu!magnesium.club.cc.cmu.edu!news.mic.ucla.edu!library.ucla.edu!agate!diva.EECS.Berkeley.EDU!jang
From: jang@diva.EECS.Berkeley.EDU (Jyh-Shing Roger Jang)
Newsgroups: comp.ai.fuzzy,comp.ai.neural-nets
Subject: C codes and examples available for adaptive fuzzy systems
Date: 10 Sep 1993 00:06:05 GMT
Organization: University of California, Berkeley
Lines: 2069
Message-ID: <26ogdd$73l@agate.berkeley.edu>
NNTP-Posting-Host: diva.eecs.berkeley.edu
Keywords: fuzzy system, learning, parameter identification


Hi there,

Attached is a uuencoded file containing the C codes and simulation
examples for the ANFIS (Adaptive-Network-based Fuzzy Inference System)
architecture proposed in [1,2].

Related papers
[1] "ANFIS: Adaptive-Network-based Fuzzy Inference Systems", IEEE
    Trans. on Systems, Man and Cybernetics, May 1993.
[2] "Fuzzy Modeling Using Generalized Neural Networks and Kalman
    Filter Algorithms", Proc. of the Ninth National Conference on
    Artificial Intelligence (AAAI-91), pp 762-767, 1991.

To retrieve the C programs and examples, save the following to a
file "tmp" and do the following.
	% uudecode tmp
	% uncompress anfis.tar.Z
	% tar xvf anfis.tar
Upon completion, a new directory "anfis" is generated. Get into
each subdirectory and read the "README" file.

Roger
=======================================================================
Jyh-Shing Roger Jang			Research Associate
571 Evans, Dept. of EECS		Phone: 510-642-5029
University of California		Fax  : 510-642-5775
Berkeley, CA 94720			Email: jang@eecs.berkeley.edu
=======================================================================

