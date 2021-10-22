This file last updated 11/16/93.

If you are using Dick Waters series & generator package (as described in
CLtL/2) and would like fi:clman manual pages, ftp to
ftp.cs.rochester.edu:/pub/knowlege-tools/

and get file cl-lib-3-41.tar.gz (or later) 

Uncompress (via gunzip - gnu's zip) and untar the file (will go into a
directory cl-lib).  cl-lib/series/series is a manual page directory you can
merge with clman by simply linking that directory into your fi/manual
directory that your clman knows about (installation option; consult with
who installed your emacs and or fi subsystem).

****

Of course, there may be other parts of cl-lib you will find of interest.
:cl-lib is a compilable loadable sysetem (once you load
cl-lib/defsystem), and is compatible with allegro 4.1 and 4.2b

In particular, cl-lib has files that:

extend allegro's defsystem with edit-system and provide example-modules
(loadable but not compilable files); See allegro-stuff.lisp;
more-allegro.lisp

A variety of library functions (see cl-extensions.lisp;
more-extensions.lisp)

An initializations package similar to what was available on MIT lisp
machine descendants.

Some additional compatibility functions wrt processes between allegro
and symbolics (see process.lisp)

re to dfa converter (re-to-dfa.lisp)

A version of lisp-machine resources (puts you in control of memeory
management). See resources.lisp

If you have any problems with these tools, I'd like to hear about it. In
addition there are a variety of pd/freeware tools available in this
directory the I **don't** maintain, but these files should point to the
owner.

Note that we use .fasl2 to designate binaries for 4-2b vs. fasl for 4-1 
binaries.
