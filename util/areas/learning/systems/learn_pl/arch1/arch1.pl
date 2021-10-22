/******************************************************************/
/* ARCH1.PRO          Last Modification: Fri Jan 14 19:19:54 1994 */
/* Winston's incremental learning procedure.                      */
/******************************************************************/
%
%    Copyright (c) 1988 Stefan Wrobel
%
%    This program is free software; you can redistribute it and/or 
%    modify it under the terms of the GNU General Public License 
%    Version 1 as published by the Free Software Foundation.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public 
%    Licensealong with this program; if not, write to the Free 
%    SoftwareFoundation, Inc., 675 Mass Ave, Cambridge, MA 02139, 
%    USA.
%
/******************************************************************/
/*  impl. by    : Stefan Wrobel                                   */
/*                F3.XPS                                          */ 
/*                Gesellschaft fuer Mathematik und                */
/*                Datenverarbeitung                               */
/*                Schloss Birlinghoven                            */
/*                Postfach 1240                                   */
/*                5205 St.Augustin 1                              */
/*                F.R.G.                                          */
/*                E-Mail: wrobel@gmdzi.gmd.de                     */
/*                1988                                            */
/*                                                                */
/*  reference   : ES2ML Tutorial Exercise                         */
/*                Concept Learning and Concept Formation          */
/*                Stefan Wrobel                                   */
/*                                                                */
/*                chapter 11                                      */
/*                Artificial Intelligence                         */
/*                Winston                                         */
/*                second edition                                  */
/*                Addison-Wesley, 1984                            */
/*                                                                */
/*  call        : process_stored_inputs(arch)                     */
/*                                                                */
/******************************************************************/
% TH Sat May 29 23:25:18 1993  - made some minor modifications

/******************************************************************/
/*                                                                */
/*  call        : process_stored_inputs(+ConceptName)             */
/*                                                                */
/*  arguments   : ConceptName = Name of example class             */
/*                                                                */
/*  side effects: retracts the previous concept, if there was one */
/*                                                                */
/******************************************************************/
/* Retracts the previous concept, if there was one and processes  */
/* the example class.                                             */
/******************************************************************/

process_stored_inputs(ConceptName):-
        (retract(concept(ConceptName,_)) ; true),
        !,
        process_stored_inputs_body(ConceptName).

process_stored_inputs_body(ConceptName):-
        msgs([nl,'Processing stored inputs for ', ConceptName, ' ...']),
        input(ID,Type,ConceptName,Input),
        msgs([nl,'Input ',ID,': ', Type, nl, Input]),
        process_example(Type,ConceptName,Input),
        concept(ConceptName,Concept),
        concept_template(Concept,Template),
        concept_constraints(Concept,Constraints),
        msgs([nl,'New Concept Definition is:',
                nl, '--- Template:',
                nl,Template,
                nl,'--- Constraints:',
                nl,Constraints,
                nl]),
        fail.
process_stored_inputs_body(_):-
        msgs([nl,'No more inputs. Done.']).


/******************************************************************/
/*                                                                */
/*  call        : process_example(+Type,+ConceptName,+Example)    */
/*                                                                */
/*  arguments   : Type        = Classification                    */
/*                ConceptName = Name of example class             */
/*                Example     = Structural Description            */
/*                                                                */
/*  side effects: assertion of concept definition in database     */
/*                modified concept definition in database         */
/*                                                                */
/******************************************************************/
/* Processes a new input example (representation: see             */
/* arch_1.prolog) and adapts the existing concept definition by   */
/* using specialize (if Type is near_miss) or generalize (if Type */
/* is example).                                                   */
/*****************************************************************/

process_example(example,ConceptName,Example):-
        retract(concept(ConceptName,Definition)),
        !,
        /* process it */
        generalize(Example,Definition,NewDefinition),
        assertz(concept(ConceptName,NewDefinition)),
        !.
process_example(example,ConceptName,Example):-
        !,
        /* no concept yet - this is the initial input. Perform */
        /* special initial generalization on it */
        initial_generalization(Example,InitialDefinition),
        assertz(concept(ConceptName,InitialDefinition)).
process_example(near_miss,ConceptName,Example):-
        retract(concept(ConceptName,Definition)),
        !,
        /* process it */
        specialize(Example,Definition,NewDefinition),
        assertz(concept(ConceptName,NewDefinition)),
        !.
process_example(near_miss,ConceptName,_):-
        !,
        /* oops - we got a near miss as a first example. Reject it. */
        msgs([nl,'Cannot process a (near) miss as the first example of ',
                                        ConceptName,'.', nl,
             'Please begin with a (prototypical) example instead.']).

/******************************************************************/
/*                                                                */
/*  call        : specialize(+Example,+Definition,-NewDefinition) */
/*                                                                */
/*  arguments   : Example       = Structural Description          */
/*                Definition    = Current Concept Definition      */
/*                NewDefinition = New Concept Definition          */
/*                                                                */
/******************************************************************/
/* Example is a near miss with respect to Definition (see         */
/* arch_1.prolog for representations). This procedure tries to    */
/* specialize the concept definition such that Example is         */
/* excluded. This is done by strengthening the necessary          */
/* conditions of Definition (adding must/must_not links in        */
/* Winston's terminology). Note that this Winston-style           */
/* specialization procedure needs a difference between the        */
/* existing sufficient conditions and the example; if we          */
/* ever overgeneralize (i.e., a near miss exactly matches         */
/* the sufficient conditions), this procedure doesn't know        */
/* how to recover.                                                */
/******************************************************************/

specialize(Example,OldConcept,OldConcept):-
        is_member(Example,OldConcept,no),
        !,
        /* match failed, i.e., this example is already excluded */
        /* by the existing definition */
        msgs([nl,'Already excluded.']).
specialize(Example,OldConcept,NewConcept):-
        /* try to find the most important differences between the Example */
        /* and the definition */
        match(OldConcept,Example,[],BL,PL,ML,AL),
        /* check if we're happy with this match */
        find_important_differences_p(specialize,PL,ML,AL,
                                                DifferenceDescriptions),
        /* o.k., we found some interesting differences */
        specialize_concept_definition(DifferenceDescriptions,BL,
                                                OldConcept,NewConcept),
        !.
specialize(_,Definition,Definition):-
        msgs([nl,'Specialize failed. Ignoring example.']).


/******************************************************************/
/*                                                                */
/*  call        : generalize(+Example,+Definition,-NewDefinition) */
/*                                                                */
/*  arguments   : Example       = Structural Description          */
/*                Definition    = Current Concept Definition      */
/*                NewDefinition = New Concept Definition          */
/*                                                                */
/******************************************************************/
/* Example is a positive example with respect to Definition (see  */
/* arch_1.prolog for representations). This procedure tries to    */
/* generalize the concept definition such that Example is         */
/* included. This is done by weakening the sufficient conditions  */
/* of Definition.                                                 */
/******************************************************************/

