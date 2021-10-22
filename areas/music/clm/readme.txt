    C O M M O N    L I S P    M U S I C

This directory contains the "common lisp music" system.  It is
currently made up of two main parts: a software synthesis and signal
processing package, CL-MUSIC, and a package that makes it relatively
easy to take advantage of the Motorola 56000, CL-MUSIC-56.

In its compressed form (for public distribution) the clm software is
called clm.tar.Z -- ftp ccrma-ftp, login as anonymous, use your email
address as the password, cd pub, binary, get clm.tar.Z, and quit.  Back
at home, uncompress clm.tar.Z, tar xf clm.tar.  This will write out
all the files that make up the clm system into the current directory.
The current version number is in initmus.lisp, along with news about
changes.  (From outside Stanford, ftp ccrma-ftp.stanford.edu).

Basic documentation is in clm.wn (or clm.rtf) and ins.lisp.  You will
need the LOOP macro, normally available with Common Lisp.  I find it
easiest to work entirely in Emacs -- GNU Emacs is available free, has
mouse support on the Next, and lisp can run as an emacs subjob.
makins.lisp tries out many of the instruments -- if you can load
makins, clm is probably happy.

There's a mailing list for clm news: cmdist@ccrma.stanford.edu.  To
get your address added to or removed from this list, send the request
to cmdist-request@ccrma.stanford.edu.  (Common Music and CMN use this
same mailing list).



This software is available to anyone who is interested, free gratis
for nothing, without warranties of any kind.  Send bug reports or
suggestions to bil@ccrma.stanford.edu.



There are currently 3 possible environments for CLM: 

  a NeXT (68000) with Franz Lisp's common lisp (OS 2.1 or 3.0) 
	(lisp versions 2, 3.1, or 4.1)
  a NeXT (68000) with Kyoto common lisp (OS 2.1 or 3.0)
  an SGI Indigo with Franz's Allegro CL 4.1

In addition, you can run the non-56000 version on any machine
with C and common lisp.

At one time we ran on a Mac II with MPW 3.2, Coral's MCL 2.0, and a
Digidesign Sound Accelerator, but I don't have access to such a system
anymore, and have not been able to keep the code up-to-date.  Even
when it worked, the DAC routine was buggy, and attempts to use
Digidesign's Play function caused the machine to crash.



------------------------------------------------------------------------
NeXT:

If you have the DSP memory expansion upgrade on the NeXT, see all.lisp
-- you want to explicitly tell clm that you have that memory by adding
the :dsp32K identifier to the *features* list, and changing the
address offset in yoffset.h to 16384.


---- on a (68000-based) NeXT with Franz Allegro CL (3.1 or 4.1)

