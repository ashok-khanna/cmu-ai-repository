It is most easily available by anonymous ftp from
crl.nmsu.edu in the directory

	pub/non-lexical/ViewFinder

The files in that directory are:

	ViewFinder-A4.tar.Z	= A4 postscript version of my dissertation
	ViewFinder-A5.tar.Z	= A5 version of same
	ViewFinder-US.tar.Z	= US letter version
	ViewGen.tar.Z		= the ViewGen system
	patch1			= patch for ViewGen
	patch1.readme		= explanation of how to apply the patch
	vf-hetis.tar.Z		= Multiple Defeasible Inheritance Reasoner
				  as described in various papers, as well
				  as in the thesis.

Brief description of ViewGen follows:

ViewGen: ViewGen.tar.Z available by anonymous ftp from --

ViewGen (a viewpoint generator) is a prolog program that implements a
"Belief Ascription Algorithm" as described in Ballim & Wilks (see the
bibliography section on User Modelling).  This can be seen as a form of
agent modelling tool, which allows for the generation of arbitrarily deep
nested belief spaces based on the system's own beliefs, and on beliefs that
are typically held by groups of agents.  The theory of belief ascription
upon which it is based is described in detail in "Artificial Believers" by
Ballim & Wilks (Lawrence Erlbaum Associates), and a general framework for
attributing and maintaining nested propositional attitudes is described in
Afzal Ballim's dissertation which is archived with the Viewgen program (in
the files ViewFinder-{A4/A5/US}.tar.Z, the variable part indicating the
format of the PostScript file).

Brief description of my dissertation follows:

		ViewFinder: A Framework for Representing,
	       Ascribing and Maintaining Nested beliefs of
			    Interacting Agents

			       Afzal Ballim

       Dept. of Computer Science, University of Geneva, Switzerland

Interacting with agents in an intelligent manner means that the computer
program is able to adapt itself to the specific requirements of agents.  The
dissertation is concerned with an important feature necessary for this
ability to adapt:  the use of models of the beliefs and knowledge of the
interacting agents.

The objective of this dissertation is to detail a theory of belief, by which
is meant a theory of how the contents of nested belief models are formed.
The work is motivated by (i) the aspects of representation, formation, and
revision of nested belief models that have been neglected, and (ii) the lack
of a unifying framework for all of these features of nested beliefs.

In much research involving models of the beliefs of agents, the models used
are pre-given.  While this is sufficient in highly constrained domains it is
inappropriate in general.  In more complex domains it is necessary to
dynamically generate these models.  This dissertation is directly concerned
with the problems of dynamically creating such nested models of the beliefs
of agents.

The major contributions of this work are:

1) Investigation of the problems of using stereotypes for generating
nested belief models.
2) Detailed work on using belief perturbation as an ascription method.
3) Development of parameterized ``belief ascription operators'' to
characterize the ascription process.
4) Elaborated proposal for an approach to belief ascription that captures
the best of perturbation and stereotype approaches, but is more general.
5) Comparison of belief ascription with belief interpretation.
6) Consideration of belief revision in a system that maintains nested
beliefs.
7) Formulation of a generalized framework for dealing with nested
propositional attitudes, based on the notion of ``environments.''
8) Reformulation of ascription operators as environment projection
operators. 
9) Demonstration of how environment projection can can be seen as a
fundamental operator underlying many important processes in AI, including
belief ascription, inheritance reasoning, truth maintenance, belief
revision, merging of intensional descriptions, and metaphor generation.  An
environment framework may thus serve as a basis for investigation,
development, and implementation of all of these processes.