generalize(Example,OldConcept,OldConcept):-
        is_member(Example,OldConcept,yes),
        !,
        /* this example is already included by the existing definition */
        msgs([nl,'Already included.']).
generalize(Example,OldConcept,NewConcept):-
        /* try to find the most important differences between the Example */
        /* and the definition */
        match(OldConcept,Example,[],_,PL,ML,AL),
        /* check if we're happy with this match */
        find_important_differences_p(generalize,PL,ML,AL,
                                                DifferenceDescriptions),
        /* o.k., we found some interesting differences */
        generalize_concept_definition(DifferenceDescriptions,OldConcept,
                                                            NewConcept).
generalize(_,Concept,Concept):-
        msgs([nl,'Generalize failed. Ignoring example.']).


/**********************************************************************/
/*                                                                    */
/*  call        : find_important_differences_p(Operation,             */
/*                                             +PartialList,          */
/*					       +AdditionList,         */
/*                                             +MissingList,          */
/*                                             -DifferenceDescription)*/
/*                                                                    */
/**********************************************************************/
/* Inspect the differences in PartialList, AdditionList, and          */
/* MissingList, and decide which ones to use as the basis for         */
/* concept modification. Operation is either "specialize" or          */
/* "generalize". DifferenceDescriptions is the list of such           */
/* differences, with a descriptor indicating their type:              */
/*                                                                    */
/*   - partial_match([DefinitionConstraint,ExampleFact])              */
/*   - addition(ExampleFact)                                          */
/*   - missing(DefinitionConstraint)                                  */
/*                                                                    */
/**********************************************************************/
/* For generalization, additional facts in the example are            */
/* not interesting. Return partial matches and missing constraints.   */
/**********************************************************************/
find_important_differences_p(generalize,PL,ML,_,DD):-
        mark_as(partial,PL,DD1),
        mark_as(missing,ML,DD2),
        append(DD1,DD2,DD).
/***********************************************************************/
/* For specialization, both missing constraints and additional facts   */
/* are interesting. If there are both, prefer the missing constraint.  */
/***********************************************************************/
find_important_differences_p(specialize,_,[],AL,DD):-
        not(AL = []),
        !,
        /* differences_acceptable_p(AL), */
        mark_as(addition,AL,DD).
find_important_differences_p(specialize,_,ML,_,DD):-
        not(ML = []),
        !,
        /* differences_acceptable_p(ML), */
        mark_as(missing,ML,DD).
find_important_differences_p(specialize,PL,_,_,DD):-
        mark_as(partial,PL,DD).

differences_acceptable_p(Diffs):-
        /* a single difference is always fine */
        length(Diffs,1), !.
differences_acceptable_p(Diffs):-
        /* more than one must have the same functor to be acceptable */
        same_functor_p(Diffs,_), !.

same_functor_p([],_):- !.
same_functor_p([LastDifference],Functor):-
        !,
        LastDifference =.. [Functor|_].
same_functor_p([First|Rest],Functor):-
        same_functor_p(Rest,Functor),
        First =.. [Functor|_].

mark_as(_,[],[]):- !.
mark_as(Mark,[First|Rest],[FirstMarked|RestMarked]):-
        FirstMarked =.. [Mark,First],
        mark_as(Mark,Rest,RestMarked).

/***********************************************************************/
/* The evolving concept definition is represented by two lists of facts*/
/* (which may contain symbolic vars "var(...)"). The first list is the */
/* "template", a structural description of the concept that is matched */
/* one-to-one to the example, i.e., each part of the template          */
/* "consumes" one part of the example when matched. The second list    */
/* contains the "constraints", which are logical conditions on concept */
/* members that do not "consume" example parts when they get matched.  */
/* Negated facts go in the constraint slot. Within the template,       */
/* necessary parts can be marked as necessary by enclosing them with   */
/* "must(...)"; constraints are always interpreted as necessary.       */
/***********************************************************************/
/* A concept is represented as:                                        */
/*                                                                     */
/*   concept(NAME,TEMPLATE_LIST,CONSTRAINT_LIST)                       */
/*                                                                     */
/* e.g., concept(arch,                                                 */
/*               [part(var(o1)),part(var(o2)),part(var(o3)),           */
/*                isa(var(o1),brick), isa(var(o2),brick),              */
/*                isa(var(o3),brick), left_of(var(o2),var(o1)),        */
/*                must(supports(var(o1),var(o3))),                     */
/*                must(supports(var(o2),var(o3)))],                    */
/*               [not(touches(var(o1),var(o2)))]).                     */
/***********************************************************************/
/* The following predicates give access to the parts of a concept:     */
/***********************************************************************/

concept_p(concept(_,_,_)).
concept_name(concept(Name,_,_),Name).
concept_template(concept(_,Template,_),Template).
concept_constraints(concept(_,_,Constraints),Constraints).

/***********************************************************************/
/* The following predicates alternate parts of a concept:              */
/***********************************************************************/
alter_concept_constraints(concept(N,T,_),C,concept(N,T,C)).
alter_concept_template(concept(N,_,C),T,concept(N,T,C)).

/***********************************************************************/
/* Two concepts are equal if both have the same name and the sets of   */
/* their templates and constraints are equal. This predicate will not  */
/* notice isomorphic concepts with different variable names.           */ 
/***********************************************************************/
concept_equal_p(concept(Name,Template1,Constraints1),
                concept(Name,Template2,Constraints2)) :-
        set_equal_p(Template1,Template2),
        set_equal_p(Constraints1,Constraints2).

print_concept(Concept):-
        concept_name(Concept,Name),
        /* make sure Name is bound to something reasonable */
        (Name = '_' ; true),
        concept_template(Concept,Template),
        concept_constraints(Concept,Constraints),
        msgs([nl,'Concept ',Name,':',nl,'Template:    ',Template,nl,
                 'Constraints: ',Constraints]),
        !.

print_concepts(Concepts):-
        member(Concept,Concepts),
        print_concept(Concept),
        fail.
print_concepts(_).

/******************************************************************/
/*                                                                */
/*  call        : is_member(+Example,+Concept,-Decision)          */
/*                                                                */
/*  arguments   : Example  = Structural Description               */
/*                Concept  = Current Concept Definition           */
/*                Decision = Truth Value                          */
/*                                                                */
/******************************************************************/
/* Classifies Example according to Concept. Three cases are       */
/* possible:                                                      */
/*                                                                */
/*    (a) Example meets the sufficient conditions of the current  */
/*        Concept Definition, so it must be a member of the       */
/*        concept (Decision = yes)                                */
/*    (b) Example does not meet the necessary conditions, so it   */
/*        cannot be a member (Decision = no)                      */
/*    (c) Example meets the necessary conditions, but not the     */
/*        sufficient conditions (Decision = possible)             */
/*                                                                */
/******************************************************************/

