/*
  implementation by Adam M. Costello, R. P. Loui, and Andrew Merrill 
  theory by LMNO-PQRS:  R. Loui, A. Merrill, J. Norman, J. Olson, after
	D. Poole, J. Pollock, G. R. Simari, and Q. Stiefvater	

  11/92	spec11.c is spec10.c with unique names assumption.

  6/93	use pre.p (perl) to pre-process MUTEX and CASE statements.

  10,11/93 spec12.c fixes a few bugs with pending list, specificity
	with NULL activators, and auxiliarizing wff variables

  1/94	spec13.c makes pending list global.

  BUGS:  
	check for UNIMPLEMENTED code

	check for un-freed space when assigning NULL

*/

/* 
NATHAN(l)                 MISC. REFERENCE MANUAL PAGES                 NATHAN(l)



NAME
     nathan - specs1-13

SYNOPSIS
     nathan [-IATGPMSVRHCL] [-s n] [-a n] [-b n] [-l n]


DESCRIPTION
     nathan conducts an argument pro and con upon evidence and defeasible
     rules, in response to a query.  The underlying logic is first-order.
     For a description of the logical system on which this is based, see

		Loui.  "A system of defasible inference," COMPUTATIONAL 
			INTELLIGENCE 3, 1987.

		Simari and Loui.  "Mathematics of defeasible reasoning,"
			ARTIFICIAL INTELLIGENCE 53, 1992.

		Loui, Norman, Merrill, Olson, Stiefvater, Costello.
			"Computing specificity," Washington Universtiy CS
			Technical Report 93-03, 1993.

OPTIONS
	options are for printing or suppressing output (all toggle):
	    -I seeinput
	    -A PRINTARGS
	    -T PRINTTOP
	    -G PRINTTGTS
	    -P PRINTPROG
	    -M PRINTTIME
	    -S PRINTSUPPORTED
	    -V PRINTVIABLES
	    -R PRINTRESULT
	    -H PRINTSEARCH
	    -C PRINTCLAUSES

	for disallowing reasoning-by-cases:

	    -L ALLOWCASES

	for changing the parameters of the theorem-proving:
	setting the maximum attempted and successful resolutions:

	    -s n SLIMIT
	    -a n ALIMIT
	    -b n ABONUS

	setting the maximum number of literals in a resultant clause:

	    -l n LITLIMIT

	The defaults are 1000 successes, 10000 attempts, 10 bonus attempts
	per success, and 20 literals maximum.  Reasoning deductively by cases 
	is allowed by default.

INPUT
     Input is piped in the following format:
     
     Contingent evidence is terminated with exclamation:

		bird(tweety)!
		penguin(opus)!
		~flies(tweety)!

     Necessary evidence is terminated with period (please note the
     parenthesization w.r.t. material conditional):

		A x,y ( loves(x,y) <=> loves(y,x) ).
		A x ( penguin(x) => bird(x) ).
		true.

     Defeasible rules are prefixed with R and terminated with period:

		R x bird(x) >-- flies(x).
		R y penguin(y) >-- ~flies(y).
		R , true >-- loves(opus, tweety).

     Note how the variables (or lack thereof) are indicated.
     Variables are prefixed with "?" internally in the program.

     The query is indicated by a question mark.

		flies(opus)?


     The following equivalences are allowed by the parser:
	
		<=> iff IFF
		=> implies IMPLIES
		v or OR
		^ & and AND
		~ not NOT
		A forall FORALL
		E exists EXISTS
		R rule RULE
		>- suggests SUGGESTS

     More examples appear in the typescript attached.

     Nameq is a reserved predicate that has the following behavior:

	nameq(f(a,b), f(a,b), f(a,b))  immediately evaluates to true.
	nameq(f(a,b), a)               does not immediately evaluate.
	nameq(f(a,b), a, b, f(a,b))    immediately evaluates to false.
	nameq(?x1, a)                  does not immediately evaluate.
	nameq(?x1, a, b)               immediately evaluates to false.
	nameq(!f1, !f1)                immediately evaluates to true.
	nameq(?x1, ?x1)                does not immediately evaluate.

     MUTEX:, CASE:, MIN:, OPT: and DECISION: are reserved for the
     perl preprocessor of mutual exclusion statements and rule-extraction
     from cases.

OUTPUT

     The basic output of nathan is a 0, 1, or -1, depending on which side
     of the query (or neither) won the argument.  However, the default
     options are to print the input (-I), the targets (-T), the time (-M),
     and the progress (-P). (-R) suppresses the result.  

	
EXAMPLES

	the file, ex2:

	penguin(opus)!
	R x bird(x) >- flies(x).
	R x penguin(x) >- ~flies(x).
	A x (penguin(x) => bird(x)).
	flies(opus)?

	% nathan < ex2

	INPUT:
	penguin(opus)!
	R x bird(x) >- flies(x).
	R x penguin(x) >- ~flies(x).
	A x (penguin(x) => bird(x)).
	flies(opus)?
	DISPUTING flies(opus)

	A tries to support:  flies(opus)

	A has an argument for flies(opus)
	B has an argument for ~(flies(opus))
	   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
	   TARGETS:  flies(opus)  
	   B ALLOWS A's subarguments for flies(opus)
	      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
	      TARGETS:  ~(flies(opus))  
	      A ALLOWS B's subarguments for ~(flies(opus))

	************ round 1 ************
	A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
	A ACTIVATOR: bird(opus)
	B ACTIVATOR: penguin(opus)
	B's ARGUMENT IS MORE SPECIFIC
	no more arguments for A
	A exhausts arguments for: flies(opus)

	B tries to support: ~(flies(opus))

	   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(opus))
	   TARGETS:  ~(flies(opus))  
	   A ALLOWS B's subarguments for ~(flies(opus))
	      B is CHECKING SUBARGUMENTS to defeat A's establishment of flies(opus)
	      TARGETS:  flies(opus)  
	      B ALLOWS A's subarguments for flies(opus)

	************ round 2 ************
	B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
	no more arguments for A
	B WINS ~(flies(opus))
	-1
	0.083330 seconds


BUGS

     Please report all bugs to loui@ai.wustl.edu.

SEE ALSO

     pre.p, a pre-processor to doctor the input when using mutual
     exclusion or rule-extraction from cases:

	input to pre.p:

	penguin(opus)!
	pays_taxes(opus)!
	onplane(opus)!
	A x (penguin(x) => bird(x)).
	R x bird(x) ^ adult(x) >- flies(x).
	R x penguin(x) >- ~adult(x).
	R x penguin(x) >- ~flies(x).
	R x penguin(x) ^ adult(x) ^ onplane(x) >- ~flies(x).
	R x onplane(x) >- flies(x).
	R x pays_taxes(x) >- adult(x).
	# cases are not yet named
	CASE: 	MIN:  penguin(x) ^ adult(x) OPT: pays_taxes(x) ^ eats_seed(x) ^ lifts_weights(x) DECISION: flies(x).
	MUTEX:  penguin(x) ostrich(x) llama(x).
	R x adult(x) >-- llama(x).
	adult(opus) ^ penguin(opus)?

	output from pre.p:

	penguin(opus)!
	pays_taxes(opus)!
	onplane(opus)!
	A x (penguin(x) => bird(x)).
	R x bird(x) ^ adult(x) >- flies(x).
	R x penguin(x) >- ~adult(x).
	R x penguin(x) >- ~flies(x).
	R x penguin(x) ^ adult(x) ^ onplane(x) >- ~flies(x).
	R x onplane(x) >- flies(x).
	R x pays_taxes(x) >- adult(x).
	R x penguin(x) ^ adult(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  pays_taxes(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  eats_seed(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  pays_taxes(x) ^  eats_seed(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  lifts_weights(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  pays_taxes(x) ^  lifts_weights(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  eats_seed(x) ^  lifts_weights(x) >-  flies(x).
	R x penguin(x) ^ adult(x) ^  pays_taxes(x) ^  eats_seed(x) ^  lifts_weights(x) >-  flies(x).
	R x penguin(x) ^ adult(x) >-  flies(x).
	penguin(x) v ostrich(x) v llama(x).
	penguin(x) -> ~ostrich(x).
	penguin(x) -> ~llama(x).
	ostrich(x) -> ~penguin(x).
	ostrich(x) -> ~llama(x).
	llama(x) -> ~penguin(x).
	llama(x) -> ~ostrich(x).
	R x adult(x) >-- llama(x).
	adult(opus) ^ penguin(opus)?
__________________________________________________________________________
INPUT:
bird(tweety)!
~flies(tweety)!
R x bird(x) >- flies(x).
flies(tweety)?
DISPUTING flies(tweety)

A tries to support:  flies(tweety)

A has an argument for flies(tweety)
B has an argument for ~(flies(tweety))
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(tweety)
   TARGETS:  flies(tweety)  
   B ALLOWS A's subarguments for flies(tweety)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(tweety))
      TARGETS:  no targets
      A ALLOWS B's subarguments for ~(flies(tweety))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: bird(tweety)
B ACTIVATOR: (NULL)
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: flies(tweety)

B tries to support: ~(flies(tweety))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(tweety))
   TARGETS:  no targets
   A ALLOWS B's subarguments for ~(flies(tweety))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of flies(tweety)
      TARGETS:  flies(tweety)  
      B ALLOWS A's subarguments for flies(tweety)

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(flies(tweety))
-1
0.049998 seconds
__________________________________________________________________________
INPUT:
penguin(opus)!
R x bird(x) >- flies(x).
R x penguin(x) >- ~flies(x).
A x (penguin(x) => bird(x)).
flies(opus)?
DISPUTING flies(opus)

A tries to support:  flies(opus)

A has an argument for flies(opus)
B has an argument for ~(flies(opus))
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  flies(opus)  
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  ~(flies(opus))  
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: bird(opus)
B ACTIVATOR: penguin(opus)
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: flies(opus)

B tries to support: ~(flies(opus))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(opus))
   TARGETS:  ~(flies(opus))  
   A ALLOWS B's subarguments for ~(flies(opus))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of flies(opus)
      TARGETS:  flies(opus)  
      B ALLOWS A's subarguments for flies(opus)

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(flies(opus))
-1
0.066664 seconds
__________________________________________________________________________
INPUT:
cat(garfield)!
R x cat(x) >- aloof(x).
R x aloof(x) >- ~likes-people(x).
R x cat(x) >- likes-people(x).
likes-people(garfield)?
DISPUTING likes-people(garfield)

A tries to support:  likes-people(garfield)

A has an argument for likes-people(garfield)
B has an argument for ~(likes-people(garfield))
   B is CHECKING SUBARGUMENTS to block A's establishment of likes-people(garfield)
   TARGETS:  likes-people(garfield)  
   B ALLOWS A's subarguments for likes-people(garfield)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(likes-people(garfield))
      TARGETS:  aloof(garfield)    ~(likes-people(garfield))  
      NEW GOAL for A:  ~(aloof(garfield))
      A is ESTABLISHING ~(aloof(garfield)) for support
      A has no argument for ~(aloof(garfield))
      A FAILED TO ESTABLISH ~(aloof(garfield)) for support
      NEW GOAL for A:  likes-people(garfield)
      likes-people(garfield) already pending: A backtracks
      A ALLOWS B's subarguments for ~(likes-people(garfield))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: cat(garfield)
B ACTIVATOR: aloof(garfield)
A's ARGUMENT IS MORE SPECIFIC
no more arguments for B
A WINS likes-people(garfield)
1
0.099996 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) >- hawk(x).
R x quaker(x) >- dove(x).
A x (hawk(x) <=> ~dove(x)).
dove(nixon)?
DISPUTING dove(nixon)

A tries to support:  dove(nixon)

A has an argument for dove(nixon)
B has an argument for ~(dove(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of dove(nixon)
   TARGETS:  dove(nixon)  
   B ALLOWS A's subarguments for dove(nixon)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(dove(nixon))
      TARGETS:  hawk(nixon)  
      NEW GOAL for A:  ~(hawk(nixon))
      A is ESTABLISHING ~(hawk(nixon)) for support
      A has an argument for ~(hawk(nixon))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(hawk(nixon))
         TARGETS:  dove(nixon)  
         NEW GOAL for B:  ~(dove(nixon))
         ~(dove(nixon)) already pending: B backtracks
         B ALLOWS A's subarguments for ~(hawk(nixon))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(hawk(nixon))
         B has an argument for hawk(nixon)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of hawk(nixon)
            TARGETS:  hawk(nixon)  
            A ALLOWS B's subarguments for hawk(nixon)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: quaker(nixon)
      B ACTIVATOR: republican(nixon)
      INCONCLUSIVE
      A seeks another argument for ~(hawk(nixon))
      no more arguments for A
      A FAILED TO ESTABLISH ~(hawk(nixon)) for support
      A ALLOWS B's subarguments for ~(dove(nixon))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: quaker(nixon)
B ACTIVATOR: republican(nixon)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: dove(nixon)

B tries to support: ~(dove(nixon))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(dove(nixon))
   TARGETS:  hawk(nixon)  
   NEW GOAL for A:  ~(hawk(nixon))
   A is ESTABLISHING ~(hawk(nixon)) for viability
   A has an argument for ~(hawk(nixon))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of ~(hawk(nixon))
      TARGETS:  dove(nixon)  
      NEW GOAL for B:  ~(dove(nixon))
      ~(dove(nixon)) already pending: B backtracks
      B ALLOWS A's subarguments for ~(hawk(nixon))
      B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(hawk(nixon))
      B has an argument for hawk(nixon)
         A is CHECKING SUBARGUMENTS to defeat B's establishment of hawk(nixon)
         TARGETS:  hawk(nixon)  
         A ALLOWS B's subarguments for hawk(nixon)
   
************ round 1 ************
   A's ARGUMENT:  (1)   B's ARGUMENT:  (0)   
   A ACTIVATOR: quaker(nixon)
   B ACTIVATOR: republican(nixon)
   INCONCLUSIVE
   B seeks another argument against ~(hawk(nixon))
   no more arguments for B
   A ESTABLISHED ~(hawk(nixon)) for viability
   A DISALLOWS B's subarguments for ~(dove(nixon))
no more arguments for B
NO WINNER FOR dove(nixon)
0
0.216658 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) >- hawk(x).
R x quaker(x) >- dove(x).
A x (hawk(x) <=> ~dove(x)).
dove(nixon)?
DISPUTING dove(nixon)

A tries to support:  dove(nixon)

A has an argument for dove(nixon)
B has an argument for ~(dove(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of dove(nixon)
   TARGETS:  dove(nixon)  
   B ALLOWS A's subarguments for dove(nixon)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(dove(nixon))
      TARGETS:  hawk(nixon)  
      NEW GOAL for A:  ~(hawk(nixon))
      A is ESTABLISHING ~(hawk(nixon)) for support
      A has an argument for ~(hawk(nixon))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(hawk(nixon))
         TARGETS:  dove(nixon)  
         NEW GOAL for B:  ~(dove(nixon))
         ~(dove(nixon)) already pending: B backtracks
         B ALLOWS A's subarguments for ~(hawk(nixon))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(hawk(nixon))
         B has an argument for hawk(nixon)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of hawk(nixon)
            TARGETS:  hawk(nixon)  
            A ALLOWS B's subarguments for hawk(nixon)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: quaker(nixon)
      B ACTIVATOR: republican(nixon)
      INCONCLUSIVE
      A seeks another argument for ~(hawk(nixon))
      no more arguments for A
      A FAILED TO ESTABLISH ~(hawk(nixon)) for support
      A ALLOWS B's subarguments for ~(dove(nixon))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: quaker(nixon)
B ACTIVATOR: republican(nixon)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: dove(nixon)

B tries to support: ~(dove(nixon))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(dove(nixon))
   TARGETS:  hawk(nixon)  
   NEW GOAL for A:  ~(hawk(nixon))
   A is ESTABLISHING ~(hawk(nixon)) for viability
   A has an argument for ~(hawk(nixon))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of ~(hawk(nixon))
      TARGETS:  dove(nixon)  
      NEW GOAL for B:  ~(dove(nixon))
      ~(dove(nixon)) already pending: B backtracks
      B ALLOWS A's subarguments for ~(hawk(nixon))
      B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(hawk(nixon))
      B has an argument for hawk(nixon)
         A is CHECKING SUBARGUMENTS to defeat B's establishment of hawk(nixon)
         TARGETS:  hawk(nixon)  
         A ALLOWS B's subarguments for hawk(nixon)
   
************ round 1 ************
   A's ARGUMENT:  (1)   B's ARGUMENT:  (0)   
   A ACTIVATOR: quaker(nixon)
   B ACTIVATOR: republican(nixon)
   INCONCLUSIVE
   B seeks another argument against ~(hawk(nixon))
   no more arguments for B
   A ESTABLISHED ~(hawk(nixon)) for viability
   A DISALLOWS B's subarguments for ~(dove(nixon))
no more arguments for B
NO WINNER FOR dove(nixon)
0
0.216658 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) >- hawk(x).
R x quaker(x) >- dove(x).
A x (hawk(x) <=> ~dove(x)).
A x (hawk(x) v dove(x) <=> politically-motivated(x)).
politically-motivated(nixon)?
DISPUTING politically-motivated(nixon)

A tries to support:  politically-motivated(nixon)

A has an argument for politically-motivated(nixon)
B has no argument for ~(politically-motivated(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of politically-motivated(nixon)
   TARGETS:  no targets
   B ALLOWS A's subarguments for politically-motivated(nixon)
A WINS politically-motivated(nixon)
1
13.916110 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) >- hawk(x).
R x quaker(x) >- politically-motivated(x).
A x (hawk(x) <=> politically-motivated(x)).
politically-motivated(nixon)?
DISPUTING politically-motivated(nixon)

A tries to support:  politically-motivated(nixon)

A has an argument for politically-motivated(nixon)
B has no argument for ~(politically-motivated(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of politically-motivated(nixon)
   TARGETS:  politically-motivated(nixon)  
   B ALLOWS A's subarguments for politically-motivated(nixon)
A WINS politically-motivated(nixon)
1
0.049998 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) >- ~pacifist(x).
R x quaker(x) >- pacifist(x).
R x republican(x) >- footballfan(x).
R x footballfan(x) >- ~antimilitary(x).
R x pacifist(x) >- antimilitary(x).
antimilitary(nixon)?
DISPUTING antimilitary(nixon)

A tries to support:  antimilitary(nixon)

A has an argument for antimilitary(nixon)
B has an argument for ~(antimilitary(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of antimilitary(nixon)
   TARGETS:  pacifist(nixon)    antimilitary(nixon)  
   NEW GOAL for B:  ~(pacifist(nixon))
   B is ESTABLISHING ~(pacifist(nixon)) for viability
   B has an argument for ~(pacifist(nixon))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(pacifist(nixon))
      TARGETS:  ~(pacifist(nixon))  
      A ALLOWS B's subarguments for ~(pacifist(nixon))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(pacifist(nixon))
      A has an argument for pacifist(nixon)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of pacifist(nixon)
         TARGETS:  pacifist(nixon)  
         B ALLOWS A's subarguments for pacifist(nixon)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: republican(nixon)
   A ACTIVATOR: quaker(nixon)
   INCONCLUSIVE
   A seeks another argument against ~(pacifist(nixon))
   no more arguments for A
   B ESTABLISHED ~(pacifist(nixon)) for viability
   B DISALLOWS A's subarguments for antimilitary(nixon)
no more arguments for A
A exhausts arguments for: antimilitary(nixon)

B tries to support: ~(antimilitary(nixon))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(antimilitary(nixon))
   TARGETS:  footballfan(nixon)    ~(antimilitary(nixon))  
   NEW GOAL for A:  ~(footballfan(nixon))
   A is ESTABLISHING ~(footballfan(nixon)) for viability
   A has no argument for ~(footballfan(nixon))
   A FAILED TO ESTABLISH ~(footballfan(nixon)) for viability
   NEW GOAL for A:  antimilitary(nixon)
   antimilitary(nixon) already pending: A backtracks
   A ALLOWS B's subarguments for ~(antimilitary(nixon))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of antimilitary(nixon)
      TARGETS:  pacifist(nixon)    antimilitary(nixon)  
      NEW GOAL for B:  ~(pacifist(nixon))
      B is ESTABLISHING ~(pacifist(nixon)) for support
      B has an argument for ~(pacifist(nixon))
         A is CHECKING SUBARGUMENTS to block B's establishment of ~(pacifist(nixon))
         TARGETS:  ~(pacifist(nixon))  
         A ALLOWS B's subarguments for ~(pacifist(nixon))
         A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(pacifist(nixon))
         A has an argument for pacifist(nixon)
            B is CHECKING SUBARGUMENTS to defeat A's establishment of pacifist(nixon)
            TARGETS:  pacifist(nixon)  
            B ALLOWS A's subarguments for pacifist(nixon)
      
************ round 1 ************
      B's ARGUMENT:  (1)      A's ARGUMENT:  (0)      
      B ACTIVATOR: republican(nixon)
      A ACTIVATOR: quaker(nixon)
      INCONCLUSIVE
      B seeks another argument for ~(pacifist(nixon))
      no more arguments for B
      B FAILED TO ESTABLISH ~(pacifist(nixon)) for support
      NEW GOAL for B:  ~(antimilitary(nixon))
      ~(antimilitary(nixon)) already pending: B backtracks
      B ALLOWS A's subarguments for antimilitary(nixon)

************ round 1 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)
B ACTIVATOR: pacifist(nixon)
A ACTIVATOR: footballfan(nixon)
INCONCLUSIVE
no more arguments for B
B exhausts arguments for: ~(antimilitary(nixon))
NO WINNER FOR antimilitary(nixon)
0
0.299988 seconds
__________________________________________________________________________
INPUT:
alive(0) ^ loaded(s(0)) ^ fired(s(s(s(0))))!
R x alive(x) >- alive(s(x)).
R x loaded(x) >- loaded(s(x)).
R x loaded(x) ^ fired(x) ^ alive(x) >- ~alive(s(x)).
alive(s(s(s(s(0)))))?
DISPUTING alive(s(s(s(s(0)))))

A tries to support:  alive(s(s(s(s(0)))))

A has an argument for alive(s(s(s(s(0)))))
B has an argument for ~(alive(s(s(s(s(0))))))
   B is CHECKING SUBARGUMENTS to block A's establishment of alive(s(s(s(s(0)))))
   TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    alive(s(s(s(s(0)))))  
   NEW GOAL for B:  ~(alive(s(0)))
   B is ESTABLISHING ~(alive(s(0))) for viability
   B has no argument for ~(alive(s(0)))
   B FAILED TO ESTABLISH ~(alive(s(0))) for viability
   NEW GOAL for B:  ~(alive(s(s(0))))
   B is ESTABLISHING ~(alive(s(s(0)))) for viability
   B has no argument for ~(alive(s(s(0))))
   B FAILED TO ESTABLISH ~(alive(s(s(0)))) for viability
   NEW GOAL for B:  ~(alive(s(s(s(0)))))
   B is ESTABLISHING ~(alive(s(s(s(0))))) for viability
   B has no argument for ~(alive(s(s(s(0)))))
   B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for viability
   NEW GOAL for B:  ~(alive(s(s(s(s(0))))))
   ~(alive(s(s(s(s(0)))))) already pending: B backtracks
   B ALLOWS A's subarguments for alive(s(s(s(s(0)))))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(alive(s(s(s(s(0))))))
      TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    loaded(s(s(0)))    loaded(s(s(s(0))))    ~(alive(s(s(s(s(0))))))  
      NEW GOAL for A:  ~(alive(s(0)))
      A is ESTABLISHING ~(alive(s(0))) for support
      A has no argument for ~(alive(s(0)))
      A FAILED TO ESTABLISH ~(alive(s(0))) for support
      NEW GOAL for A:  ~(alive(s(s(0))))
      A is ESTABLISHING ~(alive(s(s(0)))) for support
      A has no argument for ~(alive(s(s(0))))
      A FAILED TO ESTABLISH ~(alive(s(s(0)))) for support
      NEW GOAL for A:  ~(alive(s(s(s(0)))))
      A is ESTABLISHING ~(alive(s(s(s(0))))) for support
      A has no argument for ~(alive(s(s(s(0)))))
      A FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for support
      NEW GOAL for A:  ~(loaded(s(s(0))))
      A is ESTABLISHING ~(loaded(s(s(0)))) for support
      A has no argument for ~(loaded(s(s(0))))
      A FAILED TO ESTABLISH ~(loaded(s(s(0)))) for support
      NEW GOAL for A:  ~(loaded(s(s(s(0)))))
      A is ESTABLISHING ~(loaded(s(s(s(0))))) for support
      A has no argument for ~(loaded(s(s(s(0)))))
      A FAILED TO ESTABLISH ~(loaded(s(s(s(0))))) for support
      NEW GOAL for A:  alive(s(s(s(s(0)))))
      alive(s(s(s(s(0))))) already pending: A backtracks
      A ALLOWS B's subarguments for ~(alive(s(s(s(s(0))))))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: alive(s(s(s(0))))
B ACTIVATOR: (loaded(s(s(s(0)))) ^ (fired(s(s(s(0)))) ^ alive(s(s(s(0))))))
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: alive(s(s(s(s(0)))))

B tries to support: ~(alive(s(s(s(s(0))))))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(alive(s(s(s(s(0))))))
   TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    loaded(s(s(0)))    loaded(s(s(s(0))))    ~(alive(s(s(s(s(0))))))  
   NEW GOAL for A:  ~(alive(s(0)))
   A is ESTABLISHING ~(alive(s(0))) for viability
   A has no argument for ~(alive(s(0)))
   A FAILED TO ESTABLISH ~(alive(s(0))) for viability
   NEW GOAL for A:  ~(alive(s(s(0))))
   A is ESTABLISHING ~(alive(s(s(0)))) for viability
   A has no argument for ~(alive(s(s(0))))
   A FAILED TO ESTABLISH ~(alive(s(s(0)))) for viability
   NEW GOAL for A:  ~(alive(s(s(s(0)))))
   A is ESTABLISHING ~(alive(s(s(s(0))))) for viability
   A has no argument for ~(alive(s(s(s(0)))))
   A FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for viability
   NEW GOAL for A:  ~(loaded(s(s(0))))
   A is ESTABLISHING ~(loaded(s(s(0)))) for viability
   A has no argument for ~(loaded(s(s(0))))
   A FAILED TO ESTABLISH ~(loaded(s(s(0)))) for viability
   NEW GOAL for A:  ~(loaded(s(s(s(0)))))
   A is ESTABLISHING ~(loaded(s(s(s(0))))) for viability
   A has no argument for ~(loaded(s(s(s(0)))))
   A FAILED TO ESTABLISH ~(loaded(s(s(s(0))))) for viability
   NEW GOAL for A:  alive(s(s(s(s(0)))))
   alive(s(s(s(s(0))))) already pending: A backtracks
   A ALLOWS B's subarguments for ~(alive(s(s(s(s(0))))))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of alive(s(s(s(s(0)))))
      TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    alive(s(s(s(s(0)))))  
      NEW GOAL for B:  ~(alive(s(0)))
      B is ESTABLISHING ~(alive(s(0))) for support
      B has no argument for ~(alive(s(0)))
      B FAILED TO ESTABLISH ~(alive(s(0))) for support
      NEW GOAL for B:  ~(alive(s(s(0))))
      B is ESTABLISHING ~(alive(s(s(0)))) for support
      B has no argument for ~(alive(s(s(0))))
      B FAILED TO ESTABLISH ~(alive(s(s(0)))) for support
      NEW GOAL for B:  ~(alive(s(s(s(0)))))
      B is ESTABLISHING ~(alive(s(s(s(0))))) for support
      B has no argument for ~(alive(s(s(s(0)))))
      B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for support
      NEW GOAL for B:  ~(alive(s(s(s(s(0))))))
      ~(alive(s(s(s(s(0)))))) already pending: B backtracks
      B ALLOWS A's subarguments for alive(s(s(s(s(0)))))

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(alive(s(s(s(s(0))))))
-1
7.316374 seconds
__________________________________________________________________________
INPUT:
alive(0) ^ loaded(s(0)) ^ fired(s(s(s(0))))!
R x alive(x) >- alive(s(x)).
R x loaded(x) >- loaded(s(x)).
R x loaded(x) ^ fired(x) ^ alive(x) >- ~alive(s(x)).
E x (~alive(x))?
DISPUTING Exists x (~(alive(x)))

A tries to support:  Exists x (~(alive(x)))

A has an argument for Exists x (~(alive(x)))
B has no argument for All x (alive(x))
   B is CHECKING SUBARGUMENTS to block A's establishment of Exists x (~(alive(x)))
   TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    loaded(s(s(0)))    loaded(s(s(s(0))))    ~(alive(s(?x1)))  
   NEW GOAL for B:  ~(alive(s(0)))
   B is ESTABLISHING ~(alive(s(0))) for viability
   B has no argument for ~(alive(s(0)))
   B FAILED TO ESTABLISH ~(alive(s(0))) for viability
   NEW GOAL for B:  ~(alive(s(s(0))))
   B is ESTABLISHING ~(alive(s(s(0)))) for viability
   B has no argument for ~(alive(s(s(0))))
   B FAILED TO ESTABLISH ~(alive(s(s(0)))) for viability
   NEW GOAL for B:  ~(alive(s(s(s(0)))))
   B is ESTABLISHING ~(alive(s(s(s(0))))) for viability
   B has no argument for ~(alive(s(s(s(0)))))
   B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for viability
   NEW GOAL for B:  ~(loaded(s(s(0))))
   B is ESTABLISHING ~(loaded(s(s(0)))) for viability
   B has no argument for ~(loaded(s(s(0))))
   B FAILED TO ESTABLISH ~(loaded(s(s(0)))) for viability
   NEW GOAL for B:  ~(loaded(s(s(s(0)))))
   B is ESTABLISHING ~(loaded(s(s(s(0))))) for viability
   B has no argument for ~(loaded(s(s(s(0)))))
   B FAILED TO ESTABLISH ~(loaded(s(s(s(0))))) for viability
   NEW GOAL for B:  Exists ?x1 (alive(s(?x1)))
   B is ESTABLISHING Exists ?x1 (alive(s(?x1))) for viability
   B has an argument for Exists ?x1 (alive(s(?x1)))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of Exists ?x1 (alive(s(?x1)))
      TARGETS:  alive(s(?x1))  
      NEW GOAL for A:  Exists ?x1 (~(alive(s(?x1))))
      A is ESTABLISHING Exists ?x1 (~(alive(s(?x1)))) for support
      A has an argument for Exists ?x1 (~(alive(s(?x1))))
         B is CHECKING SUBARGUMENTS to block A's establishment of Exists ?x1 (~(alive(s(?x1))))
         TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    loaded(s(s(0)))    loaded(s(s(s(0))))    ~(alive(s(?x1)))  
         NEW GOAL for B:  ~(alive(s(0)))
         B is ESTABLISHING ~(alive(s(0))) for viability
         B has no argument for ~(alive(s(0)))
         B FAILED TO ESTABLISH ~(alive(s(0))) for viability
         NEW GOAL for B:  ~(alive(s(s(0))))
         B is ESTABLISHING ~(alive(s(s(0)))) for viability
         B has no argument for ~(alive(s(s(0))))
         B FAILED TO ESTABLISH ~(alive(s(s(0)))) for viability
         NEW GOAL for B:  ~(alive(s(s(s(0)))))
         B is ESTABLISHING ~(alive(s(s(s(0))))) for viability
         B has no argument for ~(alive(s(s(s(0)))))
         B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for viability
         NEW GOAL for B:  ~(loaded(s(s(0))))
         B is ESTABLISHING ~(loaded(s(s(0)))) for viability
         B has no argument for ~(loaded(s(s(0))))
         B FAILED TO ESTABLISH ~(loaded(s(s(0)))) for viability
         NEW GOAL for B:  ~(loaded(s(s(s(0)))))
         B is ESTABLISHING ~(loaded(s(s(s(0))))) for viability
         B has no argument for ~(loaded(s(s(s(0)))))
         B FAILED TO ESTABLISH ~(loaded(s(s(s(0))))) for viability
         NEW GOAL for B:  Exists ?x1 (alive(s(?x1)))
         Exists ?x1 (alive(s(?x1))) already pending: B backtracks
         B ALLOWS A's subarguments for Exists ?x1 (~(alive(s(?x1))))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to Exists ?x1 (~(alive(s(?x1))))
         B has no argument for All ?x1 (alive(s(?x1)))
      A ESTABLISHED Exists ?x1 (~(alive(s(?x1)))) for support
      A DISALLOWS B's subarguments for Exists ?x1 (alive(s(?x1)))
   B seeks another argument for Exists ?x1 (alive(s(?x1)))
   no more arguments for B
   B FAILED TO ESTABLISH Exists ?x1 (alive(s(?x1))) for viability
   B ALLOWS A's subarguments for Exists x (~(alive(x)))
A WINS Exists x (~(alive(x)))
1
9.882938 seconds
__________________________________________________________________________
INPUT:
alive(0) ^ loaded(s(0)) ^ fired(s(s(s(0))))!
R x alive(x) >- alive(s(x)).
R x loaded(x) >- loaded(s(x)).
R x loaded(x) ^ fired(x) ^ alive(x) >- ~alive(s(x)).
R x alive(x) >- saysyabbadabbadoo(x).
saysyabbadabbadoo(s(s(s(s(0)))))?
DISPUTING saysyabbadabbadoo(s(s(s(s(0)))))

A tries to support:  saysyabbadabbadoo(s(s(s(s(0)))))

A has an argument for saysyabbadabbadoo(s(s(s(s(0)))))
B has no argument for ~(saysyabbadabbadoo(s(s(s(s(0))))))
   B is CHECKING SUBARGUMENTS to block A's establishment of saysyabbadabbadoo(s(s(s(s(0)))))
   TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    alive(s(s(s(s(0)))))    saysyabbadabbadoo(s(s(s(s(0)))))  
   NEW GOAL for B:  ~(alive(s(0)))
   B is ESTABLISHING ~(alive(s(0))) for viability
   B has no argument for ~(alive(s(0)))
   B FAILED TO ESTABLISH ~(alive(s(0))) for viability
   NEW GOAL for B:  ~(alive(s(s(0))))
   B is ESTABLISHING ~(alive(s(s(0)))) for viability
   B has no argument for ~(alive(s(s(0))))
   B FAILED TO ESTABLISH ~(alive(s(s(0)))) for viability
   NEW GOAL for B:  ~(alive(s(s(s(0)))))
   B is ESTABLISHING ~(alive(s(s(s(0))))) for viability
   B has no argument for ~(alive(s(s(s(0)))))
   B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for viability
   NEW GOAL for B:  ~(alive(s(s(s(s(0))))))
   B is ESTABLISHING ~(alive(s(s(s(s(0)))))) for viability
   B has an argument for ~(alive(s(s(s(s(0))))))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(alive(s(s(s(s(0))))))
      TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    loaded(s(s(0)))    loaded(s(s(s(0))))    ~(alive(s(s(s(s(0))))))  
      NEW GOAL for A:  ~(alive(s(0)))
      A is ESTABLISHING ~(alive(s(0))) for support
      A has no argument for ~(alive(s(0)))
      A FAILED TO ESTABLISH ~(alive(s(0))) for support
      NEW GOAL for A:  ~(alive(s(s(0))))
      A is ESTABLISHING ~(alive(s(s(0)))) for support
      A has no argument for ~(alive(s(s(0))))
      A FAILED TO ESTABLISH ~(alive(s(s(0)))) for support
      NEW GOAL for A:  ~(alive(s(s(s(0)))))
      A is ESTABLISHING ~(alive(s(s(s(0))))) for support
      A has no argument for ~(alive(s(s(s(0)))))
      A FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for support
      NEW GOAL for A:  ~(loaded(s(s(0))))
      A is ESTABLISHING ~(loaded(s(s(0)))) for support
      A has no argument for ~(loaded(s(s(0))))
      A FAILED TO ESTABLISH ~(loaded(s(s(0)))) for support
      NEW GOAL for A:  ~(loaded(s(s(s(0)))))
      A is ESTABLISHING ~(loaded(s(s(s(0))))) for support
      A has no argument for ~(loaded(s(s(s(0)))))
      A FAILED TO ESTABLISH ~(loaded(s(s(s(0))))) for support
      NEW GOAL for A:  alive(s(s(s(s(0)))))
      alive(s(s(s(s(0))))) already pending: A backtracks
      A ALLOWS B's subarguments for ~(alive(s(s(s(s(0))))))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(alive(s(s(s(s(0))))))
      A has an argument for alive(s(s(s(s(0)))))
         B is CHECKING SUBARGUMENTS to defeat A's establishment of alive(s(s(s(s(0)))))
         TARGETS:  alive(s(0))    alive(s(s(0)))    alive(s(s(s(0))))    alive(s(s(s(s(0)))))  
         NEW GOAL for B:  ~(alive(s(0)))
         B is ESTABLISHING ~(alive(s(0))) for support
         B has no argument for ~(alive(s(0)))
         B FAILED TO ESTABLISH ~(alive(s(0))) for support
         NEW GOAL for B:  ~(alive(s(s(0))))
         B is ESTABLISHING ~(alive(s(s(0)))) for support
         B has no argument for ~(alive(s(s(0))))
         B FAILED TO ESTABLISH ~(alive(s(s(0)))) for support
         NEW GOAL for B:  ~(alive(s(s(s(0)))))
         B is ESTABLISHING ~(alive(s(s(s(0))))) for support
         B has no argument for ~(alive(s(s(s(0)))))
         B FAILED TO ESTABLISH ~(alive(s(s(s(0))))) for support
         NEW GOAL for B:  ~(alive(s(s(s(s(0))))))
         ~(alive(s(s(s(s(0)))))) already pending: B backtracks
         B ALLOWS A's subarguments for alive(s(s(s(s(0)))))
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: (loaded(s(s(s(0)))) ^ (fired(s(s(s(0)))) ^ alive(s(s(s(0))))))
   A ACTIVATOR: alive(s(s(s(0))))
   B's ARGUMENT IS MORE SPECIFIC
   A seeks another argument against ~(alive(s(s(s(s(0))))))
   no more arguments for A
   B ESTABLISHED ~(alive(s(s(s(s(0)))))) for viability
   B DISALLOWS A's subarguments for saysyabbadabbadoo(s(s(s(s(0)))))
no more arguments for A
A exhausts arguments for: saysyabbadabbadoo(s(s(s(s(0)))))

B tries to support: ~(saysyabbadabbadoo(s(s(s(s(0))))))

NO WINNER FOR saysyabbadabbadoo(s(s(s(s(0)))))
0
5.816434 seconds
__________________________________________________________________________
INPUT:
dancer(noemi)!
R x dancer(x) >- graceful(x).
R x dancer(x) >- ~ballerina(x).
R x graceful(x) ^ dancer(x) >- ballerina(x).
ballerina(noemi)?
DISPUTING ballerina(noemi)

A tries to support:  ballerina(noemi)

A has an argument for ballerina(noemi)
B has an argument for ~(ballerina(noemi))
   B is CHECKING SUBARGUMENTS to block A's establishment of ballerina(noemi)
   TARGETS:  graceful(noemi)    ballerina(noemi)  
   NEW GOAL for B:  ~(graceful(noemi))
   B is ESTABLISHING ~(graceful(noemi)) for viability
   B has no argument for ~(graceful(noemi))
   B FAILED TO ESTABLISH ~(graceful(noemi)) for viability
   NEW GOAL for B:  ~(ballerina(noemi))
   ~(ballerina(noemi)) already pending: B backtracks
   B ALLOWS A's subarguments for ballerina(noemi)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(ballerina(noemi))
      TARGETS:  ~(ballerina(noemi))  
      A ALLOWS B's subarguments for ~(ballerina(noemi))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: (graceful(noemi) ^ dancer(noemi))
B ACTIVATOR: dancer(noemi)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: ballerina(noemi)

B tries to support: ~(ballerina(noemi))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(ballerina(noemi))
   TARGETS:  ~(ballerina(noemi))  
   A ALLOWS B's subarguments for ~(ballerina(noemi))
already countered  (argument -1)
no more arguments for B
NO WINNER FOR ballerina(noemi)
0
0.133328 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) ^ quaker(x) >- ~pacifist(x).
R x quaker(x) >- pacifist(x).
R x republican(x) >- footballfan(x).
R x footballfan(x) >- ~antimilitary(x).
R x pacifist(x) >- antimilitary(x).
~antimilitary(nixon)?
DISPUTING ~(antimilitary(nixon))

A tries to support:  ~(antimilitary(nixon))

A has an argument for ~(antimilitary(nixon))
B has an argument for antimilitary(nixon)
   B is CHECKING SUBARGUMENTS to block A's establishment of ~(antimilitary(nixon))
   TARGETS:  footballfan(nixon)    ~(antimilitary(nixon))  
   NEW GOAL for B:  ~(footballfan(nixon))
   B is ESTABLISHING ~(footballfan(nixon)) for viability
   B has no argument for ~(footballfan(nixon))
   B FAILED TO ESTABLISH ~(footballfan(nixon)) for viability
   NEW GOAL for B:  antimilitary(nixon)
   antimilitary(nixon) already pending: B backtracks
   B ALLOWS A's subarguments for ~(antimilitary(nixon))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of antimilitary(nixon)
      TARGETS:  pacifist(nixon)    antimilitary(nixon)  
      NEW GOAL for A:  ~(pacifist(nixon))
      A is ESTABLISHING ~(pacifist(nixon)) for support
      A has an argument for ~(pacifist(nixon))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(pacifist(nixon))
         TARGETS:  ~(pacifist(nixon))  
         B ALLOWS A's subarguments for ~(pacifist(nixon))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(pacifist(nixon))
         B has an argument for pacifist(nixon)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of pacifist(nixon)
            TARGETS:  pacifist(nixon)  
            A ALLOWS B's subarguments for pacifist(nixon)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: (republican(nixon) ^ quaker(nixon))
      B ACTIVATOR: quaker(nixon)
      A's ARGUMENT IS MORE SPECIFIC
      B seeks another argument against ~(pacifist(nixon))
      no more arguments for B
      A ESTABLISHED ~(pacifist(nixon)) for support
      A DISALLOWS B's subarguments for antimilitary(nixon)
no more arguments for B
A WINS ~(antimilitary(nixon))
1
0.166660 seconds
__________________________________________________________________________
INPUT:
republican(nixon) ^ quaker(nixon)!
R x republican(x) ^ quaker(x) >- ~pacifist(x).
R x quaker(x) >- pacifist(x).
R x republican(x) >- footballfan(x).
R x footballfan(x) >- ~antimilitary(x).
R x pacifist(x) >- antimilitary(x).
pacifist(nixon)?
DISPUTING pacifist(nixon)

A tries to support:  pacifist(nixon)

A has an argument for pacifist(nixon)
B has an argument for ~(pacifist(nixon))
   B is CHECKING SUBARGUMENTS to block A's establishment of pacifist(nixon)
   TARGETS:  pacifist(nixon)  
   B ALLOWS A's subarguments for pacifist(nixon)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(pacifist(nixon))
      TARGETS:  ~(pacifist(nixon))  
      A ALLOWS B's subarguments for ~(pacifist(nixon))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: quaker(nixon)
B ACTIVATOR: (republican(nixon) ^ quaker(nixon))
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: pacifist(nixon)

B tries to support: ~(pacifist(nixon))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(pacifist(nixon))
   TARGETS:  ~(pacifist(nixon))  
   A ALLOWS B's subarguments for ~(pacifist(nixon))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of pacifist(nixon)
      TARGETS:  pacifist(nixon)  
      B ALLOWS A's subarguments for pacifist(nixon)

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(pacifist(nixon))
-1
0.116662 seconds
__________________________________________________________________________
INPUT:
grapevine(seedless-grapevine) ^ seedless(seedless-grapevine)!
R x grapevine(x) >- fruit(x).
R x seedless(x) >- ~fruit(x).
R x grapevine(x) >- vine(x).
R x vine(x) >- arbor(x).
R x fruit(x) >- ~arbor(x).
R x fruit(x) >- tree(x).
R x arbor(x) >- plant(x).
R x tree(x) >- plant(x).
plant(seedless-grapevine)?
DISPUTING plant(seedless-grapevine)

A tries to support:  plant(seedless-grapevine)

A has an argument for plant(seedless-grapevine)
B has no argument for ~(plant(seedless-grapevine))
   B is CHECKING SUBARGUMENTS to block A's establishment of plant(seedless-grapevine)
   TARGETS:  fruit(seedless-grapevine)    tree(seedless-grapevine)    plant(seedless-grapevine)  
   NEW GOAL for B:  ~(fruit(seedless-grapevine))
   B is ESTABLISHING ~(fruit(seedless-grapevine)) for viability
   B has an argument for ~(fruit(seedless-grapevine))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(fruit(seedless-grapevine))
      TARGETS:  ~(fruit(seedless-grapevine))  
      A ALLOWS B's subarguments for ~(fruit(seedless-grapevine))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(fruit(seedless-grapevine))
      A has an argument for fruit(seedless-grapevine)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of fruit(seedless-grapevine)
         TARGETS:  fruit(seedless-grapevine)  
         B ALLOWS A's subarguments for fruit(seedless-grapevine)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: seedless(seedless-grapevine)
   A ACTIVATOR: grapevine(seedless-grapevine)
   INCONCLUSIVE
   A seeks another argument against ~(fruit(seedless-grapevine))
   no more arguments for A
   B ESTABLISHED ~(fruit(seedless-grapevine)) for viability
   B DISALLOWS A's subarguments for plant(seedless-grapevine)
trying next A argument
   B is CHECKING SUBARGUMENTS to block A's establishment of plant(seedless-grapevine)
   TARGETS:  vine(seedless-grapevine)    arbor(seedless-grapevine)    plant(seedless-grapevine)  
   NEW GOAL for B:  ~(vine(seedless-grapevine))
   B is ESTABLISHING ~(vine(seedless-grapevine)) for viability
   B has no argument for ~(vine(seedless-grapevine))
   B FAILED TO ESTABLISH ~(vine(seedless-grapevine)) for viability
   NEW GOAL for B:  ~(arbor(seedless-grapevine))
   B is ESTABLISHING ~(arbor(seedless-grapevine)) for viability
   B has an argument for ~(arbor(seedless-grapevine))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(arbor(seedless-grapevine))
      TARGETS:  fruit(seedless-grapevine)    ~(arbor(seedless-grapevine))  
      NEW GOAL for A:  ~(fruit(seedless-grapevine))
      A is ESTABLISHING ~(fruit(seedless-grapevine)) for support
      A has an argument for ~(fruit(seedless-grapevine))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(fruit(seedless-grapevine))
         TARGETS:  ~(fruit(seedless-grapevine))  
         B ALLOWS A's subarguments for ~(fruit(seedless-grapevine))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(fruit(seedless-grapevine))
         B has an argument for fruit(seedless-grapevine)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of fruit(seedless-grapevine)
            TARGETS:  fruit(seedless-grapevine)  
            A ALLOWS B's subarguments for fruit(seedless-grapevine)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: seedless(seedless-grapevine)
      B ACTIVATOR: grapevine(seedless-grapevine)
      INCONCLUSIVE
      A seeks another argument for ~(fruit(seedless-grapevine))
      no more arguments for A
      A FAILED TO ESTABLISH ~(fruit(seedless-grapevine)) for support
      NEW GOAL for A:  arbor(seedless-grapevine)
      arbor(seedless-grapevine) already pending: A backtracks
      A ALLOWS B's subarguments for ~(arbor(seedless-grapevine))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(arbor(seedless-grapevine))
      A has an argument for arbor(seedless-grapevine)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of arbor(seedless-grapevine)
         TARGETS:  vine(seedless-grapevine)    arbor(seedless-grapevine)  
         NEW GOAL for B:  ~(vine(seedless-grapevine))
         B is ESTABLISHING ~(vine(seedless-grapevine)) for support
         B has no argument for ~(vine(seedless-grapevine))
         B FAILED TO ESTABLISH ~(vine(seedless-grapevine)) for support
         NEW GOAL for B:  ~(arbor(seedless-grapevine))
         ~(arbor(seedless-grapevine)) already pending: B backtracks
         B ALLOWS A's subarguments for arbor(seedless-grapevine)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: fruit(seedless-grapevine)
   A ACTIVATOR: vine(seedless-grapevine)
   INCONCLUSIVE
   A seeks another argument against ~(arbor(seedless-grapevine))
   no more arguments for A
   B ESTABLISHED ~(arbor(seedless-grapevine)) for viability
   B DISALLOWS A's subarguments for plant(seedless-grapevine)
no more arguments for A
A exhausts arguments for: plant(seedless-grapevine)

B tries to support: ~(plant(seedless-grapevine))

NO WINNER FOR plant(seedless-grapevine)
0
0.483314 seconds
__________________________________________________________________________
INPUT:
on(a,b,0)!
on(b,c,0)!
on(c,table,0)!
clear(a,0)!
A s clear(table,s).
R x,y,z,s on(x,z,s) ^ clear(x,s) ^ clear(y,s) >- on(x,y,move(x,y,s)).
R x,y,z,s clear(x,s) ^ clear(y,s) ^ on(x,z,s) >- clear(z,move(x,y,s)).
R x,y,s on(x,y,s) >- ~clear(y,s).
R x,y,z,t,s on(x,y,s) >- on(x,y,move(z,t,s)).
R x,z,t,s clear(x,s) >- clear(x,move(z,t,s)).
clear(b,move(a,table,0))?
DISPUTING clear(b,move(a,table,0))

A tries to support:  clear(b,move(a,table,0))

A has an argument for clear(b,move(a,table,0))
B has an argument for ~(clear(b,move(a,table,0)))
   B is CHECKING SUBARGUMENTS to block A's establishment of clear(b,move(a,table,0))
   TARGETS:  clear(b,move(a,table,0))  
   B ALLOWS A's subarguments for clear(b,move(a,table,0))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(clear(b,move(a,table,0)))
      TARGETS:  on(?x1,b,move(a,table,0))    ~(clear(b,move(a,table,0)))  
      NEW GOAL for A:  Exists ?x1 (~(on(?x1,b,move(a,table,0))))
      A is ESTABLISHING Exists ?x1 (~(on(?x1,b,move(a,table,0)))) for support
      A has no argument for Exists ?x1 (~(on(?x1,b,move(a,table,0))))
      A FAILED TO ESTABLISH Exists ?x1 (~(on(?x1,b,move(a,table,0)))) for support
      NEW GOAL for A:  clear(b,move(a,table,0))
      clear(b,move(a,table,0)) already pending: A backtracks
      A ALLOWS B's subarguments for ~(clear(b,move(a,table,0)))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: (clear(a,0) ^ (clear(table,0) ^ on(a,b,0)))
B ACTIVATOR: on(?x1,b,move(a,table,0))
A's ARGUMENT IS MORE SPECIFIC
no more arguments for B
A WINS clear(b,move(a,table,0))
1
5.333120 seconds
__________________________________________________________________________
INPUT:
penguin(opus)!
pays__taxes(opus)!
onplane(opus)!
A x (penguin(x) => bird(x)).
R x bird(x) ^ adult(x) >- flies(x).
R x penguin(x) >- ~adult(x).
R x penguin(x) >- ~flies(x).
R x penguin(x) ^ adult(x) ^ onplane(x) >- ~flies(x).
R x onplane(x) >- flies(x).
R x pays__taxes(x) >- adult(x).
adult(opus) ^ penguin(opus)?
DISPUTING (adult(opus) ^ penguin(opus))

A tries to support:  (adult(opus) ^ penguin(opus))

A has an argument for (adult(opus) ^ penguin(opus))
B has an argument for (~(adult(opus)) v ~(penguin(opus)))
   B is CHECKING SUBARGUMENTS to block A's establishment of (adult(opus) ^ penguin(opus))
   TARGETS:  adult(opus)  
   NEW GOAL for B:  ~(adult(opus))
   B is ESTABLISHING ~(adult(opus)) for viability
   B has an argument for ~(adult(opus))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(adult(opus))
      TARGETS:  ~(adult(opus))  
      A ALLOWS B's subarguments for ~(adult(opus))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(adult(opus))
      A has an argument for adult(opus)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of adult(opus)
         TARGETS:  adult(opus)  
         B ALLOWS A's subarguments for adult(opus)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: penguin(opus)
   A ACTIVATOR: pays__taxes(opus)
   INCONCLUSIVE
   A seeks another argument against ~(adult(opus))
   no more arguments for A
   B ESTABLISHED ~(adult(opus)) for viability
   B DISALLOWS A's subarguments for (adult(opus) ^ penguin(opus))
no more arguments for A
A exhausts arguments for: (adult(opus) ^ penguin(opus))

B tries to support: (~(adult(opus)) v ~(penguin(opus)))

   A is CHECKING SUBARGUMENTS to block B's establishment of (~(adult(opus)) v ~(penguin(opus)))
   TARGETS:  ~(adult(opus))  
   NEW GOAL for A:  adult(opus)
   A is ESTABLISHING adult(opus) for viability
   A has an argument for adult(opus)
      B is CHECKING SUBARGUMENTS to defeat A's establishment of adult(opus)
      TARGETS:  adult(opus)  
      B ALLOWS A's subarguments for adult(opus)
      B CHECKING FOR TOP-LEVEL COUNTERARGS to adult(opus)
      already pending:  B backtracks
   A ESTABLISHED adult(opus) for viability
   A DISALLOWS B's subarguments for (~(adult(opus)) v ~(penguin(opus)))
no more arguments for B
NO WINNER FOR (adult(opus) ^ penguin(opus))
0
0.216658 seconds
__________________________________________________________________________
INPUT:
smells__like__fish(opus)!
waddles(opus)!
R x smells__like__fish(x) ^ waddles(x) >- penguin(x).
A x (penguin(x) => bird(x)).
R x penguin(x) >- ~flies(x).
R x bird(x) >- flies(x).
flies(opus)?
DISPUTING flies(opus)

A tries to support:  flies(opus)

A has an argument for flies(opus)
B has an argument for ~(flies(opus))
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  penguin(opus)    flies(opus)  
   NEW GOAL for B:  ~(penguin(opus))
   B is ESTABLISHING ~(penguin(opus)) for viability
   B has no argument for ~(penguin(opus))
   B FAILED TO ESTABLISH ~(penguin(opus)) for viability
   NEW GOAL for B:  ~(flies(opus))
   ~(flies(opus)) already pending: B backtracks
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  penguin(opus)    ~(flies(opus))  
      NEW GOAL for A:  ~(penguin(opus))
      A is ESTABLISHING ~(penguin(opus)) for support
      A has no argument for ~(penguin(opus))
      A FAILED TO ESTABLISH ~(penguin(opus)) for support
      NEW GOAL for A:  flies(opus)
      flies(opus) already pending: A backtracks
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: bird(opus)
B ACTIVATOR: penguin(opus)
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: flies(opus)

B tries to support: ~(flies(opus))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(opus))
   TARGETS:  penguin(opus)    ~(flies(opus))  
   NEW GOAL for A:  ~(penguin(opus))
   A is ESTABLISHING ~(penguin(opus)) for viability
   A has no argument for ~(penguin(opus))
   A FAILED TO ESTABLISH ~(penguin(opus)) for viability
   NEW GOAL for A:  flies(opus)
   flies(opus) already pending: A backtracks
   A ALLOWS B's subarguments for ~(flies(opus))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of flies(opus)
      TARGETS:  penguin(opus)    flies(opus)  
      NEW GOAL for B:  ~(penguin(opus))
      B is ESTABLISHING ~(penguin(opus)) for support
      B has no argument for ~(penguin(opus))
      B FAILED TO ESTABLISH ~(penguin(opus)) for support
      NEW GOAL for B:  ~(flies(opus))
      ~(flies(opus)) already pending: B backtracks
      B ALLOWS A's subarguments for flies(opus)

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(flies(opus))
-1
0.299988 seconds
__________________________________________________________________________
INPUT:
smells__like__fish(opus)!
bird(opus)!
R x smells__like__fish(x) ^ bird(x) >- penguin(x).
A x (penguin(x) => bird(x)).
R x penguin(x) >- ~flies(x).
R x bird(x) >- flies(x).
flies(opus)?
DISPUTING flies(opus)

A tries to support:  flies(opus)

A has an argument for flies(opus)
B has an argument for ~(flies(opus))
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  flies(opus)  
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  penguin(opus)    ~(flies(opus))  
      NEW GOAL for A:  ~(penguin(opus))
      A is ESTABLISHING ~(penguin(opus)) for support
      A has no argument for ~(penguin(opus))
      A FAILED TO ESTABLISH ~(penguin(opus)) for support
      NEW GOAL for A:  flies(opus)
      flies(opus) already pending: A backtracks
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: bird(opus)
B ACTIVATOR: penguin(opus)
B's ARGUMENT IS MORE SPECIFIC
trying next A argument
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  penguin(opus)    flies(opus)  
   NEW GOAL for B:  ~(penguin(opus))
   B is ESTABLISHING ~(penguin(opus)) for viability
   B has no argument for ~(penguin(opus))
   B FAILED TO ESTABLISH ~(penguin(opus)) for viability
   NEW GOAL for B:  ~(flies(opus))
   ~(flies(opus)) already pending: B backtracks
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  penguin(opus)    ~(flies(opus))  
      NEW GOAL for A:  ~(penguin(opus))
      A is ESTABLISHING ~(penguin(opus)) for support
      A has no argument for ~(penguin(opus))
      A FAILED TO ESTABLISH ~(penguin(opus)) for support
      NEW GOAL for A:  flies(opus)
      flies(opus) already pending: A backtracks
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 2 ************
A's ARGUMENT:  (2)B's ARGUMENT:  (-1)
A ACTIVATOR: ((smells__like__fish(opus) ^ bird(opus)) ^ bird(opus))
B ACTIVATOR: penguin(opus)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: flies(opus)

B tries to support: ~(flies(opus))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(opus))
   TARGETS:  penguin(opus)    ~(flies(opus))  
   NEW GOAL for A:  ~(penguin(opus))
   A is ESTABLISHING ~(penguin(opus)) for viability
   A has no argument for ~(penguin(opus))
   A FAILED TO ESTABLISH ~(penguin(opus)) for viability
   NEW GOAL for A:  flies(opus)
   flies(opus) already pending: A backtracks
   A ALLOWS B's subarguments for ~(flies(opus))
already countered  (argument -1)
no more arguments for B
NO WINNER FOR flies(opus)
0
0.299988 seconds
__________________________________________________________________________
INPUT:
a(t)!
b(t)!
c(t)!
d(t)!
e(t)!
f(t)!
g(t)!
R x a(x) >- i(x).
R x b(x) ^ i(x) >- h(x).
R x c(x) >- j(x).
R x a(x) ^ j(x) >- ~i(x).
R x d(x) >- k(x).
R x c(x) ^ k(x) >- ~j(x).
R x e(x) >- l(x).
R x d(x) ^ l(x) >- ~k(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  i(t)    h(t)  
   NEW GOAL for B:  ~(i(t))
   B is ESTABLISHING ~(i(t)) for viability
   B has an argument for ~(i(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(i(t))
      TARGETS:  j(t)    ~(i(t))  
      NEW GOAL for A:  ~(j(t))
      A is ESTABLISHING ~(j(t)) for support
      A has an argument for ~(j(t))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(j(t))
         TARGETS:  k(t)    ~(j(t))  
         NEW GOAL for B:  ~(k(t))
         B is ESTABLISHING ~(k(t)) for viability
         B has an argument for ~(k(t))
            A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(k(t))
            TARGETS:  l(t)    ~(k(t))  
            NEW GOAL for A:  ~(l(t))
            A is ESTABLISHING ~(l(t)) for support
            A has no argument for ~(l(t))
            A FAILED TO ESTABLISH ~(l(t)) for support
            NEW GOAL for A:  k(t)
            k(t) already pending: A backtracks
            A ALLOWS B's subarguments for ~(k(t))
            A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(k(t))
            A has an argument for k(t)
               B is CHECKING SUBARGUMENTS to defeat A's establishment of k(t)
               TARGETS:  k(t)  
               B ALLOWS A's subarguments for k(t)
         
************ round 1 ************
         B's ARGUMENT:  (1)         A's ARGUMENT:  (0)         
         B ACTIVATOR: (d(t) ^ l(t))
         A ACTIVATOR: d(t)
         B's ARGUMENT IS MORE SPECIFIC
         A seeks another argument against ~(k(t))
         no more arguments for A
         B ESTABLISHED ~(k(t)) for viability
         B DISALLOWS A's subarguments for ~(j(t))
      A seeks another argument for ~(j(t))
      no more arguments for A
      A FAILED TO ESTABLISH ~(j(t)) for support
      NEW GOAL for A:  i(t)
      i(t) already pending: A backtracks
      A ALLOWS B's subarguments for ~(i(t))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(i(t))
      A has an argument for i(t)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of i(t)
         TARGETS:  i(t)  
         B ALLOWS A's subarguments for i(t)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: (a(t) ^ j(t))
   A ACTIVATOR: a(t)
   B's ARGUMENT IS MORE SPECIFIC
   A seeks another argument against ~(i(t))
   no more arguments for A
   B ESTABLISHED ~(i(t)) for viability
   B DISALLOWS A's subarguments for h(t)
no more arguments for A
A exhausts arguments for: h(t)

B tries to support: ~(h(t))

NO WINNER FOR h(t)
0
0.466648 seconds
__________________________________________________________________________
INPUT:
a(t)!
b(t)!
c(t)!
d(t)!
e(t)!
f(t)!
g(t)!
R x a(x) >- i(x).
R x b(x) ^ i(x) >- h(x).
R x c(x) >- j(x).
R x a(x) ^ j(x) >- ~i(x).
R x d(x) >- k(x).
R x c(x) ^ k(x) >- ~j(x).
R x m(x) >- l(x).
R x e(x) >- m(x).
R x d(x) ^ l(x) >- ~k(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  i(t)    h(t)  
   NEW GOAL for B:  ~(i(t))
   B is ESTABLISHING ~(i(t)) for viability
   B has an argument for ~(i(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(i(t))
      TARGETS:  j(t)    ~(i(t))  
      NEW GOAL for A:  ~(j(t))
      A is ESTABLISHING ~(j(t)) for support
      A has an argument for ~(j(t))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(j(t))
         TARGETS:  k(t)    ~(j(t))  
         NEW GOAL for B:  ~(k(t))
         B is ESTABLISHING ~(k(t)) for viability
         B has an argument for ~(k(t))
            A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(k(t))
            TARGETS:  m(t)    l(t)    ~(k(t))  
            NEW GOAL for A:  ~(m(t))
            A is ESTABLISHING ~(m(t)) for support
            A has no argument for ~(m(t))
            A FAILED TO ESTABLISH ~(m(t)) for support
            NEW GOAL for A:  ~(l(t))
            A is ESTABLISHING ~(l(t)) for support
            A has no argument for ~(l(t))
            A FAILED TO ESTABLISH ~(l(t)) for support
            NEW GOAL for A:  k(t)
            k(t) already pending: A backtracks
            A ALLOWS B's subarguments for ~(k(t))
            A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(k(t))
            A has an argument for k(t)
               B is CHECKING SUBARGUMENTS to defeat A's establishment of k(t)
               TARGETS:  k(t)  
               B ALLOWS A's subarguments for k(t)
         
************ round 1 ************
         B's ARGUMENT:  (1)         A's ARGUMENT:  (0)         
         B ACTIVATOR: (d(t) ^ l(t))
         A ACTIVATOR: d(t)
         B's ARGUMENT IS MORE SPECIFIC
         A seeks another argument against ~(k(t))
         no more arguments for A
         B ESTABLISHED ~(k(t)) for viability
         B DISALLOWS A's subarguments for ~(j(t))
      A seeks another argument for ~(j(t))
      no more arguments for A
      A FAILED TO ESTABLISH ~(j(t)) for support
      NEW GOAL for A:  i(t)
      i(t) already pending: A backtracks
      A ALLOWS B's subarguments for ~(i(t))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(i(t))
      A has an argument for i(t)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of i(t)
         TARGETS:  i(t)  
         B ALLOWS A's subarguments for i(t)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: (a(t) ^ j(t))
   A ACTIVATOR: a(t)
   B's ARGUMENT IS MORE SPECIFIC
   A seeks another argument against ~(i(t))
   no more arguments for A
   B ESTABLISHED ~(i(t)) for viability
   B DISALLOWS A's subarguments for h(t)
no more arguments for A
A exhausts arguments for: h(t)

B tries to support: ~(h(t))

NO WINNER FOR h(t)
0
0.533312 seconds
__________________________________________________________________________
INPUT:
a(t)!
b(t)!
c(t)!
d(t)!
e(t)!
f(t)!
g(t)!
m(t)!
R x a(x) >- i(x).
R x b(x) ^ i(x) >- h(x).
R x c(x) >- j(x).
R x a(x) ^ j(x) >- ~i(x).
R x d(x) >- k(x).
R x c(x) ^ k(x) >- ~j(x).
R x e(x) >- l(x).
R x d(x) ^ l(x) >- ~k(x).
R x f(x) >- m(x).
R x e(x) ^ m(x) >- ~l(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  i(t)    h(t)  
   NEW GOAL for B:  ~(i(t))
   B is ESTABLISHING ~(i(t)) for viability
   B has an argument for ~(i(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(i(t))
      TARGETS:  j(t)    ~(i(t))  
      NEW GOAL for A:  ~(j(t))
      A is ESTABLISHING ~(j(t)) for support
      A has an argument for ~(j(t))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(j(t))
         TARGETS:  k(t)    ~(j(t))  
         NEW GOAL for B:  ~(k(t))
         B is ESTABLISHING ~(k(t)) for viability
         B has an argument for ~(k(t))
            A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(k(t))
            TARGETS:  l(t)    ~(k(t))  
            NEW GOAL for A:  ~(l(t))
            A is ESTABLISHING ~(l(t)) for support
            A has an argument for ~(l(t))
               B is CHECKING SUBARGUMENTS to block A's establishment of ~(l(t))
               TARGETS:  ~(l(t))  
               B ALLOWS A's subarguments for ~(l(t))
               B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(l(t))
               B has an argument for l(t)
                  A is CHECKING SUBARGUMENTS to defeat B's establishment of l(t)
                  TARGETS:  l(t)  
                  A ALLOWS B's subarguments for l(t)
            
************ round 1 ************
            A's ARGUMENT:  (1)            B's ARGUMENT:  (0)            
            A ACTIVATOR: (e(t) ^ m(t))
            B ACTIVATOR: e(t)
            A's ARGUMENT IS MORE SPECIFIC
            B seeks another argument against ~(l(t))
            no more arguments for B
            A ESTABLISHED ~(l(t)) for support
            A DISALLOWS B's subarguments for ~(k(t))
         B seeks another argument for ~(k(t))
         no more arguments for B
         B FAILED TO ESTABLISH ~(k(t)) for viability
         NEW GOAL for B:  j(t)
         j(t) already pending: B backtracks
         B ALLOWS A's subarguments for ~(j(t))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(j(t))
         B has an argument for j(t)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of j(t)
            TARGETS:  j(t)  
            A ALLOWS B's subarguments for j(t)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: (c(t) ^ k(t))
      B ACTIVATOR: c(t)
      A's ARGUMENT IS MORE SPECIFIC
      B seeks another argument against ~(j(t))
      no more arguments for B
      A ESTABLISHED ~(j(t)) for support
      A DISALLOWS B's subarguments for ~(i(t))
   B seeks another argument for ~(i(t))
   no more arguments for B
   B FAILED TO ESTABLISH ~(i(t)) for viability
   NEW GOAL for B:  ~(h(t))
   ~(h(t)) already pending: B backtracks
   B ALLOWS A's subarguments for h(t)
A WINS h(t)
1
0.566644 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
R x b(x) >- h(x).
R x c(x) >- ~b(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  b(t)    h(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has no argument for ~(b(t))
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(h(t))
   ~(h(t)) already pending: B backtracks
   B ALLOWS A's subarguments for h(t)
A WINS h(t)
1
0.083330 seconds
__________________________________________________________________________
INPUT:
a(t,r)!
R x,y a(x,y) >- b(x,y).
R x,y b(x,y) >- h(x,y).
R x,y c(x,y) >- ~b(x,y).
h(t,r)?
DISPUTING h(t,r)

A tries to support:  h(t,r)

A has an argument for h(t,r)
B has no argument for ~(h(t,r))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t,r)
   TARGETS:  b(t,r)    h(t,r)  
   NEW GOAL for B:  ~(b(t,r))
   B is ESTABLISHING ~(b(t,r)) for viability
   B has no argument for ~(b(t,r))
   B FAILED TO ESTABLISH ~(b(t,r)) for viability
   NEW GOAL for B:  ~(h(t,r))
   ~(h(t,r)) already pending: B backtracks
   B ALLOWS A's subarguments for h(t,r)
A WINS h(t,r)
1
0.099996 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
R x b(x) >- h(x).
R x c(x) >- ~b(x).
~b(t)?
DISPUTING ~(b(t))

A tries to support:  ~(b(t))

A has no argument for ~(b(t))
B has an argument for b(t)
A exhausts arguments for: ~(b(t))

B tries to support: b(t)

   A is CHECKING SUBARGUMENTS to block B's establishment of b(t)
   TARGETS:  b(t)  
   A ALLOWS B's subarguments for b(t)
B WINS b(t)
-1
0.033332 seconds
__________________________________________________________________________
INPUT:
a(t)!
c(t)!
R x a(x) >- b(x).
R x b(x) >- h(x).
R x c(x) >- ~b(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  b(t)    h(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has an argument for ~(b(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(b(t))
      TARGETS:  ~(b(t))  
      A ALLOWS B's subarguments for ~(b(t))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(b(t))
      A has an argument for b(t)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of b(t)
         TARGETS:  b(t)  
         B ALLOWS A's subarguments for b(t)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: c(t)
   A ACTIVATOR: a(t)
   INCONCLUSIVE
   A seeks another argument against ~(b(t))
   no more arguments for A
   B ESTABLISHED ~(b(t)) for viability
   B DISALLOWS A's subarguments for h(t)
no more arguments for A
A exhausts arguments for: h(t)

B tries to support: ~(h(t))

NO WINNER FOR h(t)
0
0.099996 seconds
__________________________________________________________________________
INPUT:
a(t)!
c(t)!
d(t)!
R x a(x) >- b(x).
R x b(x) >- h(x).
R x c(x) >- e(x).
R x e(x) >- ~b(x).
R x d(x) >- ~e(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  b(t)    h(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has an argument for ~(b(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(b(t))
      TARGETS:  e(t)    ~(b(t))  
      NEW GOAL for A:  ~(e(t))
      A is ESTABLISHING ~(e(t)) for support
      A has an argument for ~(e(t))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(e(t))
         TARGETS:  ~(e(t))  
         B ALLOWS A's subarguments for ~(e(t))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(e(t))
         B has an argument for e(t)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of e(t)
            TARGETS:  e(t)  
            A ALLOWS B's subarguments for e(t)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: d(t)
      B ACTIVATOR: c(t)
      INCONCLUSIVE
      A seeks another argument for ~(e(t))
      no more arguments for A
      A FAILED TO ESTABLISH ~(e(t)) for support
      NEW GOAL for A:  b(t)
      b(t) already pending: A backtracks
      A ALLOWS B's subarguments for ~(b(t))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(b(t))
      A has an argument for b(t)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of b(t)
         TARGETS:  b(t)  
         B ALLOWS A's subarguments for b(t)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: e(t)
   A ACTIVATOR: a(t)
   INCONCLUSIVE
   A seeks another argument against ~(b(t))
   no more arguments for A
   B ESTABLISHED ~(b(t)) for viability
   B DISALLOWS A's subarguments for h(t)
no more arguments for A
A exhausts arguments for: h(t)

B tries to support: ~(h(t))

NO WINNER FOR h(t)
0
0.216658 seconds
__________________________________________________________________________
INPUT:
a(t)!
c(t)!
d(t)!
R x a(x) >- b(x).
R x b(x) >- h(x).
R x c(x) >- e(x).
R x e(x) >- ~b(x).
R x d(x) ^ c(x) >- ~e(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  b(t)    h(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has an argument for ~(b(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(b(t))
      TARGETS:  e(t)    ~(b(t))  
      NEW GOAL for A:  ~(e(t))
      A is ESTABLISHING ~(e(t)) for support
      A has an argument for ~(e(t))
         B is CHECKING SUBARGUMENTS to block A's establishment of ~(e(t))
         TARGETS:  ~(e(t))  
         B ALLOWS A's subarguments for ~(e(t))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to ~(e(t))
         B has an argument for e(t)
            A is CHECKING SUBARGUMENTS to defeat B's establishment of e(t)
            TARGETS:  e(t)  
            A ALLOWS B's subarguments for e(t)
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: (d(t) ^ c(t))
      B ACTIVATOR: c(t)
      A's ARGUMENT IS MORE SPECIFIC
      B seeks another argument against ~(e(t))
      no more arguments for B
      A ESTABLISHED ~(e(t)) for support
      A DISALLOWS B's subarguments for ~(b(t))
   B seeks another argument for ~(b(t))
   no more arguments for B
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(h(t))
   ~(h(t)) already pending: B backtracks
   B ALLOWS A's subarguments for h(t)
A WINS h(t)
1
0.166660 seconds
__________________________________________________________________________
INPUT:
alive(fred,0)!
alive(wilma,0)!
alive(betty,0)!
alive(barney,0)!
alive(pebbles,0)!
alive(bambam,0)!
R p,t alive(p,t) >- alive(p, s(t)).
R p,t ~alive(p,t) >- ~alive(p, s(t)).
R g,t loaded(g,t) >- loaded(g, s(t)).
loaded(gun(barney), s(0))!
fired-at(gun(barney),fred,s(s(s(0))))!
R p,g,t alive(p,t) ^ fired-at(g,p,t) ^ loaded(g,t) >- ~alive(p, s(t)).
A t alive(fred,t) => says(fred,yabba(dabba(doo)),s(t)).
alive(fred,s(s(s(s(0)))))?
DISPUTING alive(fred,s(s(s(s(0)))))

A tries to support:  alive(fred,s(s(s(s(0)))))

A has an argument for alive(fred,s(s(s(s(0)))))
B has an argument for ~(alive(fred,s(s(s(s(0))))))
   B is CHECKING SUBARGUMENTS to block A's establishment of alive(fred,s(s(s(s(0)))))
   TARGETS:  alive(fred,s(0))    alive(fred,s(s(0)))    alive(fred,s(s(s(0))))    alive(fred,s(s(s(s(0)))))  
   NEW GOAL for B:  ~(alive(fred,s(0)))
   B is ESTABLISHING ~(alive(fred,s(0))) for viability
   B has no argument for ~(alive(fred,s(0)))
   B FAILED TO ESTABLISH ~(alive(fred,s(0))) for viability
   NEW GOAL for B:  ~(alive(fred,s(s(0))))
   B is ESTABLISHING ~(alive(fred,s(s(0)))) for viability
   B has no argument for ~(alive(fred,s(s(0))))
   B FAILED TO ESTABLISH ~(alive(fred,s(s(0)))) for viability
   NEW GOAL for B:  ~(alive(fred,s(s(s(0)))))
   B is ESTABLISHING ~(alive(fred,s(s(s(0))))) for viability
   B has no argument for ~(alive(fred,s(s(s(0)))))
   B FAILED TO ESTABLISH ~(alive(fred,s(s(s(0))))) for viability
   NEW GOAL for B:  ~(alive(fred,s(s(s(s(0))))))
   ~(alive(fred,s(s(s(s(0)))))) already pending: B backtracks
   B ALLOWS A's subarguments for alive(fred,s(s(s(s(0)))))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(alive(fred,s(s(s(s(0))))))
      TARGETS:  alive(fred,s(0))    alive(fred,s(s(0)))    alive(fred,s(s(s(0))))    loaded(gun(barney),s(s(0)))    loaded(gun(barney),s(s(s(0))))    ~(alive(fred,s(s(s(s(0))))))  
      NEW GOAL for A:  ~(alive(fred,s(0)))
      A is ESTABLISHING ~(alive(fred,s(0))) for support
      A has no argument for ~(alive(fred,s(0)))
      A FAILED TO ESTABLISH ~(alive(fred,s(0))) for support
      NEW GOAL for A:  ~(alive(fred,s(s(0))))
      A is ESTABLISHING ~(alive(fred,s(s(0)))) for support
      A has no argument for ~(alive(fred,s(s(0))))
      A FAILED TO ESTABLISH ~(alive(fred,s(s(0)))) for support
      NEW GOAL for A:  ~(alive(fred,s(s(s(0)))))
      A is ESTABLISHING ~(alive(fred,s(s(s(0))))) for support
      A has no argument for ~(alive(fred,s(s(s(0)))))
      A FAILED TO ESTABLISH ~(alive(fred,s(s(s(0))))) for support
      NEW GOAL for A:  ~(loaded(gun(barney),s(s(0))))
      A is ESTABLISHING ~(loaded(gun(barney),s(s(0)))) for support
      A has no argument for ~(loaded(gun(barney),s(s(0))))
      A FAILED TO ESTABLISH ~(loaded(gun(barney),s(s(0)))) for support
      NEW GOAL for A:  ~(loaded(gun(barney),s(s(s(0)))))
      A is ESTABLISHING ~(loaded(gun(barney),s(s(s(0))))) for support
      A has no argument for ~(loaded(gun(barney),s(s(s(0)))))
      A FAILED TO ESTABLISH ~(loaded(gun(barney),s(s(s(0))))) for support
      NEW GOAL for A:  alive(fred,s(s(s(s(0)))))
      alive(fred,s(s(s(s(0))))) already pending: A backtracks
      A ALLOWS B's subarguments for ~(alive(fred,s(s(s(s(0))))))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: alive(fred,s(s(s(0))))
B ACTIVATOR: (alive(fred,s(s(s(0)))) ^ (fired-at(?x1,fred,s(s(s(0)))) ^ loaded(?x1,s(s(s(0))))))
B's ARGUMENT IS MORE SPECIFIC
no more arguments for A
A exhausts arguments for: alive(fred,s(s(s(s(0)))))

B tries to support: ~(alive(fred,s(s(s(s(0))))))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(alive(fred,s(s(s(s(0))))))
   TARGETS:  alive(fred,s(0))    alive(fred,s(s(0)))    alive(fred,s(s(s(0))))    loaded(gun(barney),s(s(0)))    loaded(gun(barney),s(s(s(0))))    ~(alive(fred,s(s(s(s(0))))))  
   NEW GOAL for A:  ~(alive(fred,s(0)))
   A is ESTABLISHING ~(alive(fred,s(0))) for viability
   A has no argument for ~(alive(fred,s(0)))
   A FAILED TO ESTABLISH ~(alive(fred,s(0))) for viability
   NEW GOAL for A:  ~(alive(fred,s(s(0))))
   A is ESTABLISHING ~(alive(fred,s(s(0)))) for viability
   A has no argument for ~(alive(fred,s(s(0))))
   A FAILED TO ESTABLISH ~(alive(fred,s(s(0)))) for viability
   NEW GOAL for A:  ~(alive(fred,s(s(s(0)))))
   A is ESTABLISHING ~(alive(fred,s(s(s(0))))) for viability
   A has no argument for ~(alive(fred,s(s(s(0)))))
   A FAILED TO ESTABLISH ~(alive(fred,s(s(s(0))))) for viability
   NEW GOAL for A:  ~(loaded(gun(barney),s(s(0))))
   A is ESTABLISHING ~(loaded(gun(barney),s(s(0)))) for viability
   A has no argument for ~(loaded(gun(barney),s(s(0))))
   A FAILED TO ESTABLISH ~(loaded(gun(barney),s(s(0)))) for viability
   NEW GOAL for A:  ~(loaded(gun(barney),s(s(s(0)))))
   A is ESTABLISHING ~(loaded(gun(barney),s(s(s(0))))) for viability
   A has no argument for ~(loaded(gun(barney),s(s(s(0)))))
   A FAILED TO ESTABLISH ~(loaded(gun(barney),s(s(s(0))))) for viability
   NEW GOAL for A:  alive(fred,s(s(s(s(0)))))
   alive(fred,s(s(s(s(0))))) already pending: A backtracks
   A ALLOWS B's subarguments for ~(alive(fred,s(s(s(s(0))))))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of alive(fred,s(s(s(s(0)))))
      TARGETS:  alive(fred,s(0))    alive(fred,s(s(0)))    alive(fred,s(s(s(0))))    alive(fred,s(s(s(s(0)))))  
      NEW GOAL for B:  ~(alive(fred,s(0)))
      B is ESTABLISHING ~(alive(fred,s(0))) for support
      B has no argument for ~(alive(fred,s(0)))
      B FAILED TO ESTABLISH ~(alive(fred,s(0))) for support
      NEW GOAL for B:  ~(alive(fred,s(s(0))))
      B is ESTABLISHING ~(alive(fred,s(s(0)))) for support
      B has no argument for ~(alive(fred,s(s(0))))
      B FAILED TO ESTABLISH ~(alive(fred,s(s(0)))) for support
      NEW GOAL for B:  ~(alive(fred,s(s(s(0)))))
      B is ESTABLISHING ~(alive(fred,s(s(s(0))))) for support
      B has no argument for ~(alive(fred,s(s(s(0)))))
      B FAILED TO ESTABLISH ~(alive(fred,s(s(s(0))))) for support
      NEW GOAL for B:  ~(alive(fred,s(s(s(s(0))))))
      ~(alive(fred,s(s(s(s(0)))))) already pending: B backtracks
      B ALLOWS A's subarguments for alive(fred,s(s(s(s(0)))))

************ round 2 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)already argued; B won
no more arguments for A
B WINS ~(alive(fred,s(s(s(s(0))))))
-1
14.199432 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
A x (b(x) <=> c(x)).
R x c(x) >- ~b(x).
b(t)?
DISPUTING b(t)

A tries to support:  b(t)

A has an argument for b(t)
B has an argument for ~(b(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of b(t)
   TARGETS:  b(t)  
   B ALLOWS A's subarguments for b(t)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(b(t))
      TARGETS:  b(t)    ~(b(t))  
      NEW GOAL for A:  ~(b(t))
      ~(b(t)) already pending: A backtracks
      NEW GOAL for A:  b(t)
      b(t) already pending: A backtracks
      A ALLOWS B's subarguments for ~(b(t))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: a(t)
B ACTIVATOR: c(t)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: b(t)

B tries to support: ~(b(t))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(b(t))
   TARGETS:  b(t)    ~(b(t))  
   NEW GOAL for A:  ~(b(t))
   ~(b(t)) already pending: A backtracks
   NEW GOAL for A:  b(t)
   b(t) already pending: A backtracks
   A ALLOWS B's subarguments for ~(b(t))
already countered  (argument -1)
no more arguments for B
NO WINNER FOR b(t)
0
0.166660 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
R x b(x) >- c(x).
R x c(x) >- ~b(x).
R x ~b(x) >- h(x).
h(t)?
DISPUTING h(t)

A tries to support:  h(t)

A has an argument for h(t)
B has no argument for ~(h(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of h(t)
   TARGETS:  b(t)    c(t)    ~(b(t))    h(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has an argument for ~(b(t))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(b(t))
      TARGETS:  b(t)    c(t)    ~(b(t))  
      NEW GOAL for A:  ~(b(t))
      ~(b(t)) already pending: A backtracks
      NEW GOAL for A:  ~(c(t))
      A is ESTABLISHING ~(c(t)) for support
      A has no argument for ~(c(t))
      A FAILED TO ESTABLISH ~(c(t)) for support
      NEW GOAL for A:  b(t)
      b(t) already pending: A backtracks
      A ALLOWS B's subarguments for ~(b(t))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to ~(b(t))
      A has an argument for b(t)
         B is CHECKING SUBARGUMENTS to defeat A's establishment of b(t)
         TARGETS:  b(t)  
         B ALLOWS A's subarguments for b(t)
   
************ round 1 ************
   B's ARGUMENT:  (1)   A's ARGUMENT:  (0)   
   B ACTIVATOR: c(t)
   A ACTIVATOR: a(t)
   A's ARGUMENT IS MORE SPECIFIC
   B seeks another argument for ~(b(t))
   no more arguments for B
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(c(t))
   B is ESTABLISHING ~(c(t)) for viability
   B has no argument for ~(c(t))
   B FAILED TO ESTABLISH ~(c(t)) for viability
   NEW GOAL for B:  b(t)
   B is ESTABLISHING b(t) for viability
   B has an argument for b(t)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of b(t)
      TARGETS:  b(t)  
      A ALLOWS B's subarguments for b(t)
      A CHECKING FOR TOP-LEVEL COUNTERARGS to b(t)
      already pending:  A backtracks
   B ESTABLISHED b(t) for viability
   B DISALLOWS A's subarguments for h(t)
no more arguments for A
A exhausts arguments for: h(t)

B tries to support: ~(h(t))

NO WINNER FOR h(t)
0
0.283322 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
R x b(x) >- c(x).
A x (c(x) => d(x)).
d(t)?
DISPUTING d(t)

A tries to support:  d(t)

A has an argument for d(t)
B has no argument for ~(d(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of d(t)
   TARGETS:  b(t)    c(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has no argument for ~(b(t))
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(c(t))
   B is ESTABLISHING ~(c(t)) for viability
   B has no argument for ~(c(t))
   B FAILED TO ESTABLISH ~(c(t)) for viability
   B ALLOWS A's subarguments for d(t)
A WINS d(t)
1
0.066664 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
A x (b(x) => c(x)).
R x c(x) >- d(x).
d(t)?
DISPUTING d(t)

A tries to support:  d(t)

A has an argument for d(t)
B has no argument for ~(d(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of d(t)
   TARGETS:  b(t)    d(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has no argument for ~(b(t))
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(d(t))
   ~(d(t)) already pending: B backtracks
   B ALLOWS A's subarguments for d(t)
A WINS d(t)
1
0.083330 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
A x (b(x) <=> c(x)).
R x c(x) >- d(x).
d(t)?
DISPUTING d(t)

A tries to support:  d(t)

A has an argument for d(t)
B has no argument for ~(d(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of d(t)
   TARGETS:  b(t)    d(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has no argument for ~(b(t))
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(d(t))
   ~(d(t)) already pending: B backtracks
   B ALLOWS A's subarguments for d(t)
A WINS d(t)
1
0.083330 seconds
__________________________________________________________________________
INPUT:
a(t)!
R x a(x) >- b(x).
A x (c(x) <=> b(x)).
R x c(x) >- d(x).
d(t)?
DISPUTING d(t)

A tries to support:  d(t)

A has an argument for d(t)
B has no argument for ~(d(t))
   B is CHECKING SUBARGUMENTS to block A's establishment of d(t)
   TARGETS:  b(t)    d(t)  
   NEW GOAL for B:  ~(b(t))
   B is ESTABLISHING ~(b(t)) for viability
   B has no argument for ~(b(t))
   B FAILED TO ESTABLISH ~(b(t)) for viability
   NEW GOAL for B:  ~(d(t))
   ~(d(t)) already pending: B backtracks
   B ALLOWS A's subarguments for d(t)
A WINS d(t)
1
0.083330 seconds
__________________________________________________________________________
INPUT:

penguin(opus)!
adult(opus)!
onplane(opus)!
A x (penguin(x) => bird(x)).
R x bird(x) ^ adult(x) >- flies(x).
R x penguin(x) >- ~flies(x).
R x onplane(x) >- flies(x).
flies(opus)?
DISPUTING flies(opus)

A tries to support:  flies(opus)

A has an argument for flies(opus)
B has an argument for ~(flies(opus))
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  flies(opus)  
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  ~(flies(opus))  
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 1 ************
A's ARGUMENT:  (1)B's ARGUMENT:  (-1)
A ACTIVATOR: onplane(opus)
B ACTIVATOR: penguin(opus)
INCONCLUSIVE
trying next A argument
   B is CHECKING SUBARGUMENTS to block A's establishment of flies(opus)
   TARGETS:  flies(opus)  
   B ALLOWS A's subarguments for flies(opus)
      A is CHECKING SUBARGUMENTS to defeat B's establishment of ~(flies(opus))
      TARGETS:  ~(flies(opus))  
      A ALLOWS B's subarguments for ~(flies(opus))

************ round 2 ************
A's ARGUMENT:  (2)B's ARGUMENT:  (-1)
A ACTIVATOR: (bird(opus) ^ adult(opus))
B ACTIVATOR: penguin(opus)
INCONCLUSIVE
no more arguments for A
A exhausts arguments for: flies(opus)

B tries to support: ~(flies(opus))

   A is CHECKING SUBARGUMENTS to block B's establishment of ~(flies(opus))
   TARGETS:  ~(flies(opus))  
   A ALLOWS B's subarguments for ~(flies(opus))
already countered  (argument -1)
no more arguments for B
NO WINNER FOR flies(opus)
0
0.116662 seconds
__________________________________________________________________________
INPUT:
(E x f(x)) => d.
R x g(x) >- f(x).
a => (A x g(x)).
~a => g(b).
d?
DISPUTING d

A tries to support:  d

A has an argument for d
B has no argument for ~(d)
   B is CHECKING SUBARGUMENTS to block A's establishment of d
   TARGETS:  f(?x1)    f(???x1)  
   NEW GOAL for B:  Exists ?x1 (~(f(?x1)))
   B is ESTABLISHING Exists ?x1 (~(f(?x1))) for viability
   B has no argument for Exists ?x1 (~(f(?x1)))
   B FAILED TO ESTABLISH Exists ?x1 (~(f(?x1))) for viability
   NEW GOAL for B:  Exists ???x1 (~(f(???x1)))
   B is ESTABLISHING Exists ???x1 (~(f(???x1))) for viability
   B has no argument for Exists ???x1 (~(f(???x1)))
   B FAILED TO ESTABLISH Exists ???x1 (~(f(???x1))) for viability
   B ALLOWS A's subarguments for d
A WINS d
1
0.066664 seconds
__________________________________________________________________________
INPUT:
junk!
R x,y h(x,y) >- i(x,y).
A y (h(m,y))!
R , junk >- ~(E x (i(x,t))).
E x (i(x,t))?
DISPUTING Exists x (i(x,t))

A tries to support:  Exists x (i(x,t))

A has an argument for Exists x (i(x,t))
B has an argument for All x (~(i(x,t)))
   B is CHECKING SUBARGUMENTS to block A's establishment of Exists x (i(x,t))
   TARGETS:  i(?x1,t)  
   NEW GOAL for B:  Exists ?x1 (~(i(?x1,t)))
   B is ESTABLISHING Exists ?x1 (~(i(?x1,t))) for viability
   B has an argument for Exists ?x1 (~(i(?x1,t)))
      A is CHECKING SUBARGUMENTS to defeat B's establishment of Exists ?x1 (~(i(?x1,t)))
      TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
      NEW GOAL for A:  Exists ???x1 (i(???x1,t))
      A is ESTABLISHING Exists ???x1 (i(???x1,t)) for support
      A has an argument for Exists ???x1 (i(???x1,t))
         B is CHECKING SUBARGUMENTS to block A's establishment of Exists ???x1 (i(???x1,t))
         TARGETS:  i(?x1,t)  
         NEW GOAL for B:  Exists ?x1 (~(i(?x1,t)))
         Exists ?x1 (~(i(?x1,t))) already pending: B backtracks
         B ALLOWS A's subarguments for Exists ???x1 (i(???x1,t))
         B CHECKING FOR TOP-LEVEL COUNTERARGS to Exists ???x1 (i(???x1,t))
         B has an argument for All ???x1 (~(i(???x1,t)))
            A is CHECKING SUBARGUMENTS to defeat B's establishment of All ???x1 (~(i(???x1,t)))
            TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
            A ALLOWS B's subarguments for All ???x1 (~(i(???x1,t)))
      
************ round 1 ************
      A's ARGUMENT:  (1)      B's ARGUMENT:  (0)      
      A ACTIVATOR: h(?x1,t)
      B ACTIVATOR: junk
      INCONCLUSIVE
      A seeks another argument for Exists ???x1 (i(???x1,t))
      no more arguments for A
      A FAILED TO ESTABLISH Exists ???x1 (i(???x1,t)) for support
      A ALLOWS B's subarguments for Exists ?x1 (~(i(?x1,t)))
      A CHECKING FOR TOP-LEVEL COUNTERARGS to Exists ?x1 (~(i(?x1,t)))
      A has no argument for All ?x1 (i(?x1,t))
   B ESTABLISHED Exists ?x1 (~(i(?x1,t))) for viability
   B DISALLOWS A's subarguments for Exists x (i(x,t))
no more arguments for A
A exhausts arguments for: Exists x (i(x,t))

B tries to support: All x (~(i(x,t)))

   A is CHECKING SUBARGUMENTS to block B's establishment of All x (~(i(x,t)))
   TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
   NEW GOAL for A:  Exists ???x1 (i(???x1,t))
   A is ESTABLISHING Exists ???x1 (i(???x1,t)) for viability
   A has an argument for Exists ???x1 (i(???x1,t))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of Exists ???x1 (i(???x1,t))
      TARGETS:  i(?x1,t)  
      NEW GOAL for B:  Exists ?x1 (~(i(?x1,t)))
      B is ESTABLISHING Exists ?x1 (~(i(?x1,t))) for support
      B has an argument for Exists ?x1 (~(i(?x1,t)))
         A is CHECKING SUBARGUMENTS to block B's establishment of Exists ?x1 (~(i(?x1,t)))
         TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
         NEW GOAL for A:  Exists ???x1 (i(???x1,t))
         Exists ???x1 (i(???x1,t)) already pending: A backtracks
         A ALLOWS B's subarguments for Exists ?x1 (~(i(?x1,t)))
         A CHECKING FOR TOP-LEVEL COUNTERARGS to Exists ?x1 (~(i(?x1,t)))
         A has no argument for All ?x1 (i(?x1,t))
      B ESTABLISHED Exists ?x1 (~(i(?x1,t))) for support
      B DISALLOWS A's subarguments for Exists ???x1 (i(???x1,t))
   A seeks another argument for Exists ???x1 (i(???x1,t))
   no more arguments for A
   A FAILED TO ESTABLISH Exists ???x1 (i(???x1,t)) for viability
   A ALLOWS B's subarguments for All x (~(i(x,t)))
      B is CHECKING SUBARGUMENTS to defeat A's establishment of Exists x (i(x,t))
      TARGETS:  i(?x1,t)  
      NEW GOAL for B:  Exists ?x1 (~(i(?x1,t)))
      B is ESTABLISHING Exists ?x1 (~(i(?x1,t))) for support
      B has an argument for Exists ?x1 (~(i(?x1,t)))
         A is CHECKING SUBARGUMENTS to block B's establishment of Exists ?x1 (~(i(?x1,t)))
         TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
         NEW GOAL for A:  Exists ???x1 (i(???x1,t))
         A is ESTABLISHING Exists ???x1 (i(???x1,t)) for viability
         A has an argument for Exists ???x1 (i(???x1,t))
            B is CHECKING SUBARGUMENTS to defeat A's establishment of Exists ???x1 (i(???x1,t))
            TARGETS:  i(?x1,t)  
            NEW GOAL for B:  Exists ?x1 (~(i(?x1,t)))
            Exists ?x1 (~(i(?x1,t))) already pending: B backtracks
            B ALLOWS A's subarguments for Exists ???x1 (i(???x1,t))
            B CHECKING FOR TOP-LEVEL COUNTERARGS to Exists ???x1 (i(???x1,t))
            B has an argument for All ???x1 (~(i(???x1,t)))
               A is CHECKING SUBARGUMENTS to defeat B's establishment of All ???x1 (~(i(???x1,t)))
               TARGETS:  ~(Exists ???x1 (i(???x1,t)))  
               A ALLOWS B's subarguments for All ???x1 (~(i(???x1,t)))
         
************ round 1 ************
         A's ARGUMENT:  (1)         B's ARGUMENT:  (0)         
         A ACTIVATOR: h(?x1,t)
         B ACTIVATOR: junk
         INCONCLUSIVE
         B seeks another argument against Exists ???x1 (i(???x1,t))
         no more arguments for B
         A ESTABLISHED Exists ???x1 (i(???x1,t)) for viability
         A DISALLOWS B's subarguments for Exists ?x1 (~(i(?x1,t)))
      B seeks another argument for Exists ?x1 (~(i(?x1,t)))
      no more arguments for B
      B FAILED TO ESTABLISH Exists ?x1 (~(i(?x1,t))) for support
      B ALLOWS A's subarguments for Exists x (i(x,t))

************ round 1 ************
B's ARGUMENT:  (1)A's ARGUMENT:  (-1)
B ACTIVATOR: h(?x1,t)
A ACTIVATOR: junk
INCONCLUSIVE
no more arguments for B
B exhausts arguments for: All x (~(i(x,t)))
NO WINNER FOR Exists x (i(x,t))
0
0.299988 seconds
*/
/*
pre.p:

while (<>) { 
	if (/\#/) { ;}
	elsif (/MUTEX:/) {
	  s/	/ /g; s/  / /g;
	  chop; while (/ $/) {chop;}
	  if (/\.$/) { chop; } else {
	    $hold = $_;
	    while (<>) {
	      s/	/ /g; s/  / /g;
	      chop; while (/ $/) {chop;}
	      $_ = $hold . $_;
	      if (/\.$/) { chop; last; }
	      $hold = $_;
	    }
	  }

	  ($trash, $rem) = split(/MUTEX:/, $_);
	  $rem =~ s/^ //;
	  @pieces = split(/ /, $rem);
	  $rem =~ s/ / v /g; print "$rem.\n";
	  for $x (0..$#pieces) {
	    for $y (0..$#pieces) {
	      if ($x ne $y) {
		print "$pieces[$x] -> ~$pieces[$y].\n";
	      }
	    }
	  }
	}
	elsif (/CASE:/) {
	  s/	/ /g; s/  / /g;
	  chop; while (/ $/) {chop;}
	  if (/\.$/) { chop; } else {
	    $hold = $_;
	    while (<>) {
	      s/	/ /g; s/  / /g;
	      chop; while (/ $/) {chop;}
	      $_ = $hold . $_;
	      if (/\.$/) { chop; last; }
	      $hold = $_;
	    }
	  }

	  ($trash, $rem) = split(/CASE:/, $_);
	  ($trash, $rem) = split(/MIN:/, $rem);
	  $_ = $rem;
	  if (!/OPT:/) {
	    ($min, $decision) = split(/DECISION:/, $rem);
	    $nless1 = 0;
	    $expn = 0;
	  } 
	  else {
	    ($min, $rem) = split(/OPT:/, $rem);
	    ($opt, $decision) = split(/DECISION:/, $rem);
	    @opts = split(/\^/, $opt);
	    $nless1 = $#opts+1;
	    $expn = 2**$nless1;
	  }
	  for $x (0..$expn) {
	    printf("R x$min");
	    for $i (0..$nless1) {
	      if ($x != $expn) { if (2**$i & $x) {printf("^ $opts[$i]")} }
	    }
	    printf(">- $decision.\n")
	  }
	}
	else {print;}
}
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int SLIMIT=1000;
int ALIMIT=10000;
int ABONUS=10;
int LITLIMIT=20;

#define FALSE 0
#define TRUE 1

#define D 1

#define dbug 1

typedef int pint;
/* pint should be an integral type wide enough to hold a pointer */

