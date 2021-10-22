This is XLISP-STAT 2.1 for generic bsd systems (with simple tektronix
graphics from the gnuplot system), SunView or X11.  

XLISP-STAT is a statistical environment based on a dialect of the Lisp
language called XLISP. Originally developed for the Apple Macintosh,
XLISP-STAT is now also available for UNIX workstations using the X11
window system and for use on SUn workstations running suntools. To
facilitate statistical computations standard Lisp functions for
addition, logarithms, etc., have been modified to operate on lists and
arrays of numbers, and a number of basic statistical functions have
been added.  Many of these functions have been written in Lisp, and
additional functions can be added easily by a user.  Several basic
forms of plots, including histograms, scatterplots, rotatable plots
and scatterplot matrices are provided.  These plots support various
forms of interactive highlighting operations and can be linked so
points highlighted in one plot will be highlighted in all linked
plots. Interactions with the plots are controlled by the mouse, menus
and dialog boxes. An object-oriented programming system is used to
allow menus, dialogs, and the response to mouse actions to be
customized.

Updates to this system will be posted periodically in the anonymous
ftp directory of umnstat.stat.umn.edu (128.101.51.1).

A tutorial introduction to the system is available. It is written
primarily for the Macintosh version, but the differences to the UNIX
version are minor; see below. The tutorial is available as a set of
LaTeX files in xlispstat.doc.tar.Z at the ftp address above.

For further information contact

		Luke Tierney
		School of Statistics
		University of Minnesota
		Minneapolis, Mn. 55455

		luke@umnstat.stat.umn.edu


			COPYRIGHT INFORMATION
				   
*******************************************************************************
* XLISP-STAT 2.1 Copyright (c) 1990, by Luke Tierney
* XLISP version 2.1, Copyright (c) 1989, by David Betz.
*
* Permission to use, copy, modify, distribute, and sell this software and its
* documentation for any purpose is hereby granted without fee, provided that
* the above copyright notice appear in all copies and that both that
* copyright notice and this permission notice appear in supporting
* documentation, and that the name of Luke Tierney and David Betz not be
* used in advertising or publicity pertaining to distribution of the software
* without specific, written prior permission.  Luke Tierney and David Betz
* make no representations about the suitability of this software for any
* purpose. It is provided "as is" without express or implied warranty.
*
* LUKE TIERNEY AND DAVID BETZ DISCLAIM ALL WARRANTIES WITH REGARD TO THIS
* SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS,
* IN NO EVENT SHALL LUKE TIERNEY NOR DAVID BETZ BE LIABLE FOR ANY SPECIAL,
* INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
* LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
* OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
* PERFORMANCE OF THIS SOFTWARE.
* 
* XLISP-STAT AUTHOR:
*               Luke Tierney
*               School of Statistics
*               University of Minnesota
*               Minneapolis, MN 55455
*               (612) 625-7843
* 
*       Email Address:
*               internet: luke@umnstat.stat.umn.edu
*
* XLISP AUTHOR:
*              David Betz
*              P.O. Box 144
*              Peterborough, NH 03458
*              (603) 924-4145
*******************************************************************************

(David Betz has kindly given his permission to remove the restriction
on commercial use from the copyright. The new copyright is adapted
from the copyright in winterp as distributed with X11 R4.)

				   
			     INSTALLATION

To compile the system you need to edit the Makefile and

	1) set the two variables

		BINDIR
		XLISPLIB

	to appropriate values

	2) choose your graphics system

	3) for SunView choose your SunOS version

	4) adjust the UCFLAGS, etc to your liking

Then do a `make' or a `make install'. The XLISPLIB directory must
exist for the install to succeed.

If you are in a sun environment with some people using suntools and others
using X11 you may want to set things up to use both systems. To do this

	1) edit the Makefile and set the directories and SunOS version
           as above

	2) do a `make X11sun' or `make installX11sun'

This sets up two executables and a shell script that tries to figure
out which one to use based on whether it finds the DISPLAY environment
variable set.


	   MAJOR DIFFERENCES BETWEEN UNIX AND MAC VERSIONS

Examples and sample data sets are located in a library directory. To access 
them you can use the functions load-data and load-example. For example, to
load the data sets used in the tutorial technical report type

	(load-data "tutorial")

The library directory is given by the variable *default-path*; data
and examples are in the subdirectories Data and Examples.

The UNIX xlispstat versions are designed to run on a standard
terminal.  This means parentheses matching is not available. If you
are a gnu emacs user you can set up gnu emacs to allow it to run
xlispstat for you.  The files my.emacs and xlispstat.el in the emacs
directory are examples of how to do this.

If you are a vi user you may want to use the -l option for editing
Lisp files.

The basic UNIX version includes some Tektronix graphics based on the
gnuplot routines. The functions plot-points and plot-lines should work
but all other high lever graphics functions will signal an error when
used in this system.  Low level graphics methods will probably result
in a crash.

