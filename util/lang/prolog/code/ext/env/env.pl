% From ok@goanna.cs.rmit.oz.au Fri Sep  2 13:58:21 EDT 1994
% Article: 11175 of comp.lang.prolog
% Path: cantaloupe.srv.cs.cmu.edu!das-news.harvard.edu!news2.near.net!MathWorks.Com!europa.eng.gtefsd.com!howland.reston.ans.net!agate!msuinfo!harbinger.cc.monash.edu.au!aggedor.rmit.EDU.AU!goanna.cs.rmit.oz.au!not-for-mail
% From: ok@goanna.cs.rmit.oz.au (Richard A. O'Keefe)
% Newsgroups: comp.lang.prolog
% Subject: Re: Writing Prolog version dependent code
% Date: 1 Sep 1994 20:09:12 +1000
% Organization: Comp Sci, RMIT, Melbourne, Australia
% Lines: 1515
% Message-ID: <344988$h32@goanna.cs.rmit.oz.au>
% References: <33g37o$i4o@lightning.ditc.npl.co.uk>
% NNTP-Posting-Host: goanna.cs.rmit.oz.au
% NNTP-Posting-User: ok
% 
% One of the things I always thought that the Prolog standard should do
% was to provide a practical analogue of C's <limits.h>, <float.h>,
% and the related things in POSIX.1.  I have not received the draft of
% the standard that was to be balloted, so I don't know if there was
% anything useful in that draft.  Certainly there wasn't in any of the
% earlier drafts.
% 
% Here is something I have posted to several Prolog implementors.
% I am currently adding POSIX.1-related stuff to the design.
% Adapt it to your system and stick it where [environment] will find it,
% and you're away laughing.
% 
% Note that tests for the existence of specific built-in predicates
% don't _begin_ to be enough in real programming.
% 
%   Package: environment
%   Author : Richard A. O'Keefe
%   Updated: September 1992
%   Purpose: Portability

%   Copyright (C) 1989, Quintus Computer Systems, Inc.  All rights reserved.

:- module(environment, [
	environment/1
   ]).

sccs_id('"@(#)89/11/12 environment.pl	200.9"').

/*  This is the "environment" table which has been developed by Richard
    O'Keefe for Quintus to try to improve portability of Prolog source code
    between the following systems:

	Quintus		Unix (BSD)
	Quintus		Unix (System V)
	Quintus		VMS
	Quintus		VM/SP (CMS)
	Quintus		MVS
	LPA		MS-DOS
	LPA		Macintosh
	SICStus		Unix (BSD)
	NU		Unix (BSD)

    For a description of the parameters, look after the first 'end_of_file.'
*/

%   environment(Feature)
%   BSD Unix version of the environment table.

environment(os(unix)).
environment(os_version([4,3,encore([4,0,0])])).
environment(dialect(quintus)).
environment(version([2,5])).
environment(var(width(10))).
environment(atom(X))		:- 'env atom'(X).
environment(string(_))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(T,W))	:- 'env type'(T, W).

'env atom'(size(511)).
'env atom'(min(1)).
'env atom'(max(255)).
'env atom'(width(X))		:- X is 511*4 + 2.
'env atom'(number(X))		:- X is 1 << 21.

'env integer'(size(29)).
'env integer'(small(X))		:- X is -1 << 28.
'env integer'(large(X))		:- X is -1 - (-1 << 28).
'env integer'(width(10)).
'env integer'(too_big(truncate)).
'env integer'(overflow(truncate)).