typedef struct w {
  char fa;
  void *fb;
  struct w *fc;
} wff;

#define kindof(x)  (((wff *) (x))->fa)
#define ante(x)    (((wff *) (x))->fb)
#define succ(x)    (((wff *) (x))->fc)
#define wffname(x) (((wff *) (x))->fb)

typedef char wffkind;

#define NULLkind   0
#define ANDkind    1
#define ORkind     2
#define FORALLkind 3
#define EXISTSkind 4
#define NOTkind    5
#define FUNCTkind  6
#define ARGkind    7

#define binary(x)  (kindof(x) == ANDkind || kindof(x) == ORkind)
/* warning: binary(x) evaluates x twice */

wffkind dual[] = {0,2,1,4,3,5,6,7};

/**** the following declarations were added by ASM ****/

int seeinput=1;
int PRINTEV=0;
int PRINTARGS=0;	/* 1 if generated arguments should be output */
int PRINTTOP=0;		/* 1 if search for top rules should be output */
int PRINTTGTS=1;	/* 1 if counterarg points should be output */
int PRINTPROG=1;	/* 1 if progress reports should be output */
int PRINTTIME=1;	/* 1 if time should be output */
int PRINTSUPPORTED=0;	/* 1 if supported facts output */ /* RPL */
int PRINTVIABLES=0;	/* 1 if viable facts output */ /* RPL */
int PRINTRESULT=1;	/* 1 if result output */ /* RPL */
int PRINTSEARCH=0;	
int PRINTCLAUSES=0;	
int ALLOWCASES=1;       /* 1 if arguments using cases should be allowed */

