=============================================================================
                        C++ SEARCH CLASS LIBRARY

                     Copyright (c) Peter M. Bouthoorn

                  ICCE, Groningen University, Netherlands
=============================================================================


DESCRIPTION
===========

The search class library is a software package I wrote during an internship.
It is meant to be used as a tool for developing problem solving software.
Basically, the library offers the programmer a set of search algorithms that
may be used to solve all kind of different problems. The idea is that when
developing problem solving software the programmer should be able to 
concentrate on the representation of the problem to be solved and should
not need to bother with the implementation of the search algorithm that will be
used to actually conduct the search. This idea has been realized by the
implementation of a set of search classes that may be incorporated in other
software through C++'s features of derivation and inheritance.  The following
search algorithms have been implemented:

    - depth-first tree and graph search.
    - breadth-first tree and graph search.
    - uniform-cost tree and graph search.
    - best-first search.
    - bidirectional depth-first tree and graph search.
    - bidirectional breadth-first tree and graph search.
    - AND/OR depth tree search.
    - AND/OR breadth tree search.

Using one of these search methods in your own programs is just a matter of
deriving a class from the desired search class and filling in the necessary
parts.
Turning the representation of the problem into actual source code is also made
easier because the library demands that certain functions be used (these 
- virtual - functions are called by several routines in the search library),
which helps standardizing this process.

Although this package is meant as a tool for developing problem solving 
software it is not meant exclusively for programmers that are familiar with
the concept of problem representation and search techniques. The document
accompanying this package first describes (though condensed) the theory of
problem solving in AI and next explains how the search class library must be
used. Furthermore, as the source code is richly commented and as also some
demo programs are included the package should also prove useful to people that
want to get acquainted with the subject.


If there are any probs, you can find me at:

peter@icce.rug.nl,
peter@freedom.nmsu.edu (thanks Jeff!)
