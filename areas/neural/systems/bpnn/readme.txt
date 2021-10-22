-------------------------------------------------------------------------------
                Back Propagation Neural Net Engine v1.33u
                           for C programmers

                          by Patrick Ko Shu-pui

                  Copyright (c) 1991, 1992 All Rights Reserved.
-------------------------------------------------------------------------------
ADDRESS TO CONTACT:

            internet: ko053@cs.cuhk.hk
            fidonet:  patrick ko, 6:700/132 BiG Programming Club 

            mailing:  Patrick Ko
                      No.11, 14 ST.,
                      Hong Lok Yuen,
                      Tai Po, Hong Kong
-------------------------------------------------------------------------------
WHATS NEW in v1.31u:

        -       adaptive learning coefficients
        -       C-programmer-friendly C sources
        -       periodic neural net dump

WHATS NEW in v1.32u:

	-	support response file and inline comments
	-	configurable random weight range
	-	configurable tolerance error

WHATS NEW in v1.33u

	-	bug fix in cparser multiple @files

HOW TO COMPILE:

        This version support 2 platforms:

        1.      DOS under PC - use Borland's MAKE with makefile.dos and TCC 2.0
	2.	Ultrix under DECstation - use makefile.ux
	3.	SUNs - use makefile.ux


WHAT IS Bptrain and Bprecog?
Bptrain is a program to let you create your Neural Net with desired topology
(subject to some limitations, see CONSTANT) and you may train this NN with
back propagation algorithm found in the REFERENCE.

Bprecog is a program to let you create the NN that could read back the
stablized weights generated from Bptrain and use these weights to recognize
some new or old patterns.


HOW TO USE?
Step 1:		Define a training file, specifying all input patterns
                and expected output.
                For example, if your input is 2 units and output 1 unit,
                and you have 4 patterns to train, (See DEMO1.TRN)
                you write:
                        +-+----------- input
			0 0  0
			0 1  1
			1 0  1
			1 1  0
                             +-------- output

                NOTE: all the input/output values must be normalized.
                That is, they should be within the range of 0 to 1.

Step 2:		Define a recognizing file, containing another set of
                input patterns which you would like to recognize.
                For example, if after Step 1 you would like your NN to
                recognize 1 0 and 0.99 0.02, (See DEMO1.RGN)
                you write:
                        +-+----------- input
                        1 0
                        0.99 0.02

Step 3:         Configure your NN topology by specifying it to BOTH
                BPTRAIN and BPRECOG. (See DEMO1.BAT)

Step 4:         After BPTRAIN, it will output a DUMP file which contains
                the adapted weights for the NN. Run BPRECOG afterwards and
                it will output a OUT file (you may specify its name) which
                contains the result of the recognizing file. For example,
                the result from DEMO1.RGN may become:

                        0.9965    (very close to 1)
                        0.0013    (very close to 0)

Please refer to the two demostration file DEMO1.BAT and DEMO2.BAT.

NOTE: in v1.32u I have introduced the response file feature.  Please refer
      to the files *.rsp together with the .bat files for details.  Also
      please note that in the response file '//' is treated as comments at
      the beginning of non-space characters in each line. 


CONSTRAINTS
- The Neural Net (NN) created is fully connected.


REFERENCE
"Learning Internal Representations by Error Propagation", D.E.Rumelhart.,
G.E.Hinton., and R.J.Williams, Chapter 8 of Parallel Distributed Processing,
Vol 1., MIT Press, Cambridge, Massachusetts.

"An Adaptive Training Algorithm for Back Propagation Networks", L.W.Chan.,
and F.Fallside. Computer Speech and Language (1987) 2, pp.205-218.

AUTHOR
All the sources are written by Patrick KO Shu Pui

===============================================================================
AUTHORIZATION NOTICE

This C source package BPNN133U.ZIP(or bpnn133u.tar.Z) is FREELY
DISTRIBUTABLE under all circumstances.

This C source package BPNN133U.ZIP(or bpnn133u.tar.Z) is FREE to be
used for ACADEMIC purpose only.  It is freely modifiable, included in
any other sources, projects, or whosoever provided that the author's
name is acknowledged.

For COMMERCIAL use, authorization is required from the author.
Please contact the author via any channel stated above.
===============================================================================

