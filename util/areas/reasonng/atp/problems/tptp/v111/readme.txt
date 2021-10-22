
  +-------------------------------------------------------------------------+
  | This file contains important information, and should be read completely |
  | and carefully. Last updated Tue Jul 5 05:14:27 +1000 1994               |
  +-------------------------------------------------------------------------+

Description
-----------
The TPTP (Thousands  of Problems for  Theorem Provers)  Problem  Library  is  a
collection of test problems for Automated Theorem Proving systems (ATPs), using 
the clausal normal form  of 1st order predicate logic.  The TPTP aims to supply 
the ATP community with the following :
1. A  comprehensive list  of the ATP test problems that are available today, in
   order to provide a simple and unambiguous reference mechanism.
2. New generalized variants of  those problems  whose original presentation  is
   hand-tailored towards a particular automated proof.
3. The  availability of  these problems  via FTP  in a  general-purpose format, 
   together with a  utility to convert  the problems  to existing ATP  formats.
   (Currently the  METEOR, MGTP,  OTTER,  PTTP, SETHEO,  and SPRFN formats  are 
   supported,  and the  utility can  easily be extended  to produce any  format 
   required.)
4. A comprehensive list of references and other interesting information on each 
   problem.
5. General guidelines outlining the requirements for ATP system evaluation.

The TPTP is the work of Geoff Sutcliffe, Christian Suttner, and Theodor Yemenis.
The TPTP was originally compiled  at The University of  Western Australia,  and
is now being maintained  at the  Department of  Computer  Science,  James  Cook
University, Australia.  The TPTP  is also  supported  and  distributed  by  the
Institut fuer Informatik, TU Muenchen, Germany.

The TPTP  is regularly updated with new problems,  additional information,  and 
enhanced utilities. If you would like to be kept informed of such developments, 
please email one of us. Our addresses are:
    Geoff Sutcliffe   - geoff@cs.jcu.edu.au                (FAX: +61-77-814029)
or  Christian Suttner - suttner@informatik.tu-muenchen.de  (FAX: +49-89-526502)


Releases
--------
Each release of the TPTP is  identified by a version number, an edition number,
and a  patch level, in  the form:  TPTP v<Version>.<Edition>.<Patch level>. The
version  number enumerates  major new releases of the TPTP, in which  important
new features have been added.  The edition number is incremented  each time new 
problems are added to the current version.  The patch level is incremented each 
time errors, found in the current edition, are corrected. 

This release is v1.1.1.


Files
-----
ReadMe - This file.
TPTP-v1.1.1.tar.Z - The TPTP problem library, which expands to :
  + Problems  - The problem files directory with subdirectories for each domain.
                The  subdirectories  contain  problem  files  with  the clauses 
                specific to each problem.  
  + Axioms    - The axiom set directory, containing axiom set files  (these are
                merged into the problem files).
  + TPTP2X    - A  directory  of Prolog  source files,  containing  the  tptp2X 
                utility.  The tptp2X  utility converts  TPTP problems  from the 
                TPTP format to  formats accepted by existing ATP programs,  and 
                creates problem variants by reordering the clauses and literals
                in problems.  The Prolog  code in  TPTP2X/tptpread may  also be 
                used directly to read problem files.
  + Scripts   - A directory  containing  C shell scripts  for manipulating  the 
                TPTP. Each script is described in Scripts/ReadMe.
  + Documents - A directory containing documents that relate to the TPTP :
      + Abbreviations   - A  list  of the  abbreviations used  in the  semantic 
                          names of problems and axiom sets (see below).
      + AxiomList       - A  list of  the axiom  sets in  the TPTP,  giving the 
                          canonical name,  semantic name,  number of  versions, 
                          and one line description.
      + History         - A history of  the changes made to the TPTP, upto this
                          release.
      + ProblemList     - A list  of all the problems in the  TPTP,  giving the
                          canonical  name,  semantic name,  number of versions, 
                          and one line description.
      + ProblemSynopsis - A list of  all the problems in the  TPTP,  giving the
                          number of clauses, percentages of non-Horn, unit, and
                          equality  clauses,  an indicator  whether or  not the
                          problem is  propositional,  and the average number of
                          literals per clause.
      + ReadMe          - This file.
      + ReverseIndex    - An  index from existing known  names for  problems to 
                          their TPTP file names.
      + Synopsis        - Statistics on the TPTP and the  structure of the TPTP 
                          problem domains.
      + Template        - A template for submitting new TPTP problems.
      + Users           - A list of registered TPTP users.
