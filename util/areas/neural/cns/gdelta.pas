		                      Artificial Neural Networks

                       An Example Program in PASCAL


                    		  Mark Watson, Copyright 1987



	  There are many reasons for doing neural modeling which range in
scope from research in cognitive pschycology to exploring techniques for
performing computationally expensive signal processing tasks using
massive numbers of simple hardware realizable components.  In the last
twenty years, several theories for self adapting systems have evolved; 
the program discussed here uses one of these approaches, the Generalized
Delta Rule for error propagation and connection weight modification (ie.
learning).  The best reference for the Generalized Delta Rule and other
popular learning paradigms is the book  "Parallel Distributed Processing,
Exploring the Microstructures of Cognition" by David Rumelhart and James
McClelland (editors).



	  What is a neural network?  We will answer this in the context of the
simulation program (listed at the end of this article) by first defining a
few terms:


	neuron		      A processing element with one memory cell to
			            record its energy or activation level.  A neuron
			            has one output and any number of inputs.


	connection	   A linkage between two neurons.  Each such linkage
			            is characterized by a the two connected neurons,
			            by a connection strength or weight, and by a
            			direction.


	weight		      A numeric factor which determines how easily
			            a connection propagates energy excitation
			            from one neuron to another.


	slab		        A collection of neurons which are manipulated
			            by this system as a group and which have no
			            connections between them.



	   In the attached PASCAL program, there are three slabs of neurons:
input, hidden and output.  Activation energy flows from the input slab
neurons through connecting weights to hidden slab neurons;  the larger a
weight, the faster it can propagate activation energy to hidden slab  
neurons.  Similarly, the hidden slab to the output slab weights carry
activation energy from the hidden slab neurons to the output slab neurons. 
It is interesting to note that the information processing capability
of neural networks is in the weights, not in the activation values.  The
activation values tend to change quickly while the weights only change
during 'learning', and then the are modified very slowly.


	   The first step in using the attached program is to modify the number
of neurons in each slab, if desired, by changing the constant declarations
at the beginning of the program.  The next step in using this model is to
"train" it by giving it a training set consisting of values for the input slab
neurons and the desired values for the output slab neurons.  The attached
program is already set up to learn four patterns;  the main program
consists of a training loop and a final test.  Notice that the network is
trained by repeating the complete set of training examples many times.  A
common mistake is made by completely training a Generalized Delta
Network for one pattern (i.e. so there is little error when
comparing the values of the output slab activations with the
desired system output) before learning the next pattern.


	   It takes a very long time to learn patterns in a neural network that
is being simulated on a conventional computer.  The learning process is
especially slow on a Macintosh with no hardware floating point support. 
The example program uses floating point calculations, although it is fairly
straight forward to use 32 bit integer arithmetic for implementing the
Generalized Delta Rule.  It is difficult to perform learning experiments in
8 or 16 bit integer arithmetic because calculated changes to the
connection weights must be very small compared to the magnitude of the
weights themselves.  This is very important since in general many
patterns will be learned by a system, and fast learning causes fast
'forgetting'.


	   I am training a Delta Rule Network (with six slabs, which is more 
complex than the attached program) to recognize digitized speech.  The
learning process is painfully slow.  This program has been optimized by
using 32 bit integer arithmetic (instead of floating point) and by storing
values for the procedure 'sigmoid' in the attached listing in a large table
and perfoming a lookup instead of evaluating a transcedental function for
every activation update.  Still the speech system takes DAYS to learn a
few phonemes (although recognition is fast since only one forward pass
through the network is required).  The company I work for (Science
Applications International Corporation) is building a very high speed
processor for peforming all the standard neural network learning
paradigms (Generalized Delta, Adaptive Resonance, Hopfield, etc.).  I can
perform about 5,000 weight updates (in learning) per second on a
Macintosh; our processor will perform 1 to 10 million updates per second. 
Several research groups are working on 'real' neural computers that have
many (thousands, perhaps millions of) individual processors with many
more (tens of millions) of hardware weight interconnects; it will probably
take several years before these systems can be built with enough neurons and
connecting weights to solve useful problems.



	Listing 1 - Generalized Delta Rule Simulator in Turbo PASCAL



PROGRAM testGeneralizedDeltaRuleEngine;

{------------- Copyright 1987, Mark L. Watson -----------------}
{-------- Program to test Generalized Delta Engine ------------}

{$R-}
{ This simulator is hardwired for 3 slabs: input, hidden and output }
 USES Memtypes, QuickDraw;

	CONST
		numInput  = 4;    { number of neurons in the input slab }
		numhidden = 20;   { number of neurons in the hidden slab }
		numOutput = 4;    { number of neurons in the output slab }

  numCompleteTrainingCycles = 50;

	TYPE
		INPUTARRAY = ARRAY[1..numInput] OF real;

	VAR
		inputA:INPUTARRAY;                                { activations }
		hiddenA:ARRAY[1..numhidden] OF real;              { activations }
		hiddenN:ARRAY[1..numhidden] OF real;              { sum of products }
		hiddenD:ARRAY[1..numhidden] OF real;              { output error }
		hiddenW:ARRAY[1..numhidden, 1..numInput] OF real; { connection weights }
		outputA:ARRAY[1..numOutput] OF real;              { activations }
		outputN:ARRAY[1..numOutput] OF real;              { sum of products }
		outputD:ARRAY[1..numOutput] OF real;              { output error }
		outputW:ARRAY[1..numOutput, 1..numhidden] OF real;{ connection weights }

		eida, theta:real; { learning rate and sigmoid threshold }
		waitChar:char;
		iter, numTrain:integer;

