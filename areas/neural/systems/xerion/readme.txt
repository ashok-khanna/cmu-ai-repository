######################################################################
# $Id: README,v 1.4 93/02/10 11:23:26 drew Exp $
######################################################################

######################################################################
#     Copyright 1990, 1991, 1992, 1993 by University of Toronto,
#		      Toronto, Ontario, Canada.
# 
#			 All Rights Reserved
# 
# Permission to use, copy, modify,  distribute, and sell this software
# and its documentation for any purpose is hereby granted without fee,
# provided that the above copyright  notice appears  in all copies and
# that both the copyright notice and this  permission notice appear in
# supporting documentation, and that the name of University of Toronto
# not be used in advertising  or  publicity pertaining to distribution
# of the   software  without  specific,   written  prior   permission.
# University of Toronto makes no representations about the suitability
# of this  software  for any purpose. It  is  provided "as is" without
# express or implied warranty.
#
# UNIVERSITY OF TORONTO DISCLAIMS  ALL WARRANTIES WITH REGARD TO  THIS
# SOFTWARE, INCLUDING ALL IMPLIED  WARRANTIES  OF MERCHANTABILITY  AND
# FITNESS, IN NO EVENT  SHALL UNIVERSITY OF TORONTO BE  LIABLE FOR ANY
# SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
# RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF
# CONTRACT, NEGLIGENCE OR OTHER TORTIOUS  ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#
######################################################################

######################################################################
		   XERION VERSION 3.1, WHAT IS IT?
######################################################################

Xerion is a Neural Network simulator developed and used by the
connectionist group at the University of Toronto. This release
(Version 3.1) contains libraries of routines for building networks,
and graphically displaying them.  As well it contains an optimization
package which can train nets using several different methods including
conjugate gradient. It is written in C and uses the X window system to
do the graphics. It is being given away free of charge to Canadian
industry and researchers (and anyone else who wants it). It comes with
NO warranty.

This distribution contains all the libraries used to build the
simulators as well as several simulators built using them (Back
Propagation, Recurrent Back Propagation, Boltzmann Machine, Mean Field
Theory, Free Energy Manipulation, Kohonnen Net, Hard and Soft
Competitive Learning). Also included are some sample networks built
for the individual simulators.

There are man pages for the simulators themselves and for many of the
C language routines in the libraries. As well, xerion has online help
available once the simulators are started. There is a tutorial on
using Xerion in the 'doc' directory.
######################################################################

######################################################################
			     FIRST THINGS
######################################################################

This is the second real release of Xerion (Despite the version number
3.1). It is a beta release and probably has some bugs, but as far as
we can tell, nothing that affects the results of the simulations run
with it. The exact version number of this release is Version 3.1.147.
To install and use it, first read the README files, then try the man
pages or online help (see below).

Xerion has been run and (pretty well) tested on the following
platforms:

SGI Personal Iris and SGI 4d running IRIX 4.0.1
Sun 4 running SunOS 4.1.2
Sun 3 running SunOS 4.0.3

It has been compiled and *minimally* tested on the following platforms:

DEC 5000 running ULTRIX
DEC Alpha running OSF/1
HP 730 running HP-UX 8.07	 (Thanks to Joe Devlin at USC). 

(I don't have access to these machines, so if you are running on one
and you find some bugs, let me know about them (preferably with a
fix)).

It has been tested with MIT X11R4 and X11R5 (libraries: Xaw, Xmu, Xt,
X11).  Xerion will probably run on other machines with some
modifications, but we haven't tested it on them and make no
guarantees.

######################################################################
			   BUILDING XERION
######################################################################

Before you build xerion, make sure you have all of the necessary
source files.  Xerion comes in several packages. The tar file named
xerion-3.1.tar.Z allows you to build the libraries used by the various
simulators. The files bp-3.1.tar.Z, bm-3.1.tar.Z etc. contain the
source for the individual simulators. You MUST untar the xerion tar
file, but need only untar the simulators that you want to build.

unix> mkdir xerion
unix> mv xerion-3.1.tar.Z bp-3.1.tar.Z bm-3.1.tar.Z xerion 
unix> cd xerion
unix> zcat xerion-3.1.tar.Z | tar xvf -
unix> zcat bp-3.1.tar.Z | tar xvf -
unix> zcat bm-3.1.tar.Z | tar xvf -

