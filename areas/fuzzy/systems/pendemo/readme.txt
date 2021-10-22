     The Togai InfraLogic Inverted Pendulum Demonstration


OVERVIEW

This demonstration consists of a simulated inverted pendulum
that is controlled by a fuzzy logic knowledge base.  The
fuzzy logic knowledge base was developed with the Togai
InfraLogic Fuzzy-C Development System.	All source code
is supplied.



SYSTEM REQUIREMENTS

To run the pendulum demonstration, you need:

    - An IBM-PC or compatible.
    - An EGA adapter.
    - 256K of memory.
    - DOS 3.3 or higher.



INSTALLATION AND EXECUTION

To install the pendulum demonstration onto your hard disk,
do the following:

    - Make a directory called pend (type "md pend").
    - Go into that directory (type "cd pend").
    - Copy everything from the floppy (type "copy a:*.*").
    - Run the demonstration (type "pendemo").



DESCRIPTION

This is a demonstration of fuzzy logic control using a
stationary inverted pendulum with a variable weight and
variable motor strength.  The demonstration is designed for
"hands on" evaluation as to how fuzzy logic works.  To run
the demonstration, type "pendemo".  The demonstration will
immediately begin with the default settings.  Before
proceeding, hit the "?" key and page through the help
menus.	This should give you a good overview of how the
demonstration works.

The demonstration scree is divided into five display windows
as follows:

    1. The center window shows the pendulum itself.  These are
       the main features of this window:

       - The red bob at the top of the pendulum is a user alterable
	 mass.	You can increase or decrease the mass of the bob
	 with the F6 and shift-F6 keys respectively.

       - The green stick separates the bob from the motor.  You
	 can cause the length of the stick to vary (which
	 considerably alters the physics of the system) by
	 pressing the F7 key.

       - The blue ball at the bottom of the pendulum is a motor
	 which, when given current, drives the stick one way
	 or the other.	You can increase or decrease the strength
	 of the motor with the F5 and shift-F5 keys.

       The other items in the window reflect the status of these
       main features.

    2. The upper right window shows the fuzzy logic production
       rules that control the pendulum in a matrix style.  Each
       element in the matrix corresponds to a rule.  For example
       the center element in the matrix reads:

		 IF Theta is Z and dTheta is Z THEN
		     Current = Z

       If a rule is firing in the knowledge base, the matrix
       element corresponding to the rule is highlighted in gray.

    3. The lower right window consists of two main sections: the
       rule list and the currently selected rule display.

       You can scroll through the rule list with the up and
       down arrows of your PC.	Scrolling through the list
       dynamically sets the highlighted rule in the rule list
       to be the "current rule".  The current rule is then
       graphically displayed in the current rule display section.

       If you press the F1 key, the current rule is disabled in
       the knowledge base and the system behaves as though the
       rule does not exist.  You can re-enable the rule by pressing
       F1 again.

    4. The lower left window displays the system from a black-box
       perspective.  The crisp values for Theta and dTheta are
       shown at the top of the window (the inputs) while the
       crisp value for the motor current is displayed at the
       bottom of the window (the output).

       The middle portion of the window shows the combined fuzzy
       output for all the rules that fired in the knowledge base
       over one cycle.	The final crisp value (for that cycle)
       for motor control is determined by what is called the
       centroid defuzzification technique.  This process computes
       the moment and area for the fuzzy output polygon (shown in
       red in the center of this window) and then divides the
       moment by the area to get a crisp value.

    5. The upper left window is a trace buffer showing the motor
       current as it varies over time.

Just as in standard production rules, fuzzy logic production
rules have a premise, or IF portion, and a conclusion, or THEN
portion.  However, there are two major differences between
fuzzy production rules and standard production rules:
first, each variable of the premise and conclusion has a
set associating it to its "level of belief".  Secondly, all
rules within the fuzzy logic knowledge base which fired are
used in calculating the resulting output.  The resultant
combination of all of the rules fired is shown in the
display in the lower left window.

The premise or IF portion of the rule is evaluated by
translating an input signal to a level of belief by imposing
the input upon the membership function (which represents the
association between the linguistic variable in the fuzzy
production rule such as "negative small (NS)" or "positive
medium (PM)").  The  minimum value of all of the levels of
belief of the premise portion of the rule is used as the
output to conclusion.  This value is known as the alpha.
If alpha is not zero the rule has been fired.

The conclusion or THEN portion of a rule is evaluated by
imposing the alpha  onto the conclusion membership function
such that the conclusion membership graph is "clipped" by
the alpha value.  For all of the rules which were fired the
graphs are combined with a logical OR resulting in the
polygon  in the lower left window.  This result is then
converted into a "crisp" output by taking the centroid of
the graph.

One of the most valuable attributes of fuzzy logic is its
elasticity.  This can be demonstrated by selecting and
deselecting the rules to see their effect.  This is done by
placing the cursor over a rule in the lower right window and
hitting the F1 key.  There are 25 possible two input and one
output fuzzy production rules for this system (11 are used
in the demonstration) with a single conclusion shown as each
position in the matrix.  However, the actual number of rules
required to control an inverted pendulum is about seven.
Thus, some of the production rules can be eliminated.



PERTINENT FILES

    - demo.til	     The input file to the Fuzzy-C Compiler that
		     describes the fuzzy logic knowledge base.

    - demo.c demo.h  Two files that are generated by the
		     Fuzzy-C Compiler.

    - pendemo	     A makefile that builds the demonstration.

    - pendemo.c      Code for the simulation and graphical model.

    - pendemo.h      Header for pendemo.c.

    - tilcomp.h      Portability definitions supplied with the
		     Fuzzy-C Development System.

    - pendemo.hlp    This file.

    - pendemo.exe    Run this program to see the demonstration.



CONTACT

If you have any comments, suggestions, or questions,
please contact Togai InfraLogic, Inc. at:

    Togai InfraLogic
    5 Vanderbilt
    Irvine, CA	92718
    Phone: (714) 975-8522
    F A X: (714) 975-8524
    email: info@til.til.com

$Header:   Z:/vcs/common/pendemo.hlv   1.3   13 Oct 1992 11:33:42   eah  $
