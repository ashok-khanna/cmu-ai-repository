example(+ object([A,B,C],[support(A,C),
			  support(B,C),
			  isa(A,rectangle),
			  isa(B,rectangle),
			  isa(C,rectangle)])).
example(- object([A,B,C],[support(A,C),
			  support(B,C),
			  touch(A,B),
			  isa(A,rectangle),
			  isa(B,rectangle),
			  isa(C,rectangle)])).
example(- object([A,B,C],[isa(A,rectangle),
			  isa(B,rectangle),
			  isa(C,rectangle)])).
example(+ object([A,B,C],[support(A,C),
			  support(B,C),
			  isa(A,rectangle),
			  isa(B,rectangle),
			  isa(C,triangle)])).


ako(figure,polygone).
ako(figure,circle).
ako(polygon,convex_poly).
ako(polygon,concave_poly).
ako(convex_poly,stable_poly).
ako(convex_poly,unstable_poly).
ako(stable_poly,triangle).
ako(stable_poly,rectangle).
ako(stable_poly,trapezium).
ako(unstable_poly,unstable_triangle).
ako(unstable_poly,hexagon).
