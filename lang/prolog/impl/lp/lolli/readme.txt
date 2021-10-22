% README for Lolli 0.701 -- Josh Hodas (hodas@saul.cis.upenn.edu) 11/30/92*

This distribution contains the files necessary to build an interpreter for
a prolog-like language based on intuitionistic linear logic.

The language Lolli (named for the linear logic implication operator "-o"
called lollipop), is a full implementation of the language described in
our paper "Logic Programming in a Fragment of Intuitionistic Linear
Logic" (Hodas & Miller, to appear in Information and Computation '92), 
though it differs a bit in syntax, and has several built-in extra-logical 
predicates and operators.**

This preliminary implementation was developed over the last year 
and is based on code written by Frank Pfenning and Conal Elliot for their 
excellent paper "A Semi-Functional Implementation of a Higher-Order Logic 
Programming Language" which appears in "Topics in Advanced Language 
Implementation" , MIT Press, Peter Lee editor.  The paper is also available 
from CMU as Ergo Report 89-080. 

The system is written in Standard ML of New Jersey, and the parser and lexer
were built using the parser-generator (MLYACC) and lexical-analyzer-generator
(MLLEX) distributed with that system.  Though source files for the parser 
and lexer have been included, the parser and lexer have already been built, 
so you do not need access to the MLYACC or MLLEX.

For those who do not have SML-NJ at their site, I am attempting to provide
pre-built binaries for a variety of architectures. These binaries will
be stored in compressed form in the same directory (/pub/lolli) from
which you ftp'ed this distribution. At present Sparc and NeXT binaries
are available.  If you compile lolli on a new architecture, please contact me
so that I can distribute your binary.



Contents of the Distribution
----------------------------

The ./src directory contains files used to build an executable version
of Lolli using SML-NJ. It also contains the following two subdirectories
which hold the source code for the system itself.

    ./src/parser contains the source grammar and lex files used to 
    build the Lolli parser, as well as the code used to interface the 
    parser to the main system.

    ./src/interpreter includes all the SML source code for the Lolli 
    interpreter itself. The core of the prover is in 
    ./src/interpreter/interprter.sml. The remaining files define the 
    term and formula language, and give code for lifting terms to formulas.

The ./papers directory includes DVI and PostScript versions of several
papers relating to Lolli, as well as a preliminary version of the 
Elliot & Pfenning paper mentioned above.

The ./examples directory includes several sub-directories of example Lolli
programs. Most are drawn from the papers mentioned above, but almost all
have been changed to make use of some of the built-in predicates, to make them
more functional.


--------------------
*Work on this project, by Josh Hodas and Dale Miller, has been funded by
ONR N00014-88-K-0633, NSF CCR-87-05596, NSF CCR-91-02753, and DARPA 
N00014-85-K-0018, through the University of Pennsylvania.  Miller was also 
supported by SERC Grant No. GR/E 78487 "The Logical Framework" and ESPRIT 
Basic Research Action No. 3245 "Logical Frameworks: Design Implementation 
and Experiment" while he was visiting the University of Edinburgh.


**The internal representation of formulas and proof contexts is
actually based on an earlier version of the logic, described in the
"extended abstract" version of the paper presented at the 1991 Logic
In Computer Science conference (which paper is also include in this
distribution). This distinction permeates aspects of the interpreter
in subtle ways, but should not be apparent to the user. A future
version of the system will likely shift to an internal representation
more in line with the journal version of the paper.

More seriously, the interpreter implements a modified proof system that
handles "TOP" lazily, rather than generating all possible subcontexts.
A Latex file of the modified proof system is in the ./papers directory.
The proof that it is sound and complete relative to the original system 
has been completed, and will appear in my thesis.