NOTE: Be sure to untar the xerion tar file before any simulators.

The list of simulators (and their associated tar files) is:

bm-3.1.tar.Z	 - Boltzmann Machine Simulator
bp-3.1.tar.Z	 - Backprop Simulator
cascor-3.1.tar.Z - Cascade Correlation Simulator
fem-3.1.tar.Z	 - Free Energy Manipulation Simulator
hcl-3.1.tar.Z	 - Hard Competitive Learning Simulator
kcl-3.1.tar.Z	 - Kohonen Learning Simulator
mft-3.1.tar.Z	 - Mean Field Theory Simulator
rbp-3.1.tar.Z	 - Recurrent Backprop Simulator
scl-3.1.tar.Z	 - Soft Competitive Learning Simulator

Once you have untarred all of the files, type 'make" for further
instructions on building and installing Xerion.

If you have simulators built with the version 3.0 libraries of Xerion,
there are patches to bring them up to Version 3.1.111 in the directory
"3.0".  There is no patch files that will bring the xerion library
version 3.0 up to version 3.1 (It would be larger than the the source
for version 3.1).

There are also patches (in this directory) for some of the version 3.1
modules. These patches fix various bugs, and add new functionality to
the original release of Xerion 3.1 (revision 3.1.111). If you need to
apply these patches, make sure you apply them in order. 

THE PATCHES HAVE ALREADY BEEN APPLIED TO THE TAR FILES CURRENTLY IN
THIS DIRECTORY. DO NOT RE-APPLY THEM.

Note: Xerion uses Imakefiles; therefore, you must have imake and xmkmf
installed on your system to build it.

######################################################################
			     USING XERION
######################################################################

To use xerion you must initially do two things.

In your .login (csh) insert the following two lines:

setenv XERIONDIR <directory>
source $XERIONDIR/config/setup.csh

where <directory> is the place that the xerion config directory (as
well as the man, doc, templates and nets directories) resides.  (i.e.
the place you untarred the files from above). WARNING: $XERIONDIR
must not contain the '@' character, or you won't be able to run the
simulators. 

If you use sh or ksh, then put the following in your .profile:

XERIONDIR=<directory> ; export XERIONDIR
. $XERIONDIR/config/setup.sh

These setup files add directories to your search path and set some
environment variables.

Then to run the simulator type:
unix> bp
or
unix> run bp	# if you want it to run in it's own window


######################################################################
			     ONLINE HELP
######################################################################

Xerion has unix man pages which can be accessed using the command
'sman' (type "sman sman" for help), as well as online help inside the
simulator (type "help help" for help).
######################################################################

######################################################################
		      BUG REPORTING OR QUESTIONS
######################################################################

There is a mailing list for people using xerion. The mailing list is
primarily intended for discussion of issues relating to the xerion
neural network simulator, and dissemination of information directly
relevant to using the simulator.  The list will also be used to
announce any bug fixes, updates and release news. If you want to be
added to the list, send mail to:

	xerion-request@ai.toronto.edu

If you find any bugs you can mail:

	xerion-bugs@ai.toronto.edu

using the bug report format in the directory $XERIONDIR/doc.

We can't guarantee to fix bugs you tell us about right away, but if we
don't know about them, we can guarantee that we won't fix them.

Any complaints, suggestions, comments, or things not mentioned above
can be sent to:

	xerion@ai.toronto.edu

######################################################################
			       AUTHORS
######################################################################

Xerion was designed an implemented by Drew van Camp, Tony Plate, and
Geoffrey Hinton and is funded by a strategic grant from the Natural
Science and Engineering Research Council of Canada.  Evan Steeg
contributed the bm, mft, and fem modules. Sue Becker contributed the
hcl, scl, and kcl modules.  Brion Dolenko of the University of
Manitoba contributed the cascade correlation module. 
######################################################################

 -- Drew van Camp --------------------------- drew@cs.toronto.edu --
 -- Dept. of Computer Science, University of Toronto ---------------
 -- 6 Kings College Road, Toronto, Ontario -- Vox: (416) 978-7403 --
 -- CANADA M5S 1A4 -------------------------- Fax: (416) 978-1455 --

					Tue Jan 26 11:08:07 EST 1993
