This directory contains the Franz Inc. Allegro CL-GNU Emacs interface.

The versions of emacs now supported are:

	- (FSF) GNU Emacs 18.* and 19.*
	- Epoch 3.2 and 4.2 (not tested with 4.0 or 4.1)
	- lemacs 19.6 and 19.8

The files making up this interface are:

	eli-2.0.11.tar.gz
		The source code to the interface.

	clman-4.1-v2.tar.gz
	clman-4.1-v2-clim2.tar.gz
		Franz Inc's on-line manual, both with and without the
		CLIM 2.0 manual pages.  You should grab only one of
		these two .gz files.

*******************************************************************************
INSTALLATION

Unlike previous versions of the emacs-lisp interface, you don't have
to install this version in the lisp/ subdirectory in the emacs
library.  You can put the directory you create from unpacking the
.tar.gz file anywhere.  The lisp/ directory is a good place for it,
but this location is not required.  So, let's assume you have emacs
installed in /usr/local/lib/emacs.  Then you'd do this:

	% cd /usr/local/lib/emacs/lisp
	% gzip -d < eli-2.0.11.tar.gz | tar xf -

This will extract the directory fi-2.0.11 from the .tar.gz file.  Next,
if you want to install the on-line manual pages then do this:

	% cd fi-2.0.11
	% gzip -d < clman-4.1-v2-clim2.tar.gz | tar xf -

This will extract a new more files.  Next, to build the `clman'
program, type:

	% make clman

This will ensure that everything is up-to-date.  If you don't have gcc
installed, then you'll have to type

	% make CC=cc clman

where `cc' is the name of the C compiler on your system.

Lastly, put the following into your ~/.emacs file:

	(setq load-path (cons "/usr/local/lib/emacs/lisp/fi-2.0.11" load-path))
	(load "fi-site-init")

This will probably replace the following item in your ~/.emacs:

	(load "fi/site-init")

which is the old way the interface was loaded.
