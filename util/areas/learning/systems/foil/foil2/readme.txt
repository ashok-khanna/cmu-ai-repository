/******************************************************************************

FOIL.2.1
------

	Summary of changes from FOIL.1:
	-------------------
	* arbitrary number of constants
	* arbitrary constant names
	* incorporation of types and keys
	* modified calculation of encoding length
	* option to prohibit negated literals
	* some more risk-free pruning
	* determinate literals


This is moderately rough implementation of FOIL intended for experimental use
only.  Please mail bugs etc to quinlan@cs.su.oz.au.

Input to the program consists of three sections:

	* specification of types
	  blank line
	* extensional definitions of relations
	  blank line				|  these are
	* test cases for learned definitions	|  optional

Each type specification consists of the type name followed by a colon, then a
series of constants separated by commas and terminated with a period.  A type
definition can occupy several lines and the same constant can appear in several
types.  If the type is ordered or partially ordered, the constants should be
arranged so that no constant appears before a "smaller" constant.

Constants consist of any string of characters with the exception that any
occurrence of certain delimiter characters (left and right parenthesis, period,
comma, semicolon) must be prefixed by the escape character "\".

The type definitions are followed by a set of relations, each specified by tuples
of constants that are in or out of the relation.  If only "in" tuples are
given, all other constant tuples of the correct types are taken to be "out".
The program will then attempt to find definitions for all relations other
than those whose name starts with '*'.

Each relation is defined by a header and one or two sets of constant tuples.
The header is either

    name(type, type, ... , type)
or
    name(type, type, ... , type) key/key/.../key

The ith type is the type of the ith constant in each tuple.  If they appear,
the keys limit the ways the relation may be used.  Each key consists of a
string of characters, one for each type.  The character '#' indicates that
the corresponding argument in a literal must be bound; the character '-'
indicates that the argument can be bound or unbound.  Each key thus gives
a permissible way of accessing the relation.  If no keys appear, all possible
combinations of bound and unbound arguments are allowed.

Following the header line are a series of lines containing constant tuples, as

    in tuple
    in tuple
      . . .
    ;
    out tuple
    out tuple
      . . .
    .

Each tuple consists of constants separated by commas and must appear on a
single line.  The section from ';' to the last out tuple may be omitted, in
which case all constant tuples other than those specified as in are taken to
be out.

Example:  the input for the "list" problem is

    Thing: a,b,d,e,f,e \. f,[],[a],[d],[[a] d],[b [a] d].

    list(Thing)
    []
    [a]
    [b [a] d]
    [[a] d]
    [d]
    .
    *null(Thing)
    []
    .
    *components(Thing, Thing, Thing) #--/-##
    [a], a, []
    [b [a] d], b, [[a] d]
    [[a] d], [a], [d]
    [d], d, []
    e \. f, e, f
    .

Here the type name is "Thing", and the tuples contain constants like
"[b [a] d]" and "e . f".  The keys "#--/-##" for *components indicates that,
if a literal *components(X,Y,Z) appears in a clause, the variable X must be
bound, or both Y and Z must be bound (i.e. we can find the components of a
given list, or produce a list from its components).  Since all relations
other than "list" have names starting with an asterisk, the program will
attempt to find a definition only for "list".

An alternative input for the relation "list" might be

    Thing: a,b,d,e,f,e \. f,[],[a],[d],[[a] d],[b [a] d].

    list(Thing)
    []
    [a]
    [b [a] d]
    [[a] d]
    [d]
    ;
    a
    b
    f
    [e \. f]
    .

This time we have said that a, b, f, and [e . f] are not lists, but we have
left the question open for d and e.

After all relations have been processed, the learned definitions can be
tested if desired.  The additional input consists of

	a blank line (indicating start of tests)
	relation name
	test tuples
	.
	relation name
	test tuples
	.
	  and so on

Each test tuple consists of a constant tuple followd by ':+' if the tuple
should be in the relation, ':-' if not.  Each test tuple that is handled
incorrectly by the definition is printed, along with the number of such
errors for that relation.  [**NB**: the definition interpreter is extremely
simple; right-hand sides of the clauses are checked with reference to the
given tuples, not to the definitions of the relations that may have been
learned.]

This version of FOIL is intended for use in situations for which there may
not be a perfect definition of the target relations.  It uses encoding-length
heuristics to restrict definitions to what can be justified by the data
available.  It is also possible for clauses to be inexact, i.e. to cover
non-"in" tuples.  FOIL prints a warning message if the clauses it finds are
not a perfect definition of the relation.

FOIL.2 incorporates a primitive back-up facility.  When there are several
possible next literals that have approximately equal gain, the system
will set a checkpoint.  If the current attempt to find a useful clause
fails and there is a remaining checkpoint, the system will recover to that
point and go on with the alternative literal.  The checkpoints are ranked
so recovery is not necessarily to the most recent checkpoint.  There are
limits on the maximum number of alternatives to any one literal and on
the maximum number of saved checkpoints.

FOIL.2 includes post-processing of clauses (to remove unnecessary literals)
and of clause sets (to remove redundant clauses).

Unlike FOIL.1, this version uses information about types in two ways.  First,
when a training set is being prepared using the closed-world assumption, only
tuples that satisfy the type constraints of the target relation are included.
Secondly, it finds which types are "compatible" (i.e. have at least one value
in common) and does not consider literals that, through incompatibility of
types, could never be useful.  Both these factors influence the calculation
of encoding length mentioned above.

One recent addition is the automatic inclusion of "determinate" literals.
A literal L is determinate if it introduces at least one new variable and,
for each + tuple in the current training set, there is exactly one binding
of these new variables that satisfies the literal.  All determinate literals
are automatically added to a clause unless there is a literal with very
high gain (default: 80% of the maximum possible gain).  Since there is
exactly one binding in each case, the inclusion of determinate literals
does not increase the size of the training set, and unnecessary literals
are removed during post-processing.  The idea for determinate literals
came from "determinate terms" in Stephen Muggleton's GOLEM system, and
their effect is to give FOIL a kind of look-ahead; using them, FOIL has
been able to find some very complex definitions (including quicksort).
If you aren't impressed by determinate literals, they can be turned off
by setting g to 0 (see parameters below).

FOIL.2 has one option and several parameters that can be set on the command
line.  Apart from negated literals and verbosity (see below), you should not
have to worry about these as the default values should be adequate.  They are
NOT intended to customize the system for a particular problem (which I regard
as cheating).

	-n	Negative literals are not considered.  This may be useful in
		domains where negated literals wouldn't make sense, or if
		learned definitions must be Horn clauses.

	-vX	Set verbosity to X [0, 1, 2 or 3; default 1]
		The program produces rather voluminous trace output controlled
		by this variable.  The default value of 1 gives a fair
		amount of detail; 0 produces very little output; 2 gives
		a blow-by-blow account of what the system is doing;
		3 gives details of tuples in training sets etc.

	-aX	Minimum accuracy of any clause is X% [default 80%]
		FOIL will not accept any clause with an accuracy lower
		than this.

	-fX	Any alternative literal must have at least X% of the gain
		of the best literal [default 80%].  This parameter thus defines
		what is meant by two literals having "roughly equal" gain.

	-lX	Maximum of X of alternatives to any one literal [default 5].
		This limits the amount of backup from any one point.  As
		the default value indicates, I don't intend there to be
		many such.

	-tX	Maximum of X checkpoints at any one time [default 20].
		This limit seems to be unnecessary (there are seldom many
		saved backup points), but I left it in anyway.

	-gX	Determinate literals art automatically included, unless
		there is a literal which has at least X% of the maximum
		possible gain.  (The maximum possible gain is achieved
		by a literal that is satisfied by all + tuples, but no
		- tuples, in the current training set.)  Obviously, if
		X is zero, no determinate literals are included unless
		there are no other literals.

The order of options doesn't matter.  Options are given in the usual Unix
way, e.g. "foil2 -v0 <infile >outfile".

Building the system
-------------------

A Unix makefile is provided.  To produce an executable version of the system
in the file "foil2", type "make foil2".

Final note
----------

I'd appreciate hearing of any sucesseses or, better still, failures that
you might have.  Copies of input files that you prepare are always welcome!

*****************************************************************************/
