/********************************************************************/
/* cobweb_2.pro         Last modification: Sun 2 Feb  1992 12:47:41 */
/********************************************************************/

/********************************************************************/
/* COBWEB example data-set: Rectangle descriptions                  */
/* Source: from J. Gennari, P. Langley, D. Fisher:                  */
/*              'Models of Incremental Concept Formation',          */
/*              AI 40, 1989, page 41, Fig. 6-10                     */
/********************************************************************/

% Description of the features as a list of (type and name)

features([[numeric,ht],
          [numeric,wid],
          [numeric,txt]]).

% Description of the cases
% (first element: case-id (will not be used in clustering),
%  rest: feature values in accordance to the description of features above)

case([firstInstance,14.0,7.0,8.0]).
case([secondInstance,12.0,7.0,20.0]).
case([thirdInstance,25.0,15.0,24.0]).
case([fourthInstance,28.0,13.0,19.0]).
case([fifthInstance,41.0,36.0,30.0]).
case([sixthInstance,12.0,6.0,7.0]).
