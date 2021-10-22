THIS VERSION OF PRODIGY IS 2.11
FROZEN ON 2 OCTOBER 1990

THE FOLLOWING DESCRIBES CHANGES FOR PRODIGY RELEASE 2.11

The tree graphics were substantially re-written.  They are much faster
and reliable.

Added a fix to ebl from steve minton.

The system should be more reliable running under allegro, since we
have had someone running under allegro for a while.

A few new domains were added making it impossible to distribute the system
on three 700k mac diskettes.  We have divided up the domains into two groups
a default and an extra.  If you only send three disks you don't get the
extra domains.

THIS VERSION OF PRODIGY IS 2.10
FROZEN ON 16 May 1990

THE FOLLOWING DESCRIBES CHANGES FOR PRODIGY RELEASE 2.10
16 May 1990


Note: X10 is no longer supported in this release.

Note: When you start either the tree window or the domain window under X11
PRODIGY will initialize the graphics code.  If you save a core after
creating a tree or domain window prodigy will save invalid references to
windows and you won't be able to use the graphics with your core.  You
should create the core before you start any of the windows.

Note: The depth slot in the node structure maintains the depth of the search
tree, the cost of an operator is 1+ and the cost of an inference rule is 0.
To change this you must add the appropriate change to the execute-operator
function.  Also, this is a new slot so you should recompile all code that
uses this structure.

Note: You should now add a call to (reset-last-domain) to the beginning of
each of your domain files.  Prodigy is now a lot better a resetting code
when you change domains and this function call is vital to the process.

I made many little bug fixes a few of which are probably mentioned here, but
for the most part I've left them out.

We fixed a problem in the search control binding rules that would let the
system rebind values that were already bound.  This occurred if you bound a
variable with a literal in the rule, and then the system tried to rebind the
rule.

The interface is fixed so that a CR at the interface is no longer an error.

The advise facility was improved so that you can return to the Prodigy:
prompt (almost) immediately.

Changes were made to the startup file to eliminate X10 support.

Some extra-right paren's were removed.

The cntrl function in engine was modified to eliminate to redundant math
calculations per iteration in the time bound inequality.

All inits in ini.lisp have been changed to defvar which is the "right" way
to do things according to steele.

A few more variables were added to ini.lisp.

The (reset-last-domain) function was created.  This should be called by a
domain startup file (see note above) before any of the domain is loaded.
This will clear out stuff from the last domain.

Added the movie command.  This command lets you see the graphical trace of a
solution run on your screen.

Added auto resize to graphics.  This allows graphics that can be resized to
be resized (not all graphics have this ability) before typing run so you can
write domain graphics as big as you want.

Added a discard command.  This command will toggle a switch that tells
prodigy that it should erase all nodes on a branch that has failed.  This
offers a space savings on a search in a large search space.

Added the dfid-run command.  This command performs depth first iterative
deepening and should be used with the discard on, otherwise you will be
running a very inefficient version of breadth first search.

I have added lots of declare statements in many files in the hopes of making
the code run a little faster.

I added a new structure slot to node.  The slot is called depth.  For any
node the depth of that node will be the number of operators (and not
inference rules) executed between it and the root node.

The raw command in analyze now works differently.  It prints out every slot
in the node structure and then prints out each of the properties in the rule
structure.

Traversing nodes in the analyze facility works differently.  In the past
going forward N nodes with graphics turned off took you forward N nodes.
With the graphics turned on it took you forward N nodes on the current path,
so it might skip some backtrack nodes.  Now the forward command works this
way regardless of whether the graphics are turned on or off.

Graphics Support changes:

Added new graphics stuff from Robert Joseph that will allow windows to be
moved around the screen and changed in size under X11.  This is especially
nice with the analyze facility which lets you view very large trees.

The macro call (current-host) will give the name of the host to which an X
connection will be made for graphics.  It is setf'able.  This is very useful
if you want to run a demo on an X workstation, but wish to control the
graphics from another system or a terminal.  The screen used is always 0 and
this cannot be changed by the user.  The change must be made before any
windows are requested.

The variable *font-string* contains the name of the font used the the
graphics windows.  You can change this before you start prodigy to determine
the font (on X11, see man page of xlsfonts) no font facility exists yet on
the mac.

Fixed graphics so CLX xlib:open-display and other calls are only made once.

The graphics call xlib:open-display now uses the unix display variable to
choose the host.  This needs to be re-written for each type of lisp and
operating system that runs CLX.  So far we have allegro and CMU Common lisp
(both under unix) support.  Look in ini.lisp for the place to change the
code.  Under unix the string "unix" is better (gives a faster connection)
then the host name but can only be used in the X server and lisp run on the
same host.

Added resize to tree graphics, now you can look at a very large tree.

Removed a lot of extra display-force-output calls in the CLX stuff.  This
should improve graphics performance when there is a long communications
delay between the application and the X server.

Since CMU Common lisp lets us eliminate the event loop because of a local
feature I had to add one for allegro (and others) support.  The event loop
runs while the system is expecting input from keyboard.  Generally this
causes a lot of cons'ing even when you aren't doing anything.  Because of
this the event loop only functions when you have a window up.  With no
windows the system acts as it always did.

THIS VERSION OF PRODIGY IS 2.01
FROZEN ON 29 AUGUST 1989

THE FOLLOWING DESCRIBES CHANGES FOR PRODIGY RELEASE 2.01 
28 AUGUST 1989

NOTE:  The changes in this release are primarily aimed at getting the system
up on Allegro Common Lisp on a MAC II.

NOTE:  This will be the last release with X10 support.  After this the
Prodigy Project will not continue to test the software with the X10 window
manager.  The next release will include a substantially different
pg-X11.lisp which will offer better graphics capabilities.   pg-X10.lisp
will not be upgraded to offer these capabilites and may even fail.

NOTE: The compress'ed file prodigy2.tar.Z is now also available.  It will
ftp much faster to your site because it is smaller.  Use the uncompress
program on it to generate the tar file, which you can then un'tar.

NOTE:  Use the FTP binary option when you ftp the tar file to you machine.

Places where eq was used to compare numeric or character arguments were
changed to eql or equal.

graphics for frozenblocksworld and blocksworld now load from the startup
file and have the defmacro's at the beginning of the file so that they work
in versions of lisp that require them to be defined in the beginning.

A :franz-inc read-conditional was added to one of the directory commands in
commands.lisp so that the domain command in the interface would work
properly under allegro common lisp.

A number of extra ')' were removed from source code.

A lot of extraneous files and directories have been deleted from the
release.  The release 2.01 may actually be smaller than 2.0.

eval-when's were fixed so that the proper pg- (e.g. pg-mac) is loaded just
before compilation.  This is need for machines (like the Mac) that expand
macros at compile time.

------------------------------------------------------------------------
