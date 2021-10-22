 /usr/outrageous/jbennett/ai/build/README, Fri Feb 19 15:17:43 1988, Edit by jbennett

This is a Common Lisp version of Scott Falhman's Build, a blocks-world
planner.  It is described in Fahlman, S.E., "A Planning System for Robot
Construction Tasks", Artifical Intelligence, 5(1974) 1-49.  It was converted
from CONNIVER to Common Lisp by John Nagle (jbn@glacier.stanford.edu); see his
notes at the end of this file.

The Build planner operates under Kyoto Common Lisp (see note below), Ibuki
Common Lisp, and Lucid Common Lisp on Sun workstations.

Build is normally distributed via FTP as a single compressed tar file.  The
Makefile will pack/unpack the system from the tar file and will compile the
Build system itself.

To build Build, create a subdirectory to contain the system.  Use 'make unpack'
to uncompress and extract the files from the FTP'd tar file, and 'make build' to
compile the system:

%mkdir build
%cd build
%# copy the files from wherever they are stored
%cp Makefile build.tar.Z .
%make unpack
%make build

The Makefile assumes that KCL (Kyoto Common Lisp) is available for
compilation.  It takes about 20 minutes on a Sun 3/280 to compile all the
files under KCL.  You can change the LISP image used to compile the system by
issuing the make command:

%make build LISP=/usr/local/bin/mylisp

A NOTE ON KCL:

Some versions of KCL do not correctly implement "equal" for arrays.  KCL must
be fixed before Build will operate correctly.  To test for this problem, run
KCL and execute the following expression; it should return T. If it returns
NIL you have the bug.

(let ((aa (make-array 1))(ab (make-array 1))) (equal aa ab))

     If you have the KCL sources, the bug is in the function "equalp" in
"predicate.c"; the test for equality of array rank is incorrect.  The code
fragement in question should read:

	case t_array:
		if (ty == t_array && x->a.a_rank = y->a.a_rank)
			goto ARRAY;
		else
			return(FALSE);


To run Build:

;; To run Build, start KCL and type (load "build.lsp"), which loads the
;; planner and a number of support routines.

%kcl

>(load "build.lsp")
Loading build.lsp
Loading database.o
Finished loading database.o
Loading builddefs.o
Finished loading builddefs.o
Loading vector.o
Finished loading vector.o
Loading buildutil.o
Finished loading buildutil.o
Loading build5.o
Finished loading build5.o
Loading build6.o
Finished loading build6.o
Loading build3.o
Finished loading build3.o
Loading build4.o
Finished loading build4.o
Loading build7.o
Finished loading build7.o
Loading build8.o
Finished loading build8.o
Loading buildshapes.o
Finished loading buildshapes.o
Loading plandefs.o
Finished loading plandefs.o
Loading plan1.o
Finished loading plan1.o
Loading plan2.o
Finished loading plan2.o
Loading plan3.lsp
Finished loading plan3.lsp
Loading plan4.lsp
Finished loading plan4.lsp
Loading plan5.lsp
Finished loading plan5.lsp
Loading planutil.o
Finished loading planutil.o
Loading uplot.o
Finished loading uplot.o
Loading dummies.lsp
Loading robottest.lsp
Loading robotio.o
Finished loading robotio.o
Loading amlparse.o
Finished loading amlparse.o
Finished loading robottest.lsp
Finished loading dummies.lsp
Loading drawtools.o
Finished loading drawtools.o
Loading printplan.o
Finished loading printplan.o
Loading robotio.o
Finished loading robotio.o
Loading amlparse.o
Finished loading amlparse.o
Finished loading build.lsp
T
>

;; To test Build, (load "unitblocks.lsp"), which defines several "contexts"--an
;; initial state named binitial, and three goals states named bgoal1, bgoal2,
;; and bgoal3.

>(load "unitblocks.lsp")
Loading unitblocks.lsp
Finished loading unitblocks.lsp
T
>

;; To have the system create a plan, call the function dobuild with the
;; initial state and the goal state.  The result is the plan, if any.
;; The following example simply stacks 3 blocks.

>(setq plan (dobuild binitial bgoal1))
-> Beginning work on goal: Build (<context 5>).
-> Build: trying to place (<B1>
                        <B2>
                        <B3>).
--> Beginning work on goal: PLACE (<B1>
                               <context 5>).
---> Beginning work on goal: MOVE (<B1>
                              (loc 900.0000 50.0000 34.9250)
                              (loc 200.0000 200.0000 34.9250)).
---> Achieved goal: MOVE (<B1>
                     (loc 900.0000 50.0000 34.9250)
                     (loc 200.0000 200.0000 34.9250)).
--> Achieved goal: PLACE (<B1>
                      <context 5>).
-> Build: trying to place (<B2>
                        <B3>).
--> Beginning work on goal: PLACE (<B2>
                               <context 5>).