{--------------Start of the Generalized Delta Simulation Engine ------}

	FUNCTION xmax (x, y:real):real;
	BEGIN	IF x > y THEN	xmax:=x	ELSE	xmax:=y; END;

	FUNCTION xmin (x, y:real):real;
	BEGIN	IF x < y THEN	xmin:=x	ELSE	xmin:=y; END;

	FUNCTION sigmoid (x:real):real; { non-linear neuron response function }
	BEGIN
		sigmoid:=xmin(1.0,xmax(-1.0, 1.0 - exp(-(1.5*x) + theta)));
	END;

	PROCEDURE feedforward; { propagate neuron activation values from the   }
		VAR                   { input neurons to the hidden neurons, then     }
			i, j:integer;        { from the hidden neurons to the output neurons }
			sum2:real;
	BEGIN
    { do input to hidden slab:}
		FOR i:=1 TO numhidden DO
			BEGIN
				sum2:=0;
				FOR j:=1 TO numInput DO
					sum2:=sum2 + hiddenW[i, j] * inputA[j];
				hiddenN[i]:=sum2;
				hiddenA[i]:=sigmoid(sum2);
			END;
    { do hidden to output slab:}
		FOR i:=1 TO numOutput DO
			BEGIN
				sum2:=0;
				FOR j:=1 TO numhidden DO
					sum2:=sum2 + outputW[i, j] * hiddenA[j];
				outputN[i]:=sum2;
			END;
	END; { feedforward }

	PROCEDURE calcdeltas;
		VAR	i, n:integer;
	   		del, delw, temp:real;
	BEGIN
    { calculate deltas for the output slab }
		FOR n:=1 TO numOutput DO
			BEGIN
				del:=outputA[n] - sigmoid(outputN[n]);
				outputD[n]:=del;
				FOR i:=1 TO numhidden DO
					outputW[n, i]:=outputW[n, i] + del * hiddenA[i] * eida;
			END;
	END; { calcdeltas }

	PROCEDURE updateweights;
		VAR	i, n:integer;
		   	del, temp, sum2:real;
	BEGIN
    { now update the hidden slab neuron weights: }
		FOR n:=1 TO numhidden DO
			BEGIN
				sum2:=0;
				FOR i:=1 TO numOutput DO
					sum2:=sum2 + outputD[i] * outputW[i, n];
				del:=sum2;
				FOR i:=1 TO numInput DO
					hiddenW[n, i]:=hiddenW[n, i] + eida * del * inputA[i];
			END;
	END; { updateweights }

	PROCEDURE learn;  { main procedure for weight modification }
	BEGIN
		feedforward;
		calcdeltas;
		updateweights;
	END;

	PROCEDURE run;    { procedure for recalling network outputs for a }
		VAR              { given input }
			i, j:integer;
			sum2:real;
	BEGIN
    { do input to hidden slab:}
		FOR i:=1 TO numhidden DO
			BEGIN
				sum2:=0;
				FOR j:=1 TO numInput DO
					sum2:=sum2 + hiddenW[i, j] * inputA[j];
				hiddenA[i]:=sigmoid(sum2);
			END;
    { do hidden to output slab:}
		FOR i:=1 TO numOutput DO
			BEGIN
				sum2:=0;
				FOR j:=1 TO numhidden DO
					sum2:=sum2 + outputW[i, j] * hiddenA[j];
				outputA[i]:=sigmoid(sum2);
			END;
	END; { run }

{-----------------END of Generalized Delta Rule Simulation Engine ------}

	FUNCTION frandom (xmin, xmax:real):real;
		VAR	x:real;
	BEGIN
		x:=Random MOD 5000; x:=abs(x);
		frandom:=x * (xmax - xmin) / 5000.0 + xmin;
	END;

	PROCEDURE init;
		VAR	i, n:integer;
	BEGIN
		FOR i:=1 TO numhidden DO
			BEGIN
				hiddenA[i]:=frandom(0.005, 0.2);
				FOR n:=1 TO numInput DO
					hiddenW[i, n]:=frandom(-0.1, 0.15);
			END;
		FOR i:=1 TO numOutput DO
			BEGIN
				FOR n:=1 TO numhidden DO
					outputW[i, n]:=frandom(-0.1, 0.15);
			END;
	END;  { init }

 PROCEDURE TrickForLearning; { Special trick: add a little random noise  }
  VAR i:INTEGER;             { to the training input for faster          }
 BEGIN                       { learning. This procedure is not required. }
    FOR i:=1 to numInput DO inputA[i] := inputA[i] + frandom(0.0,0.15);
 END;
 
	PROCEDURE printKey (a:INPUTARRAY); { print output activations after }
		VAR	i:integer;                    { doing one recall cycle         }
	BEGIN
		FOR i:=1 TO numInput DO	inputA[i]:=a[i]; { load up the input neurons }
		run;                                     { calculate outputs }
		FOR i:=1 TO numOutput DO		write(outputA[i]:5:2, ' '); { print outputs }
		writeln;
	END;