'env float'(size(28)).   
'env float'(too_big(infinity)).
'env float'(overflow(infinity)).
'env float'(confounded)		:- fail.
'env float'(b(2)).
'env float'(p(19)).
'env float'(emin(-125)).
'env float'(emax( 128)). 
'env float'(sigma(X))		:- scale(-126, 1.0, X).
'env float'(lambda(X))		:- scale(109, 524287.0, X).
'env float'(epsilon(X))		:- scale(-18, 1.0, X).
'env float'(max_integer( 524287.0)).
'env float'(min_integer(-524287.0)).
'env float'(pi(3.141592653589793238462643)).	% ROUNDED BY COMPILER!
'env float'(digits(6)).
'env float'(width(12)).
'env float'(mark(0'E)).
'env float'(radix(2)).
'env float'(mantissa(19)).
'env float'(small(X))		:- scale(-126, 1.0, X).
'env float'(large(X))		:- scale(109, 524287.0, X).
'env float'(machine(X))		:- 'env mac'(X).

scale(N, X0, X) :-
    (	N >= 4 -> X1 is X0 * 16.0,   N1 is N-4, scale(N1, X1, X)
    ;   N=< -4 -> X1 is X0 * 0.0625, N1 is N+4, scale(N1, X1, X)
    ;	N >  0 -> X1 is X0 * 2.0,    N1 is N-1, scale(N1, X1, X)
    ;   N <  0 -> X1 is X0 * 0.5,    N1 is N+1, scale(N1, X1, X)
    ;   X is X0
    ).

'env mac'(b(2)).
'env mac'(radix(2)).
'env mac'(rounds).
'env mac'(overflows)		:- fail.
'env mac'(format(ieee(short))).	%  no such animal, of course.

'env arity'(functor(255)).
'env arity'(call(255)).
'env arity'(foreign(255)).

'env stream'(read( user_input)).
'env stream'(write(user_output)).
'env stream'(error(user_error)).
'env stream'(trace(user_error)).

'env file'(size(1023)).		% pick up from PATH_MAX
'env file'(host(_)) :- fail.
'env file'(device(_)) :- fail.
'env file'(directory(255)).	% use 14 on System V
'env file'(depth(128)).
'env file'(name(255)).		% use 14 on System V
'env file'(type(253)).		% use 12 on System V
'env file'(base(255)).		% use 14 on System V
'env file'(version(_)) :- fail.

'env type'(source,	'pl').		% Use ".pl" extension for source code
'env type'(object,	'qof').		% Use ".qof" extension for compiled
'env type'(log,		'log').		% use for log files
'env type'(options,	'ini').		% Not the real BSD convention...

end_of_file.
/*
		Description of features.

os(OsName)

	OsName is an atom which identifies the "operating system".
	Really what it identifies is the file system.  Current
	values are
	    unix	BSD, SysV, POSIX, Ultrix, any of them.
	    vms		VAX/VMS 3.x, 4.x, 5.x
	    cms		IBM VM/CMS Release 4, 5, 6
	    mvs		IBM MVS
	    mac		Macintosh 128k (117) ROM or later
	    msdos	MS-DOS 3.x
	There are major differences between releases of some of
	these operating systems.  For example, an extension can
	be 39 characters in VMS 4.x, but only 3 in 3.x, and the
	CMS operating system didn't get directories until R6.
	Such differences are supposed to be covered by other
	environment parameters.

	Currently this parameter also serves to identify the
	character set:
	    unix	ISO 8859/1
	    vms		DEC MNCS (like ISO 8859 but has OE ligatures)
	    cms		EBCDIC
	    mvs		EBCDIC
	    mac		Mac extension of ASCII
	    msdos	PC extension of ASCII
	It is possible to discriminate these another way:

	(   " " =:= 64 -> ebcdic
	;   is_space(160) ->		% unbreakable space
	    (   is_alpha(215) -> mncs	% OE ligature in DEC MNCS
	    ;   iso_8859_1		% x (multiply) in ISO 8859/1
	    )
	;   is_alpha(160) -> pc		% a-acute
	;   mac				% obelus
	)

	Neither of these ways of discovering the character set is
	satisfactory.  In a networked system, each different stream
	may be associated with a different character set.  Some better
	method of determining the character set must be found; for the
	moment environment(os(_)) is all we have.  (Note also that
	Quintus support Kanji under both UNIX and VMS.)

	We really ought to have some way of entering accented characters,
	\'e would be nice (Yay, TeX!) but we already want \' and \" for
	another reason.  \:<char><accent> might not be too bad, and use
	\:<sym><sym> for other things, then we might have ISO 8859/1:

	\:sp	\:!!	\:c/	\:##	\:$$	\:Y=	\:||	\:se
	\:""	\:co	\:a_	\:<<	\:~~	\:--	\:tm	\:__
	\:oo	\:++	\:2_	\:3_	\:''	\:mi	\:pp	\:..	
	\:,,	\:1_	\:o_	\:>>	\:14	\:12	\:34	\:??

	\:A`	\:A'	\:A^	\:A~	\:A"	\:Ao	\:AE	\:C,
	\:E`	\:E'	\:E^	\:E"	\:I`	\:I'	\:I^	\:I"
	\:D/	\:N~	\:O`	\:O'	\:O^	\:O~	\:O"	\:OE
	\:O/	\:U`	\:U'	\:U^	\:U"	\:Y'	\:TH	\:ss

	\:a`	\:a'	\:a^	\:a~	\:a"	\:ao	\:ae	\:c,
	\:e`	\:e'	\:e^	\:e"	\:i`	\:i'	\:i^	\:i"
	\:d/	\:n~	\:o`	\:o'	\:o^	\:o~	\:o"	\:oe
	\:o/	\:u`	\:u'	\:u^	\:u"	\:y'	\:th	\:y"

	(\:OE and \:oe are DEC MNCS; the ISO characters are the
	times (x) \:** and divide (-:-) \:// symbols.)  I'm not crazy
	about this, but at least it would give us a way of writing a
	string like "Base de donn\:e'es" in a way which would port
	between VMS, Mac, and PC, despite the incompatible character sets.
	(It would even make English words like "re\:i"nforce" portable...)

dialect(Dialect)

	This is a ground term naming the dialect of Prolog you are
	using.  If two Prolog systems have different syntax, or have
	different sets of built in predicates (where one is not a
	subset of the other), they should be regarded as different
	dialects.  Note that the presence or absence of some major
	feature is not enough to warrant classification as different
	dialects:  I classify lpa(pc) and lpa(mac) as different
	dialects not because one has a module system and the other
	has none but because of differences in things like length/2,
	is/2, :- dynamic declarations, input-output, ...  The values
	currently defined for this enquiry are

	quintus		Quintus Prolog (including Xerox Quintus Prolog)
	sicstus		SICStus Prolog (Swedish Institute of Computer Science)
	nu		NU Prolog (Melbourne University)
	lpa(pc)		LPA Prolog Professional
	lpa(mac)	LPA MacProlog (Logic Programming Associates)
	lpa(386)	LPA Prolog-386 for 80[34]86 MS-DOS systems
	arity		Arity/Prolog
	esl		Expert Systems Ltd Prolog-2
	open		Open Prolog

	As a further explication of dialect/1, Expert Systems Ltd Prolog-2
	has some differences between the DOS, UNIX, and VMS versions, but
	these have to do with access to operating system features and do
	not count as dialect differences.

version(Version)

	This is a list of constants saying which release of the dialect
	you have.  It will be a proper list if and only if the release
	is a full "customer" release; Alpha, Beta, ... releases will
	end with 'Alpha', 'Beta', ... instead of [] (nil).  The list is
	such that later releases are @> than earlier ones.

atom(_)

	Ideally, there is a one to one correspondence between atoms
	and character strings.  An implementation may impose limits
	on atoms.  These are the limits I have thought of:

    atom(size(LengthInBytes))

	How long may an atom be?  In any reasonable Prolog, we will
	have
	    environment(file(size(FS))) & environment(atom(size(AS)))
	    => AS >= FS
	Note that this limit applies separately to each atom; if an
	implementation imposes some limit on the number of atoms it
	is possible that a smaller number of atoms each of them the
	maximum length may exhaust some other resource.

	It is entirely possible that a Prolog system may impose no
	limit on atom size other than "whatever will fit in memory".
	We expect two things from atom(size(N)):
	a)  An atom with more than N characters _won't_ work
	b)  An atom with exactly N character _will_ work.
	In systems with no hard bound, there is no such value of N,
	and the only sensible thing to do is to have atom(size(_))
	FAIL.  That's how we handle NU Prolog.

    atom(min(CharCode))

	I assume that the set of character codes which may appear in
	an atom is a consecutive sequence of integers.  This is the
	smallest character code which may reliably be used.  There's
	some point to it because Quintus Prolog rejects NUL codes in
	atom names (but not lists of character codes) but others may
	not have this restriction.  Some versions of LPA Prolog will
	let you include NUL bytes in atoms, but do not handle them
	correctly in C.  Such implementations should set the lower
	limit to 1.  The point of this parameter is to tell programs
	"you can _rely_ on putting this character in an atom".

	Since only non-negative character codes are possible in atom
	names, there is always a value for this limit.

    atom(max(CharCode))

	This is the greatest character code which may reliably be
	used in an atom name.  Although one normally expects that
	the limit will be 255 in eight-bit character sets, it may
	be that some non-ISO-8859 system has a reason to keep the
	limit lower.  (Is the "EO" value really legal in MVS?)

	Armed with these two numbers, we can define

	char_atom(Char, Atom) :-
	    (	atom(Atom) ->
		atom_chars(Atom, [Char])
	    ;   var(Atom) ->
		environment(atom(min(Min))),
		environment(atom(max(Max))),
		between(Min, Max, Char),
		atom_chars(Atom, [Char])
	    ).

    atom(number(MaxAtoms))

	If an implementation has a limit on the total number of atoms
	current at any one time other than storage limits, this is the
	number.  It should be guaranteed that a Prolog program which
	creates the atoms [min]..[max], [min,min]..[min,max]..[max,max]
	and so on can reach this limit before exhausting any other
	limit.  It may be possible for a program to exceed this limit.
	The main reason for making this limit available is so that a
	portable program can refuse _early_ to do something that is
	obviously not going to fit.  For example, producing a list of
	all the Kanji as atoms is not going to work if you can only
	have a couple of thousand atoms.

	If there is no such limit, this enquiry just fails quietly.
	It is not clear to me whether Quintus Prolog ought to define
	environment(atom(number(16'200000))) or leave it undefined;
	I cannot imagine a program actually running into that limit
	(because the symbol table would have the system thrashing a
	lot sooner than that...)

	In LPA Prolog Professional on the PC, a term which is an atom
	has an 8-bit tag and a 16-bit "segment address" pointing to the
	information about the atom.  That means that there is an
	architectural limit of 2**16 atoms.  Also, all atoms are stored
	in "text space", which the implementation limits to 128k, and
	an atom takes a minimum of 16 bytes (more than Quintus Prolog...)
	so the implementation limit is ((128/16)*1024) = 8192.  Later
	versions may perhaps raise that limit.


    atom(width(LengthInChars))

	The greatest number of characters that can be required to
	write out an atom with full quoting, assuming a sufficiently
	large output line.  In Quintus Prolog this is currently
	2 + 4*size, because each character might be \ooo for some
	octal digits ooo.

	Note that if an implementation has no hard bound on the number
	of characters in an atom, it won't have a hard bound on the
	printed width either, so atom(size(_)) and atom(width(_)) must
	both succeed or both fail.

	To determine the width required for any particular atom, use
	print_length(writeq(TheAtom), ItsWidth).

string(_)

	These limits apply to a string data type which a Prolog program
	can distinguish from both atoms and lists of character codes,
	such as Xerox Quintus Prolog and Arity Prolog provide.  In a
	Prolog system without them, they all fail.  In a Prolog system
	which has strings but which places no hard bound on their length,
	string(size(_)) and string(width(_)) may both fail, but you can
	rely on string(min(_)) having a solution if and only if strings
	are supported.

    string(size(LengthInBytes))
    string(min(CharCode))
    string(max(CharCode))
    string(width(LengthInChars))

	These have the same meaning as the corresponding limits for atoms.
	If strings are provided, these limits should be no more restrictive
	than the atom limits.  There is no string(number(_)) limit; the
	only limit should be the amount of storage needed for all the
	strings retained at any one time.

integer(_)

	These enquiries define the properties of integer arithmetic.

    integer(size(SizeInBits))

	How many bits there are in an integer.  It is likely that a
	future version of Quintus Prolog will support "bignums", but
	they will be limited in size to 64kbytes, so we might then
	define environment(integer(size(5000000))) or so.  Even on
	the Xerox D-machines, the practical limit is well below
	10,000,000 bits (if all of a D-machine's memory were one
	bignum, it would be about 80 million bits).  This is a rather
	large limit, but 300,000! is comparable to our future limit.

	If you know the ELEFUNT subroutine 'i1mach', this is similar
	to IMACH(5).

    integer(small(MinInt))

	If a Prolog system has a foreign interface, this is the most
	negative integer which can both be held as a Prolog integer
	and passed directly to the foreign languages as a "plain"
	integer.  In a Prolog/Lisp system, this would correspond to
	most-negative-fixnum.  In a Prolog/C system this would
	correspond to MINLONG.  In a Prolog/Fortran system, this
	would be either -IMACH(9) or -1-IMACH(9).  If a Prolog
	system has no foreign interface, then it may be any integer
	such that arithmetic operations all of whose operands and
	results are in the closed interval [MinInt,MaxInt] are
	correct.

    integer(large(MaxInt))

	The largest plain foreign integer; most-positive-fixnum,
	MAXLONG, or IMACH(9).

    integer(width(LengthInChars))

	How many characters may be required to write a Prolog integer
	(not necessarily a foreign "plain" integer), assuming a
	sufficiently long output line.  At present this is pretty small,
	but if/when we provide bignums, it could be over 150,000.
	To determine the width of any particular integer, do
	print_length(writeq(TheInteger), ItsWidth)

    integer(too_big(Action))

	What happens if you try to read an integer which is too big
	to be represented as an integer, or if you call number_chars/2
	with a list of character codes which represent an integer
	which is too big to be so represented?  (name/2 should do the
	same as number_chars/2; oversize integer names should not be
	converted to atoms.)  Some possibilities are

	too_big(truncate)
		Map the number into the representable range by
		taking the bottom size() bits.  The tokeniser might
		or might not print a warning, number_chars/2 will not.

	too_big(limit)
		Map the number into the representable range by
		taking large() or small() as appropriate.  The
		tokeniser might or might not print a warning,
		number_chars/2 and name/2 will not.

	too_big(float)
		Use the floating-point number nearest in value instead.
		The tokeniser might or might not print a warning.
		number_chars/2 and name/2 will not.
		If the number is too big for floating-point representation
		as well, see environment(float(too_big(_))).

	too_big(error)
		When reading, report a syntax failure.
		number_chars/2 and name/2 report a representation fault.
		This is the preferred method.

    integer(overflow(Action))

	If a program tries to compute an integral value, whether by
	using arithmetic expressions or by using special predicates
	(succ/2, plus/3, or similar), and that value is too big to
	be represented as a Prolog integer, what happens?

	overflow(truncate)
	overflow(limit)
	overflow(float)
	overflow(error)

		These are the same as the corresponding actions for
		too_big(_).  It is possible that they might be different.
		'error' is the preferred method.

float(_)

	These parameters describe the properties of floating-point
	arithmetic.  Most of them are described in my document on
	standardising Prolog floating-point arithmetic.  The numbers
	given for NU Prolog and SICStus Prolog are for IEEE-754 64-
	bit arithmetic.  Note that the numbers for LPA Professional
	are *different*:  LPA Prolog Professional does not provide
	IEEE-754 arithmetic and does not claim to.

    float(size(X))

	The size of a floating-point number in bits.  This ought to
	be recoverable from environment(float(machine(format(_)))),
	but is included for cuteness.

    float(width(LengthInChars))

	How many characters may be required to write a floating-point
	number with enough digits to read it back correctly?  (Assume
	sufficiently long output lines.)  To determine the width of
	any particular floating-point number, do
	print_length(writeq(TheFloat), ItsWidth)
	Note that write/1 may round floating-point numbers off to a
	small number of digits (perhaps under the programmer's control),
	but writeq/1 is supposed to identify the number completely.

    float(too_big(Action))

	This is like integer(too_big(Action)), except that (a) 'float'
	is not a possible action, and (b) 'infinity' means that numbers
	which are too large are converted to IEEE 754 (or IEEE-like)
	infinities of the appropriate sign, while 'limit' means that
	numbers are converted to the large finite float with the
	appropriate sign.  'infinity' should never be claimed on machines
	like the VAX or /370 which do not have IEEE-like infinities.

	'truncate' _is_ a possible value; it means that the number
	wraps around in some way (typically the binary exponent is
	truncated to N bits for some N).  The preference order is
	error (best) > infinity > limit > truncate (worst).

    float(overflow(Action))

	This is like integer(overflow(Action)) with the same differences
	as float(too_big(_)).

    NOTE.
	There are other things one might test, e.g.
	float(too_small(truncate | zero | error))
	float(underflow(truncate | zero | error))
	If underflow is forced to 0.0 and float(confounded), the result
	of an underflow might be an integer 0 (strongly disapproved of).
	In fact, the IEEE 754 standard distinguishes between five kinds
	of exceptional condition.  Before doing anything about that, we
	should settle the "elementary transcendental function" question.

var(_)

	There are several situations where there may be a limit on the
	number of variables in a term.
	1.  read/1 may have a limited dictionary.
	2.  write/1 and relatives may use a fixed size dictionary for
	    mapping variables to numbers during one output call (though
	    the global stack can very easily be used for this purpose)
	3.  Variables may be classified into several groups by assert{,az}/,
	    each group with its own limit.  (This happened in C Prolog.)
	4.  A compiler may classify variables into several groups, each
	    group with its own limit.  (This happens in DEC-10 Prolog and
	    in WAM-based compilers.)
	5.  Check your vendor's Prolog manual for others...
	There are so many limits that it would be difficult to encompass
	all of them.  I have chosen just two, which are reasonably portable
	in concept.

    var(read(N))

	If it is possible to construct a Prolog term having K+1 variables
	which is rejected by read/1 as too complex but which read/1 would
	accept if any one of those variables were replaced by a constant,
	then N is to be the smallest such K.

	The intent is that a term having at most N variables should not
	be rejected by read/1 on the grounds of having too many variables,
	though it might be rejected for some other reason.

	If read/1 will never reject a term for having too many variables,
	environment(var(read(_))) is to fail.

    var(assert(N))

	If it is possible to construct a Prolog clause having K+1 variables
	which is rejected by any member of the assert/1 family or
	which is rejected by any member of the consult/1 family or
	which is rejected by the usual compiler for this dialect
	on the grounds that it has too many variables of some sort,
	and which clause would be accepted if any one of those variables
	were replaced by a constant,
	then N is to be the smallest such K.

	The intent is that a clause having at most N variables should not
	be rejected by assert/1, consult/1, compile/1, ... on the grounds
	of having too many variables, though it might be rejected for some
	other reason.  As an example, a WAM-based compiler which has
	support for 255 A and X registers and 255 Y variables would set N
	to 255, even if assert/1 has no limit, and even if you can construct
	a clause with many more variables than that.

	If assert/1, consult/1, compile/1, and so on will NONE of them
	ever rejects a clause for having too many variables,
	environment(var(assert(_))) is to fail.

    var(width(N))

	This is the maximum number of characters in the written form of a
	variable.  Imagine a Prolog system on a 32-bit UNIX system with a
	128 Mb address space, where a variable is written by taking its
	address, shifting it right 2 binary places, and then writing an
	underscore followed by the address in decimal (not atypical).
	You might need as many as 9 characters for a variable name in such
	a system, so var(width(9)).


	If we intepret environment(var(N)) as meaning
		"It is possible to construct a clause having N+1 variables
		which is rejected as too complex, but if any one of those
		variables were replaced by a constant it would be accepted,
		and N is the smallest such number"
	then this limit can be useful in many Prologs.  Since a clause has
	to be read, if there is a limit on the number of variables that
	read/1 can handle, this will be a lower bound on that limit too.
	Accordingly, I have added environment(var(N)) with this meaning.




arity(_)

	These are the limits on compound terms.

    arity(functor(N))

	A compound term may have any function symbol and may have as
	many as N arguments.  That is, for any atom S and for any
	integer 0 =< A =< N, the goal functor(_, S, A) must either
	succeed or report a storage overflow, and in the initial
	state of the system it should succeed.  N is not necessarily
	the largest value for which functor/3 will ever work; the
	main property is that you can keep constructing as many terms
	of this size as you want until you run out of storage, without
	crashing the system.

    arity(call(N))

	A compound term used as a goal may have this many arguments;
	which is to say that a Prolog predicate may have this many
	arguments.

    arity(foreign(N))

	If a foreign interface is provided, a foreign function called
	as a Prolog predicate may have this many arguments.  This can
	never be larger than the 'call' limit, but may be smaller.  A
	Prolog system with no foreign interface would fail this query.

stream(X)

	These environment enquiries yield stream identifiers (things
	that can be given as first argument to read/2 or write/2).

    stream(read(X))

	X names the stream that read/1 gets its input from if you have
	not redirected it using see/1, set_input/1, stdin/2, stdinout/3,
	with_input_from_stream/2, or any other such method.
	A common name for this is "the standard input stream"
	Note that LPA MacProlog is exceptional in not accepting this
	stream as an argument for get0/2.
    
	The equivalent of *standard-input* in Common Lisp.

    stream(write(X))

	X names the stream that write/1 sends its output to if you
	have not redirected it using tell/1, set_output1, stdout/2,
	stdinout/3, with_output_to_stream/2, or any such method.
	A common name for this is "the standard output stream".

	The equivalent of *standard-output* in Common Lisp.

    stream(error(X))

	X names the stream that the system sends error messages to.
	A common name for this is "the standard error stream".
	There might be something special about this stream; it is
	always a good idea to send error messages there, even if the
	dialect you are using makes it the same as write(_).
	Note that if it is possible to redirect error output, there
	should be a current_error/1 predicate or some such method
	of determining the current binding; _this_ enquiry tells you
	the _initial_ binding.

	The equivalent of *error-output* in Common Lisp.

    stream(trace(X))

	X names the stream that the debugger sends tracing output to.
	A common name for this is "the standard debugger stream".
	There might be something special about this stream.
	Tracing messages should be sent to it.
	Note that if it is possible to redirect debugger output, there
	should be a current_debug/1 predicate or some such method
	of determining the current binding; _this_ enquiry tells you
	the _initial_ binding.

	The equivalent of *trace-output* in Common Lisp.

    NOTE.
	An earlier draft used the names "input, output, error, debug"
	where I now have "read, write, error, trace".  Input and output
	have been renamed (a) to avoid introducing new atoms, and (b)
	to make it clearer exactly what they do.  stream(read(X)) _is_
	valid for read/2 in LPA MacProlog but is _not_ generally valid
	for other sorts of input.  Debug has been renamed (a) to fit
	the Common Lisp model better, and (b) because the debugger
	needs an INPUT stream as well as an OUTPUT stream, and the
	value currently assigned to stream(trace(X)) is not usable as
	an input stream in Quintus Prolog, LPA Prolog Professional, or
	LPA Mac Prolog ('Sigma Error Log').

	Common Lisp has three other standard streams:
	*query-io*		for asking questions of the user
	*debug-io*		for interactive debugging
	*terminal-io*		the user's console.
	We can't model those directly.  For example, LPA Prolog
	Professional can do I/O in program-controlled windows, but
	it uses the same input stream for all such windows.  We would
	have to model these things as pairs, perhaps
	stream(query(Input,Output))
	stream(debug(Input,Output))
	stream(terminal(Input,Output))	\ these two pairs are not
	stream(standard(Input,Output))	/ necessarily identical!
	But that is definitely for the future.

file_name(X)

    These options are described in filename.txt.
    They give limits on the sizes of parts of file names, and if some
    system does not support a particular part, indicate that by not having
    a limit.  The atom and string limits are to be read as "anything
    bigger than this is forbidden"; these limits are to be read as
    "things no bigger than this are allowed".

file_type(Category, Atom)

    This table maps ``abstract'' file types to the extensions or types which
    are used on the particular operating system.  The types currently listed
    are
	source		-- Prolog source code
	object		-- Prolog object code
	log		-- log/transcript file
	options		-- "init", "profile", or "options" file
	text		-- plain text

    This table is definitely likely to be revised.  In particular, CMS
    uses the back-to-front convention of
	PROFILE.program
    instead of the usual
	program.INI
    or equivalent.  There is also the ambiguity on the Macintosh that we
    really want this to be a four-letter magic code, but LPA actually use
    a .extension for one of these cases.  On the Mac, this environment
    feature just quietly fails, which is a reasonable way of indicating that
    the distinction must be drawn by changing the name.
    The 'text' type was introduced for Expert Systems Ltd Prolog-2 which
    does a very painful thing:  tell(fred) does not open "fred" or "fred."
    but insists on opening "fred.PRO".  So 'text' specifies the type (or
    extension) used when you open a file with see/1 or tell/1 and do not
    specify a file type.  Note that there is a difference between using an
    _empty_ type (environment(file_type(Category, X)) yields X = '') and
    using _no_ type (environment(file_type(Category, X)) fails).  In a DOS
    or VMS system there is of course no difference, because it is not
    possible to omit the type completely, but the distinction is there for
    UNIX, Aegis, Mac-OS, PRIMOS, and so on.

OTHER LIMITS.
    Expert Systems Prolog-2 has the following limits which do not yet fit
    into the environment/1 table.
	max_clauses		How many clauses per predicate?
	max_drefs		How many DBrefs alive at any one time?
	max_error		Largest allowed error number.
	max_global		Largest allowed global variable number.
	max_hashtable		Largest allowed hash table.
	max_internal_integer	How can integers get in expressions?
	max_modules		How many modules are possible?
	max_precision		How many digits can follow a decimal point?

    max_modules.
	The concept is portable, but modules aren't.  It is not clear why
	there should be any limit other than the number of clauses in a
	predicate (so that a predicate can hold information about all modules).
	To make the most effective use of this you need to know how many
	modules the system already uses up.

    max_predicates.
	I don't know why Prolog-2 doesn't limit this too.
	If there is a maximum number of atoms F and a maximum arity N
	there then can in the nature of things be no more than (N+1)*F
	predicates.  A system might impose a limit on the number of predicates
	in a module, AND/or a limit on the number of predicates in total.
	To make the most effective use of this you would need a way of
	finding out how many predicates are already in use.

    max_clauses
	The concept is portable, although there could in principle be
	a total limit, a limit per module, AND/or a limit per predicate.
	I am strongly inclined to add a per-predicate clause limit to the
	"portable" environment table.

    max_vars
`	There are some Prolog implementations which impose no limit on the
	number of distinct variables in a clause.  That's fine.
	There are some Prolog implementations which provide separate limits
	on temporary variables, local variables, and global variables.
	That's fine too; if we report the smallest of those three limits as
	"the" limit then any clause which doesn't exceed that limit will
	not exceed any of the three limits.
	If we intepret environment(var(assert(N))) as meaning
		"It is possible to construct a clause having N+1 variables
		which is rejected as too complex, but if any one of those
		variables were replaced by a constant it would be accepted,
		and N is the smallest such number"
	then this limit can be useful in many Prologs.  Since a clause has
	to be read, if there is a limit on the number of variables that
	read/1 can handle, this will be a lower bound on that limit too.
	Accordingly, I have added environment(var(_)).

    max_hashtable
	You probably won't believe this, but Prolog-2 has a limit on the
	size of hash tables that is smaller than the number of clauses
	allowed in a predicate.  Which predicates may not be hashed?
	Precisely those which most need to be.  Without wishing to be
	uncharitable, I do not see how this makes sense.  (It doesn't make
	a lot of sense to me that there are _any_ predicates which are
	_not_ hashed, but there you are.)  Since Prolog-2's hash/[1-3] and
	unhash/1 have no portable equivalents, there is no need to provide
	a portable interface to information about their absurdities.

    max_drefs
	Aside from the aberrant spelling (the usual abbreviation is DBrefs),
	the concept of limiting the number of active DBrefs strikes me as
	curious.  How is a limit of 16 DBrefs to be shared amongst 65535
	clauses to be regarded as sensible?  If you have boxed constants
	(which you need if you support 64-bit floats) then there should be
	_no_ intrinsic limit on the number of lives DBrefs.

    max_error
	This is tied up with Prolog-2's error handling systems, which is
	based on error numbers.  That is the Wrong Way to go.  Error numbers
	are so very system dependent that there is no point in trying to
	provide portable access to information about them.

    max_global
	Prolog-2 has a fixed array of global variables (15 under DOS, 49
	under VMS or UNIX).  Unfortunately, telling you how _many_ there
	are is not enough, because Expert Systems Limited made the mistake
	of swiping some of them back:
	     0	Break level
	     1	Reset to 0 at each query
	    12	Edit toggle
	    13	Incremented when a line is read (from what? any file?)
	    14	Set to offset of syntax error in input
	    15  Used internally.
	What you want to know is _which_ global numbers are available to
	_you_.  Several Prologs provide some such facility, but there is
	as yet no agreed interface.  This limit belongs as part of such an
	optional package.

*/
%   environment(Feature)
%   VAX/VMS version of the environment table.

environment(os(vms)).
environment(dialect(quintus)).
environment(version([2,4])).
environment(var(width(10))).
environment(atom(X))		:- 'env atom'(X).
environment(string(_))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(T,W))	:- 'env type'(T, W).

%   The numbers for 'env float' should be changed, but I haven't worked
%   out what they are for the VAX.  My present belief is that the VAX
%   double floats are just about as good as IEEE except for the exponent
%   range.  Note that there is no need for an environment feature to tell
%   whether -0.0 is distinguished from +0.0, just check whether
%	-0.0 == 0.0		-- they are not distinguished
%	-0.0 \==0.0		-- they are distinguished
%   Note that IBM 370s allow -0.0 in storage and in a register, but the
%   floating-point operations do not distinguish them.

'env file'(size(255)).
'env file'(host(15)).		% (not including "access control")
'env file'(device(253)).	% logical device names can be this long
'env file'(directory(39)).
'env file'(depth(8)).
'env file'(name(39)).
'env file'(type(39)).
'env file'(base(79)).
'env file'(version(6)).		% -#####

'env type'(source,	'PL').
'env type'(object,	'QOF').
'env type'(log,		'LST').
'env type'(options,	'INI').


%   environment(Feature)
%   VM[370]/CMS version of the environment table.

environment(os(cms)).
environment(os_version([6])).	% FIX THIS AS PART OF INSTALLATION
environment(dialect(quintus)).
environment(version([1,5])).
environment(var(width(10))).
environment(atom(X))		:- 'env atom'(X).
environment(string(_))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(Feature)) :- 'env file'(Feature).
environment(file_type(T, W))	:- 'env type'(T, W).

