This Goodwill version of Express Windows was built from the
original version of Express Windows made freely available by
Andrew Ressler on April 2, 1990.  This Goodwill version was built
by personnel of The Boeing Company.

This version represents the version currently in use at The Boeing
Company.  However, neither Boeing nor I, Stephen Nicoud accept
responsibility to anyone for the consequences of using it or for
whether it serves any particular purpose or works at all.  There
is no express or implied warranty.  Neither does the release of
this version consitute endorsement of Express Windows by The
Boeing Company.

To copy, uncompress & untar Express Windows on a Unix Platform:

  (0) Using the binary mode, get the compressed tar file for
      Express Windows.

  (1) Create a directory on which Express Windows will reside.

      e.g, % mkdir ew

  (2) Move the file express-windows.goodwill.tar.Z to that directory.

      e.g. % mv express-windows.goodwill.tar.Z ew

  (3) Change the working directory to the Express Windows directory.

      e.g. % cd ew

  (4) Issue this command to uncompress and untar the file:

      % uncompress -c express-windows.goodwill.tar.Z | tar xvf -

  (5) Optionally delete the tar file:

      % rm express-windows.goodwill.tar.Z


Differences between this version and the original:

 - Works in May Day PCL and Symbolics CLOS.

 - Should work with Victoria, and Rainy Day PCL and Symbolics
   CLOS. 

 - Works with CLX R4.3.

 - Should work with CLX R3.

 - Compiled and cursorily tested in 
    - Sun/Lucid Common Lisp 3.0.2 (Sun 3, SunOS 4.1)
    - Franz Allegro Common Lisp 3.1.13 (Sun 3, SunOS 4.1)
    - Symbolics Common Lisp (Symbolics 3650, Genera 8.0)

    [Note: Compiled and tested using CLX R4.3 and May Day PCL
    (except for Symbolics, for which the native CLOS
    implementation was used).]

 - PCL & CLX are not included in this distribution
   PCL is available in /pcl/tarfile on parcftp.xerox.com
   CLX is available in /contrib/CLX.R4.3.tar.Z on export.lcs.mit.edu

 - Installation procedures have been refined.  Consult
   ./INSTALL.GOODWILL.

 - No attempt has been made to preserve non-CLOSified EW,
   although no deliberate attempt has been made to rule it out.

 - While EW can be compiled and run in Symbolics (Genera 8.0),
   full functionality is not available.  In particular, those
   Symbolics CL functions (e.g., ROOM & DESCRIBE) which have
   their input/output function calls optimized to message sends,
   will not function properly.  This is probably due to compiler
   optimizations of FORMAT.

 - Numerous (too numerous to list) bugs and compilation warning
   messages from the original version have been handled.

Other important information:

 - Consult ./code/READ_ME.GOODWILL for a description of changes
   to the files in that directory.

 - Email Addresses

   - express-windows@cs.cmu.edu

     This mailing list is for discussion of any topic related to
     the use of Express Windows.  Questions, bug reports,
     enhancements, comments, etc are to be directed to this
     address.

   - express-windows-request@cs.cmu.edu

     Administrative address for the Express Windows mailing list.
     only requests for addition, deletion, modification to the
     Express Windows mailing list should be directed to this
     address.  Additionally, if any messages submitted to the
     Express Windows mailing list bounce, the bounced message(s)
     may be forwarded/resent to this address.

   - aressler@oiscola.columbia.ncr.com

     This is the address for the author of Express Windows,
     Andrew L. Ressler.
