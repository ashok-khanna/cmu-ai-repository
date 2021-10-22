This subtree contains the source files to Texas Instruments' PC-SCHEME,
a Scheme implementation which runs on PCs and clones.  TI has made the
source available to us under certain conditions, e.g. that their copyright
notice remains intact and that any improvements and "noteworthy uses"
be returned to TI.  The official copyright notice follows shortly.

Files in subdirectories Disk1-4 contain verbatim contents of the four
1.2 Mb disks which came from TI.  Note that the files are untranslated;
thus BINARY transfer to a PC (via ftp or zmodem, for example) will yield
PC-format .EXE and ASCII files.  If you want to read the ASCII files on
UNIX, you'll find CR chars (as well as newlines) unless you use the 
unixify command (or some equivalent) to convert them.  The CRs may not
get in your way if you are just browsing.

The files are also contained in four ZIP archives, using relative
pathnames.  This provides a convenient way of moving the whole shebang
to a PC, if you are into PC archives.

Please note that the state of these sources is unknown.  They include
ASM and C files which used now-obsolete assemblers and compilers (MASM
4.0 and Lattice 3.05), and may have a variety of other local (to Dallas)
ideosyncrasies.  As a number of us are interested in exploring this code,
it makes sense to share intersting discoveries and progress; please report
such developments to me, ward@mit.edu, for posting to the MIT community
and (if interest warrants) beyond.

The sources and notice of related developments will live on HX.LCS.MIT.EDU,
in the directory /projects/TI-Scheme.

========================================================================
TI's Copyright Notice follows:
========================================================================

		 TEXAS INSTRUMENTS PROGRAM LICENSE AGREEMENT
       Copyright (c) 1985, 1986, 1987, Texas Instruments Incorporated

This copyrighted software program is licensed, not sold.  Title to the
original Program remains at all times with TI and/or its licensors.
Permission to copy and distribute this Program and to use it for any purpose
is granted, subject to the following restrictions and understandings.

1.  Any copy made of this Program must include this copyright notice in full.

2.  Users of this Program agree to make their best efforts to return to TI
any improvement, enhancement or extension that they make, so that such
improvement, enhancement or extension may be considered for future releases
of this Program.  Such improvements, enhancements or extensions may be used
and/or adapted for use by TI, royalty free, without accounting to creator of
such improvements, enhancements or extensions in TI products.  User agrees to
inform TI of noteworthy uses of this Program.  Send improvements,
enhancements or extensions on magnetic media along with appropriate
documentation and/or information concerning noteworthy uses to

		Herb Roehrig
		Texas Instruments
		PO Box 1444, MS 7722
		Houston, TX  77251

3.  All materials developed as a consequence of the use of this Program
shall duly acknowledge such use, in accordance with the usual standards of
acknowledgement accepted in the publishing industry.

4.  THE PROGRAM IS NOT WARRANTED AND IS PROVIDED SOLELY ON AN "AS IS" BASIS.
TI AND ITS LICENSORS SHALL NOT BE RESPONSIBLE FOR INCIDENTAL, OR
CONSEQUENTIAL DAMAGES.

5.  In conjunction with products arising from the use of this program, there
shall be no use of the name of Texas Instruments Incorporated nor any
adaptation thereof in any marketing literature without the prior written
consent of TI in each use.

			  RESTRUCTED RIGHTS LEGEND

Use, duplication, or disclosure by the Government is subject to restructions
as set forth in subdivision (c) (1) (ii) of the Rights in Technical Data and
Computer Software clause at DFAR 252.227.7013.

		ATTN: Information Technology Group, M/S 2151
		Texas Instruments Incorporated
		PO Box 149149
		Austin, TX  78714-9149

========================================================================
End of official notice from TI
========================================================================

Following is a complete listing of the ZIP archives and, correspondingly,
of the original TI source disks:

C>zip -v a:disk1

PKZIP (tm)   FAST!   Create/Update Utility   Version 1.02   10-01-89
Copyright 1989 PKWARE Inc.   All Rights Reserved.   PKZIP/h for help

