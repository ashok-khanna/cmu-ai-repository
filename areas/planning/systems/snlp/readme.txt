These files contain the code for the planner SNLP.
SNLP is a domain independent systematic nonlinear planner that is both
complete and sound.

The design of this planner was influenced by the paper "Systematic
Nonlinear Planning" by D. McAllester and D.  Rosenblitt (to appear in
AAAI-91).  It was created for comparing linear and nonlinear
planning in the paper "Partial Order Planning: Evaluating Possible
Efficiency Gains" by A. Barrett and D. Weld (University of Washington
CSE TR 92-05-01).

The best way to explain the planner is through an example.  Planning
domains are defined using a STRIPS like notation.  An example domain
for the blocks world would be defined by the following routine.

   (defun blocks-world-domain ()
     ;; purge old domain prior to defining a new domain
     (plan-utils:reset-domain)
   
     ;; Define step for putting a block on the table.
     (plan-utils:defstep :action '(newtower ?x)
              :precond  '((on ?X ?Z) (clear ?X))
              :add '((on ?X Table) (clear ?Z))
              :dele'((on ?X ?Z))
              :equals '((not (?X ?Z)) (not (?X Table)) (not (?Z Table))))

     ;; Define step for placing one block on another.
     (plan-utils:defstep :action '(puton ?X ?Y)
              :precond '((on ?X ?Z) (clear ?X) (clear ?Y))
              :add   '((on ?X ?Y) (clear ?Z))
              :dele  '((on ?X ?Z) (clear ?Y))
              :equals '((not (?X ?Y)) (not (?X ?Z)) (not (?Y ?Z))
                       (not (?X Table)) (not (?Y Table)))))

The only difference between a DEFSTEP and a STRIPS action revolves
around the :equals entry.  This entry defines extra constraints on the
variables involving equalities and inequalities.

Once a domain is defined a problem can be defined by two lists,
representing a set of conjunctive initial conditions and goal
conditions respectively.  For example,

   (defun sussman-anomaly ()
     (snlp:plan '((on C A) (on A Table) (on B Table) (clear C) (clear B))
                '((on A B) (on B C))))

Calling these four functions one after the other gives the following
output:

  USER(27): (snlp-sussman-anomaly)
  #SNLP-Plan<S=3; O=0; U=0>
  #Stats:<cpu time = 400      >

Setting the flag PLAN-UTILS:*VERBOSE* to T results in the following:

  USER(33): (snlp-sussman-anomaly)


  Initial  : ((ON C A) (ON A TABLE) (ON B TABLE) (CLEAR C) (CLEAR B))

  Step 1   : (NEWTOWER C)      Created 2 
  Step 2   : (PUTON B C)       Created 3 
  Step 3   : (PUTON A B)       Created 1 

  Goal     : ((ON A B) (ON B C))
  Complete!


  POCL (Init = 5  ; Goals = 2 ) => Win  (3 steps)     CPU 300      
       Nodes (V = 28  ; Q = 30  ; C = 87  )           Branch 2.0714285 
       Working Unifies: 342                           Bindings added: 211

Notice that the planner returns two values, a plan and a statistics
object.  Both of these structures have customized print methods that
cause the outputs shown above.

Special flag variables:

  PLAN-UTILS:*SEARCH-LIMIT* - Limit on the numbers of plans that the planner
                              will produce when attempting to solve a problem.
                              (used to avoid infinite loops).

  PLAN-UTILS:*VERBOSE*      - T to print out the entire plan and stats object
                              NIL for short form (default)

Other options:

  There are two keyword parameters to SNLP:plan.  They are:

    :search-fun - The search function used by SNLP.  Defaults to best first
                  search.  There is also the option of using Stuart Russell's
                  call-ie search function (see plan-utils.lisp).  
                  Other user suplied search functions can also be used.
    :rank-fun   - A heuristic function for guiding the planner's search.
                  There are many options provided in section 4 of file
                  snlp.lisp.