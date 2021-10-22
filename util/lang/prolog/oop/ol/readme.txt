
OL(P): Object Layer for Prolog -- README
Version 1.1 for SICStus Prolog and QUINTUS Prolog

  Copyright (c) 1993 Markus P.J. Fromherz.  All Rights Reserved.
  Copyright (c) 1993 Xerox Corporation.  All Rights Reserved.

  Use, reproduction, preparation of derivative works, and distribution
  of this software is permitted, but only for non-commercial research or
  educational purposes. Any copy of this software or of any derivative
  work must include both the above copyright notices of Markus P.J.
  Fromherz and Xerox Corporation and this paragraph.  Any distribution
  of this software or derivative works must comply with all applicable
  United States export control laws. This software is made available AS
  IS, and XEROX CORPORATION DISCLAIMS ALL WARRANTIES, EXPRESS OR
  IMPLIED, INCLUDING WITHOUT LIMITATION THE IMPLIED WARRANTIES OF
  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, AND
  NOTWITHSTANDING ANY OTHER PROVISION CONTAINED HEREIN, ANY LIABILITY
  FOR DAMAGES RESULTING FROM THE SOFTWARE OR ITS USE IS EXPRESSLY
  DISCLAIMED, WHETHER ARISING IN CONTRACT, TORT (INCLUDING NEGLIGENCE)
  OR STRICT LIABILITY, EVEN IF XEROX CORPORATION IS ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGES.

  This copyright notice applies to all Object Layer software in this
  release (sources, libraries, demos, and documentation).

Author: Markus P.J. Fromherz

Please send comments and bug reports to <fromherz@parc.xerox.com>.
Please note that I will try to help, but can't guarantee anything.


Table of contents of this file:

   1. Installation of the OL(P) System
   2. First Use
   3. Base Language Configuration
   4. Dictories and Files


1. Installation of the OL(P) System
-----------------------------------

OL(P) has been prepared for both SICStus Prolog and QUINTUS Prolog on
a UNIX system. OL(P) can be used for other Prolog systems and on other
platforms, but some changes may be necessary.