Searching ZIP: A:DISK1.ZIP

 Length  Method   Size  Ratio   Date    Time   CRC-32  Attr  Name
 ------  ------   ----- -----   ----    ----   ------  ----  ----
   4870  Implode   2092  58%  06-18-88  13:43  1e901976 --w  README.2
   3511  Implode   1712  52%  06-18-88  13:41  2f1194e1 --w  README.PRO
   1273  Implode    661  49%  06-18-88  12:09  26de8c09 --w  DO_UTIL.BAT
   1672  Implode    714  58%  06-09-88  10:30  62faf0df --w  DO_PCS.BAT
   1039  Implode    443  58%  02-11-88  12:13  a5a7ad74 --w  DO_AUTO.BAT
    650  Implode    408  38%  02-09-88  18:51  a5cc208f --w  DO_SCOOP.BAT
   1721  Implode    730  58%  02-10-88  14:28  07421216 --w  DO_EDWIN.BAT
   4477  Implode   1484  67%  06-18-88  11:09  18ef0cb9 --w  SCHBUIL2.BAT
   1230  Implode    526  58%  06-24-88  08:52  7d41fba7 --w  INSTALL.BAT
   1916  Implode    769  60%  06-06-88  11:16  9f87df44 --w  INSTALL2.BAT
    387  Implode    192  51%  08-26-87  11:00  0f559c29 --w  MEMORY.BAT
   2444  Implode    875  65%  06-18-88  15:14  ea1c9fdd --w  SCHBUILD.BAT
    512  Implode    349  32%  02-16-88  12:42  87e9cc91 --w  INSTALL3.BAT
   2303  Implode    967  59%  03-03-88  09:01  800208cb --w  INSTPRO.BAT
   2232  Implode   1314  42%  07-09-90  07:58  6f4223ba --w  README.1
   4628  Implode   1320  72%  06-18-88  13:47  e188ec92 --w  MASTER.BAT
 100352  Implode  44457  56%  05-06-86  09:02  17fb46f1 --w  TOOLS/LC.LIB
  52736  Implode  24949  53%  05-06-86  09:02  6ff4d9fa --w  TOOLS/LCM.LIB
  19573  Implode  13576  31%  04-27-87  00:00  2f70ecbb --w  TOOLS/PKARC.COM
  12242  Implode   8923  28%  04-27-87  00:00  97a6df4b --w  TOOLS/PKXARC.COM
    454  Implode    358  22%  08-26-87  11:00  f448c08f --w  TOOLS/DATER.COM
   9037  Implode   3723  59%  08-26-87  11:00  39e895ed --w  TOOLS/PBOOT.FSL
    886  Implode    315  65%  07-27-87  16:58  ebe462f2 --w  TOOLS/TOUCH.EXE
  70054  Implode  40427  43%  03-18-88  09:26  6a087e7d --w  TOOLS/LC1.EXE
  85052  Implode  45449  47%  03-18-88  09:27  e88a7941 --w  TOOLS/LC2.EXE
  43844  Implode  26405  40%  03-18-88  09:29  d1daae53 --w  TOOLS/LINK.EXE
  23938  Implode  15891  34%  03-18-88  09:31  dbeb5034 --w  TOOLS/MAKE.EXE
  83144  Implode  52116  38%  03-18-88  09:29  c0957f8b --w  TOOLS/MASM.EXE
  18026  Implode  10743  41%  10-16-85  04:00  c9e6c808 --w  TOOLS/MAPSYM.EXE
    215  Shrunk     141  35%  06-10-87  10:47  e9a8c93f --w  TOOLS/VERS8042.COM
  16768  Implode   4318  75%  02-14-86  14:31  3c9d3325 --w  EDWIN/ALLCOMS1.SCM
  15194  Implode   3644  77%  11-11-85  12:40  a9f4b6fa --w  EDWIN/ALLCOMS2.SCM
  11558  Implode   3139  73%  02-03-88  23:27  b0a15e35 --w  EDWIN/ALLCOMS3.SCM
   3470  Implode   1446  59%  10-14-85  09:16  4000b1e5 --w  EDWIN/ARGRED.SCM
   5975  Implode   2082  66%  10-14-85  09:16  939e5733 --w  EDWIN/ARGREDP.SCM
   4151  Implode   1487  65%  06-11-87  07:50  5049fc5f --w  EDWIN/AUTOLOAD.SCM
   6144  Implode   1911  69%  10-14-85  09:16  35db334b --w  EDWIN/BUFFER.SCM
   2619  Implode   1153  56%  10-14-85  09:16  393effae --w  EDWIN/BUFSET.SCM
   3564  Implode   1309  64%  10-14-85  09:16  73cc8c79 --w  EDWIN/BUFSETP.SCM
   2843  Implode   1262  56%  10-14-85  09:17  2e11ca70 --w  EDWIN/CHARMAC.SCM
   4128  Implode   1562  63%  10-14-85  09:17  4bd4d0fb --w  EDWIN/CHARSET.SCM
   3715  Implode   1508  60%  05-27-88  14:18  ae8d8f77 --w  EDWIN/COEDWIN.SCM
   2930  Implode   1233  58%  06-11-87  08:41  7f3fe2c3 --w  EDWIN/COEDWIN2.SCM
   2048  Implode    960  54%  10-24-85  20:13  2425ea90 --w  EDWIN/COEDWIN3.SCM
   2053  Implode   1018  51%  02-10-88  13:25  ebfa1e44 --w  EDWIN/COEDWIN4.SCM
   3657  Implode   1558  58%  10-18-85  06:20  971e60bc --w  EDWIN/COMFUN.SCM
   2780  Implode   1313  53%  10-14-85  09:17  ddac9814 --w  EDWIN/COMMAC.SCM
   6400  Implode   1902  71%  02-10-86  10:38  99a7d718 --w  EDWIN/COMTABV.SCM
   5721  Implode   1781  69%  10-14-85  09:18  421b286c --w  EDWIN/CURR.SCM
   2029  Implode   1057  48%  10-14-85  09:18  f04badc0 --w  EDWIN/DE.SCM
     29  Stored      29   0%  06-24-86  15:26  a9052f6e --w  EDWIN/DEMSTART.SCM
   2029  Implode   1008  51%  02-10-88  13:22  e702bb59 --w  EDWIN/DOEDWI2A.SCM
     83  Shrunk      70  16%  06-05-86  23:21  ccc09718 --w  EDWIN/DOEDWIN1.SCM
     83  Shrunk      70  16%  06-05-86  23:21  05bdc85f --w  EDWIN/DOEDWIN2.SCM
     83  Shrunk      70  16%  06-05-86  23:21  faf4c0f1 --w  EDWIN/DOEDWIN3.SCM
   3249  Implode    843  75%  10-14-85  09:18  2e86718b --w  EDWIN/DWIND.SCM
   3884  Implode   1215  69%  08-25-87  14:46  1bbc4bd5 --w  EDWIN/EDINIT.SCM
   8088  Implode   2216  73%  10-18-85  03:58  b0238dd4 --w  EDWIN/EMACROS.SCM
  12218  Implode   2869  77%  10-14-85  09:19  18d1f22f --w  EDWIN/INCSER.SCM
   4096  Implode   1441  65%  02-10-86  10:39  1e225eac --w  EDWIN/INITKEY.SCM
   2843  Implode   1258  56%  10-14-85  09:19  2e966951 --w  EDWIN/INITMAC.SCM
   5067  Implode   1926  62%  10-21-85  18:58  8e7defd2 --w  EDWIN/INSERT80.SCM
   7904  Implode   2274  72%  10-14-85  09:20  40025bb0 --w  EDWIN/IO.SCM
   2747  Implode   1294  53%  10-14-85  09:20  a249e4ce --w  EDWIN/KILL1.SCM
   2589  Implode   1278  51%  10-14-85  09:20  29eb00c3 --w  EDWIN/KILL2.SCM
   2493  Implode   1077  57%  06-11-87  10:08  30589843 --w  EDWIN/LDALL.SCM
   1821  Implode    959  48%  10-16-85  18:59  44a11c31 --w  EDWIN/LDCHSET.SCM
   8737  Implode   2432  73%  10-21-85  16:09  030c9cfc --w  EDWIN/LISP.SCM
   5137  Implode   1697  67%  04-01-87  16:05  f4d00f80 --w  EDWIN/MAIN.SCM
   3057  Implode   1089  65%  08-20-85  16:45  a55433f6 --w  EDWIN/MARKS.SCM
   5988  Implode   1750  71%  10-20-85  17:04  3044e229 --w  EDWIN/MESSAGES.SCM
   5316  Implode   1851  66%  10-20-85  21:37  8b07c354 --w  EDWIN/MODELN.SCM
   7541  Implode   2044  73%  10-14-85  09:22  862587ed --w  EDWIN/MOTION.SCM
   2369  Implode   1076  55%  10-14-85  09:22  ee308d17 --w  EDWIN/NSTRING.SCM
   4864  Implode   1718  65%  02-10-86  10:40  8b8bb79b --w  EDWIN/PARENS.SCM
  14405  Implode   3582  76%  10-21-85  18:57  384341c0 --w  EDWIN/REDISP1.SCM
  14408  Implode   3638  75%  10-21-85  18:58  d8b3b692 --w  EDWIN/REDISP2.SCM
  14475  Implode   3371  77%  10-14-85  09:24  b4db0159 --w  EDWIN/REGOPS.SCM
   3793  Implode   1504  61%  10-14-85  09:25  80c41fff --w  EDWIN/RING.SCM
   9789  Implode   2259  77%  10-14-85  09:25  3d964fb6 --w  EDWIN/SEARCH1.SCM
   8247  Implode   1910  77%  10-14-85  09:25  de331fc6 --w  EDWIN/SEARCH2.SCM
  10039  Implode   2428  76%  10-14-85  09:26  9eb3cf86 --w  EDWIN/SENTENCE.SCM
   4512  Implode   1568  66%  10-14-85  09:26  f7642855 --w  EDWIN/STRCOMP.SCM
  14702  Implode   4526  70%  10-18-85  03:56  ff7f59f5 --w  EDWIN/STRUCT.SCM
   8897  Implode   2804  69%  10-14-85  09:27  10af6da7 --w  EDWIN/THINGS.SCM
   7302  Implode   2477  67%  02-03-88  23:27  6b5a2f12 --w  EDWIN/TOPLEVEL.SCM
   2863  Implode   1259  57%  10-14-85  09:28  0269b7da --w  EDWIN/TRANSPOS.SCM
   3583  Implode   1285  65%  10-14-85  09:28  b68c6b10 --w  EDWIN/WORDS.SCM
  23313  Implode   8012  66%  02-09-87  14:21  ae13b855 --w  EDWIN/NEWFRAME.SCM
    515  Implode    367  29%  10-15-85  13:31  1748b88f --w  EDWIN/DUMMY.SCM
   6016  Implode   1127  82%  09-13-85  10:07  7d9a7159 --w  SCOOPS/CLASS.SCM
    556  Implode    226  60%  02-10-88  11:19  e294d5c4 --w  SCOOPS/COSCOOPS.SCM
   2176  Implode    524  76%  09-12-85  16:16  028c0901 --w  SCOOPS/DEBUG.SCM
   3275  Implode   1045  69%  09-12-85  16:17  b6dd71f5 --w  SCOOPS/EXPAND.SCM
   5001  Implode   1094  79%  09-12-85  16:17  eaed9997 --w  SCOOPS/INHT.SCM
   3392  Implode    889  74%  02-03-88  23:31  81bf1882 --w  SCOOPS/INSTANCE.SCM
   8111  Implode   1570  81%  09-12-85  16:17  ed5b8d3b --w  SCOOPS/INTERF.SCM
     55  Stored      55   0%  09-12-85  16:17  6139f0ac --w  SCOOPS/LDSCOOP.SCM
   5269  Implode   1149  79%  09-12-85  16:17  117ad972 --w  SCOOPS/METH2.SCM
   5139  Implode   1143  78%  09-12-85  16:18  7872486c --w  SCOOPS/METHODS.SCM
   8960  Implode   1331  86%  09-12-85  16:18  1b5628f9 --w  SCOOPS/SCSEND.SCM
   2647  Implode    630  77%  09-12-85  16:18  c0a107f1 --w  SCOOPS/SEND.SCM
   6023  Implode   1529  75%  09-13-85  12:40  340e08f7 --w  SCOOPS/UTL.SCM
    187  Shrunk     146  22%  02-09-88  15:19  4ac53c52 --w  SCOOPS/COMPILE.DEM
  29308  Implode   7364  75%  06-17-87  13:47  cd0b27aa --w  SCOOPS/TUTORIAL.SCM
  20395  Implode   6513  69%  06-17-87  15:16  1564d3e3 --w  SCOOPS/FRAME.SCM
   3292  Implode   1164  65%  06-24-86  15:10  1244461c --w  SCOOPS/SCPSDEMO.S
     29  Stored      29   0%  06-24-86  15:26  a9052f6e --w  SCOOPS/DEMSTART.SCM
 ------          ------  ---                                 -------
