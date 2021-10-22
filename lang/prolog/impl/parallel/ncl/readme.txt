Zdravko Markov
Institute of Informatics, Bulgarian Academy of Sciences
Acad.G.Bonchev Street, Block 29A, 1113 Sofia, Bulgaria
Tel: +359-2-707586
Fax: +359-2-720166
Email: markov@iinf.bg

============================== File: README ===============================

Net-Clause Language (NCL)
=========================
NCL is aimed at describing distributed computation models using term
unification as a basic processing and control mechanism. NCL is embedded in
standard Prolog and comprises two parts, which can communicate each to other
and to standard Prolog programs through the unified representation of terms,
the unification procedure and the database mechanism provided by Prolog.


1. Net-Clauses
--------------
A net-clause is a special domain in the database defining a network of nodes
and links. The nodes are represented by Prolog compound terms. The variables
occurring within the nodes are global logical variables, which can be shared
within the scope of the net-clause thus playing the role of network links.
The net-clause nodes define local conditions for unification of terms or 
execution of Prolog goals. Thus two basic mechanisms are implemented:

 - Spreading activation. This is a distributed computation scheme similar to
   the connectionist spreading activation or to the marker passing mechanism 
   in SN's. In the framework of logic programming it is seen as a restricted
   (without recursion) forward chaining computation.

 - Default mechanism similar to the Reiter's default assignment to variables.
   The basic idea is to use variables to propagate terms without being bound
   to them, thus implementing the non-monotonicity of default reasoning.


2. Data-driven Rules (DD-rules)
-------------------------------
DD-rules implement a full scale forward chaining for logic programs. They also
simulate a data-driven parallel computation, where each DD-rule is a process
(in contrast to the traditional parallel logic programming, such as PARLOG for
example, where each goal is a process).



NCL/Prolog Interpreter
======================
NCL/Prolog interpreter is supplied in C-code for UNIX along with a reference
manual and a set of commented examples. The following files are included:

README  - this file
NCL.MAN - Reference manual for NCL/Prolog and how to install it
NCL.C   - NCL/Prolog C-code
NCL.LIB - library file required to run NCL/Prolog

The rest are example programs, each one containing detailed comments
describing the idea, the implementation and examples runs.

NLP     - Natural language parsing and semantic analysis
DEFAULT - NL parsing by using NCL default mechanism
GRAMMAR - Grammar rules by DD-rules
MP      - Marker passing in semantic nets
CIRCUIT - Model-based diagnosis of a binary adder
QUEENS  - 4-queens problem as a network of communicating agents
FIG     - Recognition of geometric figures
XOR     - Connectionist-like implementation of XOR
PIXEL   - Connectionist-like feature detection in a binary image
FLATTEN - Stream AND-parallelism in DD-rules
DDIL    - Data-driven inductive learning in a network of relations
FAMILY  - Set of training examples for DDIL

-----------------------------------------------------------------------------


=================================================================
             List of publications related to NCL
=================================================================
1. Markov, Z., C. Dichev & L. Sinapova. The Net-Clause Language -
a  tool  for  describing  network models.  In: Proceedings of the
Eighth Canadian  Conference  on  AI,  Ottawa,  23-25  May,  1990,
pp.33-39.

2.  Markov,  Z.  & Ch. Dichev. Logical inference in a network en-
vironment.  In: Ph.  Jorrand & V.  Sgurev (eds.),  Proceedings of
AIMSA'90,  Artificial Intelligence IV,  North-Holland, 1990, 169-
178

3. Markov, Z., L. Sinapova & Ch.  Dichev.  Default reasoning in a
network  environment.  In:  Proceedings of ECAI-90,  August 6-10,
1990, Stockholm, Sweden, 431-436.

4. Markov, Z. & Ch. Dichev.  The Net-Clause Language - A Tool for
Data-Driven Inference,  In: Logics in AI, Proceedings of European
Workshop JELIA'90,  Amsterdam,  The Netherlands,  September 1990,
LNCS, Vol.478, Springer-Verlag, 366-385.

5.  Markov,  Z. An Approach to Data-Driven Learning. In: Proceed-
ings of the International Workshop on Fundamentals of  Artificial
Intelligence Research (FAIR'91), September 8-12, 1991, Smolenice,
Czechoslovakia,  LNCS, Vol.535, Springer-Verlag, 127-140.

6. Markov, Z. & Ch. Dichev. Distributed Logic Programming, in: G.
Wiggins,  C.  Mellish and T. Duncan (eds.) Proceedings of the 3rd
UK Annual Conference of Logic Programming,  Edinburgh,  Scotland,
1991, Workshops in Computing, Springer-Verlag, 36-55.

7.  Markov,  Z.  A  tool for building connectionist-like networks
based on term unification.  In: M.  Richter and H.  Boley (eds.),
Proceedings of PDK'91, LNCS Vol.567, Springer-Verlag, 119-203.

8.  Markov,  Z.  An  Approach  to  Concept Learning Based on Term
Generalization.   In:  Proceedings  of  the  Ninth  International
Machine Learning Conference (ML92),  San Mateo, CA, 1992, Morgan-
Kaufmann, 310-315.

9. Sinapova, L. & Z.  Markov.  Grammar Representation and Parsing
in a Data-Driven Logic Programming Environment.  In: B. du Boulay
& V.  Sgurev (eds.),  Proceedings of AIMSA'92,  Artificial Intel-
ligence V, North-Holland, 151-159.

10.  Markov, Z. Inductive Inference in Networks of Relations, in:
Proceedings of the  Third  International  Workshop  on  Inductive
Logic Programming (ILP'93), April 1-3, Bled, Slovenia, 256-277.

11.  Sinapova,   L. A network parsing scheme. In: Ph. Jorrand and
V.  Sgurev (eds.),  Proceedings of  AIMSA'90,  Artificial  Intel-
ligence IV, North-Holland, 1990, 383-392.



