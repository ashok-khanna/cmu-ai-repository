A LEFT-CORNER BOTTOM UP PARSER WITH FEATURES

The directory contains a bottom-up chart parser as described in Chapters 3 and 4 
of Natural Language Understanding, 2nd edition. The algorithm is the same as 
that described  for the bottom-up parser in the first edition, but the way the 
system handles features differs from the first edition. Hopefully, the new 
format is self explanatory from these notes. The system can be loaded by
	(load "LoadParser")
from this directory. The appropriate lexicon and grammar can then be loaded
using the apporpriate file. E.G., (load "LoadChapter4") loads the grammars
and lexicon from Chapter 4.

The directory has two main subdirectories:
Parser:
   contains all the code for the system, including
     BUParser  -  the code for the bottom-up parsing algorithm
     Chart - the code for maintaining the chart
     FeatureHandling - the code that implements feature manipulation
     GrammarandLexicon - the code the defines the grammar and lexicon data 
                    structures, and the I/O routines
     GapFeatures - the code for handling gaps
              (not needed until Chapter 5)
     SemanticInterpreation - the extensions to support semantic interpretation
            (not needed until Chapter 9)
     Generator - a head-driven sentence realization algorithm
            (not needed until Chapter 9)

The rest of this file is basic documentation on the Parser

GRAMMATICAL RULES

The basic syntax for a grammatical rule is
	(<lhs constit> <rule id> <rhs constit 1> ... <rhs constit n>)
A constituent is specified in the form
	(<atomic category> (<feat1> <val1>) ... (<featn> <valn>))
Values may be atoms, other feature-value lists, or variables. A variable is 
can be written in several different forms:
        ?<atomic name> - an unconstrained variable (e.g., ?A)
	(? <atomic name>) - same as first version (e.g., (? A))
	(? <atomic name> <val1> ... <valn>) - a variable constrained to be one of 
                                    the indicated values (e.g., (? A 3s 3p))

Constituents on the left hand side may be designated as head constituents by 
enclosing them in a list with the first element being the atom HEAD.

For example, the following is the S rule
 	((s (agr ?a)) -1> (np (agr ?a)) (head (vp (agr ?a)))

This is rule has as its  left hand side an S with the AGR feature the variable 
?a, a rule identifier of "-1>", and two constituents on the right hand side: 
an NP and a VP, both with an AGR feature that must unify with the S AGR feature. 
The VP is the head feature.

GRAMMARS

A grammar is a list of rules, together with a prefix that indicates what input 
format is being used. The rules above are in what is called cat format, where 
the cat feature is not explicitly present. For example, here is a small grammar 
in CAT format.

(setq *testGrammar1*
  '(cat
    ((s (agr (? a))) 1 (np (agr (? a))) (vp (agr (? a))))
    ((np (agr (? a))) 2 (art (agr (? a))) (n (agr (? a))))
    ((vp (agr (? a)) (vform (? v))) 3 (v (agr (? a)) (vform (? v)) (subcat _none)))
    ((vp (agr (? a)) (vform (? v))) 4 
          (v (agr (? a)) (vform (? v)) (subcat _np)) (np))))

The Head feature input format allows the user to specify head features for each 
category. If this format is used, every rule should have at least one head on 
the left hand side. The specification of headfeatures for the grammar using the 
form
      (Headfeatures (<cat1> <feat1.1> ... <feat1.m>) ...(<catn> <featn.1> ... 
<featn.k>)).
Here is the same grammar as *grammar1*, but in head feature format 

(setq *testGrammar2*
     '((headfeatures (VP vform agr) (NP agr))
        ((s (agr (? a))) 1 (np (agr (? a))) (head (vp (agr (? a)))))
        ((np) 2 (art (agr (? a))) (head (n (agr (? a)))))
        ((vp) 3 (head (v (subcat _none))))
        ((vp) 4 (head (v (subcat _np))) (np))))

These two grammars would generate exactly the same grammar in the internal 
format.

For improved tracing (and for use in later extensions), you should declare all 
lexical categories by setting the variable *lexical-cats*. This variable is 
preset by the system to the following, so if this covers all your categories, 
you need not do anything.

