

THE ATREE ADAPTIVE LOGIC NETWORK SIMULATION PACKAGE

The atree adaptive logic network (ALN) simulation package, atree
release 2.7, is available via anonymous ftp from menaik.cs.ualberta.ca
[129.128.4.241] in pub/atree/atre27.exe (ftp in binary mode).  It runs on
IBM PCs and compatibles under Windows 3.x. (Another version runs under
Unix -- see below.)  Included is documentation and ON-LINE HELP
explaining the basic principles of adaptive logic networks, the atree
source code and the examples.  All C and C++ source code is provided.

The atree package is not a toy, despite the fact that it is used for
demonstration purposes, and is non-commercial.  Experimenters are
using it on challenging problems of medicine, physics and the
environment.  It has been used to grade beef based on ultrasound
images, design hardware to discriminate particles produced by a
high-energy accelerator, help to design walking prostheses for spinal
cord damaged patients and measure the composition of tarsands from
spectral data.

It is possible to use inexpensive, off-the-shelf programmable logic
devices to realize trained ALNs in high-speed hardware, though those
facilities are not in the atree 2.7 software.

Please read the license, and the warranty (that protects the
developers, not the users).  All neural networks which are "black
boxes" are possibly unsafe, i.e.  unexpected outputs can occur at some
untested places in the domain of the neural net's mapping. The current
atree package is no exception; however ALNs can be made safe by
forcing the learned mappings to be piecewise monotonic according to
the developer's a priori knowledge of the problem.  A commercial
version of atree is planned which will support a safe design
methodology. (Update as of July 93 -- it's running and works as
expected, but it still requires improvement before we let others try it.)

Atree release 2.7 is available in either of two files in pub/atree/ on
menaik: atre27.exe and a27exe.exe.  The file atre27.exe contains the
full C and C++ sources for those who want to study or modify them. The
code was developed using Borland C++ 3.1 and Application Frameworks.
The other, smaller file contains just the executables. The sources
help the user understand the adaptive algorithm in detail (see ALN
Technical Notes/The Learning Algorithm in the On-Line Help).

Everyone should have a look at the OCR demo!  It has been referred to
as "quite impressive" even by experts in the OCR area.  Test yourself
against the trained ALNs, and scribble in your own characters (similar
to the A, L, or N; or pick any language, any alphabet and then train)
to see how noisy and distorted the characters can be, yet still be
recognized by the logic networks.  The demo can be obtained without
the rest in pub/atree/a27ocr.exe.

To set up your software on the PC under Windows 3.x, it is recommended
that you execute atre27.exe in your main directory, whereupon it will
create a subdirectory atree_27 and extract everything into it.
Running "setup" in the latter directory will create a group of icons
you can use to invoke demos and the facilities for programming
adaptive logic network applications in the lf language.  The "Open"
command gives you access to numerous instructive examples.  Clicking
on the Help button gives you access to explanations of theory and
code.

The Unix version, atree release 2.0, is in C, and has been ported to
Macintosh, Amiga, and other machines.  Windows NT will eventually
offer another way to use atree on various platforms.

There is an electronic mailing list for discussions of ALNs. Mail to
alnl-request@cs.ualberta.ca to subscribe or cancel.  Your comments on
ALN subjects can be emailed to all other subscribers to the list by
mailing to alnl@cs.ualberta.ca.

Welcome to the world of adaptive logic networks!

	RECOMMENDED PUBLICATIONS ON ADAPTIVE LOGIC NETWORKS

W. Armstrong, Adaptive Boolean Logic Element, U. S. Patent 3934231,
Feb. 28, 1974 (filings in various countries), assigned to Dendronic
Decisions Limited, 3624 - 108 Street, Edmonton, Alberta, T6J 1B4, Tel.
(403) 438-1103.  N. B. EXPIRED JANUARY 1993, THUS PUTTING DESIGNS FOR
HIGH-SPEED ALN ADAPTIVE HARDWARE INTO THE PUBLIC DOMAIN.

G. v. Bochmann, W. Armstrong, Properties of Boolean Functions
with a Tree Decomposition, BIT 13, 1974. pp. 1-13.

W. Armstrong, Gilles Godbout: Use of Boolean Tree Functions to Perform
High-Speed Pattern Classification and Related Tasks, Dept. d'IRO,
Universite de Montreal, Doc. de Travail #53, 1974. (unpublished,
except in summary form as follows:)

