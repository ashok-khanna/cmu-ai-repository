PC-KIMMO: A Two-level Processor for Morphological Analysis

   WHAT IS PC-KIMMO?
   WHO IS PC-KIMMO FOR?
   VERSIONS AVAILABLE
   THE PC-KIMMO BOOK
   RELATED SOFTWARE: KGEN, KTEXT and Englex
   HOW TO GET PC-KIMMO VIA FTP
   HOW TO CONTACT THE DEVELOPERS
   REFERENCES
   PC-KIMMO Order Form

WHAT IS PC-KIMMO?

PC-KIMMO is a new implementation for microcomputers of a program
dubbed KIMMO after its inventor Kimmo Koskenniemi (see
Koskenniemi 1983). It is of interest to computational linguists,
descriptive linguists, and those developing natural language
processing systems. The program is designed to generate (produce)
and/or recognize (parse) words using a two-level model of word
structure in which a word is represented as a correspondence
between its lexical level form and its surface level form.

Work on PC-KIMMO began in 1985, following the specifications of
the LISP implementation of Koskenniemi's model described in
Karttunen 1983. The coding has been done in Microsoft C by David
Smith and Stephen McConnel under the direction of Gary Simons and
under the auspices of the Summer Institute of Linguistics. The
aim was to develop a version of the two-level processor that
would run on an IBM PC compatible computer and that would include
an environment for testing and debugging a linguistic
description. The PC-KIMMO program is actually a shell program
that serves as an interactive user interface to the primitive
PC-KIMMO functions. These functions are available as a C-language
source code library that can be included in a program written by
the user.

A PC-KIMMO description of a language consists of two files
provided by the user:

    (1) a rules file, which specifies the alphabet and the
phonological (or spelling) rules, and

    (2) a lexicon file, which lists lexical items (words and
morphemes) and their glosses, and encodes morphotactic
constraints.

The theoretical model of phonology embodied in PC-KIMMO is called
two-level phonology. In the two-level approach, phonological
alternations are treated as direct correspondences between the 
underlying (or lexical) representation of words and their realization 
on the surface level. For example, to account for the rules of English
spelling, the surface form spies must be related to its lexical
form `spy+s as follows (where ` indicates stress, + indicates a
morpheme boundary, and 0 indicates a null element):

    Lexical Representation:   ` s p y + 0 s
    Surface Representation:   0 s p i 0 e s

Rules must be written to account for the special correspondences
`:0, y:i, +:0, and 0:e.  For example, the two-level rule for the
y:i correspondence looks like this (somewhat simplified):

          y:i => @:C___+:0

Notice that the environment of the rule is also specified as a
string of two-level correspondences.  Because two-level rules have
access to both underlying and surface environments, interactions
among rules can be handled without using sequential rule ordering.
All of the rules in a two-level description are applied simultaneously,
thus avoiding the creation of intermediate levels of derivation (an 
artifact of sequentially applied rules). 

The two functional components of PC-KIMMO are the generator and
the recognizer. The generator accepts as input a lexical form,
applies the phonological rules, and returns the corresponding
surface form. It does not use the lexicon. The recognizer accepts
as input a surface form, applies the phonological rules, consults
the lexicon, and returns the corresponding lexical form with its
gloss. Figure 1 shows the main components of the PC-KIMMO system.

Figure 1:  Main components of PC-KIMMO

           +-----------+        +-----------+
           |  RULES    |        |  LEXICON  |
           +----+------+        +------+----+
                |-------+      +-------|
                        |      |
                        v      v
    Surface Form:  +------------------+      Lexical Form:
     spies ------->|    Recognizer    |----> `spy+s
                   +----+-------------+      [N(spy)+PLURAL]
                        |
                        v
                   +------------------+
     spies <-------|    Generator     |<----- `spy+s
                   +------------------+


The rules and lexicon are implemented computationally using finite 
state machines. For example, the two-level rule shown above
for the y:i correspondence must be translated into the following 
finite state table for PC-KIMMO to use:

          |@ y + @
          |C i 0 @
        --+-------
        1:|2 0 1 1
        2:|2 3 2 1
        3.|0 0 1 0

(Note: as of May 1991, there is a beta test vesion of a rule compiler
available, called KGEN. See below for more information.)

