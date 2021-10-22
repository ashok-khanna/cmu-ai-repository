
rplay release 3.1.0

COPYRIGHT:
----------
rplay is now distributed under the GNU General Public License Version 2 and
Copyright (C) 1993 Mark Boyns (boyns@sdsu.edu).  See the COPYING file for 
further rplay copyright information.

This distribution also contains:

* The extended regular expression matching and search library version 0.12
  which is Copyright (C) 1993 Free Software Foundation, Inc.
  See rplayd/regex.[ch] for further information.

* An hsearch replacement which is Copyright (c) August 5, 1993 by Darren Senn.
  The hsearch implementation was written by Darren Senn when he was porting
  rplay to Linux.  Darren's hsearch is now used exclusively since it is more
  portable and it includes a DELETE action which is not supported in the 
  standard hsearch.  Thanks Darren!
  See rplayd/search.[ch] for further information.

DIRECTIONS:
-----------
* See the CHANGES file for documented changes since the last version.

* See the INSTALL file for rplay installation instructions.

* Continue reading this README file for more information.

WHAT IS RPLAY?
--------------
rplay is a sound package that supports both local and remote sound control.
rplay is based on client/server communication using two protocols.  The first
protocol that can be used is RPLAY, which is UDP based and allows sounds to
be played, paused, continued, and stopped.  The second protocol is RPTP
(the Remote Play Transfer Protocol) which is TCP based and allows sounds to be
played, paused, continued, stopped, and transferred.

The rplay system can be described as follows.  An rplay client sends an RPLAY
UDP packet to an rplay server.  The RPLAY packet sent contains the name of a
sound file and various other sound attributes.  The rplay server receives the
RPLAY packet and looks up the sound in a sound file database.  If the sound
is found in the database it will be immediately played on the host the rplay
server is running on.  If the sound is not found in the database the rplay
server can be configured to search other rplay servers for the desired sound
file.   rplay servers communicate using the RPTP protocol.  rplay clients can
also use RPTP to upload sounds to an rplay server.  When an rplay server
receives sounds from a server or a client the sounds are stored in a sound 
cache directory.  The size in bytes of the cache directory can be limited
by the rplay server.  When the cache is full, the rplay server will remove
sounds using a "least recently used" algorithm.  Sound files that are larger
than the maximum cache size will not be accepted by the rplay server.

rplay can be used to easily add sound to any application.  For example,
if you want to play a sound when a button is pressed, all you need to do
is this:

	rplay_local("sound_name.au");

Or, if you want to specify a hostname:

	rplay_host("bozo.sdsu.edu", "sound_name.au");

The above routines along with many others are included in the rplay library.
See the KNOWN RPLAY APPLICATIONS section of this file for a list of applications
that use the rplay library.

Currently the rplay server only supports u-law 8000hz sound files.

CONTENTS:
---------
This rplay release contains the following:

* rplayd - The remote play sound server which supports both the RPLAY and
	   RPTP protocols.

* rplay - A sample RPLAY client.

* rptp - A sample RPTP client.

* librplay - The rplay library which contains support routines for both
	     the RPLAY and RPTP protocols.

* doc - A directory containing rplay documentation and manual pages.

* contrib - A directory containing rplay applications and references to
	    other rplay applications.

KNOWN RPLAY APPLICATIONS:
-------------------------
rplay has been used to add sound to several applications.  Below is a list
of rplay applications that I know about.  If you know of more, please let
me know.

* XTank - A multiplayer X11 game.

* XPilot - A multiplayer gravity war game for X11.

* olvwm - The OPEN LOOK Virtual Window Manager for X11 and OpenWindows.

* Crossfire - A multiplayer graphical arcade and adventure game made for
              the X-Windows environment. 

* XBoing - I have heard that version 1.7 will include rplay support.

Also included with this distribution in the contrib directory are the following
custom rplay applications:

* Jukebox - A program that is very useful for playing multiple sound files. 

* Mailsound - An e-mail notification program that can play different sounds 
	      depending on who the message is from.

PORTING:
--------
rplay is known to work on the following systems:

   * Sun SPARCstations running SunOS 4.1.x

   * Sun SPARCstations running Solaris 2.x

   * HP-UX

   * Linux

   * BSDI/386

   * 386bsd using Steve Haehnichen's soundblaster driver version 1.5

   * SGI Indigo

All rplay requires is an audio device where sounds can be played using the 
write system call.  For example, if you can "cat sound_file > /dev/audio",
then rplay should work.  If your system has an audio device that does not work 
with the above "cat" command, there is still hope but you might need to do some
programming.  You will probably only need to modify rplayd/audio.c.
If you port rplay to another system please send me patches.

OBTAINING SOUND FILES:
----------------------
* Anonymous FTP - Sound files are available via anonymous ftp at sounds.sdsu.edu
                  which currently has about 1.1 gigabytes of sounds.  Login as 
                  ftp or anonymous and use your e-mail address for the password.
		  Remember to use binary mode when ftping sounds.

* Gopher - The sounds.sdsu.edu sound archive is also available via gopher at:

           Name=SDSU Sound Archive (sounds.sdsu.edu)
           Type=1
           Port=71
           Path=
           Host=sounds.sdsu.edu

* RPTP - Sound files can also be obtained using RPTP at sounds.sdsu.edu port
         55556.  You can put sounds.sdsu.edu:55556 in your rplay.servers file
         or use the rptp client.
         
THANKS:
-------
Below is a list of people who have gone above and beyond the rplay call of duty:

* Andrew "Ender" Scherpbier (turtle@sciences.sdsu.edu)

* John "Shorty" Denune (jdenune@sciences.sdsu.edu)

* Raphael Quinet (quinet@montefiore.ulg.ac.be)

* Darren Senn (sinster@scintilla.santa-clara.ca.us)

* Markus Gyger (mgyger@itr.ch)

* Kjetil Wiekhorst J{\o}rgensen (jorgens@pvv.unit.no)

* Richard Lloyd (rkl@csc.liv.ac.uk)

* Mike Halderman (mrh@io.nosc.mil)

* Mike Hoffmann (Mike.Hoffmann@mch.sni.de)

Thank you all for your comments, suggestions, and contributions.

RPLAY SUPPORT:
--------------
Feel free to send any questions or comments to Mark Boyns (boyns@sdsu.edu).

Thank you for using rplay!
