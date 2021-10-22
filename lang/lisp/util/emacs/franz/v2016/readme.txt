Version 2.0.16 of Franz Inc's GNU Emacs-Allegro CL interface is now
available.  This is the first general release since 2.0.11, which was
(and is still) the version shipped with Allegro CL version 4.2.

2.0.16 is both a bugfix and new-feature release, and the significant
changes are listed below.  This version is installed, loaded, and used
the same way as versions since 2.0.9, but instructions are included at
the end of this file along with ftp address.

Those who use the Emacs-Lisp interface heavily are encouraged to try
the new version.

------------------------------
Supported versions.

Version 2.0.16 has been tested with current versions of Emacs.

  Xemacs 19.11
  Lemacs 19.10
  FSF Emacs 19.28
  Mule 2.1
  FSF Emacs 18.59

The interface should also work with recent earlier versions from these
same Emacs.  Obviously, there will from time to time be new releases
of these various development lines.  We expect the interface will work
with new releases, but there is no way to test in advance.

We also believe the interface continues to work with Epoch 3.2 and
4.2, but this is little tested.

In order to track current name conventions, "xemacs" is now used
consistently to refer to both xemacs and lemacs in the names of files
and in the source code itself.

------------------------------
New features.

`Run Bars' -- Users can now have `Run Bars' in the mode line for lisp
source and listener buffers.  One of the words "Run", "Idle", or "GC
appears in the buffer mode line depending on the instantaneous state
of the ACL image.  Run bar support will be built in to future versions
of ACL, but 4.2 users will need to load both a .o and .fasl file into
their images.  This can conveniently be done at build time.  See the
instructions in the file gc-mode-line.cl included with the Emacs-Lisp
interface sources.

FSF Emacs19 menubars -- Menubar support has been added for FSF Emacs
similar to the existing support for Lemacs.  The organization of the
menubar has been cleaned up for both families.

Fontification -- Common Lisp buffers now have a reasonable default
font-lock-keywords specification to support font-lock mode.  This may
be better customized specifically for Common Lisp in some future
release.

------------------------------
Notable bugfixes.

Indentation -- Some longstanding bugs in automatic indentation of
lisp-forms were found and fixed in this release.

Clman now works correctly on byte-order-reversed hosts.

Fontification -- Most problems sending font-lock mode buffer regions
from FSF Emacs to ACL have been fixed.

Xemacs/Lemacs hanging problems -- There is a serious problem between
minibuffer completion and mouse handling under Lemacs 19.8 and later.
If a minibuffer completion function blocks asynchronously (as do many
such Emacs-Lisp functions), any mouse motion will recurse on each
mouse update.  This deep recursion makes Lemacs appear to wedge
(although a _large_ number of keyboard ^G chars will eventually pop
out).  The ACL code now protects against this recursion.

Composer Podium behavior -- Since almost all Composer Podium functions
are available from the Emacs menubar, it is common now to start
Composer without the Podium.  This option has been fixed so that
invoking the two remaining features that unavoidably use CLM (the
"Profiler Options" and the "Composer Options" dialogs) will silently
try to start the CLM server rather than fail in obscure ways.

Lisp interaction buffers by default now use a socket rather than a
pseudo tty to communicate to the ACL process.  This eliminated any
remaining bad behavior with very long input lines and with special
tty-control characters in the input.

There were also numerous minor bugfixes.

------------------------------
Support for Mule.

Version 2.0.16 works with Mule 2.1 and the Japanese-capable version of
"International" ACL, with these exceptions:

   WNN keyboard translation in a lisp listener buffer is incompatible
   with the little-used fi:raw-mode.  Therefore, fi:raw-mode is disabled
   under Mule.

   The emacs lisp-form indenter does not correctly understand non-ASCII
   characters and incorrectly indents lisp forms in both Common Lisp
   source and listener buffers.  This appears to be a problem with
   syntax-table changes that these modes make, and we hope to fix this in
   a future release.

In order to use the Emacs-Lisp interface with Mule, it is necessary to
setup the appropriate coding systems.  The Emacs-Lisp interface
creates new processes dynamically in response to background tasks, so
it is necessary globally to set the default coding system.  This can
best be done by placing the following form in a user's ~/.emacs
initialization file:

   (when (boundp 'mule-version)
     (set-default-process-coding-system *euc-japan* *euc-japan*))

Mule users also need to instruct Emacs the NAME of the host on which
to contact the WNN server.  This can be done with the following form
also in the ~/.emacs file:

   (when (boundp 'mule-version)
     (set-jserver-host-name "NAME"))

Otherwise, remarks concerning FSF Emacs 19 pertain also to Mule.

------------------------------
Known Bugs in 2.0.16.

FSF Emacs 19 redisplay strategies work badly with the way the
Emacs-Lisp interface can asynchronously pop up a
"*background-interaction*" buffer.  There is a tendency the first time
such a buffer is popped up after its creation to be scrolled past the
end of the buffer.  This can appear as though the buffer is still
empty while in fact the contents are scrolled off screen.  (The Lisp
process may even be waiting for input.)  The problem is minor once one
is aware of it, as manual scrolling or even executing a "C-l recenter"
command will make the buffer display appropriately.  We will attempt
to solve this in a future release.

*******************************************************************************
Obtaining the interface:

The sources are available by ftp from ftp.uu.net as the
following files:

   /vendor/franz/emacs/eli-2.0.16.tar.gz (280 Kb)
   /vendor/franz/emacs/clman-4.1-v2.tar.gz (950 Kb)
   /vendor/franz/emacs/clman-4.1-v2-clim2.tar.gz (1306 Kb)

Grab the first file and either the second or third files, as
appropriate.  The uncompressed clman-4.1-v2.tar.gz is 4280 Kb and
clman-4.1-v2-clim2.tar.gz is 6110 Kb.

Note: the .gz means you need gzip (GNU zip) to uncompress these files.
You can get gzip from prep.ai.mit.edu (/pub/gnu/gzip-1.2.3.tar, 778240
bytes).  We use gzip because it produces much better compression.

*******************************************************************************
INSTALLATION

[These instructions last changed significantly with release 2.0.9.]

Unlike versions of the emacs-lisp interface prior to 2.0.9, current
versions of the Emacs-Lisp interface do not require installation in
the lisp/ subdirectory in the emacs library.  The directory created
from unpacking the file eli-2.0.16.tar.gz can be placed anywhere.  (A
subdirectory of the lisp/ directory is an appropriate place, but this
location is not required.)  The following will assume the directory
/usr/local/lib/fi-2.0.16 is chosen as the place you will install this
version of the emacs-lisp interface.  Then you'd do this:

	% cd /usr/local/lib
	% gzip -d < eli-2.0.16.tar.gz | tar xf -

This will extract the files from the .tar.gz file into the directory
/usr/local/lib/fi-2.0.16.  Next, if you want to install the on-line
manual pages then do this:

	% cd fi-2.0.16
	% gzip -d < clman-4.1-v2-clim2.tar.gz | tar xf -

This will extract a few more files.  Next, to build the `clman'
program, type:

	% make clman

This will ensure that everything is up-to-date.  If you don't have gcc
installed, then you'll have to type

	% make CC=cc clman

where `cc' is the name of the C compiler on your system.

Lastly, put the following into your ~/.emacs file:

	(setq load-path (cons "/usr/local/lib/fi-2.0.16" load-path))
	(load "fi-site-init")

This will probably replace the following form in your ~/.emacs if you
were using a version prior to 2.0.9:

	(load "fi/site-init")
