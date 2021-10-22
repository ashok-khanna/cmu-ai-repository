june.cs.washington.edu:~ftp/pub/constraints/SkyBlue/sky-blue.lisp is the
current version of the SkyBlue constraint solver code, which extends
DeltaBlue with support for multi-output methods and better behavior when
encountering cycles.  For more information on the algorithm, including
pseudocode, see the tech report TR 92-07-02, available in
june.cs.washington.edu:~ftp/tr/1992/07/UW-CSE-92-07-02.PS.Z.  Send any
questions or comments to sannella@cs.washington.edu.

10/12/93 changes:

Two new entry functions that are not in the tech report:

(change-constraint-strength cn strength)
Changes the strength of a cn that is already within the graph, modifying
the graph and propagating walkabout strengths as needed.  If a constraint
is not in the graph, its strength can simply be changed by calling
(setf (CN-strength) cn), without calling this function.

(execute-constraints cns)
Takes a list of cns in the graph, and executes their selected
methods, and any downstream methods.  This can be used to cause input
constraints to be executed.

10/20/93 changes:

added comment to example function linear-eqn-cycle-solver.

2/22/94 changes:

The strength :required has been changed to :max, and :weakest has been
changed to :min.  For backwards compatibility, the strength :required will
be accepted as a synonym for :max, and :weakest will be accepted instead of
:min.  The variables *max-strength* and *min-strength* are exported.  For
backwards compatibility, *required-strength* and *weakest-strength* are
still defined.

Plans now include information on constraint cycles, and call cycle solvers
to solve cycles when the plan is executed (rather than automatically
invalidating all constraints in cycles).

Lots of internal changes, in particular the treatment of *exec-roots-stack*
and *undetermined-vars-stack* (previously named *redetermined-vars-stack*).

Cycle solvers may now return either (1) t (this solver solved this cycle),
(2) nil (this solver can't solve this cycle), or (3) :no-soln (this solver
can determine that this cycle has no solution).