'env file'(size(171)).
'env file'(host(8)).
'env file'(device(1)).
'env file'(directory(16)).
'env file'(depth(8)).
'env file'(name(8)).
'env file'(type(8)).
'env file'(base(17)).
'env file'(version(_)) :- fail.	% mode number NOT counted here!

'env type'(source,	'PROLOG').
'env type'(object,	'QOF').
'env type'(log,		'LISTING').
'env type'(options,	'PROFILE').

%   environment(Feature)
%   MS-DOS 3.x version of the environment table.
%   This version is written for LPA Prolog Professional 2.6,
%   which does not do full first argument indexing.

environment(file_type(T, W))	:- 'env type'(T, W).
environment(C(V)) :- !,
	environment(C, V).

environment(os,		msdos).
environment(dialect,	lpa(pc)).
environment(version,	[2,6]).
environment(var,	width(5)).
environment(atom,	C(V))	:- 'env atom'(C, V).
environment(string,	C(V))	:- fail.
environment(integer,	C(V))	:- 'env integer'(C, V).
environment(float,	X)	:- 'env float'(X).
environment(arity,	C(V))	:- 'env arity'(C, V).
environment(stream,	C(V))	:- 'env stream'(C, V).
environment(file_name,	C(V))	:- 'env file'(C, V).

