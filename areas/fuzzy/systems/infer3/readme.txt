DOCUMENTATATION FOR THE "JAPANESE FUZZY INFERENCE LIBRARY"

John Nagle

July, 1993

INTRODUCTION

      A "General Purpose Fuzzy Reasoning Library" is available from the
University of Tokyo.  The documentation is in Japanese.  This is a set of
English-language documentation for that library.


HOW TO GET THE LIBRARY

The "General Purpose Fuzzy Reasoning Library" is available via anonymous FTP
from 

	Server: utsun.s.u-tokyo.ac.jp	 [133.11.11.11]
	
	File:	fj/fj.sources/v25/2577.Z
	
	This yields the "General-Purpose Fuzzy Inference Library Ver. 
3.0 (1/1)".  Use "uncompress" to decompress it, then "uudecode" to
convert it from text to a binary file, then "uncompress" again, and
finally "tar" to unpack the resulting file.

The program is in C, with English comments, but the documentation is in 
Japanese.

----- 
THE ORIGINAL "README" FILE, translated to English.

(Translation by Michiaki Nakayama at the Stanford Computer Systems Laboratory)

General Purpose Fuzzy Reasoning Library Ver.3.0

     (c) 1991 Kohichi Numata
	 
	If you use "rule read-in" functions of the general purpose fuzzy 
reasoning library, it reads fuzzy reasoning information from a certain format 
file (rule file) and returns that to a structure. Therefore, only editing the 
rule file enables you try and error.
	Reasoning functions of this library return the reasoned value of the 
output variables when you input an array of every input variable and a 
structure, which was mentioned before, as parameters. So, it makes fuzzy 
reasoning operation blackbox-like. 		
	This library includes some sped-up operations in which inner 
operations are done with integers. I intended to write it according to ANSI 
standard; most compilers might be able to compile this library.
	Programming of fuzzy reasoning is quite troublesome, if you would do 
it from the beginning. I would be happy if this library reduces your effort. 
This has nothing to do with those people who has nothing to do with fuzzy 
reasoning, but I'd like to recommend to touch it before it disappears(??).
		
		
		University of Electric and communications   	Kohichi Numata
		numata@qr.cas.uec.ac.jp	 
		
-----
Documentation for the program obtained by analyzing the code.
(by John Nagle, Stanford CSL)

SUMMARY

     This is a simple implementation of standard fuzzy inference, implemented
as a C function library. It reads fuzzy rules from a text file, and 
initializes a data structure based on that file, after which a function 
can be called with a set of values from which a single output value, 
inferred according to the rules, will be generated.  No "adaptive" or 
"learning" capability is provided.
The implementation is straightforward, and does not use known optimizations of
the algorithm.  The code is well-written and easy to follow, with comments and
variable names in English, even though the original documentation is in 
Japanese.

FORMAT OF THE RULE FILE

The rule file is divided into three sections.

The first section defines the variables. There can be up to MAX_N_IN_VAR (a
constant in "infer3.h") input variables, and there is exactly one output 
variable, which must be the last variable defined.

For each variable, there is a line of the form:

	varname	lowbound highbound
	
which defines the range of the input or output variable.  For input variables,
this range is used only by the integer version of the package, which scales
input variables into the range 0..255 based on these bounds.  For output
variables, this value will be used in conjunction with the "NEP" value set
below to divide the output range into N equal parts.  So variable ranges should
be as narrow as possible to cover the expected values of the variables.  Overly
large ranges will reduce output resolution.
 	
The range line is followed by a block of fuzzy value name definitions of the 
form:

	valuename	a b c d
	
The trapezoid defined by a,b,c,d determines the translation from the input
numeric value to the fuzzy value named "valuename".
The values a,b,c,d define a trapezoid, in the usual fuzzy rule sense, as shown
below.

       o         ________
       u        /        \
       t       /          \
           ___/            \___
       in     A  B       C  D


Each block of fuzzy value name definitions is terminated by a blank line.  
There must be at least one fuzzy value name line; it may be be preceded by 
blank lines.