TR-v1.0.0.ps.Z - A  technical report  describing  the TPTP.  The report  may be 
                 updated in each release of the TPTP.


Problem and Axiom Set File Names
--------------------------------
Problem file names  are in the form DDDNNN-V.p and DDDNNN-V.MMM.p,  while axiom
file names  are in the form DDDNNN-E.ax  and DDDNNN-E.eq. DDD is a three letter 
mnemonic for the domain of the problem/axiomatisation;  NNN is an index, unique 
within the domain, for that problem/axiomatisation;  V is the version number of 
the problem (some problems have  several different presentations, each of which 
is considered to be  a different version of the same problem);  MMM is the size 
of the problem,  used only for those problems that are generated according to a 
size parameter;  E is the axiomatisation extension number.  The file type is .p 
for  problem  files,  .ax  for  theory  specific   axiom  files,  and  .eq  for 
substitution axiom files.

The  file  names   provide  an  unambiguous   reference  to  the  problems  and 
axiomatisations.  Problems and  axiomatisations  sets have also  been allocated 
semantic names,  which may  be used  to augment  the standard  file names.  For 
information on  this,  see the  information about  Scripts/tptp_naming  in  the 
Scripts/ReadMe file.


Conditions of use
-----------------
By providing  this library  of ATP problems,  and a specification  of how these 
problems should  be presented to ATP systems,  it is our intention to place the 
testing,  evaluation, and comparison of ATP systems on a firm footing.  To this 
end, you should abide by the  following conditions when using TPTP problems and 
presenting your results.  
1. The specific version,  edition,  and patch  level of the TPTP,  used as  the 
   problem source, must be stated.
2. Each problem must be referenced by its unambiguous syntactic name. 
3. No  clauses/literals may  be added/removed  without  explicit notice.  (This 
   holds  also for removing equality axioms  when built-in equality is provided 
   by the prover.)
4. The  clauses/literals  may not  be rearranged  without explicit  notice.  If 
   clause and  literal reversing  is done by the tptp2X utility,  the reversals 
   must be explicitly noted.
5. The header  information in  each problem  may not  be used by the ATP system 
   without explicit notice.  Any information  that is given  to the ATP system, 
   other than that in the "input_clause"s,  must be explicitly noted (including 
   any system switches or default settings).


Please email one of us if :
---------------------------
1. You find any mistakes in the TPTP.
2. You are able to provide further information for a TPTP problem.
3. You  want  to  contribute  a  problem  to  the TPTP.  Please use the problem 
   template that comes with the distribution, and fill in header information as 
   far as possible. Any unambiguous representation will do for the clauses.
4. You have further suggestions for improving the TPTP library.


General Disclaimer
------------------
Every effort has been made to ensure that the TPTP problems have been correctly 
presented, and that appropriate acknowledgments have been made.  However, we do 
not guarantee that we have succeeded,  and accept  no  responsibility  for  any 
errors or omissions.  We will gratefully receive comments and  corrections.


Copyright
---------
The TPTP is copyrighted (c) 1993, 1994,  by Geoff Sutcliffe, Christian Suttner,
and Theodor Yemenis. Use and verbatim redistribution of the TPTP are permitted. 
Distribution of  any modified  version or  modified part of  the TPTP  requires 
permission.


Acknowledgements 
----------------
We are indebted to the following people and organizations, who have contributed 
problems and helped with the construction of the TPTP. Particular thanks to the
beta-testers who provided useful feed back (marked with an *).

Geoff Alexander*, the ANL group (especially Bill McCune*), Dan Benanav,
Woody Bledsoe, Maria Poala Bonacina, Heng Chu, Tom Jech, Reinhold Letz,
Thomas Ludwig, Max Moser, Gerd Neugebauer, Xumin Nie, Jeff Pelletier, 
David Plaisted, Joachim Posegga, Art Quaife, Alberto Segre*, John Slaney, 
Mark Stickel*, Bob Veroff, TC Wang.