typedef struct wr {
  wff *ga, *gb, *gc;
  wff *gd, *ge;
  char gf, gg, gh;
  struct wr *gi;
} wffrule;

#define wffrulevar(x)	    (((wffrule *) (x))->ga)
#define wffruleant(x)	    (((wffrule *) (x))->gb)
#define wffrulecon(x)	    (((wffrule *) (x))->gc)
#define wffruleantname(x)   (((wffrule *) (x))->gd)
#define wffruleconname(x)   (((wffrule *) (x))->ge)
#define wffruleuse(x)	    (((wffrule *) (x))->gf)
#define wffruletop1(x)	    (((wffrule *) (x))->gg)
#define wffruletop2(x)	    (((wffrule *) (x))->gh)
#define nextwffrule(x)	    (((wffrule *) (x))->gi)

typedef struct wl {
  wff *faa, *fab;
  char fbb;
  wffrule *fcc;
  struct wl *fdd;
} wfflist;

#define thewff(x)  (((wfflist *) (x))->faa)
#define cwff(x)  (((wfflist *) (x))->fab)
#define wffflag(x) (((wfflist *) (x))->fbb)
#define wfflistrule(x) (((wfflist *) (x))->fcc)
#define nextwff(x) (((wfflist *) (x))->fdd)

#define NECEVflag 0	/* used for the wffflag field, to record type of */
#define CONTEVflag 1	/* knowledge, if appropriate */

