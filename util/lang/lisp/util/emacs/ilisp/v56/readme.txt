To: ILISP Discussion <ilisp@lehman.com>
Subject: ILISP available via anonymous ftp to CMU
From: Rick Busdiecker <rfb@lehman.com>
Organization: Lehman Brothers Inc.
X-Windows: Garbage at your fingertips.

-----BEGIN PGP SIGNED MESSAGE-----

The ILISP archive is available via anonymous ftp to H.GP.CS.CMU.EDU
[128.2.254.156] in /usr/rfb/ilisp/

The archive is available as a gzipped tar file, ilisp-5.6.tar.gz

To expand the archive, do the following:

 % zcat ilisp-5.6.tar.gz | tar xf -

This will create an ilisp-5.6 directory containing all of the ilisp
files.

Please note that you must change directories directly into
/usr/rfb/ilisp/ when using anonymous ftp rather than going in
intermediate steps.  For example you will not be allowed to cd to
/usr/rfb/

The current version is 5.6.  Version 5.5 is also available in the same
directory.

Checksums are:

			 BSD                     SysV
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
150 Opening data connection for ls (192.147.66.1,2444).
total 597
- -rw-r--r--  1 rfb      garnet       2888 Jul 15 16:02 README.FTP
- -rw-r--r--  1 rfb      garnet     307354 Jul 15 15:47 ilisp-5.5.tar.gz
- -rw-r--r--  1 rfb      garnet        282 Jul 15 15:32 ilisp-5.5.tar.gz.asc
- -rw-r--r--  1 rfb      garnet     272206 Jul 15 15:56 ilisp-5.6.tar.gz
- -rw-r--r--  1 rfb      garnet        282 Jul 15 15:33 ilisp-5.6.tar.gz.asc
226 Transfer complete.
373 bytes received in 0.065 seconds (5.6 Kbytes/s)
ftp> quit
221 Goodbye.
% 

-----BEGIN PGP SIGNATURE-----
Version: 2.6

iQCVAgUBLibrgZNR+/jb2ZlNAQHB2wP+MRzYGVwJ2vejlE5etT52n/ZIjhU68VNm
vJIkCpXb/7Q+5k/8XCRQnt2WCGYd9yiYuzgCoBvw30W5VWVDSIIpv0vMqjDjOBiP
xKZC+39oGVJSFTcHlcjapJaIfJ16q3sdW5Hl4zBuUk6EyEjGZCg1WFSiariryL/q
kRmoEugJwwg=
=Na+B
-----END PGP SIGNATURE-----