---> Beginning work on goal: MOVE (<B2>
                              (loc 900.0000 150.0000 34.9250)
                              (loc 200.0000 200.0000 104.7750)).
---> Achieved goal: MOVE (<B2>
                     (loc 900.0000 150.0000 34.9250)
                     (loc 200.0000 200.0000 104.7750)).
--> Achieved goal: PLACE (<B2>
                      <context 5>).
-> Build: trying to place (<B3>).
--> Beginning work on goal: PLACE (<B3>
                               <context 5>).
---> Beginning work on goal: MOVE (<B3>
                              (loc 900.0000 250.0000 34.9250)
                              (loc 200.0000 200.0000 174.6250)).
---> Achieved goal: MOVE (<B3>
                     (loc 900.0000 250.0000 34.9250)
                     (loc 200.0000 200.0000 174.6250)).
--> Achieved goal: PLACE (<B3>
                      <context 5>).
-> Build: trying to place NIL.
-> Achieved goal: Build (<context 5>).
((<context 7>
  <context 7> (NOP)
  ((Build <context 5>) ("Because you told me to.")))
 (<context 7>
  <context 9>
  (MOVE <B1>
        (loc 900.0000 50.0000 34.9250)
        (loc 200.0000 200.0000 34.9250))
  ((MOVE <B1>
         (loc 900.0000 50.0000 34.9250)
         (loc 200.0000 200.0000 34.9250))
   (PLACE <B1>
          <context 5>)
   (Build <context 5>) ("Because you told me to.")))
 (<context 9>
  <context 10>
  (MOVE <B2>
        (loc 900.0000 150.0000 34.9250)
        (loc 200.0000 200.0000 104.7750))
  ((MOVE <B2>
         (loc 900.0000 150.0000 34.9250)
         (loc 200.0000 200.0000 104.7750))
   (PLACE <B2>
          <context 5>)
   (Build <context 5>) ("Because you told me to.")))
 (<context 10>
  <context 11>
  (MOVE <B3>
        (loc 900.0000 250.0000 34.9250)
        (loc 200.0000 200.0000 174.6250))
  ((MOVE <B3>
         (loc 900.0000 250.0000 34.9250)
         (loc 200.0000 200.0000 174.6250))
   (PLACE <B3>
          <context 5>)
   (Build <context 5>) ("Because you told me to."))))

>

;; The variable plan now contains the plan datastructure.
;; You can review the final plan on the screen using 
;; the function printplan:

>(printplan plan)
Action: (MOVE <B1>
              (loc 900.0000 50.0000 34.9250)
              (loc 200.0000 200.0000 34.9250)) 
        [because (PLACE <B1>
                        <context 5>)]
Action: (MOVE <B2>
              (loc 900.0000 150.0000 34.9250)
              (loc 200.0000 200.0000 104.7750)) 
        [because (PLACE <B2>
                        <context 5>)]
Action: (MOVE <B3>
              (loc 900.0000 250.0000 34.9250)
              (loc 200.0000 200.0000 174.6250)) 
        [because (PLACE <B3>
                        <context 5>)]
NIL
>


VIEWING PLANS ON SUN WORKSTATIONS:

On a Sun, you can graphically review the steps of a plan using the Tek4014
emulation system.  To do this, perform the following:

1. In the Build image, run the function

>(plot "plotfile")

This creates a file that will be used to communicate between the Build image
and the Tek4014 emulation window described below.

2. From a shell, start tektool in background.  

%tektool &

This builds a full screen window running the Tek4014 emulator.  

3. Resize the window so you can get to the other windows.  Note that the
Tek4014 window should take the full length of the screen but need only take
about 5/8ths of its width.

4. In the Tek4014 window, connect to the build directory and type

%cd build
%setenv TERM tek
%tail -f plotfile | plot

5. Finally, back in the Build image, run the function

>(showplan plan)

Follow its instructions.


You can show a particular configuration ("context") using tektool and the show
function.  Under the Tek4014 setup, perform the following:

>(setq context binitial)
>(show)

Sometimes the plotfile gets out-of-synch or locks up.  If this happens, in the
Tek4014 window, type

%cp /dev/null plotfile
%tail -f plotfile | plot

to restart.


SOME NOTES FROM JOHN NAGLE ON THE BUILD SYSTEM:

Return-Path: <jbn@glacier.stanford.edu>
Date: Thu, 10 Mar 88 10:10:06 PST
From: John B. Nagle <jbn@glacier.stanford.edu>
Subject: Re: notes on a Build release
To: jbennett@coherent.com, jbn@glacier.stanford.edu

Some notes on Build:

     Build represents a major milestone in solid geometric modelling.  Build
was developed in 1972, and may be the first solid geometric modeller.  Inside
are the basic primitives of a solid modeller for arbitrary convex polyhedra.
Fahlman only used these primitives on "bricks" and "wedges", but the
generality was implicitly there, and I have provided some additional 
capabilities that make it possible to describe more general polyhedra.

     As a planner, Build contains little that is novel.  It is a classical