It is assumed that you get OL(P) in a compressed tar file `ol.tar.Z'.

a. Create a directory where you want to install OL(P), move the tar file
   there, cd there, and uncompress and extract the file's contents:
      mkdir /import/prolog/ol          % for example
      mv ol.tar.Z /import/prolog/ol
      cd /import/prolog/ol
      uncompress ol.tar
      tar xf ol.tar

b. In the file `Makefile' in the OL(P) directory, change the settings
   of the the following variables:
   - for all Prolog versions:
       OL        path to the OL(P) directory
       OLBIN     path and name of executable file
   - for your Prolog version (SICStus 0.6, SICStus 2.1, Quintus):
       PROLOG    path to your Prolog
       PROLOPTS  compile flag (SICStus Prolog: `prolog_flag/3'
                 for `compiling')
       further flags: make sure the section for your Prolog version
                      is not in comments (`#'), while the other two are

   For QUINTUS Prolog users:
   In the file `src/ol_resource.rc', look for the fact `ol_prolog'.
   Make the appropriate change for your Prolog version (take its line
   out of comment, put the other into comment).

   Then, to build the OL(P) system, type (in the OL(P) directory):
      make all
   (This compiles all source files and creates a saved state `ol' in the `bin/'
   directory. This also compiles the libraries and demo programs.)

c. Remove the tar file and - depending on your import or library package
   organization - setup a link from your `bin/' directory to the executable
   binary `ol':
      rm ol.tar
      ln -s /import/prolog/ol/bin/ol ~/bin/ol          % for example

d. The file `User-Manual' in doc/ explains how to use the OL(P) system.
   If you want to reinstall OL(P) (e.g., after you made changes to the resource
   file; see below), simply `make ol' in the OL(P) directory.
   If you want to remove all files created by the installation (i.e. return to
   the state right after the extraction from the tar file), `make clean' in the
   OL(P) directory.


2. First Use
------------

Note that the library `gmlib' is not available for QUINTUS Prolog, and
that the following example will not run for QUINTUS Prolog. Try the
examples in the `User-Manual' instead.

The following is a sample use of a demo program. You will run it, then
change it, compile, reload it, and run it again. This is for people
who don't want to read the documentation first, but instead want to
get a feeling for the use of the OL(P) system. See the `User-Manual'
for more information. The installation steps above have to be
completed. (If you don't have the GM library installed, you can use
the `manual_pro' examples instead: start OL(P), switch to
`manual_pro', and consult it as shown below, then try the sample
queries. See also the `User-Manual'.)

In a shell, change directory to OL(P)'s demo/ directory. Then type
after the prompts (the text in between is omitted):

   % ../bin/ol
   | ?- project::switch(sort_pro).
   | ?- project::do(consult(_)).
   | ?- sort_interface::start.

 (The first command starts Prolog together with OL(P). The second command
 sends a message to `project' to load the project data of `sort_pro'. Then,
 its file and the libraries are consulted. Finally, the start message is
 sent to object `sort_interface'. Method `help' in object `project' gives
 you more information about these methods.)

Play with buttons and slider in the upcoming dialog window. Note how
when you press `Sort', a message is displayed in the shell window.
Finish by pressing `Quit'.
Open file demo/sort_interface.pl.ol, search for method `handle_event/5'
and there for the last-but-one clause. This clause is in comments;
remove the `%' in front of this clause and save the file.  Back in the
(Prolog) shell, type after the prompts:

   | ?- project::(compile, do(consult)).
   | ?- sort_interface::start.

 (This compiles and consults the project's file, and starts the interface
 again.)

Add some numbers and see how this time the `Sort' button works.


3. Base Language Configuration
------------------------------

OL(P) can be used for Prolog and Prolog variants. The inclusive
condition is that - within an object - clauses in the base language
are translated to clauses with bodies separated from the head by `:-'.
Furthermore, any argument expansion has to be done before handing the
clause to the OL(P) compiler. Terms outside of objects are copied
without change. The notation should not conflict with that of OL(P).
Further compilation after that of OL(P) is also possible.
   Typically, these can be languages that are expanded to Prolog,
e.g., a language that allows functional expressions, arrays or
attribute-value lists, concurrency, or constraint satisfaction.

OL(P) compiles the body of a clause by expanding object-oriented goals
`Object::Message'. What constitutes a goal in a particular language
can be defined in the resource file `ol_resource.rc'. The resource
file defines a fact

   ol_prolog(Prolog).

facts

   ol_read(BaseLanguage, InStream, PrologTerm, Init, ReadGoal)

and a number of facts

   ol_meta_predicate(Prolog, BaseLanguage, MetaPredicate).

(see there).

   `Prolog' denotes the current Prolog system and is set to
`sicstusProlog' in `ol_prolog/1'. Make the appropriate change. For
common meta-predicates (such as `,/2', `call/1' etc.), `Prolog' can be
anonymous in `ol_meta_predicate/3'.
   `BaseLanguage' is the suffix for the base language (e.g., `pl' for
Prolog).  Again, for common meta-predicates (such as `,/2', `call/1'
etc.), it can be anonymous.
   `MetaPredicate' is the specification of a meta-predicate that
contains goals.
   Other arguments are explained in the resource file.

The specification `ol_meta_predicate/3' defines for each of the
arguments whether it holds a goal or not. Goals are denoted by `::',
other terms by `-'. For example, the specification `(::,::)' says that
both arguments of the conjunction are goals, while the specification
`findall(-,::,-)' says that the second argument of `findall/3' is a
goal.

This specification extends to messages. Using the same specification,
`O::(A,B)' is interpreted as `O::A, O::B', `::findall(X,M,L)' as
`findall(X,::M,L)', `O::findall(X,(a(X);b(X)),L)' as
`findall(X,(O::a(X);O::b(X)),L)' etc.

OL(P) determines the base language of a file's objects by the file's
suffix.  Thus, if the OL(P) file is called `File.pl.ol', the
meta-predicate specifications for `pl' are used, and a file `File.pl'
is produced on compilation.

If you change the resource file, make a new OL(P) system (`make ol' as
in the Installation).


4. Dictories and Files
----------------------

README
      This file.

Release-Notes
      Information on how to get OL(P), and on recent changes.

Makefile
      The make file for setting up the OL(P) system in the current
      directory. See Installation.

quintus.ini, sicstus0.6.ini
      Files needed for QUINTUS Prolog and for SICStus Prolog 0.6
      installation.

src/
      The directory containing the source files for the OL(P) system,
      and a make file `Makefile' used by the above `Makefile'. Note
      that all files needed for a run-time version of OL(P) have a
      name starting with `ol_'.

bin/
      The directory containing `ol' (a saved Prolog state with the
      loaded OL(P) system), and `ol.pl' (a Prolog file that loads the
      OL(P) system when consulted). See Installation.

lib/
      The directory containing some libraries for lists, integers,
      meta-programming, and an user interface framework.

doc/
      The directory containing the documentation for the OL(P) system.
      The file `User-Manual' explains OL(P) constructs and the use of
      the OL(P) system. The file `Reference-Manual' documents the
      system objects.

demo/

      The directory containing demo programs, including project
      `manual_pro' (programs from the User-Manual), library
      `listener_lib' (simple tracing meta-interpreter), and a sample
      use of the user interface framework (`sort_pro'). Note that
      the latter needed library gmlib.
