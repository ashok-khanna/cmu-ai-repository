This directory contains the Caml Light system, version 0.6.

FILES: (files marked (B) must be transferred in binary mode
        files marked (A) in text mode)

  cl6unix.tar.Z     (B) Complete source code for Unix machines, plus a
                        bootstrap compiler.
                        Extract with "zcat cl6unix.tar.Z | tar xBf -".

  cl6refman.ps.Z    (B) Reference manual and user's manual (145 pages)
                        in compressed Postscript format.
                        Extract with "uncompress cl6refman.ps.Z".

  cl6refman.dvi.Z   (B) Reference manual and user's manual (145 pages)
                        in compressed DVI format.
                        Extract with "uncompress cl6refman.dvi.Z".

  cl6refman.txt     (A) Reference manual and user's manual (133 pages)
                        in plain ASCII text format.

  cl6refman.prn     (A) Reference manual and user's manual (133 pages)
                        in plain ASCII with underline and overstrike,
                        for printing on an impact printer
                        or viewing with "less".

  cl6tutorial.ps.Z  (B) "Functional programming using Caml Light" (136 pages)
                        in compressed Postscript format.
                        Extract with "uncompress cl6tutorial.ps.Z".

  cl6tutorial.dvi.Z (B) "Functional programming using Caml Light" (136 pages)
                        in compressed DVI format.
                        Extract with "uncompress cl6tutorial.dvi.Z".

  cl6tutorial.txt   (A) "Functional programming using Caml Light" (130 pages)
                        in plain ASCII text format.

  cl6tutorial.prn   (A) "Functional programming using Caml Light" (130 pages)
                        in plain ASCII with underline and overstrike,
                        for printing on an impact printer
                        or viewing with "less".

  cl6macbin.sea.hqx (A) Binaries for the Macintosh version.
                        Extract with BinHex to get a self-extracting Compactor
                        archive.

  cl6pc386bin.zip   (B) Binaries for the 80386 PC version.
                        They run only on 80386 or 80486 processors,
                        in protected 32-bit mode.
                        Extract with "pkunzip -d cl6pc386bin".

  cl6pc86bin.zip    (B) Binaries for the 8086 PC version.
                        They run on any PC, in native 16-bit mode.
                        Extract with "pkunzip -d cl6pc86bin".

  cl6macsrc.sea.hqx (A) Source code for the Macintosh version.
                        Not required to run Caml Light. Transfer this archive
                        only if you want to read the source code, or
                        recompile the system yourself.
                        Extract with BinHex to get a self-extracting
                        Compact Pro archive.

  cl6pc386src.zip   (B) Source code for the 80386 PC version.
                        Not required to run Caml Light. Transfer this archive
                        only if you want to read the source code, or
                        recompile the system yourself.
                        Extract with "pkunzip -d cl6pc386src".

  cl6pc86src.zip    (B) Source code for the 8086 PC version.
                        Not required to run Caml Light. Transfer this archive
                        only if you want to read the source code, or
                        recompile the system yourself.
                        Extract with "pkunzip -d cl6pc86src".

  cl5stgem.arc      (B) Binaries for the Atari ST version.
                        Not yet upgraded to version 0.6.
                        Contributed by Christian Carrez (CNAM).
                        Extract with arc.prg.

  camlot51.tar.Z    (B) High-performance Caml Light to C compiler.
                        Not yet upgraded to version 0.6.

OVERVIEW:

  Caml Light is a small, portable implementation of the ML language.
  that runs on most Unix machines. It has also been ported to the
  Macintosh and to the IBM PC.

  Caml Light implements the Caml language, a functional language from
  the ML family. Caml is quite close to Standard ML, though not strictly
  conformant. There are some slight differences in syntax and semantics,
  and major differences in the module system (these changes were
  required to support separate compilation).

  Caml Light is implemented as a bytecode compiler, and fully
  bootstrapped.  The runtime system and bytecode interpreter is written
  in standard C, hence Caml Light is easy to port to almost any 32-bit
  platform. The whole system is quite small: about 100K for the runtime
  system, and another 100K of bytecode for the compiler. 1.2 megabyte of
  memory is enough to recompile the whole system. This stands in sharp
  contrast with other implementations of ML, such as SML-NJ, that
  requires about ten times more memory. Performance is quite good for a
  bytecoded implementation: five to ten times slower than SML-NJ.

  Caml Light comes in two flavors: a classical, interactive, toplevel-based
  system; and a standalone, batch-oriented compiler that produces standalone
  programs, in the spirit of the Unix cc compiler. The former is good for
  learning the language and testing programs. The latter integrates more
  smoothly within programming environments. The generated programs are quite
  small, and can be used like any other command.


NOTES ON THE PC 86 AND PC 386 VERSIONS:

  To unpack the distribution, you will need the "pkunzip" program version 2.
  (Earlier versions such as 1.10 or 1.93 will not work.)
  This program is freely available from most archive sites.
  You can get it by anonymous FTP from:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/msdos/zip
            file:       pkz204g.exe

  To extract the Postscript or DVI code for the documentation,
  you will need the "compress" program. It is available by anonymous FTP from:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/msdos/arcutils
            file:       compr16.zip

  You can also uncompress on a Unix machine, with the "uncompress" command.

  The DVI files can be printed on a variety of printers (Postscript printers,
  HP LaserJets, Epson dot matrix, ...). The DVI printing programs are available
  by anonymous FTP from:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/msdos/tex

NOTES ON THE MACINTOSH VERSION:

  To unpack the distribution, you will need a program for extracting binhex
  files.  One of the following will do:

      BinHex 4 or 5   StuffIt 1.5     UnStuffIt 1.5   Compact Pro 1.3

  These are public domain or shareware programs. For instance, you can get
  UnStuffIt 1.5.1 by anonymous FTP:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/macintosh/appl
            file:       unstuffit151.bin

  Use one of these programs to transform the distribution file, which is
  is BinHex format, to a self-extracting (.sea) archive.
  Then, open the .sea archive like any other application, select and open the
  directory where the Caml Light files should reside, and click "Extract"; this
  recreates all files in the opened directory.
  If you don't trust self-extracting archives, you can also extract the
  files manually with Compact Pro.

  To extract the Postscript or DVI code for the documentation, try the Mac
  Compress program, available by anonymous FTP:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/macintosh/utilfil
            file:       maccompress304.sit

  You can also uncompress on a Unix machine, with the "uncompress" command.

  Once uncompressed, send the Postscript code to a Postscript printer
  with the SendPS application, available by anonymous FTP:

            host:       wuarchive.wustl.edu (128.252.135.4)
            directory:  mirrors/macintosh/appl
            file:       sendps.sit

  If you don't have a Postscript printer, you can print the DVI code on
  a StyleWriter or ImageWriter using OzTeX, available by anonymous FTP:

            host:       midway.uchicago.edu (128.135.12.73)
            directory:  pub/tex/macintosh
            files:      see the index in file README

