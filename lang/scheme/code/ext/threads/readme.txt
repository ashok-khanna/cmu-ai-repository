$Id: README,v 1.1 1992/01/15 11:59:13 queinnec Exp $

   PCALL and other high tech control structures in Scheme
		by Christian Queinnec
	Ecole Polytechnique and INRIA-Rocquencourt

This set of files must contain:
	README
	threads.scm
	susp.scm
	cont-bm.scm
	splitter.scm

README is the precise file you are reading.

threads.scm contains a multi-threads kernel which provides a pcall
facility with the semantics described in [Queinnec90g] and
[Queinnnec91b]. Threads are represented by continuations, the kernel
is non preemptive but rather unpredictable. 

susp.scm defines place-holders, futures, and suspensions. A new trick
is defined: `pursuable futures' which will be documented in a future
paper. The idea of pursuable futures comes from the Thesis of Vincent
Poirriez.

splitter.scm defines the splitter conntrol operator as described in
[Queinnec91a]. It is a high level control operator that allows to 
define partial continuations. 

cont-bm.scm contains a benchmark making use of continuations in
various contexts. They heavily use the indefinite extent of Scheme
continuations. The constants that are predefined in it can be changed,
they are set to values that allow Scheme->C (from Joel Bartlett) to
run them with a 20 Mbytes heap.


BIBLIOGRAPHY:

@InProceedings{Queinnec90g,
  author = 	 "Christian Queinnec",
  title = 	 "{P}oly{S}cheme : {A} {S}emantics for a {C}oncurrent
		  {S}cheme",
  booktitle = 	 "Workshop on High Performance and Parallel Computing in Lisp",
  year = 	 1990,
  organization = europal,
  address = 	 "Twickenham (UK)",
  month = 	 nov,
  ecritsdIcsla = 4,
  abstract = "
The Scheme language does not fully specify the
semantics of combination: the evaluation order of the terms composing
a combination is left indeterminate.  We investigate in this paper a
different semantics for Scheme where terms of combinations are evaluated
concurrently. The resulting semantics models a language with concurrent
threads sharing a common workspace. The semantics is given in terms
of denotational semantics and uses resumptions as well as a choice operator:
{\it oneof\/} which mimics a scheduler.
An alternate definition for this operator lets appear
the classical powerdomains. The main interest of this operator is to
offer a formalization that can be read with an operational point of view
while keeping a firm theoretical base.

Scheme also offers first class continuations with indefinite extent;
we examine some semantics for continuations with respect to
concurrency. Each of these semantics is a natural extension
of the sequential case of regular Scheme. Still they strongly
differ in their observed behaviours.

The resulting language, named PolyScheme, offers much of the features
of current concurrent Lisp (or Scheme) dialects thanks to the sole
extension of its combination semantics and without any explicit
specialized construct dealing with concurrency."
}

@InProceedings{Queinnec91a,
  author = 	 "Christian Queinnec and Bernard Serpette",
  title = 	 "{A} {D}ynamic {E}xtent {C}ontrol {O}perator for
		  {P}artial {C}ontinuations",
  booktitle = 	 popl91,
  year = 	 1991,
  pages = 	 "174--184",
  address = 	 "Orlando (Florida USA)",
  month = 	 jan,
  ecritsdIcsla = 5,
  abstract = "
A partial continuation is a prefix of the computation that remains to
be done. We propose in this paper a new operator
which precisely controls which prefix is to be abstracted into a partial
continuation. This operator is strongly related to the notion of
dynamic extent which we denotationally characterize.
Some programming examples are commented and
we also show how to express previously proposed control operators.
A suggested implementation is eventually discussed."
}

@InProceedings{Queinnec91b,
  author = 	 "Christian Queinnec",
  title = 	 "{C}rystal {S}cheme, {A} {L}anguage for {M}assivel
		  {P}arallel {M}achines",
  editor =       "M Durand and F {El Dabaghi}",
  booktitle = 	 "Second Symposium on High Performance Computing",
  year = 	 1991,
  pages =        "91-102",
  publisher =    north-holland,
  address = 	 "Montpellier (France)",
  month = 	 oct,
  ecritsdIcsla = 5,
  abstract = "
Massively parallel computers are built out of thousand conventional
but powerful processors with independent memories. Very simple
topologies mainly based on physical neighbourhood link these
processors. The paper discusses extensions to the Scheme language in
order to master such machines. Allowing arguments of functions to be
concurrently evaluated introduces parallelism. Migration across the
different processors is achieved through a remote evaluation
mechanism. We propose a clean semantics for first class continuations
in presence of concurrency and show how they can be used to build,
in the language itself, advanced concurrent constructs such as futures.
Eventually we comment some simulations, with various topologies and
migration policies, which enables to appreciate our previous
linguistical choices and confirms the viability of the model."
}


pcall.tar.gz     Scheme code to emulate future and pcall