'env atom'(size,    122).
'env atom'(min,       0).	% Maybe it is really 1
'env atom'(max,     255).
'env atom'(width,     X)	:- X is 122*2 + 2.
'env atom'(number, 8192).

'env integer'(small,        X)	:- X is -16384*2.
'env integer'(large,        X)	:- X is 32767.
'env integer'(size,        16).
'env integer'(too_big,  float).
'env integer'(overflow, float).
'env integer'(width,        6).

'env float'(confounded).
'env float'(C(V)) :- !,
	'env float'(C, V).

'env float'(size,      64).
'env float'(too_big,  error).	% NOT a syntax error, internal routine bombs
'env float'(overflow, error).
'env float'(b,          2).
'env float'(p,         52).	% AS MEASURED BY "PARANOIA"
'env float'(pi, 3.141592653589793238462643).	% ROUNDED BY COMPILER!
'env float'(width,     22).	% measured, may not be right
'env float'(mark, 69 /* E */).
'env float'(radix,      2).
'env float'(mantissa,  52).	% AS MEASURED BY "PARANOIA"

'env stream'(input,  'BUF:').
'env stream'(output, 'WND:').
'env stream'(error,  '&:').
'env stream'(trace,  'DEBUG:').

'env file'(size,	65).	% 63 + "x:"
'env file'(host,	 _) :- fail.
'env file'(device,	 1).
'env file'(directory,	12).	% 8.3 format is possible
'env file'(depth,	 8).	% another document says 7
'env file'(name,	 8).
'env file'(type,	 3).
'env file'(base,	12).
'env file'(version,	 _) :- fail.

