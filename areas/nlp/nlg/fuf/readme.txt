                                -------
                                FUF 5.2
                                -------

======================================================================
All the material included in this package is Copyright (1987-1993) by
          Michael Elhadad
          Ben Gurion University of the Negev
          Dept. of Mathematics and Computer Science
          Beer Sheva, 84105  ISRAEL
          +972 (57) 461-626
          elhadad@bengus.bgu.ac.il

License agreement can be found in file LICENSE.
======================================================================

This distribution contains FUF 5.2 and SURGE 1.2, a system of natural
language generation based on the formalism of Functional Unification
Grammars. Also included are the postscript version of my Columbia
University dissertation (thesis.ps.Z) and a corpus of student-advisor 
conversations used to develop the ADVISOR II system described in my
dissertation.  The dissertation provides detailled information on the 
design of FUF and the only documentation available on the SURGE grammar.

The tar file should expand to the following directories:
doc, examples, grammar and src:

.:
total 39
-rw-r--r--  1 elhadad      4140 Jun 28 18:15 LICENSE
-rw-r--r--  1 elhadad      7919 Jun 29  1993 README
-rw-r--r--  1 elhadad       778 Jun 28 18:32 RELEASE
drwxr-xr-x  2 elhadad       512 Jun 28  1993 doc
drwxr-xr-x  2 elhadad      1024 Jun 29  1993 examples
drwxr-xr-x  2 elhadad      1536 Jun 29  1993 grammar
-rw-r--r--  1 elhadad      4792 Jun 28 18:12 lisp-init-acl.l
-rw-r--r--  1 elhadad      2556 Jun 28 18:35 lspinit.l
-rw-r--r--  1 elhadad      5077 Jun 28 18:35 lspinit2.l
-rw-r--r--  1 elhadad      5092 Jun 28 18:11 lspinit3.l
-rw-r--r--  1 elhadad      1073 Jun 28 18:11 lspinit4.l
drwxr-xr-x  2 elhadad      1024 Jun 29  1993 src

doc:
total 499
-rw-r--r--  1 elhadad       683 Jun 28  1993 README
-rw-r--r--  1 elhadad     69941 Jun 28 18:36 bk-class.ps.Z
-rw-r--r--  1 elhadad      1890 Jun 28 18:36 bkclass1.ps.Z
-rw-r--r--  1 elhadad      9357 Jun 28  1993 control.txt
-rw-r--r--  1 elhadad    120865 Jun 28  1993 fuf5.2.mss.Z
-rw-r--r--  1 elhadad    230973 Jun 28  1993 fuf5.2.ps.Z
-rw-r--r--  1 elhadad      5712 Jun 28  1993 fuf5.bib.Z
-rw-r--r--  1 elhadad     10772 Jun 28 18:36 grammar-map.ps.Z
-rw-r--r--  1 elhadad      5587 Jun 28 18:36 graph12.ps.Z
-rw-r--r--  1 elhadad      6203 Jun 28 18:36 graph22.ps.Z
-rw-r--r--  1 elhadad      5336 Jun 28  1993 graph32.ps.Z
-rw-r--r--  1 elhadad      2150 Jun 28 18:36 stack2.ps.Z
-rw-r--r--  1 elhadad      9895 Jun 28  1993 update.5.2

examples:
total 816
-rw-r--r--  1 elhadad       558 Jun 29  1993 README
-rw-r--r--  1 elhadad     36780 Jun 28  1993 gcon3.l
-rw-r--r--  1 elhadad      1213 Jun 28  1993 gr0.l
-rw-r--r--  1 elhadad      1972 Jun 28  1993 gr1.l
-rw-r--r--  1 elhadad    132631 Jun 28  1993 gr10.l
-rw-r--r--  1 elhadad      4431 Jun 28  1993 gr2.l
-rw-r--r--  1 elhadad      7660 Jun 28  1993 gr3.l
-rw-r--r--  1 elhadad     50533 Jun 28  1993 gr4.l
-rw-r--r--  1 elhadad      1442 Jun 28  1993 gr5.l
-rw-r--r--  1 elhadad     47311 Jun 28  1993 gr6.l
-rw-r--r--  1 elhadad     50440 Jun 28  1993 gr7.l
-rw-r--r--  1 elhadad    100349 Jun 28  1993 gr8.l
-rw-r--r--  1 elhadad    119609 Jun 28  1993 gr9.l
-rw-r--r--  1 elhadad      2813 Jun 28  1993 icon3.l
-rw-r--r--  1 elhadad      8681 Jun 29  1993 ir-bk-class.l
-rw-r--r--  1 elhadad      1285 Jun 28  1993 ir0.l
-rw-r--r--  1 elhadad      1418 Jun 28  1993 ir1.l
-rw-r--r--  1 elhadad     60176 Jun 28  1993 ir10.l
-rw-r--r--  1 elhadad       713 Jun 28  1993 ir2.l
-rw-r--r--  1 elhadad      1832 Jun 28  1993 ir3.l
-rw-r--r--  1 elhadad     17407 Jun 28  1993 ir4.l
-rw-r--r--  1 elhadad      1393 Jun 28  1993 ir5.l
-rw-r--r--  1 elhadad     17582 Jun 28  1993 ir6.l
-rw-r--r--  1 elhadad      2956 Jun 28  1993 ir7.l
-rw-r--r--  1 elhadad     33313 Jun 28  1993 ir8.l
-rw-r--r--  1 elhadad     49900 Jun 28  1993 ir9.l
-rw-r--r--  1 elhadad       816 Jun 28  1993 lattice.l
-rw-r--r--  1 elhadad       891 Jun 29  1993 test1.l
-rw-r--r--  1 elhadad      1074 Jun 29  1993 test2.l
-rw-r--r--  1 elhadad       793 Jun 29  1993 test3.l
-rw-r--r--  1 elhadad      1128 Jun 29  1993 test4.l
-rw-r--r--  1 elhadad       709 Jun 29  1993 test5.l
-rw-r--r--  1 elhadad      1034 Jun 29  1993 test6.l
-rw-r--r--  1 elhadad      2933 Jun 28  1993 test7.l
-rw-r--r--  1 elhadad      1097 Jun 29  1993 test8.l
-rw-r--r--  1 elhadad     13332 Jun 28  1993 tpat.l