typedef struct wp {
  wffrule *ha;
  wfflist *hb;
  wff *hc, *hd;
} wffpack;

#define wffrules(x)  (((wffpack *) (x))->ha)
#define wffknow(x)   (((wffpack *) (x))->hb)
#define wffactivator(x)  (((wffpack *) (x))->hc)
#define wffgoal(x)  (((wffpack *) (x))->hd)

#define printknow(n,s,c,subs) printclause(1,n,s,c,subs,1)

void printclause();
void printwff();	/* declared here so it can be called from anywhere */
void print_subs();
void printlits();  
void printclauselist();
void printterms();
void printterms_r();
char *makename();

/**** end of ASM declarations ****/

/**** begin RPL declarations ****/

typedef struct tl {
  wff *faa;
  struct tl *fbb;
} targetlist;

targetlist *ppending = NULL, *plastpend = NULL;

#define targetwff(x)  (((targetlist *) (x))->faa)
#define nexttarget(x) (((targetlist *) (x))->fbb)

/**** end RPL declarations ****/

typedef struct t {
  void *ea;
  struct t *eb;
  void *ec;
} term;

#define termname(x) (((term *) (x))->ea)
#define tlits(x)    (((term *) (x))->ea)
#define nextterm(x) (((term *) (x))->eb)
#define tterms(x)   (((term *) (x))->ec)
#define lastname(x) (((term *) (x))->ec)

typedef struct l {
  char da, db, *dc;
  struct l *dd;
  term *de;
} lit;

#define polarity(x) (((lit *) (x))->da)
#define origin(x)   (((lit *) (x))->db)
#define litname(x)  (((lit *) (x))->dc)
#define nextlit(x)  (((lit *) (x))->dd)
#define lterms(x)   (((lit *) (x))->de)

#define FromNothing '\0'
#define FromDad     '\1' /* Note that there is a mom-bit and a dad-bit. */
#define FromMom     '\2' /* These values were meant to be combined with */
#define FromBoth    '\3' /* bit-wise OR (|) */

#define isfromdad(x) (origin(x) | FromDad)
#define isfrommom(x) (origin(x) | FromMom)

typedef struct c {
  struct c *ba, *bb, *bc;
  void *bd, *be;
  lit *bf;
  term *bg;
  wffrule *bh;
} clause;

typedef void *knowclass;

#define nextclause(x)   (((clause *) (x))->ba)
#define mother(x)       (((clause *) (x))->bb)
#define father(x)       (((clause *) (x))->bc)
#define head(x)         (((clause *) (x))->bd)
#define classof(x)      (((clause *) (x))->bd)
#define prevhm(x)       (((clause *) (x))->be)
#define nonunilit(x)    (((clause *) (x))->be)
#define lits(x)         (((clause *) (x))->bf)
#define substitution(x) (((clause *) (x))->bg)
#define clauserulewff(x) (((clause *) (x))->bh)	  /* ASM */

char ca,cb,cc,cd,ce,cf;

#define contev  ((void *) &ca)
#define necev   ((void *) &cb)
#define fakev   ((void *) &cc)
#define defrul  ((void *) &cd)
#define unifail ((void *) &ce)
#define truth   ((void *) &cf)

#define iscontev(x)    (classof(x) == contev)
#define isnecev(x)     (classof(x) == necev)
#define isfakev(x)     (classof(x) == fakev)
#define isdefrul(x)    (classof(x) == defrul)
#define isknowledge(x) (iscontev(x) | isnecev(x) | isfakev(x) | isdefrul(x))
#define succeeded(x)   ((void *) (x) != unifail)

typedef struct a {
  clause *aa, *ab, *ac, *ad, *ae, *af;
  struct a *ag, *ah;
  int ai, aj;
  char ak;
  term *al;
  char am;
  int an;
  struct a *ao;
  wff *ap;
  struct a *aq;
  wffrule *ar;
  wfflist *as;
} argheader;

#define knowledge(x)    (((argheader *) (x))->aa)
#define goals(x)        (((argheader *) (x))->ab)
#define lastm(x)        (((argheader *) (x))->ac)
#define lastf(x)        (((argheader *) (x))->ad)
#define lastg(x)        (((argheader *) (x))->ae)
#define nilclause(x)    (((argheader *) (x))->af)
#define left(x)         (((argheader *) (x))->ag)
#define right(x)        (((argheader *) (x))->ah)
#define attemptlimit(x) (((argheader *) (x))->ai)
#define successlimit(x) (((argheader *) (x))->aj)
#define unique(x)       (((argheader *) (x))->ak)
#define cutsets(x)      (((argheader *) (x))->al)
#define argstatus(x)    (((argheader *) (x))->am)     /* ASM */
#define argnumber(x)    (((argheader *) (x))->an)     /* ASM */
#define lastcheckedarg(x) (((argheader *) (x))->ao)   /* ASM */
#define argactivator(x) (((argheader *) (x))->ap)   /* ASM */
#define nextarg(x)      (((argheader *) (x))->aq)     /* ASM */
#define toprules(x)      (((argheader *) (x))->ar)     /* RPL */
#define thrulelist(x)      (((argheader *) (x))->as)     /* RPL */

#define DEFEATEDstatus   2  /* ASM */
#define INTERFEREDstatus 1  /* ASM */

#define xpro 0  /* RPL */
#define xcon 1  /* RPL */
#define negated 1  /* RPL */
#define unnegated 0  /* RPL */
#define vsDEFEATERS 1  /* RPL */
#define vsINTERFERERS 0  /* RPL */
#define usecontyes 1  /* RPL */
#define usecontno 0  /* RPL */
#define outputyes 1  /* RPL */
#define outputno 0  /* RPL */
#define for1yes 1  /* RPL */
#define for1no 0  /* RPL */
#define for2yes 1  /* RPL */
#define for2no 0  /* RPL */

typedef struct th {
  clause *ga, *gb, *gc;
  argheader *gd, *ge;
  int gf, gg;
} theoryheader;

#define rules(x)      (((theoryheader *) (x))->ga)
#define contingent(x) (((theoryheader *) (x))->gb)
#define otherev(x)    (((theoryheader *) (x))->gc)
#define generator(x)  (((theoryheader *) (x))->gd)
#define theories(x)   (((theoryheader *) (x))->ge)
#define arglimit(x)   (((theoryheader *) (x))->gf)
#define thlimit(x)    (((theoryheader *) (x))->gg)

int wffblock=144, clauseblock=144, litblock=144, termblock=144, charblock=987,
    arghblock=21, tlblock=21;
/* charblock must be init'ed to at least maxwordlen */
wff *availwff=NULL, *headwff=NULL, *lastwff=NULL;
clause *availclause=NULL;
lit *availlit=NULL;
term *availterm=NULL, *namelist=NULL, *varnamelist=NULL,
     **lastvartermp=&varnamelist, *nextvarterm=NULL;
argheader *availargh=NULL;
int nameroom=0;
char *nextname=NULL, *nameqname;  /* AMC */
targetlist *availtl=NULL;

wff *maingoal=NULL; /* RPL */
wff *notmaingoal=NULL; /* RPL */

int functnum=1, varnum=1;

#define maxwordlen 32
char letter,word[maxwordlen];

char *errmsg[] = {
  "ok",
  "name expected",
  "null sentences forbidden",
  "illegal symbol",
  "right parenthesis expected",
  "quantified functions forbidden",
  ">- expected",
  "period expected",
  "terminator ('?', '!', or '.') expected"
};

void err(n)  /* prints error message n to stdout and exits with result n */
int n;
{
  fflush(stdout);
  printf("\nerror: %s\n",errmsg[n]);
  exit(n);
}

#define nameexperr()       err(1)
#define nonullsenterr()    err(2)
#define illegalsymbolerr() err(3)
#define rparenexperr()     err(4)
#define quantfuncterr()    err(5)
#define suggexperr()       err(6)
#define periodexperr()     err(7)
#define qpbexperr()        err(8)

