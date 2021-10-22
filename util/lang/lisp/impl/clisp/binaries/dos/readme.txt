This is CLISP, a Common Lisp implementation.


What is LISP?
-------------

LISP is a programming language. It was invented by J. McCarthy in 1959.
There have been many dialects of it, but nowadays LISP has been standardized
and wide-spread due to the industrial standard COMMON LISP. There are
applications in the domains of symbolic knowledge processing (AI), numerical
mathematics (MACLISP yielded numerical code as good as FORTRAN), and
widely used programs like editors (EMACS) and CAD (AUTOCAD).
There is an introduction to the language:

  Sheila Hughes: Lisp. Pitman Publishing Limited, London 1986.
  107 pages.

After a while wou will need the standard text containing the language
definition:

  Guy L. Steele Jr.: Common Lisp - The Language. Digital Press.
  1. edition 1984, 465 pages.
  2. edition 1990, 1032 pages.

LISP is run in an interactive environment. You input forms, and they will be
evaluated at once. Thus you can inspect variables, call functions with given
arguments or define your own functions.


Contents:
---------

It consists of the following files:

      lisp.exe         main program
      lisp_1mb.exe     main program, use this one if you have
                       only 1 or 2 MB of RAM
      lispinit.mem     memory image needed for startup
      clisp.1          manual page in Unix man format
      clisp.man        manual page
      clisp.dvi        manual page in dvi format
      impnotes.txt     implementation notes
      emx-user.doc     emx applications user's guide
      emx-faq.doc      frequently asked questions about emx applications
      delay.exe        auxiliary program for running clisp under Windows
      README           this text
      SUMMARY          short description of CLISP
      ANNOUNCE         announcement
      COPYRIGHT        copyright notice
      GNU-GPL          free software license
      config.lsp       site-dependent configuration

and - to your convenience, if you like reading source -

      *.lsp            the source of lispinit.mem
      *.fas            the same files, already compiled


Hardware requirements:
----------------------

This DOS version of CLISP requires an 80386 (SX or DX) or an 80486 CPU
and at least 1 MB of RAM.


Installation:
-------------

Edit the contents of config.lsp appropriately for your site,
especially the definitions of short-site-name and long-site-name.
You may also want to edit the time zone definition in defs1.lsp.
Then start

         lisp.exe -M lispinit.mem

When the LISP prompt

      > _

appears, type

        (compile-file "config")
        (load "config")

and - in case you modified defs1.lsp -

        (compile-file "defs1")
        (load "defs1")

and then

        (saveinitmem)

to overwrite the file lispinit.mem with your configuration. Then

        (exit)

Then create a directory, and put the executable and the memory image there.
Assuming D:\LIB\LISP :

   mkdir d:\lib\lisp
   copy lisp.exe d:\lib\lisp
   copy lispinit.mem d:\lib\lisp

And create a batch file that starts lisp:

   copy con c:\bat\clisp.bat
   d:\lib\lisp\lisp.exe -M d:\lib\lisp\lispinit.mem %1 %2 %3 %4 %5 %6 %7 %8 %9
   [Ctrl-Z]


Installation under Microsoft Windows:
-------------------------------------

CLISP also runs in the DOS box of Microsoft Windows 3.1.
To achieve this, the following additional steps are necessary:

1. Get and install
     ma2s2.mathematik.uni-karlsruhe.de:/pub/lisp/clisp/dos/clisp-english.zip
   as described above. Then

   copy delay.exe d:\lib\lisp

2. Get and install RSX
     ftp.uni-kl.de:/pub/pc/dos/programming/c/dpmigcc1.zip

3. Create a batch file that starts lisp:

   copy con c:\bat\winclisp.bat
   d:\lib\lisp\delay.exe 1
   c:\rsx\bin\rsx.exe d:\lib\lisp\lisp.exe -M d:\lib\lisp\lispinit.mem %1 %2 %3 %4 %5 %6 %7 %8 %9
   [Ctrl-Z]

   (The paths of course depend on your installation.)

4. Call the PIF editor and input the following:

   Program file name:      c:\bat\winclisp.bat
   Program title:          COMMON LISP
   Program parameters:     
   Start directory:        e:\lisp
   Screen:                 Text
   Memory requirements:    requires:  500      maximum:  640
   EMS memory:             requires:    0      maximum:    0
   XMS memory:             requires: 1024      maximum:   -1
   Display:                        [as you like]
   Quit_closes_window:             [as you like]
   Execution:                      [as you like]
   other_options:                  [as you like]

   (You will probably choose the directory which contains your lisp programs
   as start directory, instead of e:\lisp.)

   Save it under the name WINCLISP.PIF.

5. In the program manager, in a suitable group:

   Menu "File" -> "New" -> "Program", window "program properties".
   Input there:

   Description:            COMMON LISP
   Command line:           winclisp.pif
   Start directory:        e:\lisp
   Key combination:        Ctrl+Alt+Shift+L      [as you like]

Clicking with the mouse on the such created icon or pressing the key
combination given above will now start CLISP.

Remarks:

* If you want to provide command line parameters for CLISP, set the
  "Program parameters" field in the PIF editor to "?". You will then
  always be asked to input arguments for WINCLISP.BAT.

* Cut & Paste in DOS boxes (via menu "Edit" -> "Mark" resp.
  menu "Edit" -> "Insert") inserts an <Enter> at the end. Therefore one
  cannot re-edit a pasted line.

* But the editing facilities mentioned in CLISP.MAN work.

* Bugs in Microsoft Windows and/or RSX can cause system crashes.
  (That's also the reason for DELAY.EXE.) Good luck!


The editor:
-----------

Normally CLISP's ED function calls the editor you specified in config.lsp.
However, after you did

    (load "editor")

it invokes a builtin screen editor. It is a bit Emacs-like: you can evaluate
lisp expressions from within the editor, and the result is pasted into the
editor buffer. Type Alt-H to see the full set of commands.


When you encounter problems:
----------------------------

If clisp doesn't start up at all, check EMX-USER.DOC. lisp.exe is an EMX
application, so everything mentioned there applies to lisp.exe.

After errors, you are in the debugger:

     1. Break> _

You can evaluate forms, as usual. Furthermore:

     Help
               calles help
     Abort     or
     Unwind
               climbs up to next higher input loop
     (show-stack)
               shows the contents of the stack, helpful for debugging

And you can look at the values of the variables of the functions where the
error occurred.

On bigger problems, e.g. register dumps, please send a description of the error
and how to produce it reliably to the authors.


Mailing List:
-------------

There is a mailing list for users of CLISP. It is the proper forum for
questions about CLISP, installation problems, bug reports, application
packages etc.

For information about the list and how to subscribe it, send mail to
listserv@ma2s2.mathematik.uni-karlsruhe.de, with the two lines
          help
          information clisp-list
in the message body.


Acknowledgement:
----------------

If you find CLISP fast and bug-free and you like using it, a gift of $25
(or any amount you like) will be appreciated. Most DOS software costs
something, so you will probably already be used to paying.

If not, feel free to send us suggestions for improvement. Or grab the
source of CLISP, improve it yourself and send us your patches.

We are indebted to
  * Guy L. Steele and many others for the Common Lisp specification.
  * Richard Stallman's GNU project for GCC and the readline library.
  * Eberhard Mattes for EMX.


Authors:
--------

        Bruno Haible                    Michael Stoll
        Augartenstraáe 40               Gallierweg 39
    D - 76137 Karlsruhe             D - 53117 Bonn
        Germany                         Germany

Email: haible@ma2s2.mathematik.uni-karlsruhe.de
