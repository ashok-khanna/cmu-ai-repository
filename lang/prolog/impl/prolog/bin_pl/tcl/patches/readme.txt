                                addinput-3.6a

   This patch for Tk 3.6 implements two new commands for Tk.  They
allow you to associate a callback command with a file id directly from Tcl.
When data is available on the file, the command is executed.  This command
greatly simplifies building multi-process applications under Tk.

   Only a minor for support of non-ANSI compilers has been made since the
addinput-3.4a release.

   This patch is only compatible with Tk 3.6, although it should be easy to
port to newer versions.  The latest version of this patch should be available
from:

     ftp.neosoft.com:~ftp/pub/distrib
or 
     harbor.ecn.purdue.edu:~ftp/pub/tcl/extensions

   The implementation of addinput has been changed so only Tk is patched,
Tcl (and TclX if you are using it) are no longer modified.  No code C beyond
Tk needs to be modified to use these commands.

Please report any bugs or comments to markd@grizzly.com

   The Tk event handling code has been modified to be smart enough look into a
stdio buffer for pending input, so the input files can be buffered.  I have
observed over an order of magnitude performance degradation when unbuffered
files are used, so this change is important.

The commands are:

   addinput ?-read? ?-write? ?-exception? fileid cmd

      Associate cmd with fileid.  If -read is specified, the callback is run
      when the file is ready for input. If -write is specified, the callback
      is run when the file is ready for output.  If -exception is specified,
      the callback is run when an exception occures on fileid.  If no flag
      is specified, then -read is assumed.  The following substitutions are
      performed on cmd.

        %%   Replaced with a single percent.
        %F   Replaced with the fileid.
        %E   Replaced with a list indicating which events occurred.  The list
             will contain one or more of the following strings:
                READ
                WRITE
                EXCEPTION

   removeinput fileid

      Remove the callback from fileid.  This must be done before the file
      is closed.

A file, library/demo/addinput.tcl is provided as a demo/test of these commands.
This program uses a shell script addinput.sh that must be in the directory
that addinput.tcl is run in.