'env type'(source,	'DEC').
'env type'(object,	'PRO').
'env type'(log,		'LOG').
'env type'(options,	'INI').


%   environment(Feature)
%   Macintosh HFS version of the environment table.
%   This version is written for LPA MacProlog 2.5,
%   which does not do full first argument indexing.

environment(file_type(T, W))	:- 'env type'(T, W).
environment(C(V)) :- !,
	environment(C, V).

environment(os,		mac).
environment(dialect,	lpa(mac)).
environment(version,	[2,5]).
environment(var,	width(8)).
environment(atom,	C(V))	:- 'env atom'(C, V).
environment(string,	C(V))	:- fail.
environment(integer,	C(V))	:- 'env integer'(C, V).
environment(float,	X)	:- 'env float'(X).
environment(arity,	C(V))	:- 'env arity'(C, V).
environment(stream,	C(V))	:- 'env stream'(C, V).
environment(file_name,	C(V))	:- 'env file'(C, V).

'env atom'(size,   255).
'env atom'(min,      0).	% Maybe it is really 1
'env atom'(max,    255).
'env atom'(width,    X)		:- X is 255*2 + 2.
'env atom'(number, 32768).	% May be too large.

'env integer'(small,        X) :- X is (-1) << 23.
'env integer'(large,        X) :- X is (-1) - ((-1) << 23).
'env integer'(size,        24).
'env integer'(too_big,  float).
'env integer'(overflow, float).
'env integer'(width,        6).

