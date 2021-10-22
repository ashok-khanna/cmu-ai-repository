		ezd - easy drawing for programs on X displays

Ezd is a graphics server that sits between an application program and the X
server and allows both existing and new programs easy access to structured
graphics.  Ezd users have been able to have their programs produce interactive
drawings within hours of reading the man page.

Structured graphics:  application defined graphical objects are ordered into
drawings by the application.  Drawings are displayed by mapping them onto
windows.  Multiple drawings may be mapped onto a window and a drawing may be
mapped onto multiple windows.  Pan and zoom operations are done by remapping
the drawing.  PostScript renderings of a window's contents are produced by a
single command.

Loose coupling to the application program:  unlike most X tools, ezd does not
require any event handling by the application.  The ezd server mantains window
contents.  As the application makes changes to drawings, the server smoothly
corrects the display.  Communication between the application and the server is
via text streams so feel free to write your application in COBOL.

Interaction:  objects in drawings are made interactive making them sensitive
to mouse and keyboard events.  When an event occurs on such an object, an
application supplied Scheme expression is evaluated.  This expression may
simply relay the event to the application, or the entire application may be
written in Scheme and embedded in the server.

An example:  draw three overlapping circles; when mouse button 1 is clicked
on a circle, raise it to the top of the drawing:

	(object c1 (fill-arc 0 0 60 60 0 360 red))
	(object c2 (fill-arc 30 0 60 60 0 360 green))
	(object c3 (fill-arc 15 30 60 60 0 360 blue))
	(click * 1 (ezd `(float ,*user-event-object*)))


A technical report is available that describes this software:

	Bartlett, Joel F., "Don't Fidget with Widgets, Draw!",
	WRL Research Report 91/6, May 1991.

You may send your order to:

	Technical Report Distribution
	DEC Western Research Laboratory, WRL-2
	250 University Avenue
	Palo Alto, California 94301  USA

or you may order via electronic mail by sending a message with "help" in
the subject line to one of the following addresses:

	Digital E-net:	DECWRL::WRL-TECHREPORTS
	Internet:	WRL-Techreports@decwrl.dec.com
	UUCP:		decwrl!wrl-techreports

The software is owned by Digital Equipment Corporation and available under
the following conditions:

;*           Copyright 1990-1993 Digital Equipment Corporation
;*                         All Rights Reserved
;*
;* Permission to use, copy, and modify this software and its documentation is
;* hereby granted only under the following terms and conditions.  Both the
;* above copyright notice and this permission notice must appear in all copies
;* of the software, derivative works or modified versions, and any portions
;* thereof, and both notices must appear in supporting documentation.
;*
;* Users of this software agree to the terms and conditions set forth herein,
;* and hereby grant back to Digital a non-exclusive, unrestricted, royalty-free
;* right and license under any changes, enhancements or extensions made to the
;* core functions of the software, including but not limited to those affording
;* compatibility with other hardware or software environments, but excluding
;* applications which incorporate this software.  Users further agree to use
;* their best efforts to return to Digital any such changes, enhancements or
;* extensions that they make and inform Digital of noteworthy uses of this
;* software.  Correspondence should be provided to Digital at:
;* 
;*                       Director of Licensing
;*                       Western Research Laboratory
;*                       Digital Equipment Corporation
;*                       250 University Avenue
;*                       Palo Alto, California  94301  
;* 
;* This software may be distributed (but not offered for sale or transferred
;* for compensation) to third parties, provided such third parties agree to
;* abide by the terms and conditions of this notice.  
;* 
;* THE SOFTWARE IS PROVIDED "AS IS" AND DIGITAL EQUIPMENT CORP. DISCLAIMS ALL
;* WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF
;* MERCHANTABILITY AND FITNESS.   IN NO EVENT SHALL DIGITAL EQUIPMENT
;* CORPORATION BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
;* DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
;* PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
;* ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
;* SOFTWARE.

The software is available for anonymous ftp from 'gatekeeper.dec.com'
[16.1.0.2]. The ezd files are in '/pub/DEC/ezd'.  These files include the
current release:

     README             - this file
     15mar93.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.
     techreport.psf.Z   - compressed PostScript for WRL Research Report 91/6,
			  "Don't Fidget with Widgets, Draw!"

and earlier release(s):

     03feb93.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.

     23sep92.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.

     20aug92.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.

     04nov91.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.

     01jul91.tar.Z      - compressed tar file containing all source,
                          DECstation .o files, examples, and documentation.

To build ezd:

1.  Create an working directory and load the files into it:

	> mkdir ezd-work
	> cd ezd-work
	> mv ???/???/???/15mar93.tar.Z .
	> uncompress 15mar93.tar.Z
	> tar -xf 15mar93.tar

    The directory now contains the Scheme->C source and DECstation .o files
    for the software.  The doc directory contains the troff source and 
    PostScript for the man page.  The examples directory contains a few
    examples.

2.  Build ezd.  For a DECstation, this is straight forward as the .o files
    for ezd and Scheme->C are part of the distribution:

	> make ezd-for-DECstation

    Other systems require Scheme->C, a portable Scheme-to-C compiler, as the
    ezd source must be compiled to C and then linked with a system specific
    version of the Scheme->C runtime library.

    The Scheme->C system is also available from 'gatekeeper.dec.com' and
    is in the directory '/pub/DEC/Scheme-to-C'.  Once it has been installed:

	1.  Change the SCXL variable in 'makefile' to designate the
	    Scheme->C X library, scxl.a.

        2.  Change the X11 variable in 'makefile' if required for your
	    system.  For example, when building ezd for an Alpha AXP system
	    running OSF/1, change it to "-non_shared -lX11 -ldnet_stub".

	3.  > make ezd

3.  Test ezd by compiling one of the examples, make sure that the environment
    variable DISPLAY is correctly set:

	> cd examples
	> make clock
	> ln -s ../ezd
	> clock

    A window containing a clock face should now be displayed.  Drag either of
    the hands using mouse button 1 to set the clock.  Click mouse button 3 on
    the background to terminate the program.


Changes since the 04nov91 release:

1.  Buttons and other interactors (except sliders) update the display before
    executing the user's action.  Under load, it was possible for the action
    to be taken without any visual feedback.

2.  EDIT-VARIABLE-COLOR's control panel now includes HSV sliders.

3.  The POSTSCRIPT command has the following improvements:

	%%CreationDate is defined in the header.

	%%BoundingBox is defined in the header.

	Output is centered on either an 8.5 x 11 or 11 x 17 page.  Paper
	sizes and printable areas are specified in tables in psdraw.sc
	that are straightforward to change.

4.  The POINTS attribute in the SCALE command in now correctly interpreted.

5.  Bounding box computation for filled polygons has been corrected.

6.  Mouse detection on lines has been corrected.

7.  Text drawings now correctly support explicit changes of the cursor and
    highlights and allow the compose key to be encoded as xk_multi_key.

8.  Sliders now correctly restore the cursor when the mouse is inside them
    when their attributes are changed.

9.  Menu width for popup menus is now the width of the widest entry plus
    four spaces.

10. When multiple edit-variable-color commands are issued, the controls are
    not stacked directly over each other.

11. Ezd now uses either the procedure time-of-day or open-input-process to
    get the time of day in order to be compatible with all versions of
    Scheme->C.

12. Correct argument types are now supplied to XAllocColorCells in a call
    associated with variable colors.

13. Image data is now supported by the quilt and bitmap commands.

14. Colors may be defined using HSV coordinates.

15. RGB and HSV definitions for colors may be obtained by the get-color-value
    command.

16. Transparent check buttons and push buttons are now supported.

17. Corrected PostScript output for the point command.


Performance tips:

- Drawings containing a large number of objects may cause ezd to run poorly
because it's doing an excessive number of garbage collections.  To see if this
is a problem, set the environment variable SCGCINFO to 1 to log garbage
collection statistics to stderr.

The easiest way to avoid this problem is to let ezd automatically expand its
heap as needed.  To allow this, set the environment variable SCMAXHEAP to the
desired maximum heap size in megabytes.  For example, "setenv SCMAXHEAP 16",
allows ezd to expand its initial 4MB heap to 16MB.

For details on configuring the heap via environment variables or command line
flags, see the man page for sci.

- Use integers rather than real numbers for coordinates and coordinate
transforms.

- Use quilt's rather than large numbers of rectangles where applicable.


remember, don't fidget with widgets, draw!

		Joel Bartlett	bartlett@decwrl.dec.com