Around the components of PC-KIMMO shown in figure 1 is an
interactive shell program that serves as a user interface. When
the PC-KIMMO shell is run, a command-line prompt appears on the
screen. The user types in commands which PC-KIMMO executes. The
shell is designed to provide an environment for developing,
testing, and debugging two-level descriptions. Among the features
available in the user shell are:

    * on-line help;

    * commands for loading the rules and lexicon files;

    * ability to generate and recognize forms entered
interactively from the keyboard;

    * a mechanism for reading input forms from a test list on a
disk file and comparing the output of the processor to the
correct results supplied in the test list;

    * provision for logging user sessions to disk files;

    * a facility to trace execution of the processor in order to
debug the rules and lexicon;

    * other debugging facilities including the ability to turn
off selected rules, show the internal representation of rules,
and show the contents of selected parts of the lexicon; and

    * a batch processing mode that allows the shell to read and
execute commands from a disk file.

Because the PC-KIMMO user shell is intended to facilitate
development of a description, its data-processing capabilities
are limited. However, PC-KIMMO can also be put to practical use 
by those engaged in natural language processing. The primitive 
PC-KIMMO functions (including load rules, load lexicon,
generate, recognize) are available as a source code library
that can be included in another program. This means that the users
can develop and debug a two-level description using the PC-KIMMO
shell and then link PC-KIMMO's functions into their own programs.


WHO IS PC-KIMMO FOR?

Up until now, implementations of Koskeniemmi's two-level model have 
been available only on large computers housed at academic or 
industrial research centers. As an implementation of the two-level 
model, PC-KIMMO is important because it makes the two-level processor 
available to individuals using personal computers. Computational 
linguists can use PC-KIMMO to investigate for themselves the properties 
of the two-level processor. Theoretical linguists can explore the
implications of two-level phonology, while descriptive linguists
can use PC-KIMMO as a field tool for developing and testing their
phonological and morphological descriptions. Teachers of courses on
computational linguistics can use PC-KIMMO to demonstrate the two-level
approach to morphological parsing.  Finally, because the source code for 
the PC-KIMMO's generator and recognizer functions is made available, 
those developing natural language processing language processing 
applications (such as a syntactic parser) can use PC-KIMMO as a 
morphological front end to their own programs.

(Note: as of May 1991, a program called KTEXT is available. It uses the
PC-KIMMO parser and processes text, producing a morphological parse of
each word in the text. See below for more information.)


VERSIONS AVAILABLE

PC-KIMMO will run on the following systems:
    MS-DOS or PC-DOS (any IBM PC compatible)
    Macintosh
    UNIX System V (SCO UNIX V/386 and A/UX) and 4.2 BSD UNIX

There are two versions of the PC-KIMMO release diskette, one for
IBM PC compatibles and one for the Macintosh. Each contains the
executable PC-KIMMO program, examples of language descriptions,
and the source code library for the primitive PC-KIMMO functions.
The PC-KIMMO executable program and the source code library are
copyrighted but are made freely available to the general public
under the condition that they not be resold or used for
commercial purposes.

It should be noted that the Macintosh version retains the
DOS/UNIX command-line interface rather than using the graphical
user interface one expects from Macintosh programs.

For those who wish to compile PC-KIMMO for their UNIX system, we
will supply the full sources. But you must also obtain either the
IBM PC version or the Macintosh version in order to get all the
sample files.

The PC-KIMMO release diskette contains the executable PC-KIMMO
program, the function library, and examples of PC-KIMMO
descriptions for various languages, including English, Finnish,
Japanese, Hebrew, Kasem, Tagalog, and Turkish. These are not
comprehensive linguistic descriptions, rather they cover only a
selected set of data.

Versions of PC-KIMMO and KTEXT are now available for PC's running
a 386 CPU (or higher). The main advantage of these 386 versions
is that they will use all available extended/expanded memory and
will also use virtual memory. This means that you can load a
lexicon that is larger than 640K (such as Englex described
below). These 386 versions support VCPI-compliant memory managers
such as MS-DOS 5.0's EMM386 and Quarterdeck's QEMM386. They do
not support Microsoft Windows.


THE PC-KIMMO BOOK

