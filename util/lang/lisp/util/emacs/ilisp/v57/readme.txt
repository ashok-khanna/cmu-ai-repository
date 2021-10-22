-----BEGIN PGP SIGNED MESSAGE-----

The ILISP archive is available via anonymous ftp to H.GP.CS.CMU.EDU
[128.2.254.156] in /usr/rfb/ilisp/

The archive is available as a gzipped tar file, ilisp-5.6.tar.gz

To expand the archive, do the following:

 % zcat ilisp-5.7.tar.gz | tar xf -

This will create an ilisp-5.7 directory containing all of the ilisp
files.

Please note that you must change directories directly into
/usr/rfb/ilisp/ when using anonymous ftp rather than going in
intermediate steps.  For example you will not be allowed to cd to
/usr/rfb/

The current version is 5.7.  Versions 5.6 and 5.5 are also available
in the same directory.

Checksums are:

			 BSD                     SysV
 ilisp-5.7.tar.gz        21624   252             38227 504
 ilisp-5.6.tar.gz        54533   266             64936 532
 ilisp-5.5.tar.gz        26872   301             28698 601

In case anyone wants to be really sure that the archive has not been
tampered with, I've included PGP detached digital signature files for
each of the archives.

Happy lisping,

			Rick

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% ftp h.gp.cs.cmu.edu
Connected to 128.2.254.156
Name: anonymous
331 Guest login ok, send username@node as password.
Password:
230-Filenames can not begin with the three characters "/.." .
    Other than that, everything is ok.
230 User anon logged in.
ftp> cd /usr/rfb
530-Access not allowed for guest users for path "/usr/rfb".
    Here is a hint... If you know the full name, starting with "/"
    of the path or directory that you want, try to cd there in
    one step rather than taking little steps in between.
    Those intermediate directories are sometimes protected.
    Or perhaps you are already in the appropriate directory.
530 Use the pwd command to get the current directory.
ftp> cd /usr/rfb/ilisp
250 Directory path set to /usr/rfb/ilisp.
ftp> dir
200 PORT command successful.
150 Opening data connection for ls (192.147.66.1,3212).
total 862
- -rw-r--r--  1 rfb      garnet       2903 Jan 24 16:37 README.FTP
- -rw-r--r--  1 rfb      garnet     307354 Jul 15  1994 ilisp-5.5.tar.gz
- -rw-r--r--  1 rfb      garnet        282 Jul 15  1994 ilisp-5.5.tar.gz.asc
- -rw-r--r--  1 rfb      garnet     272206 Jul 15  1994 ilisp-5.6.tar.gz
- -rw-r--r--  1 rfb      garnet        282 Jul 15  1994 ilisp-5.6.tar.gz.asc
- -rw-r--r--  1 rfb      guest      257790 Jan 24 09:00 ilisp-5.7.tar.gz
- -rw-r--r--  1 rfb      garnet        284 Jan 24 16:22 ilisp-5.7.tar.gz.asc
226 Transfer complete.
521 bytes received in 0.085 seconds (6 Kbytes/s)
ftp> quit
221 Goodbye.
% 

-----BEGIN PGP SIGNATURE-----
Version: 2.6.2

iQCUAwUBLyVzOpNR+/jb2ZlNAQFHaQP1GZJV0lWkRwU3yIq0mCbqCufYM68XFflY
jqxtdRCQUA+2V1cKCfoUGf4U329ZI4d1/MwVmKpyYJQtQTeWX1NwQQwaGL82UVoX
ZcVFamPYuOt9Izqk/qtgq49SnPqOAUPps1kxXsTpWj4UYkassxXJCrZlKAruuGRY
PO6vKRzLEQ==
=mRgH
-----END PGP SIGNATURE-----