'env float'(confounded).
'env float'(C(V)) :- !,
	'env float'(C, V).

'env float'(size,        80).
'env float'(too_big,  error).
'env float'(overflow, error).
'env float'(b,            2).
'env float'(p,           64).	% NOT MEASURED
'env float'(pi, 3.141592653589793238462643).	% ROUNDED BY COMPILER!
'env float'(width,  	  _) :- fail.	% It's *BROKEN*
'env float'(mark,        69).	% character code of `E`
'env float'(radix,        2).
'env float'(mantissa,    64).	% NOT MEASURED

'env file'(size,	255).
'env file'(host,	  _) :- fail.
'env file'(device,	 27).
'env file'(directory,	 31).
'env file'(depth,	126).		% supposedly no limit
'env file'(name,	 31).
'env file'(type,	  _) :- fail.
'env file'(base,	 31).
'env file'(version,	  _) :- fail.

%   environment(Feature)
%   SICStus Prolog BSD Unix version of the environment table.

/*  Note: most of these facts have been checked against SICStus 0.6 (Feb '89).
    The behaviour of floating-point arithmetic is machine-dependent.
    The figures quoted below have been checked (if at all) ONLY on a Sun-3.
    IEEE denormalised numbers are NOT ``model numbers'', so don't be
    surprised by the value of sigma.
*/
environment(os(unix)).
environment(os_version([4,3,encore([4,0,0])])).
environment(dialect(sicstus)).
environment(version([0,7])).
environment(var(width(10))).
environment(atom(X))		:- 'env atom'(X).
environment(string(_))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(T,W))	:- 'env type'(T, W).

'env atom'(size(512)).
'env atom'(min(1)).
'env atom'(max(255)).
'env atom'(width(X))		:- X is 512*4 + 2.
'env atom'(number(X))		:- X is 1 << 20.	% (reported by SICS)

'env integer'(size(32)).
'env integer'(small(X))		:- X is -1 << 31.
'env integer'(large(X))		:- X is -1 - (-1 << 31).
'env integer'(width(11)).
'env integer'(too_big(truncate)).
'env integer'(overflow(truncate)).

'env float'(size(64)).
'env float'(too_big(infinity)).		% prints as 1.0e1000, NASTY.
'env float'(overflow(infinity)).
'env float'(confounded)		:- fail.
'env float'(b(2)).
'env float'(p(53)).
'env float'(emin(-1021)).
'env float'(emax( 1024)).
'env float'(sigma(X))		:- scale(-1022, 1.0, X).
'env float'(lambda(X))		:- scale(52, 1.0, Y), Z is (Y-1)+Y,
				   scale(971, Z, X).  % (2**53-1)*2**(1024-53)
