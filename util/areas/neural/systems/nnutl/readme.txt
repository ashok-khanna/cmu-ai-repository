                                    NNUTILS.ZIP
              by Gregory Stevens (stevens@prodigal.psych.rochester.edu)
                                     ver 1.01

              Tutorial Package Comments, Instructions, Documentation

This is a Public Domain package of files that are meant to help you to
get started programming neural networks in C.  In essence, it is a tutorial
about how to program neural networks (or how to program in C, depending on
what you need to learn more), where instead of the tutorial being readable
text, it is readable code.  There are include files here with overdocumented
code that contains everything you need to implement several kinds of net
archetectures.  What you get in this package is a couple text files in
the main directory you unzip to, and then a series of simple implementations
using the include files to let you, step by step, see how they work.

In each subdirectory there is source code in C, which will usually consist
of six standard include files for the nnutils library, and a main program
which will have a name similar to that of the directory.  The source is 
written ANSI compliant C and developed primarily under Borland C++ 3.1
developing environment.  Because of this, I have included DOS executables
and project files for each implementation (except one: see BUGS.DOC).  Also,
because the code is all ANSI compliant, all of the compiles under gcc and
runs under UNIX.  This has not been included, but all you need do is put all
the source in a UNIX directory on a machine that has gcc, and type:

gcc -O -o executable.filename -lm

This sets for maximum optimization, to put the output executable file in
the name executable.filename (changable, obviously), and to include the math
library.

To use these you should have a basic understanding of the theory behind
neural networks (and C programming), even if you haven't implemented anything
before.  You should know about layers, activation states, learning and
back-propagation (even if you don't understand the math :-), supervised
versus unsupervised learning, etc.

If you don't understand the math behind back-propagation (and even if you do,
possibly!), NNBKPROP.C will be a little cryptic.  Any questions about the
math behind back-propagation or the file, you can email me at
stevens@prodigal.psych.rochester.edu.

To learn how to use the tools presented here, I suggest you look at the
code for, alter and run, the following implementations (in order):

NNTEST1  -  This is a very simple demonstration.  It is a network with
            one input node and one output node, as you can see from the
            nnparams.c file.  Also, if you look in nnstruct.c at the
            initialization function, you can see that it sets the output
            node's learning function flag to 0, representing a linear
            node.  
             This node basically can learn linear equations.  Try it.
            Give it a series of input numbers in nninputs.dat (make sure
            the number of numbers is the same as the definition of NUMPATTERNS
            in nninputs.c), and put the corresponding y values for a linear
            function in nnoutput.dat.  It will display as it trains, and
            eventually the weight will converge as the x coefficient and
            the threshhold as the y-intercept.  This demonstrates something 
            about the theory behind linear threshhold units, too.
             Try to make the values in nnoutput.dat be non-linear functions
            on the input values.  The net cannot learn them.

NNTEST2 - This is a demonstration of what's called the "logistic" activation
          function (as opposed to linear).  This is the kind of function
          generally used, because it can approximate both linear and
          stepwise activation functions.  The current nninputs.dat and
          nnoutput.dat train it to mimick a threshhold unit.  You can play
          with these at will.

NNXOR - This is an implementation of the famous Exclusive Or problem.
         Though both of the tests use back-propagation for learning, this
         is the first one that has needed hidden units.  It is set up with
         the standard archetecture for solving XOR (2 input,2 hidden,1 output)
         and the inputs and output files have been set up accordingly.  It 
         takes a while.  Be patient.

