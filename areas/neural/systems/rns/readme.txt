
                    Recurrent Network Simulator
                            RNS v1.6b

                           R. Kooijman


RNS is a simulator for recurrent (but also plain) neural networks. 
It uses a general version of the back-propagation algorithm, but other
(not that well tested) algorithms are also available.

RNS runs on IBM PC's and Sun workstations with MS-DOS, Linux, SunOS 4.X,
and Solaris 2.X. I compiled it with Turbo C v2.0 for MS-DOS and 
with gcc v2.3 (and up) on the Unix type of OS'es. All OS and compiler 
definitions are in rnsconf.h, so that's the place to look in case you 
need to (un)define things.

Making it work on other OS'es or compilers may require some changes to
the source. The machine specific code lies mainly in the areas of
terminal control and graphics (only available on PC's) and sometimes
there are minor problems with the order of including files.

There are a couple of Makefiles. Doing a 'make -f Makefile.gcc' will 
suffice for SunOS, Solaris and Linux. Makefile.dos can be used 
for Turbo C. You might want to take a look at Makefile.dos, turboc.cfg and 
libs.lnk to change some compiler settings (paths).

The documentation comes in two Postscript files, rns.ps and report.ps,
but for anyone who wants, I can dig up the original WP 5.1 files.
The manual rns.ps is somewhat outdated since I extended RNS for some
later research, but you can always take a look at sources or bug me
at the address below.

Example network definitions are in the net subdirectory. RNS has
the benefit that output can be used as input again without any modifications.
Comes in handy if you want to train your network some more.


Good luck,


Richard.


R. Kooijman
Delft University of Technology
Department of Electrical Engineering
Section Computer Architecture and Digital Technique
Mekelweg 4
2628 CD Delft
The Netherlands

e-mail: R.Kooijman@et.tudelft.nl
phone:  +31-15-786209
fax:    +31-15-784898
