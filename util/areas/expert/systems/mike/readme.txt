MIKE (Micro Interpreter for Knowledge Engineering) is a full-featured,
free, and portable software environment designed for teaching purposes at
the UK's Open University.  It includes forward and backward chaining rules with
user-definable conflict resolution strategies, and a frame representation
language with inheritance and 'demons' (code triggered by frame access or
change), plus user-settable inheritance strategies.  Automatic 'how'
explanations (proof histories) are provided for rule exectuion, as are
user-specified 'why' explanations.  Coarse-grained and fine-grained rule
tracing facilities are provided, along with a novel 'rule graph' display
which concisely shows the history of rule execution.  MIKE, which forms the
kernel of an Open University course on Knowledge Engineering, is written in
a conservative and portable subset of Edinburgh-syntax Prolog, and is
distributed as non-copy-protected source code.

The above description applies to MIKEv1.50, which was formerly available
on a range of bulletin board and FTP servers.  This has been superseded
by two versions, which can be obtained by FTP as shown below:

   MIKEv2.03 (full Prolog source code version, incorporating a RETE
              algorithm for fast forward chaining, a truth maintenance
              system, uncertainty handling, and hypothetical worlds)

   MIKEv2.50 (turnkey DOS version with menu-driven interface and
              frame- and rule-browsing tools, fully compatible with
              MIKEv2.03, but no source code supplied)

The above versions are available by anonymous ftp from hcrl.open.ac.uk
[137.108.81.16] in the following files:

   MIKEv2.03: /pub/software/src/MIKEV2.03/*
   MIKEv2.50: /pub/software/pc/MIKEV25.ZIP

ADDITIONAL INFORMATION ABOUT MIKEv2.03 and MIKEv2.50
----------------------------------------------------
MIKEv2.03, a 1990 Prolog implementation of MIKE, contains the following
features:

1. RETE algorithm for fast forward chaining:  as described in part II
of Eisenstadt & Brayshaw's BYTE Magazine article (November 1990),
the rule selection algorithm in MIKE-1 is rather naive.  A fast indexing
algorithm incorporated in MIKE-2 only investigates rules which are relevant
to the most recent working memory or frame changes.  This provides significant
speedup of forward chaining rule execution: an order of magnitude or
more, depending on the size of your rule base.

2. Truth maintenance system (TMS): This keeps track of dependencies
among working memory assertions.  Derived conclusions stored in working
memory can be thought of as a house of cards (they depend on earlier
conclusions, which in turn depend on earlier ones, etc.).  Retracting
any assertion might cause the house of cards (or part of it) to crumble,
or may introduce inconsistencies.  The TMS handles all of the
bookkeeping, and resolves inconsistencies automatically wherever
possible by providing new justifications for working memory assertions.
A 'justification browser' displays the tree of dependencies which
support particular conclusions.

3.  Uncertainty: antecedents and consequents of rules can now contain an
optional 'certainty factor'.  Certainty factors can be combined in a
user-specified manner.  Three options are built in: standard
probability, fuzzy sets, and Bayesian.

4.  Hypothetical worlds: For certain reasoning and planning problems, it
is advantageous to be able to conduct alternative lines of reasoning in
separate working memories.  MIKE-2 provides a 'hypothetical worlds'
mechanism which facilitates the exploration of 'what if' scenarios, and
enables the user to 'spawn' new worlds and subordinate ('child') worlds
of existing worlds, in which the assumptions which hold in the parent
world  are automatically passed along to the child world.  Inconsistent
or impossible worlds can be detected, and separate lines of reasoning
can be combined into a merged world.


MIKEv2.50, a 1991 MS-DOS-specific implementation, retains
compatibility with older versions of MIKE (v1.50 and 2.03) and adds
the following features:

-     MIKE status control panel
-     In-window working memory proof trees and frame/rule descriptions
-     File selector for loading knowledge bases
-     User accessible menu and window manipulation
-     Integrated editor
-     Ability to switch out to DOS from MIKE
-     '--More--' facility
-     System for handling run-time frame creation when RETE is enabled
-     Improved error handling
-     Improved rule and frame descriptions
-     User settable justification tree depth

