		Release of Beta-Prolog (Version 1.1)
	            Latest update: March 1994

      Beta-Prolog is an experimental Prolog system that provides many
      facilities for specifying and solving combinatorial problems. It
      supports the definition and manipulation of Boolean tables which can
      be used to represent graphs, simple and hierarchical domains, and
      situations in various combinatorial problems. Beta-Prolog also
      provides several primitives for describing constraint satisfaction 
      problems declaratively.

      The Beta-Prolog system consists of an emulator of the TOAM (matching
      Tree Oriented Abstract Machine) written in C and a compiler of
      Beta-Prolog written in Beta-Prolog itself. It differs from
      WAM-based systems mainly in the following two aspects: (1) It
      translates predicates into trees and generates multi-level hashing
      code for predicates; (2) It passes arguments directly in stack frames
      like most compilers of procedural languages.  

      Beta-Prolog is currently one of the fastest emulator-based Prolog
      systems. It will be of interest to Prolog users, programmers
      investigating search algorithms for combinatorial problems, and
      researchers who want to develop high-performance Prolog systems and/or
      evaluate compilation techniques for Prolog.

      Please send all comments and bug reports to:
		Neng-Fa Zhou
		zhou@mse.kyutech.ac.jp
		Faculty of Computer Science and Systems Engineering
		Kyushu Institute of Technology
      		680-4 Kawazu, Iizuka, Fukuoka 820, Japan
		phone 81-948-29-7774
		fax 81-948-29-7760.
