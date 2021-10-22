11/25/91
Contents of this disk: 

     TRAN1SP.ZIP  --  The translation program and its data for Spanish.
     PCL.ZIP      --  A copy of the thesis describing the program
                      in Hewlett-Packard Laser Jet format.
     PCW.ZIP      --  A copy of the thesis describing the program
                      in PC-Write format.
     ICON386      --  The ICON programming language for an 80386
                      processor running MS-DOS with three megabytes
                      or more of memory.
     ICON088      --  The ICON programming language for an 8088 
                      processor running MS-DOS with 640K


The following MS-DOS directory structure is assumed:

ICON386
    |
    |---- SOURCE
    |
    |---- PROGS
    |
    |---- DATA

To un-zip a file while preserving the directory structure, use the following 
command:   pkunzip -d -o -JHSR <zip-file-name> . 

Put the ICON translator and executor (ICONT and ICONX) as well as any batch 
files in the ICON386 directory.  Put the source (.ICN) program in the SOURCE 
directory.  Compile the source program, and put the executable (.ICX) program 
in the PROGS directory.

The program should be compiled and run with ICON386 or another version of ICON 
supporting a large amount of memory (i.e. 3 megs or more).  However, the 
program can be compiled and run under ICON for the 8088 or another version of 
ICON which supports only a small amount of memory (i.e. 640K), but the size of 
the semanticon will have to be kept small.

Your path statement should include a reference to the ICON386 directory.  To 
execute the machine translation program type: TRAN1 .  The results will be 
placed in the DATA directory.

The batch files included on this disk assume that the translator is named 
ICON386T (not ICONT), and the executor is named ICON386X (not ICONX).  (This 
avoids confusion when more than one version if ICON is used on the same 
system.)  You should either change the names in the batch files to match the 
names on your system, or rename your translator and executor to match the 
expectations of the batch files. 

For more information on the implementation of the program read Chapter 4 of
the enclosed thesis.  You should also read the comments in the TRAN1.ICN 
source program and the TRAN1.BAT batch file.