NNSIM1 - After this you are ready to look at general simulator number 1. This
        allows you flexibility to modify it into any kind of feed-forward
        network with backpropagation as the learning algorithm.  It contains
        what you need to train a net, as well as adding the file NNINTEST.DAT
        as novel patterns to expose to the net after training, with a Boolean
        to turn on or off the option of exposing the net to these novel
        patterns.
         Please play with this.  There are a lot of variables to be altered.
        Right now, in the distribution package, it should be a cheesy little
        net that I interprete as a rhythm detector.  The input layer is 
        eight nodes, with the input patterns representing one measure of
        eight eighth notes positions, with 1's representing a beat, 0's
        representing rests.  The output layer has one node, which is on (1)
        if it is a "good" rhythm (likeable), and 0 (off) otherwise.  There
        should be 10 good rhythms coded in the first ten input patterns,
        with the first 10 numbers in the nnoutput.dat being 1's, followed
        by 10 bad rhythms (10 zero's in nnoutput.dat).  This trains to
        recognize good from bad rhythms.  Then, the nnintest.dat presents
        20 novel rhythms to see if the net generalized the way people do.
         It's kinda neat.  But, you can have your input and output patterns
        represent anything you want.  Play, please.
         Things to note:  This displays every pattern as it is introduced
        to the net, and pauses the display for keyboard trigger for the
        last 10 sets of training patterns.  You can suppress output by
        putting the DisplayLayer functions and other output stuff in an
        if condition and have it only display the last trials.
          If you change the layer sizes, you will want to change the last
        number in DisplayLayer, which is the formatting function.  If would
        have made it prettier with gotoxy()'s, but I wanted it runable on 
        UNIX.  If you make a DOS display function with gotoxy's, send
        them to me, and I will put them in the next version in the file
        NNDISPLY.C.  Don't put them there yourself, however, because I will
        be wanting to use pre-compiler commends to be able to skip past them
        when run on a UNIX machine.

NNWHERE - Now that you have played with the general simulator a bit, you
        are ready to look at some specific applications.  This implements
        a net based on part of a model described in a paper that is cited 
        in the introductory comments of the source code.  It is basically
        part of a 2-test project, where there is a 5x5 retina presented with
        shapes in different positions, and the NNWHERE half of it has to
        learn to classify the position of different objects (thus learn a
        classification independant of shape of the pattern).  This it 
        learns quite easily, and will run quite well.

NNWHAT - This half of the experiment is more complex.  This is designed to
        learn which shape is being presented, independant of _position_.
        Computationally, this is a much more difficult task, and needs a
        hidden layer with many units.
         However, as you will read in bugs.doc, there are problems with the
        size of the structure running under Borland under DOS.  Compile it
        under UNIX and it runs with no problem.  If you find out how to get 
        this to go on a DOS machine, please tell me.

NNEVOLVE - Finally (for the feed-forward, back-propagation supervised nets)
          this last thing is a slight hand-tweaking for an experiment I did
          to show representation independance in distributed systems.  My
          idea for the experiment is all documented in nnevolve.doc, and
          the output of my run of the experiment are in gens1.zip.  All you
          need to do to reproduce my experiment is run evolve.bat.  You can
          figure out what it's doing from the documentation and code yourself.

NOTE: All of the previous have been supervised learning implementations using
      back-propagation.  They all #include nnbkprop.c, and they all need
      the files nninputs.dat as the input training patterns and nnoutput.dat
      as the "what the answers should be" patterns.  There are two other
      kinds of error-correction with neural networks: unsupervised and
      reward-based learning.  Reward learning is not covered here, because it
      is similar to Hebbian learning in conception, but there are so many 
      methods for calculating reward, and so many difficulties with dealing
      with delayed reward, that it is beyond the scope of this library.

      The following file is an example of the routines for feed-foreward,
      UNsupervised learning (with Hebbian learning algorithm).  To use just
      standard Hebbian learning, include "nnhebbln.c" in your main file.
      To use competative learning, include "nncompet.c" instead.

      ** I plan on writing more implementations for unsupervised nets, and
      will distribute updates.  However, if you are feeling inventive and
      want to write a neat variation/implementation, send it to me and I
      will include it with a new release, with all of your credit info. **

NNSIM2 - This is a general simulation of a competative learning network with 
      a hebbian learning algorithm.  To change this to a Hebbian learning
      algorithm (not winner-take-all competative learning), simply comment
      out the call to the function AllOrNoneLayerActs().  To change it
      permanently in a program, simply  delete that line, and change the
      include file from nncompet.c to nnhebbln.c.
       I'm not sure, but I think this simulation has some bugs, which may
      be in nncompet.c, nnhebbln.c, or the main nnsim2.c itself.  See
      BUGS.DOC for more information.

NOTE: All of the previous networks have been feed foreward networks.  They
      all follow the same basic format in the main body of the program. 
      However, there is another kind of net: recurrent networks.

      The following file is a basic little recurrent network that learns an
      internal representation in the hidden units of a sequence of numbers.
      It has one input, and one output, designed to work with back-propagation
      self-correlating (output node equals input node) and a number of context
      units equal to the size of the hidden layer.  It displays the hidden
      layer so you can see the pattern it learns.

NNRECUR1 - This is an example of a recurrent net with back-propagation
      (a kind of supervised learning called Self-Correlating, where the
      input patterns serve as their own output patterns).  It goes through
      all possible three-bit patterns, and feeds them in one-by-one, and
      the hidden layer learns a representation of the entire strings through
      time.  Values of patterns are 1.0 or 0.0, empty values (before beginning
      and afte ending of patterns) is 0.5.  It takes a while.

-------------------------------------------------------------------------------
That's it for now.  Keep in touch.

greg

stevens@prodigal.psych.rochester.edu
