
  I   INTRODUCTION
  ----------------

This package contains a small Scheme evaluator INCLUDING the low-level macro
facility described in the appendix of R4RS. The implementation of this facility
is very simple, and is described in a paper that will be submitted to LFP94.
There are few comments and explanations in this package: everything is in the
paper which will be available on request to dumesnil@etca.fr when it will be
terminated. But any questions or remarks are welcome anyway.

Features of the algorithms are:

   + straightforward implementation
   + hygienic expansion is done during the evaluation, only when needed
   + variables are not renamed (i.e the original name is accessible via
      identifier->symbol)
   + no need for multiple walks over the code

The only trouble is that, as a side effect of this work, I realized that the
semantic of syntax described in R4RS is a litle wrong. Moreover I think
that many examples in the appendix should have an unspecified (implementation
dependant) result.

Here are the differences:

   + calling syntax outside of a macro rewriter should have an unspecified
     result (i.e. it is not a bad choice to signal an error: the idea is that
     there is no syntactic environment outside the body of a rewriter).

   + the fact that symbols are identifiers or not should also be unspecified.

   + the example

       (let ((x 0))
         (let-syntax ((alpha (lambda (x) (syntax x))))
           (alpha)))
     
     should not raise to an error, it should be the same as

       (let ((x 0))
         (let-syntax ((alpha (lambda (e) (syntax x))))
           (alpha)))

     i.e. there  is no reason why the x enclose by lambda and the one 
     introduced by let should interact.

Note that our algorithm does not specify these points (except the last one):
it is really an implementor choice. This is discussed in detail in the paper.

In this implementation I use a new special form (make-transformer) that creates
a transformer (a syntactic closure?) by enclosing the current environment and
binding it with a procedure (the rewriter). Define-syntax (resp. let-syntax
and letrec-syntax) is only a macro using make-transformer and define (resp.
let and letrec). This implies that rewriters are first class objects available
in the normal environment. Once again, this a choice (the simplest one), but
one could imagine that macros are bound in another space name (this is however
more complicated for lexical bindings).

  II  FILES
  ---------

This package contains the following files:

	README		this file
	eval.scm	code for a toy Scheme evaluator
	macro.scm	some macro written thanks to the low-level facility
	r4rs.scm	examples from the appendix of R4RS


  III USING THE EVALUATOR
  -----------------------

Run your usual Scheme and just type:

  > (load "eval.scm")

This will enter the main-loop, and display a prompt. You can now type
expressions to evaluate them (note: letrec is not implemented). 

You can for example load the file "macro.scm":

  ?? (load "macro.scm")

This will define the following macros: let, let*, define-syntax, let-syntax
and some examples described in the paper.

You can now type some examples from the file "r4rs.scm" (expansion traces
are deleted):

  ?? (let-syntax ((quote-me 
	            (lambda (x) 
		      (list (syntax quote) x))))
       (quote-me please))

  == (quote-me please)

  ?? (let-syntax ((car (lambda (x) (syntax car))))
       ((car) '(0)))
  
  == 0

  ?? (let ((x 0))        ;;; an error in R4RS, correct here
       (let-syntax ((alpha (lambda (x) (syntax x))))
         (alpha)))

  == 0

  ?? (let ((* +))  ;;; example in the paper (very slow)
       (fact 5))

  == 120

  ?? (symbol? (syntax x))  ;;; #f in R4RS, an error here
  %eval: illegal use of syntax: (syntax x)

...

  ?? (end)

  IV  REMARKS
  -----------

1- This implementation is copied from a C written one. It is not supported nor
   carefully tested and may contains some bugs. 

2- Expansion is very slow. The reasons are mainly:
    + macro rewriters are evaluated by our evaluator and not the underlying one
    + access to identifier is not memoized (quadratic time in the worse case)
    + macros are not displaced. This is especially sensible when they are used
      in the rewriter of other macros.

   Note that I use this algorithm in my C version for 2 months (with memoizing
   and displacing macros): I never observed significant overhead compared to
   other implementations of Scheme.

3- Macros in file macro.scm are hard to read (and to write ...). Don't forget
   this is a LOW level facility. Moreover we can't use quasiquotation, nor
   quasi-syntaxification (#`) as suggested in R4RS (which is very usefull).
