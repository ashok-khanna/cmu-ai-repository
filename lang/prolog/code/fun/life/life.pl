% John Horton Conway's "Game of Life"
% programmed in Sicstus Prolog by Jamie Andrews
% incorporating suggestions by William Clocksin
% posted to comp.lang.prolog, 8-MAR-94

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To use: life(Num_R, Num_C, Live_cells, Gen).
%
% Num_R and Num_C are the numbers of rows and columns on the board.
% Live_cells is a list of pairs [R|C], each indicating the
%   row and column of an initial live cell.
% Gen gets a similar list, indicating the rows and columns of
%   live cells in some future generation.
% Prints and returns successive generations upon backtracking.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Top-level predicates

life(Max_R, Max_C, Live_Cells, Some_future_gen) :-
  % you don't have to use "sort" if you make sure Initial_RCs is
  % always in "reading order".
  sort(Live_Cells, Board),
  future_gen(Board, Max_R, Max_C, Some_future_gen).

future_gen(Board, Max_R, Max_C, Board) :-
  printboard(Board, Max_R, Max_C).
future_gen(Board, Max_R, Max_C, New_Board) :-
  next_gen(Board, Max_R, Max_C, Mid_Board),
  !, % "green" cut for efficiency (needed?)
  future_gen(Mid_Board, Max_R, Max_C, New_Board).

% printboard/3
printboard(Board, Max_R, Max_C) :-
  printboard(Board, 1, Max_R, 1, Max_C).

% printboard/5
% Could be made more efficient if make use of "reading order".
printboard(_Board, R, Max_R, _, _) :-
  R > Max_R,
  !.
printboard(Board, R, Max_R, C, Max_C) :-
  C > Max_C,
  !,
  nl,
  R1 is R+1,
  printboard(Board, R1, Max_R, 1, Max_C).
printboard(Board, R, Max_R, C, Max_C) :-
  ( on(Board, R, C) ->
    write(' @') ;
    write(' .')
  ),
  C1 is C+1,
  printboard(Board, R, Max_R, C1, Max_C).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic engine

% Board, Adds, and Deletes are all lists of pairs [R|C],
% ordered in "reading order" (top to bottom, left to right).

% next_gen/4:
next_gen(Board, Max_R, Max_C, New_Board) :-
  updates(Board, 1, Max_R, 1, Max_C, Adds, Deletes),
  updated_version(Board, Adds, Deletes, New_Board).

updates(_Board, R, Max_R, _C, _Max_C, Adds, Deletes) :-
  R > Max_R,
  !,
  Adds = [],
  Deletes = [].
updates(Board, R, Max_R, C, Max_C, Adds, Deletes) :-
  C > Max_C,
  R1 is R+1,
  !,
  updates(Board, R1, Max_R, 1, Max_C, Adds, Deletes).
updates(Board, R, Max_R, C, Max_C, Adds, Deletes) :-
  number_of_neighbours(Board, R, C, N),
  updates1(N, Board, R, C, Adds, Later_adds, Deletes, Later_deletes),
  C1 is C+1,
  updates(Board, R, Max_R, C1, Max_C, Later_adds, Later_deletes).

% 2 neighbours: do nothing.
updates1(2, _Board, _R, _C, Adds, Adds, Deletes, Deletes) :-
  !.
% 3 neighbours, one already there: do nothing.
updates1(3, Board, R, C, Adds, Later_adds, Deletes, Later_deletes) :-
  on(Board, R, C),
  !,
  Later_adds = Adds,
  Later_deletes = Deletes.	% unifs at end for efficiency
% 3 neighbours, none there right now: add.
updates1(3, _Board, R, C, [[R|C]|Later_adds], Later_adds, Deletes, Deletes) :-
  !.
% < 2 or > 3 neighbours, one there: delete.
updates1(_N, Board, R, C, Adds, Later_adds, Deletes, Later_deletes) :-
  on(Board, R, C),
  !,
  Adds = Later_adds,
  Deletes = [[R|C]|Later_deletes].
% < 2 or > 3 neighbours, none there: do nothing.
updates1(_N, _Board, _R, _C, Adds, Adds, Deletes, Deletes).

% Does a merge of 1st and 2nd args, ignoring deletes.  Exploits
% the fact that all the lists are in "reading order".
updated_version([], Adds, _Deletes, Adds).
% If first add is before first in board, use it first
updated_version([[R|C]|Board], [[R1|C1]|Adds], Deletes, New_Board) :-
  (R1 < R ; (R1 = R, C1 < C)),
  !,
  New_Board = [[R1|C1]|New_Board1],
  updated_version([[R|C]|Board], Adds, Deletes, New_Board1).
% Otherwise, try first in board, but if it is really to be deleted,
% the delete will be the first in the list of deletes
updated_version([[R|C]|Board], Adds, [[R|C]|Deletes], New_Board) :-
  !,
  updated_version(Board, Adds, Deletes, New_Board).
% Otherwise, use first in board.
updated_version([[R|C]|Board], Adds, Deletes, [[R|C]|New_Board]) :-
  updated_version(Board, Adds, Deletes, New_Board).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Utilities

number_of_neighbours(Board, R, C, N) :-
  sum_number_on(
    [ [R-1|C-1],[R-1|C],[R-1|C+1],
      [R  |C-1],        [R  |C+1],
      [R+1|C-1],[R+1|C],[R+1|C+1] ],
    Board,
    0,
    N
  ).

sum_number_on([], _Board, Sofar, Sofar).
sum_number_on([[Row|Col]|Pairs], Board, Sofar, N) :-
  R is Row,
  C is Col,
  ( on(Board, R, C) ->
    ( Sofar1 is Sofar+1,
      sum_number_on(Pairs, Board, Sofar1, N)
    ) ;
    sum_number_on(Pairs, Board, Sofar, N)
  ).

% Requires R and C to be input; exploits the fact that the board
% is ordered in "reading order".
on([[R|C]|_], R, C) :-			% found it
  !.
on([[R|C1]|Board], R, C) :-		% same row, later column
  C1 < C,
  !,
  on(Board, R, C).
on([[R1|_C1]|Board], R, C) :-		% later row
  R1 < R,
  on(Board, R, C).

% EOF
