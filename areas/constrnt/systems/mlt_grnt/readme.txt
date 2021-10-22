
Multi-Garnet is a package that implements multi-directional constraints
within Garnet.  When the Multi-Garnet package is loaded into Garnet, the
normal Garnet constraint system (formulas, etc) is still accessible.  In
addition it is possible to create multi-way constraints relating slot
values.  Each constraint is defined by a set of methods, where each method
contains a Lisp form to propagate values in a different direction.  The
constraints are organized into a hierarchy of different strength
constraints, where stronger constraints can override weaker constraints.
For an overview of multi-way hierarchical constraints, see the article "An
Incremental Constraint Solver" by Freeman-Benson, Maloney and Borning in
Communications of the ACM, January 1990 (v33, n1, pp54-63).

The Multi-Garnet package is available by anonymous ftp to
june.cs.washington.edu (128.95.1.4), cd pub/constraints/multi-garnet.  This
directory contains the following:

pub/constraints/multi-garnet/UW-CSE-92-07-01.PS.Z

  This file is a compressed Postscript file containing a 50-page tech report
  on Multi-Garnet.  This report includes an overview of the system and a
  reference manual.

pub/constraints/multi-garnet/v2.1

  This directory contains the code for Multi-Garnet v2.1, as well as
  several example files containing commented code written using
  Multi-Garnet.  Multi-Garnet v2.1 has been tested under Garnet v2.0 and
  v2.1 and Franz Allegro Common Lisp version 4.1.  It may require small
  changes to run under other versions of Lisp.  It will not work with other
  versions of Garnet.  Eventually other versions will be created to work
  with newer versions of Garnet.

pub/constraints/multi-garnet/v2.2

  This directory contains the code for Multi-Garnet v2.2.  Multi-Garnet
  v2.2 has been tested under Garnet v2.2 and Franz Allegro Common Lisp
  version 4.1.

  Changes:

  Based on the latest SkyBlue code, which is much faster than the version
  included in Multi-Garnet v2.1.

  The strength :required has been changed to :max.  For backwards
  compatibility, the strength :required will be accepted as a synonym for
  :max.

  The default value for *unsatisfied-max-constraint-warning* (formally
  ...-required-...) has been changed from t to nil, so Multi-Garnet will not
  warn of max-max constraint conflicts.

  new function (mg:change-constraint-strength cn strength) to change the
  strength of a constraint.

  new variable mg:*s-value-bad-schema-action* controls what happens if
  s-value is called on an object that is not a schema.  If the value is nil
  (the default), the call to s-value is a noop.  If the value is :print, a
  warning message is printed.  If the value is :break, a continuable error
  occurs.



Important note: Multi-Garnet is not an official part of the Garnet project.
The Garnet maintainers are not responsible for maintaining this package.
Any bug reports on Multi-Garnet should be sent to Michael Sannella
(sannella@cs.washington.edu), not the garnet mailing lists.

Any comments on the Multi-Garnet system would be welcome.

  ~~ Michael Sannella

