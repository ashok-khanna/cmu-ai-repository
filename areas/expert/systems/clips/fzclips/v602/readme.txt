FuzzyCLIPS Version 6.02
-----------------------

FuzzyCLIPS is an enhanced version of CLIPS developed at the National 
Research Council of Canada to allow the implementation of fuzzy expert 
systems. The modifications made to CLIPS contain the capability of 
handling fuzzy concepts and reasoning. It enables domain experts to 
express rules using their own fuzzy terms. It allows any mix of fuzzy 
and normal terms, numeric-comparison logic controls, and uncertainties 
in the rule and facts. Fuzzy sets and relations deal with fuzziness in 
approximate reasoning, while certainty factors for rules and facts 
manipulate the uncertainty. The use of the above modifications are 
optional and existing CLIPS programs still execute correctly.


Licence Requirements
--------------------

This software is provided by The National Research Council of Canada 
(called NRC) whose address for communications with respect to this 
software is:

   Knowledge Systems Laboratory
   Institute for Information Technology
   National Research Council Canada
   Ottawa, Ontario Canada K1A 0R6
   Electronic mail: fzclips@ai.iit.nrc.ca

Title and Conditions

NRC provides a fully paid up and non exclusive licence to the software 
package with the following conditions:

1. The software will be used for educational and research purposes only.
2. The licence does not include the right to sublicence the software, or 
   to make it available for independent use by third parties outside the 
   recipient organization.
3. Copies of the software may be made for use within the recipient 
   organization, however, copyright remains with NRC.
4. All publications arising from the use of the software shall duly 
   acknowledge such use in accordance with normal practices followed in 
   scientific research publications.
5. The software is provided in its current state and NRC assumes no 
   obligation to provide services, for example maintenance or updates.
6. All users are requested to provide their name, the name of their 
   organization and a mailing or email address so that we may track 
   the use of the software as well as provide information to users 
   as updates and enhancements are made.

Record of Use

Users are requested to inform NRC of any corrections, changes or extensions 
to the software. NRC would also appreciate being informed of noteworthy uses.

Value of the Software

This software is considered to have no market value.

Warranty

NRC disclaims any warranties, expressed, implied, or statutory, of any kind 
or nature with respect to the software, including without limitation any 
warranty of fitness for a particular purpose. NRC shall not be liable in any 
event for damages, whether direct or indirect, special or general, 
consequential or incidental, arising from the use of the software.



Access & Installation Information
---------------------------------

FuzzyCLIPS has been successfully compiled and tested on the following
machines:

        Sun Sparc workstations (using cc compiler)
        IBM PC DOS machines (using Borland C++ 4.0)
        Macintosh II (using the MPW C 3.3 compiler)

FuzzyCLIPS is available via anonymous ftp from ai.iit.nrc.ca and via the
World Wide Web (WWW) using URL designation 

        http://ai.iit.nrc.ca/fuzzy/fuzzy.html

After connecting to the system with ftp do the following:

1. cd pub/fzclips
2. binary             (binary transfers are required)
3. get fzclips.tar.Z  (unix version - compiled for sun workstation
                       - tar'd and compressed)
      or
   get fzclips.sea.hqx (Macintosh version - self extracting archive
                        format created with Stuffit Deluxe which
                        has been converted to binhex format)
      or
   get fzclips.exe    (PC version - self extracting archive format 
                       created with PAK)
      or
   get fzclips.doc.ps (FuzzyCLIPS documentation - postscript file)

The documentation is only included with the unix version (fzclips.tar.Z 
- both postscript format and framemaker format). If the framemaker files
are required by others then they can be made available on request.

If using the WWW to access FuzzyCLIPS you will be prompted to provide your 
name and address of your organization and then will be able to access one 
or all of the documents.

On a unix system the following commands are used to install FuzzyCLIPS.

    uncompress fzclips.tar.Z  (not required if accessed from WWW since
                               decompression will already be done)
    tar -xvf fzclips.tar

Please note that the executables (FZ_CLIPS_shower and FZ_XCLIPS_shower)
are compiled for the Sun OS. In particular they are compiled with
a simulator and interface for a shower control problem that requires
that NeWS be available on the Sun workstation. This means that the 
version of Sun OS must be prior to Solaris 2 which has dropped support
for NeWS. Therefore if you have another unix platform (HP, SGI, etc.)
or Sun OS without support for NeWS you will need to make a new version
of the executables. See the file makefile.x and create a FZ_CLIPS or
FZ_XCLIPS version without the shower GUI cod. Note that it will
be necessary to set the appropriate flags in setup.h and main.c or xmain.c
as indicated in the comments in makefile.x. In setup.h it is necessary
to also set the flag ANSI_COMPILER correctly as well as the flag which
identifies your operating system (e.g. UNIX_V).


On a Macintosh system use a Binhex program to extract the fzclips.sea 
file then double-click on the fzclips.sea file and it will 
automatically uncompress and install the system. Note that if you 
have a version of the Stuffit file compression program you could 
extract only the parts that you need instead of the entire system.

On a PC system the program fzclips.exe when executed will uncompress and 
install the FuzzyCLIPS system. Execute the program with the following 
commands:

    mkdir /fzclp602    - create a directory for the files to be unpacked 
                         into; the fzclips.exe file should be in this 
                         directory
    cd /fzclp602
    fzclips /path      - the /path is necessary to recreate the correct 
                         directory structure; if omitted then all files 
                         will be placed in the current directory without 
                         any sub-directories.

If you have a version of the PAK archiving/compression program then you 
could extract only the parts that you need instead of the entire system.