grammar:
total 363
-rw-r--r--  1 elhadad       873 Jun 29  1993 README
-rw-r--r--  1 elhadad     16611 Jun 29  1993 TAGS
-rw-r--r--  1 elhadad     21629 Jun 28  1993 circumstance.l
-rw-r--r--  1 elhadad     24035 Jun 28  1993 clause.l
-rw-r--r--  1 elhadad      8580 Jun 28  1993 complex.l
-rw-r--r--  1 elhadad      4686 Jun 28  1993 connectives.l
-rw-r--r--  1 elhadad     24640 Jun 28  1993 determiner.l
-rw-r--r--  1 elhadad      9971 Jun 28  1993 gr-modular.l
-rw-r--r--  1 elhadad      2045 Jun 28  1993 gr.l
-rw-r--r--  1 elhadad    119450 Jun 28  1993 ir.l
-rw-r--r--  1 elhadad      1929 Jun 28  1993 np-head.l
-rw-r--r--  1 elhadad     21236 Jun 28  1993 np.l
-rw-r--r--  1 elhadad     13474 Jun 28  1993 tpat.l
-rw-r--r--  1 elhadad     23109 Jun 28  1993 transitivity.l
-rw-r--r--  1 elhadad     17486 Jun 28  1993 types.l
-rw-r--r--  1 elhadad     27231 Jun 28  1993 verb-group.l
-rw-r--r--  1 elhadad     14896 Jun 28  1993 voice.l

src:
total 360
-rw-r--r--  1 elhadad       164 Jun 29  1993 README
-rw-r--r--  1 elhadad     16341 Jun 29  1993 alt.l
-rw-r--r--  1 elhadad     11447 Jun 29  1993 backtrack.l
-rw-r--r--  1 elhadad     26246 Jun 29  1993 checker.l
-rw-r--r--  1 elhadad      4597 Jun 29  1993 complexity.l
-rw-r--r--  1 elhadad      5560 Jun 29  1993 continue.l
-rw-r--r--  1 elhadad      4175 Jun 29  1993 control.l
-rw-r--r--  1 elhadad       986 Jun 29  1993 copypath.l
-rw-r--r--  1 elhadad     13860 Jun 29  1993 define.l
-rw-r--r--  1 elhadad     17782 Jun 29  1993 determine.l
-rw-r--r--  1 elhadad      2734 Jun 29  1993 external.l
-rw-r--r--  1 elhadad      3615 Jun 29  1993 fdlist.l
-rw-r--r--  1 elhadad      6451 Jun 29  1993 findcset.l
-rw-r--r--  1 elhadad      4070 Jun 29  1993 fset.l
-rw-r--r--  1 elhadad     13667 Jun 29  1993 fug5.l
-rw-r--r--  1 elhadad      5943 Jun 29  1993 generator.l
-rw-r--r--  1 elhadad     20575 Jun 29  1993 graph.l
-rw-r--r--  1 elhadad      3017 Jun 29  1993 ignore.l
-rw-r--r--  1 elhadad      7188 Jun 29  1993 lexicon.l
-rw-r--r--  1 elhadad     23644 Jun 29  1993 linearize.l
-rw-r--r--  1 elhadad     12357 Jun 29  1993 macros.l
-rw-r--r--  1 elhadad     16510 Jun 29  1993 path.l
-rw-r--r--  1 elhadad     22871 Jun 29  1993 pattern.l
-rw-r--r--  1 elhadad     17723 Jun 29  1993 psgraph.l
-rw-r--r--  1 elhadad      4087 Jun 29  1993 ralt.l
-rw-r--r--  1 elhadad      6482 Jun 29  1993 test.l
-rw-r--r--  1 elhadad     23843 Jun 29  1993 top.l
-rw-r--r--  1 elhadad     15582 Jun 29  1993 trace.l
-rw-r--r--  1 elhadad     14444 Jun 29  1993 type.l
-rw-r--r--  1 elhadad      7379 Jun 29  1993 vars.l
-rw-r--r--  1 elhadad     17028 Jun 29  1993 wait.l


============================================================
Installation guide:
-------------------

Detailled instructions are given in the documentation.  The program should
work on any Common-Lisp.  It has been tested on Lucid Common Lisp versions
2 to 4.0 on Sun 386, Sun3, and Sun4s, DEC stations and HP workstations.
Allegro Common Lisp has been tested on Sun3s and Sun4 (sparcstations) and
on NeXt machines.  Allegro Common Lisp has been tested on the Macintosh II.
Ibuki Common Lisp has been tested on Suns.  FUF has also been tested under
the POPLOG version of Common Lisp.

It should really be compiled to work honestly.  Tail recursion elimination
must be enabled to produce best results.

All the system dependent names can be changed in the 
file src/fug5.l - if you rename the source files, update
fug5.l also.  

To facilitate installation, the init files lisp-init*.l are included for
Lucid and Allegro on Unix machines.  The main function is a rewrite of load
that understands shell variables in file names (for example (load
"$fug/fug.l") works as expected if $fug is defined in the shell).






