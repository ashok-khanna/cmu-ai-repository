		     Gesellschaft fuer Informatik
			   Fachgruppe 1.1.3
				   
	     Special Interest Group on 'Machine Learning'
				   
	    Prolog library of machine learning algorithms
				   
				   
			     Thomas Hoppe
			  Projektgruppe KIT
		    Technische Universitaet Berlin
			  Franklinstr. 28/29
			     10629 Berlin
			       Germany
				   
			hoppet@cs.tu-berlin.de
				   

The  following  algorithms are currently available  from  the  library 
(last update: 25 October 1994):


1. Learning Algorithms

  AQ1
     aq1.pl       - Jeffrey M.  Becker's AQ-PROLOG, a reimplementation 
                    of Michalski's AQ for attribute vectors
     aq1_1.pl     - Simple Example for AQ
     aq1_2.pl     - Extension of AQ_1.PL 

  ARCH1
     arch1.pl     - Stefan Wrobel's   reimplementation  of   Winston's 
		    incremental  learning  procedure  for   structural  
		    descriptions
     arch1_1.pl   - Winston's example archs

  ARCH2
     arch2.pl     - Ivan Bratko's minimal implementation of  Winston's 
                    incremental  learning  procedure  for   structural 
                    descriptions
     arch2_1.pl   - simple example archs

  ATTDSC
     attdsc.pl    - Ivan Bratko's simple algorithm for learning attri-
                    butional descriptions
     attdsc_1.pl  - Small  example  set  for  learning  to   recognize 
                    objects from their silhouettes

  COBWEB
     cobweb.pl    - Joerg-Uwe Kietz's  reimplementation  of   Fisher's 
                    incremental concept formation algorithm
     cobweb_1.pl  - a simple data set describing some hotels
     cobweb_2.pl  - Gennari, Langley and Fischer's rectangle classifi-
                    cation example
     cobweb_3.pl  - Fischer's animal classification example
     cobweb_4.pl  - Gennari, Langley and Fischer's cell classification 
                    example

  DISCR
     discr.pl     - Pavel  Brazdil's generation of discriminants  from 
                    derivation trees
     discr_1.pl   - Simple abstract example
     discr_2.pl   - Abstract example generating useful and not  useful 
                    discriminants

  FOIL
     foil.pl      - John Zelle's  reimplementation  of  Ross Quinlan's 
		    Foil (First-Order Inductive Learning of Relational 
		    Concepts) System
     foil_1.pl    - Reachability Example
     foil_2.pl    - List Example
     foil_3.pl    - Quinlan's (probably faulty) Member Example 
     foil_4.pl    - Member Example 

  MULTAGNT
     multagnt.pl  - Yiu Cheung HO's implementation of Brazdil's tutor-
                    ing setting
     teacher.pl   - Teacher's knowledge base
     learner1.pl  - A correct Learner's knowledge base
     learner2.pl  - An erroneous Learner's knowledge base
     calls_1.pl   - Example calls concerning correct knowledge
     calls_2.pl   - Example calls concerning wrong knowledge

  IDT
     idt.pl       - Luis  Torgo's  ID3-like program for  induction  of 
                    decision trees based on the gain-ratio measure
     idt_1.pl     - Abstract example
     idt_2.pl     - Credit assignment example producing trivial  clas-
                    sification
     idt_3.pl     - Credit  assignment example  producing  non-trivial 
                    classification
     idt_4.pl     - Credit  assignment example  producing  non-trivial 
                    classification for three different classes
     idt_5.pl     - `Make a holiday if whether is nice' example
     idt_6.pl     - Quinlan's wheather example

  INVERS
     invers.pl    - Implementation  of Steven  Muggleton's  absorption 
                    and intra-construction operators for inverse reso-
                    lution based on the representation change idea  of 
                    Celine Rouveirol and Jean-Francois Puget
     invers_1.pl  - Example call's

  LOGIC
     logic.pl     - Steven Muggleton's implementations of substitution 
                    matching,  Plotkin's term generalisations and Wray 
                    Buntine's generalized subsumption
     logic_1.pl   - Example call's

  EBG
     ebg.pl       - Basic algorithms for explanation based generalisa-
                    tion and partial evaluation based on Kedar-Cabelli 
                    & McCarty's idea. Different kinds of simple PROLOG 
                    meta-interpreters.
     ebg_1.pl     - Suicide example for EBG
     ebg_2.pl     - Safe_to_stack example for EBG

  VS
     vs.pl        - Luc  de  Raeth's  reimplementation  of  Mitchell's 
                    version space strategy
     vs_1.pl      - A simple shape and color taxonomy


2. Updates

  All algorithms give now at consultation time a brief description  of 
  how to call them,  which can also be obtained by  proving  the  goal
  'help'.

  COBWEB 	  - Bug in data set cobweb_3.pl removed 
		  - Output of cobweb.pl prettyfied
		  - Prolog dialect dependency removed
		  - Modification for avoiding rounding errors
		  - Parameter 'acuity' can now be modified  explicitly
		  - Incorporated functions  for  displaying  generated 
		    nodes

  IDT             - Zero-division bug removed 
	          - Several Prolog dependencies removed
	          - Additional examples prepared

  AQ1		  - Prolog dialect dependency removed

3. In preparation

  MIS             - Shapiro's Model Inference System
  AQ2             - Stefan Wrobel's reimplementation of Michalski's AQ 
                    for structural descriptions
  CLUSTER         - Michalski and Stepp's Conceptual Clustering
  HEBBSIM         - Duwe & Grothaus's connectionist association matrix
  SPROUTER        - Hayes Roth's Generalisation Algorithm


4. Ordering of files

Files can be ordered either via surface or electronic mail, or
accessed via anonymous ftp.

  Surface Mail    - Send a short notice to the address given at top of 
                    this document.  Files will be distributed via  MS-
                    DOS formated 3.5 inch floppy (double, high and ex-
	            tra-high density),  which should be send with your 
	  	    request.

  E-Mail          - Send a short notice to the address given at top of 
                    this document.

  FTP             - Files  are  accessible  via  anonymous  FTP   from 
                    ftp.gmd.de
                         userid:        anonymous
                         password:      <your own e-mail address>
                         directory:     /gmd/mlt/ML-Program-Library/


5. Documentation notes

All algorithms are written in Edinburgh Prolog syntax.  Most of the
time only Clocksin/Mellish or DEC-10 built-in predicates are used.
Some programs use predicates which are not built-in w.r.t.
Clocksin/Mellish or DEC-10, but which are quite common (e.g.  append,
member, bagof). I rely that your local Prolog system has access to
their definitions.  If you have trouble with some particular
predicates send an e-mail to the address given at top of this
document. Either I will send you the predicate definition I use or I
fix the problem in the source code as soon as possible.

If a particular algorithm only consists of some predicates I try to
document every predicate (e.g. EBG.PL), otherwise I only document the
necessary predicates for running the algorithm and/or the special
changes I had to introduce (e.g. AQ1.PL ).

The sign '+' in front of an argument in a call means that the
argument, is an input argument to the function, which must be
instantiated. A sign '-' in front of an argument, means that this is
an output argument, which should not be instantiated. No sign in front
of an argument indicates that this argument works in both ways.

The property 'backtrackable' indicates that the predicate is re-
instantiated on backtracking. The property 'symmetric' means that this
predicate can also called with instantiated output arguments, deliver-
ing the appropriate input arguments.

In any case, before running a library program you should skip through
the code and see whether some adaptation to your dialect are
necessary. Some adaptations are necessary for M-Prolog, C-Prolog,
YAP-Prolog, Quintus-Prolog, and SWI-Prolog (Yes I know, it would be
better to automatize this. I will see what I can do about it.).  Most
of the programs run in the past without problems in these dialects. If
you have a different dialect, you need to try the program (if you
detect problems, see the following note).

The programs are not yet completely documented. Anyway, at
consultation time every program displays a brief message of how to
call the program.  This information will also be displayed by the call
':- help.'. If you like to process your own data, take a look into the
examples to see how the syntax for the input data looks like. Note,
that for some programs the examples does not cover the input data
completely (e.g. AQ1 can also deal with taxonomies). In the case of
doubt, either look up the original papers, or contact me under the
address given above.


6. Notes on bug detection

The library has evolved over several years on different systems and
different Prolog dialects (i.e. M-Prolog, YAP-Prolog, Quintus-Prolog,
and SWI-Prolog). Although I have tried to make it as independent as
possible from the peculiarities of different Prolog dialects, it
happens occasionally that (still undetected) Prolog dependencies cause
problems. If you detect such a problem, please contact me and report
the problem to the address given at top of this document.

Some features of certain Prolog dialects cause sometimes problems
(e.g.  different operator precedences, missing first arg indexing,
varying real precision). The following Prolog dialects where
identified to cause: LPA-Prolog, Arity-Prolog, and SWI-Prolog. If you
find a 'new feature' which you didn't expected, let me know about it,
so that others can benefit from your experience.  Send bug reports to
the address given at top of this document.


7. Notes on software delivery

Because any library has to rely on authors, we encourage everybody who
has implemented a machine learning algorithm to participate in the
extension of the library.

Software should be send on 3.5 inch floppies formated either for MSDOS
or NeXT, or by electronic mail to the address given at top of this
document.

For the purpose of a uniform documentation and easy maintenance,
please include a note with references about the algorithm and if
possible document the top-level calls of your program with the
following form:

/**********************************************************/
/*                                                        */
/*  call        : predicate (+ARG1,-ARG2)                 */
/*                                                        */
/*  arguments   : ARG1 = is of type xyz                   */
/*                ARG2 = is something different in the    */
/*                       following form                   */
/*                                                        */
/*  side effects: which ever side effects the predicate   */
/*                produces                                */
/*                                                        */
/*  properties  : backtrackable, or whatever outstanding  */
/*                properties the predicate has            */
/*                                                        */
/*  references  : actual reference of the algorithm       */
/*                                                        */
/**********************************************************/
/* A short description of what the predicate does and how */
/* the input and output can be interpreted.               */
/**********************************************************/

8. Copyright and Warranty Notice

Most of the algorithms are copyleft under the GNU GENERAL PUBLIC
LICENSE (which should be available on your site, which you can obtain
from the ftp site above, or which was delivered on the floppy), others
are not. Take a look into the code for determining the actual
copyright status of the program. Anyway, for programs not copyleft
under the GNU LICENSE, the items 9. and 10. of the GNU LICENSE about
warranty apply.

9. Contents of other files in the directory

   README:   This description
   LOGFILE:  Description of recent additions and changes.
   GNU-GENERAL-PUBLIC-LICENSE: GNU General Public License
