You are going to get the ASpecT system? 

Fine! By the way, ASpecT is a strict functional language which
compiles to C and is designed to run fast and to be compatible
on as many systems as possible.

Still interested?

Ok! You don't need to get all the tar files. What you need is 
file ASpecT.common.tar.Z, which contains librarys, the 
runtime system, some demo soures, documentation and so on.

Then you have to decide on which machine you are going to use
the ASpecT system. We currently deliver versions for

Platform		   id
------------------------   --------
Atari (with TOS)           atari
IBM RS 6000		   rs
IBM PC 386 (with OS2/2.0)  os2		(*)
IBM PC 386 (with linux)    lx
MacIntosh (with A/UX)      mac
NeXT		           NeXT
SUN386i series		   sun386i
SUN3 series		   sun3
SUN SPARC series	   sun4		(*)
VAX (with ULTRIX)          vax

To get the running compiler and the compiled objects of the
runtime system (the later you can produce by yourself if you
like to).

Get the file ASpecT.($id).tar.Z too.

Create a directory on you machine, uncompress and untar
the files. Further process is documented in the package.


Joern von Holten (University of Bremen, aspect@sun1.uni-bremen.de)


P.S.: You do not find YOUR machine in this list. What a pitty!
Just mail us a note ... maybe we have YOUR machine in our
deliverables just now - currently trying a PC, Amiga and
Atari version. Maybe you like to help us to compile the whole
thing on your machine ... if its UNIX or some alike (modern os) there
should be no problem but to get and compile about 5 megs of generated
C code. You will find these in ASpecT.doityourself.tar.Z. Unpack these
files in a special dir. You will need ASpecT.common.tar.Z too!
Read the README-file and the modified COPYRIGHTS delived within there.

P.S.S.: You can get some of the packets (these which are marked (*) and
the common file) from a second ftp-server now.
It is located in Dortmund/Germany and should be a bit faster. The
address is ftp.germany.eu.net (simpson.germany.eu.net, 192.76.144.75)
and it can be found in pub/programming/languages/LogicFunctional.
