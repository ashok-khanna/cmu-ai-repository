-- TelosiS (Version 1.00-feeler) --

Note: This is just a feeler distribution to court comment from members of
      the EuLisp working group. If you're not a member of this select band
      of social outcasts then comment is still welcome but please
      bear in mind that this Telos contains features and restrictions 
      not yet agreed (or even discussed yet) by the working group so,
      if you find anything that appalls you, chances are it's down to 
      me alone and not a feature of EuLisp.

      For this reason also, this code is not yet intended to be widely
      and freely (in a devil-may-care sense) distributed so please do 
      not redistribute it yourself. Point interested parties at the 
      address given below for information and up to date versions.

Also: Credit and thanks to the authors of the two files included from
      Aubrey Jaffer's SLIB Scheme library.

-- Telos --

Telos is the reflective object system of both EuLisp and LeLisp V16.
It can be summarised as being a rationalised CLOS for a module-based
environment with simpler default functionality (general multiple
inheritance and before/after/under/over/etc method combination
are not provided) but including a powerful, standard meta-object
protocol supporting its portable extension. 

Note that, although its MOP can stand alone as it does here, Telos
is intended to be fully integrated into its host language, as it 
is in EuLisp and LeLisp V16, whose datatypes and operations may be 
specialised by applications.

-- TelosiS --

TelosiS is the result of an attempt to produce a simple but fully 
functional implementation of Telos' meta-object protocol in Scheme,
the aim being to provide a reference implementation in a stable 
language, not far removed from EuLisp, that accurately represents
the current specification of the MOP.

The system's simplicity has been gained at the expense of run-time
efficiency but, together with a slightly unusual bootstrap sequence,
has yielded a clearer definition of Telos' behaviour in the style of a
well-structured Telos program. The lower-level boot code need not be 
suffered to read the MOP implementation.

Only token efforts at optimisation have been made so as to avoid 
obfuscating the code and these serve only to identify the structure 
of typical, high-performance implementations - a method lookup cache
abstraction is used in the generic dispatch code for example. 

-- Requirements --

Preferably a Scheme implementation with some kind of old-fangled macro
facility. Failing that, there is a generic version of the loader
supplied which uses its own (very dodgy) macro expander that's just
powerful enough to load the MOP and the examples safely and very
little else.

Currently, it is known to run under T in scheme mode (i.e. after
calling "(scheme-reset)"), xscheme, cscheme and also FEEL's Scheme
emulation module using local macro facilities. In addition, it runs
under scm using its own macro expander.

The files to load for each of these are:

	t		telosis.t (or telosis.t.c after compilation)
	xscheme		telosis.xscm
	cscheme		telosis.cscm
	feel		telosis.em (just (!> telosis) to load the module)

	scm		telosis.scm (loads the generic version)
	any scheme	telosis.generic

Speed-wise, T's favourite of these followed by scm and then xscheme.
Don't waste your time with cscheme - life's too short. 

Even T just makes things comfortable while experimenting - remember
that this implementation is _not_ designed to provide a practical object 
system for Scheme and succeeds in that admirably...

-- Where to Find It --

The latest version is available through anonymous ftp from 
ftp.bath.ac.uk:pub/eulisp.

-- Notes on Use --

Loading telosis.xxx will place you in a special read-eval-print loop.
If you've hooked into the built-in macro system, then there is nothing
crucial about this apart from the fact that it uses a friendlier 
generic output function - Telos defining forms can also be input at 
the standard Scheme prompt and loaded normally from files. If the
provided macro expander is being used, expressions must be evaluated
via EXPANDING-EVAL or loaded using EXPANDING-LOAD, although there
is no guarantee that it will expand all code correctly.

A few simple examples of Telos code live in the file: Examples.
A number of longer example applications can be found in the 
Applications directory.

-- A Code Library --

A few examples of typical MOP applications are included with the
distribution. This will be extended over time and if you implement 
any interesting extensions that you'd like included, perhaps derived
from those already given (this is an OOPL we're talking about here
after all) - then by all means send them in.

-- Correspondence --

Questions, comments, suggestions, bug reports and interesting MOP 
extensions are all very welcome (although not necessarily in that 
order of preference) and can, currently, be e-mailed to the author 
at:

			 kjp@maths.bath.ac.uk

-- Keith --