(setq *lexical-cats* 
      '(n v adj art p aux pro qdet pp-wrd name to))

LEXICON FORMAT

A lexicon consists of a list of word entries of form
     (<word> <constit>)
where the constit is in abbreviated format as described above
Here's a sample lexicon

(setq *Lexicon1*
  '((dog (n (agr 3s) (root dog)))
    (dogs (n (agr 3p) (root dog)))
    (pizza (n (agr 3s) (root pizza)))
    (saw (v (agr (? a1)) (vform past) (subcat _np) (root see)))
    (barks (v (agr 3s) (vform pres) (subcat _none) (root bark)))
    (the (art (agr 3s) (root the)))))

DEFINING THE ACTIVE LEXICON AND GRAMMAR

The following functions are provided to define which grammars and lexicons are 
to be used by the parser. These functions also convert the input formats into 
the internal formats. For defining the grammar, there are two functions. One 
redefines the active grammar to a new grammar while the other adds additional 
rules to the active grammar.

(make-grammar *grammar1*) - defines the active grammar to the expanded 
                          version of *grammar1*

(augment-grammar *grammar2*) - adds the rules in *grammar2* to the active 
                          grammar.

There are two functions for accessing the active grammar:

(get-grammar) returns the complete active grammar

(show-grammar) prints the grammar out in a slightly better format

For the lexicon, a similar pair of functions is provided.

(make-lexicon *lexicon1*) - defines the active lexicon to be the expanded 
                          version of *lexicon1*

(augment-lexicon *lexicon2*) - adds the lexical entries in *lexicon2* to the 
                          active lexicon

There are two functions for accessing the active lexicon

(get-lexicon) returns the complete active lexicon 

(defined-words) returns a list of all the words defined

RUNNING THE PARSER

The parser is called using the function BUparse with a list of words as its 
argument, e.g.,

  (BU-parse '(Jack saw the dog))

There are two levels of tracing on the parser

(traceon) calling this will cause concise trace of each constituent as it is 
          added to the chart.
(verboseon)  calling this traces each arc extension as well.

(verboseoff) this stops the extended tracing (actually it is identical
             to calling (traceon) 

(traceoff) disables tracing

If tracing is on, the whole chart is printed at the end of the parse.

There are several ways to access the chart built from the last parse:

(show-chart) prints out the complete chart 

(show-answers) prints out every complete S constituent that covers the sentence, showing the 
               complete parse tree. This function all binds the variables in the 
               subconstituents as it prints giving a better view of the overall parser tree 
               than the full chart where the constituents are shown as they were defined 
               bottom-up.

DEBUGGING GRAMMARS

One nice feature of bottom up algorithms is that they allow for some effective 
debugging strategies. If you find that a sentence doesn't parse that you think 
should. Try each of the constituents one at a time and see what the parser 
produces. If you don't get the right analysis, then try additional subparts of 
the sentence until you find the answer. For example,. say you try
   (bu-parse '(the angry man ate the pizza))
and it doesn't produce a complete interpretation. You might then try
    (bu-parse '(the angry man))
and see if this produces an appropriate NP analysis. Say it does. Then try
    (bu-parse '(ate the pizza))
ands see if this produces the appropriate VP analysis. If it doesn't, then 
there's probably a problem with your VP -> V NP rule, or your lexical entry for 
"ate". If it does produce the right interpretation, then the problem must be 
with your S -> NP VP rule (e.g., maybe the rule is missing, or maybe a feature 
equation is wrong, etc.).


GAP FEATURE PROPAGATION

You can enable and diable gap features with the following functions.

(Enablegaps) - turn gap handling on
(Disablegaps) - turn grap handling on.

To work, gap handling must be enabled before you convert the
lexicon and grammars into the active form. Make-lexicon and Make-grammar
insert gap features in all rules that do not have a gap feature
specified already.
see Chapter 5 of the NLU book for details.

SEMANTIC INTERPRETATION

You can enable semantic interpretation with the following function:

(enablesem) - turns on semantic interpretation. This causes the
       VAR feature to be instantiated when lexical constituents
       are added, and attempts to simplify lambda expressions in
       the SEM feature

(disableSem) - turns off semantic interpretation

For details, see Chapter 9 of the NLU book.


NOTES:
This is a preliminary version of the software. Please report all bugs and 
suggestions for improving the system or the documentation to James Allen at 
james@cs.rochester.edu.