The complete PC-KIMMO release software is included with the book
"PC-KIMMO: a two-level processor for morphological analysis" by
Evan L. Antworth, published by the Summer Institute of
Linguistics (1990).  The book is a full-length (273 pages) tutorial 
on writing two-level linguistic descriptions with PC-KIMMO. It also
fully documents the PC-KIMMO user interface and the source code
function library. The book with release diskette(s) is available
for $24.00 (plus postage) from:

    International Academic Bookstore
    7500 W. Camp Wisdom Road
    Dallas TX, 75236
    U.S.A.

    phone: 214/709-2404
    fax:   214/709-2433
    email: Academic.Books@sil.org

A partial listing of the contents of the book is as follows:

1. Introduction
   1.1 What is PC-KIMMO
   1.2 The history of PC-KIMMO
   1.3 The significance of PC-KIMMO
2. A sample user session with PC-KIMMO
3. Developing the rules component
   3.1 Understanding two-level rules
   3.2 Implementing two-level rules as finite state machines
   3.3 Compiling two-level rules into state tables
   3.4 Writing the rules file
4. Developing the lexical component
   4.1 Structure of the lexical component
   4.2 Encoding morphotactics as a finite state machine
   4.3 Writing the lexicon file
5. Testing a two-level description
   5.1 Types of errors in two-level descriptions
   5.2 Strategies for debugging a two-level description
6. A sampler of two-level rules
   6.1 Assimilation
   6.2 Deletion
   6.3 Insertion
   6.4 Nonconcatenative processes
       [gemination, metathesis, infixation, reduplication]
7. Reference manual
   7.1 Introduction and technical specifications
   7.2 Installing PC-KIMMO
   7.3 Starting PC-KIMMO
   7.4 Entering commands and getting on-line help
   7.5 Command reference by function
   7.6 Alphabetic list of commands
   7.7 File formats
   7.8 Trace formats
   7.9 Algorithms
   7.10 Error messages
Appendix A. Developing a description of English
Appendix B. Other applications of the two-level processor, by G. Simons
Appendix C. Using the PC-KIMMO functions in a C program, by S. McConnel
References
Index

RELATED SOFTWARE: KGEN, KTEXT and Englex

KGEN, a rule compiler for PC-KIMMO, was written by Nathan Miles of Ohio State 
University. 

KGEN takes a two-level rule like this:

        y:i => @:C___+:0

and translates it into a finite state table like this:

           @ y + @
           C i 0 @
        1: 2 0 1 1
        2: 2 3 2 1
        3. 0 0 1 0

KGEN accepts as input a file of two-level rules and produces as output a file 
of state tables that is identical in format to PC-KIMMO's rules file. Anything 
that KGEN does not correctly handle can be easily fixed by hand in its output 
file. KGEN runs under MS-DOS, UNIX, and Macintosh. 

KTEXT is a new text-processing application that uses the PC-KIMMO parser. It 
accepts as input a text in orthographic form, tokenizes it into words, strips 
off and saves punctuation, capitalization, white space, and formatting codes, 
parses each word, and outputs the result to a quasi-database file with a 
record for each word. Its output data structures are suitable for further 
processing by other programs, such as a text interlinearizer, a syntactic 
parser, or a machine translation system. KTEXT is available for MS-DOS, 
Macintosh, 
and UNIX. 


Englex is a morphological parsing lexicon of English intended for use with 
PC-KIMMO and/or KTEXT. Its 20,000 entries consist of affixes, roots, and
indivisible stems. Both inflectional and derivational morphology are
analyzed. Englex will run under Unix, Macintosh, or MS-DOS (the files are
plain ascii and are identical for all three versions). Because of memory 
requirements, to run Englex under MS-DOS you will need a 386 cpu and 
the new 386 versions of PC-KIMMO and KTEXT. These 386 versions will use all 
available extended/expanded memory and virtual memory. They support 
VCPI-compliant memory managers such as DOS 5.0's EMM386 and Quarterdeck's 
QEMM. They do not support (or need) Windows.


HOW TO GET PC-KIMMO VIA FTP

For those who would like to try out PC-KIMMO for free, it is available on 
various FTP archives or bulletin boards, notably the Consortium 
for Lexical Research at clr.nmsu.edu [128.123.1.12]. Send e-mail inquiries
to lexical@nmsu.edu. (For a listing of their holdings, get the file
catalog-short in the top directory.) Here are the subdirectories and 
file names:

