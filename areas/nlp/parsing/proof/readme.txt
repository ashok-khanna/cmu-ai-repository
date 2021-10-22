
	This file is available via anonymous ftp to scam.Berkeley.EDU
(128.32.138.1) as /misc/src/local/proof/README.


	This directory contains the documentation, library support,
and sources for 'proof', a natural language grammar scanner, in ./doc,
./lib, and ./src, respectively. You may see how the program behaves
when successfully built by doing 'rsh scam.Berkeley.EDU -l demo' and
following the directions.


INSTALLATION NOTES:


	'proof' has been successfully built on DECstation 3100s
running ULTRIX 4.2 and X11R5.
 
	In the Makefile, you will want to change the DIR variables for
your site, and get rid of "demo", DEMODIR, and FTPDIR, since you
probably won't be demoing or distributing 'proof' from your site.

	You'll also want to edit the site-dependent #defines at the
beginning of source module "motor.c".

	Library source avilability: the gdbm libraries are available
from prep.ai.mit.edu (the Free Software Foundation), the curses
library should come with the host operating system, and Jonathan Lee's
"stuff" library source is online here.



	I welcome all comments, via email to proof@xcf.Berkeley.EDU.
To be put on a 'proof' users' mailing list, send email to
proof-request@xcf.Berkeley.EDU, with "add me" in the subject line. You
can send mail to that list at proof-users@xcf.Berkeley.EDU.

	
		Thanks,

			Craig R. Latta
			latta@xcf.Berkeley.EDU

***
			
	Licensing:
	   
		    'proof' GENERAL PUBLIC LICENSE
	 (derived from the GNU EMACS GENERAL PUBLIC LICENSE)
		     clarified 20 September 1991
				   
		  Copyright (C) 1991 Craig R. Latta
     Everyone is permitted to copy and distribute verbatim copies
    of this license, but changing it is not allowed.  You can also
	use this wording to make the terms for other programs.

  The license agreements of most software companies keep you at the
mercy of those companies.  By contrast, our general public license is
intended to give everyone the right to share 'proof'.  To make sure
that you get the rights we want you to have, we need to make
restrictions that forbid anyone to deny you these rights or to ask you
to surrender the rights.  Hence this license agreement.

  Specifically, we want to make sure that you have the right to give
away copies of 'proof', that you receive source code or else can get it
if you want it, that you can change 'proof' or use pieces of it in new
free programs, and that you know you can do these things.

  To make sure that everyone has such rights, we have to forbid you to
deprive anyone else of these rights.  For example, if you distribute
copies of 'proof', you must give the recipients all the rights that you
have.  You must make sure that they, too, receive or can get the
source code.  And you must tell them their rights.

  Also, for our own protection, we must make certain that everyone
finds out that there is no warranty for 'proof'.  If 'proof' is
modified by someone else and passed on, we want its recipients to know
that what they have is not what we distributed, so that any problems
introduced by others will not reflect on our reputation.

  Therefore we (Craig Latta and the Experimental Computing Facility at
UC Berkeley) make the following terms which say what you must do to be
allowed to distribute or change 'proof'.

			COPYING POLICIES

  1. You may copy and distribute verbatim copies of 'proof' source
code as you receive it, in any medium, provided that you conspicuously
and appropriately publish on each copy a valid copyright notice
"Copyright (C) 1991 Craig R. Latta" (or with whatever year is
appropriate); keep intact the notices on all files that refer to this
License Agreement and to the absence of any warranty; and give any
other recipients of the 'proof' program a copy of this License
Agreement along with the program.  You may charge a distribution fee
for the physical act of transferring a copy.

  2. You may modify your copy or copies of 'proof' source code or
