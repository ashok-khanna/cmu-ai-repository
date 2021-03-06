# 
# Copyright (C) 1994, Enterprise Integration Technologies Corp. and Niels Mayer.
# WINTERP 1.15-1.99, Copyright (c) 1993, Niels P. Mayer.
# WINTERP 1.0-1.14, Copyright (c) 1989-1992 Hewlett-Packard Co. and Niels Mayer.
# 
# Permission to use, copy, modify, distribute, and sell this software and its
# documentation for any purpose is hereby granted without fee, provided that
# the above copyright notice appear in all copies and that both that
# copyright notice and this permission notice appear in supporting
# documentation, and that the name of Enterprise Integration Technologies,
# Hewlett-Packard Company, or Niels Mayer not be used in advertising or
# publicity pertaining to distribution of the software without specific,
# written prior permission. Enterprise Integration Technologies, Hewlett-Packard
# Company, and Niels Mayer makes no representations about the suitability of
# this software for any purpose.  It is provided "as is" without express or
# implied warranty.
# 
# ENTERPRISE INTEGRATION TECHNOLOGIES, HEWLETT-PACKARD COMPANY AND NIELS MAYER
# DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL ENTERPRISE
# INTEGRATION TECHNOLOGIES, HEWLETT-PACKARD COMPANY OR NIELS MAYER BE LIABLE
# FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
# RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF
# CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
# CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

WINTERP: An object-oriented rapid prototyping, development and delivery
environment for building extensible applications with the OSF/Motif UI
Toolkit and Xtango-based graphics/animation.
			by Niels Mayer
			WINTERP Version 2.03
			July 24, 1994

------------------------------------------------------------------------------
For information on the latest version of WINTERP, and other information (under
construction), see the World-Wide-Web/Mosaic "WINTERP Home Page":
	URL -- http://www.eit.com/software/winterp/winterp.html
------------------------------------------------------------------------------

WINTERP is a Widget INTERPreter, an application development environment
enabling rapid prototyping of graphical user-interfaces (GUI) through the
interactive programmatic manipulation of user interface objects and their
attached actions. The interpreter, based on David Betz, Tom Almy, et al's
XLISP-PLUS, provides an interface to the X11 toolkit Intrinsics, the
OSF/Motif widget set, primitives for collecting data from UN*X processes,
and facilities for interacting with other UN*X processes. WINTERP thus
supports rapid prototyping of GUI-based applications by allowing the user
to interactively change both the UI appearance and application
functionality. These features make WINTERP a good tool for learning and
experimenting with the capabilities of the OSF/Motif UI toolkit, allowing
UI designers to more easily play "what if" games with different interface
styles.

WINTERP is also an excellent platform for delivering extensible or
customizable applications. By embedding a small, efficient language
interpreter with UI primitives within the delivered application, users and
system integrators can tailor the static and dynamic layout of the UI,
UI-to-application dialogue, and application functionality. WINTERP's use of
a real programming language for customization allows WINTERP-based
applications to be much more flexible than applications using customization
schemes provided by the X resource database, OSF/Motif's UIL (user
interface language), and resource-based languages such as WCL.

An environment similar to WINTERP's already exists in the Gnu-Emacs text
editor -- WINTERP was strongly influenced by Gnu-Emacs' successful design.
In Gnu-Emacs, a mini-Lisp interpreter is used to extend the editor to
provide text-browser style interfaces to a number of UN*X applications
(e.g. e-mail user agents, directory browsers, debuggers, etc). Whereas
Emacs-Lisp enables the creation of new applications by tying together
C-implemented primitives operating on text-buffer UI objects, WINTERP-Lisp
ties together operations on graphical UI objects implemented by the Motif
widgets. Both achieve a high degree of customizability that is common for
systems implemented in Lisp, while still attaining the speed of execution
and (relatively) small size associated with C-implemented applications.

Other features:
	* WINTERP is free software -- available via anonymous ftp from
	  ftp.x.org.
	* Portable -- runs without porting on many Unix systems.	
	* Interface to GNU Emacs' lisp-mode allows code to be developed
	  and tested without leaving the editor.
	* Interactive programing also available in the "WINTERP Control Panel",
	  with editing taking place in a Motif text widget controlled by
	  WINTERP.
	* Built-in RPC mechanism for inter-application communications.
	* XLISP provides a simple Smalltalk-like object system.
	* OSF/Motif widgets are real XLISP objects -- widgets can be
	  specialized via subclassing, methods added or altered, etc.
	* Automatic storage management of all Motif/Xt/X data.
	* Contains facilities for "direct manipulation" of UI components.

The WINTERP 2.0 release includes the following new features:
	* High-level, object-oriented 2.5D graphics/animation package featuring
          pixel-independent/resizeable/scalable rendering, path-transition
	  animation, and high-level animation operators. This is based on
	  Stasko&Hayes' Xtango system.
	* Using Xtango, the ability to easily create new widget classes
	  employing arbitary graphical behavior without the tedium of
	  programming in the Xt instrinsics and Xlib.
	* Asynchronous subprocess facility enables non-blocking GUI interfaces
	  to existing interactive unix commands and interactive network
	  services. Enables use of multiple asynchronous subprocesses.
	* XmGraph widget for creating directed acyclic graphs, trees, and
          direct-manipulation displays.
	* Table widget allows constraint-based GUI static layout
          using tbl(1)-style specifications.
	* Uses XLISP-PLUS version 2.1c -- more functionality, better subset of
	  Common Lisp, e.g. good support for sequence operators.
	* Support for OSF/Motif 1.2.*
	* GIF Image Support.
	* Many new examples, improved example WINTERP applications.
	* Major code cleanups, bugfixes, etc.