is_member(Example,Concept,Decision):-
        /* match succeeds only if necessary conditions */
        /* (incl. constraints) are met                 */
        match(Concept,Example,[],_,PL,ML,_),
        !,
        /* check if all non-necessary conditions were */
        /* matched also                               */
        (ML = [], PL = [],
                !,
                Decision = yes;
                Decision = possible).
is_member(_,_,no).

/********************************************************************/
/* Pattern Matcher                                                  */
/********************************************************************/
/*                                                                  */
/*  call        : match(+Concept,+Example,                          */
/*                      +OldBindingList,-NewBindingList,            */
/*                      -PartialMatchList,-MissingList,             */
/*                      -AdditionList,CheckNecessaryConditions)     */
/*                                                                  */
/*  arguments   : Concept          = Current Concept Definition     */
/*                Example          = Structural Description         */
/*                OldBindingList   = List of Current Bindings       */
/*                NewBindingList   = List of New Bindings           */
/*                PartialMatchList = List of Partial Matched Pairs  */
/*                MissingList      = List of Missing Example Facts  */
/*                AdditionList     = List of Missing Concept Parts  */
/*                CheckNecessaryConditions = see descripton         */
/*                                                                  */
/*  properties  : The predicate is backtrackable and returns all    */
/*                equally good matches on backtracking.             */
/*                                                                  */
/********************************************************************/
/* Match Example with Concept Definition. Example and Concept are   */
/* represented as in "arch_1.pro". Concept may contain facts with   */
/* symbolic variables as arguments ("var(<varname>)"), all other    */
/* symbols are treated as constants. No guarantee if you call match */
/* with expressions that contain unbound (PROLOG-) variables.       */
/* OldBindingList is the list of bindings (list of [var|value]      */
/* pairs) to respect when performing the match. The constraints of  */
/* Concept are handled properly (they do not "consume" parts in the */
/* example and may include negated facts). The match does not       */
/* succeed unless all constraints are met. If CheckNecessary-       */
/* Conditions is non-nil (or left out), match makes sure that no    */
/* match leaves a necessary part of Definition unmatched (those     */
/* marked with "must(...)"). If CheckNecessaryConditions is nil,    */
/* that check is not made (useful if you want to generalize on      */
/* necessary conditions, too).                                      */
/*                                                                  */
/* Match returns:                                                   */
/*                                                                  */
/*    - the NewBindingList with any additional bindings that were   */
/*      made (a superset of OldBindingList)                         */
/*    - PartialMatchList, the list of pairs                         */
/*      ([Constraint,ExampleFact]) that were partially matched      */
/*    - AdditionList, the list of facts present in the example      */
/*      without a counterpart in the definition                     */
/*    - MissingList, the list of facts in the definition without a  */
/*      a counterpart in the example                                */
/*                                                                  */
/********************************************************************/

match(Concept,Ex,OldBL,NewBL,PL,ML,AL):-
        match(Concept,Ex,OldBL,NewBL,PL,ML,AL,t).

match(Concept,Ex,OldBL,NewBL,PL,ML,AL,CheckNecessaryP):-
        concept_template(Concept,Templ),
        concept_constraints(Concept,Constraints),
        /* try to match as many parts as possible unambiguously */
        unambiguous_match(Templ,Ex,OldBL,RestTempl1,RestEx1,BL1),
        /* for the rest, try to match as many as possible perfectly */
        perfect_match(RestTempl1,RestEx1,BL1,RestTempl2,RestEx2,BL2,
                                                        CheckNecessaryP),
        /* check other constraints (negated conditions, etc.) */
        /* ("Must" conditions are checked in perfect_match, */
        /* to cut off false matches as early as possible) */
        not(unsatisfied_constraint_p(Constraints,Ex,BL2)),
        /* among whatever is still left, try to find as many partial  */
        /* matches as possible - whatever is left there is  */
        /* missing/additional */
        partial_match(RestTempl2,RestEx2,BL2,NewBL,PL,ML,AL).

/********************************************************************/
/* unambiguous_match                                                */
/********************************************************************/

unambiguous_match(Templ,Ex,OldBL,Templ,Ex,OldBL):-
        /* if either Def or Ex are empty, we can't do anything */
        (Templ = [] ; Ex = []), !.
unambiguous_match(Templ,Ex,OldBL,RestTempl,RestEx,NewBL):-
        find_unambiguous_match_p(Templ,Ex,OldBL,RestTempl1,RestEx1,NewBL1),
        !,
        unambiguous_match(RestTempl1,RestEx1,NewBL1,RestTempl,RestEx,NewBL).
unambiguous_match(Templ,Ex,OldBL,Templ,Ex,OldBL):-
        /* we couldn't find another unambiguous match - just return */
        !.

find_unambiguous_match_p(Templ,Ex,OldBL,RestTempl,RestEx,NewBL):-
        enumerate(Templ,Part,RestTempl),
        /* can we find an unambiguous match for FirstPart? */
        find_unambiguous_match_p1(Part,Templ,Ex,OldBL,RestEx,NewBL),
        /* yes, fine */
        !.

find_unambiguous_match_p1(Part,Template,Ex,OldBL,RestEx,NewBL):-
        enumerate(Ex,ExamplePart,RestEx),
        /* they must at least match */
        perfect_match_p(Part,ExamplePart,OldBL,NewBL),
        /* and do so uniquely */
        not(non_unique_match_p(Part,ExamplePart,Template,Ex,OldBL)),
        /* fine */
        !.

non_unique_match_p(Part,ExamplePart,Template,Example,BL):-
        member(Part1,Template),
        member(ExamplePart1,Example),
        (not(Part1 = Part), ExamplePart1 = ExamplePart;
         not(ExamplePart1 = ExamplePart), Part1 = Part),
        perfect_match_p(Part1,ExamplePart1,BL,_),
        !.

/********************************************************************/
/* Finding perfect matches involves guessing. To avoid returning a  */
/* bad match only because of a bad first guess, we need to look at  */
/* all possible matches and return the best one (since by looking   */
/* at the first N matches, we cannot always be sure there won't be  */
/* a better one if we backtrack once more).                         */
/********************************************************************/

perfect_match(Templ,Ex,OldBL,RestTempl,RestEx,NewBL,CheckNecessaryP):-
        /* find all perfect matches  */
        findbag([RestTempl1,RestEx1,NewBL1],
                 (perfect_match1(Templ,Ex,OldBL,RestTempl1,
                                                RestEx1,NewBL1),
                  check_for_unmatched_necessary_constraints_p(RestTempl1,
                                                       CheckNecessaryP)),
                PerfectMatches),
        remove_duplicates(PerfectMatches,PerfectMatches1,perfect_match_equal_p),
        list_sort(PerfectMatches1,SortedPerfectMatches,perfect_match_better_p),
        /* get all matches with the top score */
        get_best(SortedPerfectMatches,BestMatches,perfect_match_better_p),
        /* return one of them (backtrackable) */
        member([RestTempl,RestEx,NewBL],BestMatches).

