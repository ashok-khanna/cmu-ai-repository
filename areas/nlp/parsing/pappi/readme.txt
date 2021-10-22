
			GETTING PAPPI STARTED

		     (C) 1992, 1993, 1994 Sandiway Fong, 
		      NEC Research Institute, Inc.


VERSION: 2.0 (1st Public Release)

CONTACT ADDRESS:
			Sandiway Fong
			NEC Research Institute, Inc.
			4 Independence Way
			Princeton NJ 08540
			USA
			Inet: sandiway@research.nj.nec.com

*  Please follow the installation instructions and run the demo to 
   verify that everything is properly installed.

*  COLING-94 posters in Postscript format are included in doc/posters
   
   [Posters may be viewed on-line using ghostscript/ghostview or
    Sun's pageview (preferred). Adjust magnification to suit. They
    print nicely if you have access to a poster-sized colour printer!]

   Demonstration versions of the posters can also be run on the
   parser. Use the Start Script selection under the Run menu.

*  To receive notifications about bug fixes and future versions of
   this program, send a note to the contact address.

   [Note: the grammar supplied is just a sample of what can be done. 
    Upcoming releases may include alternative theories and parsing 
    models from the same framework.]

*  Bug reports, contributions to and suggestions for the system are
   most welcome.

ACKNOWLEDGEMENTS:

The author wishes to acknowledge the following persons who have
made contributions to the PAPPI system:

*  OpenWindows Interface	Erwin Klöck, NEC Research Institute.
*  GLR Debugger, Interface	Mike Lake, U. of Illinois, Urbana-Champaign
*  Utilities			Rathnakar Gopisetty, U. of Missouri
*  Dutch syntax			Tim van der Avoird, Tilburg University
*  French and Spanish syntax	Martine Smets, U. of Illinois, Urbana-Champaign
*  German syntax		Uli Sauerlan, MIT

DISCLAIMER:  There is no warranty on the program.

TERMS AND CONDITIONS OF THE LICENSE:

1. You may freely copy and distribute verbatim copies of this program.

2. You may modify the program and copy and distribute any modifications
   under the terms of paragraph (1) provided:

   a. Original copyright notices are not removed. If provided sources are 
   modified, annotate the copyright notice in each file.

   b. You may not charge a fee for the program, unmodified or otherwise.
   A nominal charge for any media or transfer costs is permitted.
   
   c. You may incorporate portions of this program into another program.
   However, the resulting program must be licensed under the terms of
   paragraphs (1) through (4).

3. You may not copy, modify or distribute the program except as provided by
   the terms of this license. Your right to use this program will be
   automatically terminated. Permission for exceptions to any of these terms
   can only be granted by the original copyright holder.

4. By copying, modifying or distributing the program or any work derived from
   the program, you indicate your acceptance of the terms and conditions of 
   this license.


REQUIREMENTS:

*	A Sun Sparcstation, preferably with a colour monitor.
*	SunOS 4.1.x with OpenWindows 3.0, or 
	SunOS 5.3 with OpenWindows 3.3
*	Quintus Prolog 3.1.4
*	About 65-70MB of free disk space to install

	[Note: Requirements will be relaxed somewhat in the next
	 release. Other platforms may be supported. Quintus Prolog
	 may not be required.]

INSTALLATION:

*  This distribution comes mostly pre-compiled. 
   To run the system use the provided executable (Pappi) AFTER completing
   ALL of the following steps.
   Note: A sample installation is given in Appendix A.

Installation Steps:

0. I assume you've uncompressed and untarred Pappi-2.0X.tar.Z where X
   is the minor release (an alphabetic character (or you wouldn't be
   reading this now.)

1. You must know where Quintus Prolog is installed at your local site.

2. Run the Makefile using the command:

	make
	
   to compile the distributed Prolog files and sets up the
   executables.

   [Note: the Prolog (.pl) files are shipped uncompiled. The make command
    will compile all the .pl files into object (.qof) files. This will
    take 3-20 minutes depending on your Sun workstation. Grammars then
    can be loaded in PAPPI in tens of seconds rather than tens of
    minutes. If PAPPI startup is very slow, then this probably means
    the Prolog files haven't been compiled.]

   Note: The Makefile assumes the Quintus Prolog compiler (qpc) 
         is accessible via your executable path. 
         (Type 'which qpc' to find out.) If not, either add the
	 relevant directory to your path or edit the Makefile.

         For example, qpc will be in /usr/quintus/bin/3.1.4/sun4-4
	 if Quintus 3.1.4 is installed in /usr/quintus and we are 
	 running SunOS 4.1.x.

	 The Make attempts to figure out if you are running SunOS
	 4.1.x or Solaris 2.x. It should install the correct
	 executables automatically. If not, consult the Makefile
	 and create the symbolic links manually.

3. Configure the executable to point to the Quintus Prolog hierarchy.
   Suppose the relevant directory is /usr/quintus. Then type the
   command:

	Configure /usr/quintus

4. The PAPPI system is a dynamically linked application. This means
   that PAPPI requires the following shared libraries to be accessible
   in order to operate:

   Under SunOS 4.1.x:

	LIBRARY			TYPICAL LOCATION
	libxvps.0		/usr/openwin/lib	
	libxview.3		/usr/openwin/lib	
	libolgx.3		/usr/openwin/lib	
	libcps.1		/usr/openwin/lib
	libX11.4		/usr/openwin/lib
	libc.1			/usr/lib
	libdl.1			/usr/lib
	sspkg.1			<Distribution Directory>/lib
	Xpm.4			<Distribution Directory>/lib

   Under Solaris 2.3:

	LIBRARY			TYPICAL LOCATION
        libxview.so.3 	        /usr/openwin/lib
        libolgx.so.3 		/usr/openwin/lib
        libXext.so.0		/usr/openwin/lib
        libX11.so.4 		/usr/openwin/lib
	libsocket.so.1 		/usr/lib
        libnsl.so.1 		/usr/lib
        libintl.so.1 		/usr/lib
        libdl.so.1 	    	/usr/lib
        libm.so.1 		/usr/lib
        libc.so.1 		/usr/lib
        libw.so.1 		/usr/lib
        libelf.so.1		/usr/lib
        libucb.so.1		/usr/ucblib
        libsspkg.so.1 		<Distribution Directory>/lib
        libXpm.so.4.1		<Distribution Directory>/lib

   You should set the LD_LIBRARY_PATH environment variable to access
   the directories in which these libraries can be found. For example,
   under SunOS 4.1.3:

	setenv LD_LIBRARY_PATH /usr/openwin:/home/lf/Pappi/lib

   if PAPPI is installed in /home/lf/Pappi. Note that /usr/lib 
   is implicit.

   To check that all the libraries are bound correctly, issue the
   command: 

	ldd Pappi

   Note: All of the above libraries except for the last two are
	 supplied as part of the standard Sun distribution. Consult
	 your system administrator if they are not.

   	 The sskpg and Xpm libraries may or may not already be present
	 on your local system. They are supplied as part of this
	 distribution and can be found in the lib subdirectory.

   Note: If you're running dPappi, libXm1_1 and libXt1_1 are also
	 necessary. Use:

	 setenv LD_LIBRARY_PATH 
	 /usr/openwin:/home/lf/Pappi/lib:/usr/quintus/bin3.1.4/sun4-4

	 for SunOS 4.1.x, and:

	 setenv LD_LIBRARY_PATH 
	 /usr/openwin:/home/lf/Pappi/lib:/usr/quintus/bin3.1.4/sun4-5

	 for Solaris 2.3. Here, in either case we're assuming that
	 Quintus Prolog has been installed in /usr/quintus and PAPPI
	 in /home/lf/Pappi.

5. That's it.


USING THE SYSTEM:

*  Start OpenWindows if you haven't already. 
   (Typically started as /usr/openwin/bin/openwin.)
   Start Pappi (type Pappi).

*  Use the "Demo" button (top right corner) to get a system tour and to
   check that everything is running ok. If the demo completes successfully,
   approx. 5-6 mins, all should be well.

*  For sample data, see the *.xpl files. (The "Examples" button in the top
   left corner provides one way to access these files.) For example, l&u.xpl 
   contain almost all of the sentences analyzed in chapters 1,2,3,4 and 6 
   in  "A Course in GB Syntax" by Lasnik & Uriagereka. 

   [If you're unfamiliar with classic GB analysis, it will be much more
    rewarding to use the parser in tandem with a copy of the text.]

*  Hint: If you're unfamiliar with the default OpenWindows behaviour, check 
   the Sun OpenWindows documentation. Here are some simple hints:

   Mouse buttons work as follows: 
	Left   means "select" (single/double or triple clicking).
        Middle means "adjust selection" 
	Right  means "bring up menu"
    NB. Left on a menu button means "select default menu item"

   Menus:
	Defaults selections are "circled". The default can be altered 
	by the user (use Control "select").

   Scroll bars: Select ...
	Top/bottom anchor means "go to the top/bottom".
	Up/down arrow (wedge) means "scroll up/down by line".
	Rope between elevator and anchor means "scroll by page"
	Center of elevator means "scroll by dragging"
	
*  Interrupting the system: Most time-consuming operations such as parsing
   and GLR machine generation can be aborted by sending a Control-C to the
   terminal window from which Pappi was started (provided Pappi is running
   in the foreground). The system will register the interrupt and provide
   you with the opportunity to abort the current operation at the next
   possible opportunity.


DOCUMENTATION:

A Programming Guide is currently under preparation and will be provided with
the next release.

*  A 33 page introduction titled "Getting Started With Pappi (after Getting
   Pappi Started)" by Tim van der Avoird is included in the doc subdirectory. 

*  Because of the time it would take to run through the Lasnik & Uriagereka
   examples, the doc subdirectory also contains an on-line, readable version
   of the analyses produced by the parser for all of the examples in l&u.xpl.
   This is stored in the file doc/l&u.phf. This file is readable by Pappi.
   Hence, you can use Pappi as a parse tree browser and do things like
   click on nodes to see the associated features.

   doc/l&u.ps is the printable (Postscript) counterpart of doc/l&u.phf.

   CAUTION: Due to the number of examples, this will take several minutes 
	    and a LOT of memory to load.

	    To browse it, you should consider loading it into its own copy
	    of Pappi. (Multiple copies of Pappi can be running at the same
	    time without interference.)

		 	    Example Instructions: 

	1. Type "Pappi -nd" to start a new copy (-nd for no user defaults).
	2. Switch off text wrap in the menu "General Options".
	3. Select the "Load History" command in the "History" menu.

*  For more technical detail and general background, see my Ph.D thesis:

   "Computational Properties of Principle-Based Grammatical Theories"
   MIT Artificial Intelligence Laboratory.
   (Freely available as /pub/users/sandiway/sandiway.thesis.ps.Z 
    by anonymous ftp from ftp.ai.mit.edu.)

*  A guide to the sample theory is currently under preparation and
   will be included with the next release.

DIFFERENT ENVIRONMENTS:

It is strongly recommended that OpenWindows 3.x be used for non-quirky
behaviour. We have done some but not much testing with other combinations.

*  The system, except for the demo will probably work under window managers 
   (e.g. twm) different from the standard OpenLook Window Manager (olwm).

*  Does it run under OpenWindows 2.0? 
   Probably not, I don't know.

*  How about other X servers?  
   Pappi will run on MIT's Xsun server, albeit with some redisplay quirks. 
   Fonts, in particular kanji, may be a problem. 
   (See immediately below.)
   Finally, the demo won't run in automated mode.

*  A Word about Kanji Fonts
   Depending on your system, kanji fonts may be available under
   different names. The command 'xlsfonts' will show what fonts are
   available on your local xserver. To change the kanji font names
   that Pappi uses, look in the init/language_info file. For example:

   -jis-fixed-medium-r-normal--16-150-75-75-c-160-jisx0208.1983-0
   -jis-fixed-medium-r-normal--24-230-75-75-c-240-jisx0208.1983-0

   may be used on vanilla MIT Xsun servers.


Sandiway Fong

10/15/92 (Revised 1/18/92, 5/18/93, 10/17/93, 11/20/93 7/19/94 8/16/94 10/5/94)

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

APPENDIX A: SAMPLE INSTALLATION SESSION

> ftp external.nj.nec.com
Connected to external.nj.nec.com.
220- 
 
 ===============================================================================
 				NOTICE				
 
 Unauthorized users will be prosecuted. This system is being monitored.
 
 ===============================================================================
 
220 external FTP server ready.
Name (external.nj.nec.com:sandiway): anonymous
331 Guest login ok, type your name as password.
Password:
230 Guest login ok, access restrictions apply.
ftp> cd pub/sandiway
250 CWD command successful.
ftp> bin
200 Type set to I.
ftp> get Pappi-2.0.tar.Z
200 PORT command successful.
150 Opening BINARY mode data connection for 'Pappi-2.0.tar.Z' (13800503 bytes).
226 Transfer complete.
local: Pappi-2.0.tar.Z remote: Pappi-2.0.tar.Z
13800503 bytes received in 2.1e+02 seconds (63 Kbytes/s)
ftp> quit
221 Goodbye.
> zcat Pappi-2.0.tar.Z | tar xvf -
x pappi/bin/USEnglish.qof, 232000 bytes, 454 tape blocks
x pappi/bin/Japanese.qof, 232000 bytes, 454 tape blocks
x pappi/bin/Dutch.qof, 232000 bytes, 454 tape blocks
x pappi/bin/French.qof, 232000 bytes, 454 tape blocks
x pappi/bin/German.qof, 232000 bytes, 454 tape blocks
x pappi/bin/Spanish.qof, 232000 bytes, 454 tape blocks
x pappi/bin/sun4/dPappi, 3670016 bytes, 7168 tape blocks
x pappi/bin/sun4/pappiSlave, 1720320 bytes, 3360 tape blocks
x pappi/bin/sun4/Pappi, 3473408 bytes, 6784 tape blocks
x pappi/bin/sun5/dPappi, 3221992 bytes, 6293 tape blocks
x pappi/bin/sun5/pappiSlave, 1783492 bytes, 3484 tape blocks
x pappi/bin/sun5/Pappi, 3005408 bytes, 5870 tape blocks
x pappi/lib/sun4/libsspkg.so.1.0, 565248 bytes, 1104 tape blocks
x pappi/lib/sun4/libXpm.so.4.1, 65536 bytes, 128 tape blocks
x pappi/lib/sun5/libsspkg.so.1, 307428 bytes, 601 tape blocks
x pappi/lib/sun5/libXpm.so.4.1, 75540 bytes, 148 tape blocks
x pappi/init/fontlist, 2092 bytes, 5 tape blocks
x pappi/init/language_info, 866 bytes, 2 tape blocks
x pappi/init/print_preamble.ps, 5598 bytes, 11 tape blocks
x pappi/init/user_defaults.sample, 1413 bytes, 3 tape blocks
x pappi/init/hosts.sample, 32 bytes, 1 tape blocks
x pappi/init/user_defaults, 2169 bytes, 5 tape blocks
x pappi/init/user_defaults.~1~, 2169 bytes, 5 tape blocks
x pappi/init/hosts, 14 bytes, 1 tape blocks
x pappi/init/user_defaults.~2~, 2166 bytes, 5 tape blocks
x pappi/bitmap/demo_1st_reading_down.xpm, 26114 bytes, 52 tape blocks
x pappi/bitmap/demo_1st_reading_right.xpm, 25979 bytes, 51 tape blocks
x pappi/bitmap/demo_2nd_reading_down.xpm, 26118 bytes, 52 tape blocks
x pappi/bitmap/demo_2nd_reading_right.xpm, 25975 bytes, 51 tape blocks
x pappi/bitmap/demo_click_node_left.xpm, 25981 bytes, 51 tape blocks
x pappi/bitmap/demo_click_to_switch.xpm, 25982 bytes, 51 tape blocks
x pappi/bitmap/demo_flag_changed_right.xpm, 26013 bytes, 51 tape blocks
x pappi/bitmap/demo_flag_right.xpm, 26005 bytes, 51 tape blocks
x pappi/bitmap/demo_input_up.xpm, 26275 bytes, 52 tape blocks
x pappi/bitmap/demo_language_down.xpm, 26119 bytes, 52 tape blocks
x pappi/bitmap/demo_language_left.xpm, 25979 bytes, 51 tape blocks
x pappi/bitmap/demo_language_right.xpm, 25980 bytes, 51 tape blocks
x pappi/bitmap/demo_lower_number_up.xpm, 26282 bytes, 52 tape blocks
x pappi/bitmap/demo_no_parse_left.xpm, 25979 bytes, 51 tape blocks
x pappi/bitmap/demo_operations_right.xpm, 25986 bytes, 51 tape blocks
x pappi/bitmap/demo_parse_found_left.xpm, 25982 bytes, 51 tape blocks
x pappi/bitmap/demo_parser_down.xpm, 26117 bytes, 52 tape blocks
x pappi/bitmap/demo_parser_right.xpm, 25978 bytes, 51 tape blocks
x pappi/bitmap/demo_principles_right.xpm, 26011 bytes, 51 tape blocks
x pappi/bitmap/demo_run_down.xpm, 26114 bytes, 52 tape blocks
x pappi/bitmap/demo_run_left.xpm, 25974 bytes, 51 tape blocks
x pappi/bitmap/demo_run_right.xpm, 25975 bytes, 51 tape blocks
x pappi/bitmap/demo_select_up.xpm, 26247 bytes, 52 tape blocks
x pappi/bitmap/demo_switched_off.xpm, 25978 bytes, 51 tape blocks
x pappi/bitmap/demo_theory_down.xpm, 26124 bytes, 52 tape blocks
x pappi/bitmap/demo_theory_right.xpm, 25982 bytes, 51 tape blocks
x pappi/bitmap/demo_upper_number_down.xpm, 26284 bytes, 52 tape blocks
x pappi/bitmap/flag_auto.xpm, 2727 bytes, 6 tape blocks
x pappi/bitmap/flag_britain.xpm, 2612 bytes, 6 tape blocks
x pappi/bitmap/flag_deutschland.xpm, 2669 bytes, 6 tape blocks
x pappi/bitmap/flag_france.xpm, 2611 bytes, 6 tape blocks
x pappi/bitmap/flag_holland.xpm, 2665 bytes, 6 tape blocks
x pappi/bitmap/flag_italia.xpm, 2611 bytes, 6 tape blocks
x pappi/bitmap/flag_jamaheriya.xpm, 2573 bytes, 6 tape blocks
x pappi/bitmap/flag_nippon.xpm, 2635 bytes, 6 tape blocks
x pappi/bitmap/flag_nolang.xpm, 2606 bytes, 6 tape blocks
x pappi/bitmap/flag_usa.xpm, 2661 bytes, 6 tape blocks
x pappi/bitmap/flag_xl_auto.xpm, 9918 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_britain.xpm, 9790 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_deutschland.xpm, 9847 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_france.xpm, 9789 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_holland.xpm, 9843 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_italia.xpm, 9789 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_jamaheriya.xpm, 9751 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_nippon.xpm, 9813 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_nolang.xpm, 9784 bytes, 20 tape blocks
x pappi/bitmap/flag_xl_usa.xpm, 9839 bytes, 20 tape blocks
x pappi/bitmap/flag_espagna.xpm, 2627 bytes, 6 tape blocks
x pappi/bitmap/flag_xl_espagna.xpm, 9805 bytes, 20 tape blocks
x pappi/bitmap/demo_check_mark_black, 1259 bytes, 3 tape blocks
x pappi/doc/GSWP.ps, 1971569 bytes, 3851 tape blocks
x pappi/doc/l&u.phf, 1972817 bytes, 3854 tape blocks
x pappi/doc/l&u.ps, 768037 bytes, 1501 tape blocks
x pappi/doc/posters/README, 464 bytes, 1 tape blocks
x pappi/doc/posters/dutch.ps.Z, 239669 bytes, 469 tape blocks
x pappi/doc/posters/english.ps.Z, 184911 bytes, 362 tape blocks
x pappi/doc/posters/french.ps.Z, 228873 bytes, 448 tape blocks
x pappi/doc/posters/intro-1.ps.Z, 76089 bytes, 149 tape blocks
x pappi/doc/posters/intro-2.ps.Z, 185781 bytes, 363 tape blocks
x pappi/doc/posters/japanese.ps.Z, 236685 bytes, 463 tape blocks
x pappi/help/Trees.info, 2470 bytes, 5 tape blocks
x pappi/help/Special.info, 486 bytes, 1 tape blocks
x pappi/README, 21071 bytes, 42 tape blocks
x pappi/opDecls.pl, 4185 bytes, 9 tape blocks
x pappi/macros.pl, 3794 bytes, 8 tape blocks
x pappi/principles11.pl, 68024 bytes, 133 tape blocks
x pappi/xbar.pl, 7193 bytes, 15 tape blocks
x pappi/lex.pl, 2371 bytes, 5 tape blocks
x pappi/lexiconUSEnglish.pl, 34761 bytes, 68 tape blocks
x pappi/parametersUSEnglish.pl, 899 bytes, 2 tape blocks
x pappi/peripheryUSEnglish.pl, 4732 bytes, 10 tape blocks
x pappi/commentsUSEnglish.pl, 71844 bytes, 141 tape blocks
x pappi/transitionUSEnglish.pl, 78444 bytes, 154 tape blocks
x pappi/igoalsUSEnglish.pl, 3135 bytes, 7 tape blocks
x pappi/actionUSEnglish.pl, 279288 bytes, 546 tape blocks
x pappi/USEnglish.glr, 18 bytes, 1 tape blocks
x pappi/English.dbf, 7220 bytes, 15 tape blocks
x pappi/lexiconJapanese.pl, 19313 bytes, 38 tape blocks
x pappi/parametersJapanese.pl, 998 bytes, 2 tape blocks
x pappi/peripheryJapanese.pl, 7237 bytes, 15 tape blocks
x pappi/commentsJapanese.pl, 454184 bytes, 888 tape blocks
x pappi/h.xpl, 1366 bytes, 3 tape blocks
x pappi/transitionJapanese.pl, 302424 bytes, 591 tape blocks
x pappi/igoalsJapanese.pl, 2161 bytes, 5 tape blocks
x pappi/actionJapanese.pl, 1627620 bytes, 3179 tape blocks
x pappi/Japanese.glr, 18 bytes, 1 tape blocks
x pappi/Japanese.dbf, 6842 bytes, 14 tape blocks
x pappi/lexiconDutch.pl, 34297 bytes, 67 tape blocks
x pappi/parametersDutch.pl, 1054 bytes, 3 tape blocks
x pappi/peripheryDutch.pl, 5011 bytes, 10 tape blocks
x pappi/commentsDutch.pl, 127944 bytes, 250 tape blocks
x pappi/transitionDutch.pl, 95034 bytes, 186 tape blocks
x pappi/igoalsDutch.pl, 2234 bytes, 5 tape blocks
x pappi/actionDutch.pl, 543906 bytes, 1063 tape blocks
x pappi/Dutch.glr, 0 bytes, 0 tape blocks
x pappi/Dutch.dbf, 6300 bytes, 13 tape blocks
x pappi/lexiconFrench.pl, 85365 bytes, 167 tape blocks
x pappi/parametersFrench.pl, 978 bytes, 2 tape blocks
x pappi/peripheryFrench.pl, 7578 bytes, 15 tape blocks
x pappi/commentsFrench.pl, 70609 bytes, 138 tape blocks
x pappi/transitionFrench.pl, 79645 bytes, 156 tape blocks
x pappi/igoalsFrench.pl, 1792 bytes, 4 tape blocks
x pappi/actionFrench.pl, 280415 bytes, 548 tape blocks
x pappi/French.glr, 0 bytes, 0 tape blocks
x pappi/French.dbf, 11377 bytes, 23 tape blocks
x pappi/e.xpl, 2920 bytes, 6 tape blocks
x pappi/lexiconSpanish.pl, 68059 bytes, 133 tape blocks
x pappi/parametersSpanish.pl, 945 bytes, 2 tape blocks
x pappi/peripherySpanish.pl, 5075 bytes, 10 tape blocks
x pappi/commentsSpanish.pl, 96932 bytes, 190 tape blocks
x pappi/transitionSpanish.pl, 72725 bytes, 143 tape blocks
x pappi/igoalsSpanish.pl, 2161 bytes, 5 tape blocks
x pappi/actionSpanish.pl, 388589 bytes, 759 tape blocks
x pappi/Spanish.glr, 18 bytes, 1 tape blocks
x pappi/Spanish.dbf, 5221 bytes, 11 tape blocks
x pappi/lexiconGerman.pl, 35558 bytes, 70 tape blocks
x pappi/parametersGerman.pl, 994 bytes, 2 tape blocks
x pappi/peripheryGerman.pl, 7205 bytes, 15 tape blocks
x pappi/commentsGerman.pl, 180625 bytes, 353 tape blocks
x pappi/transitionGerman.pl, 165351 bytes, 323 tape blocks
x pappi/igoalsGerman.pl, 2195 bytes, 5 tape blocks
x pappi/actionGerman.pl, 781685 bytes, 1527 tape blocks
x pappi/German.glr, 18 bytes, 1 tape blocks
x pappi/German.dbf, 7085 bytes, 14 tape blocks
x pappi/i0parser.pl, 1592 bytes, 4 tape blocks
x pappi/i4parser.pl, 1471 bytes, 3 tape blocks
x pappi/i5parser.pl, 1448 bytes, 3 tape blocks
x pappi/j4parser.pl, 1447 bytes, 3 tape blocks
x pappi/j5parser.pl, 1424 bytes, 3 tape blocks
x pappi/m5parser.pl, 1576 bytes, 4 tape blocks
x pappi/t5parser.pl, 1594 bytes, 4 tape blocks
x pappi/ts5parser.pl, 1637 bytes, 4 tape blocks
x pappi/tc5parser.pl, 1718 bytes, 4 tape blocks
x pappi/tfc5parser.pl, 1917 bytes, 4 tape blocks
x pappi/p5parser.pl, 1757 bytes, 4 tape blocks
x pappi/m52parser.pl, 1583 bytes, 4 tape blocks
x pappi/t52parser.pl, 1601 bytes, 4 tape blocks
x pappi/ts52parser.pl, 1644 bytes, 4 tape blocks
x pappi/silencer.pl, 626 bytes, 2 tape blocks
x pappi/loadControl.pl, 45 bytes, 1 tape blocks
x pappi/glrControl.pl, 280 bytes, 1 tape blocks
x pappi/interleaveControl.pl, 65 bytes, 1 tape blocks
x pappi/l&s.xpl, 1674 bytes, 4 tape blocks
x pappi/l&u.xpl, 18579 bytes, 37 tape blocks
x pappi/saito.xpl, 4555 bytes, 9 tape blocks
x pappi/d.xpl, 2635 bytes, 6 tape blocks
x pappi/german.xpl, 5025 bytes, 10 tape blocks
x pappi/FrExamples.xpl, 8564 bytes, 17 tape blocks
x pappi/USEnglishGLR.pl, 174 bytes, 1 tape blocks
x pappi/JapaneseGLR.pl, 169 bytes, 1 tape blocks
x pappi/DutchGLR.pl, 154 bytes, 1 tape blocks
x pappi/FrenchGLR.pl, 159 bytes, 1 tape blocks
x pappi/GermanGLR.pl, 159 bytes, 1 tape blocks
x pappi/SpanishGLR.pl, 164 bytes, 1 tape blocks
x pappi/Makefile, 2621 bytes, 6 tape blocks
x pappi/Configure, 908 bytes, 2 tape blocks
56.8u 21.8s 1:31.44 86.0% 0+222k 63+1308io 7pf+0w
> cd pappi
> make
Assuming SunOS 4.1.x...
qpc -c -i macros lexiconUSEnglish.pl
% /home/jp/pappi/lexiconUSEnglish.pl: lexiconUSEnglish.qof
  qpc -c -i macros parametersUSEnglish.pl
% /home/jp/pappi/parametersUSEnglish.pl: parametersUSEnglish.qof
qpc -c -i macros peripheryUSEnglish.pl
% /home/jp/pappi/peripheryUSEnglish.pl: peripheryUSEnglish.qof
qpc -c -i macros transitionUSEnglish.pl
% /home/jp/pappi/transitionUSEnglish.pl: transitionUSEnglish.qof
qpc -c -i macros igoalsUSEnglish.pl
% /home/jp/pappi/igoalsUSEnglish.pl: igoalsUSEnglish.qof
* Singleton variables, clause 1 of hm6vv/4: F
! Approximate line: 125, file: '/home/jp/pappi/igoalsUSEnglish.pl'
qpc -c -i macros actionUSEnglish.pl
% /home/jp/pappi/actionUSEnglish.pl: actionUSEnglish.qof
qpc -c -i macros commentsUSEnglish.pl
% /home/jp/pappi/commentsUSEnglish.pl: commentsUSEnglish.qof
qpc -c -i macros lexiconJapanese.pl
% /home/jp/pappi/lexiconJapanese.pl: lexiconJapanese.qof
qpc -c -i macros parametersJapanese.pl
% /home/jp/pappi/parametersJapanese.pl: parametersJapanese.qof
qpc -c -i macros peripheryJapanese.pl
% /home/jp/pappi/peripheryJapanese.pl: peripheryJapanese.qof
qpc -c -i macros transitionJapanese.pl
% /home/jp/pappi/transitionJapanese.pl: transitionJapanese.qof
qpc -c -i macros igoalsJapanese.pl
% /home/jp/pappi/igoalsJapanese.pl: igoalsJapanese.qof
qpc -c -i macros actionJapanese.pl
% /home/jp/pappi/actionJapanese.pl: actionJapanese.qof
qpc -c -i macros commentsJapanese.pl
% /home/jp/pappi/commentsJapanese.pl: commentsJapanese.qof
qpc -c -i macros lexiconDutch.pl
% /home/jp/pappi/lexiconDutch.pl: lexiconDutch.qof
qpc -c -i macros parametersDutch.pl
% /home/jp/pappi/parametersDutch.pl: parametersDutch.qof
qpc -c -i macros peripheryDutch.pl
% /home/jp/pappi/peripheryDutch.pl: peripheryDutch.qof
qpc -c -i macros transitionDutch.pl
% /home/jp/pappi/transitionDutch.pl: transitionDutch.qof
qpc -c -i macros igoalsDutch.pl
% /home/jp/pappi/igoalsDutch.pl: igoalsDutch.qof
* Singleton variables, clause 1 of hm1cv/4: H
! Approximate line: 65, file: '/home/jp/pappi/igoalsDutch.pl'
qpc -c -i macros actionDutch.pl
% /home/jp/pappi/actionDutch.pl: actionDutch.qof
qpc -c -i macros commentsDutch.pl
% /home/jp/pappi/commentsDutch.pl: commentsDutch.qof
qpc -c -i macros lexiconFrench.pl
% /home/jp/pappi/lexiconFrench.pl: lexiconFrench.qof
qpc -c -i macros parametersFrench.pl
% /home/jp/pappi/parametersFrench.pl: parametersFrench.qof
qpc -c -i macros peripheryFrench.pl
% /home/jp/pappi/peripheryFrench.pl: peripheryFrench.qof
qpc -c -i macros transitionFrench.pl
% /home/jp/pappi/transitionFrench.pl: transitionFrench.qof
qpc -c -i macros igoalsFrench.pl
% /home/jp/pappi/igoalsFrench.pl: igoalsFrench.qof
qpc -c -i macros actionFrench.pl
% /home/jp/pappi/actionFrench.pl: actionFrench.qof
qpc -c -i macros commentsFrench.pl
% /home/jp/pappi/commentsFrench.pl: commentsFrench.qof
qpc -c -i macros lexiconSpanish.pl
% /home/jp/pappi/lexiconSpanish.pl: lexiconSpanish.qof
qpc -c -i macros parametersSpanish.pl
% /home/jp/pappi/parametersSpanish.pl: parametersSpanish.qof
qpc -c -i macros peripherySpanish.pl
% /home/jp/pappi/peripherySpanish.pl: peripherySpanish.qof
qpc -c -i macros transitionSpanish.pl
% /home/jp/pappi/transitionSpanish.pl: transitionSpanish.qof
qpc -c -i macros igoalsSpanish.pl
% /home/jp/pappi/igoalsSpanish.pl: igoalsSpanish.qof
* Singleton variables, clause 1 of hm5vv/4: F
! Approximate line: 95, file: '/home/jp/pappi/igoalsSpanish.pl'
qpc -c -i macros actionSpanish.pl
% /home/jp/pappi/actionSpanish.pl: actionSpanish.qof
qpc -c -i macros commentsSpanish.pl
% /home/jp/pappi/commentsSpanish.pl: commentsSpanish.qof
qpc -c -i macros lexiconGerman.pl
% /home/jp/pappi/lexiconGerman.pl: lexiconGerman.qof
* Clauses for lex/5 are not together in the source file
! Approximate line: 513, file: '/home/jp/pappi/lexiconGerman.pl'
* Clauses for lex/4 are not together in the source file
! Approximate line: 514, file: '/home/jp/pappi/lexiconGerman.pl'
qpc -c -i macros parametersGerman.pl
% /home/jp/pappi/parametersGerman.pl: parametersGerman.qof
qpc -c -i macros peripheryGerman.pl
% /home/jp/pappi/peripheryGerman.pl: peripheryGerman.qof
qpc -c -i macros transitionGerman.pl
% /home/jp/pappi/transitionGerman.pl: transitionGerman.qof
qpc -c -i macros igoalsGerman.pl
% /home/jp/pappi/igoalsGerman.pl: igoalsGerman.qof
* Singleton variables, clause 1 of hm1cv/4: H
! Approximate line: 64, file: '/home/jp/pappi/igoalsGerman.pl'
* Singleton variables, clause 1 of hm5vv/5: F
! Approximate line: 97, file: '/home/jp/pappi/igoalsGerman.pl'
-qpc -c -i macros actionGerman.pl
% /home/jp/pappi/actionGerman.pl: actionGerman.qof
qpc -c -i macros commentsGerman.pl
% /home/jp/pappi/commentsGerman.pl: commentsGerman.qof
qpc -c -i macros principles11.pl
% /home/jp/pappi/principles11.pl: principles11.qof
* Clauses for parser_operation/2 are not together in the source file
! Approximate line: 188, file: '/home/jp/pappi/principles11.pl'
* Clauses for in_all_configurations/2 are not together in the source file
! Approximate line: 197, file: '/home/jp/pappi/principles11.pl'
* Clauses for each/2 are not together in the source file
! Approximate line: 916, file: '/home/jp/pappi/principles11.pl'
* Clauses for cases/2 are not together in the source file
! Approximate line: 1032, file: '/home/jp/pappi/principles11.pl'
* Clauses for top/2 are not together in the source file
! Approximate line: 1245, file: '/home/jp/pappi/principles11.pl'
* Clauses for smallest_configuration/2 are not together in the source file
! Approximate line: 1406, file: '/home/jp/pappi/principles11.pl'
* Clauses for those/2 are not together in the source file
! Approximate line: 1982, file: '/home/jp/pappi/principles11.pl'
* Clauses for collect_all_configurations/2 are not together in the source file
! Approximate line: 2016, file: '/home/jp/pappi/principles11.pl'
qpc -c -i macros xbar.pl
% /home/jp/pappi/xbar.pl: xbar.qof
qpc -c -i macros lex.pl
% /home/jp/pappi/lex.pl: lex.qof
rm Pappi dPappi pappiSlave \
    lib/libsspkg.so.1.0 lib/libsspkg.so.1 lib/libXpm.so.4.1
rm: Pappi: No such file or directory
rm: dPappi: No such file or directory
rm: pappiSlave: No such file or directory
rm: lib/libsspkg.so.1.0: No such file or directory
rm: lib/libsspkg.so.1: No such file or directory
rm: lib/libXpm.so.4.1: No such file or directory
*** Error code 1 (ignored)
ln -s bin/sun4/Pappi Pappi
ln -s bin/sun4/dPappi dPappi
ln -s bin/sun4/pappiSlave pappiSlave
ln -s sun4/libsspkg.so.1.0 lib/libsspkg.so.1.0
ln -s sun4/libXpm.so.4.1 lib/libXpm.so.4.1
> Configure /home/lf/quintus-3.1.4
Quintus Prolog 3.1.4
 Add-Ons :
 Runtime Path :/home/lf/quintus-3.1.4/bin3.1.4/sun4-4
 Quintus Home :/home/lf/quintus-3.1.4
 Host Directory :/sun4-4
 Banner :Sun-4, SunOS 4.1
> Pappi
Please wait. Loading defaults...
(System is up and running)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

APPENDIX B: CUSTOMIZATION

*  The startup and the various option settings reachable by the via the
   "Options" menu can be customized by modifying the file init/user_defaults. 
   As shipped, this file causes the system to automatically load
   principles11.pl, language USEnglish and parser j5parser.pl. 

*  The system can either be run directly from the directory in which
   it is installed, or it can be run from a separate working
   directory, say ~/pappi.

   For the latter case, set the environment variable PAPPI_HOME to point
   to the Pappi installation directory. Also, make a symbolic link between
   the local and the Pappi installation bitmap directory. For example:

	cd ~/pappi
	setenv PAPPI_HOME /usr/pappi
	ln -s /usr/pappi/bitmap bitmap

	[Here ~/pappi and /usr/pappi are the local and install 
	 directories, respectively.]

   Several different configurations of Pappi can coexist in this
   manner. For example: 

   1. Local user defaults can be stored in a local init/user_defaults 
      file. At startup, the system will first look in the current 
      directory for init/user_defaults and if present, load that 
      instead of the one in PAPPI_HOME.

   2. Local modifications, e.g. to specific lexicons or principles, 
      can be maintained without replicating all the distributed Prolog
      files. For instance, a lexiconUSEnglish.pl file in the local 
      directory will override the PAPPI_HOME version during startup.

   3. If local modifications include any Prolog code, then copy
      opDecls.pl from the distribution directory into your local 
      PAPPI directory.

*  User defaults can be skipped by using the option -nd (for no user
   defaults). That is, start with "Pappi -nd".

*  Pappi is an XView application. Many XView options, e g. -scale, -bg, -fg,
   etc., will work with Pappi. Consult man xview(1) for details.

*  Pappi makes use of many temporary files during execution. These files
   are stored by default in /tmp. The system will automatically clean up
   these temporary files on normal exit. If the system crashes or has
   to be killed manually, then you should remove them.

   If you are running out of space in /tmp or wish to use a different
   temporary file directory, set the environment variable PAPPI_TMP.

*  The "Compile" menu choices operate by invoking qpc. If qpc is not in
   your current path, either change the path or set the environment 
   variable QUINTUS_HOME to point to the Quintus Prolog hierarchy.


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

APPENDIX C: DPAPPI

   dPappi is a version of the PAPPI system that integrates the 
   Quintus Prolog source debugger (QUI) to facilitate user level
   debugging of the Prolog code.

   Documentation for the operation of QUI can be found in the 
   appropriate Quintus documentation (Chapter C in the manual I:
   Programming Environment).

   The following are specific instructions for using dPappi in
   conjunction with QUI:

*  Under Solaris 2.3, in addition to the system libraries described
   earlier, it will also be necessary to augment the LD_LIBRARY_PATH
   variable to point to the Quintus Prolog directory containing the
   distributed X-Window libraries for Xm and Xt. (This modification is
   not necessary on SunOS 4.1.x.) For example, if Quintus Prolog 
   version 3.1.4 in installed in /opt/quintus, then:

	setenv LD_LIBRARY_PATH /opt/quintus/bin3.1.4/sun4-5:/usr/openwin/lib
   
   Note: Use the following command to check that the libraries
   are correctly bound:

	ldd dPappi

*  To use the debugger, follow these sample instructions:

	1. Turn on Tracing from the QUI Debug menu.
	   (The Quintus Debugger window will pop up.)

	2. Type in a sentence in the PAPPI input window and hit Run.

	3. QUI will stop in the Quintus Debugger window and display:

		=> callGoal(j5parser([....])).

	4. Switch from Tracing to Debug in the QUI Debug Menu.

	5. Select Open... from the File menu in the Quintus Debugger
	   window. After a few seconds, hit the Front key on the Sun
	   keyboard. A file dialogue box should appear. Load in the
	   file you wish to debug.

	6. Put a spypoint on a predicate you are interested in.

	7. Hit the Leap button in the Quintus Debugger window. 
	   QUI will stop and point to the source code when the 
	   spy'd predicate is reached during parsing.

	8. To switch off debugging either:
	   a) Select Nodebug from the Debug menu in the QUI window, or
	   b) Select Quit from the File menu in the Quintus Debugger
	      window.

   Note: Selecting Quit from the QUI window or unpinning the Quintus
	 Debugger window will not only quit Quintus Prolog, but also 
	 quit the entire PAPPI session.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

