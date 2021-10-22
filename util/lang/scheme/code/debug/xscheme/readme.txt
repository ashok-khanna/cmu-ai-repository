This directory contains XScheme release 0.2

XScheme is a graphical Scheme debugger based on STk (Scheme Tk interface)
and was developed for cs169 Software Engineering class of 1994 at
University of California at Berkeley.
STk 2.1b2 was used to develop this software, but it should be also
compatible with the later versions of STk.

The features of this release include:
    * Breakpoints on any subexpression of a closure -- stop evaluation
      before that subexpression is evaluated.  Set break, remove break
      enable/disable break operations can be done both interactively from
      Break point manager window, Expression viewer or scheme prompt, as
      well as from code.

    * Selfevaluating watch expressions, that provide monitoring of arbitrary
      expressions with various scope and evaluation optinos.

    * Abitily to install custom viewers that provide a specialized view at
      any scheme data. These viewers must confirm to a common interface and
      can be attached to any watch expression so the value of that watch
      expression is displayed with this specified viewer.

    * A number of viewer is provided with this release:
	- expression viewer, shows data in textual notation, pretty printed
			     with color coded keywords.
        - Box-n-Pointer Viewer, shows data in Box and Pointer notation, with
			     a cons cell represented as a box with two pointers
			     for car and cdr.
        - Environment Viewer, a specialized viewer to display the current
			     binings of any given environment, and its parent
			     environments.
      
    * Evaluation Monitor: provides display of the location of evaluation when
      a breakpoint occures and displays current local bindings at that point.
      
    * Help system. It provides a set of indexed entries that can be expanded
      easily by loading a new text module and regestering. Help screens can
      use custom fonts, sizes and formatting. No colors are supported yet, but
      can be added with minimum effort.



-----------------------------------------------------------------------------
This software was developed by
RND-SyS:
    Dmitry Serebrennikov
    Nikolay Stolin
    Khang Kim Dao
    Nam Nguyenn
    Mike Rogoff

This software is provided without any waranty and is buggy since it's the
first release. The usual DISCLAMER applies. All copyrights and copylefts found
in the source files included from outside sources apply.
-----------------------------------------------------------------------------

You are free to use or modify this software so long as the above names are
mentioned.