perfect_match1(Templ,Ex,OldBL,Templ,Ex,OldBL):-
        /* if either Templ or Ex are empty, we can't do anything */
        (Templ = [] ; Ex = []), !.
perfect_match1(Templ,Ex,OldBL,Templ,Ex,OldBL):-
        not(find_perfect_match_p(Templ,Ex,OldBL,_,_,_)),
        /* we couldn't find another perfect match - just return */
        !.
perfect_match1(Templ,Ex,OldBL,RestTempl,RestEx,NewBL):-
        find_perfect_match_p(Templ,Ex,OldBL,RestTempl1,RestEx1,NewBL1),
        perfect_match1(RestTempl1,RestEx1,NewBL1,RestTempl,RestEx,NewBL).

find_perfect_match_p(Templ,Ex,OldBL,RestTempl,RestEx,NewBL):-
        enumerate(Templ,Part,RestTempl),
        /* can we find a perfect match for FirstPart? */
        find_perfect_match_p1(Part,Ex,OldBL,RestEx,NewBL).

find_perfect_match_p1(Part,Ex,OldBL,RestEx,NewBL):-
        enumerate(Ex,ExamplePart,RestEx),
        /* they must match */
        perfect_match_p(Part,ExamplePart,OldBL,NewBL).

/********************************************************************/
/*                                                                  */
/*  call        : perfect_match_p(+Constraint,+Fact,+OldBL,-NewBL)  */
/*                                                                  */
/*  arguments   : Constraint = Current Concept Definition           */
/*                Fact       = Structural Description               */
/*                OldBL      = OldBindingList                       */
/*                NewBL      = NewBindingList                       */
/*                                                                  */
/********************************************************************/
/* Succeed if Constraint and Fact match perfectly, returning the new*/
/* binding list, or fail otherwise.                                 */
/* Second possibility: we are able to use a theorem that uses the   */
/* existing example fact to derive a fact that matches. See         */
/* arch_1.pro for some sample inferences.                           */
/********************************************************************/
perfect_match_p(must(Constraint),Fact,OldBL,NewBL):-
        perfect_match_p(Constraint,Fact,OldBL,NewBL).
perfect_match_p(Constraint,Fact,OldBL,NewBL):-
        Constraint =.. [Functor|Args1],
        Fact =.. [Functor|Args2],
        count_differences_p(Args1,Args2,OldBL,NewBL,0).
perfect_match_p(Constraint,Fact,OldBL,NewBL):-
        infer(Fact,FactDerivation),
        perfect_match_p(Constraint,FactDerivation,OldBL,NewBL).


/********************************************************************/
/* Decides if one perfect match is better than another by a simple  */
/* measure: more parts of the template matched                      */
/********************************************************************/
perfect_match_better_p([RestTempl1,_RestEx1,_BL1],
                                        [RestTempl2,_RestEx2,_BL2]):-
        length(RestTempl1,L1),
        length(RestTempl2,L2),
        L1 < L2.

/********************************************************************/
/* True if two perfect matches are equal                            */
/********************************************************************/
perfect_match_equal_p([RestTempl1,RestEx1,BL1],
                                        [RestTempl2,RestEx2,BL2]):-
        set_equal_p(RestTempl1,RestTempl2),
        set_equal_p(RestEx1,RestEx2),
        set_equal_p(BL1,BL2).

/********************************************************************/
/* unsatisfied_constraint_p                                         */
/********************************************************************/

unsatisfied_constraint_p(Constraints,Ex,BL):-
        member(Constraint,Constraints),
        member(Fact,Ex),
        (Constraint = not(BaseConstraint);
         BaseConstraint = Constraint),
        perfect_match_p(BaseConstraint,Fact,BL,_),
        !.

check_for_unmatched_necessary_constraints_p(_,nil):- !.
check_for_unmatched_necessary_constraints_p(Templ,_):-
        not(member(must(_),Templ)).

/********************************************************************/
/*                                                                  */
/*  call        : partial_match(!Template,!Example,                 */
/*                              !OldBindingList,?NewBindingList,    */
/*                              ?PartialMatchList,?MissingList,     */
/*                              ?AdditionList)                      */
/*                                                                  */
/*  arguments   : Template         = Current Template               */
/*                Example          = Structural Description         */
/*                OldBindingList   = List of Current Bindings       */
/*                NewBindingList   = List of New Bindings           */
/*                PartialMatchList = List of Partial Matched Pairs  */
/*                MissingList      = List of Missing Example Facts  */
/*                AdditionList     = List of Missing Concept Parts  */
/*                                                                  */
/********************************************************************/
/* Finding partial matches involves guessing. To avoid returning a  */
/* bad match only because of a bad first guess, we need to look at  */
/* all possible matches and return the best one (since by looking at*/
/* the first N matches, we cannot always be sure there won't be a   */
/* better one if we backtrack once more). Anything that can't be    */
/* matched partially is returned as missing (left-over template     */
/* parts) or additional (left-over example parts).                  */
/********************************************************************/

partial_match(Templ,Ex,OldBL,NewBL,PL,RestTempl,RestEx):-
        /* find all partial matches  */
        findbag([PL1,RestTempl1,RestEx1,NewBL1],
                        partial_match1(Templ,Ex,OldBL,PL1,RestTempl1,
                                                        RestEx1,NewBL1),
                PartialMatches),
        remove_duplicates(PartialMatches,PartialMatches1,
                                                partial_match_equal_p),
        list_sort(PartialMatches1,SortedPartialMatches,
                                                partial_match_better_p),
        /* get all matches with the top score */
        get_best(SortedPartialMatches,BestMatches,
                                                partial_match_better_p),
        /* return one of them (backtrackable) */
        member([PL,RestTempl,RestEx,NewBL],BestMatches).


partial_match1(Templ,Ex,OldBL,[],Templ,Ex,OldBL):-
        /* if either Templ or Ex are empty, we can't do anything */
        (Templ = [] ; Ex = []), !.
partial_match1(Templ,Ex,OldBL,[],Templ,Ex,OldBL):-
        not(find_partial_match_p(Templ,Ex,OldBL,_,_,_,_)),
        /* we couldn't find another partial match - just return */
        !.
partial_match1(Templ,Ex,OldBL,[PartialMatch|RestPL],RestTempl,RestEx,
                                                                NewBL):-
        find_partial_match_p(Templ,Ex,OldBL,PartialMatch,RestTempl1,
                                                        RestEx1,NewBL1),
        !,
        partial_match1(RestTempl1,RestEx1,NewBL1,RestPL,RestTempl,
                                                        RestEx,NewBL).

