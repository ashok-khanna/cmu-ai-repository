                                                            README file
                                                  Created on 07-Aug-1992
                                            Last Modified on 27-Jun-1994

[Introduction]

     We, the Institute for New Generation Computer Technology (ICOT),
have made our original and advanced software available to the public
free of charge in order to contribute toward the progress of computer
science.  Persons wanting to use this ``ICOT Free Software'' may
freely do so and may also freely modify, copy and distribute such,
provided that ICOT gives no warranty on this software.  We hope that
this software will be of use in your research and development
activities.

     A list of ICOT Free Software is provided in the ``ICOT Free
Software Catalogue.''  If you do not have a copy of this list, please
contact us at the address below.

	e-mail: ifs@icot.or.jp

        ICOT Free Software desk
        Institute for New Generation Computer Technology
        21th Floor, Mita Kokusai Bldg.
        4-28, Mita 1-chome,
        Minato-ku, Tokyo 108
        Japan

        FAX:    +81-3-3456-1618

    Note that general information on this software can be obtained in
the files archived in INFO.tar.Z, which includes documents on
copyright and conditions for use, Japanese Kanji code, KLIC (KL1 
language processor on UNIX), Common-ESP (ESP language processor on 
UNIX).


[Notes]

(1) ICOT holds the copyright of all the programs in this software.  
Read COPYRIGHT file in each archive.

(2) All source and document files in archives are readable on UNIX
machines.  They are archived and compressed on UNIX.  Japanese
Character code in these files is chiefly JIS code.  See INFO.tar.Z 
file for further information.

(3) You can access this software only by anonymous ftp.  IP address
of ICOT ftp server is ftp.icot.or.jp .  After you connect the server,
enter the 'ifs' directory.

(4) Programs, documents, or structure of archive files may be changed
without previous notice.  Refer to the change-log at the next section.

(5) Software programs are written in KL1 (Parallel logic programming 
language on Parallel Inference Machine), C, Prolog, ESP (Sequential 
Logic programming language on PSI), Common-ESP (ESP on UNIX machine).
Changes are required to install them on UNIX machines.

1: Small software programs written in KL1 can be executed on KLIC (KL1
Language System on UNIX) with a little modification.  KLIC is also
available on this ftp server.  See the files in INFO.tar.Z for further
information.

2: Software programs written in C can be installed without difficulty,
though it may be slightly difficult to install on System V UNIX.

3: Software programs written in Prolog can be executed with only a
slight modification if your Prolog system is based on DEC-10 Prolog.
Some programs are written in SICStus Prolog, the language processor
of which is sold from SICS (Swedish Institute of Computer Science).
Access sicstus-request@sics.se for further information.

4: Software programs written in ESP on PSI machines can be executed on
UNIX with Common-ESP with a slight modification.  Some of them have
Common-ESP versions, but you will have to modify others yourself.  See
the files in INFO.tar.Z for further information.


[Change Log]

[78] KLIC version 1: An implementation of KL1            20 June,1994
                     for general-purpose computers
	version-up.

[76] Intelligent Refiner fot Multiple Sequence Alignment
        version-up & Bug fixed.                          30 May, 1994

[9] CLP Language：cu-Prolog 				 20 May, 1994
	Bug fix & add sample programs			 27 June, 1994

[03] Pseudo Parallel System for KL1 on Sequential Inference Machine PSI-III
        version-up.                                      12 May,1994

[04] OS for Parallel Inference Machines: PIMOS
        version-up.                                      12 May,1994

[14] Constraint Logic Programming Language CAL on CESP   10 May,1994
	Ver 1.3 release.

[77] Protein Structure Visualization system
	version-up.					 19 April,1994

[03] Pseudo Parallel System for KL1 on Sequential Inference Machine PSI-III
        version-up.                                      29 March,1994

[04] OS for Parallel Inference Machines: PIMOS
        version-up.                                      29 March,1994

[84] Protein Structure Prediction System Based on Mulit-Level Description
	New release					 29 March,1994

[14] Constraint Logic Programming Language CAL on CESP    2 March,1994
	Ver 1.2 release

[76] Intelligent Refiner fot Multiple Sequence Alignment
        Bug fixed.                                        1 March,1994

[83] Protein Motif Knowledge-Base and Retriever based on Quixote
	New release				       16 February,1994

[80] Knowledge Representation Language: micro-Quixote
	New release				       27 December,1993

[76] Intelligent Refiner fot Multiple Sequence Alignment
        Bug fixed.                                     22 December,1993

[78] KLIC version 1: An implementation of KL1          17 December,1993
                     for general-purpose computers
	New release

