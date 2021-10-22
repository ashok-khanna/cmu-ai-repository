Current Release Date: 30 October 1995

The Allegro CL 3.0 Web Version for Windows is a fully functional, and free 
version of our Dynamic Object Oriented Programming Development System 
for ANSI standard CLOS, with some limitations*.  We sell a supported 
version of this software, Allegro CL for Windows, without these 
limitations.  Please contact us at:

Telephone: (510) 548-3600
FAX:       (510) 548-8253
U.S.:      (800) 3 CLOS NOW
E-mail:    info@franz.com
Web page:  http://www.franz.com/

We welcome suggestions you have, or problems you find, but we may not 
get back to you since this software is unsupported.  Please send your 
input to us here ar web@franz.com.

Enjoy the power of CLOS!

*The limitations are: A limited heap size, no foreign function
support, no compile-file, no disassembler, and no image saving
(save-image).  The documentation fully explains these capabilities.

---------------------------------------------------------------------------

Installation Prerequisites:

  For best performance, we recommend your machine have least 16 MB of
memory and at least 20 MB of swap space.


Installation Instructions:

(1) Please read the file license.txt for the legal details on how this
software is to be used.  This license.txt file is available in
ftp://ftp.uu.net/vendor/franz/aclwin/web/license.txt as well as in the
top level of the AclWin distribution directory after installation.
This file is also shown as part of the "About Allegro CL" display
(available by clicking the "Help" menu in Allegro CL 3.0).

(2) Download via ftp the file
"ftp://ftp.uu.net/vendor/franz/aclwin/web/acl3wr.exe".  This file is a
little over 4 MB, so the download may take some time.

(3) In an empty directory, run the acl3wr.exe program.  This program
is actually a self-extracting archive.  When completed, approximately
200 files will be placed into the directory where you ran the
acl3wr.exe program.  The total size of the extracted files is about
4.7 MB.  After extracting the files, the acl3wr.exe file will no
longer be needed and can be removed if you are low on disk space.

(4) One of the newly created files from the archive is called
"setup.exe".  Running that file as a program will launch the Allegro
CL installation.  This procedure will ask you for a directory to store
the installed distribution.  C:\Allegro is the recommended name, but
you can choose any location.  Approximately 10 MB will be stored in
this directory.

(5) After installation, you can remove acl3wr.exe (downloaded in step
(2)), and all the files extracted from the archive (from step (3)).


Win32s

If you are running Microsoft Windows 3.1 or Microsoft Windows for
Workgroups 3.11, you will need to install (or already have running)
Microsoft Win32s 1.30 before you can run AclWin.  Win32s allows Win32
applications to run under Windows 3.1.  Win32s is not required (and
cannot even be installed) under Windows 95 or Windows NT.

If you are unsure whether you are already running the correct win32s
version, there is no harm in attempting a new win32s installation.
The win32s installation procedure does a version check on the
installed win32s (if any) and proceeds only if there is no already
installed win32s or the already installed win32s is out of date.  To
manually check the win32s version number, you can look at the
"[Win32s] Version=" field in the system\win32s.ini file in your
Windows directory.  If no such win32s.ini file exists, then you will
need to install win32s.

A copy of Win32s is available as
"ftp://ftp.uu.net/vendor/franz/aclwin/web/w32s130.exe".  Like the
AclWin distribution, this file is distributed as a self-extracting
archive containing a "setup" program needed to perform the
installation.  As with the AclWin installation, both the original
archive and the extracted files can be deleted after Win32s is
installed.

Notes

The Web version of AclWin is unsupported.  However, we are very
interested in improving this software and its installation procedures.
Please feel free to send any comments, suggestions, or problems you
may find to web@franz.com.


Allegro CL is a registered trademark of Franz Inc.
Microsoft is a registered trademark.
Windows is a trademark of Microsoft Corporation.