wff *newwff(k,a,s)  /* returns a new wff of kind k, with ante a and succ s */
wffkind k;
void *a;
wff *s;
{
  if (availwff == lastwff) {
    wff *temp=headwff;
    headwff = (wff *) malloc(wffblock * sizeof (wff));
    ante(headwff) = temp;
    lastwff = succ(headwff) = headwff+wffblock-1;
    availwff = headwff;
    wffblock = wffblock * 21 / 13;
  }
  kindof(++availwff) = k;
  ante(availwff) = a;
  succ(availwff) = s;
  return availwff;
}

void freewff(w)
wff *w;
{
  /* Rewrite newwff and all wff functions  */
  /* so that garbage wffs can be recycled. */
}

#define and(x,y)    newwff(ANDkind,x,y)
#define or(x,y)     newwff(ORkind,x,y)
#define forall(x,y) newwff(FORALLkind,x,y)
#define exists(x,y) newwff(EXISTSkind,x,y)
#define not(y)      newwff(NOTkind,NULL,y)
#define funct(x,y)  newwff(FUNCTkind,x,y)
#define arg(x,y)    newwff(ARGkind,x,y)

void freeallwffs()  /* returns memory allocated for wffs back to the OS */
{
  wff *temp;
  while (headwff) {
    temp = ante(headwff);
    free(headwff);
    headwff = temp;
  }
}

clause *newclause(n,m,f,hkc,phmnul,ls,s)  /* returns new clause with next  */
clause *n, *m, *f;                    /* n, mother m, father f, head or    */
void *hkc, *phmnul;               /* knowledge class hkc, prevhm or        */
lit *ls;                      /* nonunilit phmnul, lits ls, substitution s */
term *s;
{
  clause *temp;
  if (!availclause) {
    int i;
    availclause = (clause *) malloc(clauseblock * sizeof (clause));
    for (i=0, temp=availclause;  i < clauseblock-1;  ++i, ++temp)
      nextclause(temp) = temp+1;
    nextclause(temp) = NULL;
    clauseblock = clauseblock * 21 / 13;
  }
  temp = availclause;
  availclause = nextclause(availclause);
  nextclause(temp) = n;
  mother(temp) = m;
  father(temp) = f;
  head(temp) = hkc;
  prevhm(temp) = phmnul;
  lits(temp) = ls;
  substitution(temp) = s;
  if (0 && temp && s) {
    printf("storing substs %d in %d : \n\t",temp,s);
    print_subs(s);
    printf("\n");
  }
  clauserulewff(temp) = NULL;  /*ASM*/
  return temp;
}

#define newrule(next,nul,ls) newclause(next,NULL,NULL,defrul,nul,ls,NULL)
#define newev(next,class,ls) newclause(next,NULL,NULL,class,NULL,ls,NULL)
#define newgoal(n,m,f,h,phm,ls) newclause(n,m,n,h,phm,ls,NULL)

#define freeoneclause(c)       \
  nextclause(c) = availclause; \
  availclause = c
/* c must not be NULL; allows clause to be  */
/* recycled.  warning: c is evaluated twice */

void freeclauses(c)  /* allows clauses in list c to be recycled */
clause *c;
{
  clause *temp;
  while (c) {
    temp = c;
    c = nextclause(c);
    freeoneclause(temp);
  }
}

#define copyoneclause(c,n) newclause(n,mother(c),father(c),head(c), \
                                     prevhm(c),lits(c),substitution(c))
/* warning: copyoneclause(c,n) evaluates c 5 times */

lit *newlit(p,name,next,t)  /* returns new lit with polarity p, name name,  */
char p, *name;              /* next link next, lterms t, origin FromNothing */
lit *next;
term *t;
{
  lit *temp;
  if (!availlit) {
    int i;
    availlit = (lit *) malloc(litblock * sizeof (lit));
    for (i=0, temp=availlit;  i < litblock-1;  ++i, ++temp)
      nextlit(temp) = temp+1;
    nextlit(temp) = NULL;
    litblock = litblock * 21 / 13;
  }
  temp = availlit;
  availlit = nextlit(availlit);
  polarity(temp) = p;
  litname(temp) = name;
  nextlit(temp) = next;
  lterms(temp) = t;
  origin(temp) = FromNothing;
  return temp;
}

#define freeonelit(lt)    \
  nextlit(lt) = availlit; \
  availlit = lt
/* lt must not be NULL; allows lit to be     */
/* recycled.  warning: lt is evaluated twice */

void freelits(ls)  /* allows the lits in the list ls to be recycled */
lit *ls;
{
  lit *temp;
  while (ls) {
    temp = ls;
    ls = nextlit(ls);
    freeonelit(temp);
  }
}

term *newterm(name,next,tln)  /* returns new term with name name, next */
char *name;                   /* link next, and tterms or lastname tln */
term *next;
void *tln;
{
  term *temp;
  if (!availterm) {
    int i;
    availterm = (term *) malloc(termblock * sizeof (term));
    for (i=0, temp=availterm;  i < termblock-1;  ++i, ++temp)
      nextterm(temp) = temp+1;
    nextterm(temp) = NULL;
    termblock = termblock * 21 / 13;
  }
  temp = availterm;
  availterm = nextterm(availterm);
  termname(temp) = name;
  nextterm(temp) = next;
  tterms(temp) = tln;
  return temp;
}

term *copyterms(t)  /* returns copy of termlist t */
term *t;
{
  return t ? newterm(termname(t),copyterms(nextterm(t)),copyterms(tterms(t)))
           : NULL;
}

#define copyoneterm(t,n) newterm(termname(t),n,copyterms(tterms(t)))
/* warning: copyoneterm(t,n) evaluates t twice */

#define copylit(l,n) newlit(polarity(l),litname(l),n,copyterms(lterms(l)))
/* warning: copylit(l,n) evaluates l 3 times */

#define freeoneterm(t)     \
  nextterm(t) = availterm; \
  availterm = t
/* t must not be NULL; allows the single term t   */
/* to be recycled.  warning: t is evaluated twice */

void freeterms(t)  /* allows the terms in the list t to be recycled */
term *t;
{
  term *temp;
  while (t) {
    temp = t;
    t = nextterm(t);
    freeoneterm(temp);
  }
}

argheader *newargheader(k,g,lm,lf,lg,nc,L,R,al,sl,u,cs)  /* returns a new   */
clause *k, *g, *lm, *lf, *lg, *nc;  /* argheader with knowledge k, goals g, */
argheader *L, *R;                /* lastm lm, lastf lf, lastg lg, nilclause */
int al, sl, u;                   /* nc, left L, right R, attemptlimit al,   */
term *cs;                        /* successlimit sl, unique u, cutsets cs   */
{
  argheader *temp;
  if (!availargh) {
    int i;
    availargh = (argheader *) malloc(arghblock * sizeof (argheader));
    for (i=0, temp=availargh;  i < arghblock-1;  ++i, ++temp)
      left(temp) = temp+1;
    left(temp) = NULL;
    arghblock = arghblock * 21 / 13;
  }
  temp = availargh;
  availargh = left(availargh);
  knowledge(temp) = k;
  goals(temp) = g;
  lastm(temp) = lm;
  lastf(temp) = lf;
  lastg(temp) = lg;
  nilclause(temp) = nc;
  left(temp) = L;
  right(temp) = R;
  attemptlimit(temp) = al;
  successlimit(temp) = sl;
  unique(temp) = u;
  cutsets(temp) = cs;
  nextarg(temp) = NULL; /* ASM */
  argstatus(temp) = 0;  /* ASM */
  argnumber(temp) = 0;  /* ASM */
  lastcheckedarg(temp) = NULL; /* ASM */
  argactivator(temp) = NULL; /* ASM */
  toprules(temp) = NULL; /* RPL */
  thrulelist(temp) = NULL; /* RPL */
  return temp;
}

#define freeargheader(ah)    \
  knowledge(ah) = availargh; \
  availargh = ah
/* ah must not be NULL; allows argheader ah to  */
/* be recycled.  warning: ah is evaluated twice */


#define isvar(x)    (*((char *) (x)) == '?')
#define isauxvar(x) (*((char *) (x)) == '?' && *((char *) (x) + 1) == '?')

wff *multiquant(k,vl,w)  /* builds a chain of quantifiers of kind k */
wffkind k;               /* from a varlist vl and links it to wff w */
wff *vl,*w;
{
  if (0) {
    printf("multiquant %d %d %d entry",k,vl,w);printwff(w);printf("\n");
  }
  if (!vl) return w;
  if (0) {
    printf("\nvl is ");printwff(vl);printf("\n");
    printf("multiquant ante recursion %d\n",ante(vl));
  }
  succ(ante(vl)) = multiquant(k,succ(vl),w);
  if (0) printf("after:multiquant succ recursion %d\n",succ(ante(vl)));
  kindof(ante(vl)) = k;
  if (0) printf("multiquant popping %d\n",ante(vl));
  return ante(vl);
}

#define multiforall(vl,w) multiquant(FORALLkind,vl,w)
#define multiexists(vl,w) multiquant(EXISTSkind,vl,w)

wff *findimplicit(w,build)  /* looks for an implicit variable in a wff - RPL 91393  */
wff* w;
wff *build; /* builds a varlist */
{
  wff *res;
  if (0) printf("		printwff %d\n",w);
  if (!w)
    return build;
  else {
    if (0) printf("looking for var, string is %s\n",wffname(w));
    switch(kindof(w))
    {
      case NULLkind:
        return build;
        break;
      case ANDkind:
        return findimplicit(ante(w),findimplicit(succ(w),build));
        break;
      case ORkind:
        return findimplicit(ante(w),findimplicit(succ(w),build));
        break;
      case FORALLkind:
        return build; /* already explicit, no action needed */
        break;
      case EXISTSkind:
        return build; /* ouch!  need to check for NEW variable UNIMPLEMENTED */
        break;
      case NOTkind:
        return findimplicit(succ(w),build);
        break;
      case FUNCTkind:
        if (isvar(wffname(w))) {
	  if (0) {
	    printf("found var and building %s\n",wffname(w));
	    printf("build is now:");printwff(build);printf("\n");
	  }
	  res = arg(funct(makename(wffname(w)),build),NULL);
	  if (0) printwff(res);
	  if (succ(w) != NULL) return findimplicit(succ(w),res);
	  else return res;
	}
        if (succ(w) != NULL) return findimplicit(succ(w),build);
        break;
      case ARGkind:
        return findimplicit(ante(w),findimplicit(succ(w),build));
        break;
      default:
        printf("bogus wff type=%d", kindof(w));
    }
    return build;
  }
}

wff *checkforall(w)  /* checks for implict FORALL RPL 91393 */
wff *w;
{
  wff *wr;
  wff *foundvar;
  if (0) printf("in checkforall\n");
  foundvar = findimplicit(w,NULL);
  if (foundvar) {
    if (0) {
      printf("found implicit variable!\n");
      printf("result is:");
      printwff(foundvar);
      printf("creating multiforall\n");
    }
    wr = multiforall(foundvar,w);
    if (0) {
      printf("multiforall created\n");
      printwff(wr);
    }
    return wr;
  }
  return w;
}

wff *copywff(w)  /* returns a copy of the wff w */
wff *w;
{
  return w ? newwff(kindof(w),
                    (binary(w) || kindof(w) == ARGkind ?
                      (void *) copywff(ante(w)) :
                      ante(w)),
                    copywff(succ(w)))
           : NULL;
}

targetlist *newtl() /* RPL */
{
  targetlist *temp;
  if (!availtl) {
    int i;
    availtl = (targetlist *) malloc(tlblock * sizeof (targetlist));
    for (i=0, temp=availtl;  i < tlblock-1;  ++i, ++temp)
      nexttarget(temp) = temp+1;
    nexttarget(temp) = NULL;
    tlblock = tlblock * 21 / 13;
  }
  temp = availtl;
  availtl = nexttarget(availtl);
  nexttarget(temp) = NULL;
  targetwff(temp) = NULL;
  return temp;
}


#define freeonetl(tl)    \
  nexttarget(tl) = availtl; \
  availtl = tl
/* tl must not be NULL; allows tl to be     */
/* recycled.  warning: lt is evaluated twice */

freetl(tl)  /* RPL */
targetlist *tl;
{
  targetlist *temp;
  while (tl) {
    temp = tl;
    tl = nexttarget(tl);
    freeonetl(temp);
  }
}

char getletter()  /* returns next character of input, which is then  */
{                 /* also available in the global letter; translates */
  int c;          /* tabs and newlines to spaces and EOF to ?        */
  c = getchar();
  if (c == EOF) c = '?';
  if (seeinput) putchar(c);
  if (c == '\n' || c == '\t') c = ' ';
  return letter = c;
}

#define isspecialletter(c) ((c) == ',' || (c) == '.' || (c) == '!'\
  || (c) ==  '?' || (c) == ',' || (c) == '(' || (c) == ')' || (c) == '~')
/* warning: isspecialletter(c) evaluates c 8 times */

char *getword()  /* returns the next word of input, which is then */
{                /* also available in the global variable word    */
  int i=0;
  if (letter == ' ') while (getletter() == ' ');  /* skip spaces */
  word[0] = letter;
  if (!isspecialletter(letter))
    for (;;) {
      getletter();
      if (isspecialletter(letter) || letter == ' ') break;
      if (i < maxwordlen-2) word[++i] = letter;
    }
  else getletter();
  word[i+1] = '\0';
  return word;
}

#define islparen(s) (*(s) == '(')
#define isrparen(s) (*(s) == ')')
#define iscomma(s)  (*(s) == ',')
#define isperiod(s) (*(s) == '.')
#define isbang(s)   (*(s) == '!')
#define isquest(s)  (*(s) == '?')

/* the following functions beginning with "is" return 1 or 0,    */
/* depending on whether s is or is not whatever the name implies */

char isiff(s)
char *s;
{
  return !strcmp(word,"<=>") || !strcmp(word,"iff") || !strcmp(word,"IFF");
}

char isimplies(s)
char *s;
{
  return !strcmp(word,"=>") || !strcmp(word,"implies") ||
         !strcmp(word,"IMPLIES");
}

char isor(s)
char *s;
{
  return !strcmp(word,"v") || !strcmp(word,"|") || !strcmp(word,"or") ||
         !strcmp(word,"OR");
}

char isand(s)
char *s;
{
  return !strcmp(word,"^") || !strcmp(word,"&") || !strcmp(word,"and") ||
         !strcmp(word,"AND");
}

char isnot(s)
char *s;
{
  return word[0] == '~' || !strcmp(word,"not") || !strcmp(word,"NOT");
}

char isforall(s)
char *s;
{
  return !strcmp(word,"A") || !strcmp(word,"forall") || !strcmp(word,"FORALL");
}

char isexists(s)
char *s;
{
  return !strcmp(word,"E") || !strcmp(word,"exists") || !strcmp(word,"EXISTS");
}

char isrule(s)
char *s;
{
  return !strcmp(word,"R") || !strcmp(word,"rule") || !strcmp(word,"RULE");
}

char issuggests(s)
char *s;
{
  return !strcmp(word,">-") || !strcmp(word,"suggests") ||
         !strcmp(word,"SUGGESTS");
}

char isterminator(s)
char *s;
{
  return isperiod(s) || isbang(s) || isquest(s) || issuggests(s);
}

char isspecial(s)
char *s;
{
  return islparen(s) || isrparen(s) || isperiod(s) || isbang(s) ||
         isquest(s) || isiff(s) || isimplies(s) || isor(s) || isand(s) ||
         isnot(s) || isforall(s) || isexists(s) || isrule(s) || issuggests(s);
}

char *makename(s)  /* returns a pointer to the name s, creating */
char *s;           /* s only if it did not already exist        */
{
  term *t;
  char *c,*name;
  for (t=namelist; t; t=nextterm(t))
    for (c=termname(t);  c <= (char *) lastname(t);  ++c)
      if (!strcmp(c,s)) return c;
      else while (*++c);  /* skip to next null character */
  if (nameroom <= strlen(s)) {
    nextname = (char *) calloc(charblock, sizeof (char));
    namelist = newterm(nextname,namelist,nextname);
    nameroom = charblock;
    charblock = charblock * 21 / 13;
  }
  name = lastname(namelist) = nextname;
  for (c=s;  *c;  ++c, ++nextname, --nameroom) *nextname = *c;
  ++nextname;  --nameroom;
  return name;
}

char *newfunctname()  /* returns the names !f1, !f2... upon successive calls */
{
  char name[8];
  sprintf(name,"!f%u",functnum++);
  return makename(name);
}

#define resetfunctnames() (functnum = 1)

char *newvarname()   /* returns the names ?x1, ?x2, ... upon successive    */
{                    /* calls; these names have ?? immediately before them */
  char name[11],*temp;
  sprintf(name,"???x%u",varnum++);
  *lastvartermp = newterm((temp = makename(name)+2), NULL, NULL);
  lastvartermp = &nextterm(*lastvartermp);
  return temp;
}

char *nextvarname()  /* returns the next name in the list of all standard */
{                    /* variable names, creating one if necessary         */
  char *temp;
  if (!nextvarterm) return newvarname();
  temp = termname(nextvarterm);
  nextvarterm = nextterm(nextvarterm);
  return temp;
}

#define resetvars() (nextvarterm = varnamelist)

wff *getvarlist()  /* like getarglist() but disallows nesting of terms */
{
  wff *firstvar;
  if (isspecial(word)) nameexperr();
  firstvar = funct(makename(word),NULL);
  if (0) {
    printf("varlist is:"); printwff(firstvar); 
  }
  return arg(firstvar, (iscomma(getword()) ? getword(), getvarlist() : NULL));
}

/* now we have parsing routines too difficult to adequately comment */

wff *getfunct();

wff *getarglist()
{
  wff *firstarg;
  if (isrparen(word)) return NULL;
  if (isspecial(word)) nameexperr();
  firstarg = getfunct();
  if (iscomma(word)) getword();  /* allows args to be separated by spaces */
  return arg(firstarg,getarglist());
}

wff *getfunct() 
{
  char *name;
  wff *arglist;
  name = makename(word);
  if (!islparen(getword())) return funct(name,NULL);
  getword();
  arglist = getarglist();
  /* must be isrparen(word) */
  getword();
  return funct(name,arglist);
}

wff *getsentence();

wff *getandarg()
{
  if (isrparen(word) || isterminator(word) || isiff(word) || isimplies(word)
      || isor(word) || isand(word)) nonullsenterr();
  if (iscomma(word) || isrule(word)) illegalsymbolerr();
  if (islparen(word)) {
    wff *sent;
    getword();
    sent = getsentence();
    if (!isrparen(word)) rparenexperr();
    getword();
    return sent;
  }
  if (isnot(word)) {
    getword();
    return not(getandarg());
  }
  if (isexists(word)) {
    wff *varlist;
    getword();
    varlist = getvarlist();
    return multiexists(varlist,getandarg());
  }
  if (isforall(word)) {
    wff *varlist;
    getword();
    varlist = getvarlist();
    return multiforall(varlist,getandarg());
  }
  return getfunct();
}

wff *getorarg()
{
  wff *andarg;
  andarg = getandarg();
  if (isrparen(word) || isterminator(word) || isiff(word) || isimplies(word)
      || isor(word)) return andarg;
  if (isand(word)) getword();  /* allows conjunction by juxtaposition */
  return and(andarg,getorarg());
}

wff *getimpliesarg()
{
  wff *orarg;
  orarg = getorarg();
  if (isrparen(word) || isterminator(word) || isiff(word) || isimplies(word))
    return orarg;
  /* must be isor(word) */
  getword();
  return or(orarg,getimpliesarg());
}

wff *getiffarg()
{
  wff *impliesarg;
  impliesarg = getimpliesarg();
  if (isrparen(word) || isterminator(word) || isiff(word)) return impliesarg;
  /* must be isimplies(word) */
  getword();
  return or(not(impliesarg),getiffarg());
}

wff *getsentence()
{
  wff *iffarg,*sent;
  iffarg = getiffarg();
  if (isrparen(word) || isterminator(word)) return iffarg;
  /* must be isiff(word) */
  getword();
  sent = getsentence();
  return or(and(copywff(iffarg),copywff(sent)),
            and(not(iffarg),not(sent)));
}

wff *reducenot(w)  /* w must not be NULL; reduces the scope of NOT in w */
wff *w;
{
  while (kindof(w) == NOTkind && kindof(succ(w)) == NOTkind) w = succ(succ(w));
  if (kindof(w) == NOTkind && kindof(succ(w)) != FUNCTkind) {
    wff *temp;
    temp = w;
    w = succ(w);
    kindof(w) = dual[kindof(w)];
    if (binary(w)) ante(w) = not(ante(w));
    succ(temp) = succ(w);
    succ(w) = temp;
  }
  if (kindof(w) != NOTkind && kindof(w) != FUNCTkind) {
    succ(w) = reducenot(succ(w));
    if (binary(w)) ante(w) = reducenot(ante(w));
  }
  return w;
}

void functreplacename(oldname,newname,w) /* w must not be NULL ; replaces */
char *oldname, *newname;                 /* oldname by newname in funct w */
wff *w;
{
  if (0) printf("functreplacename with %s,%s\n",oldname,newname);
  if (wffname(w) == oldname) {
    if (succ(w)) quantfuncterr();
    wffname(w) = newname;
  } else {
    wff *a;
    a = succ(w);
    while (a) {
      functreplacename(oldname,newname,ante(a));
      a = succ(a);
    }
  }
}

void wffreplacename(oldname,newname,w)  /* w must not be NULL ; replaces */
char *oldname, *newname;                /* oldname by newname in wff w   */
wff *w;
{
  if (0) printf("wffreplacename with %s,%s\n",oldname,newname);
  if (kindof(w) == FUNCTkind) functreplacename(oldname,newname,w);
  else {
    wffreplacename(oldname,newname,succ(w));
    if (binary(w)) wffreplacename(oldname,newname,ante(w));
  }
}

wff *standardize(w)  /* w must not be NULL; standardize variables in w */
wff *w;
{
  if (kindof(w) != FUNCTkind) {
    standardize(succ(w));
    if (binary(w)) standardize(ante(w));
    else if (kindof(w) == FORALLkind || kindof(w) == EXISTSkind) {
      char *varname;
      wffreplacename(wffname(w),varname=nextvarname(),succ(w));
      wffname(w) = varname;
      if (0) printf("wffname gets %s\n",varname);
    }
  }
  return w;
}

void replacefunct(varname,functname,arglist,w)  /* w must not be NULL */
char *varname, *functname; 
wff *arglist, *w; 
{
  if (wffname(w) == varname) {
    wffname(w) = functname;
    if (0) printf("wffname gets %s\n",functname);
    succ(w) = copywff(arglist);
  } else {
    wff *a;
    a = succ(w);
    while (a) {
      replacefunct(varname,functname,arglist,ante(a));
      a = succ(a);
    }
  }
}

void skolemize(varname,functname,arglist,w)  /* w must not be NULL */
char *varname, *functname;
wff *arglist, *w;
{
  if (kindof(w) == FUNCTkind) replacefunct(varname,functname,arglist,w);
  else {
    skolemize(varname,functname,arglist,succ(w));
    if (binary(w)) skolemize(varname,functname,arglist,ante(w));
  }
}

wff *removeexists(arglist,w)  /* remove existentials from */
wff *arglist, *w;             /* w using Skolem functions */
{
  if (!w) return NULL;
  if (kindof(w) != FUNCTkind)
    if (kindof(w) == FORALLkind)
      succ(w) = removeexists(arg(funct(wffname(w),NULL),arglist),succ(w));
    else if (kindof(w) == EXISTSkind) {
      succ(w) = removeexists(arglist,succ(w));
      skolemize(wffname(w),newfunctname(),arglist,succ(w));
      w = succ(w);
    } else {
      succ(w) = removeexists(arglist,succ(w));
      if (kindof(w) != NOTkind) ante(w) = removeexists(arglist,ante(w));
    }
  return w;
}

wff *removeforall(w)  /* simply remove universals */
wff *w;
{
  if (!w) return NULL;
  if (kindof(w) != FUNCTkind) {
    succ(w) = removeforall(succ(w));
    if (binary(w)) ante(w) = removeforall(ante(w));
  }
  return kindof(w) == FORALLkind ? succ(w) : w;
}

wff *dist1(w)  /* w must be of the form or(cnf,cnf).  Returns form cnf. */
wff *w;
{
  if (kindof(succ(w)) == ANDkind) {
    w = and(w,succ(w));
    kindof(succ(w)) = ORkind;
    succ(ante(w)) = ante(succ(w));
    ante(succ(w)) = copywff(ante(ante(w)));
    succ(w) = dist1(succ(w));
    ante(w) = dist1(ante(w));
  } else if (kindof(ante(w)) == ANDkind) {
    w = and(ante(w),w);
    kindof(ante(w)) = ORkind;
    ante(succ(w)) = succ(ante(w));
    succ(ante(w)) = copywff(succ(succ(w)));
    succ(w) = dist1(succ(w));
    ante(w) = dist1(ante(w));
  }
  return w;
}

wff *distributeor(w)  /* w must not be NULL; transform to conj. of disj. */
wff *w;
{
  if (kindof(w) != FUNCTkind) {
    succ(w) = distributeor(succ(w));
    if (binary(w)) ante(w) = distributeor(ante(w));
    if (kindof(w) == ORkind) w = dist1(w);
  }
  return w;
}

term *termform(w)  /* w should be ARGkind; return termlist equivalent to w */
wff *w;
{
  return w ? newterm(wffname(ante(w)),
                     termform(succ(w)),
                     termform(succ(ante(w))))
           : NULL;
}

lit *litform(w)  /* w must not be NULL; return lit equivalent to w */
wff *w;
{
  lit *lit1;
  if (kindof(w) == ORkind) {
    lit *lit2, *lit3;
    lit1 = litform(ante(w));
    lit2 = litform(succ(w));
    lit3 = nextlit(lit1);
    nextlit(lit1) = nextlit(lit2);
    nextlit(lit2) = lit3;
    return lit2;
  }
  /* either w is FUNCTkind or (w is NOTkind and succ(w) is FUNCTkind) */
  {
    char positive;
    if (!(positive = kindof(w) == FUNCTkind)) w = succ(w);
    /* if w was funct, positive = 1 */
    /* if w was not funct, positive = 0 and w became funct */
    lit1 = newlit(positive,wffname(w),NULL,termform(succ(w)));
    return nextlit(lit1) = lit1;
  }
}

clause *clauseform(c,w)  /* w must not be NULL; return clause equiv. to w */
/* returns tail of list, whose next pointer points to head */
knowclass c;
wff *w;
{
  clause *clause1;
  if (kindof(w) == ANDkind) {
    clause *clause2, *clause3;
    clause1 = clauseform(c,ante(w));
    clause2 = clauseform(c,succ(w));
    clause3 = nextclause(clause1);
    nextclause(clause1) = nextclause(clause2);
    nextclause(clause2) = clause3;
    return clause2;
  }
  {
    lit *lit1, *lit2;
    lit1 = litform(w);
    lit2 = nextlit(lit1);
    nextlit(lit1) = NULL;
    clause1 = newev(NULL,c,lit2);
    return nextclause(clause1) = clause1;
  }
}

clause *cnf(sent,c)  /* sent must not be NULL; return tail of */
wff *sent;           /* list (who points to head) of clauses  */
knowclass c;         /* of class c in cnf equiv. to sent      */
{
  resetvars();
  return clauseform(c,
                    distributeor(
                      removeforall(
                        removeexists(
                          NULL,
                          standardize(
                            reducenot(
                              sent
                            )
                          )
                        )
                      )
                    )
         )
  ;
}

clause *insertknowledge(k,w,c)  /* insert clauses of class c into knowledge */
clause *k;                      /* k; clauses derived from wff w            */
wff *w;
knowclass c;
{
  clause *t, *h;
  t = cnf(w,c);
  h = nextclause(t);
  nextclause(t) = k;
  return h;
}