[10] Dynamic Programming			       18 November,1993
	Bug fixed.

[14] Constraint Logic Programming Language CAL on CESP  9 November,1993
	Ver 1.1   Bug fixed & version-up.

[77] Protein Structure Visualization system		3 August,1993
	New release

[9] CLP Language：cu-Prolog 				30 July, 1993
	Bug fixed & version-up.

[11] Knowledge Representation Language
	Formal version release				29 July, 1993

[13] Parallel Nested Relational Database Management System
	Formal version release				28 July, 1993

[76] Intelligent Refiner for Multiple Sequence Alignment
	Version-up.					26 July, 1993

[74] Load distribution library :ldlib	                15 July, 1993
	New release

[72] KL1 to C compiler system (experimental version)    15 July, 1993
	New release

[52]   Go Play Game System GOG				31 April, 1993
	Version-up.

[18] Parallel Constraint Logic Programming System：GDCC	 (28Apr,1993)
        Revision of Shell, Compiler and Algebraic constraint solvers.

[75] Multiple Sequence Alignment by Parallel Iterative Aligner
	New release					5 April, 1993
[76] Intelligent Refiner for Multiple Sequence Alignment
	New release					5 April, 1993

[73] Process oriented language AYA			29 March, 1993
	New release

[33] Morphological Dictionary for Japanese		18 March, 1993
	Add UNIX version of the syllabication program.
[36] Sentence Retrieval Tool				15 March, 1993
	Add X-Window version.

Oct 12, 1992: 64 programs becomes ftp available. The following programs
  are revised:

[4] OS for Parallel Inference Machine: PIMOS	  	18 September
	Object code and source code have ben separated.
[5] A Concurrent Object-Oriented Language：A'UM-90	29 September
	Revised to aum-1.2c (Bug fix)．aum-pat-1.2b is a patch for
       	this program.
[9] CLP Language：cu-Prolog 				 7 October
	Bug fixed.
[14] Constraint Logic Programming Language：CAL (CESP version)
							14 August
	Revision of Boolean and Simplex constraint solvers.

[18] Parallel Constraint Logic Programming System：GDCC
							13 August
	Addition of the operation manual.

[19] Constraint Logic Programming Language：CAL (ESP version)
							14 August
	Revision of Boolean and Simplex constraint solvers.
[47] A Sentence Retrieval Tool: KWIC (ESP Version)
        (1)Add "Idiom Search"
        (2)Add "Character Wildcard Search"
        (3)Refine Text database


Sep 07, 1992: Anonymous ftp service for domestic users started.  
  58 programs became ftp available.
Aug 07, 1992: Anonymous ftp service started.  42 programs became ftp
  available.


[Directory Structure]

The identification number after each archive file name is the same as
that in ``ICOT Free Software Catalogue,'' and the directory
structure here corresponds the classification of the catalogue.

INFO.tar.Z	Archive of files for general information
README		This file.
README.j	Japanese version of the README file.

manuals/	Manuals and textbooks of the languages and OS

symbolic-proc/	Symbolic Processing

   pim-psi/	OS on PSI or PIM.
      psdpim	[03] Pseudo PIM (PIM emulator on PSI)
      pimos	[04] PIMOS (KL1 language system and OS)

   unix/	Software on UNIX.
      pdss	[01] KL1 programming environment on UNIX machine
      vpim	[02] Pim emulator on parallel UNIX machine
      aum	[05] Concurrent object oriented language
      pkl1	[72] KL1 to C compiler system (experimental version)
      klic/     [78] KL1 to C compiler and its runtime system

   pimos/	Software on PIMOS.
      exreps	[06] Experimental reflective programming system
      kl1graph	[07] Program visualization environment
      strtgysh	[08] Strategy management shell
      aya	[73] Process oriented language AYA
      ldlib	[74] Load distribution library

kbms-clp/	Knowledge representation, knowledge base and
		constraint logic prgramming

   unix/	Software on UNIX.
      cuprolog	[09] Constraint Logic Programming Language: cu-Prolog
      dp	[10] Dynamic Programming System
      m-qxt	[80] Knowledge Representation language: micro-Quixote

   cesp/	Software on Common-ESP.
      cal-cesp	[14] Constraint Logic Programming Language CAL

   simpos/	Software on SIMPOS.
      kappa2	[12] Nested Relational Database Management System
      chal	[15] Hierarchical Constraint Logic Programming Language
      cal-esp	[19] Constraint Logic Programming Language CAL
      knov	[21] Knowledge Verification System

   pimos/	Software on PIMOS.
      quixote	[11] Knowledge Representation Language
      kappa-p	[13] Parallel Nested Relational Database Management System
      robot	[16] Robot Design Support System
      p-chal	[17] Hierarchical Constraint Parallel Solver 
      gdcc	[18] Parallel Constraint Logic Programming System
      voronoi	[20] Voronoi Diagram Construction Program

   klic/        Software on KLIC.
    *preparing* [79] Knowledge Representation Language: Quixote KLIC version