find_partial_match_p(Templ,Ex,OldBL,PartialMatch,RestTempl,
                                                        RestEx,NewBL):-
        enumerate(Templ,Part,RestTempl),
        /* can we find a partial match for Part? */
        find_partial_match_p1(Part,Ex,OldBL,MatchingFact,RestEx,NewBL),
        /* yes, fine */
        PartialMatch = [Part,MatchingFact].

find_partial_match_p1(Part,Ex,OldBL,ExamplePart,RestEx,NewBL):-
        enumerate(Ex,ExamplePart,RestEx),
        /* they must match */
        partial_match_p(Part,ExamplePart,OldBL,NewBL).

/********************************************************************/
/*                                                                  */
/*  call        : partial_match_p(+Constraint,+Fact,+OldBL,-NewBL)  */
/*                                                                  */
/*  arguments   : Constraint =                                      */
/*                Fact       =                                      */
/*                OldBL      = List of Current Bindings             */
/*                NewBL      = List of New Bindings                 */
/*                                                                  */
/********************************************************************/
/* Succeed if Constraint and Fact match partially, returning the new*/
/* binding list, or fail otherwise.                                 */
/* Second possibility: we are able to use a theorem that uses the   */
/* existing example fact to derive a fact that matches. See         */
/* arch_1.pro for some sample inferences.                           */
/********************************************************************/
partial_match_p(must(Constraint),Fact,OldBL,NewBL):-
        !,
        partial_match_p(Constraint,Fact,OldBL,NewBL).
partial_match_p(Constraint,Fact,OldBL,NewBL):-
        Constraint =.. [Functor|Args1],
        Fact =.. [Functor|Args2],
        count_differences_p(Args1,Args2,OldBL,NewBL,1).
partial_match_p(Constraint,Fact,OldBL,NewBL):-
        infer(Fact,FactDerivation),
        partial_match_p(Constraint,FactDerivation,OldBL,NewBL).


/********************************************************************/
/* Decides if one partial match is better than another by a simple  */
/* measure: more parts of the template matched                      */
/********************************************************************/
partial_match_better_p([_PL1,RestTempl1,_RestEx1,_BL1],
                                     [_PL2,RestTempl2,_RestEx2,_BL2]):-
        length(RestTempl1,L1),
        length(RestTempl2,L2),
        L1 < L2.

partial_match_equal_p([PL1,RestTempl1,RestEx1,BL1],
                                        [PL2,RestTempl2,RestEx2,BL2]):-
        set_equal_p(PL1,PL2),
        set_equal_p(RestTempl1,RestTempl2),
        set_equal_p(RestEx1,RestEx2),
        set_equal_p(BL1,BL2).

/********************************************************************/
/*                                                                  */
/*  call        : count_differences_p(+List1,+List2,+OldBL,-NewBL,  */
/*                                    -NoOfDifferences)             */
/*                                                                  */
/*  arguments   : List1           =                                 */
/*                List2           =                                 */
/*                OldBL           = List of Current Bindings        */
/*                NewBL           = List of New Bindings            */
/*                NoOfDifferences = Number of Differences           */
/*                                                                  */
/********************************************************************/
/* NoOfDifferences is the number of positions in which list1 and    */
/* list2 differ, returning new binding list. Fails if the two lists */
/* don't have the same length.                                      */
/********************************************************************/

count_differences_p([],[],BL,BL,0):- !.
count_differences_p([First1|Rest1],[First2|Rest2],OldBL,NewBL,RestN):-
        atom_match_p(First1,First2,OldBL,BL),
        /* those two matched - compute differences for tail of list  */
        !,
        count_differences_p(Rest1,Rest2,BL,NewBL,RestN).
count_differences_p([First1|Rest1],[First2|Rest2],OldBL,NewBL,N):-
        !,
        /* oops - they didn't match, increase count (but only if  */
        /* both were constants), there can't be partial matches   */
        /* with incorrectly bound vars) */
        not(First1 = var(_)), not(First2 = var(_)),
        count_differences_p(Rest1,Rest2,OldBL,NewBL,RestN),
        N is RestN + 1.

/********************************************************************/
/*                                                                  */
/*  call        : atom_match_p(+Object1,+Object2,BindingList)       */
/*                                                                  */
/*  arguments   : Object1     =                                     */
/*                Object2     =                                     */
/*                BindingList = List of Current Bindings            */
/********************************************************************/
/* Succeeds iff Object1 and Object2 can be unified using the        */
/* bindings in BindingList. Variables are marked "var(varname)"     */
/* (i.e., they are not Prolog variables). Handles atoms and         */
/* variables only. Note: we require bindings to be unique, i.e.     */
/* invertible mappings from vars to values. atom_match_p checks for */
/* that after performing a match.                                   */
/********************************************************************/

atom_match_p(O1,O2,OldBL,NewBL):-
        atom_match_p1(O1,O2,OldBL,NewBL),
        unique_binding_p(NewBL).

atom_match_p1(var(VarName1),var(VarName2),OldBL,NewBL):-
        !,
        /* matching two variables - give them a Prolog variable  */
        /* as binding, so when one of them gets matched later on, */
        /* that binding is propagated */
        get_binding(VarName1,OldBL,BL,Binding1),
        get_binding(VarName2,BL,NewBL,Binding2),
        Binding1 = Binding2.
atom_match_p1(Const,var(VarName),OldBL,NewBL):-
        !,
        /* we require bindings to be unique (one part in object A */
        /* can match only one part in object B */
        get_binding(VarName,OldBL,NewBL,Const).
atom_match_p1(var(VarName),Const,OldBL,NewBL):-
        !,
        get_binding(VarName,OldBL,NewBL,Const).
atom_match_p1(Const,Const,BL,BL).

/********************************************************************/
/*                                                                  */
/*  call        : get_binding(+Key,+BindingList,-Value)             */
/*                                                                  */
/*  arguments   : Key         =                                     */
/*                BindingList = List of Current Bindings            */
/*                Value       =                                     */
/*                                                                  */
/********************************************************************/
/* Value is the binding for Key in BindingList (first occurence). If*/
/* key is not bound in BindingList, a PROLOG variable is returned   */
/* as Value. If the binding list is empty,  Key doesn't have a value*/
/*  yet, add it (as an unbound variable)                            */
/********************************************************************/

get_binding(Key,[],[[Key|Value]],Value):-
        !.
get_binding(Key,BL,BL,Value1):-
        /* this split is necessary for cases where Value1 is */
        /* bound by the caller  */
        BL = [[Key|Value2]|_],
        !,
        Value1 = Value2.
get_binding(Key,[FirstBinding|RestBL],[FirstBinding|NewRestBL],Value):-
        !,
        get_binding(Key,RestBL,NewRestBL,Value).


