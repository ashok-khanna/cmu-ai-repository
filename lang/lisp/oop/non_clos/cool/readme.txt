	    Revised Instructions for Installing and Using 
		CommonObjects on CommonLoops
			(COOL)

I) INTRODUCTION

COOL is an implementation of HP's CommonObjects on
the Portable CommonLoops (PCL) metaclass kernel.
As such, it provides a portable implementation of
CommonObjects. It should be of particular interest
to people who want to program in the mixin style
supported by PCL but are also interested in trying
the encapsulation style of Smalltalk, which CommonObjects
supports.

This version of COOL is guaranteed to work with Portable
CommonLoops system date 2-24-87. A copy of this version
of Portable CommonLoops is distributed along with COOL.

COOL comes as a set of files grouped into four groups:

  1) Documentation

     README-this file

     semantics.asci-Description of semantic differences
       between the CommonObjects specification in the
       document ATC-85-01, "Object Oriented Programming
       for Common Lisp," by Alan Snyder.

  2) The System
     co-defsys.l
     pcl-patches.l
     co-parse.l
     co-dtype.l
     co-meta.l
     co-dmeth.l
     co-sfun.l

  3) Test and Profiling files

     co-test.l-A generalized version of the PCL test macro.
     co-regress.l-Some simple regression tests for COOL.
     co-profmacs.l-Macros for simplifying profiling.
     co-prof.l-Profiling tests.

  4) Portable CommonLoops (system date 2-24-87)
     The file <xxx>-low.l corresponds to the machine-dependent
     file for your system. For HP Lisp, this will be hp-low.l.

     walk.l
     macros.l
     low.l
     <xxx>-low.l
     braid.l
     class-slots.l
     defclass.l
     class-prot.l
     methods.l
     dfun-templ.l
     fixup.l
     high.l
     compat.l

If you are on a Un*x system, the COOL files will be in the
directory co/ and the PCL files will be in the directory pcl/.

If you have never programmed using CommonObjects, it is
suggested you request a paper copy of ATC-85-01, "Object
Oriented Programming for Common Lisp," by Alan Snyder;
which is a specification of the CommonObjects language.
It can be obtained by sending electronic mail with your
name and address to mingus@hplabs.hp.com. If you are anxious
to get started and don't want to wait for the specification,
look at some of the test examples in co-regress.l for
an idea of how to use CommonObjects.

II) BRINGING UP PORTABLE COMMONLOOPS
Directions are given in the file defsys.l
Briefly, one edits the variables *pcl-pathname-defaults* (which
gives the location of the PCL files on your system). After that 
the PCL files can be compiled by invoking:

   (require "defsys")
   (pcl::compile-pcl)

and loaded by invoking:

   (pcl::load-pcl)

III) BRINGING UP COOL

Cool uses the PCL defsystem. Directions are given in the file
co-defsys.l . Briefly, in file co-defsys.l, one sets the variable
*co-pathname-defaults* to correspond to the location of the files
on your local system. After that, the COOL files may be compiled by invoking:

   (require "co-defsys")
   (co:compile-co)

and loaded by invoking:

   (co:load-co)

In addition, the file pcl-patches.l contains a patch for
the PCL function CLASS-OF. This function is specialized
for each implementation of Common Lisp, but, in the
released version, it does not check if the type specifier
returned by TYPE-OF is list. You will need to modify
the SETQ of *CLASS-OF* in your implementation xxx-low.l
file so that the function PCL::ATOM-TYPE-OF is called
on (TYPE-OF X) instead of simply TYPE-OF. To see how this was
done for HP Lisp, look at the top of pcl-patches.l
Remember to put the form:

(eval-when (load eval)
  (recompile-class-of)

)

in your file after you have rebound *CLASS-OF*; otherwise,
the new definition will not take effect.

III) COMPILATION

You will probably want to compile COOL before using it,
unless your system doesn't have a compiler. There
are only three files in the COOL system itself. If
you have set up your pathnames for REQUIRE correctly,
then the following script should compile COOL:

   (require "co-defsys")
   (co:compile-co)