wfflist *newwfflist(tail, wff1, wff2) /* allocates a new wfflist element - ASM */
wfflist *tail;			    /* ptr to tail of current list */
wff *wff1, *wff2;		    /* ptr to the wff to add to the list */
{
  wfflist *temp;
  temp = (wfflist *) malloc(sizeof (wfflist));
  thewff(temp) = wff1;
  cwff(temp) = wff2;
  wffflag(temp) = 0;
  nextwff(temp) = NULL;
  wfflistrule(temp) = NULL;
  if (tail)
    nextwff(tail) = temp;
  return temp;
}

wffrule *newwffrule(tail,var,ant,con) /* allocates a new wffrule - ASM */
wffrule *tail;	  		      /* ptr to tail of current list */
wff *var,*ant,*con;		      /* ptr to the wffs to add to the list */
{
  wffrule *temp;
  temp = (wffrule *) malloc(sizeof (wffrule));
  wffrulevar(temp) = var;
  wffruleant(temp) = ant;
  wffrulecon(temp) = con;
  wffruleantname(temp) = NULL;
  wffruleconname(temp) = NULL;
  wffruleuse(temp) = TRUE;
  wffruletop1(temp) = FALSE;
  wffruletop2(temp) = FALSE;
  nextwffrule(temp) = NULL;
  if (tail) {
    nextwffrule(tail) = temp;
    if (0) printf(" newwffrule points %d to %d ",tail,temp);
    }
  return temp;
}

void readwffs(wpack)  /* initialize investigation invest */
wffpack *wpack;       /* with knowledge from stdin       */
{
  wff *varlist, *sent1, *sent2;
  wfflist *wknowledge=NULL;
  wffrule *wrules=NULL;
  wffrules(wpack) = NULL;
  wffknow(wpack) = NULL;
  wffactivator(wpack) = NULL;
  getletter();
  for (;;)
    if (isrule(getword())) {
      if (iscomma(getword())) {
        varlist = NULL;
        getword();
      } else varlist = getvarlist();
      sent1 = getsentence();
      if (!issuggests(word)) suggexperr();
      getword();
      sent2 = getsentence();
      if (!isperiod(word)) periodexperr();
      wrules = newwffrule(wrules,varlist,sent1,sent2);
      if (!wffrules(wpack)) wffrules(wpack) = wrules;
    } else {
      sent1 = getsentence();
      if (isquest(word)) break;
      wknowledge = newwfflist(wknowledge,sent1,NULL);
      if (!wffknow(wpack)) wffknow(wpack) = wknowledge;
      if (isperiod(word))
	wffflag(wknowledge) = NECEVflag;
      else if (isbang(word))
	wffflag(wknowledge) = CONTEVflag;
      else qpbexperr();
    }
  wffgoal(wpack) = sent1;
/*  freeallwffs(); */
}

/* initialize investigation invest */
void translatewffs(wpack, invest, pol, usecont, output)
wffpack *wpack;
theoryheader *invest;
char pol, usecont, output;
{
  wfflist *wknowledge;
  wffrule *wrules;
  wff *varlist, *sent1, *sent2, *vl1, *vl2, *vl3, *vl4, *vl5, *quant;
  term *t;
  clause *k, *g;
  char *q, *r;
  rules(invest) = contingent(invest) = otherev(invest) = NULL;
  arglimit(invest) = thlimit(invest) = -1;
  resetfunctnames();
  for (wrules=wffrules(wpack); wrules; wrules=nextwffrule(wrules)) {
    q = newfunctname();
    r = newfunctname();
    if (0) printf("looking at rule %d ",wrules);
    if (wffruleuse(wrules))
    {
      if (0) printf("ok to use rule %d ",wrules);
      varlist = wffrulevar(wrules);
      vl1 = copywff(varlist);
      vl2 = copywff(varlist);
      vl3 = copywff(varlist);
      vl4 = copywff(varlist);
      vl5 = copywff(varlist);
      resetvars(); 
      t = NULL;
      for (sent1=varlist; sent1; sent1=succ(sent1))
	t = newterm(nextvarname(),t,NULL);
      sent1 = copywff(wffruleant(wrules));
      sent2 = copywff(wffrulecon(wrules));
      resetvars();
      wffruleantname(wrules) = 
	removeforall(standardize(multiforall(vl3,copywff(sent1))));
      resetvars();
      wffruleconname(wrules) = 
	removeforall(standardize(multiforall(vl4,copywff(sent2))));
      rules(invest) =
	newrule(rules(invest),
		  newlit(1,q,NULL,t),
		  newlit(1,r,NULL,copyterms(t)));
      clauserulewff(rules(invest)) = wrules;
      quant = multiforall(vl5, and(or(not(sent1),not(funct(q,vl1))),
				   or(not(funct(r,vl2)),sent2)));
      otherev(invest) =
	insertknowledge(otherev(invest), quant, fakev);
      if (0) {
	printf("-RULE");
	printwff(sent1);
	printwff(sent2);
      }
      if (output) {
	printf("* ~%s = ", q);
	printwff(wffruleantname(wrules));
	printf("\n* %s = ", r);
	printwff(wffruleconname(wrules));
	printf("\n");
      }
    }
  }
  for(wknowledge=wffknow(wpack); wknowledge; wknowledge=nextwff(wknowledge))
  {
    if (0) printf("-EV");
    sent1 = copywff(thewff(wknowledge));
    if (wffflag(wknowledge) == NECEVflag)
        otherev(invest) = insertknowledge(otherev(invest),sent1,necev);
    if ((wffflag(wknowledge) == CONTEVflag) && usecont)
        contingent(invest) = insertknowledge(contingent(invest),sent1,contev);
  };

  if (wffactivator(wpack)) {
    if (0) printf("-ACT");
    sent1 = copywff(wffactivator(wpack));
    otherev(invest) = insertknowledge(otherev(invest),sent1,fakev);
  }

  if (!pol)
    sent1 = copywff(wffgoal(wpack));
  else
    sent1 = not(copywff(wffgoal(wpack)));
  q = newfunctname();
  if (0) {
    printf("goal for invest is ");
    printwff(sent1);
    printf("\n");
  }
  if (output) {
    printf("* %s = ", q);
    printwff(sent1);
    printf("\n");
  }
  g = newgoal(NULL,NULL,NULL,NULL,NULL,newlit(0,q,NULL,NULL));
  head(g) = prevhm(g) = g;
  otherev(invest) =
    insertknowledge(otherev(invest),or(not(sent1),funct(q,NULL)),fakev);

  /*   v- assignment! */
  if (k=contingent(invest)) {
    while (nextclause(k)) k = nextclause(k);
    nextclause(k) = otherev(invest);
  } else contingent(invest) = otherev(invest);
  /*   v- assignment! */
  if (k=rules(invest)) {
    while (nextclause(k)) k = nextclause(k);
    nextclause(k) = contingent(invest);
  } else rules(invest) = contingent(invest);
  generator(invest) =
    newargheader(rules(invest),g,g,NULL,g,NULL,NULL,NULL,ALIMIT,SLIMIT,1,NULL); 
    /* newargheader(rules(invest),g,g,NULL,g,NULL,NULL,NULL,-1,-1,1,NULL); */
  theories(invest) = NULL;
}


#define ptrless(x,y) ((pint) (x) < (pint) (y))

char compareterms(t1,t2)  /* returns 0 if termlists t1, t2 are same, else */
term *t1, *t2;            /* 1 or -1; guaranteed compareterms(t1,t2) ==   */
{                         /* -compareterms(t2,t1) */
  term *temp1, *temp2;
  char c;
  for (temp1=t1, temp2=t2;  temp1 && temp2;
       temp1=nextterm(temp1), temp2=nextterm(temp2)) {
    if (ptrless(termname(temp1),termname(temp2))) return -1;
    if (ptrless(termname(temp2),termname(temp1))) return 1;
    c = compareterms(tterms(temp1),tterms(temp2));
    if (c) return c;
  }
  return temp1 ? 1 : temp2 ? -1 : 0;
}

void termreplacename(t,oldname,newname)  /* replace oldname by    */
term *t;                                 /* newname in termlist t */
char *oldname, *newname;
{
  while (t) {
    if (termname(t) == oldname) termname(t) = newname;
    else termreplacename(tterms(t),oldname,newname);
    t = nextterm(t);
  }
}

void litreplacename(ls,oldname,newname)  /* replace oldname by    */
lit *ls;                                 /* newname in litlist ls */
char *oldname, *newname;
{
  while (ls) {
    termreplacename(lterms(ls),oldname,newname);
    ls = nextlit(ls);
  }
}

term *catsubst(s1,s2)  /* concatenates the substitutions s1 and s2, which */
term *s1, *s2;         /* must be given in tail-of-circular-list form     */
{
  term *h;
  if (!s1) return s2;
  if (!s2) return s1;
  h = nextterm(s1);
  nextterm(s1) = nextterm(s2);
  nextterm(s2) = h;
  return s2;
}

void killaux(ls,t)  /* replace in the litlist ls those auxiliary variables */
lit *ls;            /* which appear in the termlist t by standard ones     */
term *t;
{
  while (t) {
    if (isauxvar(termname(t))) litreplacename(ls,termname(t),nextvarname());
    else killaux(ls,tterms(t));
    t = nextterm(t);
  }
}

term *killauxsubst(ls,t)  /* like killaux, but returns a substitution which */
lit *ls;                  /* has the same effect as calling this function   */
term *t;
{
  term *subst=NULL, *tmpsubst;
  char *n;
  while(t) {
    if (isauxvar(termname(t))) {
      n = nextvarname();
      tmpsubst = newterm(termname(t),NULL, newterm(n,NULL,NULL));
      nextterm(tmpsubst) = tmpsubst;
      subst = catsubst(subst,tmpsubst);
      litreplacename(ls,termname(t),n);
    } else subst = catsubst(subst, killauxsubst(ls,tterms(t)));
    t = nextterm(t);
  }
  return subst;
}

void killauxterm(t)  /* like killaux but only one term RPL 121093 */
term *t;
{
  term *iter;
  iter = t;
  while (iter) {
    while (isauxvar(termname(iter))) { 
      termname(iter) = (char *) termname(iter) + 1; 
    }
    if (iter == nextterm(iter)) break;
    iter = nextterm(iter);
  }
}

void deauxlits(ls)  /* replace the auxiliary variables in */
lit *ls;            /* the litlist ls by standard ones    */
{
  lit *tl;
  resetvars();
  for (tl=ls; tl; tl=nextlit(tl)) killaux(ls,lterms(tl));
}

term *deauxlsubst(ls)  /* like deauxlits, but returns a substitution which   */
lit *ls;               /* will have the same effect as calling this function */
{
  lit *tl;
  term *subst=NULL;
  resetvars();
  for (tl=ls; tl; tl=nextlit(tl))
    subst = catsubst(subst, killauxsubst(ls,lterms(tl)));
  return subst;
}

char compdauxlterms(l1,l2)  /* compare deauxiliarized copies of the lterms */
lit *l1,*l2;                /* of l1, l2, then free them and return result */
{
  lit *n1,*n2;
  char c;
  n1 = copylit(l1,NULL);
  n2 = copylit(l2,NULL);
  deauxlits(n1);
  deauxlits(n2);
  c = compareterms(lterms(n1),lterms(n2));
  freeonelit(n1);
  freeonelit(n2);
  return c;
}

lit *sortlits(ls)  /* sorts lits in list ls by name, using terms      */
lit *ls;           /* to break ties, also removes duplicates, and     */
{                  /* returns truth if the disjuction simplifies to T */
  lit *tl, *ul, *temp, dummy, *h = &dummy;
  char c;
  if (!ls) return NULL;
  tl = nextlit(h) = ls;
  while (nextlit(tl)) {
    for (ul=h, c = -1
         ;
         ptrless(litname(nextlit(ul)),litname(nextlit(tl)))
         || ul != tl
            && litname(nextlit(ul)) == litname(nextlit(tl))
            && (c=compdauxlterms(nextlit(ul),nextlit(tl))) == -1
            /*   ^- assignment! */
         ;
         ul=nextlit(ul)
        );
    if (ul == tl) tl = nextlit(tl);  /* nextlit(tl) was already in place */
    else if (!c)  /* i.e. if nextlit(ul) and nextlit(tl) are identical */
      if (polarity(nextlit(ul)) == polarity(nextlit(tl))) {  /* redundancy */
        origin(nextlit(ul)) |= origin(nextlit(tl));  /* combine origins */
        temp = nextlit(nextlit(tl));
        freeonelit(nextlit(tl));
        nextlit(tl) = temp;
      } else {  /* tautology */
        freelits(nextlit(h));
        return truth;
      }
    else {  /* put nextlit(tl) in its proper place immediately after ul */
      temp = nextlit(nextlit(tl));
      nextlit(nextlit(tl)) = nextlit(ul);
      nextlit(ul) = nextlit(tl);
      nextlit(tl) = temp;
    }
  }
  return nextlit(h);
}

char eqterms(t1,t2)  /* Returns 1 if terms t1 and t2 are identical */
term *t1, *t2;       /* and contain no variables, else 0.  AMC     */
{
  term *ts1, *ts2;
  char *n1, *n2;

  if (!t1) return t2 == NULL;
  if (!t2) return 0;
  n1 = termname(t1);
  n2 = termname(t2);
  if (isvar(n1) || isvar(n2) || n1 != n2) return 0;
  for (ts1 = tterms(t1), ts2 = tterms(t2);
       ts1 || ts2;
       ts1 = nextterm(ts1), ts2 = nextterm(ts2))
    if (!eqterms(ts1,ts2)) return 0;
  return 1;
}

char eqtermlist(ts)  /* Returns 1 if all terms in termlist ts are        */
term *ts;            /* identical and contain no variables, else 0.  AMC */
{
  term *t;

  if (!ts) return 1;
  if (!nextterm(ts)) return !isvar(termname(ts));
  /*             v- assignment! */
  while (ts && (t=nextterm(ts))) {
    if (!eqterms(ts,t)) return 0;
    ts = t;
  }
  return 1;
}

char distinctnames(ts)  /* Returns 1 if there are two terms in termlist   */
term *ts;               /* which are distinct non-variable function names */
{                       /* with no arguments, else 0.  AMC                */
  term *t;
  char *tsn, *tn;

  if (!ts) return 0;
  if (distinctnames(nextterm(ts))) return 1;
  tsn = termname(ts);
  if (isvar(tsn) || tterms(ts)) return 0;
  for (t = nextterm(ts);  t;  t = nextterm(t)) {
    tn = termname(t);
    if (tsn != tn && !tterms(t)) return 1;
  }
  return 0;
}

lit *evalnameq(ls)  /* Tries to evaluate literals in ls with litname == */
lit *ls;            /* nameqname, removing false ones.  If any evaluate */
{                   /* to true, truth is returned.  AMC                 */
  lit dummy, *h = &dummy, *tl, *pl;
  term *tlt;
  char p, dn, etl;

  if (ls == truth) return truth;
  nextlit(h) = ls;
  pl = h;
  /*       v- assignment! */
  while(tl = nextlit(pl))
    if (litname(tl) == nameqname) {
      p = polarity(tl);
      tlt = lterms(tl);
      dn = distinctnames(tlt);
      etl = dn ? 0 : eqtermlist(tlt);
      if (p && etl || !p && dn) {
        freelits(nextlit(h));
        return truth;
      }
      if (!p && etl || p && dn) {
        nextlit(pl) = nextlit(tl);
        freeonelit(tl);
      } else pl = tl;
    } else pl = tl;

  return nextlit(h);
}

char equallits(l1,l2)  /* returns 1 if litlists l1, l2 are same, else 0 */
lit *l1, *l2;
{
  lit *temp1, *temp2;
  for (temp1=l1, temp2=l2;  temp1 && temp2;
       temp1=nextlit(temp1), temp2=nextlit(temp2)) {
    if (polarity(temp1) != polarity(temp2)) return 0;
    if (litname(temp1) != litname(temp2)) return 0;
    if (compareterms(lterms(temp1),lterms(temp2))) return 0;
  }
  return temp1 || temp2 ? 0 : 1;
}

void auxiliarize(t,d)  /* decrement the variable names in termlist t by d */
term *t;
char d;
{
  while (t) {
    if (isvar(termname(t))) termname(t) = (char *) termname(t) - d;
    else auxiliarize(tterms(t),d);
    t = nextterm(t);
  }
}

void replacevar(vn,rt,t)  /* replace the variable named vn by the term rt */
char *vn;                 /* wherever it occurs in the termlist t         */
term *rt, *t;
{
  while (t) {
    if (termname(t) == vn) {
      termname(t) = termname(rt);
      tterms(t) = copyterms(tterms(rt));
    } else replacevar(vn,rt,tterms(t));
    t = nextterm(t);
  }
}

void substitute(s,t)  /* apply the substitution s to the termlist t */
term *s, *t;
{
  term *ss;
  /*    v- assignment! */
  if (ss=s) do {
    ss = nextterm(ss);
    replacevar(termname(ss),tterms(ss),t);
  } while (ss != s);
}

char occursin(n,t)  /* returns 1 if name n occurs in termlist t, else 0 */
char *n;
term *t;
{
  return t ? termname(t) == n
             || occursin(n,tterms(t))
             || occursin(n,nextterm(t))
           : 0;
}

term *unify(t1,t2)  /* returns tail of substitution to be made, whose next */
term *t1, *t2;      /* pointer points to head; or unifail if failed        */
{
  term *s, *ss, *temp;
  if (!t1) return t2 ? unifail : NULL;
  if (!t2) return unifail;
  if (!tterms(t1) && !tterms(t2) && termname(t1) == termname(t2)) s = NULL;
  else if (isvar(termname(t1)))
    if (occursin(termname(t1),tterms(t2))) return unifail;
    else {
      s = newterm(termname(t1),NULL,copyoneterm(t2,NULL));
      nextterm(s) = s;
    }
  else if (isvar(termname(t2)))
    if (occursin(termname(t2),tterms(t1))) return unifail;
    else {
      s = newterm(termname(t2),NULL,copyoneterm(t1,NULL));
      nextterm(s) = s;
    }
  else if (termname(t1) != termname(t2)) return unifail;
  else s = unify(tterms(t1),tterms(t2));
  if (s == unifail) return unifail;
  substitute(s,nextterm(t1));
  substitute(s,nextterm(t2));
  ss = unify(nextterm(t1),nextterm(t2));
  if (ss == unifail) {
    if (s) {
      term *temp;
      temp = nextterm(s);
      nextterm(s) = NULL;
      freeterms(temp);
    }
    return unifail;
  }
  if (!s) return ss;
  if (!ss) return s;
  temp = nextterm(s);
  nextterm(s) = nextterm(ss);
  nextterm(ss) = temp;
  if (0) {
    printf("\nresult of unify %d:\n\t",ss);
    print_subs(ss);
    printf("\n");
  }
  return ss;
}

char grandfather(r,c)  /* returns 1 if rule r is in    */
clause *r, *c;         /* ancestry of clause c, else 0 */
{
  do if (father(c) == r) return 1;
  while (c=mother(c));
  /*      ^- assignment! */
  return 0;
}


/* char sametheory(c1,c2,k)  /* returns 1 if clauses c1 and c2 have the same  */
/* clause *c1, *c2, *k;      /* rules from list k in their ancestries, else 0 */
/* {
/*   while (k && isdefrul(k)) {
/*     if (grandfather(k,c1)) {
/*       if (!grandfather(k,c2)) return 0;
/*     } else if (grandfather(k,c2)) return 0;
/*     k = nextclause(k);
/*   }
/*   return 1;
/* }
/**/

char sametheory(c1,c2,k)  /* returns 1 if clauses c1 and c2 have the same  */
clause *c1, *c2, *k;      /* rules from list k in their ancestries, else 0 */
{
  clause *c;
  c = c1;
  while (c) {
    if (father(c) && isdefrul(father(c)) && !grandfather(father(c),c2))
      return 0;
    c = mother(c);
  }
  c = c2;
  while (c) {
    if (father(c) && isdefrul(father(c)) && !grandfather(father(c),c1))
      return 0;
    c = mother(c);
  }
  return 1;
}

void freesubst(s)  /* frees the substitution s, given */
term *s;           /* in tail-of-circular-list form   */
{
  if (s) {
    term *temp;
    temp = nextterm(s);
    nextterm(s) = NULL;
    freeterms(temp);
  }
}

/* Rewrite resolve!  It's a mess! */
/* Use subroutines!               */
clause *resolve(m,f,ah)  /* returns pointer to nil clause  */
clause *m, *f;           /* if one is generated, else NULL */
argheader *ah;
{
  lit *ml, *fl, *tl, *rl;
  term *terms1, *terms2, *subst, *subst2;
  int n;
  --attemptlimit(ah);
  if (0) {
    if (isknowledge(m)||isdefrul(m)||isknowledge(f)||isdefrul(f)) printf("*"); else {
    printf("\n");
    printknow(0,"father: ",f,NULL);
    printknow(0,"mother: ",m,NULL);
    printf("\n");
    }
  }
  for (ml=lits(m); ml; ml=nextlit(ml))
    for (fl=lits(f); fl; fl=nextlit(fl)) {
      if ((polarity(ml) && !polarity(fl) || !polarity(ml) && polarity(fl))
          && litname(ml) == litname(fl)) {
        auxiliarize(terms1=copyterms(lterms(ml)),1);
        auxiliarize(terms2=copyterms(lterms(fl)),2);
        subst = unify(terms1,terms2);
        freeterms(terms1);
        freeterms(terms2);
        if (succeeded(subst)) {
	  if (0) {
	    printf(" ");
	    printterms_r(subst,NULL); 
	    printf(" ");
	  }
          rl = NULL;
          n = 0;
          for (tl=lits(m); tl; tl=nextlit(tl))
            if (tl != ml) {
              rl = copylit(tl,rl);
              origin(rl) = FromMom;
              ++n;
              auxiliarize(lterms(rl),1);
            }
          for (tl=lits(f); tl; tl=nextlit(tl))
            if (tl != fl) {
              rl = copylit(tl,rl);
              origin(rl) = FromDad;
              ++n;
              auxiliarize(lterms(rl),2);
            }
          if (isdefrul(f)) {
            rl = copylit(nonunilit(f),rl);
            origin(rl) = FromDad;
            ++n;
            auxiliarize(lterms(rl),2);
          }
          if (n > LITLIMIT) {
            freelits(rl);
            freesubst(subst);
            return NULL;
          }
          for (tl=rl; tl; tl=nextlit(tl)) substitute(subst,lterms(tl));
          /*     v- assignment! */
          if ((rl=evalnameq(sortlits(rl))) == truth) freesubst(subst);
          else {
            subst = catsubst(subst, deauxlsubst(rl));
            if (unique(ah)) {
              clause *tc;
/*            if (isdefrul(f)) {              /* no, do this always */
                clause dummy, *d = &dummy;
                for (tc=goals(ah); tc; tc=nextclause(tc))
                  if (equallits(rl,lits(tc))) {
                    mother(d) = m;
                    father(d) = f;
                    if (sametheory(tc,d,knowledge(ah))) {
                      freelits(rl);
                      freesubst(subst);
                      return NULL;
                    }
                  }
/*            } else {                        /* never do this */
/*              clause *lasthm;
/*              tc = lasthm = prevhm(head(m));
/*              do {
/*                if (equallits(rl,lits(tc))) {
/*                  freelits(rl);
/*                  freesubst(subst);
/*                  return NULL;
/*                }
/*                tc = prevhm(tc);
/*              } while (tc != lasthm);
/*            }                               /**/
            }
            --successlimit(ah);
            if (attemptlimit(ah) > 0) attemptlimit(ah) += ABONUS;
            if (PRINTSEARCH) printf(".");
            lastg(ah) = nextclause(lastg(ah)) =
              newclause(NULL,m,f,head(m),prevhm(head(m)),rl,subst);
	    if (PRINTCLAUSES) 
	      printclause(1,1,"*",lastg(ah),substitution(lastg(ah)),1);
            if (isdefrul(f)) head(lastg(ah)) = prevhm(lastg(ah)) = lastg(ah);
            else prevhm(head(m)) = lastg(ah);
            if (!rl) return lastg(ah);
          }
        }
      }
  }
  return NULL;
}

clause *getnextarg(ah)  /* returns pointer to nil clause of next  */
argheader *ah;          /* argument, or NULL if no argument found */
{
  clause *m, *f, *c=NULL;
  m = lastm(ah);
  f = lastf(ah);
  if (f)
    if (isknowledge(f)) goto r1;  /* never, NEVER use goto!!! -AMC */
    else goto r2;
  while (m) {
    f = knowledge(ah);
    while (f) {
      if (!attemptlimit(ah) || !successlimit(ah)) goto found;
      if (c=resolve(m,f,ah)) goto found;
      /*   ^- assignment!  */
r1:   f = nextclause(f);
    }
    f = m;
r2: if (ALLOWCASES) while (f != head(m)) {
      f = prevhm(f);
      if (!attemptlimit(ah) || !successlimit(ah)) goto found;
      if (c=resolve(m,f,ah)) goto found;
      /*   ^- assignment!  */
    }
    m = nextclause(m);
  }
  return lastm(ah) = lastf(ah) = NULL;
found:
  if (0) if (!attemptlimit(ah)) printf("attemptlimit reached\n");
  if (0) if (!successlimit(ah)) printf("successlimit reached\n");
  lastm(ah) = m;
  lastf(ah) = f;
  if (PRINTSEARCH) printf(c ? "!" : "\\");
  return c;
}

#define samerul(x,y) (lits(x) == lits(y) && nonunilit(x) == nonunilit(y))

argheader **placetheory(newrules,origrules,pths)
clause *newrules, *origrules;     /* returns address of pointer    */
argheader **pths;                 /* in theory-tree *pths where newrules   */
{                                 /* belongs or NULL if it's already there */
  clause *np, *op, *tp;
  while (*pths) {
    for (np = newrules,  op = origrules,  tp = knowledge(*pths);
         ;
         op = nextclause(op)) {
      if (!op  ||  !isdefrul(op)  ||
          !np && (!tp || !isdefrul(tp))) return NULL;
      if (!np  ||  (tp && samerul(op,tp)) && !samerul(op,np)) {
        pths = &left(*pths);
        break;
      }
      if (!tp  ||  !isdefrul(tp)  ||  !samerul(op,tp) && samerul(op,np)) {
        pths = &right(*pths);
        break;
      }
      if (samerul(op,np)) {
        np = nextclause(np);
        tp = nextclause(tp);
      }
    }
  }
  return pths;
}

argheader *getnexttheory(invest)
theoryheader *invest;
{
  clause *a, dummy, *h, *t, *g, *r;
  argheader **place;
  if (!arglimit(invest) || !thlimit(invest)) {
    if (0) printf("arglimit %d or theory limit %d reached\n",
      arglimit(invest), thlimit(invest));
    return NULL;
  }
  /*      v- assignment! */
  while (a=getnextarg(generator(invest))) {
    h = t = &dummy;
    nextclause(t) = NULL;
    --arglimit(invest);
/*  if (head(a) == goals(generator(invest))) continue; */
/*  The above line would disallow the theory containing no rules, which  */
/*  is less- or equi-specific to any other theory.  What should be done? */
    for (r = rules(invest);  r != contingent(invest);  r = nextclause(r))
      if (grandfather(r,a)) t = nextclause(t) = copyoneclause(r,NULL);
    /*       v- assignment! */
    if (place=placetheory(nextclause(h),rules(invest),&theories(invest))) {
      nextclause(t) = otherev(invest);
      g = copyoneclause(goals(invest),NULL);
      return *place = newargheader(nextclause(h),g,g,NULL,g,a,NULL,NULL,
                                   ALIMIT,SLIMIT,1,NULL);
    }
    freeclauses(nextclause(h));
  }
  return NULL;
}