recursive-descent planner, and exhibits the singlemindedness typical of
such planners.  When Build is running a robot, incidentally, this is
painfully obvious.  However, it would actually not be all that hard to
make its moves more optimal.  The notion that the system is always working
to reduce the differences between the current state and the goal state
appears at various places in the code, but is not fully exploited.
The griping mechanism, which is an important innovation, allows the goal,
rather than the subgoal, to determine when to abandon subgoaling.  This
potentially gives the goal strategic control, enough control to reduce the
single-mindedness of the system.  But this potential capability was not
used extensively in the system.

     One particularly useful property of the griping mechanism is that
gripes can arise from the solid modelling system, as a result of detected
collisions or instabilities.  Thus, the modeller has a well-defined way
of communicating with the planner.  It is important to note that this
mechanism is not limited to reporting failure.

     The stability test is interesting.  The code provided will solve all
the cases in Fahlman's paper correctly.  But it is not, in general,
guaranteed to produce a correct solution, or even to converge.  The
general problem of determining whether a collection of blocks will
fall down is quite difficult.   Classic static analysis is not sufficient.
There are cases where static indeterminacy rules the stability problem.
Incremental dynamics may provide a general solution.  But a more practical
approach may combine rules with simple static analysis to allow the design
of conservative structures.  

     Build remains a landmark in the history of attempts to plan in the
physical world.  A predicate-based planner able to draw on a geometric model of
the physical world has powers beyond that of a planner trapped in a world of
ungrounded abstractions.  Designers of future planners should not forget this.

					John Nagle
					March, 1988
					Menlo Park, California



SOME NOTES ON THE FILES:

The files build*.lsp are the solid-modelling portions of the system;
database.lsp implements a CONNIVER-type database.  

The files plan*.lsp are planning system of Build.  Some files here must run in
interpreted mode; see the Makefile to determine which files may be compiled.
Also, only the files in this list actually loaded in build.lsp are used.  The
counterweight and prop tricks described in Fahlman's paper were never
converted and used, because they didn't really cope with the problems of
actually moving the counterweight and prop blocks.  (Fahlman's code basically
assumes that blocks dematerialize in one place and reappear in another.)

The files robot*.lsp and amlparse.lsp is part of the interface to the IBM RS-1
robot; unitblocks.lsp contains useful test cases; uplot.lsp contains the
Tektronix graphic interface; vector.lsp is a general purpose vector arithmetic
package; drawtools.lsp contains user interface functions; dummies.lsp contains
some dummy routines for parts of the system not implemented.

The files grasp.lsp, gripper.lsp, kinematics.lsp, and orient.lsp are part of a
grasp planner that Nagle was writing.  This system is not integrated with the
rest of Build, but uses the solid modelling primitives of the build*.lsp
portion of the system.  The file path.lsp contains the beginnings of a path
planner by Nagle.

COMMENTS ON THE BUILD CODE BY J. NAGLE:

     Fahlman's original paper provides a good overview of the system, and is
generally accurate as to its actual capabilities.  My conversion effort began
with a paper copy of the system as of 1972 provided by Fahlman, who is
presently at CMU.  The version here is much modified from that version.  (NB:
Fahlman's literal text, entered by a data entry operator, is available on
request; please contact jbennett@coherent.com.)

     In general, the code in the build*.lsp and plan*.lsp files follows
Fahlman's original code.  The code has been converted to Common Lisp, both in
form and style, and comments have been added, but the logic follows Fahlman.
As it turned out, very few of the features of CONNIVER (a dialect of LISP in
use at MIT in the early 1970s) were actually essential to the program logic.
All non-essential CONNIVER constructs were removed, rather than simulated.
The CONNIVER database was implemented (see database.lsp) and operates much as
in the original CONNIVER environment.

     The logic of "griping" is significantly different than in Falhman's
original version.  CONNIVER offered a somewhat painful multi-tasking
facility, and griping was originally implemented using that facility.
In this version, griping is implemented by using lexical escapes from
closures.  Look for references to the "gripehandler" macro.  Gripe
handlers use "return-from" and "go" to escape from gripe handlers into
an enclosing lexical scope.  A gripe handler is in the lexical scope of
the goal and the dynamic scope of the subgoal, and thus can escape from
a subgoal to retry a higher level goal by escaping to an outer lexical 
context.

     The above is probably the only part of the system which is confusing
in the sense of relying on subtle features of Lisp.  Everything else is
rather straightforward Common Lisp.

     The software contains code to interface an IBM RS-1 robot to 
move the blocks under control of the planner.  Converting this code
to support other cartesian or SCARA robots should not be difficult.
The present code does assume straight-down reach from above, and the
present grasp planning is very crude.  Pieces of a more advanced
grasp planning system are included, and the pieces work, but are not 
integrated into the building system.