'env float'(epsilon(X))		:- scale(-18, 1.0, X).
'env float'(max_integer(X))	:- scale(52, 1.0, Y), X is (Y-1)+Y.
'env float'(min_integer(X))	:- scale(52, 1.0, Y), X is (1-Y)-Y.
'env float'(pi(3.141592653589793238462643)).	% ROUNDED BY COMPILER!
'env float'(digits(16)).
'env float'(width(22)).
'env float'(mark(0'e)).
'env float'(radix(2)).
'env float'(mantissa(53)).
'env float'(small(X))		:- scale(-1022, 1.0, X).
'env float'(large(X))		:- scale(52, 1.0, Y), Z is (Y-1)+Y,
				   scale(971, Z, X).  % (2**53-1)*2**(1024-53)
'env float'(machine(X))		:- 'env mac'(X).

scale(N, X0, X) :-
    (	N >= 4 -> X1 is X0 * 16.0,   N1 is N-4, scale(N1, X1, X)
    ;   N=< -4 -> X1 is X0 * 0.0625, N1 is N+4, scale(N1, X1, X)
    ;	N >  0 -> X1 is X0 * 2.0,    N1 is N-1, scale(N1, X1, X)
    ;   N <  0 -> X1 is X0 * 0.5,    N1 is N+1, scale(N1, X1, X)
    ;   X is X0
    ).

'env mac'(b(2)).
'env mac'(radix(2)).
'env mac'(rounds).
'env mac'(overflows)		:- fail.
'env mac'(format(ieee(double))).

'env arity'(functor(255)).
'env arity'(call(255)).
'env arity'(foreign(255)).

'env stream'(read( user_input)).
'env stream'(write(user_output)).
'env stream'(error(user_error)).
'env stream'(trace(user_error)).

'env file'(size(1023)).		% pick up from PATH_MAX
'env file'(host(_)) :- fail.
'env file'(device(_)) :- fail.
'env file'(directory(255)).	% use 14 on System V
'env file'(depth(128)).
'env file'(name(255)).		% use 14 on System V
'env file'(type(253)).		% use 12 on System V
'env file'(base(255)).		% use 14 on System V
'env file'(version(_)) :- fail.

'env type'(source,	'pl').		% Use ".pl" extension for source code
'env type'(object,	'ql').		% Use ".ql" extension for compiled
'env type'(log,		'log').		% use for log files
'env type'(options,	'ini').		% Not the real BSD convention...

end_of_file.

%   environment(Feature)
%   NU Prolog BSD Unix version of the environment table.

/*  The behaviour of floating-point arithmetic is machine-dependent.
    The figures quoted below have been checked (if at all) ONLY on a Sun-3.
    IEEE denormalised numbers are NOT ``model numbers'', so don't be
    surprised by the value of sigma.
*/
environment(os(unix)).
environment(os_version([4,3,encore([4,0,0])])).
environment(dialect(nu)).
environment(version([1,5,24])).
environment(var(width(10))).
environment(atom(X))		:- 'env atom'(X).
environment(string(_))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(T,W))	:- 'env type'(T, W).

'env atom'(size(_))		:- fail.	% there appears to be no limit
'env atom'(min(1)).
'env atom'(max(127)).
'env atom'(width(_))		:- fail.	% there appears to be no limit
'env atom'(number(_))		:- fail.	% the only limit is storage,
						% which comes to 8 millionish.

'env integer'(size(26)).
'env integer'(small(X))		:- X is -1 << 25.
'env integer'(large(X))		:- X is -1 - (-1 << 25).
'env integer'(width(9)).
'env integer'(too_big(truncate)).
'env integer'(overflow(truncate)).

'env float'(size(64)).
'env float'(too_big(infinity)).		% prints as Infinity
'env float'(overflow(infinity)).
'env float'(confounded)		:- fail.
'env float'(b(2)).
'env float'(p(53)).
'env float'(emin(-1021)).
'env float'(emax( 1024)).
'env float'(sigma(X))		:- scale(-1022, 1.0, X).
'env float'(lambda(X))		:- scale(52, 1.0, Y), Z is (Y-1)+Y,
				   scale(971, Z, X).  % (2**53-1)*2**(1024-53)
'env float'(epsilon(X))		:- scale(-18, 1.0, X).
'env float'(max_integer(X))	:- scale(52, 1.0, Y), X is (Y-1)+Y.
'env float'(min_integer(X))	:- scale(52, 1.0, Y), X is (1-Y)-Y.
'env float'(pi(3.141592653589793238462643)).	% ROUNDED BY COMPILER!
'env float'(digits(16)).
'env float'(width(22)).
'env float'(mark(0'e)).
'env float'(radix(2)).
'env float'(mantissa(53)).
'env float'(small(X))		:- scale(-1022, 1.0, X).
'env float'(large(X))		:- scale(52, 1.0, Y), Z is (Y-1)+Y,
				   scale(971, Z, X).  % (2**53-1)*2**(1024-53)
'env float'(machine(X))		:- 'env mac'(X).

scale(N, X0, X) :-
    (	N >= 4 -> X1 is X0 * 16.0,   N1 is N-4, scale(N1, X1, X)
    ;   N=< -4 -> X1 is X0 * 0.0625, N1 is N+4, scale(N1, X1, X)
    ;	N >  0 -> X1 is X0 * 2.0,    N1 is N-1, scale(N1, X1, X)
    ;   N <  0 -> X1 is X0 * 0.5,    N1 is N+1, scale(N1, X1, X)
    ;   X is X0
    ).

'env mac'(b(2)).
'env mac'(radix(2)).
'env mac'(rounds).
'env mac'(overflows)		:- fail.
'env mac'(format(ieee(double))).

'env arity'(functor(4096)).	% bigger => error
'env arity'(call(256)).		% bigger => panic
'env arity'(foreign(256)).	% assumed same as call.

'env stream'(read( user_input)).
'env stream'(write(user_output)).
'env stream'(error(user_error)).
'env stream'(trace(user_error)).

'env file'(size(1023)).		% pick up from PATH_MAX
'env file'(host(_)) :- fail.
'env file'(device(_)) :- fail.
'env file'(directory(255)).	% use 14 on System V
'env file'(depth(128)).
'env file'(name(255)).		% use 14 on System V
'env file'(type(253)).		% use 12 on System V
'env file'(base(255)).		% use 14 on System V
'env file'(version(_)) :- fail.

'env type'(source,	'nl').		% Use ".nl" extension for source code
'env type'(object,	'no').		% Use ".no" extension for compiled
'env type'(log,		'log').		% use for log files
'env type'(options,	'ini').		% Not the real BSD convention...

end_of_file.
/*
The following rough notes are based on the als_system/1 description
in the release notes for ALS 1.2Beta3 on the Macintosh.
*/
environment(os(unix)).			% for AUX
environment(os(mac)).			% for macOS
environment(os_version([6,0])).
/*	Note:  there is currently no provision for an OS version in the
	environment table.  The reason for that is that this information
	can be hard to find out:  you sometimes have to _know_ the answer
	in order to call the right things to find it out.  This needs to
	be THOUGHT about, not just bodged in hastily.  I've thought about
	it.  The point of this file is to provide a portable way of getting
	access to generally meaningful system-dependent information.  Too
	many Mac and too many DOS Prologs provide this for me to leave it
	out, and it's not as if it was hard to define for Mac-OS, DOS,
	OS/2, VMS, or CMS.  For UNIX it is a bit trickier, because we have
	BSD, System V, POSIX, Solaris, and Mach, and we have two levels of
	version numbers, e.g. at the moment I'm using Encore's version
	[4,0,0] of BSD version [4,3].  However, the BSD version number does
	tell us interesting things, and the vendor version number doesn't,
	so maybe one number will do.  The BSD/S5 distinction is blurred by
	SunOS and S5R4.  I suggest that we leave the UNIX version numbers
	up in the air for the moment, but where it _is_ clear what to do,
	let's do it.
*/
environment(dialect(als)).
environment(version([1,2|'Beta'])).
/*	Note:  Quintus, SICStus, and NU version numbers are consistent
	across ALL supported machines.  If you know that you have
	SICStus Prolog 0.7, then you know exactly which predicates and
	operations you have without having to know what kind of machine
	you are running it on.  This also applies to Quintus and NU
	Prolog:  if you know the dialect and the version number, you
	know everything there is to know about the language as such.
	It would be helpful if ALS were to adopt a similar policy.
*/
environment(var(width(8))).
environment(atom(X))		:- 'env atom'(X).
environment(string(X))		:- fail.
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- 'env float'(X).
environment(float(single,X))	:- 'env float'(X).
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(_,_))	:- fail.

'env atom'(size(255)).		%  Or maybe 127, I'll have to check again.
'env atom'(min(1)).		%  I think.
'env atom'(max(255)).
'env atom'(width(X))		:- 'env atom'(size(N)), X is N*2+2.
'env atom'(number(907)).	%  or has that been increased?

'env integer'(size(24)).	%  I'll have to check again
'env integer'(small(X))		:- X is -1 << 23.
'env integer'(large(X))		:- X is -1 - (-1 << 23).
'env integer'(width(8)).
'env integer'(too_big(truncate)).	% CHECK THIS
'env integer'(overflow(truncate)).	% CHECK THIS

'env float'(_) ??? .
/*
	I'll have to dig out the Prolog version of PARANOIA and try it.
	It should be the same as either IEEE double or IEEE extended.
*/
'env arity'(functor(15)).		% CHECK THIS
'env arity'(call(15)).			% CHECK THIS
'env arity'(foreign(14)).		% CHECK THIS

'env stream'(read( user)).
'env stream'(write(user)).
'env stream'(error(user)).
'env stream'(trace(user)).		% Is this right?

'env file'(size,	255).
'env file'(host,	  _) :- fail.
'env file'(device,	 27).
'env file'(directory,	 31).
'env file'(depth,	126).		% supposedly no limit
'env file'(name,	 31).
'env file'(type,	  _) :- fail.
'env file'(base,	 31).
'env file'(version,	  _) :- fail.
/*
    In Expert Systems Limited's Prolog-2, 

	statistics(environment, [
		OS, OSmajor, OSminor,
		MachType, VendorCode,
		Screen, Rows, Cols,
		Drives | _])
	supplies
		environment(os(OS))
		-- except that they use 'd' for 'msdos' and 'd386'
		   for 80386 DOS extender (which one?)
		environment(os_version([Major,Minor])))
		-- no provision there for manufacturer variations
		Machine Type (i means PC, other values not defined)
		Vendor Code (apricot &c, I suppose; how do they know?)
		Screen says whether _the_ screen is 'b'lack-and-white
		or 'co'lour, but what if a machine has several screens
		Rows and Cols supply the dimensions of _the_ screen,
		but what if it has several or none, and what if it has
		an X terminal?
		Drives is the number of disc drives.  This is better
		done, I think, via a
			valid_device(DeviceName)
		predicate in the pathname package.  What is the number	
		of drives for a UNIX system?  What about aliases?

	als_system/1 has

	os=mac		But it DOESN'T identify the operating system!
			It identifies the MACHINE!  The operating system
			is actually given by
	os_variation=macOS | aux
			which is given here as
				environment(os(mac))
			or	environment(os(aux)).
	UNIX is the operating system, and AUX is the variant!

	os_version='N.N.N'
			How important is this?  Perhaps one way of
			handling it would be to use
			os(unix(sun([4,0,3])))
			os(unix(ultrix([2,2])))
			os(unix(aux([N,N,N])))
			os(mac([N,N,N]))
			os(msdos([3,3]))
			In order to cope with some other Prologs, I have
			finally given in and plugged in
			environment(os_version([N,N,N])).
			It doesn't really answer the interesting questions,
			though.

	processor=m68k	Why does a ***Prolog*** program need to know this?
			All that a Prolog program can detect about the
			hardware is integer and floating-point characteristics,
			and it is better for the user to provide those
			characteristics as such.  If the Prolog code is to
			be linked with C code, tell C about it.  In fact,
			C preprocessors already _know_ this stuff.
			It could, however, be provided through

			environment(machine(Processor(Model)))

			e.g. environment(machine(mips(r6000)))

	processor_variation=...

			What I said about why does a Prolog program need to
			know this goes for processor_variation, in spades.
			Consider, for example, knowing that a machine is
			such-and-such a MIPS chip.  That doesn't even tell
			you the byte sex!  And for Intel chips, knowing which
			Mask/Stepper number applies to the chip is nearly as
			important as knowing that it's a 386.

	model and manufacturer
			Again, model is dependent on manufacturer and should
			not be specially coded:  we want mac(plus), mac(iici)
			and so on.  And it isn't _really_ the manufacturer
			we want to know:  if we have two very similar IBM PC
			clones, we _can't_ find out who manufactured them
			and we don't _care_; all we care about is the general
			architecture, if that.  So we might have

			environment(architecture(mac(se30)))
			environment(architecture(sgi(iris(N))))
			environment(architecture(ibmpc(at)))
			environment(architecture(sun('3'(50))))

			and so on.  Note, however, that in some networked
			operating systems, it is possible for a program to
			hop around from compatible cpu to compatible cpu,
			as long as it has been compiled for the most
			restrictive model...

My basic complaints about als_system/1 are that
	-- the interface is rather poor.
	   NEVER use <attribute> = <value>, that's DEATH to type checkers
	   You should use <attribute>(<value>) instead which type checkers
	   just *love* and which uses less storage and matches faster
	   If there is only one primitive for fetching attribute/value
	   pairs, DON'T return everything at once; who says I WANT all that
	   gubbins?  Make the default be a PREDICATE (this *is* Prolog,
	   for heaven's sake, not Lisp!) which returns a single attribute.

*/


%   environment(Feature)
%   Open Prolog version of the environment table.
%   by Mike Brady.

environment(os(mac)).
environment(os_version([6,0,5])).
environment(dialect(open)).
environment(version([1,0,36|'D'])).
environment(var(X))		:- 'env var'(X).
environment(atom(X))		:- 'env atom'(X).
environment(string(X))		:- 'env string'(X).
environment(integer(X))		:- 'env integer'(X).
environment(float(X))		:- fail.
environment(float(single,X))	:- fail.
environment(arity(X))		:- 'env arity'(X).
environment(stream(X))		:- 'env stream'(X).
environment(file_name(X))	:- 'env file'(X).
environment(file_type(T,W))	:- fail.

'env var'(read(8192)).
'env var'(assert(8192)).
'env var'(width(9)).

'env atom'(size(255)).
'env atom'(min(0)).
'env atom'(max(255)).
'env atom'(width(X))		:- 'env atom'(size(S)), X is 2+S*2.
'env atom'(number(X))		:- fail.

'env string'(size(255)).
'env string'(min(0)).
'env string'(max(255)).
'env string'(width(X))		:- 'env string'(size(S)), X is 2+S*2.

'env integer'(size(32)).
'env integer'(small(X))		:- 'env integer'(size(S)), X is -1 << (S-1).
'env integer'(large(X))		:- 'env integer'(small(S)), X is -1 - S.
'env integer'(width(10)).
'env integer'(too_big(error)).
'env integer'(overflow(error)).

'env arity'(functor(8192)).
'env arity'(call(8192)).
'env arity'(foreign(8192)).

'env stream'(read( user)).
'env stream'(write(user)).
'env stream'(error(user)).
'env stream'(trace(user)).

'env file'(size(255)).
'env file'(host(_)) :- fail.
'env file'(device(27)).
'env file'(directory(31)).
'env file'(depth(126)).		% supposedly no limit
'env file'(name(31)).
'env file'(type(_)) :- fail.
'env file'(base(31)).
'env file'(version(_)) :- fail.