void printwff(w)  /* prints a wff - ASM  */
wff* w;
{
  if (0) printf("		printwff %d\n",w);
  if (!w)
    printf("(NULL)");
  else
  switch(kindof(w))
  {
    case NULLkind:
      printf("(null)");
      break;
    case ANDkind:
      printf("(");
      printwff(ante(w));
      printf(" ^ ");
      printwff(succ(w));
      printf(")");
      break;
    case ORkind:
      printf("(");
      printwff(ante(w));
      printf(" v ");
      printwff(succ(w));
      printf(")");
      break;
    case FORALLkind:
      printf("All %s ", wffname(w));
      printf("(");
      printwff(succ(w));
      printf(")");
      break;
    case EXISTSkind:
      printf("Exists %s ", wffname(w));
      printf("(");
      printwff(succ(w));
      printf(")");
      break;
    case NOTkind:
      printf("~");
      printf("(");
      printwff(succ(w));
      printf(")");
      break;
    case FUNCTkind:
      if (*((char *) wffname(w)) == NULL) printf("?"); /* RPL 91693 */
      else printf("%s", wffname(w));
      if (succ(w) != NULL) {
	printf("(");
	printwff(succ(w));
	printf(")");
      }
      break;
    case ARGkind:
      if (ante(w) != NULL)
	printwff(ante(w));
      if (succ(w) != NULL) {
	printf(",");
	printwff(succ(w));
      }
      break;
    default:
      printf("bogus wff type=%d", kindof(w));
  }
  fflush(stdout);
}


void printnotwff(w)  /* Prints negation of w. */
wff *w;
{
  wff *nw;

  nw = reducenot(not(copywff(w)));
  printwff(nw);
  freewff(nw);
}


void print_wffrule(w)  /* prints a wff rule  -  ASM */
wffrule *w;
{
  printf("R ");
  if (wffrulevar(w)) {
    printwff(wffrulevar(w));
    printf(" ");
  }
  printwff(wffruleant(w));
  printf("  >-  ");
  printwff(wffrulecon(w));
  if (0) {
    printf(" [ ");
    printwff(wffruleantname(w));
    printf(" >- ");
    printwff(wffruleconname(w));
    printf(" ]");
  }
  if (wffruletop1(w)) printf(" top1 ");
  if (wffruletop2(w)) printf(" top2 ");
  if (wffruleuse(w)) printf(" use\n");
	      else   printf(" skip\n");
}

void print_wffrulelist(w)  /* prints a list of wff rules  -  ASM */
wffrule *w;
{
wffrule *i;
  i = w;
  for (; i; i=nextwffrule(i))
    print_wffrule(i);
}

void print_wfflist(w)  /* prints a wff list  -  ASM */
wfflist *w;
{
wfflist *i;
  i = w;
  for (; i; i=nextwff(i))
  {
    if (0) printf("%d",i);
    printwff(thewff(i));
    if (wffflag(i) == NECEVflag) printf("   necev");
    if (wffflag(i) == CONTEVflag) printf("   contev");
    printf("\n");
    if (i == nextwff(i)) break; /* RPL */
    if (i == nextwff(nextwff(i))) break; /* RPL */
  }
}

void print_wffpack(w)  /* prints a wff pack  -  ASM */
wffpack *w;
{
  printf("RULES:\n");
  print_wffrulelist(wffrules(w));
  printf("KNOWLEDGE:\n");
  print_wfflist(wffknow(w));
  if (wffactivator(w)) {
    printf("ACTIVATOR:\n");
    printwff(wffactivator(w));
    printf("\n");
  }
  printf("GOAL:\n");
  printwff(wffgoal(w));
  printf("\n");
}


void printterms(t,subs)  /* print terms in termlist t */
term *t, *subs;
{
term *tt, *t2;
  for (tt=t; tt; tt=nextterm(tt)) {
    printf("%s",termname(tt));
    if (0) if (subs) {
      t2 = copyterms(tt);
      auxiliarize(t2,2);
      substitute(subs,t2);
      printf("["); print_subs(subs); printf("|");
      printterms(t2,NULL); printf("]");
      
    }
    if (tterms(tt)) {
      printf("(");
      printterms(tterms(tt),NULL);
      printf(")");
    }
    if (nextterm(tt)) printf(",");
  }
}

void printterms_r(t,subs)  /* print terms in termlist t */
term *t, *subs;
{
term *tt, *t2;
  for (tt=t; tt; tt=nextterm(tt)) {
    printf("%s",termname(tt));
    if (0) if (subs) {
      t2 = copyterms(tt);
      auxiliarize(t2,2);
      substitute(subs,t2);
      printf("["); print_subs(subs); printf("|");
      printterms(t2,NULL); printf("]");
      
    }
    if (tterms(tt)) {
      printf("(");
      printterms(tterms(tt),NULL);
      printf(")");
    }
    if (tt==nextterm(tt)) break;
    if (nextterm(tt)) printf(",");
  }
}

void print_subs(s)  /* print the substitution s  - ASM */
term *s;
{
term *ss;
  /*    v- assignment! */
  if (ss=s) do {
    ss = nextterm(ss);
    /* printf("%s/%s",termname(ss),termname(tterms(ss))); */
    printf("%s/",termname(ss)); 
    printterms_r(tterms(ss));
    printf(" ");  /* AMC */
  } while (ss != s);
}

void printlits(p,op,ls,subs)  /* print lits in litlist ls separated by    */
char p, *op;             /* string op with inverted polarity iff p=0 */
lit *ls;
term *subs;
{
lit *tl;
  for (tl=ls; tl; tl=nextlit(tl)) {
    if (polarity(tl) && !p || !polarity(tl) && p) printf("~");
    printf("%s",litname(tl));
    if (lterms(tl)) {
      printf("(");
      printterms(lterms(tl),subs);
      printf(")");
    }
    if (nextlit(tl)) printf("%s",op);
  }
}

void printclause(p,n,s,c,subs,nl)  
			   /* print clause c indented n spaces prefixed by */
			   /* the string s, if p != 0, or not c if p == 0  */
char p, nl;                    
int n; 
char *s;
clause *c;
term *subs;
{
char *op;
  op = p ? " v " : " ^ ";
  while (n--) printf(" ");
  printf("%s",s);
  if (isdefrul(c)) {
    printlits(0,op,nonunilit(c),subs);  /* note that calling printclause with a */
    printf(" >- ");                /* rule c and p == 0 makes no sense     */
  }
  printlits(p,op,lits(c),subs);
  if (nl) printf("\n");
  fflush(stdout);
}

#define shortprintknow(n,s,c,subs) printclause(1,n,s,c,subs,0)
#define printgoal(n,s,c,subs) printclause(0,n,s,c,subs,1)
#define printgoalnnl(n,s,c,subs) printclause(0,n,s,c,subs,0) /* RPL */
#define justprint(c) printclause(1,0,"",c,substitution(c),1) /* RPL */

clause *shortprovehead(c,n)  /* print the proof of head(c) with an  */
clause *c;              /* indentation of n and return head(c) */
int n;
{
  if (father(c)) do {
    if (iscontev(father(c))) {
      shortprintknow(n," ",father(c),substitution(c));
    }
    if (isknowledge(father(c))) {
      c = mother(c);
    } else {
      if (iscontev(mother(c))) shortprintknow(n,"case 1 ",mother(c),NULL);
      else printf(" case 1 ");
      shortprovehead(mother(c), n+1);
      if (iscontev(father(c))) shortprintknow(n,"case 2 ",father(c),NULL);
      else printf(" case 2 ");
      c = shortprovehead(father(c), n+1);
    }
  }
  while (c != head(c));
  return c;
}

clause *provehead(c,n)  /* print the proof of head(c) with an  */
clause *c;              /* indentation of n and return head(c) */
int n;
{
  if (father(c)) do
    if (isknowledge(father(c))) {
      printknow(n,"know:  ",father(c),substitution(c));
      c = mother(c);
      printgoal(n,"so:    ",c,substitution(c));
    } else {
      printgoal(n,"case1: ",mother(c),NULL);
      provehead(mother(c), n+1);
      printgoal(n,"case2: ",father(c),NULL);
      c = provehead(father(c), n+1);
      printgoal(n,"so:    ",c,NULL);
    }
  while (c != head(c));
  return c;
}

void longprintev(c,n)  
		/* indent and print the argument whose nil clause is c */
clause *c;
int n;
{
  printf(": ");
  while (father(c)) c = shortprovehead(c,3*n);
  printf("\n");
}

void printev(c,n)  
clause *c;
int n;
{
  if (PRINTEV) longprintev(c,n); else printf("\n");
}

printarg(c)  /* print the argument whose nil clause is c */
clause *c;
{
  if (!c) {printf("bad arg"); return;};
  printf("\n");
  while (father(c)) 
  {
    c = provehead(c,0);
  fflush(stdout);
  }
}

void printclauselist(c)  /* RPL */
clause *c;
{
  while (c) {
    justprint(c);
    c = nextclause(c);
  }
}

void printargh(ah)  /* RPL */
argheader *ah;
{
  while (ah) {
    printclauselist(lastg(ah));
    ah = nextarg(ah);
  }
}

void printth(th)  /* RPL */
theoryheader *th;
{
  printargh(generator(th));
  printargh(theories(th));
}

void printwfflist(wl)  /* RPL */
wfflist *wl;
{
  while (wl) {
    printwff(thewff(wl));
    wl = nextwff(wl);
  }
}

char preturn(x)
int x;
{
printf("result is %d\n", x);
}

char samewff(w1, w2)  /* RPL  */
wff *w1, *w2;
{
  if (0) {
    printf("entering samewff with ");
    printwff(w1);
    printwff(w2);
    printf("\n");
  }
  if (w1 == NULL || w2 == NULL) return(w1 == w2);
  if (kindof(w1) != kindof(w2)) return(0);
  switch(kindof(w1))
  {
    case NULLkind:
      return(1);
      break;
    case ANDkind:
      return(samewff(ante(w1),ante(w2)) && samewff(succ(w1),succ(w2)));
      break;
    case ORkind:
      return(samewff(ante(w1),ante(w2)) && samewff(succ(w1),succ(w2)));
      break;
    case FORALLkind:
      return(samewff(succ(w1),succ(w2)));
      break;
    case EXISTSkind:
      return(samewff(succ(w1),succ(w2)));
      break;
    case NOTkind:
      return(samewff(succ(w1),succ(w2)));
      break;
    case FUNCTkind:
      return((wffname(w1) == wffname(w2)) && samewff(succ(w1),succ(w2)));
      break;
    case ARGkind:
      if (ante(w1) == NULL || ante(w2) == NULL) {
	if (ante(w1) == ante(w2)) { 
	  if (0) printf("same\n");
	  return(1);
	}
	else {
	  if (0) printf("not same\n");
	  return(0);
	}
      }
      else if (!samewff(ante(w1), ante(w2))) return(0);
      if (succ(w1) != NULL && succ(w2) != NULL) {
	return(samewff(succ(w1),succ(w2)));
      }
      else {
	if (succ(w1) == succ(w2)) {
	  if (0) printf("same\n");
	  return(1);
	}
	else {
	  if (0) printf("not same\n");
	  return(0);
	}
      }
      break;
    default:
      printf("bogus wff type=%d", kindof(w1));
      exit(-1);
  }
}

char ispending(seek) /* RPL */
wff *seek;
{
targetlist *i;
  if (0) {
    printf("\n pending list is: \n");
    for (i=ppending; i; i=nexttarget(i)) printwff(targetwff(i));
    printf("\n");
  }
  for (i=ppending; i; i=nexttarget(i)) {
    if (samewff(targetwff(i), seek)) {
      return(1);
      }
    }
  return(0);
}

void printpending() /* RPL */
{
  targetlist *itarget, *i;
  printf("\n           pending list is: \n");
  for (i=ppending; i; i=nexttarget(i)) printwff(targetwff(i));
  printf("\n");
}

void poppending(oldplast) /* RPL */
targetlist *oldplast;
{
  targetlist *itarget;
  /* pop ppending list */
  if (0) {
    printf("          popping pending list:");
    printwff(targetwff(oldplast));
    printf("|");
    printf("\n");
  }
  plastpend = oldplast;
  nexttarget(plastpend) = NULL;
  /* should free what you've cut */
  if (0) printpending();
}

void pushpending(target) /* RPL */
wff *target;
{
targetlist *newp;
targetlist *i;
  if (0) {
    printf("          pushing target ");
    printwff(target);
    printf("\n");
  }
  if (ispending(target)) {
    if (0) printf("already pending!  returning.\n");
    return;
  }
  newp = newtl();
  targetwff(newp) = target;
  if (ppending == NULL) ppending = newp;
  else nexttarget(plastpend) = newp;
  plastpend = newp;
  if (0) printpending();
}

wff *make_wff_from_term(t) /* ASM */
term *t;
{
  term *tt;
  wff *newwff1=NULL, *newfunct, *newarg, *oldarg=NULL, *termargs;
  if (!t) return NULL;
  for (tt=t; tt; tt=nextterm(tt)) {
    termargs = make_wff_from_term(tterms(tt));
    newfunct = funct(termname(tt),termargs);
    newarg = arg(newfunct,NULL);
    if (!newwff1) newwff1 = newarg;
    if (oldarg)
      succ(oldarg) = newarg;
    oldarg = newarg;
  }
  return newwff1;
}

wff *make_wff_from_lit(l)  /* ASM */
lit *l;
{
  wff *newfunct, *newarg;
  if (nextlit(l)) printf("\n********* TOO MANY LITERALS IN GOAL *********\n");
  newarg = make_wff_from_term(lterms(l));
  newfunct = funct(litname(l),newarg);
  if (polarity(l))
    newfunct = not(newfunct);
  return newfunct;
}

void apply_subs_wff(w, vterm, rwff) /* ASM */
wff *w;
char *vterm;
wff *rwff;
/* given a wff, the name of a variable, and an replacement wff for that
   variable, this replaces all occurrences of the variable in the first wff
   with the replacement wff */
{
  if (0) {
    printf("name of variable is %s\n",vterm);
  }
  switch(kindof(w))
  {
    case ANDkind: case ORkind:
      apply_subs_wff(ante(w), vterm, rwff);
      apply_subs_wff(succ(w), vterm, rwff);
      break;
    case NOTkind:
      apply_subs_wff(succ(w), vterm, rwff);
      break;
    case FUNCTkind:
      if (0) printf("two are %s and %s",vterm,ante(w));
      if (vterm == ante(w)) {
	if (0) printf(" considered equal ");
	ante(w) = ante(ante(rwff)); 
	succ(w) = succ(ante(rwff));
      }
      else
	if (succ(w))
	  apply_subs_wff(succ(w), vterm, rwff);
      break;
    case ARGkind:
      if (ante(w))
	apply_subs_wff(ante(w), vterm, rwff);
      if (succ(w))
	apply_subs_wff(succ(w), vterm, rwff);
      break;
    default:
      printf("bogus subs wff type=%d", kindof(w));
  } 
}

void substitute_wff(w, subs) /* ASM */
wff *w;
term *subs;
/* this applies a term substitution to a wff */
{
  term *ss;
  wff *rwff;
  char *vterm;
  if (0) {
    printf("\napplying subs %d ",ss);
    printf("substitution is ");
    print_subs(subs);
    printf("\n");
  }
  if (ss=subs)
    do {
      ss = nextterm(ss);
      vterm = termname(ss);
   /* vterm = vterm+2; */    /* removed by AMC */
      rwff = make_wff_from_term(tterms(ss));
      if (0) {
        printf(" substitution as wff is ");
        printwff(rwff);
        printf("\n");
      }
      apply_subs_wff(w, vterm, rwff);
      if (0) {
        printf(" result wff is ");
        printwff(w);
        printf("\n");
      }
    } while (ss != subs);
}


void auxwff(w,d)  /* Decrement the variable name pointers in wff *w by d. */
wff *w;
int d;
{
  int ii;
  if (!w || kindof(w) == NULLkind) return;
  if ((kindof(w) == FUNCTkind || kindof(w) == FORALLkind ||
       kindof(w) == EXISTSkind
      ) && isvar(wffname(w)))
  {
    if (0) {
      for (ii=-5; ii<=5; ii++) printf("string %d: %s\n",(char *) wffname(w)+ii,(char *) wffname(w)+ii);
    }
    if (0) printf("auxwff org is %s, %d dec by %d\n",wffname(w),(char *) wffname(w), d); 

    wffname(w) = (char *) wffname(w) - d;

    if (0) printf("storing name %d, %s in %d\n",wffname(w),wffname(w),w);
  }
  auxwff(succ(w), d);
  if (binary(w) || kindof(w) == ARGkind)
    auxwff(ante(w), d);
}

wfflist *catwfflist(wl1,wl2)  /* AMC */
wfflist *wl1, *wl2;
/* catwfflist(wl1,wl2) returns the concatenation of wl1 and wl2, where wl1,
   wl2, and the returned list are all in form described in ground_rule().
   catwfflist() does no copying; *wl1 and *wl2 are changed. */
{
  wfflist *whead;

  if (0) {
    printf("catting wfflists:");
    print_wfflist(wl1);
    printf("\n");
    print_wfflist(wl2);
  }

  if (!wl1) return wl2;
  if (!wl2) return wl1;

  whead = nextwff(wl1);
  nextwff(wl1) = nextwff(wl2);
  nextwffrule(wfflistrule(wl1)) = wfflistrule(nextwff(wl2));
  nextwff(wl2) = whead;
  nextwffrule(wfflistrule(wl2)) = wfflistrule(whead);

  return wl2;
}

void sub_rules(wl,s,d)  /* AMC */
/* Apply substitution s to rules in wl after auxiliarizing with decrement d.
   wl has the form described in ground_rule().  */
wfflist *wl;
term *s;
int d;
{
  wfflist *wp;
  wff *w1, *w2;

  if (0) { printf("entering sub rules with substitution: "); print_subs(s); }
  wp = wl;
  do {
    w1 = thewff(wp);
    auxwff(w1,d);
    w2 = cwff(wp);
    auxwff(w2,d);
    substitute_wff(w1,s);
    substitute_wff(w2,s);
    wp = nextwff(wp);
  } while (wp != wl);
}

wfflist *ground_rule(h,c)  /* AMC */
clause *h, *c;
/* h points to the head of a family.  c points to some descendent of h, not
   necessarily in the same family.  ground_rule(h,c) returns a list of wffs
   which result in grounding the father of h (which much be a defrul) as
   far down as c (unless father(h) is NULL, in which case NULL is returned).
   Because of cases, there may be more than one wff in the list.  Actually,
   the tail of the list points back at the head, and a pointer to the tail
   is returned.  The wfflistrule fields of the wfflist nodes are linked
   together exactly like the wfflist nodes are.  The wffruleant and
   wffrulecon fields of each wfflistrule are identical to the thewff and
   cwff fields of the corresponding wfflist node. */
{
  wfflist *wlist1, *wlist2, *temp12;
  wff *w1, *w2;
  wffrule *wr;

  if (0) {
    printf("grounding rule %d %d: ",h,c);
    justprint(h);
    printf("\n");
    justprint(c);
    printf("\n");
  }

  if (!father(h)) return NULL;

  if (h == c) {
    w1 = copywff(wffruleantname(clauserulewff(father(h))));
    auxwff(w1,2);
    w2 = copywff(wffruleconname(clauserulewff(father(h))));
    auxwff(w2,2);
    substitute_wff(w1, substitution(h));
    substitute_wff(w2, substitution(h));
    wlist1 = newwfflist(NULL, w1, w2);
    nextwff(wlist1) = wlist1;
    wfflistrule(wlist1) = wr =
      newwffrule(NULL,
        wffrulevar(clauserulewff(father(h))),
        w1,
        w2);
    nextwffrule(wr) = wr;
    if (0) {
      printf("a result of grounding is ");
      print_wfflist(wlist1);
      printf("\n");
    }
    return wlist1;
  }

  wlist1 = ground_rule(h, mother(c));
  /* sub_rules(wlist1, substitution(c), 1); /* ASM */
  sub_rules(wlist1, substitution(c), 0); /* RPL 91693 */

  if (isknowledge(father(c))) {
    if (0) {
      printf("b result of grounding is ");
      print_wfflist(wlist1);
      printf("\n");
    }
    return wlist1;
  }

  wlist2 = ground_rule(h, father(c));
  sub_rules(wlist2, substitution(c), 2);

  /* return catwfflist(wlist1,wlist2); */
  temp12 = catwfflist(wlist1,wlist2); 
  if (0) {
    printf("c result of grounding is ");
    print_wfflist(temp12);
    printf("\n");
  }
  return temp12;
}

wfflist *find_rule_wffs(c)  /* AMC */
clause *c;
/* c is a pointer to a clause in a clause-stack (probably a nil clause).
   find_rule_wffs(c) returns a list of all the instances of the rules used
   in the argument, grounded down as far as c.  The wfflistrule fields of
   the wfflist nodes are as described in ground_rule().  Unlike ground_rule(),
   find_rule_wffs() returns the head of a non-circular list. */
{
  clause *h;
  wfflist *wlist = NULL, *wtemp;

  h = c;
  while (h) {
    h = head(h);
    wlist = catwfflist(wlist, ground_rule(h,c));
    h = mother(h);
  }

  if (!wlist) return NULL;
  wtemp = nextwff(wlist);
  nextwffrule(wfflistrule(wlist)) = NULL;
  nextwff(wlist) = NULL;
  if (0) printf("find rule wffs returning:");
  if (0) print_wffrulelist(wtemp);
  return wtemp;
}

wfflist *asm_find_rule_wffs(c)  /* ASM */
clause *c;
/* given a pointer to the nilclause of an argheader, this constructs a list
   of the defeasible rules used in the argument.  We want this as a list
   of wffs, so we use the clauserulewff pointer of the clauses to retrieve 
   the wffs that the rule came from.  The substitution associated with the
   current clause is applied to the antecedent of the rule, which is then
   stored as thewff in the wff list being constructed.  The wfflistrule
   pointer of the wfflist structure is used to point to the original
   wffrule structure the rule came from. */
{
  wfflist *wlist1=NULL, *wlist2=NULL;
  wffrule *lastrule=NULL;
  wff *w1, *w2;
  while (father(c)) {
    do
      if (isknowledge(father(c))) {
	if (isdefrul(father(c))) {
	  w1 = copywff(wffruleantname(clauserulewff(father(c))));
	  w2 = copywff(wffruleconname(clauserulewff(father(c))));
	  substitute_wff(w1, substitution(c));
	  substitute_wff(w2, substitution(c));
          if (0) {
            printf(" result wffs are ");
            printwff(w1);
            printf(" ");
            printwff(w2);
            printf("\n");
          }
	  if (wlist2) lastrule=wfflistrule(wlist2);
	  wlist2 = newwfflist(wlist2, w1, w2);
	  /* wfflistrule(wlist2) = clauserulewff(father(c)); */
	  wfflistrule(wlist2) = 
	    newwffrule(lastrule,
	      wffrulevar(clauserulewff(father(c))),
	      w1,
	      w2);
	  /* RPL */
	  if (0) {
            printf(" wfflistrule is \n");
	    print_wffrule(wfflistrule(wlist2));
	  }
	  if (!wlist1) wlist1 = wlist2;
	  if (0) {
            printf(" wffrulelist is now\n");
	    print_wffrulelist(wfflistrule(wlist1));
	  }
	} 
	c = mother(c);
      } while (c != head(c));
  }
  return wlist1;
}

int indent(n)  /* RPL */
int n;
{
  for (; n>0; n--) printf("   ");
  return(1);
}

void re_enable_rules(wpack) /* RPL */
wffpack *wpack;
{
  wffrule *wrules;
  for (wrules=wffrules(wpack); wrules; wrules=nextwffrule(wrules)) {
    wffruleuse(wrules) = TRUE; 
    if (0) printf("re-enabling use of %d ",wrules);
  }
}

wffrule *find_top_rules(rulelist, wpack, for1, for2) /* ASM */ /*RPL */
wfflist *rulelist;
wffpack *wpack;
char for1, for2;
{
  theoryheader th, *invest=&th;
  wff *realgoal=wffgoal(wpack);
  wfflist *curlistmem, *lastlistmem=NULL, *lm1, *lm2; 
  wffrule *currule, *currule1, *currule2, *newlast, *lastrule, *saverules;
  char maybe_top;
  if (PRINTTOP) printf("FINDING TOP RULES\n"); 
  /* RPL */
  saverules=currule=lastrule=wffrules(wpack);
  while(currule) {
    if (for1) wffruletop1(currule) = FALSE;
    else wffruletop2(currule) = FALSE;
    wffruleuse(currule) = FALSE;
    if (0) {
      printf("marking %d no: ",currule);
      print_wffrule(currule);
    }
    lastrule=currule;
    currule=nextwffrule(currule);
  }
  if (PRINTTOP) printf("POSSIBLE RULES:\n"); 
  /* mark rules used in argument as useable */
  curlistmem=rulelist;
  while (curlistmem) {
    wffruleuse(wfflistrule(curlistmem)) = TRUE;
    if (0) printf("marking %d yes: ",curlistmem);
    if (PRINTTOP) print_wffrule(wfflistrule(curlistmem));
    lastlistmem=curlistmem;
    curlistmem=nextwff(curlistmem);
  }

  /* suture rulelist onto wffrules of wpack and return new wffrules RPL */
  if (lastlistmem) {
    /* nextwffrule(wfflistrule(lastlistmem))=wffrules(wpack); */
    wffrules(wpack)=wfflistrule(rulelist); 
  }
  if (0) print_wffpack(wpack);

  for (lm1=rulelist; lm1; lm1=nextwff(lm1)) { 
    currule1=wfflistrule(lm1);
    wffruleuse(currule1) = FALSE;
    if (0 && PRINTTOP) {
      printf("CANDIDATE TOP RULE:\n"); print_wffrule(currule1); 
    }
    maybe_top = TRUE;
    for (lm2=rulelist; lm2; lm2=nextwff(lm2)) { 
      currule2=wfflistrule(lm2);
      wffgoal(wpack)=wffruleant(currule2);
      if (0 && PRINTTOP) { printf("* TESTING "); printwff(wffgoal(wpack)); }
      translatewffs(wpack,invest,unnegated,usecontyes,outputno);
      if (!getnexttheory(invest)) {
	if (0 && PRINTTOP) printf(" # no argument\n");
	maybe_top = FALSE;
	break;
      }
      else if (0 && PRINTTOP) printf(" # argument found\n");
    }
    if (maybe_top) {
      if (for1) wffruletop1(currule1) = TRUE;
      else wffruletop2(currule1) = TRUE;
      }
    wffruleuse(currule1) = TRUE;
  }
  for (currule=wffrules(wpack); currule; currule=nextwffrule(currule)) 
    wffruleuse(currule) = TRUE;
  if (PRINTTOP) printf("\nTOP RULES:\n");
  for (currule=wffrules(wpack); currule; currule=nextwffrule(currule)) 
    if ((wffruletop1(currule) && for1) || (wffruletop2(currule) && for2)) 
      if (PRINTTOP) print_wffrule(currule);
  if (PRINTTOP) printf("END OF TOP RULES\n"); 

  wffgoal(wpack) = realgoal;
  wffrules(wpack) = saverules;
  re_enable_rules(wpack);

  /* nextwffrule(wfflistrule(lastlistmem))=NULL; */
  /* clip off the wffrules(wpack) so they no longer hang on */
  if (rulelist) return(wfflistrule(rulelist));
  else return(NULL);
}