You may want to turn on optimizations before compiling.
Before doing this, it is suggested that you try the
regression tests without any optimizations, in case
your optimizer does something which might cause the
system to break (like not checking for NIL during
a CAR or CDR operation). For profiling, however, it
is best to put as much optimization on as you think
can safely be done.

IV) LOADING

To load the system, do the following:
 (require "co-defsys")
 (co:load-co)

V) USE

There are two steps needed to use the CommonObjects
object oriented language extensions within your
Common Lisp. 

First, in the package where you plan to use
CommonObjects, you need to get access to the CommonObjects
functions and macros. Do that by using the USE-PACKAGE
form:

(in-package <your package>)
(use-package 'co)

You will now have access to CommonObjects. Note to
users on HP Lisp: it is not possible to use both
COOL and the system dependent CommonObjects implementation
in the same package, since a symbol conflict occurs
upon import of the CommonObjects symbols.

It is suggested that you avoid trying to use both
PCL and COOL in the same package. It MAY work,
however, it has not been tried and is therefore
untested. As a matter of good software engineering,
it also seems best to try to segment applications
which use both objects in different packages.

Second, there are a number of Common Lisp functions which
CommonObjects semantics modify. These are EQL, EQUAL, EQUALP,
TYPE-OF, and TYPEP. For more information on exactly what
these modifications are, see ATC-85-01. Because redefining
the default Lisp functions could be potentially very 
dangerous or cause serious performance degradation, a 
special macro has been constructed which SHADOWING-IMPORTs
the redefined functions into a package using CO, without
redefining the Common Lisp functions throughout the entire
system. To get access to these functions, the macro
IMPORT-SPECIALIZED-FUNCTIONS needs to be invoked after the
CO package is used:

	(import-specialized-functions)

The Common Lisp functions will now locally reflect the
CommonObjects semantics, but the global definitions
are still available by using full package qualification
of the names.

Here is a short description of the available CommonObjects
operations exported from CO. For a more detailed description,
see ATC-85-01.

(define-type <type name> <options>)		

Define a CommonObjects type whose name is <type name>. There
are a whole host of options, including instance variable
(slot) definition and inheritence. Macro.

(define-method (<type name> <method name>) (<arguments>)  
    <body>
)

Define a CommonObjects method named <method name> on <type name>.
<method name> will typically be a keyword but need not be. Macro.

(call-method (<parent type name> <parent method name>) <arguments>) 
(call-method <method name> arguments)

(apply-method (<parent type name> <parent method name>) &rest <arguments>)
(apply-method <method name> &rest arguments)

Used to invoke a parent method or a method on SELF. The difference 
from sending to SELF directly is that the method to call is
determined at compile time. The CALL-METHOD form is like FUNCALL,
APPLY-METHOD like APPLY. These forms are only valid within the
body of a DEFINE-METHOD. Macros.

(make-instance <type name> <initialization keyword list>)

Make an instance of CommonObjects type <type name> The
<initialization keyword list> is used to initialize
instance variables and for other initialization purposes.
PCL method.

(=> <instance> <method name> <arguments>)

Invoke operation <method name> on <instance> with <arguments>.
This invocation operator makes no checks for errors and
operates at full PCL messaging speed. Note that all arguments
will be evaluated. Macro.

(send? <instance> <method name> <arguments>)

Invoke operation <method name> on <instance> with <arguments>,
checking to be sure <instance> is a valid CommonObjects
instance and that it supports <method name> as an operation.
Returns NIL if the operation cannot be invoked. This
invocation operator is slow but safe. Note that all arguments
will be evaluated. Macro.

(instancep <arg>)

Returns T if <arg> is a CommonObjects instance, NIL if
not. Function.

(supports-operation-p <arg> <method name>)

Returns T if <arg> supports operation <method name>,
NIL if not. Function.

(assignedp <instance variable name>)

Returns T if <instance variable name> has been assigned
a value, NIL if not. Valid only within a DEFINE-METHOD
body. Macro.

(undefine-type <type name>)

Undefine the CommonObjects type <type name>. Returns T
if the type was undefined, NIL if not. Signals an error
if the argument is not a symbol. Function.

(rename-type <old type name> <new type name>)

Rename <old type name> to <new type name>. Returns T
if the type was renamed. Signals an error if old
type is not defined, if new type already exists,
or if the arguments are not symbols. Function.

(undefine-method <type name> <method name>)

Undefine the method <method name> on <type name>.
Signals an error if <type name> is not a symbol or
if there is no type named <type name>. Issues a
warning message if <method name> is a universal
method and the type has the default universal
methods. Returns T if the operation was successful,
NIL if not. Function.


VI) REGRESSION TESTS