MULTI-LANGUAGE MODE:

[Doesn't work under SunOS 5.3, core dumps due to memory interaction
between XView and Quintus.]

To have all languages simultaneously available, select Auto Mode from
the Language menu. (Note: it is likely to take several minutes to load
in all the language files.) 

This mode is purely for running sentences, parser development is not
permitted (the Theory and Parser menus will be greyed out). In auto
mode, the system auto-detects the input language and sends the
sentence to the appropriate language parser.  The flag will indicate
the selected language.

To exit multi-language mode: ??? (Not yet implemented)


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

APPENDIX E: KNOWN PROBLEMS

*  Due to a scroll bug, probably attributable to XView or the XNeWS 
   server in SunOS 4.1.x, very infrequently the main output window 
   may contain images, e.g. trees, superimposed on one another that
   do not disappear when the window is refreshed.

   The workaround is simply to first select the top of the history 
   (click on the top anchor) and then the bottom of the history 
   (using the bottom anchor). The output should now be correctly 
   displayed.

   If the problem persists, type Meta-3 in the sentence input area.

   Another possible workaround is to use a different X-Window 
   server.

*  Solaris 2.3 is the preferred OS platform for PAPPI. The user
   interface works signifcantly faster and with fewer bugs than in
   SunOS 4.1.3. Hence, support for running PAPPI under SunOS may
   be dropped in a later release.
