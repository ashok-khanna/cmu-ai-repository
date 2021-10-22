[From the manual]

Rudolf  Opalla
Fachbereich Informatik
Universitaet Dortmund
W-4600 Dortmund 50, Germany
opalla@ls5.informatik.uni-dortmund.de


ALF (Algebraic Logic Functional programming language) is a language which 
combines functional and logic programming techniques.  The foundation of ALF 
is Horn clause logic with equality which consists  of  predicates  and  Horn  
clauses  for  logic  programming,  and  functions  and  equations  for
functional programming.  Since ALF is a genuine integration of both programming
paradigms, any functional expression can be used in a goal literal and 
arbitrary predicates can occur in conditions of equations.  The operational 
semantics of ALF is based on the resolution rule to solve literals and
narrowing to evaluate functional expressions.  In order to reduce the number 
of possible narrowing steps, a leftmost-innermost basic narrowing strategy is 
used which can be effici ently implemented.

Furthermore, terms are simplified by rewriting before a narrowing step is 
applied and also equations are  rejected  if  the  two  sides  have  different  
constructors  at  the  top.
Rewriting  and  rejection  can result in a large reduction of the search tree.  Therefore this operational semantics is more efficient than Prolog's resolution 
strategy.

	The ALF system is an efficient implementation of the combination of 
resolution, narrowing, rewriting and rejection.  Similarly to Prolog, ALF uses 
a backtracking strategy corresponding to a depth-first search in the derivation 
tree.  ALF programs are compiled into instructions of an abstract machine.  
The abstract machine is based on the Warren Abstract Machine (WAM) with  
several  extensions  to implement narrowing and rewriting.  In  the current  
implementation programs of this abstract machine are executed by an emulator 
written in C.  ALF  has  also  a  type  and  module  concept  which  allows  
the  definition  of  generic  modules.  A preprocessor checks the type 
consistence of the program and combines all needed modules into one flat-ALF  
program  which  is  compiled  into  a  compact  bytecode  representing an  
abstract  machine program.  The current implementation has the following 
properties:

       o  The machine code for pure logic programs without defined functions is 
identical to the code of  the  original  WAM  [War83],  i.e.,  for  logic  
programs  there  is no  overhead  because  of  the functional part of the 
language.

     o  Functional programs where only ground terms have to be evaluated are 
executed by deterministic rewriting without any dynamic search for subterms 
positions where the next rewriting step can be applied.  The compiler computes 
these positions and generates particular machine instructions.  Therefore such 
programs are also efficiently executed.

     o  In  mixed  functional  and  logic  programs  argument  terms  are  
simplified  by  rewriting  before narrowing is applied and therefore function 
calls with ground arguments are automatically evaluated  by  rewriting  and  
not  by  narrowing.   This  is  more  efficient  because  rewriting  is a  
deterministic  process.   Hence  in  most  practical  cases  the  combined  
rewriting/narrowing implementation  is  more  efficient  than  an  
implementation  of  narro wing  by  flattening  terms and applying SLD-
resolution [Han91].


