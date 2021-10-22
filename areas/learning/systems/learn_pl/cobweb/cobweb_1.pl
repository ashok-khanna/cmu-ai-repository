/********************************************************************/
/* cobweb_1.pro         Last modification: Sun 2 Feb  1992 12:47:23 */
/********************************************************************/

/********************************************************************/
/* Data set describing a set of fictitious hotels (price per room,  */
/* furnishings). The learning result should be a grouping into cheap*/
/* and luxury hotels.                                               */
/********************************************************************/

% Description of the features as a list of (type and name)

features([[numeric,minPrice],                 % minimum price per room
          [nominal,tv],                       % room with TV?
	  [nominal,bar]]).                    % room with bar?

% Description of the cases
% (first element: case-id (will not be used in clustering),
%  rest: feature values in accordance to the description of features above)

case([sheraton,250.0,y,y]).
case([ritz,223.0,y,y]).
case([kempinski,224.0,y,y]).
case([sonja,40.0,n,y]).
case([ostermann,35,n,n]).
case([zur_gruenen_wiese,50,y,n]).