/********************************************************************/
/*                                                                  */
/*  call        : get_variable_p(+Value,+BindingList,-Variable)     */
/*                                                                  */
/*  arguments   : Value       =                                     */
/*                BindingList = List of Current Bindings            */
/*                Variable    =                                     */
/*                                                                  */
/********************************************************************/
/* The "reverse" of get_binding: given a value, returns the first   */
/* Variable bound to that value in BindingList (backtracking returns*/
/* second, etc.). Fails if there is none.                           */
/********************************************************************/

get_variable_p(Value,[[Variable|Value]|_],Variable).
get_variable_p(Value,[_|RestBL],Variable):-
        get_variable_p(Value,RestBL,Variable).


/********************************************************************/
/*                                                                  */
/*  call        : unique_binding_p(BindingList)                     */
/*                                                                  */
/*  arguments   : BindingList = List of Current Bindings            */
/*                                                                  */
/********************************************************************/
/* Suceeds if no binding value occurs more than once                */
/********************************************************************/

unique_binding_p([]).
unique_binding_p([FirstBinding|RestBindings]):-
        unique_binding_p(RestBindings),
        FirstBinding = [_|Value],
        not(get_variable_p(Value,RestBindings,_)).

/********************************************************************/
/*                                                                  */
/*  call        : initial_generalization(+Example,                  */
/*                                       -InitialDefinition)        */
/*                                                                  */
/*  arguments   : Example           = Structural Description        */
/*                InitialDefinition = Generalized Definition        */
/*                                                                  */
/********************************************************************/
/* Winston interprets all nodes as variables, except those found    */
/* in special positions (eg., second argument of an isa link). In   */
/* our representation, this means we have to mark the constants     */
/* found in the first example as variables. We use a different      */
/* heuristic: all parts (introduced with the "part" predicate) are  */
/* interpreted as variables. The result constitutes the initial     */
/* sufficient conditions, the necessary conditions are still empty, */
/* as we haven't seen counterexamples yet.                          */
/********************************************************************/

initial_generalization(Example,InitialConcept):-
        variabilize_part_facts(Example,VarPartFacts,BL,RestFacts),
        /* now variabilize the other facts, marking only the */
        /* part names as variable */
        variabilize_facts(RestFacts,BL,VarRestFacts),
        append(VarPartFacts,VarRestFacts,Template),
        concept_template(InitialConcept,Template),
        concept_constraints(InitialConcept,[]),
        !.

variabilize_part_facts([],[],[],[]):- !.
variabilize_part_facts([part(PartName)|Rest],VarPartFacts,BL,RestFacts):-
        !,
        VarPartFacts = [part(var(PartName))|VarRestParts],
        BL = [[PartName|PartName]|RestBL],
        variabilize_part_facts(Rest,VarRestParts,RestBL,RestFacts).
variabilize_part_facts([First|Rest],VarRestParts,RestBL,[First|RestFacts]):-
        !,
        variabilize_part_facts(Rest,VarRestParts,RestBL,RestFacts).

variabilize_facts([],_,[]):- !.
variabilize_facts([First|Rest], BL, [VarFirst|VarRest]):-
        !,
        variabilize_fact(First,BL,VarFirst),
        variabilize_facts(Rest,BL,VarRest).

/********************************************************************/
/*                                                                  */
/*  call        :  specialize_concept_definition(                   */
/*                            +DifferenceDescriptions,              */
/*                            +BindingList,+OldConcept,             */
/*                            -NewConcept)                          */
/*                                                                  */
/*  arguments   : DifferenceDescriptions = Difference Description   */
/*                BindingList            = List of Current Bindings */
/*                OldConcept             = Current Concept Def.     */
/*                NewConcept             = New Concept Definition   */
/*                                                                  */
/********************************************************************/
/* Specialize the supplied concept definition by adding constraints */
/* to its necessary conditions. Based on Winston's require-link     */
/* and forbid-link heuristics.                                      */
/********************************************************************/

specialize_concept_definition([],_,C,C):- !.
specialize_concept_definition([addition(ExampleFact)|RestDD],BL,
                                                OldConcept,NewConcept):-
        !,
        /* an additional fact was found in the example - use */
        /* forbid-link heuristic */
        variabilize_fact(ExampleFact,BL,NewNecessaryConstraint),
        /* treat rest of differences */
        specialize_concept_definition(RestDD,BL,OldConcept,Concept),
        /* add negative constraint to constraints slot */
        concept_constraints(Concept,Constraints),
        list_add_if_necessary(not(NewNecessaryConstraint),Constraints,
                                                         NewConstraints),
        alter_concept_constraints(Concept,NewConstraints,NewConcept).

specialize_concept_definition([missing(Part)|RestDD],BL,OldConcept,
                                                           NewConcept):-
        !,
        /* a constraint was missing from the example - use require-link */
        /* heuristic */
        /* treat rest of differences */
        specialize_concept_definition(RestDD,BL,OldConcept,Concept),
        /* replace Part by must(Part) */
        concept_template(Concept,Template),
        list_remove(Part,Template,Template1),
        NewTemplate = [must(Part)|Template1],
        alter_concept_template(Concept,NewTemplate,NewConcept).

specialize_concept_definition([partial([Part,_])|RestDD],BL,OldConcept,
                                                            NewConcept):-
        !,
        /* a partial match - treat like missing constraint */
        specialize_concept_definition(RestDD,BL,OldConcept,Concept),
        /* replace Part by must(Part) */
        concept_template(Concept,Template),
        list_remove(Part,Template,Template1),
        NewTemplate = [must(Part)|Template1],
        alter_concept_template(Concept,NewTemplate,NewConcept).

/********************************************************************/
/*                                                                  */
/*  call        :  variabilize_fact(+Fact,+BindingList,-VarFact)    */
/*                                                                  */
/*  arguments   : Fact        =                                     */
/*                BindingList = List of Current Bindings            */
/*                VarFact     =                                     */
/*                                                                  */
/********************************************************************/
/* Replaces each argument in Fact by the first variable in          */
/* BindingList which has that argument as its binding; if there is  */
/* none, the argumnet is left as it is.                             */
/********************************************************************/

variabilize_fact(Fact,BL,VarFact):-
        Fact =.. [Functor|Args],
        variabilize_list(Args,BL,VarArgs),
        VarFact =.. [Functor|VarArgs].

variabilize_list([],_,[]):- !.
variabilize_list([FirstArg|RestArgs],BL,[var(VarFirstArg)|VarRestArgs]):-
        get_variable_p(FirstArg,BL,VarFirstArg),
        !,
        variabilize_list(RestArgs,BL,VarRestArgs).
variabilize_list([FirstArg|RestArgs],BL,[FirstArg|VarRestArgs]):-
        !,
        variabilize_list(RestArgs,BL,VarRestArgs).