1015154          439744  57%                                     108

C>zip -v a:disk2

PKZIP (tm)   FAST!   Create/Update Utility   Version 1.02   10-01-89
Copyright 1989 PKWARE Inc.   All Rights Reserved.   PKZIP/h for help

Searching ZIP: A:DISK2.ZIP

 Length  Method   Size  Ratio   Date    Time   CRC-32  Attr  Name
 ------  ------   ----- -----   ----    ----   ------  ----  ----
   4020  Implode   1608  60%  09-25-86  18:29  efdfc66e --w  ALINK.ASM
  11480  Implode   3925  66%  05-20-88  16:30  01437ac9 --w  BLOCK.ASM
  22073  Implode   6050  73%  03-08-88  14:31  5f70ede2 --w  BORDER.ASM
  55390  Implode  12625  78%  05-11-88  16:42  a505dec3 --w  CIO.ASM
   9396  Implode   1649  83%  05-02-88  14:48  adc61c2a --w  CPRINT.ASM
  24477  Implode   6134  75%  05-09-88  09:46  8e19e9c2 --w  CPRINT1.ASM
  24488  Implode   6549  74%  03-11-87  13:42  36e6d110 --w  CREAD.ASM
  22585  Implode   4950  79%  03-07-88  13:53  7338004b --w  CWINDOW.ASM
  14466  Implode   4765  68%  02-16-88  13:30  4eb107b2 --w  EXPSMMU.ASM
  17552  Implode   6314  65%  02-16-88  13:38  4627799f --w  EXTSMMU.ASM
   3090  Implode   1401  55%  03-10-87  15:41  2d02f247 --w  FLO2HEX.ASM
   8144  Implode   2767  67%  09-29-86  16:52  c97d365e --w  GET_PATH.ASM
  65067  Implode  19256  71%  08-13-87  15:08  edb4e5e3 --w  GRAPHCMD.ASM
  98189  Implode  28834  71%  03-08-88  09:23  91cf7439 --w  GRAPHICS.ASM
   8944  Implode   2977  67%  03-16-87  14:17  45b4c5d4 --w  INTRUP.ASM
   2162  Implode   1185  46%  03-01-88  16:06  55d20cf7 --w  MACHTYPE.ASM
   1203  Implode    782  35%  06-03-86  09:14  4d0fc410 --w  MEMTYPE.ASM
  12857  Implode   3361  74%  04-08-87  16:51  b532e8a4 --w  MSDOS.ASM
   2751  Implode    930  67%  06-21-84  15:22  9b7c19e2 --w  MSDOS1.ASM
  54290  Implode  17339  69%  06-18-88  14:16  e3c56323 --w  PRO2REAL.ASM
   4997  Implode   2098  59%  03-10-88  14:34  27635508 --w  PROBID.ASM
   5958  Implode   2366  61%  03-14-88  15:07  c5b38ca8 --w  PROINTRP.ASM
  49215  Implode  11937  76%  05-23-88  16:38  b5372ef9 --w  PROIO.ASM
  13987  Implode   4137  71%  02-18-88  11:22  f2e060d9 --w  PROIOSUP.ASM
  34079  Implode   8650  75%  05-23-88  17:11  735aa093 --w  PROREAD.ASM
   8025  Implode   3072  62%  01-15-88  10:11  d2e85245 --w  PROSMMU.ASM
    636  Implode    294  54%  03-21-87  17:12  09d1f37a --w  GLUE.ASM
   2921  Implode   1135  62%  08-21-87  11:00  dde922a2 --w  SOURCES/ERRHAND.S
  12105  Implode   3327  73%  08-21-87  11:00  73423f38 --w  SOURCES/EXTEND.S
   3865  Implode   1484  62%  08-21-87  11:00  f9013806 --w  SOURCES/MACROS.S
   7435  Implode   2251  70%  02-10-88  16:44  36a59a05 --w  SOURCES/NEWWIN.S
   4806  Implode   1972  59%  08-21-87  11:00  3ee7d708 --w  SOURCES/STL.S
  15332  Implode   5882  62%  08-21-87  11:00  c9748807 --w  SOURCES/TUTFRAME.S
  24165  Implode   7147  71%  08-21-87  11:00  63637208 --w  SOURCES/TUTORENG.S
   6302  Implode   2283  64%  08-21-87  11:00  f7ced0b2 --w  SOURCES/UTILITY.S
    636  Implode    294  54%  08-21-87  11:00  09d1f37a --w  XLI/GLUE_LC.ASM
    647  Implode    296  55%  08-21-87  11:00  2f2e6cdd --w  XLI/GLUE_MS.ASM
   5329  Implode   1380  75%  08-21-87  11:00  6653e58f --w  XLI/PMATH.S
   7275  Implode   3188  57%  02-10-88  18:56  e66a94f5 --w  XLI/READ.ME
   4881  Implode   2083  58%  08-21-87  11:00  6fc100e6 --w  XLI/TRIG_LC.C
     13  Stored      13   0%  08-21-87  11:00  ec831ff4 --w  XLI/TRIG_LC.XLI
   5935  Implode   2329  61%  08-21-87  11:00  ecc69ec6 --w  XLI/TRIG_MS.C
     13  Stored      13   0%  08-21-87  11:00  47f783a4 --w  XLI/TRIG_MS.XLI
   7877  Implode   3123  61%  08-21-87  11:00  4d3bad44 --w  XLI/TRIG_TC.C
     13  Stored      13   0%  08-21-87  11:00  43dd356a --w  XLI/TRIG_TC.XLI
   6757  Implode   2875  58%  08-21-87  11:00  ab27779d --w  XLI/TRIG_TP.PAS
     13  Stored      13   0%  08-21-87  11:00  59767807 --w  XLI/TRIG_TP.XLI
   6933  Implode   2840  60%  02-10-88  18:34  d65cf50a --w  XLI/EXEC.C
   7450  Implode   4680  38%  02-11-88  00:01  28e844fa --w  XLI/EXEC.EXE
   2570  Implode   1352  48%  11-09-87  12:32  ceaee4a7 --w  XLI/EXEC.DOC
   6478  Implode   2527  61%  02-10-88  18:40  faf9c636 --w  XLI/SOUND.ASM
    946  Implode    331  66%  02-11-88  00:01  a6a4b413 --w  XLI/SOUND.EXE
   4549  Implode   1964  57%  11-17-87  16:03  46b9d67c --w  XLI/SOUND.DOC
   4690  Implode   1875  61%  05-26-88  11:00  88ecaeef --w  XLI/TRIG_LLC.C
    658  Implode    296  56%  05-26-88  11:00  3f576abf --w  XLI/GLUE_LLC.ASM
   1084  Implode    556  49%  02-09-88  20:12  6450ac8b --w  NEWPCS/AUTOCOMP.S
   1182  Implode    677  43%  02-09-88  20:16  40c14a89 --w  NEWPCS/AUTOPRIM.S
   5754  Implode   2024  65%  04-22-87  13:08  4c3ab70c --w  NEWPCS/EDWIN.INI
  27264  Implode   6261  78%  08-26-87  11:00  1b0e9884 --w  NEWPCS/EDIT.S
   4326  Implode   1046  76%  08-26-87  11:00  8db8f127 --w  NEWPCS/FILEPOS.S
   1829  Implode    604  67%  08-26-87  11:00  682b0c15 --w  NEWPCS/GRAPHICS.S
   6074  Implode   1932  69%  08-26-87  11:00  63888e2e --w  NEWPCS/HELP.S
   4646  Implode   1796  62%  08-26-87  11:00  75fe3993 --w  NEWPCS/KLDSCOPE.S
  10318  Implode   2301  78%  08-26-87  11:00  f7ed9158 --w  NEWPCS/OLDPMATH.S
   9344  Implode   2410  75%  08-26-87  11:00  e0454b36 --w  NEWPCS/PADVISE.S
  11708  Implode   3482  71%  08-26-87  11:00  242de8c2 --w  NEWPCS/PASM.S
   1656  Implode    746  55%  08-26-87  11:00  8cf5b825 --w  NEWPCS/PAUTO_C.S
   2674  Implode   1169  57%  08-26-87  11:00  66388b1d --w  NEWPCS/PAUTO_R.S
  12581  Implode   3414  73%  08-26-87  11:00  f97259c5 --w  NEWPCS/PBOOT.S
   8133  Implode   2398  71%  08-26-87  11:00  def1d987 --w  NEWPCS/PCA.S
   8068  Implode   2036  75%  08-26-87  11:00  254a44a0 --w  NEWPCS/PCHREQ.S
  21045  Implode   5636  74%  09-18-87  14:45  8fc966d0 --w  NEWPCS/PCOMP.S
  13790  Implode   4354  69%  05-03-88  16:17  b0dd8ffd --w  NEWPCS/PDEBUG.S
   8832  Implode   2435  73%  08-26-87  11:00  18b8023c --w  NEWPCS/PDEFSTR.S
  15136  Implode   4682  70%  08-26-87  11:00  5c2e3a4d --w  NEWPCS/PDOS.S
   5427  Implode   1468  73%  08-26-87  11:00  8cb87a0a --w  NEWPCS/PFUNARG.S
  23670  Implode   6261  74%  08-26-87  11:00  cf0239fd --w  NEWPCS/PGENCODE.S
  12548  Implode   3415  73%  03-11-88  10:18  338c4cea --w  NEWPCS/PGR.S
  11454  Implode   3560  69%  08-26-87  11:00  9d901afc --w  NEWPCS/PINSPECT.S
  16085  Implode   4469  73%  05-24-88  13:42  97cc871d --w  NEWPCS/PIO.S
  21262  Implode   5526  75%  09-18-87  14:32  6ef2511d --w  NEWPCS/PMACROS.S
   5329  Implode   1380  75%  08-26-87  11:00  6653e58f --w  NEWPCS/PMATH.S
  14218  Implode   4343  70%  08-26-87  11:00  257c7f97 --w  NEWPCS/PME.S
  12079  Implode   3310  73%  08-26-87  11:00  d770f47c --w  NEWPCS/PNUM2S.S
  27884  Implode   5817  80%  08-26-87  11:00  d0f75c1b --w  NEWPCS/POPCODES.S
  13417  Implode   3701  73%  08-26-87  11:00  16973978 --w  NEWPCS/PP.S
  17568  Implode   5224  71%  08-26-87  11:00  56e3fb4f --w  NEWPCS/PPEEP.S
   5601  Implode   1160  80%  02-09-88  20:16  cc8f22ca --w  NEWPCS/PRIMOPS.S
  11648  Implode   3053  74%  08-26-87  11:00  bb028574 --w  NEWPCS/PSIMP.S
   4740  Implode   1549  68%  08-26-87  11:00  38b30c58 --w  NEWPCS/PSORT.S
  11312  Implode   3498  70%  08-26-87  11:00  7161e4bb --w  NEWPCS/PSTD.S
   5313  Implode   2120  61%  04-28-88  09:42  7ea9f972 --w  NEWPCS/PSTD2.S
   5932  Implode   2264  62%  08-26-87  11:00  bdb7230e --w  NEWPCS/PSTL.S
   9861  Implode   2964  70%  03-04-88  13:32  1dad6fc2 --w  NEWPCS/PWINDOWS.S
   3292  Implode   1164  65%  08-26-87  11:00  1244461c --w  NEWPCS/SCPSDEMO.S
  10708  Implode   3247  70%  02-10-88  23:30  9a986733 --w  NEWPCS/COMPILE.ALL
 ------          ------  ---                                 -------
