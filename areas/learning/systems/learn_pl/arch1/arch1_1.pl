/********************************************************************/
/* Each example is represented by a set of Prolog facts. The arch   */
/* examples in Winston's book come out as follows:                  */
/********************************************************************/

input(1,example,arch,
        [part(part1),part(part2),part(part3),
         isa(part1,brick), isa(part2,brick), isa(part3,brick),
         left_of(part2,part1),
         supports(part1,part3), supports(part2,part3)]).
input(2,near_miss,arch,
        [part(part1), isa(part2,brick), part(part2),
        left_of(part2,part1),part(part3),
         isa(part1,brick), isa(part3,brick)]).
input(3,near_miss,arch,
        [part(part1),part(part2),part(part3),
         isa(part1,brick), isa(part2,brick), isa(part3,brick),
         left_of(part2,part1), touches(part1,part2),
         supports(part1,part3), supports(part2,part3)]).
input(4,example,arch,
        [part(part1),part(part2),part(part3),
         isa(part1,brick), isa(part2,brick), isa(part3,wedge),
         left_of(part2,part1),
         supports(part1,part3), supports(part2,part3)]).
input(5,near_miss,arch,
         [part(part1),part(part2),part(part3),
          isa(part1,brick), isa(part2,brick), isa(part3,cylinder),
          left_of(part2,part1),
          supports(part1,part3), supports(part2,part3)]).
	  
/********************************************************************/
/* background knowledge                                             */
/********************************************************************/
/* infer - used during matching to try to infer facts that might    */
/*         match.                                                   */
/* Careful - match doesn't check for cycles in the inference chain. */
/********************************************************************/

infer(touch(O1,O2),touch(O2,O1)).

infer(isa(Object,Type1),isa(Object,Type2)):-
        !,
        ako(Type1,Type2).

/********************************************************************/
/* ako - represent taxonomies                                       */
/********************************************************************/

ako(brick,parallel_epiphed).
ako(wedge,parallel_epiphed).