/********************************************************************/
/*                                                                  */
/*  call        :  generalize_concept_definition(                   */
/*                               +DifferenceDescriptions,           */
/*                               +OldConcept,-NewConcept)           */
/*                                                                  */
/*  arguments   : DifferenceDescriptions  = Difference Description  */
/*                OldConcept              = Current Concept Defi.   */
/*                NewConcept              = New Concept Definition  */
/*                                                                  */
/********************************************************************/
/* Generalize the supplied concept definition by weakening and/or   */
/* removing constraints from its sufficient conditions NOTE: if you */
/* pass differences involving necessary conditions ("must"),        */
/* generalization may result in the concept covering negative       */
/* examples again.                                                  */
/********************************************************************/
generalize_concept_definition([],C,C):- !.
generalize_concept_definition([partial([Constraint,ExampleFact])|RestDD],
                                                 OldConcept,NewConcept):-
        !,
        /* a partial match was found, i.e., one arg in Constraint and */
        /* Factis different. If there is common parent in the ako     */
        /* hierarchy for both, use the parent in the new constraint.  */
        /* If there isn't, use a new variable */
        generalize_arg(Constraint,ExampleFact,NewConstraint),
        /* treat rest of differences */
        generalize_concept_definition(RestDD,OldConcept,RestConcept),
        concept_template(RestConcept,Template),
        list_remove(Constraint,Template,Template1),
        NewTemplate = [NewConstraint|Template1],
        alter_concept_template(RestConcept,NewTemplate,NewConcept).

generalize_concept_definition([missing(Constraint)|RestDD],OldConcept,
                                                          NewConcept):-
        !,
        /* a constraint was missing from the example - use */
        /* drop-link heuristic */
        generalize_concept_definition(RestDD,OldConcept,RestConcept),
        concept_template(RestConcept,Template),
        list_remove(Constraint,Template,NewTemplate),
        alter_concept_template(RestConcept,NewTemplate,NewConcept).

generalize_concept_definition([_|RestDD],OldSC,RestSC):-
        /* this must be an additional example fact - don't know */
        /* what to do with them, so ignore and treat rest of    */
        /* differences */
        generalize_concept_definition(RestDD,OldSC,RestSC).

generalize_arg(must(Constraint),ExampleFact,must(NewConstraint)):-
        !,
        generalize_arg(Constraint,ExampleFact,NewConstraint).

generalize_arg(Constraint,ExampleFact,NewConstraint):-
        Constraint =.. [Functor|Args1],
        ExampleFact =.. [Functor|Args2],
        generalize_arg1(Args1,Args2,NewArgs1),
        NewConstraint =.. [Functor|NewArgs1].

generalize_arg1([],[],[]):- !.
generalize_arg1([Arg1|Rest1],[Arg2|Rest2],[Arg1|GenRest]):-
        (Arg1 = Arg2 ; Arg1 = var(_)),
        !,
        generalize_arg1(Rest1,Rest2,GenRest).
generalize_arg1([Arg1|Rest1],[Arg2|_],[GenArg|Rest1]):-
        !,
        /* o.k., this is it - can we generalize them? */
        find_or_create_common_ancestor(Arg1,Arg2,GenArg).

find_or_create_common_ancestor(Class1,Class2,Ancestor):-
        ancestors(Class1,Ancestors1),
        ancestors(Class2,Ancestors2),
        smallest_ancestor_p(Ancestors1,Ancestors2,Ancestor),
        !.
find_or_create_common_ancestor(Class1,Class2,Ancestor):-
        !,
        /* create a new name */
        concat(Class1,Class2,Ancestor),
        /* and record its relation to existing classes */
        assertz(ako(Class1,Ancestor)),
        assertz(ako(Class2,Ancestor)).

ancestors(Class,Ancestors):-
        ancestors1([Class],[],Ancestors).

ancestors1([],Ancestors,Ancestors):- !.
ancestors1([First|Rest],Ancestors,ExtendedAncestors):-
        direct_ancestors(First,FirstAncestors),
        not(FirstAncestors = []),
        !,
        append(FirstAncestors,Rest,NewClassList),
        union(Ancestors,FirstAncestors,NewAncestorList),
        ancestors1(NewClassList,NewAncestorList,ExtendedAncestors).
ancestors1([First|Rest],Ancestors,ExtendedAncestors):-
        !,
        /* no ancestors */
	union([First],Ancestors,NewAncestors),
        ancestors1(Rest,NewAncestors,ExtendedAncestors).

direct_ancestors(Class,Ancestors):-
        !,
        findbag(Ancestor,ako(Class,Ancestor),Ancestors).

smallest_ancestor_p([First|_],Ancestors2,First):-
        member(First,Ancestors2),
        !.
smallest_ancestor_p([_|Rest],Ancestors2,Ancestor):-
        !,
        smallest_ancestor_p(Rest,Ancestors2,Ancestor).

/********************************************************************/
/*                                                                  */
/*  call        :  list_remove(+Target,+List,-Rest)                 */
/*                                                                  */
/*  arguments   : Target  =                                         */
/*                List    =                                         */
/*                Rest    = List without Target                     */
/*                                                                  */
/********************************************************************/
/* Remove all elements of List that unify with Target, return the   */
/* Rest.                                                            */
/********************************************************************/

list_remove(_,[],[]):- !.
list_remove(Target,[Target|Rest],RestRemoved):-
        !,
        list_remove(Target,Rest,RestRemoved).
list_remove(Target,[First|Rest],[First|RestRemoved]):-
        list_remove(Target,Rest,RestRemoved).

/********************************************************************/
/*                                                                  */
/*  call        : msgs(+List)                                       */
/*                                                                  */
/*  arguments   : List = of Elements which should be displayed on   */
/*                       current output device                      */
/*                                                                  */
/********************************************************************/
/* Display the Elements of the List on the current output device.   */
/* The following constants are handled in a special way:            */
/*                                                                  */
/*   nl      - forces a single linefeed                             */
/*   nl(X)   - forces the number of linefeeds given by X            */
/*   sp      - forces a single space                                */
/*   nl(X)   - forces the number of spaces given by X               */
/*   pf(X,Y) - uses print function X to display Y                   */
/*                                                                  */
/* Every other element is outputed in the normal "print"-way.       */
/********************************************************************/

msgs([]):- !.
msgs([First|Rest]):-
        msg(First),
        msgs(Rest),!.

msg(nl):-
        !, nl.
msg(nl(N)):-
        !, repeat(N,nl).
msg(sp):-
        !, write(' ').
msg(sp(N)):-
        !, repeat(N,write(' ')).
msg(pf(PF,Object)):-
        !,
        Call =.. [PF,Object],
        call(Call).
msg(Object):-
        write(Object), !.