Directory: pub/tools/ling-analysis/morphology/pc-kimmo
    pckim108.zip    Zipped MS-DOS file of pc-kimmo108 (inc. 386 version)
    pckim108.tar.Z  Compressed UNIX tar file of pc-kimmo108 sources
    pckimmo108.hqx  Stuffed, binhexed Mac file of pc-kimmo108

Directory: pub/tools/ling-analysis/englex_pckimmo
    englex10.zip    Zipped MS-DOS file of englex10
    englex10.tar.Z  Compressed UNIX tar file of englex10
    englex10.hqx    Stuffed, binhexed Mac file of englex10

Directory: pub/tools/ling-analysis/morphology/ktext
    ktext103.zip    Zipped MS-DOS fiel of ktext103 (inc. 386 version
    ktext103.tar.Z  Compressed UNIX tar file of ktext103 sources
    ktext103.hqx    Stuffed, binhexed Mac file of ktext103

KGEN  is available from:

     wsmr-simtel20.army.mil [192.88.110.20]
     pd1:<msdos.linguistics>kgen02.zip

     cis.ohio-state.edu [128.146.8.60]
     pub/kgen/kgen03.tar.Z



HOW TO CONTACT THE DEVELOPERS

PC-KIMMO is a research project in progress, not a finished
commercial product. In this spirit, we invite your response to
the software and the book. Please direct your comments to:

    Academic Computing Department
    PC-KIMMO project
    7500 W. Camp Wisdom Road
    Dallas, TX 75236
    U.S.A.

    phone: 214/709-3346, -2418
    fax:   214/709-24333
    email: Evan.Antworth@sil.org


REFERENCES

Antworth, Evan L. 1990. PC-KIMMO: a two-level processor for
    morphological analysis. Occasional Publications in Academic
    Computing No. 16. Dallas, TX: Summer Institute of Linguistics.
    ISBN 0-88312-639-7, 273 pages, paperbound.

____. 1993. Glossing text with the PC-KIMMO morphological parser.
    Computers and the Humanities 26:475-484.

Karttunen, Lauri. 1983. KIMMO: a general morphological processor.
    Texas Linguistic Forum 22:163-186.

Koskenniemi, Kimmo. 1983. Two-level morphology: a general
    computational model for word-form recognition and production.
    Publication No. 11. University of Helsinki: Department of
    General Linguistics.

Miles, Nathan L. 1991. Automatic generation of two-level FSM
    tables. M.A. thesis, Ohio State University. [Description of the
    KGEN rule compiler.]

Sproat, Richard. 1991. Review of "PC-KIMMO:  a two-level
    processor for morphological analysis" by Evan L. Antworth.
    Computational Linguistics 17.2:229-231.



------------------------------------------------------------------------

PC-KIMMO Order Form

  Qty |                       |  Price   | Total
--------------------------------------------------
      | PC-KIMMO book+disk    |  $24.00  |
      |                       |          |
      | Texas residents add   |          |
      |  8% sales tax         |          |
      |                       |          |
      | Shipping and Handling |          |
      |     USA               |  $2.50   |
      |     Foreign (surface) |  $3.00   |
      |     Foreign (airmail) |  $8.00   |
--------------------------------------------------
                          Total amount:


Important: Checks must be drawn on a U.S. bank. Sorry, no credit cards.


Specify version and disk format desired:
  ___ 5.25" 360K MS-DOS (IBM PC)
  ___ 3.5"  720K MS-DOS (IBM PC)
  ___ 3.5"  800K Macintosh
  ___ UNIX (You *must* also specify one of the above three versions.
            UNIX source files will be sent on 5.25" 360K MS-DOS
            diskettes unless you request otherwise.)


Name

Institution

Address





Send this order form to the address below. Either enclose payment or ask
to be billed by invoice. Phone and Fax orders also accepted.

        International Academic Bookstore
        7500 W. Camp Wisdom Road
        Dallas, TX  75236
        U.S.A.

        phone: 214/709-2404
        fax:   214/709-2433
        email: Academic.Books@sil.org

------------------------------------------------------------------------