1154907          342373  71%                                      96

C>zip -v a:disk3

PKZIP (tm)   FAST!   Create/Update Utility   Version 1.02   10-01-89
Copyright 1989 PKWARE Inc.   All Rights Reserved.   PKZIP/h for help

Searching ZIP: A:DISK3.ZIP

 Length  Method   Size  Ratio   Date    Time   CRC-32  Attr  Name
 ------  ------   ----- -----   ----    ----   ------  ----  ----
  49042  Implode  12501  75%  05-27-88  13:42  9c7bcfb1 --w  PROSPRIN.ASM
  24627  Implode   6609  74%  02-18-88  11:47  d7b8f11c --w  PROSREAD.ASM
  22513  Implode   4972  78%  03-07-88  14:04  043b9d99 --w  PROWIN.ASM
  68738  Implode  18124  74%  05-23-88  14:05  984432a1 --w  REALIO.ASM
  43705  Implode  13957  69%  05-25-88  16:20  ece3a8b1 --w  REALSCHM.ASM
   9060  Implode   2646  71%  05-22-86  11:11  6a1140fa --w  SAPROP.ASM
  17008  Implode   5323  69%  01-11-88  18:23  9dda6e6d --w  SBID.ASM
  22395  Implode   6459  72%  05-27-86  17:15  9ec42549 --w  SBIGMATH.ASM
  30002  Implode  10972  64%  02-19-88  09:26  67236f6d --w  SC.ASM
  14637  Implode   4821  68%  12-14-87  15:49  ce0e232b --w  SCANNUM.ASM
  28662  Implode   5801  80%  05-29-87  15:19  689f5bf6 --w  SCAR_CDR.ASM
  25732  Implode   6959  73%  03-04-88  14:32  7669bf1f --w  SCHEMED.ASM
   5120  Implode   1680  68%  10-23-85  10:30  df5984cf --w  SCROLL.ASM
  45924  Implode  10237  78%  09-18-87  15:07  ac2fb027 --w  SENV.ASM
   3968  Implode   1374  66%  05-09-86  13:23  fb85aeca --w  SEXEC.ASM
  11703  Implode   3896  67%  05-20-86  13:38  00b33c1d --w  SGCMARK.ASM
  12681  Implode   4046  69%  02-16-88  14:09  d7cf4aa2 --w  SGCSWEEP.ASM
 136329  Implode  31534  77%  04-08-88  14:16  09cea3e3 --w  SINTERP.ASM
  12330  Implode   3672  71%  03-25-86  16:13  6ab69608 --w  SIO.ASM
   4141  Implode   1801  57%  02-16-88  14:13  cc25deba --w  SMMU.ASM
  17465  Implode   4742  73%  05-20-86  13:36  58662549 --w  SOBJHASH.ASM
  35619  Implode   8117  78%  05-23-88  09:36  b73440a5 --w  SQUISH.ASM
  57116  Implode  14607  75%  05-19-88  16:45  17f30d5c --w  SRCH_STR.ASM
  24566  Implode   5216  79%  05-28-86  09:00  4d2d80eb --w  SRELOCAT.ASM
  98518  Implode  20465  80%  02-17-88  10:12  44ce90c4 --w  SSTACK.ASM
  21064  Implode   5411  75%  04-27-88  14:29  5a003dd8 --w  SSTRING.ASM
   3734  Implode   1592  58%  07-30-85  16:38  6277833f --w  STIMER.ASM
  23352  Implode   7581  68%  02-18-88  11:10  b1a162e1 --w  STRMLNRS.ASM
  28569  Implode   7401  75%  02-17-88  09:59  ea93cf18 --w  SUTIL.ASM
  40884  Implode  10593  75%  02-09-88  10:58  f0242705 --w  SVARS.ASM
   1087  Implode    555  49%  11-08-85  15:29  1f249a6f --w  SW_INT.ASM
  45456  Implode  13760  70%  05-25-88  17:04  9d52bc5f --w  XLI.ASM
  38916  Implode   8363  79%  04-14-88  09:22  fff5e110 --w  ZIO.ASM
   1034  Implode    509  51%  12-16-85  17:30  764f45aa --w  SINTERP.ARG
     16  Stored      16   0%  10-14-86  18:09  a90abf87 --w  FREESP.EQU
    457  Implode    213  54%  12-17-87  13:21  b56a2646 --w  MEMTYPE.EQU
    303  Shrunk     210  31%  01-07-88  16:36  93e2eb3b --w  PCMAKE.EQU
   2819  Implode   1333  53%  02-09-88  10:42  f13da9bd --w  REALIO.EQU
   1493  Implode    885  41%  03-10-88  10:14  f6beef87 --w  RPC.EQU
     94  Shrunk      71  25%  05-11-88  13:59  7e5a580c --w  SCHEME.EQU
  20746  Implode   5641  73%  05-11-88  13:47  bc0962b4 --w  SCHEMED.EQU
     81  Shrunk      68  17%  03-04-88  14:11  aeba8d7c --w  SCREEN.EQU
   1873  Implode    739  61%  08-04-85  11:17  061f4d3b --w  STACKF.EQU
   2457  Implode   1297  48%  02-17-88  13:37  8af00ce0 --w  XLI.EQU
   3445  Implode   1389  60%  08-26-87  11:00  d1189f23 --w  DOS.MAC
   9499  Implode   2432  75%  08-26-87  11:00  ffdc9da1 --w  SASM.MAC
   2885  Implode   1244  57%  08-26-87  11:00  a57471db --w  SCHEMED.MAC
    552  Implode    335  40%  08-26-87  11:00  998bd9a1 --w  SINTERP.MAC
   7617  Implode   1887  76%  03-08-88  16:55  add397b6 --w  SMMU.MAC
   4583  Implode   1732  63%  08-13-87  09:26  77a0975b --w  XLI.MAC
   3715  Implode   1265  66%  12-02-87  09:06  5deaebae --w  XLI_PRO.MAC
    505  Implode    342  33%  01-01-80  00:02  69e76316 --w  CONIO.H
   2366  Implode    822  66%  05-06-86  09:00  4ffa60af --w  CTYPE.H
  11503  Implode   3386  71%  05-06-86  09:00  1b44748d --w  DOS.H
   4087  Implode   1378  67%  05-06-86  09:00  361537e5 --w  MATH.H
    254  Shrunk     162  37%  12-17-87  13:20  e9e93231 --w  MEMTYPE.H
    285  Shrunk     206  28%  02-16-88  13:44  593bc786 --w  PCMAKE.H
  11445  Implode   4038  65%  02-10-87  08:37  d67796a0 --w  REGSCHEM.H
    746  Implode    387  49%  02-13-87  18:40  39fe8a91 --w  SCHARS.H
    127  Shrunk      76  41%  02-18-88  12:57  17a1fd44 --w  SCHEME.H
  11779  Implode   4285  64%  02-18-88  12:56  7e3a1a95 --w  SCHMDEFS.H
   1328  Implode    747  44%  06-23-85  19:01  6a303ebb --w  SLINK.H
    933  Implode    426  55%  04-01-85  14:05  9a7adcf5 --w  SLIST.H
   4717  Implode   1621  66%  01-22-87  16:24  b793d416 --w  SPORT.H
   4701  Implode   1426  70%  05-06-86  09:00  da213325 --w  STDIO.H
    396  Implode    181  55%  06-24-88  08:36  d4e84be2 --w  VERSION.H
 ------          ------  ---                                 -------
