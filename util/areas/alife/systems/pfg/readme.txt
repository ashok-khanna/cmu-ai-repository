Plant and Fractal Generator (PFG)

This file contains information about obtaining and setting up the Macintosh version
of the Plant and Fractal Generator (pfg) written by Przemyslaw Prusinkiewicz
and available via ftp from the University of Calgary.

THE UNIVERSITY OF CALGARY GIVES NO WARRANTY, EXPRESSED OR IMPLIED, FOR THE
SOFTWARE AND/OR DOCUMENTATION PROVIDED, INCLUDING, WITHOUT LIMITATION, 
WARRANTY OF MERCHANTABILITY AND WARRANTY OF FITNESS FOR A PARTICULAR PURPOSE.


FTP INSTRUCTIONS

1. Log on to a host at your site that is connected to the Internet and is
   running software supporting the FTP command.

2. Invoke FTP on most systems by entering the Internet address of the server.
   Type the following at the shell (usually "%") prompt:

      % ftp cpsc.ucalgary.ca

3. Log in by entering "anonymous" for the name.

4. Enter your local email address (login@host) for the password.

5. Once loged in, you will see a message of the form:

	331 Guest login ok, send ident as password

6. The "ls" and "cd" commands can be used at the "ftp>" prompt to list and
   change directories as in the shell.

   Change directory to pub:

	ftp> cd pub/pfg
	250 CWD command successful.

    Here you will find two files, README and pfg.3.0.sit.hqx.  The former
    is this file, the latter is the actual Mac version of the pfg software,
    complete with a manual, source, and example L-systems.  The 3.0 in the
    filename indicates the version number, the .sit indicates the file has
    been stuffed, and hqx indicates the file has been BinHexed.

7. To transfer the file:
      ftp> get pfg.3.0.sit.hqx

8. Enter "quit" to exit FTP and return to your local host.



DOWNLOADING TO THE MACINTOSH

    To transfer pfg.3.0.sit.hqx to your mac, use NCSA's TelNet program, or
    similar type software.  TelNet is available free of charge from from
    The National Center for Supercomputing Applications.  The code can be
    obtained via ftp:
        % ftp ftp.ncsa.uiuc.edu
            or
        % ftp 141.142.20.50



EXTRACTING FILES

    Once the program sits on your mac, you must first decode, and then 
uncompress it before it can be used.  The program was both compressed and 
encoded with StuffIt Lite 3.0, a shareware program available from:

	Aladdin Systems, Inc.
	165 Westridge Dr.
	Watsonville, CA
	USA (408) 761-6200


    Follow the following steps:

1.  Launch StuffIt, from the Translate Menu, select BinHex4, and then further
    select Decode...

2.  A file dialog will appear, find and select the file you downloaded
    (pfg.3.0.sit.hqx).  The select Decode from the dialog.  You will further
    be asked what name to save the unencoded file, just pick the default
    (pfg.3.0.sit).

3.  The file (pfg.3.0.sit) must now be unstuffed.  Select Open from the File
    menu, and select pfg.3.0.sit from the file dialog that appears.  Then
    press the UnStuffit button.

4.  A folder (pfg.3.0) will be created.  This folder contains another, called
    PFG.  Within PFG is the standalone application(pfg 3.0), along with a 
    user manual(manual.macwrite) and two folders containing the source code
    (src) and example data files(L-systems).  With this, you are ready to 
    enjoy working with pfg.

Good Luck!



PROBLEMS
    Any problems regarding this (Macintosh) version of pfg can be directed to:
	valerio@cpsc.ucalgary.ca

    Enquires about other versions (Unix) of pfg can be directed to:
	camille@cpsc.ucalgary.ca

    Comments and feedback about pfg are welcome, and can be directed to:
	pwp@cpsc.ucalgary.ca