solver-prover/	System for problem solvers, theorem provers

   unix/	Software on UNIX.
      bmtp	[24] Boyer-Moore Theorem Prover
      kore-ie	[25] Forward Chaining Inference System
    *preparing* [26] Functional Language: Qute
    *preparing* [81] Parallel Theorem Prover: MGTP/G Prolog version
    *preparing* [82] Parallel Theorem Prover: MGTP/N Prolog version

   simpos/	Software on SIMPOS.
      papyrus	[23] Program Generation System
    *preparing* [27] SAM - A Symbolic and Algebraic Manupulation System
      euod	[28] Reasoning System
      fuzclust	[29] Fuzzy Clustering Tool

   pimos/	Software on PIMOS.
      mgtp	[22] Parallel Model Generation Theorem Prover
      ppss	[30] Parallel Problem Solving System
     *updating* [31] Argus Verification System: Argus/V
      sme	[32] Structure-Mapping Engine

natural-lang/	Natural language analysis

   unix/	Software on UNIX.
      morphdic	[33] Morphological Dictionary for Japanese
      lug	[34] Localized Unification Grammar and Grammar rules
      rdg	[35] Dependency Grammar for Japanese
      synana	[41] Syntactic Analyzer
      jpnsgen	[43] Japanese Sentence Generator

   cesp/	Software on Common-ESP.
      kwic-cesp	[36] Sentence Retrieval Tool
      morphana	[37] Morphological Analyzing Program
      linguist	[38] Grammar Writing Support System
      sdiv	[44] Sentence Dividing Tool			

   simpos/	Software on SIMPOS.
      cil	[40] Linguistic Knowledge Description Language
      sum	[45] Summarizing Support System
      icotext	[46] Support system for Generating Controlled
			Japanese Text and Semantic Structures
      kwic-esp	[47] Sentence Retrieval Tool
      utter	[48] Experimental Dialogue System with Pragmatic
			Utterance Selection Mechanism
      txtstrct	[49] Text Structure Analysis System
      disc	[50] Experimental Discourse Analyzer

   pimos/	Software on PIMOS.
      pax	[39] Parallel Parsing System
      dulcinea	[42] Experimental System for Argument Text Generation
      laputa	[51] Parallel Processing Based Natural Language
			Analysis Tool

exper-apps/	Applications programs of parallel logic programming.

   unix/	Software on UNIX.
      proview	[77] Protein Structure Visualization system

   simpos/	Software on SIMPOS.
      gog-esp	[52] Go Play Game System

   pimos/	Software on PIMOS.
      gog-kl1	[53] Parallel Go Play Game System
      helic2	[54] Parallel Legal Reasoning System
      aligndp	[55] Multiple Sequence Alignment by 3 dimensional
			Dynamic Programming (Genetic Information Processing)
      alignsa	[56] Multiple Sequence Alignment by Simulated
			Annealing (Genetic Information Processing)
      celplace	[57] Standard Cell Placement Experimental System
      lsirout	[58] LSI Routing Program (LSI CAD)
      logisim	[59] Parallel Logic Simulator (LSI CAD)
      gpsstap	[60] Group Problem Solving System for Task
			Allocation Problems
      mendels	[61] Concuurrent Program Development System
      pmonitor	[62] KL1 Execution Data Collecting Tool
      consort	[63] Combined Constraint Solver
      desq	[64] Design Support System based on Qualitative Reasoning
      cohlex	[65] Experimental Parallel Hierarchical Recursive Layout System
      colodex	[66] Cooperative Logic Design Expert System
      examds	[67] Cooperative Logic Design Expert System
      seqanal	[68] Experimental Adaptive Model-Based Diagnostic System
      cbcdss	[69] Experimental Sequence Analisys System
		        (Genetic Information Processing)
      rodin	[70] Case-Based Circuit Design Support System
      mmi	[71] A Diagnostic and Control Expert System based on a 
                        Plant Model
      multialign[75] Multiple Sequence Alignment by Parallel Iterative Aligner
      editalign [76] Intelligent Refiner for Multiple Sequence Alignment
      qxt_motif [83] Protein Motif Knowledge-Base and Retriever based on 
                        Quixote
      mssd      [84] Protein Structure Prediction System Based on Mulit-Level 
			Description
----------------------------------------------------------------END OF README
