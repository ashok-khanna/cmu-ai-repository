Kyoto Common Lisp (KCL) is a complete implementation of Common Lisp written
by T. Yuasa (Department of Computer Science, Toyohashi University of 
Technology) and M. Hagiya (Research Institute for Mathematical Sciences, 
Kyoto University).  It runs on many different machines and is highly 
portable.  It executes very efficiently and it is superbly documented.  
KCL is being made available at no fee through the implementors' generosity.  
The complete sources are included.

                               LICENSE REQUIRED!

IMPORTANT: Although there is no fee, KCL is NOT in the public domain.  You
are authorized to obtain it only after signing and mailing in a license
agreement.  Before you ftp KCL files you MUST fill out and send in the
license agreement included in this message.  Otherwise, you are not
permitted to make copies of KCL.

                               KCL LICENSE FORM

To obtain the right to copy KCL, sign this license form and send it and 
a copy to:

       Special Interest Group in LISP
       Research Institute for Mathematical Sciences
       Kyoto University
       Kyoto, 606,  JAPAN

Once you have mailed the signed license form, you may copy KCL.  You do not 
have to wait for receipt of the signed form.

---------------------------------- cut here -------------------------------


                               LICENSE AGREEMENT
                                      FOR
                               KYOTO COMMON LISP

The Special Interest Group in LISP (Taiichi Yuasa at Department of Computer
Science, Toyohashi University of Technology and Masami Hagiya at Research
Institute for Mathematical Sciences, Kyoto University) (hereinafter referred
to as SIGLISP) grants to

USER NAME: _________________________________________

USER ADDRESS: ______________________________________
              ______________________________________

(hereinafter referred to as USER), a non-transferable and non-exclusive
license to copy and use Kyoto Common LISP (hereinafter referred to as KCL)
under the following terms and conditions and for the period of time 
identified in Paragraph 6.

1.  This license agreement grants to the USER the right to use KCL within
their own home or organization.  The USER may make copies of KCL for use
within their own home or organization, but may not further distribute KCL
except as provided in paragraph 2.

2.  SIGLISP intends that KCL be widely distributed and used, but in a manner
which preserves the quality and integrity of KCL.  The USER may send a copy 
of KCL to another home or organization only after either receiving permission
from SIGLISP or after seeing written evidence that the other home or
organization has signed this agreement and sent a hard copy of it to SIGLISP.
If the USER has made modifications to KCL and wants to distribute that
modified copy, the USER will first obtain permission from SIGLISP by written
or electronic communication.  Any USER which has received such a modified 
copy can pass it on as received, but must receive further permission for 
further modifications.  All modifications to copies of KCL passed on to other
homes or organizations shall be clearly and conspicuously indicated in all 
such copies.  Under no other circumstances than provided in this paragraph 
shall a modified copy of KCL be represented as KCL.

3.  The USER will ensure that all their copies of KCL, whether modified or
not, carry as the first information item the following copyright notice:

(c) Copyright Taiichi Yuasa and Masami Hagiya, 1984.  All rights reserved.
Copying of this file is authorized to users who have executed the true and
proper "License Agreement for Kyoto Common LISP" with SIGLISP.

4.  Title to and ownership of KCL and its copies shall at all times remain
with SIGLISP and those admitted by SIGLISP as contributors to the development
of KCL.  The USER will return to SIGLISP for further distribution
modifications to KCL, modifications being understood to mean changes which
increase the speed, reliability and existing functionality of the software
delivered to the USER.  The USER may make for their own ownership and use
enhancements to KCL which add new functionality and applications which employ
KCL.  Such modules may be returned to SIGLISP at the option of the USER.

5.  KCL IS LICENSED WITH NO WARRANTY OF ANY KIND.  SIGLISP WILL NOT BE
RESPONSIBLE FOR THE CORRECTION OF ANY BUGS OR OTHER DEFICIENCIES.  IN NO
EVENT SHALL SIGLISP BE LIABLE FOR ANY DAMAGES OF ANY KIND, INCLUDING
SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES, ARISING OUT OF OR IN CONNECTION
WITH THE USE OR PERFORMANCE OF KCL.

6.  This license for KCL shall be effective from the date hereof and shall
remain in force until the USER discontinues use of KCL.  In the event the 
USER neglects or fails to perform or observe any obligations under this 
Agreement, this Agreement and the License granted hereunder shall be 
immediately terminated and the USER shall certify to SIGLISP in writing that 
all copies of KCL in whatever form in its possession or under its control 
have been destroyed.

7.  Requests.  KCL is provided by SIGLISP in a spirit of friendship and
cooperation.  SIGLISP asks that people enjoying the use of KCL cooperate in
return to help further develop and distribute KCL.  Specifically, SIGLISP
would like to know which machines KCL gets used on.  A brief notice form is
appended to this agreement which the user is requested to send by email or
otherwise.  Please send in further notifications at reasonable intervals if
you increase the number and type of machines on which KCL is loaded.  You may
send these notices to another USER which is cooperating with SIGLISP for this
purpose.

USER

  DATE:  _________________________________________

  BY:  ___________________________________________

  TITLE:  ________________________________________

  ADDRESS:  ______________________________________
            ______________________________________


SIGLISP

  DATE:  _________________________________________

  BY:  ___________________________________________
       Taiichi Yuasa
       Department of Computer Science
       Toyohashi University of Technology
       Toyohashi, 440, Japan

  BY:  ___________________________________________
       Masami Hagiya
       Research Institute for Mathematical Sciences
       Kyoto University
       Kyoto, 606,  JAPAN


USER has loaded KCL on the following machines since (date):

Model Number     Production Name       Number of Machines


---------------------------------- cut here -------------------------------

                                 DOCUMENTATION

The principal documentation for KCL is, of course, the book "Common Lisp
The Language" by Guy L. Steele, Jr. with contributions by Scott E. Fahlman,
Richard P. Gabriel, David A. Moon, and Daniel L. Weinreb, Digital Press,
1984.  Implementation-specific details of KCL (debugging, garbage collection,
data structure format, declarations, operating system interface, 
installation) may be found in the 131 page "Kyoto Common Lisp Report" by
Taiichi Yuasa and Masami Hagiya, the authors of KCL.  This report is
available from:

	Teikoku Insatsu Inc.
	Shochiku-cho,
	Ryogae-cho-dori Takeya-machi Sagaru,
	Naka-gyo-ku,
	Kyoto, 604, Japan
	tel: 075-231-4757

A document describing how to install KCL is found in the file "install".

Each of the KCL primitives is thoroughly described by the "describe"
function, which is based on 340K bytes of documentation.

                                    SUPPORT

KCL is one of the most bug-free large software systems that we have ever 
used.  However, when bugs are found, they may be reported to the KCL bboard
(kcl@cli.com) hosted by Texas Austin.