/********************************************************************/
/*                                                                  */
/*  call        : repeat(+Number,+Call)                             */
/*                                                                  */
/*  arguments   : Number = Number of times                          */
/*                Call   = Procedure call                           */
/*                                                                  */
/********************************************************************/
/* Repeats Call Number times.                                       */
/********************************************************************/
repeat(N,_):-
        N < 1,
        !.
repeat(N,Call):-
        Call,
        N1 is N - 1,
        repeat(N1,Call), !.

set_equal_p([],[]):- !.
set_equal_p([First|Rest],Set2):-
        enumerate(Set2,First,Rest2),
        !,
        set_equal_p(Rest,Rest2).

/********************************************************************/
/* remove_duplicates                                                */
/********************************************************************/
/* with an additional EqualP                                        */
/********************************************************************/
remove_duplicates([],[],_):- !.
remove_duplicates([First|Rest],Result,EqualP):-
        remove_duplicates(Rest,RestResult,EqualP),
        remove_duplicates_result(First,RestResult,Result,EqualP).

remove_duplicates_result(First,RestResult,RestResult,EqualP):-
        member(First,RestResult,EqualP), !.
remove_duplicates_result(First,RestResult,[First|RestResult],_).

/********************************************************************/
/*                                                                  */
/*  call        : list_sort(+List,-SortedList,+ComparisonPredicate) */
/*                                                                  */
/*  arguments   : List                          =                   */
/*                SortedList                    =                   */
/*                ComparisonPredicateDifference =                   */
/*                                                                  */
/********************************************************************/
/* An insertion sort  !                                             */
/* SortedList has the same members as List and is sorted according  */
/* to ComparisonPredicate (a before b if ComparisonPredicate(a,b)). */
/********************************************************************/
list_sort([],[],_).
list_sort([X|L],M,O):-
        list_sort(L,N,O),
        list_sort1(X,N,M,O).

list_sort1(X,[A|L],[A|M],O):-
        P =.. [O,A,X],
        call(P),
        !,
        list_sort1(X,L,M,O).
list_sort1(X,L,[X|L],_).

/********************************************************************/
/*                                                                  */
/*  call        : get_best(+SortedList,-Best,+OrderP)               */
/*                                                                  */
/*  arguments   : SortedList =                                      */
/*                Best       =                                      */
/*                OrderP     =                                      */
/*                                                                  */
/********************************************************************/
/* get_best returns the elements with the top score in SortedList   */
/* (which must be sorted according to OrderP).                      */
/********************************************************************/

get_best([],[],_).
get_best([Single],[Single],_).
get_best([First,Second|_],[First],ComparisonP):-
        Call =.. [ComparisonP,First,Second],
        call(Call),
        /* the next match is worse - we've found all the best matches */
        !.
get_best([First,Second|Rest],[First|RestBest],ComparisonP):-
        /* keep looking */
        !,
        get_best([Second|Rest],RestBest,ComparisonP).

/********************************************************************/
/*                                                                  */
/*  call        : enumerate(!List,?Head,?Rest)                      */
/*                                                                  */
/*  arguments   : List =                                            */
/*                Head =                                            */
/*                Rest =                                            */
/*                                                                  */
/********************************************************************/
/* Enumerates heads of List on backtracking, Rest is always List    */
/* with current Head removed.                                       */
/********************************************************************/

enumerate([Head|Tail],Head,Tail).
enumerate([Head|Tail],NextHead,[Head|NextRest]):-
        enumerate(Tail,NextHead,NextRest).

/********************************************************************/
/*                                                                  */
/*  call        : list_add_if_necessary(+NewElement,+List,-NewList) */
/*                                                                  */
/*  arguments   : NewElementList =                                  */
/*                List           =                                  */
/*                NewList        =                                  */
/*                                                                  */
/********************************************************************/
/* Adds NewElement to List if it is not already there; result is    */
/* NewList                                                          */
/********************************************************************/

list_add_if_necessary(NewElement,List,List):-
        member(NewElement,List),
        !.
list_add_if_necessary(NewElement,List,NewList):-
        NewList = [NewElement|List],
        !.

/********************************************************************/
/*                                                                  */
/*  call        : concat(Atom1,Atom2,Atom3)                         */
/*                                                                  */
/*  arguments   : Atom1 =                                           */
/*                Atom2 =                                           */
/*                Atom3 =                                           */
/*                                                                  */
/********************************************************************/
/* Concatenates Atom1 and Atom2 to Atom3, or splits Atom3 in two    */
/* ways if Atom1 is instantiated than the rest of Atom3 is returned */
/* in Atom2 or if Atom2 is instantiated than the Atom1 becomes the  */
/* prefix of Atom3 without Atom1. Two arguments must be instantiated*/
/* otherwise the predicate fails.                                   */
/********************************************************************/

concat(S1,S2,S3) :-
    nonvar(S1),
    nonvar(S2),
    name(S1,L1),
    name(S2,L2),
    append(L1,L2,L3),
    name(S3,L3),
    !.

concat(S1,S2,S3) :-
    nonvar(S1),
    nonvar(S3),
    name(S1,L1),
    name(S3,L3),
    append(L1,L2,L3),
    name(S2,L2),
    !.

concat(S1,S2,S3) :-
    nonvar(S2),
    nonvar(S3),
    name(S2,L2),
    name(S3,L3),
    append(L1,L2,L3),
    name(S1,L1),
    !.

/********************************************************************/
/*                                                                  */
/*  call        : member(Element,List,EqualP)                       */
/*                                                                  */
/*  arguments   : Element =                                         */
/*                List    =                                         */
/*                EqualP  =                                         */
/*                                                                  */
/********************************************************************/
/* The common member predicate extend by an additional EqualP to be */
/* used for membership test.                                        */
/********************************************************************/
member(_,List,_) :-
        var(List),
        !,
        List is [],
        fail.
member(E,[First|_],EqualP):-
        Call =.. [EqualP,E,First],
        call(Call).
member(E,[_|R],EqualP) :- member(E,R,EqualP).

:- dynamic found/1.

findbag(X,G,_) :-                                              
     asserta(found(mark)), call(G),                         
       asserta(found(X)), fail .                            
findbag(_,_,L) :-                                              
     collect_found([],L) .                                     
                                                              
collect_found(L,L1) :-                                       
     getnext(X), collect_found([X|L],L1) .                      
collect_found(L,L) .                                        
                                                              
getnext(X) :-                                               
     retract(found(X)), !, not (X == mark) .                

union([],X,X).
union([X|R],Y,Z) :-
      member(X,Y), !, union(R,Y,Z).
union([X|R],Y,[X|Z]) :-
      union(R,Y,Z).

help :- write('Load data set with command: [Filename].'), nl,
  write('Start arch1   with command: process_stored_inputs(ConceptName).'), nl.
   
:- help.