To make clm, put the correct pathname for your lisp image in clm-make
and run it (i.e clm-make in a terminal) (it will take a long time --
see the README file in the cm release (Common Music by Rick Taube,
cm.tar.Z) for full details (cm/build/README).  Currently clm-make dies
with

"Error (from ERROR): eof encountered on input stream #<synonym stream for *TERMINAL-IO* @ #x30ee61>
; Auto-exit"

but this is not a real error -- to run clm after clm-make has done
its job, start up lisp and load all.lisp.


If you are not running a 3.0 NeXT, comment out the line in all.lisp

#+NeXT (pushnew ':NeXT-3.0 *features*)

The libraries have different names in 2.1 and 3.0, so the foreign 
function loaders need to know which system they're running under.
If you have ACL 3.1.20 that ran on NeXT 2.1, and want it to run on
NeXT 3.0, follow the directions in the file ACL3.1-on-NeXT3.0.


We support Ariel's QP board -- just plug any number of them into any
available slots, follow Ariel's instructions on installing slot
drivers and so on, and the rest should be automatic.  If possible get
1Mword of DRAM; the SRAMs are less vital and can be 16K without any
loss.  If you're running a 2.1 NeXT (not 3.0), make the three changes
to qp.c to fix up differences between the 2.1 and 3.0 header file
pathnames.


The standard version (used in clm-make) runs on NeXT system 2.1 (or
3.0) with the upgraded (68040) hardware (either the "cube" or the
"NextStation" -- you really need 16Mbytes RAM or the thing spends all
its time swapping).

To run clm on the Next without the 56000 package, see c56-stubs.lisp.
To run clm in pure lisp (i.e. without any c foreign functions)
requires translation of io.c into the equivalent lisp code, and then
use c56-stubs.


On a Turbo NeXT, delete the word "inline" from the procedure declarations
for put_cpu_tx and get_cpu_rx in next56.c, before compiling next56.c


If you have the 32K DSPRAM upgrade, change the offset in yoffset.h to
16384 and uncomment-out the line in all.lisp that pushes :dsp32K onto
the *features* list.


Here at CCRMA, we run ACL 3.1 on NeXT 3.0 (see the file
ACL3.1-on-NeXT3.0).  It is about twice as fast as ACL 4.1, apparently
because the newer lisp is enormous and spends most of its time
swapping.  ACL 4.1 was twice as slow even on a stand-alone machine
with 32MBytes of RAM!




---- on a (68000-based) NeXT with Kyoto Common Lisp (kcl) (NeXT 2.1 or 3.0)

You need the kcl version 1-605 or (presumably) later (I have also used
version 615).  This is available free:

    Version 1.605 of AKCL (Austin Kyoto Common Lisp) for NeXT is now
    available from rascal.ics.utexas.edu (128.83.138.20) as:
    
            * pub/NeXT-akcl-1-605.tar.Z
    
    It contains change files and machine dependent files to get AKCL run
    on NeXT under OS 2.0 or later. To make the whole system, you also
    need:
    
            * pub/kcl.tar.Z
            * pub/akcl-1-605.tar.Z  (or whatever the highest number is)
    
    Noritake Yonezawa <yone@vcdew25.lsi.tmg.nec.co.jp>


On NeXT 3.0 systems, you'll need to get the dsp library from ccrma --
it's on the pub directory at ccrma-ftp.stanford.edu as libdsp.a.
Also, move next56.c to next56.lc, io.c to io.lc, next.c to next.lc,
and qp.c to qp.lc (to protect them from being overwritten by kcl).

The file akcl.README contains short directions on how to build kcl.
Before running add-defs do the following: in the file
<kcl-home-directory>/akcl/h/NeXT.defs change the line:

    LIBS = -lsys_s -lm -lg

to (NeXT 2.0 and 2.1)

    LIBS = -u libdsp_s -ldsp_s -lsys_s -lm -lg

or to (NeXT 3.0)
 
    LIBS=	-u _SNDReadSoundfile -u _SNDStartPlaying -u _SNDWait -u _SNDFree -u _SNDStop -u _SNDSetHost -u _SNDAcquire -u _snddriver_get_device_parms -u _SNDRelease -u _snddriver_set_device_parms -u _snddriver_get_volume -u _snddriver_set_volume -u _snddriver_set_ramp -u _DSPOpenNoBoot -u _DSPClose -u _valloc -ldsp -lsys_s -lm

  (all one line)

This gets the dsp/dac library loaded.  I also change the process size
(BIG_HEAP_SIZE in akcl/h/NeXT.h) to #x2000000, but this may not be
needed. And it will make everyone happier if you change:

#define ADDITIONAL_FEATURES \
	ADD_FEATURE("MACH"); \
	ADD_FEATURE("NeXT"); \
	ADD_FEATURE("MC68040")

to

#define ADDITIONAL_FEATURES \
	ADD_FEATURE("MACH"); \
	ADD_FEATURE("NeXT"); \
	ADD_FEATURE("NEXT"); \
	ADD_FEATURE("MC68040")

(in NeXT.h).

Also, on NeXT 3.0 systems, make the three changes needed in
kcl-c56-c.lisp (search for NeXT 3.0 and follow the directions).
(Or on NeXT 2.1, unmake these changes).


If you want to run CLM and Rick Taube's Common Music from kcl, 
change the LIBS line to:

(NeXT 2.1):

    LIBS=	-u libdsp_s -ldsp_s -u _midi_set_owner -u _midi_get_out_timer_port -u _midi_get_xmit -u _midi_get_recv -u _midi_set_proto -u _midi_set_sys_ignores -u _midi_get_data -u _midi_timer_error -u _port_set_allocate -u _port_set_add -u _timer_start -u _midi_error -u _port_set_deallocate -u _timer_stop -u _timer_set_quantum -u _timer_set -u _timer_quanta_req -u _midi_timer_reply_handler -u _midi_send_cooked_data -u _midi_clear_queue -u _midi_reply_handler -lmidi -lsys_s -lm -lg

(NeXT 3.0):

    LIBS=	-u _SNDReadSoundfile -u _SNDStartPlaying -u _SNDWait -u _SNDFree -u _SNDStop -u _SNDSetHost -u _SNDAcquire -u _snddriver_get_device_parms -u _SNDRelease -u _snddriver_set_device_parms -u _snddriver_get_volume -u _snddriver_set_volume -u _snddriver_set_ramp -u _DSPOpenNoBoot -u _DSPClose -u _valloc -ldsp -u _mutex_try_lock -u _mutex_wait_lock -u _MIDIBecomeOwner -u _MIDIClaimUnit -u _MIDISetClockMode -u _MIDISetClockQuantum -u _MIDISetSystemIgnores -u _MIDIRequestExceptions -u _MIDIGetAvailableQueueSize -u _MIDISetClockTime -u _MIDIStartClock -u _MIDIReleaseOwnership -u _MIDIStopClock -u _MIDIGetClockTime -u _MIDISendData -u _MIDIRequestData -u _MIDIHandleReply -u _MIDIClearQueue -u _cthread_detach -u _port_set_allocate -u _port_set_add -u _port_set_deallocate -u _name_server_port -lsys_s -lm

And for NeXT 3.0, add this line to the ADD_FEATURE list in NeXT.h:

	ADD_FEATURE("NEXT-3.0"); \


Currently, there is one further bug in kcl when using NeXT 3.0 --
In akcl/c/NeXTunixsave.c, the declaration:

  extern struct section *getsectbyname(char *, char *);

causes a fatal compiler error.  The new declaration
(in /NextDeveloper/Headers/bsd/lib.h) is:

  extern const struct section *getsectbyname(
	 const char *segname, 
	 const char *sectname);


Once kcl is ready to go, fire it up, delete *.o (if any) on the clm
directory, and if you have the 32K DSPRAM upgrade, change the offset
in yoffset.h to 16384 and uncomment-out the line in all.lisp that
pushes :dsp32K onto the *features* list.  Finally, 

(load "all.lisp")


One thing in the akcl instructions that always trips me is the
step

add-defs NeXT <kcl-directory>

by <kcl-directory> they mean the inner kcl directory, not
the outer one.  That is, if you started on /dist/lisp/kcl, and
executed as the first step mkdir kcl, it's the latter directory
they are calling the <kcl-directory>.



------------------------------------------------------------------------
SGI:

on an SGI Iris with Franz Allegro 4.1

The sgi currently has no -G 0 form of /usr/lib/libaudio.a, so:  

1) fire up a shell, cd to the clm source directory and execute the  
following five lines:

	cc io.c -c -cckr -G 0 -O
	cc merge.c -c -cckr -G 0 -O
	cc cmus.c -c -cckr -G 0 -O
	cc sgi.c -c -cckr -G 0 -O
	cc fft.c -c -cckr -G 0 -O

