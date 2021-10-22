
This software is under development.  It is provided for comments and
suggestions.  No claims are made with respect to its completelness or
correctness.  Please send comments to: dbo@cs.utah.edu.

===

This directory contains sources for C++ classes used in defining fuzzy
variables.  Common manipulations of fuzzy variables are performed by the
"degree" and "membership" classes.  Arbitrary nonlinear membership
functions, as well as membership functions based on triangular piewise
membership are supported.

To define a fuzzy variable, invoke the "fuzzy" template with the
desired type:

fuzzy<int> height;

Triangular membership functions are defined using the "tri_member"
template.  x values may be any permissible value for the template
type.  The triangular membership constructor takes 3 x coordinates,
followed by the height (typically 1.0) to describe the membership
shape.

tri_member<int> TALL (48, 72, 96, 1);
tri_member<int> SHORT (48, 56, 96, 1);

Trapezoidal membership functions (including trapezoids which are
missing one of their triangular sides) may be defined using the
"trap_member" template.  The trapezoidal membership function takes 4 x
coordinates and a height to describe the membership shape.  The x
coordinates are as follows:

         x2   x3
         ******
	********
       **********
      *************
     ****************
     x1		    x4

For example:

trap_member<float> HIGH_TEMP (92.0, 103.0, 106.333, 106.33, 1.0);

defines the partial trapezoid (with height 1.0):

        103   106.66
         ******
	*******
       ********
      *********
     **********
    93	      106.66



Now, simple membership tests may be performed using the "is" operation
and boolean functions.  e.g.,

	height.is (TALL)
	!height.is (TALL) && temperature.is (HIGH_TEMP)

The result of these operations is a "degree" which is a scaled integer
whose values range [0,255] and represents real values [0,1] (degrees
of membership in the class).

Collections of membership functions may be grouped in fuzzy
associative memories (FAM's).  A fam is an NxN matrix of membership
functions.  Each dimension represents an input function to be applied
to an input variable.  The intersection represents the logical (fuzzy)
AND of the two resulting output sets.  The degree to which the AND
succeeds determines the degree to which the output membership function
applies to the output variable.

To define a FAM, one must first define the related membership
functions:

trap_member<int> NM (-128, -128, -64, -32, 1, "NM");
tri_member<int> NS (-64, -32,  0,  1, "NS");
tri_member<int> Z  (-32,   0,  32, 1, "Z");
tri_member<int> PS (  0,  32,  64, 1, "PS");
trap_member<int> PM ( 32,  64, 127, 127, 1, "PM");

The fam is defined with, a) its dimension, b) a row
representing the input membership functions (containing the addresses
of the relevant membership functions), and c) NxN rows of the
resulting output functions.


fam<int> pendemo(5,
	 &NM,	&NS,	&Z,	&PS,	&PM,

	 NULL,	NULL,	&PM,	NULL,	NULL,
	 NULL,	NULL,	&PS,	&NS,	NULL,
	 &PM,	&PS,	&Z,	&NS,	&NM,
	 NULL,	&PS,	&NS,	NULL,	NULL,
	 NULL,	NULL,	&NM,	NULL,	NULL
);


To apply a fam to two input variables and produce a third, the "apply"
method is used:

	fuzzy<int> theta (20, "theta");
	fuzzy<int> dTheta (-10, "dTheta");
	fuzzy<int> result (0, "result");


	pendemo.apply (theta, dTheta, result);

===

Early work on 3D fam surfaces is shown.  It compiles but hasn't been tested.

Again, this software is in a preliminary form.  Please use with care.

	Douglas Orr
	Center for Software Science
	University of Utah
	dbo@cs.utah.edu
