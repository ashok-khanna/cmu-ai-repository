From honeydew.srv.cs.cmu.edu!rochester!udel!gatech!howland.reston.ans.net!usc!cs.utexas.edu!uunet!mcsun!news.inesc.pt!animal.inescn.pt!ciup2.ncc.up.pt!ciup2!zp Tue Sep 21 13:48:51 EDT 1993
Article: 8575 of comp.lang.prolog
Xref: honeydew.srv.cs.cmu.edu comp.lang.prolog:8575
Path: honeydew.srv.cs.cmu.edu!rochester!udel!gatech!howland.reston.ans.net!usc!cs.utexas.edu!uunet!mcsun!news.inesc.pt!animal.inescn.pt!ciup2.ncc.up.pt!ciup2!zp
From: zp@ciup1.ncc.up.pt (Jose' Paulo Leal)
Newsgroups: comp.lang.prolog
Subject: [ ANNOUNCE: Portable Interfaces version 1.2 ]
Date: 17 Sep 93 18:21:59
Organization: Universidade do Porto
Lines: 70
Message-ID: <ZP.93Sep17182159@ciup1.ncc.up.pt>
NNTP-Posting-Host: ciup1.ncc.up.pt


	PI: Portable Interfaces for Prolog applications
	===============================================

PI is a interface between Prolog applications  and XWindows that  aims
to  be independent from  the Prolog  engine, provided  that  it  has a
Quintus like foreign function interface  (such as SICStus, YAP). It is
mostly written in Prolog and is divided in two libraries:    

	* Edipo - the lower level interface to the Xlib functions, 
		allows you to:
			create and manage windows
			use graphical primitives
			receive events

	* Ytoolkit - the higher level user interface toolkit
		allows you to:
			create and manage graphical objects
			define new classes of objects
			handle user interaction


Pi has been tested in :

Quintus Prolog Release 3.1.1	(Sun-4, SunOS 4.1)
SICStus 2.1 #8: 		(Sun-4, SunOS 4.1)


The package is available via anonymous FTP from:

ftp.ncc.up.pt:/pub/prolog/pi_1.2.tar.gz

and includes documentation and some demos. 

Here some of the things that were improved since the last version:

o FULL PORT to Quintus Prolog
o Compatible with SICStus #8
o C code compilable by gcc
o installation makefile
o demos are working in Quintus
o problems with multifile where solved
o unneeded files were removed
o writestring/3 is now efficiently implemented
o bitmap operations implemented
o error handling

You can send questions, comments, bug reports, etc to:	


+-------------------------+---------------------------------------------+
| Ze' Paulo Leal          | zp@ncc.up.pt	                	|
| Universidade do Porto	  |                                             | 
| CIUP			  | 				           	|
| R.Campo Alegre, 823	  | 						|
| 4000 PORTO		  | Tel:	+351 2 6001672 (ext.109)        |
| PORTUGAL		  | Fax:  	+351 2 6003654		        |
+-----------------------------------------------------------------------+

--

+-------------------------+---------------------------------------------+
| Ze' Paulo Leal          | zp@ncc.up.pt	                	|
| Universidade do Porto	  |                                             | 
| CIUP			  | 				           	|
| R.Campo Alegre, 823	  | 						|
| 4000 PORTO		  | Tel:	+351 2 6001672 (ext.109)        |
| PORTUGAL		  | Fax:  	+351 2 6003654		        |
+-----------------------------------------------------------------------+



