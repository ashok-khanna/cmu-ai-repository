
OBVIUS (Object-Based Vision and Image Understanding System) is an
image-processing system based on Common Lisp and CLOS (Common Lisp
Object System).  The system provides a flexible interactive user
interface for working with images, image-sequences, and other
pictorially displayable objects.  By using Lisp as its primary
language, the system is able to take advantage of the interpretive
lisp environment (the ``listener''), object-oriented programming, and
the extensibility provided by incremental compilation.

The top-level of OBVIUS is implemented in Common Lisp, thus providing
an interpreted, object-oriented programming environment.  The
low-level floating point operations are implemented in C for
efficiency.  A graphical user interface, based on menus and dialog
boxes is also provided, in addition to the Lisp interpreter
(listener).  In the typical mode of interaction, the user types an
expression to the lisp listener (or enters a command in a dialog box)
and it returns a result.  A picture of that result will then be
automatically displayed in a window.  Each window contains a circular
stack of pictures.  The user can cycle through this stack using mouse
clicks with certain shift (``bucky'') key combinations.  Commonly used
operations such as histogram and zoom are also provided via mouse
clicks.

The system provides a library of low-level image processing routines.
Some examples of these are
- arithmetic operations (add, multiply, lookup-table point
operations, etc)
- image statistics (mean, variance, kurtosis, maximum, histograms etc)
- convolutions, Fourier transforms, Hilbert transforms
- geometric operations (crop, slice, rotate, flip-x, etc)
- comparisons (greater-than, etc)
- synthetic image generation
- matrix operations
OBVIUS also provides postscript output of pictures.  Writing new
operations in OBVIUS is relatively simple, and it is straightforward
to add new viewable and picture types.

OBVIUS currently runs on Sun and SGI workstations in Lucid v4.1 Common
Lisp.  For the Sun implementation, it also requires the LispView
interface to OpenWindows/X, which is available free of charge on the
X11 distribution tape.  LispView is also available in the ftp
directory on white.stanford.edu.

OBVIUS is available via anonymous ftp from white.stanford.edu,
IP number 36.121.0.16.  Documentation (latex), and a User's Guide with
installation instructions are included in the tarfile.  Since it is
currently an in-house product it comes without warrantee or support.
For more information contact:

David Heeger 
heeger@white.stanford.edu
(415) 723-4048

Eero Simoncelli
eero@central.cis.upenn.edu
(215) 898-0376

Let us know if you get a copy of OBVIUS at your site so that we can
keep a list of everybody (to send out bug fixes, inform you of new
releases, etc.)

