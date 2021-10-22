-*-text-*-

SPS

SPS Version 1.6.01 (Chez Scheme Version) 25 Mar 1993

This is the Semantic Prototyping System (SPS).  SPS is a suite of
programs, written in Scheme, for rapid prototyping and testing of
language definitions written using denotational semantics.  It
consists of an ML-style typechecker for a large subset of Scheme,
along with an LL(1) parser and transducer generator.

The system is available via anonymous ftp from ftp.ccs.northeastern.edu

It consists of 2 files in directory pub/wand/sps:

-rw-r--r--  1 wand         1768 May 20 11:28 README
-rw-r--r--  1 wand        69687 May 20 11:28 sps.tar.Z

Login as anonymous, use your name as password.  Set file type to I (Image or
Binary).  Send me E-mail to let me know you've gotten a copy, so I can send
updates if any.  shar files are also available if you prefer.

The current version of SPS is written in Chez Scheme.  Load it as follows:

  1.  Load Chez scheme.	
  3.  Execute (load ".....top.s")    where .... is the path name for the
directory where SPS resides.

If you intend to use the tools system seriously, it is recommended that you
re-boot scheme, loading the types system before dumping.  The resulting heap
image can be loaded by using Chez Scheme with the -h option in the command
line.  

As of 6 Jul 1993, the distribution includes patches for running SPS under MIT
Scheme 7.1.3 .  See the directory mit-scheme for details.

Mitchell Wand
College of Computer Science, Northeastern University
360 Huntington Avenue #161CN, Boston, MA 02115     Phone: (617) 373 2072
Internet: wand@ccs.neu.edu                         Fax:   (617) 373 5121







