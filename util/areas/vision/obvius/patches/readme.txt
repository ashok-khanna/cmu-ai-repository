Return-Path: <@cs.cmu.edu:heeger@White.Stanford.EDU>
Received: from CS.CMU.EDU by A.GP.CS.CMU.EDU id aa03974; 23 Jul 93 15:38:18 EDT
Received: from White.Stanford.EDU by CS.CMU.EDU id aa11715;
          23 Jul 93 15:37:47 EDT
Received: by white.Stanford.EDU (4.1/inc-1.0)
	id AA13744; Fri, 23 Jul 93 12:35:56 PDT
Date: Fri, 23 Jul 93 12:35:56 PDT
From: heeger@white.Stanford.EDU (David Heeger)
Message-Id: <9307231935.AA13744@white.Stanford.EDU>
To: obvlist@white.stanford.edu
Subject: patches
Reply-To: heeger@white.stanford.edu


There is an obvius/patches-3.0 subdirectory in the ftp directory on
white.  There are now two patch files in that subdirectory.  These are
only needed for the Sun implementation.  Here's the description of the
bug that they fix:

;;; Some users have run into a problem with the control panel when
;;; lv-control-panel.lisp is compiled with the optimizer turned on.
;;; When (run-obvius) is executed, the interior of the control panel
;;; remains black.  Similarly, menus do not show any contents.  The
;;; problem appears to be related to a Make-Instance-Optimizer bug in
;;; Lucid's CLOS implementation, causing slots of CLOS instances not
;;; being properly initialized.

If you copied either of these patches before today, then you got a bad
version and you should get 'em again.

- DH
Return-Path: <@cs.cmu.edu:heeger@White.Stanford.EDU>
Received: from CS.CMU.EDU by A.GP.CS.CMU.EDU id aa06046; 27 Jul 93 13:50:03 EDT
Received: from White.Stanford.EDU by CS.CMU.EDU id aa09722;
          27 Jul 93 13:48:02 EDT
Received: by white.Stanford.EDU (4.1/inc-1.0)
	id AA17329; Tue, 27 Jul 93 10:46:04 PDT
Date: Tue, 27 Jul 93 10:46:04 PDT
From: heeger@white.Stanford.EDU (David Heeger)
Message-Id: <9307271746.AA17329@white.Stanford.EDU>
To: obvlist@white.stanford.edu
Subject: patches
Reply-To: heeger@white.stanford.edu


Some Obvius users have still been experiencing a nasty bug having to
do with Lucid's compiler optimizations.  Since I haven't experienced
this problem here, I am relying on others to figure it out.  If your
Obvius control panel is busted or if you are experiencing other
LispView related problems, then read on...

The two patch files previously released (patch-1.lisp and
patch-2.lisp) are not sufficient, and are not obsolete.  Apparently,
the following fixes (due to hard work by Wilbur@constitution.ucr.edu)
will work:

1) Rebuild LispView completely, with the following lines in the file
"build.lisp":
   ...
   (in-package "USER")

   ;added by Wilbur
   (proclaim '(optimize (compilation-speed 0) (speed 3) (safety 1)))
   (proclaim '(notinline make-instance))
   ...

This was probably the cause for the current OBVIUS "patch-1", which
should not be necessary any longer (though it doesn't hurt).  

2) After rebuilding LispView, also rebuild OBVIUS with the
proclamation:

     (proclaim '(notinline make-instance))

placed in file "lucid-defsys".

