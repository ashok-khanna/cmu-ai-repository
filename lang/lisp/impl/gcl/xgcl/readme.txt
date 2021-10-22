Xgcl software is now available; it provides an interface to
X  windows from GCL (Gnu Common Lisp, formerly Austin Kyoto
Common Lisp or AKCL).

There is a low-level interface to the Xlib routines, and there is
an easy-to-use interface that provides graphics, menus, and mouse
interaction via functions that are called from Lisp.

Xgcl is built on top of GCL, and it is somewhat larger
(e.g. 6.7 MB for Xgcl vs. 4.9 MB for GCL) because it incorporates
Xlib.  To make Xgcl, you must first obtain and make GCL.  The code
was written by Gordon Novak, Hiep Nguyen, and William Schelter.

The file is called xgcl-2.tgz .  Xgcl and GCL can be FTP'd from:
    math.utexas.edu   pub/gcl
    ftp.cli.com       pub/gcl
    cs.utexas.edu     pub/novak/xgcl        (Xgcl file only)

    http://www.cs.utexas.edu/users/novak    (Xgcl file only)

Put the xgcl-2.tgz file in the same directory as gcl-1.1.tgz .
Uncompress it with:      gzip -dc xgcl-2.tgz | tar xvf -
Then see the README in the directory xgcl-2.
