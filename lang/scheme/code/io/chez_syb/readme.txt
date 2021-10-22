ChezSybase: A Chez Scheme interface to the Sybase database.

Version:      1.0 (25-MAY-94)

Description:  

   A foreign function interface to Chez Scheme to allow calls to the
   Sybase db-lib, the API to the Sybase database, and a high level
   Scheme-like interface so you can forget about db-lib.  Most of the
   db-lib calls and datatypes are supported.  I believe the two
   exceptions are: spotty support for text and image data as this
   datatype was being introduced as I wrote the code, and no Scheme
   support for the datetime datatype -- dates and times must be supplied
   to SQL as a string and returned to Scheme in a CONVERT()ed column as a
   string.  There is no Scheme datetime datatype.

   Working but not really commercial grade code.  There is no separate
   documentation, the code (and makefile) was only tested on a VAX not
   under Unix, there are a few hacks to avoid linking to shared libraries
   -- because this didn't work and I didn't want to spend the time
   figuring it out, and there are a few applys in the code (and lots of
   executed applys) because I wanted robustness and didn't want to work
   on speed optimizations.  Also, the user of the routines might want
   more control over the scope of some of the C foreign functions, glue
   routines, and db-lib functions to package them for an applications
   programmer, a bunch of stuff is put into the global environment.

Requires:     Chez-Scheme, Sybase db-lib

Copying:      

   Permission is granted to use this code and text so long as this
   copyright notice is included in it's entirity and so long as any
   program or product derived from this code is not sold, excepting for
   money charged to cover the cost of distribution.  The intention here
   is to provide the code for people to play with and use in their
   programs, including programs which they use in the course of their
   business, but to retain my rights to the code so that I can get
   something if somebody starts making lots of money by selling a program
   based on my work.

Bug Reports:  kop@acm.org

Author(s):    Karl O. Pinc <kop@acm.org>

