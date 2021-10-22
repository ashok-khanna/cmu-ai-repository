From ramsdell@mitre.org Wed Mar  2 17:09:17 EST 1994
Article: 12127 of comp.lang.lisp
Xref: glinda.oz.cs.cmu.edu comp.lang.lisp:12127
Path: honeydew.srv.cs.cmu.edu!rochester!udel!MathWorks.Com!blanket.mitre.org!linus.mitre.org!linus!ramsdell
From: ramsdell@triad.mitre.org (John D. Ramsdell)
Newsgroups: comp.lang.lisp
Subject: SchemeWEB 2.0 released---Supports literate programming in Lisp
Date: 25 Feb 1994 14:16:08 GMT
Organization: Research Computer Facility, The MITRE Corporation, Bedford MA
Lines: 29
Distribution: world
Message-ID: <RAMSDELL.94Feb25091608@triad.mitre.org>
Reply-To: ramsdell@mitre.org
NNTP-Posting-Host: triad.mitre.org

SchemeWEB 2.0---Simple support for literate programming in Lisp.

SchemeWEB is a Unix filter that translates SchemeWEB source into LaTeX
source or Lisp source.  Originally developed for the Scheme dialect 
of Lisp, it can easily be used with most other dialects.

Version 2.0 is available in the Scheme Repository as

	nexus.yorku.ca:/pub/scheme/new/schemeweb.sh

Version 2.0 implements several improvements over the version 1.2 which
was released in 1990.

* The LaTeX source generated from a SchemeWEB file no longer requires
the use of a style option, such as the astyped option required by the
previous version.  The output is similar to that produced by c2latex.

* By default, Lisp source generated from a SchemeWEB file includes all
comments.  As a result, the filter can translate the Lisp source
generated from a SchemeWEB file directly into LaTeX source.

* The filter can translate the Lisp source generated from a SchemeWEB
file into the original SchemeWEB file.

As a result of these changes, a SchemeWEB file can be stored and
distributed as a standard Lisp file by tangling the SchemeWEB file.
For the purposes of editing comments, the SchemeWEB file can be
recovered by untangling the Lisp file.  LaTeX documentation can be
generated from both the Lisp file or the SchemeWEB file.


