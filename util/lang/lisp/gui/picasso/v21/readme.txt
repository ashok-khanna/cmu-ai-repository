Informational posting for those interested in the status of the Picasso
Graphical User Interface Development System - March 12, 1993.

This note is the ramblings of John Boreczky, "The last Picasso developer",
and anything that upsets you shouldn't be taken too seriously, and anything
you like, well, enjoy it.

Picasso version 2 release 0 does not work as released with Allegro CL
version 4.1.  It works fine with Lucid CL 4.0.X and Allegro CL 4.0.X.
It is unlikely that we will make a version 2 release 1 available since
there are no local Picasso users (see below), and any remaining work would
need to be done in the free time of a single grad student.

THE FUTURE OF PICASSO

Picasso has been declared a success and we are moving on.  One of our main
interests in Picasso has been for internal development of GUI applications.
Unfortunately, our best efforts at optimization were insufficient.  Using
the delivery toolkits provided by Lucid and Allegro and using a lot of
other optimizations resulted in cutting startup time by 50%, execution time
by 25%, and memory usage by 20%.  These improvements are impressive but not
enough to make using Common Lisp competitive with other options.  An
upcoming technical report (which we will make available for ftp) details
our efforts and results.  We are now using Tcl/Tk (C based) for our
distributed multimedia, video conferencing, and video-on-demand
applications.  No new Picasso development is taking place and we are
building replacements for the few Picasso applications that are used
internally.

UNRELEASED PICASSO FEATURES

Allegro CL 4.1 compatibility:

Picasso version 2 release 0 does not work with Allegro CL 4.1.  A number of
people have made it work with minor changes - these changes require some CL
knowledge.  These changes come T.S. Waterman (thanks for sending your
list!), and some of our own efforts.

  1.) A number of types from CLX in the XLIB: package are used without
      specifiying the package.  Either add XLIB: in front of all of these
      or import them into Picasso using a new headers file.
  2.) A number of other types aren't deftype'd.  These include EVENT-MAP,
      VISUAL, and MENU.  ts deftype'd EVENT-MAP as a hash-table and used T
      for the rest.
  3.) A lot of our calls to WARP-MOUSE didn't use the :X and :Y keywords,
      but these are easy to find and repair.
  4.) ts had problems with the headers/classes.cl file which has stubs for
      all of the defclass statements - he removed it and then encountered
      some load order problems.  We didn't have any problem with redefining
      classes.
  5.) Lots of warnings for various things we did, which can usually be
      ignored. 

We haven't run Picasso under Allegro CL 4.1 except to verify the changes in
Allegro Presto, so there may be other problems.

Picasso bugs:

We have gotten detailed bug reports from several individuals who were
obviously using Picasso much more than we were ourselves.  Robert Bowdidge
should get an award (I wish we had any t-shirts left to send) for sending 
reports detailing hundreds of bugs AND sending code to fix most of the
problems.  Some of the fixes made it into release 0, but there are lots of
others. 

Attach/Detach:

Attach/detach allows Picasso objects to be attached and detached from
the X server so that an application can be started, stopped, saved, and
then restarted at a later time.  This code is present in version 2
release 0 but is not documented and has some rough edges.

For example, you can start cimtool, open and close the panels of
interest, and then quit.  From the CL prompt, type the following:
  (setf d (current-display))
  (detach d)
and then save the image to a file.
You can then load the image and at the prompt type
  (attach d)
  (cimtool)
The cimtool frame will appear very quickly since the database loading
and much of the Picasso object initialization doesn't need to be done.

HIP (Hypermedia in Picasso):

The minor changes to HIP taking place at the time of release 0 are
finished.  HIP doesn't work with Allegro CL 4.1 at all and would
require a good deal of modification to do so.


A final word:

Picasso has been an incredible learning experience for all of us who have
worked on it, even people like me who just saw the end.  The Lisp community
is very special, but I am encouraged that a similar community is forming
around Tcl/Tk (and it even has a Usenet group).  Thank you to everyone who
has contributed, knowingly or not, to our work.  I hope that my current
work on video database indexing will be as rewarding and enjoyable.

John Boreczky
johnb@cs.berkeley.edu
Video-on-Demand Server (VODS) Group
late of the Picasso Group
University of California Berkeley