You may obtain the latest released version of the WINTERP source,
documentation, and examples via anonymous ftp from internet host ftp.x.org
in directory /contrib/devel_tools, file winterp-2.xx.tar.gz, where 'xx'
represents the revision number. Directory /contrib/devel_tools/winterp
contains slides, papers, further documentation, contributed code, etc.

An automated reply indicating the locations and status of the latest
WINTERP source may be obtained by sending an e-mail message to
winterp-source@netcom.com.

winterp@netcom.com is the mailing list for WINTERP-related announcements
and discussions. To get added/removed from the list, send mail to
winterp-request@netcom.com. Please do not send junk mail or subscribe/
unsubscribe messages to the mailing list winterp@netcom.com.

For discussions about XLISP, see the USENET newsgroup comp.lang.lisp.x.

------------------------------------------------------------------------------

AUTHOR:
		Niels P. Mayer
		Enterprise Integration Technologies
		800 El Camino Real, Fourth Floor
		Menlo Park, CA 94025
		mayer@eit.com or mayer@netcom.com
		URL: http://www.eit.com/people/mayer.html

------------------------------------------------------------------------------

DEPENDENCIES and PLATFORMS:

	WINTERP is portable software, and should run on any machine that
	supports Motif versions 1.0, 1.1, or 1.2 and Berkeley
	sockets. WINTERP will not build directly from the X11r6 distribution.
	YOU MUST HAVE MOTIF INSTALLED ON YOUR SYSTEM.

	WINTERP 2.0 has been tested on the following platforms:
		* Sun SunOS 4.1.3 with developer 'cc' compiler, Motif 1.2.3.
		* Sun Solaris 2.3 with Motif/X11/cc provided by Sun's 2.3 SDK
		* HPUX 9.0 on HP9000s300 HP9000s400, HP9000s700
		* HPUX 8.0. on HP9000s300 and HP9000s800
		* SGI Irix 5.1 and 5.2 w/ Motif/X11/cc from Irix IDO.
		* DEC Ultrix 4.3 and its built-in Motif 1.1
		* DEC OSF1, v2.0 and its built-in Motif 1.2
		* NeXT NeXT-Step 3.0 with Pencom Co-Xist X/Motif
		* 386/486 PC running Linux OS and gcc 2.5.8 compiler
		  (reported by Serge Kolgan root@starato.wwb.noaa.gov).
		* AIX 3.2.5 on IBM RS6000 using IBM's product 'cc'.
		  (reported by Duncan Swain -- duncan@chaussegros.architecture.mcgill.ca)
		* Sun SunOS 4.1.3 with gcc 2.5.8
		  (reported by Wolfgang Kechel -- wolfgang@pr-wiesbaden.de).

	The WINTERP distribution contains Makefiles specific to the above
	machines and OSs, and also provides Imakefiles for compiling WINTERP
	on other systems.

-------------------------------------------------------------------------------

OBTAINING WINTERP:

Here's how to ftp WINTERP 2.0: (your input denoted by ^^^^^^^^^^)

jhvh-1-16-~> cd /tmp
jhvh-1-17-/tmp> ftp ftp.x.org
                ^^^^^^^^^^^^^
        [...]
Name (jhvh-1.eit.com:mayer): anonymous
                             ^^^^^^^^^
Password (jhvh-1.eit.com:anonymous): <anypassword you want here>
                                     ^^^^^^^^^^^^^^^^^^^^^^^^^^^
331 Guest login ok, send ident as password.
230 Guest login ok, access restrictions apply.
ftp> cd contrib/devel_tools
     ^^^^^^^^^^^^^^^^^^^^^^
200 CWD command okay.

ftp> binary
     ^^^^^^
200 Type set to I.

ftp> get winterp-2.XX.tar.gz		## replace XX with latest version number
     ^^^^^^^^^^^^^^^^^^^^^^^
200 PORT command okay.
150 Opening data connection for winterp-2.XX.tar.gz (192.100.58.37,3988) (2303809 bytes).
226 Transfer complete.
2303809 bytes received in 690.63 seconds (1.96 Kbytes/sec)

ftp> quit
     ^^^^
221 Goodbye.

jhvh-1-18-/tmp> su     ## become superuser to install in /usr/local/winterp
	        ^^
jhvh-1-ROOT-1-/tmp> cd /usr/local/
                    ^^^^^^^^^^^^^^

jhvh-1-ROOT-2-/usr/local> gunzip -c /tmp/winterp-2.XX.tar.gz | tar xvf -
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
        [... lengthy list of files output by tar ...]

jhvh-1-ROOT-3-/usr/local/> rm /tmp/winterp-2.XX.tar.gz
                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^

<< If you don't have GNU zip (gzip(1) gunzip(1), retrieve the               >>
<< winterp-2.XX.tar.Z instead of the winterp-2.XX.tar.gz file and use "zcat">>
<< in place of "gunzip -c" above....                                        >>

------------------------------------------------------------------------------

COMPILING and RUNNING:

   * For compilation tips, see winterp/doc/winterp.doc sections:
     <<Compiling and installing WINTERP via Imakefile and 'xmkmf':>>
     or <<Compiling and installing WINTERP via Makefile.* and 'make':>>.

   * For configuration and running hints, see winterp/doc/winterp.doc
     sections: <<Set up X resources and application defaults files:>>,
     <<~/.winterp -- WINTERP session startup file:>>, 
     <<~/.winterpapp -- WINTERP development session startup file.>>,
     and finally, <<Run WINTERP!:>>

   * For known bugs, see winterp/doc/BUGS