{--- The following is a 'throw away' test main program.  To use this
     system for your own applications, set the size of the network by
     changing this constants: 'numInput', 'numHidden', and 'numOutput'
     at the beginning of this file.  Fill in the inputA array and call
     procedure 'learn' with the patterns to learn.  Calling 'run' with
     desired values in 'inputA' yeilds the system's response in the
     array 'outputA'.
--}
BEGIN { main program }

	eida:=0.7; { set learning rate to a moderately high value }
	theta:=-0.3;


	init;  { randomize weights and set up network to BEGIN }
 writeln('Starting to learn 4 simple patterns:');
 
	FOR numTrain:=1 TO numCompleteTrainingCycles DO
		BEGIN
   IF eida > 0.05 THEN eida:=eida * 0.8; { slow down the learning rate }

    writeln;
    writeln('Starting to learn all patterns with learning rate=',eida);
    writeln;
     
   { learn first pattern }
			inputA[1]:=0.0;	 inputA[2]:=0.5;  inputA[3]:=0.5;  inputA[4]:=0.0;
			outputA[1]:=0.5; outputA[2]:=0.0; outputA[3]:=0.0; outputA[4]:=0.0;
   TrickForLearning;
			FOR iter:=1 TO 2 DO		learn; { do 5 learning cycles }
			write(' Output activations should be 0.5 0.0 0.0 0.0, they are:');
  	printKey(inputA); { see error }
   
   { learn second pattern }
			inputA[1]:=0.5;	 inputA[2]:=0.0;  inputA[3]:=0.5;  inputA[4]:=0.0;
			outputA[1]:=0.0; outputA[2]:=0.5; outputA[3]:=0.0; outputA[4]:=0.0;
   TrickForLearning;
			FOR iter:=1 TO 2 DO		learn; { do 5 learning cycles }
			write(' Output activations should be 0.0 0.5 0.0 0.0, they are:');
   printKey(inputA); { see error }
   
   { learn third pattern }
			inputA[1]:=0.0;	 inputA[2]:=0.5;  inputA[3]:=0.0;  inputA[4]:=0.5;
			outputA[1]:=0.0; outputA[2]:=0.0; outputA[3]:=0.5; outputA[4]:=0.0;
   TrickForLearning;
			FOR iter:=1 TO 2 DO		learn; { do 5 learning cycles }
			write(' Output activations should be 0.0 0.0 0.5 0.0, they are:');
   printKey(inputA); { see error }
   
   { learn fourth pattern }
			inputA[1]:=0.5;	 inputA[2]:=0.0;  inputA[3]:=0.0;  inputA[4]:=0.5;
			outputA[1]:=0.0; outputA[2]:=0.0; outputA[3]:=0.0; outputA[4]:=0.5;
   TrickForLearning;
			FOR iter:=1 TO 2 DO		learn; { do 5 learning cycles }
			write(' Output activations should be 0.0 0.0 0.0 0.5, they are:');
   printKey(inputA); { see error }

		END;

{-- done learning patterns, test the network to see how well the
    patterns were learned.  Note: printKey calls run to print
    the values of the Output activations for a specified
    set of input neuron activations.
--}

  writeln; writeln('Done with 10 learning cycles: recall patterns:');
  
   
   { test first pattern }
			inputA[1]:=0.0;	inputA[2]:=0.5; inputA[3]:=0.5; inputA[4]:=0.0;
			write(' Output activations should be 0.5 0.0 0.0 0.0, they are:');
   printKey(inputA); { see error }
   
   { test second pattern }
			inputA[1]:=0.5;	inputA[2]:=0.0; inputA[3]:=0.5; inputA[4]:=0.0;
			write(' Output activations should be 0.0 0.5 0.0 0.0, they are:');
   printKey(inputA); { see error }
   
   { test third pattern }
			inputA[1]:=0.0;	inputA[2]:=0.5; inputA[3]:=0.0; inputA[4]:=0.5;
			write(' Output activations should be 0.0 0.0 0.5 0.0, they are:');
   printKey(inputA); { see error }
   
   { test fourth pattern }
			inputA[1]:=0.5;	inputA[2]:=0.0; inputA[3]:=0.0; inputA[4]:=0.5;
			write(' Output activations should be 0.0 0.0 0.0 0.5, they are:');
   printKey(inputA); { see error }
  
	  writeln('Hit a return to END...');  	 read(waitChar);

END.                        