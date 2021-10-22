This directory contains Schematik, a NeXT front-end for the Scheme
programming language.  The Schematik.app file package also contains
MIT Scheme (CScheme), which is the default back-end.  Schematik 1.1.5.4
is packaged with a modified version of MIT Scheme, version 7.1.3.

 Existing users: please see notes later in this file regarding changes.

 European users: please see the note at the end of this file regarding
                 an alternative ftp site closer to you.

 NeXTstep on non-NeXT hardware users: please see the note later in this
                 file regarding your limited hopes of using Schematik.

Fetch in binary (image) mode the file Schematik-1.1.5.4.tar.Z
Then do the following command from a shell:

zcat Schematik-1.1.5.4.tar.Z | tar xf -

and then move Schematik.app into your ~/Apps or /LocalApps directory,
as desired.  You may, of course, also want to drag it into your dock.
Double click and enjoy.  

Please let us know if you are using Schematik by e-mail to
schematik@gac.edu; bug reports are also welcome at that address.

Thanks.
===============
Notes on version 1.1.5.4 (changes since 1.1.5.2, which was the last release):
 + The default "Scheme dialect" setting for those newly starting up
   without any recorded preferences is now MIT Scheme (without compiler),
   rather than the SICP compatability package.
 + Graphics windows can be copied to the pasteboard (as a TIFF);
   select the window and use the copy command in the edit menu or
   command-c.
 + Holding down the alternate key while pressing enter (on
   the keypad or as command-return) with nothing selected sends the
   current line to scheme rather than the current top-level expression;
   it also appends a newline.  This can be used for input to programs
   written in scheme but using a non-scheme syntax for their input.
 + A new procedure, filled-triangle, was added to the functional graphics
   package (see the help file).
 + The functional graphics package is now universally available,
   rather than just in the SICP compatability package.  (The default
   image size is 288 points in the SICP package but only 100 points
   elsewhere.)
 + The load-debug-info-on-demand? flag is now initially set true in
   all cases, not just in the SICP package.)
 + Special-case indentation handling was added for variant-case.
 + A bug was fixed in the functional graphics package that previously
   made rational numbers not work.
 + The screen size is no longer hardcoded in (in the positioning of
   graphics windows) so porting to Intel machines should be easier.
===============
Notes on .binf files:
  The file Schematik-1.1.5.4-binfs.tar.Z contains the directory tree
  Schematik.app/kernel/library/binfs (which is empty in the normal
  distribution).  If you install it you will be able to use the MIT
  Scheme debugger, environment inspector, and pretty printer on
  compiled procedures built into the Scheme distribution.  As of the
  1.1.5.4 distribution, only the .binf files for the runtime system and
  SICP compatability package are included.  The .binf files for the
  compiler and its related sf and cref systems took up a lot of space for
  little value.   Even the runtime and SICP .binf files are not worth the
  space they take for some users, which is why we've packaged them
  separately.  To install, assuming have Schematik.app in /LocalApps,
  you would do
   zcat Schematik-1.1.5.4-binfs.tar.Z | (cd /LocalApps; tar xf -)
  IMPORTANT NOTE: If you already have the binfs from version 1.1.5.2,
  you can just get the much smaller Schematik-new-in-1.1.5.4-binfs.tar.Z
  and unpack it as above to update the existing binfs directory tree,
  rather than ftping the whole large file.
===============
Notes on source distribution:
  The file Schematik-sources-1.1.5.4.tar.Z contains the source for the
  Schematik front end and also the changes made to MIT Scheme.
  Remember to use binary (image) mode if you transfer this file.
  Please remember that this distribution is on a strictly AS IS
  basis.  The individual files each contain the license terms,
  which are adapted from the MIT Scheme license.
  
  If you want to compile version 1.1.5.4 under NeXTstep 3.0, please
  get and read the file Schematik-compiling-under-NS3.x.
===============
Non-NeXT hardware:
  The Schematik executable will not run on non-NeXT hardware. It *may*
   be possible to comile the sources, using the patches from the file
   Schematik-compiling-under-NS3.x.  However, the MIT Scheme back end will
   still prove problematic.  I don't expect to have a fully working Schematik
   package for non-NeXT hardware until Summer of '94, and maybe not even
   then.  If you want to try doing it yourself before then, good luck
   to you, and please share your results with us if you are succesful.
===============
Notes on European ftp site:
  Users in Europe may more economically transfer Schematik from
  a server established at the University of Munich, Germany.
  Non-European users should not use the Munich server.  The server is
  on the host ftp.informatik.uni-muenchen.de.  If the past performance
  of its maintainers is any indication, version 1.1.5.4
  should appear there soon after its US appearance.
