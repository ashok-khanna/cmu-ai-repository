gibberish.zip
    Prolog Government-binding parser.
    Cameron Shelley, University of Waterloo.

                        GOVERNMENT-BINDING PARSER
                            Cameron Shelley,
                         University of Waterloo
                           Contributed in 1991


This is a first attempt at a Government-Binding (GB) type parser. This
parser is intended as an introductory 'toy' parser for
natural-language-understanding courses, so complexity will be kept to a
minimum while still being general enough to be easily extended. All
constraints have been been implemented as explicit Prolog goals for
perspicuity. Many optimizations are possible! The gapping mechanism
actually performs a transformation of the sentence into a 'normal' form
and so has been made general enough to move arbitrary structures through
the parse tree. [CS]

I have found this a useful tool in building a simple
natural-language-controlled agent. [JNP] 


SIZE: kilobytes


CHECKED ON EDINBURGH-COMPATIBLE (POPLOG) PROLOG : yes.


PORTABILITY : no problems.


INTERNAL DOCUMENTATION : Each predicate is commented with its purpose
and arguments. There is a set of test sentences, and a brief
introduction to using the parser, together with suggestions for
improvements.

Origin:       src.doc.ic.ac.uk:packages/prolog-pd-software/ (146.169.2.1)
    