The second section of the file defines the rules, and begins with a line of the form

	SW	varname varname varname ...
	
	for which the "varname" names must be the ones defined above, in the 
same order.
This line forms the header for the rule table to follow.

Rules are of the form

	ON	var1valuename var2valuename var3valuename...
or 
	OFF var1valuename var2valuename var3valuename...

and a blank line ends the rule section.  Only lines beginning with "ON" are
actually used.  A "valuename" of "IG" indicates that the input for that
column is to be ignored.

The third and last section is one line of the form

	NEP	nnn
	
which defines the "number of equal parts" used for the brute-force integration
to find the centroid of the output fuzzy result.  The range specified for the
output variable is divided into this number of equal parts. Thus, the specified
output range and the number of equal parts sets an upper limit on the precision
of the output.


AN ANNOTATED SAMPLE RULE FILE

A sample rule file is provided with the program, and it is reproduced here
with comments.  Unfortunately, comments in rule files are not supported by the
program, so this text with comments is not a valid rule file in this form. 
Everything after a "--" is a comment.

SL	-100	1400		-- Defines input variable SL, range -100..1400
				-- Optional blank line
S	-1e38	-1e38	600	800	-- Fuzzy value S for variable SL
L	600	800	1e38	1e38	-- Fuzzy value L for variable SL
				-- Required blank line ends variable block
D	-800	800		-- Defines input variable D, range -800..800
N1	-1e38	-1e38	-800	400		-- Fuzzy value N1
P1	-400	800	1e38	1e38		-- Fuzzy value P1
				-- Required blank line
BL	-3	3		-- Defines the output variable BL, range -3..3
N2	-3	-1	-1	1		-- 	Fuzzy value N2
P2	-1	1	1	3		-- 	Fuzzy value P2
Z2	-2	0	0	2		-- 	Fuzzy value Z2
				-- Required blank line
SW	SL	D	BL		-- 	Rule header line 
				-- Optional blank line
ON	S	N1	Z2		-- 	Rule: S and N1 implies Z2
ON	L	P1	Z2		-- 	Rule: L and P1 implies Z2
ON	L	N1	N2		-- 	Rule: L and N1 implies N2
ON	S	P1	P2		-- 	Rule: S and P1 implies P2.
					-- Required blank line.

NEP	256			-- Number of equal parts for integration.

----
CALLING THE FUNCTIONS

Usage is very simple. There are two sets of functions, one which does all 
calculations in floating point and one which does the time-consuming 
calculations in integer arithmetic.  The latter functions begin with "u", 
but take the same arguments and return the same results as the floating 
point forms.

ReadRule reads in a rule file, as defined above.  It initializes and
fills in the FUZZ_INFO structure. ReadRule returns one of the following values

	RR_OK			0	Rules read successfully
	RR_OVER_MAX		(-1)	Table sizes in infer3.h overflowed.
	RR_SHORT_FILE		(-2)	EOF before rule file complete
	RR_SHORT_LINE		(-3)	End of line before rule line complete
	RR_UNDEFINED_KEYWORD	(-4)	Unknown keyword where keyword required
	RR_UNDEFINED_SYMBOL	(-5)	Undefined variable name where required


Infer does one fuzzy inference.  It takes an array of floating point values,
one for each input variable, and returns a single floating-point result.

uReadRule and uInfer operate similarly, but use mostly integer computations.

/*
	Exported functions  -- floating point version
*/
extern int ReadRule(FILE *fp, FUZZ_INFO *fzf);
extern float Infer(const float InVar[], const FUZZ_INFO *fzf);
/*
	Exported functions  --  integer version
*/
extern int uReadRule(FILE *fp, uFUZZ_INFO *fzf);
extern float uInfer(const float InVar[], const uFUZZ_INFO *fzf);

PERFORMANCE

    Performance is not especially fast, primarily because of the brute-force
approach to finding the centroid of the summed result.  The algorithm is a
naive implementation of the classic fuzzy logic inference technique.