any portion of it, and copy and distribute such modifications under
the terms of Paragraph 1 above, provided that you also do the following:

    a) cause the modified files to carry prominent notices stating
    that you changed the files and the date of any change; and

    b) cause the whole of any work that you distribute or publish,
    that in whole or in part contains or is a derivative of 'proof'
    or any part thereof, to be licensed at no charge to all third
    parties on terms identical to those contained in this License
    Agreement (except that you may choose to grant more extensive
    warranty protection to some or all third parties, at your option).

    c) if the modified program serves as a text editor, cause it when
    started running in the simplest and usual way, to print an
    announcement including a valid copyright notice "Copyright (C)
    1991 Craig R. Latta" (or with the year that is
    appropriate), saying that there is no warranty (or else, saying
    that you provide a warranty) and that users may redistribute the
    program under these conditions, and telling the user how to view a
    copy of this License Agreement.

    d) You may charge a distribution fee for the physical act of
    transferring a copy, and you may at your option offer warranty
    protection in exchange for a fee.

Mere aggregation of another unrelated program with this program (or its
derivative) on a volume of a storage or distribution medium does not bring
the other program under the scope of these terms.

  3. You may copy and distribute 'proof' (or a portion or derivative of it,
under Paragraph 2) in object code or executable form under the terms of
Paragraphs 1 and 2 above provided that you also do one of the following:

    a) accompany it with the complete corresponding machine-readable
    source code, which must be distributed under the terms of
    Paragraphs 1 and 2 above; or,

    b) accompany it with a written offer, valid for at least three
    years, to give any third party free (except for a nominal
    shipping charge) a complete machine-readable copy of the
    corresponding source code, to be distributed under the terms of
    Paragraphs 1 and 2 above; or,

    c) accompany it with the information you received as to where the
    corresponding source code may be obtained.  (This alternative is
    allowed only for noncommercial distribution and only if you
    received the program in object code or executable form alone.)

For an executable file, complete source code means all the source code for
all modules it contains; but, as a special exception, it need not include
source code for modules which are standard libraries that accompany the
operating system on which the executable file runs.

  4. You may not copy, sublicense, distribute or transfer 'proof'
except as expressly provided under this License Agreement.  Any attempt
otherwise to copy, sublicense, distribute or transfer 'proof' is void and
your rights to use 'proof' under this License agreement shall be
automatically terminated.  However, parties who have received computer
software programs from you with this License Agreement will not have
their licenses terminated so long as such parties remain in full compliance.

  5. If you wish to incorporate parts of 'proof' into other free
programs whose distribution conditions are different, write to the
Experimental Computing Facility.  We have not yet worked out a simple
rule that can be stated here, but we will often permit this.  We will
be guided by the two goals of preserving the free status of all
derivatives of our free software and of promoting the sharing and
reuse of software.

Your comments and suggestions about our licensing policies and our
software are welcome!  Please contact
				   
		Experimental Computing Facility (XCF)
      Department of Electrical Engineering and Computer Sciences
		     199B Cory Hall, UC Berkeley
			  Berkeley, CA 94720
				U.S.A

			   NO WARRANTY

  BECAUSE 'proof' IS LICENSED FREE OF CHARGE, WE PROVIDE ABSOLUTELY
NO WARRANTY, TO THE EXTENT PERMITTED BY APPLICABLE STATE LAW.  EXCEPT
WHEN OTHERWISE STATED IN WRITING, FREE SOFTWARE FOUNDATION, INC,
RICHARD M. STALLMAN AND/OR OTHER PARTIES PROVIDE 'proof' "AS IS"
WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING,
BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY
AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE 'proof'
PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY
SERVICING, REPAIR OR CORRECTION.

 IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW WILL THE EXPERIMENTAL
COMPUTING FACILITY, CRAIG R. LATTA, AND/OR ANY OTHER PARTY WHO MAY
MODIFY AND REDISTRIBUTE 'proof' AS PERMITTED ABOVE, BE LIABLE TO YOU
FOR DAMAGES, INCLUDING ANY LOST PROFITS, LOST MONIES, OR OTHER
SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE USE OR
INABILITY TO USE (INCLUDING BUT NOT LIMITED TO LOSS OF DATA OR DATA
BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY THIRD PARTIES OR A
FAILURE OF THE PROGRAM TO OPERATE WITH PROGRAMS NOT DISTRIBUTED BY
FREE SOFTWARE FOUNDATION, INC.) THE PROGRAM, EVEN IF YOU HAVE BEEN
ADVISED OF THE POSSIBILITY OF SUCH DAMAGES, OR FOR ANY CLAIM BY ANY
OTHER PARTY.