The file co-regress.l contains a series of regression
tests which test out important features of COOL.
Some of these regression tests cause errors to be
signalled, but, in order to have the tests complete
successfully, the errors must be ignored. Since there
is no portable way defined in CLtL to modify error
handling (short of redefining the CL function ERROR)
most system implementors have added extensions to
do the job.

If you don't know what the extensions are on your
system, or don't want to be bothered about trying
to find out, skip this paragraph and go on to
the next, but first a warning: the tests requiring
error handling will be skipped, but the result
may be that some implementation dependent problem
is missed. If you know what the extensions are,
then edit the file co-test.l. Go to the top
of the file and look for the special variable
*WITHOUT-ERRORS*. This variable should contain
a function which generates the test with an error
catcher in place around the code. Add
#+<implementation name> to the list, and a LAMBDA
definition to return the proper test code with
error catching. Note that the code should return T
if an error occurs, and NIL if not, for the
test macro to work correctly. When you are done,
mail that portion of the file with your system
dependent code to cool@hplabs.hp.com.

To run the regression tests, simply REQUIRE the
file co-regress.l:

	(require "co-regress")

The test results will be printed to the standard
output.

Note that the regression tests make no checks
for compilation, since the compilation semantics
of PCL (upon which COOL is based) are very weakly
defined. File compilation should work, however.

VII) PROFILING

If you're really feeling ambitious, you may even
want to run the profiling tests to see how well
your COOL is performing. 

Again, there are some implementation dependencies 
which should be addressed before running the profiling
tests. Probably the most important is that the name
of the implementation's garbage collector be known.
If this is NOT done, then you run the risk of having
a garbage collect occur in the middle of the profiling,
which will destroy your measurements. If your system
has a large enough virtual image, however, garbage
collection may not be a problem.

Edit the file co-profmacs.l and look at the top below
the header. The function cell of the symbol
DO-GARBAGE-COLLECT should be set to the function
for your implementation's garbage collector. Be
sure to put a #+<implementation name> before any
implementation dependent code you may add. The default
for garbage collection is to simply warn the user
that the measurements may be in error because
the test can't garbage collect.

You may also want to add any implementation dependent
code for getting clock values. The default is the
Common Lisp function GET-INTERNAL-REAL-TIME, and
the clock increment in milliseconds (in the
special variable *CLOCK-INCREMENT-IN-MILLISECONDS*)
is calculated using the Common Lisp special
INTERNAL-TIME-UNITS-PER-SECOND. However, many
implementations may have special ways of getting 
clock values, and these should be added here.

Please send any implementation dependent changes
to cool@hplabs.hp.com.

The results of the profiling tests are put into
a file whose name (as a string) is bound to the
special variable TEST::*OUTPUT-FILE-NAME*. The
default string is "runprof.out", as can be
seen by checking the special variable definition
for *OUTPUT-FILE-NAME* at the top of co-prof.l.
If you want the results in another file, please
SETF this variable to the file name before
starting the profiling:

	(in-package 'test)
	(setf *output-file-name* <your file name>)

To run the profiling tests, just:

	(require "co-prof")

and, providing you've set up your REQUIRE pathnames
correctly, you should find it.

Note that profiling may take quite a while, and
it is a good idea to have as little else going on
on your machine as possible during the tests.

If you feel you want to distribute the profile
information, you may want to send it to 
cool@hplabs.hp.com with a brief description of
your system. It might help identify particular
implementation dependencies which are causing
performance problems.

VIII) CONCLUSION

If you have problems with COOL or find any bugs,
please report them to cool@hplabs.hp.com. It
is most helpful if the bug can be as isolated
as possible (e.g. "It broke when I defined
type xxx" is less easy to trace down than
a backtrace listing where it broke). It may
be difficult to track all implementations of
Common Lisp, but an effort will be made to
keep COOL running as long as people are
interested.

