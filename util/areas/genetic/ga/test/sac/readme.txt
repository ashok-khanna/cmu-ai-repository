--- ../EC/etc/data/zero-one/$Id: README,v 1.1 1994/03/18 17:37:33 joke Exp $

**************
***  1993  ***
**************
  *  sac94-suite.tar.gz

This directory contains a collection of 0/1 Multiple Knapsack Problems,
that are well known from LITERATURE, and heuristically solved in the
following publications:

Tabu Search:
  F. Dammeyer and S. Voss (1991) "Dynamic tabu list management using
    the reverse elimination method."
    Annals of Operations Research.

Simulated Annealing:
  A. Drexel (1988) "A Simulated Annealing Approach to the Multiconstraint
    Zero-One Knapsack Problem."
    Computing, 40:1-8.

Genetic Algorithms:
  S. Khuri, T. Baeck, J. Heitkoetter, (1994) "The Zero/One Multiple
    Knapsack Problem and Genetic Algorithms", to appear in the 1994
    ACM Symposium on Applied Computing, SAC'94, Phoenix, Arizona.
    See also: ../EC/GA/papers/sac94.ps.gz

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

LITERATURE
  C.C. Petersen (1967) "Computational experience with variants of the
    balas algorithm applied to the selection of R&D projects."
    Management Science, 13:736-750. [PET*.DAT]

  S. Senyu and Y. Toyada (1967) "An apparoach to linear programming
    with 0-1 variables."
    Management Science, 15:B196-B207. [SENTO*.DAT]

  H.M. Weingartner and D.N. Ness (1967) "Methods for the solution of
    the multi-dimensional 0/1 knapsack problem."
    Operations Research, 15:83-103. [WEING*.DAT]

  W. Shi (1979) "A branch and bound method for the multiconstraint
    zero one knapsack problem."
    J. Opl. Res. Soc., 30:369-378. [WEISH*.DAT]

  A. Freville and G. Plateau (1990) "Hard 0-1 multiknapsack testproblems
    for size reduction methods."
    Investigation Operativa, 1:251-270. [PB*.DAT, HP*.DAT]

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

FILE FORMAT
  The test data's file format, using 10 columns, whenever possible, is
  as follows:

  <n := #knapsacks> <m := #objects>
  <m weights of objects>
  <n knapsack capacities>
  <A := mxn mmatrice of constraints>

  <known optimum>

  <name>

  [ok]

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

EXAMPLE
  This is the WEING1.DAT data file plus some comments, that are NOT
  part of the problem instance!

  2  28  // 2 knapsacks, 28 objects
   1898    440  22507     270  14148   3100   4650  30800    615   4975
   1160   4225    510   11880    479    440    490    330    110    560
  24355   2885  11748    4550    750   3720   1950  10500  // 28 weigts
    600    600  // 2 knapsack capacities
     45      0     85     150     65     95     30      0    170      0
     40     25     20       0      0     25      0      0     25      0
    165      0     85       0      0      0      0    100  // #1 constr.
     30     20    125       5     80     25     35     73     12     15
     15     40      5      10     10     12     10      9      0     20
     60     40     50      36     49     40     19    150  // #2 constr.

  141278  // optimum value

  WEINGARTNER 1  // name of the game

  // sometimes an "ok" happens to be here, just ignore it...

-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-
  Please refer to the toplevel README file ../EC/README for further
  explanations. A handbook to this service is in ../EC/handbook.
-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-==-

