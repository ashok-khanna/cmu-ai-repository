

                             N E F C O N - I

          An InterViews based graphical simulation environment 
          to develop, train, and test Neural Fuzzy Controllers

                               Version 1.0
 
                              June 16, 1994



               COPYRIGHT NOTICE AND EXCLUSION OF WARRANTY

   Institut fuer Betriebssysteme und Rechnerverbund, Technische
   Universitaet Braunschweig, Bueltenweg 74/75, 38106 Braunschweig,
   Germany, hereby disclaims all copyright interests in the 
   program NEFCON-I and its documentation.

   NEFCON-I is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 1, or (at your option)
   any later version.

   NEFCON-I is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License in the file COPYING for more details.

   You should have received a copy of the GNU General Public License
   along with NEFCON-I and this document; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


1) WHAT IS NEFCON-I?

NEFCON-I means NEural Fuzzy CONtroller - based on InterViews, and it is 
an X11 simulation environment to build and test neural fuzzy controllers
based on the NEFCON model developed at the Department of Computer Science
of the University of Braunschweig.  
NEFCON-I is able to learn fuzzy sets and fuzzy rules by using a kind of
reinforcement learning that is driven by a fuzzy error measure. 
To do this NEFCON-I communicates with another process, that implements a
simulation of a dynamical process.

NEFCON-I can optimize the fuzzy sets of the antecedents and the conclusions
of a given rule base, and it can also create a rulebase from scratch. The
theoretical foundations of the NEFCON model are not discussed in this
report. If you are interested please refer to our publications (see the 
MANUAL.ps) Some of them you can also find on our FTP server (see below)

If your are able to read German, you can download the diploma thesis of
Hermann-Josef Diekgerdes, who wrote the first version of NEFCON-I. There 
you can find a short discussion of the theoretical foundations, and a
comprehensive description of the data structures and algorithms used in the
software. 

For a detailed discussion of neural networks and neural fuzzy systems
including the NEFCON model please refer to our new book 
Nauck, Klawonn, Kruse: 
Neuronale Netze und Fuzzy Systeme. Vieweg, Wiesbaden 1994.


2) WHERE CAN I OBTAIN NEFCON-I AND MORE INFORMATION?

You can get NEFCON-I and some of our papers which describe the aspects of the
theoretical background behind the NEFCON model from our FTP server at
ftp@ibr.cs.tu-bs.de (IP address 134.169.34.15). Papers are in the directory
pub/local/papers. Get the file INDEX first, and check which documents you
want to download. 

You will also find the latest release of NEFCON-I there in the directory
pub/local/nefcon in the file nefcon_x.y.tar.gz, where x.y is the
release number. New releases will be announced in the newsgroups comp.ai.fuzzy
and comp.ai.neural-nets. You will probably also find NEFCON-I on an FTP
server near you. Please check the newsgroups and mailing lists like
fuzzy-mail for announcements.  
If you can't read Usenet news, but you can receive email, you might want
to join the fuzzy-mail list maintained by Marcus Herzog and Wolfgang
Slany. Send an email to listserver@vexpert.dbai.tuwien.ac.at that contains
only the line 
SUBSCRIBE FUZZY-MAIL <your name> 
in its message.

If you have questions or comments concerning the NEFCON model or the
software, please mail them to nauck@ibr.cs.tu-bs.de (Detlef Nauck).
Questions concerning the program code will be usually forwarded
to the developer who works on NEFCON-I (currently Roland Stellmach). You
can send mail directly to him (stellma@ibr.cs.tu-bs.de), but please note that
he is a student at our department, and  he does not work full time
here, i.e. answering your questions may take some time.

If you are going to use NEFCON-I please send an email to 
nauck@ibr.cs.tu-bs.de, so we can keep track of users. We will inform
you about updates. We would also appreciate to hear from you, if you
tried to use NEFCON-I to solve an applicational problem (successfully
or not).

If you plan to put NEFCON-I on any FTP server, please feel free to do
so. In this case please send us an email, so we can send updates to
this site. 
 

3) HOW DO I INSTALL NEFCON-I?

To install NEFCON-I you need an X11 environment, InterViews 3.1, and a C++
compiler (e.g. g++). Please print and read the file MANUAL.ps. It contains
a description of how to install and use NEFCON-I. I you don't have a
postscript printer please consider to use GHOSTSCRIPT. In very rare cases I
can send you a hard copy.

If you don't know what InterViews is, you can't use NEFCON-I. Read the
manual, and ask your system administrator for help.

For the impatient fellows, here is a short outline of how to install:

NEFCON-I is distributed as a gzip'ed tar-file: nefcon_1.0.tar.gz, which you
have to gunzip and untar:

tar -xvzf nefcon_1.0.tar.gz
(or use gunzip nefcon_1.0.tar.gz and then tar -xvf nefcon_1.0.tar)

You will get the directory nefcon that contains this README file, the
manual, and four additional directories (source, data, datagen, pendulum).