wff *make_activator(wrules, for1, for2)	/* ASM */ /* RPL */
wffrule *wrules;
char for1, for2;
{
  wffrule *cur;
  wff *act=NULL;
  for (cur=wrules; cur; cur=nextwffrule(cur)) {
    if (0) 
      printf("act check for top at %d, ok=%d ",
	cur,wffruletop1(cur)+wffruletop2(cur));
    if ((wffruletop1(cur) && for1) || wffruletop2(cur) && for2)
      if (act)
	act = and(act,copywff(wffruleant(cur)));
      else
	act = copywff(wffruleant(cur));
    }
  return act;
}


void enable_rules(wpack, rlist1, rlist2) /* ASM */
wffpack *wpack;
wfflist *rlist1, *rlist2;
{
  wffrule *wrules;
  for (wrules=wffrules(wpack); wrules; wrules=nextwffrule(wrules)) {
    wffruleuse(wrules) = FALSE; 
    if (0) printf("zeroing use of %d ",wrules);
    }
  for (; rlist1; rlist1=nextwff(rlist1)) {
    wffruleuse(wfflistrule(rlist1)) = TRUE;
    if (0) printf("setting1 use of %d ",rlist1);
    }
  for (; rlist2; rlist2=nextwff(rlist2)) {
    wffruleuse(wfflistrule(rlist2)) = TRUE;
    if (0) printf("setting2 use of %d ",rlist2);
    }
}

char does_activate(wpack, act, pol)  /* RPL */
wffpack *wpack;
wff *act;
char pol;
{
  theoryheader th, *invest=&th;
  argheader *theory;
  wffactivator(wpack) = act;
  if (0) printf("trying activation with wffpack:\n");
  if (0) print_wffpack(wpack); 
  translatewffs(wpack, invest, pol, usecontno, outputno);
  if (0) printwff(wffgoal(wpack));
  theory = getnexttheory(invest);
  if (theory) {
    if (0) printf("activation as follows:");
    if (0) printarg(nilclause(theory),0); 
    if (0) print_wffpack(wpack); 
    return TRUE;
  } 
  else
    return FALSE;
}

char asymmetric_activator(wpack, act, pol)  /* ASM */
wffpack *wpack;
wff *act;
char pol;
{
  theoryheader th1, *invest1=&th1;
  theoryheader th2, *invest2=&th2;
  argheader *theory1, *theory2;
  wffactivator(wpack) = act;
  if (0) print_wffpack(wpack); 
  translatewffs(wpack, invest1, pol, usecontno, outputno);
  if (0) printwff(wffgoal(wpack));
  theory1 = getnexttheory(invest1);
  if (theory1) {
    if (0) printarg(nilclause(theory1),0); 
    if (0) print_wffpack(wpack); 
    translatewffs(wpack, invest2, !pol, usecontno, outputno);
    if (0) printwff(wffgoal(wpack));
    theory2 = getnexttheory(invest2);
    if (theory2)
      return FALSE;
    else
      return TRUE;
  } 
  else
    return FALSE;
}

char *negpl(x)
int x;
{
  if (x) return("A"); else return("B");
}

char *pl(x)
int x;
{
  if (x) return("B"); else return("A");
}

argheader *get_one_arg(theory, invest, m, x, pwff) /* ASM */
argheader *theory;
theoryheader *invest;
wff *pwff;
int m, x;
{
  argheader *temptheory;
  if (theory) {
    if (nextarg(theory))
      temptheory = nextarg(theory);
    else {
      temptheory = getnexttheory(invest);
      if (temptheory) {
	nextarg(theory) = temptheory;
	argnumber(temptheory)=argnumber(theory) + (argnumber(theory)>0 ? 1 : -1);
      }
    }
    if (temptheory) {
      if (PRINTPROG && indent(m)) {
	printf("trying next %s argument", pl(x));
        printev(nilclause(temptheory),m); 
      }
    }
    else
      if (PRINTPROG && indent(m)) 
	printf("no more arguments for %s\n", pl(x));
  } 
  else {
    temptheory = getnexttheory(invest);
    if (temptheory) {
      if (PRINTPROG && indent(m)) {
	printf("%s has an argument for ", pl(x));
	printwff(reducenot(pwff));
        printev(nilclause(temptheory),m); 
      }
    } else {
      if (PRINTPROG && indent(m)) {
	printf("%s has no argument for ", pl(x));
	printwff(reducenot(pwff));
        printf("\n");
	/*
	printgoal(0, "",
	  lastg(generator(invest)),substitution(lastg(generator(invest))));
	*/
      }
    }
  } 
  return temptheory;
}

int check_spec(theory1, theory2, wpack, n, m, x)  /* ASM */
argheader *theory1, *theory2;
wffpack *wpack;
int n, m, x;
{
  wfflist *rlist1, *rlist2;
  wffrule *toprules1, *toprules2, *saverules, *temp, *last;
  wff *act1, *act2;
  char act1act2, act2act1;

  last = NULL;

  if (PRINTPROG && indent(m))
    printf("\n************ round %d ************\n", n);
  if (PRINTPROG && indent(m)) 
    printf("%s's ARGUMENT:  (%d)", pl(x), argnumber(theory1));
  if (PRINTARGS) printarg(nilclause(theory1),m); 
  if (PRINTPROG && indent(m)) 
    printf("%s's ARGUMENT:  (%d)", negpl(x), argnumber(theory2));
  if (PRINTARGS) printarg(nilclause(theory2),m); 
  if (argstatus(theory1)==DEFEATEDstatus) {
    if (PRINTPROG && indent(m)) printf("already argued; %s won\n", pl(x));
    return -1;
  }
  if (argstatus(theory2)==DEFEATEDstatus) {
    if (PRINTPROG && indent(m)) printf("already argued; %s won\n", x);
    return 1;
  }

  saverules = wffrules(wpack);
  /* save rules because rlist1 and rlist2 get sutured on temporarily */

  if (PRINTPROG && indent(m))
    printf("\n");
  if (!argactivator(theory1)) {
    if (PRINTTOP) printf("%s TOP RULES:\n", pl(x));
    toprules1 = toprules(theory1);
    /* rlist1 = find_rule_wffs(nilclause(theory1)); */
    /* creates destroyable copies of rules */
    /* toprules1 = find_top_rules(rlist1,wpack,for1yes,for2no); */
    if (PRINTTOP) print_wffrulelist(toprules1);
    argactivator(theory1) = make_activator(toprules1,for1yes,for2no);
  } 
  rlist1 = thrulelist(theory1);
  if (!argactivator(theory2)) {
    if (PRINTTOP) printf("%s TOP RULES:\n", negpl(x));
    toprules2 = toprules(theory2);
    /* rlist2 = find_rule_wffs(nilclause(theory2)); */
    /* creates destroyable copies of rules */
    /* toprules2 = find_top_rules(rlist2,wpack,for1no,for2yes); */
    if (PRINTTOP) print_wffrulelist(toprules2);
    argactivator(theory2) = make_activator(toprules2,for1no,for2yes);
  }
  rlist2 = thrulelist(theory2);

  if (rlist1) {
    wffrules(wpack)=wfflistrule(rlist1);
    last=temp=wfflistrule(rlist1);
    if (temp) while(temp=nextwffrule(temp)) last=temp;
  }
  if (rlist2) {
    if (last) nextwffrule(last)=wfflistrule(rlist2);
    else wffrules(wpack)=wfflistrule(rlist2);
  }

  act1 = argactivator(theory1);
  act2 = argactivator(theory2);

  if (PRINTPROG && indent(m)) {
    printf("%s ACTIVATOR: ", pl(x)); printwff(act1); printf("\n");
  }
  if (PRINTPROG && indent(m)) {
    printf("%s ACTIVATOR: ", negpl(x)); printwff(act2); printf("\n");
  }

  if (act1) act1act2 = does_activate(wpack, act1, negated);
  if (act2) act2act1 = does_activate(wpack, act2, unnegated);

  /* this is complicated because NULL means no defeasible rules,
  so the counterarg SHOULDN'T EVEN BE an arg in competition! */
  /* to have both as NULL means that the input is deductively
  inconsistent! */

  if (!act1 && !act2) { act1act2 = TRUE; act2act1 = TRUE; }
  else if (act1 && !act2) { act1act2 = FALSE; act2act1 = TRUE; }
  else if (!act1 && act2) { act1act2 = TRUE; act2act1 = FALSE; }

  if (0) printf("act1act2 %d act2act1 %d\n",act1act2,act2act1);

  if (last) nextwffrule(last)=NULL;
  wffrules(wpack) = saverules;
  /* restore rules for exit RPL */

  if (act1act2 && !act2act1) {
    if (PRINTPROG && indent(m)) 
      printf("%s's ARGUMENT IS MORE SPECIFIC\n", pl(x));
    argstatus(theory2) = DEFEATEDstatus;
    return 1;
  } else if (!act1act2 && act2act1) {
    if (PRINTPROG && indent(m)) 
      printf("%s's ARGUMENT IS MORE SPECIFIC\n", negpl(x));
    argstatus(theory1) = DEFEATEDstatus;
    lastcheckedarg(theory1) = theory2;
    return -1;
  } else {
    if (PRINTPROG && indent(m)) printf("INCONCLUSIVE\n");
    argstatus(theory1) = INTERFEREDstatus;
    argstatus(theory2) = INTERFEREDstatus;
    return 0;
  }
}

int ok_subargs_for_counter(target_theory, wpack, defonly, m, x, pol, for1, for2)  
			/* RPL */
argheader *target_theory;
wffpack *wpack;
int pol, m, x;
char for1, for2;
/* defonly is 1 for ok w.r.t. defeating counterargs, 
   0 for o.k. w.r.t interfering counterargs (harder) */ 
/* returns 1 if no subarg is defeated by live counterarg */
{
  theoryheader th, *invest=&th;
  theoryheader th2, *invest2=&th2; 
  wfflist *intermed_list;
  targetlist *tl1 = NULL, *nexttl, *trash, *oldplastpend, *oldplastpend2;
  wff *pretgt, *posttgt, *curtgt, *savegoal=copywff(wffgoal(wpack));
  int result=0;
  if (PRINTPROG && indent(m)) {
    printf("%s is CHECKING SUBARGUMENTS", negpl(x));
    if (defonly) printf(" to defeat");
    else printf(" to block");
    printf(" %s's establishment of ", pl(x)); 
    if (pol) printnotwff(wffgoal(wpack));
    else printwff(wffgoal(wpack));
    printf("\n");
  }
  thrulelist(target_theory)=
    intermed_list=find_rule_wffs(nilclause(target_theory));
  /* creates destroyable copies of rules */

  /* call top rules so you don't target top rule's consequent RPL */
  toprules(target_theory)=find_top_rules(intermed_list,wpack,for1,for2);

  if (PRINTTGTS) {
    indent(m); printf("TARGETS:");
  }

  oldplastpend = plastpend;

  /* push negation as pending so you don't try top arg 
  if (pol) pushpending(wffgoal(wpack));
  else pushpending(reducenot(not(copywff(wffgoal(wpack)))));
  */

  while (intermed_list) {
    pretgt = checkforall(cwff(intermed_list));
    curtgt = reducenot(not(copywff(pretgt)));
    if (!(0 && wffruletop1(wfflistrule(intermed_list)) && for1) 
      && !(0 && wffruletop2(wfflistrule(intermed_list)) && for2) ) {
      if (PRINTTGTS) { 
	if (0) printf("%d",cwff(intermed_list));
	if (0) printf("kind is %d",kindof(cwff(intermed_list)));
        printf("  "); printwff(cwff(intermed_list)); printf("  "); }
      if (tl1 == NULL) {
	tl1 = newtl();
	nexttl = tl1;
	nexttarget(tl1) = NULL;
	}
      else {
        nexttarget(nexttl) = newtl();
	nexttl = nexttarget(nexttl);
      }
      targetwff(nexttl) = curtgt;
      nexttarget(nexttl) = NULL;
    }
    intermed_list = nextwff(intermed_list);
  }
  /* should free intermed_list */

  if (PRINTTGTS) {
    if (!tl1) printf("  no targets");
    printf("\n");
  }
  while (tl1) {
    curtgt = targetwff(tl1);
    posttgt = reducenot(not(copywff(curtgt)));
    if (pol) {
      if (samewff(curtgt, wffgoal(wpack))) {
	if (0 && PRINTTGTS && indent(m)) printf("target is not subarg:  next target\n");
        trash = tl1;
        tl1 = nexttarget(tl1);
        freeonetl(trash);
	continue;
      }
    } else {
      if (samewff(curtgt, reducenot(not(copywff(wffgoal(wpack)))))) {
	if (0 && PRINTTGTS && indent(m)) printf("target is not subarg:  next target\n");
        trash = tl1;
        tl1 = nexttarget(tl1);
        freeonetl(trash);
	continue;
      }
    }
    if (PRINTTGTS && indent(m)) { 
      printf("NEW GOAL for %s:  ", negpl(x));
      printwff(curtgt); printf("\n"); 
      }
    oldplastpend2 = plastpend;
    pushpending(posttgt);
    wffgoal(wpack) = curtgt;
    translatewffs(wpack,invest,unnegated,usecontyes,outputno); 
    translatewffs(wpack,invest2,negated,usecontyes,outputno);
    result = establish(invest,invest2,wpack,m,1-x,defonly);
    if (result) break; /* counterarg is established */
    trash = tl1;
    tl1 = nexttarget(tl1);
    freeonetl(trash);
    poppending(oldplastpend2);
  }

  wffgoal(wpack) = savegoal;

  if (PRINTPROG && indent(m)) {
    if (!result) {
      printf("%s ALLOWS %s's subarguments for ", negpl(x), pl(x));
      if (pol) printnotwff(savegoal);
      else printwff(savegoal);
      printf("\n");
    }
    else {
      printf("%s DISALLOWS %s's subarguments for ", negpl(x), pl(x));
      if (pol) printnotwff(savegoal);
      else printwff(savegoal);
      printf("\n");
    }
  }

  poppending(oldplastpend);

  return(1-result);
}


int establish(invest1, invest2, wpack, m, x, support)  
				/* RPL */
theoryheader *invest1, *invest2;
wffpack *wpack;
int m, x;
{
  argheader *theory1, *theory2, *theory1head, *theory2head;
  targetlist *oldplastpend, *old2plastpend;
  wff *wtemp;
  int n=0, result, ok1=0, ok2=0;
  if (ispending(wffgoal(wpack))) {
    if (PRINTPROG && indent(m)) {
    printwff(wffgoal(wpack));
    printf(" already pending: %s backtracks\n",pl(x));
    }
    return(0);
  }
  if (PRINTPROG && indent(m)) {
    printf("%s is ESTABLISHING ", pl(x)); printwff(wffgoal(wpack));
    if (support) printf(" for support"); else printf(" for viability");
    printf("\n");
  }
  if (0) printpending();

  /* init'ing of pending should be done in first call to dispute */
  /* push wffgoal(wpack) onto ppending list */

  oldplastpend = plastpend;
  pushpending(wffgoal(wpack));

  if (0) print_wffpack(wpack);
  theory1 = 
    get_one_arg(theory1, invest1, m, x, wffgoal(wpack));
  theory1head = theory1;
  if (theory1) argnumber(theory1) = 1;
  while (theory1) {
    if (ok1=ok_subargs_for_counter(theory1,wpack,1-support,
    m+1,x,unnegated,for1yes,for2no)) {

      if (PRINTPROG && indent(m+1)) {
        printf("%s CHECKING FOR TOP-LEVEL COUNTERARGS to ", negpl(x));
        printwff(wffgoal(wpack));
        printf("\n");
      }

      wtemp = not(copywff(wffgoal(wpack)));
      if (ispending(wtemp)) {
	theory2 = NULL;
        if (PRINTPROG && indent(m+1)) {
          printf("already pending:  %s backtracks\n", negpl(x));
        }
      }
      else {
        old2plastpend = plastpend;
        pushpending(wtemp);
        theory2 = get_one_arg(theory2,invest2,m+1,1-x,wtemp);
        theory2head = theory2;
      }

      if (theory2) argnumber(theory2)  -1;
      while (theory2) {
	if (ok2=ok_subargs_for_counter(theory2,wpack,vsDEFEATERS,
        m+2,1-x,negated,for1no,for2yes)) {
          result = check_spec(theory1,theory2,wpack,++n,m,x);
          if (support) {
	    if (result != 1) break; /* get another theory1 */
          } else if (result == -1) break;
	}
        if (PRINTPROG && indent(m)) {
	  printf("%s seeks another argument against ", negpl(x));
          printwff(wffgoal(wpack));
	  printf("\n");
        }
        theory2 = 
	  get_one_arg(theory2,invest2,m,1-x,not(copywff(wffgoal(wpack))));
      }
      if (!theory2) break;
    }
    if (PRINTPROG && indent(m)) {
      printf("%s seeks another argument for ",pl(x));
      printwff(wffgoal(wpack));
      printf("\n");
    }
    theory1 = get_one_arg(theory1,invest1,m,x,wffgoal(wpack));
    theory2 = theory2head;
  }

  poppending(oldplastpend);

  if (theory1 && ok1) ok1 = 1; else ok1 = 0;
  if (theory2 && ok2) ok2 = 1; else ok2 = 0;
  if (ok1 && !ok2) {
    if (PRINTPROG && indent(m)) {
      printf("%s ESTABLISHED ", pl(x)); 
      printwff(wffgoal(wpack));
      if (support) printf(" for support"); else printf(" for viability");
      printf("\n");
    };
    if ((PRINTSUPPORTED && support) || PRINTVIABLES) {
      printwff(wffgoal(wpack));
      printf("\n");
      }
    return(1);
  }
  else {
    if (PRINTPROG && indent(m)) {
      printf("%s FAILED TO ESTABLISH ", pl(x));
      printwff(wffgoal(wpack));
      if (support) printf(" for support"); else printf(" for viability");
      printf("\n");
    };
    return(0);
  }
}

int dispute(invest1, invest2, wpack, m)  /* ASM */
theoryheader *invest1, *invest2;
wffpack *wpack;
int m;
{
argheader *theory1=NULL, *theory2=NULL, *theory1head, *theory2head;
int n=0, result, ok1=0, ok2=0;
  if (PRINTPROG && indent(m)) {
    printf("DISPUTING "); printwff(maingoal);
    printf("\n");
  }

  /* set up list of pending targets */
  plastpend = NULL;
  ppending = NULL;

  pushpending(wffgoal(wpack));
  pushpending(copywff(notmaingoal));

  if (PRINTPROG && indent(m)) {
    printf("\n%s tries to support:  ", pl(0));
    printwff(maingoal);
    printf("\n\n");
  }
  theory1 = get_one_arg(theory1,invest1,m,xpro,wffgoal(wpack));
  theory1head = theory1;
  if (theory1) argnumber(theory1) = 1;
  theory2 = get_one_arg(theory2,invest2,m,xcon,not(copywff(wffgoal(wpack))));
  theory2head = theory2;
  if (theory2) argnumber(theory2) = -1;

  while (theory1) {
    ok1 = ok_subargs_for_counter(theory1,wpack,vsINTERFERERS,m+1,xpro,unnegated,for1yes,for2no);
    if (ok1) {
      while (theory2) {
	ok2 = ok_subargs_for_counter(theory2,wpack,vsDEFEATERS,m+2,xcon,negated,for1no,for2yes);
	if (ok2) {
          result = check_spec(theory1,theory2,wpack,++n,m,xpro);
          if (result != 1) break; /* get another theory1 */
	}
        theory2 = get_one_arg(theory2,invest2,m,xcon,not(copywff(wffgoal(wpack))));
      }
      if (!theory2) break;
    }
    theory1 = get_one_arg(theory1,invest1,m,xpro,wffgoal(wpack));
    theory2 = theory2head;
  }
  if (ok1 && theory1) {
    if (PRINTPROG && indent(m)) {
      printf("%s WINS ", pl(xpro)); 
      printwff(maingoal); printf("\n");
    };
    if (PRINTSUPPORTED) {
      printwff(maingoal);
      printf("\n");
      }
    return(1);
  }
  if (!theory1 || !ok1) {
    if (PRINTPROG && indent(m)) {
      printf("%s exhausts arguments for: ",pl(0));
      printwff(maingoal);
      printf("\n");
      printf("\n%s tries to support: ",pl(1));
      printwff(notmaingoal);
      printf("\n\n");
    }

    if (0) printf("resetting ppending list!\n");
    plastpend = NULL;
    ppending = NULL;

    pushpending(wffgoal(wpack));
    pushpending(copywff(notmaingoal));

    theory2 = theory2head;
    while (theory2) {
      ok2 = ok_subargs_for_counter(theory2,wpack,vsINTERFERERS,m+1,xcon,negated,for1no,for2yes);
      if (ok2) {
        if (argstatus(theory2) == 0) {
	  theory1 = theory1head;
	  while (theory1) {
	    ok1 = ok_subargs_for_counter(theory1,wpack,vsDEFEATERS,m+2,xpro,unnegated,for1yes,for2no);
	    if (ok1) {
	      result = check_spec(theory1,theory2,wpack,++n,m,xcon);
	      if (result != -1) break; /* get another theory2 */ 
	    }
	    theory1 = get_one_arg(theory1,invest1,m,xpro,wffgoal(wpack));
	  }
	  if (!theory1) break;
        }
        else 
	  if (PRINTPROG && indent(m)) 
	    printf("already countered  (argument %d)\n", argnumber(theory2));
      }
      theory2 = get_one_arg(theory2,invest2,m,xcon,not(copywff(wffgoal(wpack))));
    }
    if (theory1 && ok1 && PRINTPROG && indent(m)) {
      printf("B exhausts arguments for: ");
      printwff(notmaingoal);
      printf("\n");
    }
  }
  if (theory1 && ok1) ok1 = 1; else ok1 = 0;
  if (theory2 && ok2) ok2 = 1; else ok2 = 0;
  if (!ok1 && ok2) {
    if (PRINTPROG && indent(m)) {
      printf("%s WINS ", pl(xcon));
      printwff(notmaingoal); printf("\n");
    };
    if (PRINTSUPPORTED) {
      printwff(notmaingoal);
      printf("\n");
      }
    return(-1);
    }
  else {
    if (PRINTPROG && indent(m)) {
      printf("NO WINNER FOR ");
      printwff(maingoal); printf("\n");
    };
    return(0);
    }
}

#define CLOCKS_PER_SEC 1000000
void saycputime()
{
    fprintf(stdout, "%lf seconds\n", ((double) clock())/((double) CLOCKS_PER_SEC));
}

/*
Eugene Nathan Johnson, c. 1944 - 1984.

	Gene Johnson was systems administrator at Industry Data Services, Inc.,
	Honolulu, Hawaii, where five Loui brothers held their first
	computer industry jobs.  Gene buffered me from management so that
	I could explore chess-playing, horse-racing, language translation, and
	dialogue-engaging programs unrelated to the accounting databases
	that the company supported.  He was a major influence in my choice
	of artificial intelligence as a subject of graduate study.  Gene
	was diagnosed to have lung cancer and died soon thereafter,
	seeking the spiritual comfort of folk remedies from his Hawaiian
	ancestry.  He did not live to see me complete the doctorate
	he helped me pursue.

	Gene loved Maui, adventure games, and good people.  He hated COBOL.
	He was a racer of a stripped-down '67 Camaro, an accomplised jazz
	bassist, and a world-class assembly language hacker.  He was never
	bitter about how time had transformed his Hawaiian island; he was an
	optimist about what the future of computer science had in store for
	us.  He wanted to get a Ph.D. in computer science, too.  He loved his
	birds, his home in Kailua, and his wife.

	As a computer scientist and as an adult, I see Gene Johnson as my
	mentor.  Gene introduced me to so many things, and was as successful
	getting me to discover the companionship of a good woman as the
	virtues of LR parsing and structured programming.  Nathan was Gene's
	password (which he changed after I guessed it).  I have waited a
	decade to write a program suitable to dedicate to his memory.  This is
	the program.

					R. P. L.
*/


int premain()  /* reads knowledge, goal from stdin and prints all theories */
{
  theoryheader th, *invest=&th;
  theoryheader th2, *invest2=&th2; 
  wffpack awffpack, *wpack=&awffpack;
  short res;

  if (PRINTTIME) clock();
  nameqname = makename("nameq");  /* AMC */

  if (PRINTPROG) printf("INPUT:\n");
  readwffs(wpack);
  if (0) print_wffpack(wpack);

  maingoal=copywff(wffgoal(wpack));
  notmaingoal=reducenot(not(copywff(wffgoal(wpack))));

  if (PRINTPROG && outputno) printf("NEW LITERALS:\n");
  translatewffs(wpack,invest,xpro,usecontyes,outputno); 
  translatewffs(wpack,invest2,xcon,usecontyes,outputno);
  if (0) printf("**********************************************************\n");

  res=dispute(invest,invest2,wpack,0);

  if (PRINTRESULT) printf("%d\n",res);
  if (PRINTTIME) saycputime();
  return 0;
}

static int parseargs(argc,argv)  /* parse the command-line arguments */
int argc; char **argv;           /* returns 0 if failed, 1 otherwise */
/*
  options are:
    -I seeinput
    -A PRINTARGS
    -T PRINTTOP
    -G PRINTTGTS
    -P PRINTPROG
    -M PRINTTIME
    -S PRINTSUPPORTED
    -V PRINTVIABLES
    -R PRINTRESULT
    -H PRINTSEARCH
    -C PRINTCLAUSES
    -L ALLOWCASES
    -s n SLIMIT
    -a n ALIMIT
    -b n ABONUS
    -l n LITLIMIT
*/
{
  char *pc;
  ++argv;
  while (*argv) {
    if (*(pc = *argv++) != '-') goto badarg;
    while (*++pc)
      if (*pc == 'I') seeinput=1-seeinput;
      else if (*pc == 'A') PRINTARGS=1-PRINTARGS;
      else if (*pc == 'E') PRINTEV=1-PRINTEV;
      else if (*pc == 'T') PRINTTOP=1-PRINTTOP;
      else if (*pc == 'G') PRINTTGTS=1-PRINTTGTS;
      else if (*pc == 'P') PRINTPROG=1-PRINTPROG;
      else if (*pc == 'M') PRINTTIME=1-PRINTTIME;
      else if (*pc == 'S') PRINTSUPPORTED=1-PRINTSUPPORTED;
      else if (*pc == 'V') PRINTVIABLES=1-PRINTVIABLES;
      else if (*pc == 'R') PRINTRESULT=1-PRINTRESULT;
      else if (*pc == 'H') PRINTSEARCH=1-PRINTSEARCH;
      else if (*pc == 'C') PRINTCLAUSES=1-PRINTCLAUSES;
      else if (*pc == 'L') ALLOWCASES=1-ALLOWCASES;
      else if (*pc == 'a') {
        if (!(*argv && sscanf(*argv++, "%d", &ALIMIT))) goto badarg;
      } 
      else if (*pc == 's') {
        if (!(*argv && sscanf(*argv++, "%d", &SLIMIT))) goto badarg;
      } 
      else if (*pc == 'b') {
        if (!(*argv && sscanf(*argv++, "%d", &ABONUS))) goto badarg;
      } 
      else if (*pc == 'l') {
        if (!(*argv && sscanf(*argv++, "%d", &LITLIMIT))) goto badarg;
      } 
      else {
badarg:
        fprintf(stderr, "Bad arguments.\n");
        printf("options are:\n%s -ICATGPMSVRHasbl\n",argv[0]);
        return 0;
      }
  }
  return 1;
}

int main(argc,argv) 
int argc; char **argv;
{
  if (!parseargs(argc,argv)) return -1;
  premain();
  return 0;
}