W. Armstrong and G. Godbout, Properties of Binary Trees
of Flexible Elements Useful in Pattern Recognition, IEEE 1975
International Conf. on Cybernetics and Society, San Francisco, 1975,
IEEE Cat. No. 75 CHO 997-7 SMC, pp. 447-449.

W. Armstrong and J. Gecsei, Architecture of a Tree-based
Image Processor, 12th Asilomar Conf. on Circuits, Systems
and Computers, Pacific Grove, Calif., 1978, pp. 345-349.

W. Armstrong and J. Gecsei, Adaptation Algorithms for
Binary Tree Networks, IEEE Trans. on Systems, Man and
Cybernetics, 9, 1979, pp. 276-285.

W. Armstrong, J.-D. Liang, D. Lin, S. Reynolds, Experiments Using
Parsimonious Adaptive Logic, Tech. Rept. TR 90-30, Department of
Computing Science, University of Alberta, Edmonton, Alberta, Canada,
T6G 2H1.  This is now available in a revised form via anonymous FTP
from menaik.cs.ualberta.ca [129.128.4.241] in pub/atree/atree2.ps.Z (the
title of the revised document is Some Results concerning Adaptive
Logic Networks).

W. Armstrong, A. Dwelly, J.-D. Liang, D. Lin, S. Reynolds, Learning
and Generalization in Adaptive Logic Networks, in Artificial Neural
Networks, Proceedings of the 1991 International Conference on
Artificial Neural Networks ( ICANN'91), Espoo, Finland, June 24-28,
1991, T. Kohonen, K.Makisara, O. Simula, J. Kangas eds.  Elsevier
Science Publishing Co. Inc. N. Y. 1991, vol. 2, pp. 1173-1176.

Allen G. Supynuk, William W. Armstrong, Adaptive Logic Networks and
Robot Control, Proc. Vision Interface Conference '92, also called
AI/VI/GI '92, Vancouver B. C., May 11-15, 1992, pp. 181 - 186.

R. B. Stein, A. Kostov, M. Belanger, W. W. Armstrong and D. B.
Popovic, Methods to Control Functional Electrical Stimulation in
Walking, First International FES Symposium, Sendai, Japan, July 23 -
25, 1992, pp. 135 - 140.

Aleksandar Kostov, Richard B. Stein, William W. Armstrong, Monroe
Thomas, Evaluation of Adaptive Logic Networks for Control of Walking
in Paralyzed Patients, 14th Ann. Int'l Conf. IEEE Engineering in
Medicine and Biology Society, Paris, France, Oct. 29 - Nov. 1, 1992
vol.4, pp. 1332 - 1334.

Ian Parsons, W. W. Armstrong: The Use of Adaptive Logic Nets to
Quantify Tar Sands Feed (Draft), available via anonymous ftp from
menaik.cs.ualberta.cs [129.128.4.241] in pub/atree/alntarsands.ps.Z.

W.W. Armstrong, R. B. Stein, A. Kostov, M. Thomas, P. Baudin, P.
Gervais, D. Popovic, Application of adaptive logic networks and
dynamics to study and control of human movement, Second Int'l Symp. on
3D Analysis of Human Movement, Poitiers, June 30 - July 3, 1993
pp. 81 - 84.

In case you have difficulty in obtaining the above documents or the
atree release 2.0 software for Unix or release 2.7 for IBM-PC and
compatibles under Windows, the software and all of the above documents
prior to 1991 can be obtained from the University of Alberta for a
media fee to cover the costs of copying and mailing of $150
(Canadian), made payable to the University of Alberta.  Two 3 1/2"
diskettes are normally included but an attempt will be made to satisfy
needs for other media, e.g. tapes.  Orders can be sent to the following
address:

Prof. William W. Armstrong, Computing Science Dept.
University of Alberta; Edmonton, Alberta, Canada T6G 2H1
arms@cs.ualberta.ca Tel(403)492 2374 FAX 492 1071

Anyone interested in the commercial version should contact
Dendronic Decisions Limited, 3624 - 108 Street, Edmonton, Alberta,
Canada, T6J 1B4, Tel. (403) 438 8285.

