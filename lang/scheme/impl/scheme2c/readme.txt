This directory contains the recent versions of Scheme->C, a Scheme-to-C
compiler done by Digital Equipment Corporation's Western Research Laboratory.

The compiler compiles Revised**4 Scheme to C that is then compiled by
the native C compiler for the target machine.  This design results in
a portable system that allows either stand-alone Scheme programs or
programs written in both compiled and interpreted Scheme and other
languages.

The Scheme->C system supports the essentials of Revised**4 and many of the
optionals.  Extensions include "expansion passing style" macros, records, a
foreign function call capability, and interfaces to X11's Xlib.  The system
does provide call-with-current-continuation.  Numbers are represented
internally as 30-bit integers (62-bit integers on Alpha AXP), or 64-bit
floating point values.

The system is oriented towards block compilation to generate code
which can run in standalone programs which may include code from
other languages.  While debugging is typically done using the
interpreter, it will never be considered a "Scheme environment".

The compiler is written in Scheme.  Most of the runtime system
(including an interpreter) is written in Scheme.  The generational garbage
collector and a few other things are written in C.  There is a small
(< 100) amount of assembly code.

A research report describing this work can be obtained in either paper or
Postscript forms by sending a message to the WRL document server.  Send a
message to "WRL-Techreports@decwrl.dec.com" with the word "help" in the
subject line to receive detailed instructions.

The Scheme->C interpreter and applications may be run on the following
systems:  Alpha AXP systems with OSF/1, DECstations, VAXen with ULTRIX,
MIPS based SGI systems, PC's running Microsoft Windows 3.1, Apple
Macintosh's running system 7.1, HP 9000/300, HP 9000/700, and Sony News
systems.  The compiler is not currently available on PC's or Macintosh's.

Ports to other systems should be fairly straight-forward as the system was
designed to be portable.  Significant efforts were made in this release to
further isolate the Scheme system from the host operating system.  This
release should be significantly easier to port than earlier releases.

The source files, documentation, and instructions for constructing the system
are found in compressed tar files with names of the form:

	ddmmmyy.tar.Z

where ddmmmyy is the system date.  Patches for ports not supported in the
base system are found in files of the form:

	system_name.patches

As of 07 December 1993, the following files are found in this directory.  The
current release is in:

	15mar93.tar.Z		4th release, supports VAX/ULTRIX, DECstation,
				Alpha AXP OSF/1, Microsoft Windows 3.1,
				Apple Macintosh 7.1, HP 9000/300, HP 9000/700,
				Sony News and SGI Iris systems.
	README			this file

	M88K-15mar93.patches	contributed patches for a Harris Nighthawk (a
			        multiprocessor m88k based computer) running
			        CX/UX (Harris' real-time version of Unix).
				These patches should probably work on any m88k
				machine running Unix (e.g., a DG Aviion).

	LINUX-15mar93.patches	contributed patches for linux.

	MPE02-15mar93.patches	contributed patches for Sun SPARC.  Replaces
				an earlier version, MPE01-15mar93.patches.

	SCO-ODT11-15mar93.patches
				contributed patches for SCO OpenDesktop 1.1.

and previous releases are in:

	01nov91.tar.Z		3rd release, supports VAX/ULTRIX, DECstation,
				and SGI Iris systems.
	386BSD-01nov91.patches	patches for freeware Unix system.
	AMIGA-01nov91.patches	patches for Amiga for the 01nov91 system.
	MCC01-01nov91.patches	patches for Sun3, Sun4, DNx500, DN1000, 386,
				NeXT, and Sony News 3200 systems for the
				01nov91 release
	MCC02-01nov91.patches	corrections/improvements to
				MCC01-01nov91.patches
	HP9000-01nov91.patches	patches for HP9000/700 system
	REC-01nov91.patches	patch to MCC-01nov91.patches to correct
				bug in patch.  Allows MCC-01nov91 to work
				on AT&T SYSV machines.

	28sep90.tar.Z		2nd release
	AMIGA-28sep90.patches   Amiga patches for 28sep90 system
	APOLLO.patches		Apollo patches for 23feb90 system
	MCC-28sep90.patches	patches for Sun3, Sun4, DNx500, DN1000 and 386
				processors for the 28sep90 system
        NeXT+MCC-28sep90.patches
                                patches for NeXT processors for the 28sep90
                                system
	REC-28sep90.patches	patches for Sun4 and 386 processors for the
				28sep90 system
	SPARC-386.patches	SPARC and 386 patches for 23feb90 system
	SONY-28sep90.patches	Sony News 3200 patches for 28sep90 system
	SUN3.patches		SUN 3 patches for 23feb90 system

	23feb90.tar.Z		initial release

This software is copyrighted by Digital Equipment Corporation and may be used
under the following conditions:

/*           Copyright 1989-1993 Digital Equipment Corporation
 *                         All Rights Reserved
 *
 * Permission to use, copy, and modify this software and its documentation is
 * hereby granted only under the following terms and conditions.  Both the
 * above copyright notice and this permission notice must appear in all copies
 * of the software, derivative works or modified versions, and any portions
 * thereof, and both notices must appear in supporting documentation.
 *
 * Users of this software agree to the terms and conditions set forth herein,
 * and hereby grant back to Digital a non-exclusive, unrestricted, royalty-free
 * right and license under any changes, enhancements or extensions made to the
 * core functions of the software, including but not limited to those affording
 * compatibility with other hardware or software environments, but excluding
 * applications which incorporate this software.  Users further agree to use
 * their best efforts to return to Digital any such changes, enhancements or
 * extensions that they make and inform Digital of noteworthy uses of this
 * software.  Correspondence should be provided to Digital at:
 * 
 *                       Director of Licensing
 *                       Western Research Laboratory
 *                       Digital Equipment Corporation
 *                       250 University Avenue
 *                       Palo Alto, California  94301  
 * 
 * This software may be distributed (but not offered for sale or transferred
 * for compensation) to third parties, provided such third parties agree to
 * abide by the terms and conditions of this notice.  
 * 
 * THE SOFTWARE IS PROVIDED "AS IS" AND DIGITAL EQUIPMENT CORP. DISCLAIMS ALL
 * WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS.   IN NO EVENT SHALL DIGITAL EQUIPMENT
 * CORPORATION BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL
 * DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR
 * PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS
 * ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
*/

If you have trouble accessing these files or building the system, send mail to
bartlett@decwrl.dec.com.
