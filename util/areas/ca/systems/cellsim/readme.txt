This directory contains files related to Cellsim, the SunView-based
cellular automata simulator.  The current version of Cellsim is 2.5.

If you have questions or problems, contact either
  Chris Langton  or           Dave Hiebeler
   cgl@lanl.gov            hiebeler@think.com

Also, please send one of us a message if you obtain Cellsim for the first
time, so that you will be added to our mailing-list.  This will allow us
to notify you of any future releases or bug fixes.

Files in this archive:

README
  This file, lists files in this directory

cellsim_2.5.announcement
  The announcement of Cellsim 2.5, briefly describing some of the changes
  made since earlier versions, and describing how to obtain Cellsim.

cellsim_2.5.tar.Z
  Compressed tarfile containing Cellsim V2.5.  This has had several bugs
  fixes applied, since V2.5 was first released.  If you get this, you *don't*
  need to get any of the patch files.  This tarfile will always contain the
  most up-to-date Cellsim, with all patches installed.

patch1
  This is a subdirectory, containing patches to fix some bugs in the
  original Cellsim V2.5 distribution.   You only need to get these patches
  if you obtained Cellsim V2.5 before April 8, 1990.  If you obtained Cellsim
  later than that, the patches were already installed.
  The files are as follows:

   2.5fixes.patch.Z
     A context-diff file containing changes to several of the main source-code
     files, to correct several bugs in the original Cellsim V2.5.

   2.5CMfixes.patch.Z
     A context-diff file containing changes to some of the source-code files for
     the CM half of Cellsim.

   2.5fixes.README
     This file has instructions telling you how to apply the bug fixes to
     Cellsim V2.5.

patch2
  This is a subdirectory containing patches to fix a problem that Cellsim
  has with the SunView event-handler/notifier in SunOS 4.1 and newer.  Files
  are as follows:

   4.1_patchfile
     A file to be used with the "patch" program, to modify the "cellscr.c"
     file in Cellsim.

   4.1_cellscr.c
     The "cellscr.c" Cellsim source-file, which has had the above patch
     installed.  This is for those who do not have the "patch" program.
     Simply replace your old cellscr.c with this file (rename this file
     to "cellscr.c"), and recompile Cellsim.  If you've made any local
     changed to your cellscr.c since getting Cellsim V2.5, see the next file.

   4.1_functions
     For those who don't have "patch", and have made any local changes to
     their "cellscr.c", this file contains the new version of the three
     functions that were changed.  You can manually replace the old versions
     of these functions, in your cellscr.c file, with these versions.

   4.1_README
     Announcement of the patch for Cellsim under SunOS 4.1, describing the
     problem and how to use the patch.
