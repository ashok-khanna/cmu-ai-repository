From jaffer@zurich.ai.mit.edu Wed Jan 15 22:26:55 1992
From: jaffer@zurich.ai.mit.edu (Aubrey Jaffer)
Newsgroups: comp.lang.scheme
Subject: Editing Scheme Code
Date: 12 Jan 92 03:56:08 GMT
Distribution: comp
Organization: M.I.T. Artificial Intelligence Lab.

I have placed editor packages for editing scheme code and running
scheme processes in a window in two directories accessible via FTP.

altdorf.ai.mit.edu:archive/scheme-editor-packages/LISP.E
nexus.yorku.ca:pub/oz/scheme/new/LISP.E

is code for lisp-mode in the Epsilon (MSDOS) editor.  It offers
several indentation formats.  Buffers holding files ending in .L,
.LSP, .S, and .SCM are automatically put into lisp-mode.  Support for
tags for Scheme code needs to be written.

altdorf.ai.mit.edu:archive/scheme-editor-packages/cmuscheme.el
altdorf.ai.mit.edu:archive/scheme-editor-packages/comint.el
nexus.yorku.ca:pub/oz/scheme/new/cmuscheme.el
nexus.yorku.ca:pub/oz/scheme/new/comint.el

contain Gnu Emacs code to run any scheme implementation in a buffer.
Emacs comes with xscheme.el which runs only MIT CScheme in a buffer.