Now set the environment variable CPU to your type of system (e.g. SUN4,
LINUX, etc.). Let's assume you have a SUN4 Sparcstation.

Change directory to nefcon/source, and enter "ivmkmf -a", and the "make".
You will find the executable nefcon in the directory nefcon/source/SUN4.

Now change to nefcon/pendulum, and enter "ivmkmf -a", and the "make".
You will find the pendulum simulation in the executable 
nefcon/pendulum/SUN4/pendulum.

Finally change to nefcon/datagen, and enter "ivmkmf -a", and the "make".
You will find the data generator in nefcon/datagen/SUN4/datagen.

Move all three executables somewhere into your path. If you want you can
delete the SUN4 directories. You can also delete the sources, just keep the
files in nefcon/data. This are the provided examples.

PS: nefcon and pendulum display a German interface by default. Use the 
parameter -e if you want to have an English interface.

Sorry, but now you have to read the manual :-). 


4) LIST OF FILES

You should have receive NEFCON-I in a gzip'ed tar-file nefcon_1.0.tar.gz that 
contains the following files. If you distribution is incomplete please notify
nauck@ibr.cs.tu-bs.de.

-rw-r--r-- nauck/users   17982 Jun 16 16:45 1994 nefcon/COPYING
-rw-r--r-- nauck/users  933270 Jun 16 16:43 1994 nefcon/MANUAL.ps
-rw-r--r-- nauck/users    7372 Jun 16 16:57 1994 nefcon/README
drwxr-sr-x nauck/users       0 Jun 15 15:38 1994 nefcon/data/
-rw-r--r-- nauck/users     901 Jun 15 15:38 1994 nefcon/data/exam1.lv
-rw-r--r-- nauck/users     965 Jun 15 15:38 1994 nefcon/data/exam1.rg
-rw-r--r-- nauck/users     590 Jun 15 15:38 1994 nefcon/data/exam1_e.lv
-rw-r--r-- nauck/users     877 Jun 15 15:38 1994 nefcon/data/exam1_e.rg
-rw-r--r-- nauck/users     936 Jun 15 15:38 1994 nefcon/data/exam2.lv
drwxr-sr-x nauck/users       0 Jun 16 14:33 1994 nefcon/datagen/
-rw-r--r-- nauck/users     529 Jun 16 10:36 1994 nefcon/datagen/Imakefile
-rw-r--r-- nauck/users    6406 Jun 16 10:37 1994 nefcon/datagen/pendel_texte.c
-rw-r--r-- nauck/users    1341 Jun 16 10:37 1994 nefcon/datagen/pendel_texte.h
-rw-r--r-- nauck/users   32679 Jun 16 10:37 1994 nefcon/datagen/pendel_look.c
-rw-r--r-- nauck/users   10917 Jun 16 10:37 1994 nefcon/datagen/pendel_look.h
-rw-r--r-- nauck/users    6017 Jun 15 22:15 1994 nefcon/datagen/datagen.c
-rw-r----- nauck/users    1742 Jun 16 10:37 1994 nefcon/datagen/global.c
-rw-r----- nauck/users    2036 Jun 16 10:37 1994 nefcon/datagen/global.h
drwxr-sr-x nauck/users       0 Jun 16 14:34 1994 nefcon/pendulum/
-rw-r--r-- nauck/users     253 Jun 15 09:32 1994 nefcon/pendulum/Imakefile
-rw-r----- nauck/users    1742 Jun 15 14:20 1994 nefcon/pendulum/global.c
-rw-r--r-- nauck/users    3468 Jun 15 22:14 1994 nefcon/pendulum/main.c
-rw-r--r-- nauck/users   23853 Jun 15 14:21 1994 nefcon/pendulum/pendel.c
-rw-r--r-- nauck/users    3048 Jun 15 14:21 1994 nefcon/pendulum/pendel.h
-rw-r--r-- nauck/users   32679 Jun 15 14:22 1994 nefcon/pendulum/pendel_look.c
-rw-r--r-- nauck/users   10917 Jun 15 14:22 1994 nefcon/pendulum/pendel_look.h
-rw-r--r-- nauck/users    6406 Jun 15 14:22 1994 nefcon/pendulum/pendel_texte.c
-rw-r--r-- nauck/users    1341 Jun 15 14:22 1994 nefcon/pendulum/pendel_texte.h
-rw-r--r-- nauck/users    7538 Jun 15 14:23 1994 nefcon/pendulum/runge.c
-rw-r--r-- nauck/users   21553 May  2 16:19 1994 nefcon/pendulum/pendel.tar.gz
-rw-r--r-- nauck/users    2428 Jun 15 14:23 1994 nefcon/pendulum/runge.h
-rw-r----- nauck/users    2036 Jun 15 14:20 1994 nefcon/pendulum/global.h
drwxr-sr-x nauck/users       0 Jun 16 14:34 1994 nefcon/source/
-rw-r----- nauck/users    7972 Jun 15 14:12 1994 nefcon/source/anwend_ed.c
-rw-r----- nauck/users   11576 Jun 15 15:40 1994 nefcon/source/anwendung.c
-rw-r----- nauck/users   13455 Jun 15 14:12 1994 nefcon/source/control_ed.c
-rw-r----- nauck/users   35535 Jun 15 14:13 1994 nefcon/source/controller.c
-rw-r----- nauck/users   13918 Jun 15 14:13 1994 nefcon/source/datei.c
-rw-r----- nauck/users    1742 Jun 15 14:13 1994 nefcon/source/global.c
-rw-r----- nauck/users   18968 Jun 15 14:14 1994 nefcon/source/koosystem.c
-rw-r----- nauck/users    6656 Jun 15 14:14 1994 nefcon/source/lern_ed.c
-rw-r----- nauck/users   29042 Jun 15 14:14 1994 nefcon/source/lingvar.c
-rw-r----- nauck/users   43008 Jun 15 14:15 1994 nefcon/source/lingvar_ed.c
-rw-r----- nauck/users    3042 Jun 15 11:33 1994 nefcon/source/main.c
-rw-r----- nauck/users   25696 Jun 15 14:15 1994 nefcon/source/nfc_ed.c
-rw-r----- nauck/users   32666 Jun 15 14:15 1994 nefcon/source/nfclook.c
-rw-r----- nauck/users   33524 Jun 15 14:16 1994 nefcon/source/protokoll.c
-rw-r----- nauck/users    8325 Jun 15 14:16 1994 nefcon/source/protokoll_ed.c
-rw-r----- nauck/users   14214 Jun 15 14:17 1994 nefcon/source/regel.c
-rw-r----- nauck/users    3858 Jun 15 14:17 1994 nefcon/source/regel_ed.c
-rw-r----- nauck/users   41197 Jun 15 14:18 1994 nefcon/source/regel_tab.c
-rw-r----- nauck/users   23381 Jun 15 14:18 1994 nefcon/source/regel_tafel.c
-rw-r----- nauck/users   34444 Jun 15 14:10 1994 nefcon/source/texte.c
-rw-r----- nauck/users   13028 Jun 15 14:18 1994 nefcon/source/wissensbank.c
-rw-r----- nauck/users    2214 Jun 15 14:12 1994 nefcon/source/anwend_ed.h
-rw-r----- nauck/users    4212 Jun 15 14:12 1994 nefcon/source/anwendung.h
-rw-r----- nauck/users    3486 Jun 15 14:13 1994 nefcon/source/datei.h
-rw-r----- nauck/users    2610 Jun 15 14:12 1994 nefcon/source/control_ed.h
-rw-r----- nauck/users    7801 Jun 15 14:13 1994 nefcon/source/controller.h
-rw-r----- nauck/users    2036 Jun 15 14:14 1994 nefcon/source/global.h
-rw-r----- nauck/users    5400 Jun 15 14:14 1994 nefcon/source/koosystem.h
-rw-r----- nauck/users    2095 Jun 15 14:14 1994 nefcon/source/lern_ed.h
-rw-r----- nauck/users    8529 Jun 15 14:14 1994 nefcon/source/lingvar.h
-rw-r----- nauck/users    2023 Jun 15 14:15 1994 nefcon/source/lingvar_ed.h
-rw-r----- nauck/users    3019 Jun 15 14:15 1994 nefcon/source/nfc_ed.h
-rw-r----- nauck/users   10840 Jun 15 14:16 1994 nefcon/source/nfclook.h
-rw-r----- nauck/users    5565 Jun 15 14:16 1994 nefcon/source/protokoll.h
-rw-r----- nauck/users    2686 Jun 15 14:17 1994 nefcon/source/protokoll_ed.h
-rw-r----- nauck/users    5243 Jun 15 14:17 1994 nefcon/source/regel.h
-rw-r----- nauck/users    2186 Jun 15 14:17 1994 nefcon/source/regel_ed.h
-rw-r----- nauck/users    5330 Jun 15 14:18 1994 nefcon/source/regel_tab.h
-rw-r----- nauck/users    4293 Jun 15 14:18 1994 nefcon/source/regel_tafel.h
-rw-r----- nauck/users    1274 Jun 15 14:18 1994 nefcon/source/texte.h
-rw-r----- nauck/users    5179 Jun 15 14:19 1994 nefcon/source/wissensbank.h
-rw-r----- nauck/users     469 Jun 15 11:15 1994 nefcon/source/Imakefile


Enjoy!

Detlef

==============================================================================
Dr. Detlef Nauck                        Phone: 49.531.391.3155
Dept. of Computer Science               Fax  : 49.531.391.5936
Technical University of Braunschweig    Email: nauck@ibr.cs.tu-bs.de
Bueltenweg 74 - 75
D-38106 Braunschweig
Germany
=============================================================================