Both window-based systems should operate like the standard unix-based
system, with basic tektronix graphics, when not run under the
appropriate window manager (i. e. on a console under suntools or on a
terminal with the DISPLAY environment variable set).

In the SunView version the frame menu is used to close plots. The
right button pops up the plot menu. clicking and dragging with the
left button is like clicking and dragging on the macintosh - selected
point are unselected when a click occurs. Clicking and dragging with
the middle button is like shift-clicking and dragging on the mac - the
current selection is extended.

Under X11 there is a close button and a menu button. For plot
interaction all mouse buttons are identical. To extend a selection
hold down the shift key as you click.

For both X11 and SunView a "Save to File" is available in the plot
menus. This item brings up a dialog asking for a file name; if the ok
button is pressed an image of the plot is saved as a postscript file.
This takes a while under X11 (20 - 30 seconds on a sun 3/50).

X11 scroll bars on plots (name-lists in particular) work like xterm
scroll bars.

X11 dialog sliders sliders look something like macintosh sliders.
Sliders and scroll bars are the only items that interpret different
mouse buttons differently, and thus the only point at which a
three-button mouse is assumed: In the body of a slider the left button
decreases by a page increment, the right button increases by a page
increment and the middle button drags the thumb around



			SUNVIEW FEATURES/BUGS

Scroll bars in plots are not supported yet. This means long name-lists
are useless. Clipping is also not supported, so plot boundaries may
end up full of garbage after a while. The reason for both is that sun
pixwins and pixrects don't seem to support the notion of changing the
origin.

Dialogs show up wherever they want to on the screen - the location
specified in the dialog object is ignored.

Clicking a toggle or choice item in a modal dialog does not return
from the modal dialog loop.

Dialogs of type modal are initially non-showing. The :modal-dialog
method shows them.

in suntools dialogs of type modeless don't work with the :modal-dialog
message.

Sliders are a little strange since they don't have as many parts as
macintosh scroll bars

In suntools if a jump-to-top occurs from a break loop caused by an
error in a window manager call-back (or if the jump occurs after an
error because the break enable flag is nil) the graphics will no
longer work. Apparently something in the notifier gets confused, and I
have not been able to figure out how to reset it.
	
For now the only solution I can suggest is to wrap an errset around
plot methods while you are debugging them.



			  X11 FEATURES/BUGS

Under X11 where plots and modeless dialogs show up on your screen, and
how large they end up being, is up to the window manager. Requests you
make may be honored under one manager but not under another.

Several options can be set using the X11 resource management
facilities.  Options controlling appearance are

xlisp*menu*titles:     on for a title on a menu, off otherwise
xlisp*menu*font:
xlisp*dialog*font:
xlisp*graph*font:

There are also a few options controlling performance. These are

xlisp*graph*fastlines:   on to use 0 width lines
xlisp*graph*fastsymbols: on to use DrawPoints instead of bitmaps
xlisp*graph*motionsync:  on to use XSync
xlisp*graph*icccm:       on to use (almost?) ICCCM-compliant dialogs
xlisp*graph*waitformap   on to wait for MapNotify event before drawing

By default all are on. (This default can be changed by editing the
include file StX11options.h.) That seems to give the best performance
on a Sun 3/50. It may not be the best choice on other workstations.
You can also use the function x11-options to change these five options
within lisp. The fastlines option will not take effect immediately
when changes this way but will affect the next plot created. The other
two options do take effect immediately.

The only way to set the display to be used is to set the DISPLAY
environment variable before starting up xlispstat.

On some color or greyscale X11 implementations you may get X errors
when you exit from xlispstat. I *think* this is due to a bug in the
X11 server. Try defining the variable SERVER_COLOR_FREE_PROBLEM by
uncommenting its define line in StX11options.h.


	    FOREIGN FUNCTIONS, DYNAMIC AND STATIC LOADING

Foreign function calling may be supported on some UNIX systems. The
basic calling conventions are similar to those in New S and are
described in an appendix to the XLISP-STAT tutorial. To enable foreign
function calling uncomment the line

#FOREIGN_FLAG = -DFOREIGNCALL

in the Makefile, add a line

MACHINE=your_machine

where your_machine is one of the subdirectories of the `machines'
directory. If you do not find anything suitable in these directories
you may be able to adapt one of the existing ones; the main thing to
do for most machines is to define a `foreign.h' include file.

Depending on the machine you are on enabling foreign function calling
may enable dynamic loading as well. If dynamic loading is not
available you can still use static loading. At present there is no
simple support for users to do static loading, like in New S. Instead,
you can use the EXTRAOBJS and EXTRALIBS variables in the Makefile. If
static loading is important adding the S-like facility for user
loading should be quite easy.

This is the only aspect of XLISP-STAT on UNIX systems that involves
serious machine dependencies. If you can live without foreign function
calling you can ignore the machines directory.