2) next, (re)build lisp with the audio library linked in. cd to Franz  
Lisp's build directory and execute the following statement, with /CLM  
replaced by the appropriate directory for clm sources on your  
machine:

	sh config /CLM/sgi.o /usr/lib/libaudio.a

3) boot the newly rebuilt lisp image and:

	:ld all.lisp

this will compile and load all the sources.



------------------------------------------------------------------------
MAC:

on a Mac II with MPW 3.2, MCL 2.0, and a Sound Accelerator card

First, fix the initial pathname in all.lisp to point to the file
mac-pathnames.lisp.  Then fix the pathnames in mac-pathnames.lisp to
point to the various MPW libraries that are mentioned therein.  Then,
if your Sound Accelerator card is not in slot E, fixup the slot
addresses in the functions DSPOpenNoBoot and getDSPregs in
macintosh56.c.  In the best of all worlds, we'd scan the slots and
find the card automatically, but I'm not enough of a Mac expert to
know how to do that.  Finally, make sure the macros NEXT and MAC in
io.c and merge.c are set correctly -- for a Mac, they should be:

#define NEXT 0
#define MAC 1

Fire up MPW and

C io.c<ENTER>
C macintosh56.c<ENTER>
C merge.c<ENTER>

Now leave MPW, fire up MCL, and load all.lisp (from whatever directory
it happens to be in).  Ignore the various errors -- this compilation
and loading takes about a half hour.  Under the current Mac II OS
(system 6.<something>), clm dies with "out of Finder memory" and the
dac routine seems to be reading garbage.  My hope is that system 7
will be smarter about memory management, so all this effort won't be
wasted.




