/********************************************************************/
/* cobweb_4.pro         Last modification: Sun 2 Feb  1992 12:46:30 */
/********************************************************************/

/********************************************************************/
/* COBWEB example data-set: Cell descriptions                       */
/* Source: from J. Gennari, P. Langley, D. Fisher:                  */
/*              'Models of Incremental Concept Formation',          */
/*              Artificial Intelligence 40, 1989, page 30, Fig. 3   */
/********************************************************************/

% Description of the features as a list of (type and name)

features([[nominal,tails],
          [nominal,color],
	  [nominal,nuclei]]).

% Description of the cases
% (first element: case-id (will not be used in clustering),
%  rest: feature values in accordance to the description of features above)

case([cell1,one,light,one]).
case([cell2,two,dark,two]).
case([cell3,two,light,two]).
case([cell4,one,dark,three]).

