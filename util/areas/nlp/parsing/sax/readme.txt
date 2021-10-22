	           Syntactic Analyzing Program
             -- An overview and program file list --

1. Overview of the software
   SAX (Sequential Analyzer for syntaX and semantics) is a syntactic
analyzer based on logic programming. SAX employs a bottom-up and
breadth-first parsing algorithm. The SAX grammar rules are basically
written in Definite Clause Grammar (DCG). The SAX grammar rules are
translated into a parsing program written in Prolog. SAX is
implemented in SICStus Prolog Ver 0.7.

2. Program file list
   SAX is implemented in SICStus Prolog Ver 0.7. In addition to SAX,
Japanese grammar for syntactic analysis (RDG) and sample data are
provided. The data is RDG sample input data. The program files are as
follows.

(a) spr24.pl
    SAX translator. Grammar rules are translated into a parsing
    program written in Prolog.

(b) ytime.pl
    SAX timer program

(c) ytstr10.pl
    SAX starter program

(d) eval_lc.pl
    Tree print routine program

(e) util.pl
    Utility program

(f) new_rdg_t2.dcg
    Grammar

(g) rdg_gram_sem.pl
    Grammar (Extra condition)

(h) 1002v03.dic
    Dictionary

(i) asahi.txt
    Sample of Japanese newspaper


3. How to install the Syntactic Analyzing Program
   The programs mentioned in section 2 are to be installed on a UNIX
   machine. For further details, see INSTALL.j.

4. References

   Y. Matsumoto,
   A Parallel Parsing System for Natural Language Analysis,
   Proc. of 3rd International Conference on Logic Programming, 1986

   Y. Matsumoto and R. Sugimura,
   A Parsing System Based on Logic Programming,
   In Proceedings of IJCAI 87, 1987.
 
   Y. Matsumoto and R. Sugimura,
   Grammar Description Language for the SAX Parsing System (In Japanese),
   5th Conference Proceedings Japan Society for Software Science and Technology,
   A2-4, pp.78-80, 1988.

5. Others
   Another type of SAX system has been developed by Kyoto University.
   Full details are available from:

   Department of Electrical Engineering
   Kyoto University
   Sakyo-ku
   Kyoto 606, Japan
 
   Phone: +81-75-753-53-45
   Fax:   +81-75-751-15-76
   Email: Matsu@kuee.kyoto-u.ac.jp


   