1143504          306536  74%                                      66

C>zip -v a:disk4

PKZIP (tm)   FAST!   Create/Update Utility   Version 1.02   10-01-89
Copyright 1989 PKWARE Inc.   All Rights Reserved.   PKZIP/h for help

Searching ZIP: A:DISK4.ZIP

 Length  Method   Size  Ratio   Date    Time   CRC-32  Attr  Name
 ------  ------   ----- -----   ----    ----   ------  ----  ----
   3862  Implode   1665  57%  10-15-86  17:32  566b6fe4 --w  ASM_LINK.C
   1085  Implode    596  46%  06-10-87  10:05  c2da57e4 --w  FREESP.C
   4410  Implode   1743  61%  01-13-87  14:02  46ce11a7 --w  GET_PORT.C
  23686  Implode   5952  75%  06-06-88  11:32  64526ed3 --w  MAKE_FSL.C
   3436  Implode   1351  61%  04-28-87  14:51  e569cf07 --w  NEWTRIG.C
  17158  Implode   5460  69%  05-23-88  10:50  41887b42 --w  PROCIOSP.C
  19589  Implode   4982  75%  03-20-87  08:47  fe6a72d6 --w  SARITH.C
   4279  Implode   1819  58%  05-21-88  08:57  07e72755 --w  SBIGMEM.C
   4403  Implode   1856  58%  10-16-86  15:43  11eb62e9 --w  SBIGMXP.C
   7252  Implode   2610  65%  06-05-87  11:14  8d87322a --w  SBIGMXT.C
  16694  Implode   5081  70%  02-17-88  09:37  9fc98c85 --w  SDEBUG.C
  31691  Implode   7961  75%  02-17-88  09:38  145510ab --w  SDUMP.C
   1661  Implode    797  53%  01-25-88  18:13  c37b6445 --w  SERRMSG.C
  12809  Implode   3491  73%  02-16-88  14:07  233481aa --w  SERROR.C
  14367  Implode   4196  71%  03-19-87  17:20  4e27bf44 --w  SFASL.C
   3959  Implode   1649  59%  02-10-87  09:20  22b2c534 --w  SHASH.C
  13015  Implode   3359  75%  05-09-88  16:17  a05ba28e --w  SIN_OUT.C
  12877  Implode   4194  68%  04-27-88  14:09  81c97e10 --w  SLINK.C
  13022  Implode   5010  62%  06-18-88  09:35  7a3277ba --w  SMAIN.C
  18445  Implode   4766  75%  05-20-88  13:46  ca2a4140 --w  SMEMORY.C
  15358  Implode   4979  68%  02-10-87  09:23  57d49c48 --w  SPRINT.C
  18850  Implode   4074  79%  02-18-88  11:06  db5d8356 --w  SPRINTF.C
   8661  Implode   2288  74%  10-15-86  17:45  ddf7c8a4 --w  SPROP.C
  27967  Implode   8067  72%  10-15-86  17:46  4fe08113 --w  SREAD.C
   2726  Implode   1124  59%  10-15-86  17:46  16f83a37 --w  SREIFY.C
   2627  Implode   1017  62%  10-15-86  17:46  77e66ef7 --w  SRESET.C
  18270  Implode   5189  72%  09-24-87  13:13  3b34c839 --w  STRACE.C
  20600  Implode   5325  75%  02-19-88  13:05  1bc7d2b7 --w  SUPPORT.C
  42992  Implode   9179  79%  10-15-86  17:48  f562603b --w  ZCIO.C
    487  Implode    393  20%  01-07-88  17:59  9106fc83 --w  PCS.LNK
    480  Implode    390  19%  01-07-88  17:59  1be3ea8f --w  PCSEXP.LNK
    487  Implode    398  19%  01-07-88  18:00  32b92306 --w  PCSEXT.LNK
    424  Implode    346  19%  02-19-88  13:47  219363ad --w  PCSPRO.LNK
  14369  Implode   2561  83%  03-18-88  13:21  745fcf61 --w  PCS.MAK
   3590  Implode   1289  65%  02-16-88  14:00  c53f15e4 --w  SCHEMED.REF
   2424  Implode   1052  57%  11-02-87  14:14  aa8be741 --w  XLI.REF
  22318  Implode   8747  61%  05-26-88  15:36  2ef0bffd --w  READ.ME
   3310  Implode   1623  51%  06-03-88  14:17  a62aaea3 --w  PROREAD.ME
  13385  Implode   2164  84%  03-18-88  13:21  52a062ec --w  PCSEXP.MAK
  13324  Implode   2194  84%  03-21-88  10:30  5f17a65f --w  PCSEXT.MAK
  13842  Implode   2606  82%  03-18-88  13:22  12677969 --w  PCSPRO.MAK
 ------          ------  ---                                 -------
 474191          133543  72%                                      41