---- on any machine with C and Common Lisp

To load a non-56000 version, in all.lisp use c56-stubs.lisp in place
of all the files from init56.lisp to env.lisp except sound (that is,
don't load any of the C56 package).  If the lisp is not ACL, KCL, or
MCL, you'll need to write the foreign function interface declarations.




------------------------------------------------------------------------
DEFAULTS

The default sound file names are set in next-io.lisp.  You can either
reset these names to your own favorites, or in your init file:

    (setf default-sound-file-name "test.snd")
    (setf default-reverb-file-name "reverb.snd")

or whatever.

Similarly, the following variables have the following default values:

  sampling-rate  	   (io.lisp)      22.05KHz on Next and SGI, 44.1KHz on Mac
  *clm-array-print-length* (io.lisp)      10
  *available-IO-channels*  (io.lisp)      16
  default-table-size       (mus.lisp)     512
  *clm-max-delay-lines*    (mus.lisp)     256
  *ignore-header-errors*   (next-io.lisp) nil
  *fix-header-errors*      (next-io.lisp) t
  *clm-verbose*            (initmus.lisp) nil
  *clm-safety*		   (run.lisp)     0
  *clm-speed*              (run.lisp)     1
  *sound-player*           (sound.lisp)   nil
  *grab-dac*               (sound.lisp)   t



------------------------------------------------------------------------
BENCHMARKS

Stephen Pope is publishing some benchmarks comparing csound, cmix, and
cmusic, and I ran the same tests in clm.  Here are the numbers
(execution time in seconds) (top set = NeXT, bottom = Sparcstation):

Test               clm    csound   cmix   cmusic    clm with 2 QP's  MusicKit

fm short note:   .75     2.6  	   6.1     6.0        .75             1.7
			 1.3	   4.4     1.4

fm long note:     32     64  	   76      274         35             32
			 49        47      44

fm many notes:    203    344       893     1235        81             60
			 185       245     193

fm long notes:    305	 477       588     1685        110
			 231       323     254

mix many files:   414   1161      3033     1807
			 952       690      660

mix long files:    24     71        82      404
			  49        26      157

Both instruments were extremely simple, so in clm's case it's really
just testing the I/O speeds -- in the numbers given above, I used a
normal clm instrument for the fm case and fasmix for the file
envelope/mix case.  Since fasmix runs on the main processor, the QP's
made no difference.



------------------------------------------------------------------------
FILE PERMISSION BITS

CLM creates the sound files with the permission 666 (in io.c) but each
user has a "umask", often set to 022, which changes the final
permission bits.  This can cause trouble if more than one user is
using a machine because files left in the /zap directory (the default
location as set in next-io.lisp) cannot be overwritten by the next
user.  Strictly speaking, this isn't CLM's fault, but since it's come
up many times, I'll append here the logout hook we use here at ccrma:


The file below, CCRMA.Logout.Hook, describes the dwrite to make it work.

******************************************************************

#!/bin/sh
#
# All machines in cm-next-* have their logouthook set to execute this
# script.  Important: if you modify this file, be VERY CAREFUL.
# Use only absolute pathnames.  [grd & davem 9/8/90]
#
# This file is enabled by doing, as root,
#       dwrite loginwindow LogoutHook /LocalApps/CCRMA.Logout.Hook
#
# clear all the crud in /zap (which is for login session storage only)
if test -d /zap
        then /bin/rm -rf /zap/*
fi
# write "nodbody" into the loggedIn file
host=${host-`/bin/hostname`}
if test -w /dist/People/loggedIn/$host -a -x /dist/adm/writeName
        then /dist/adm/writeName nobody /dist/People/loggedIn/$host
fi
#
# Darken the screen
#
/dist/bin/VidLev -b -p /tmp/VidLev.pid

