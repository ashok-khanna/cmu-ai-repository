                What is YYonX
                                               1990/11/05
                                               by Masayuki Ida

1. What is YY ?
---------------
YY is a network oriented window toolkit for Common Lisp.
YYonX is an implementation of YY for X-window.

2. YYonX characteristics ?
--------------------------
The Major Characteristics are:
1. It is a pilot implementation of YY for X.
2. It used a server/client model.
 YY-server is a X-client for low level stuffs.
 YY-client is a X-client for an application part and API.
3. CLOS oriented portable tool kit.
4. Never make a Xlib (CLX) call by user.
5. There is YY-Protocol for the communication between YY-server and
 YY-client.
 YY-Protocol enables the co-operation of YY-server and YY-client
 over TCP/IP, and has a highly compressed format.
6. For example, you may use a SUN3/60 X-server, a SUN4/260 YY-server,
and a YY-client on a different machine to execute YYonX based application.
7. Tested X-windows are X11R4, X11R3.


3. What is needed to execute YYonX ?
-----------------------------------

3.1 YY-server

YY-server is executable on the machines which can understand
X-protocol as a X-Client, and IPC sockets.
Usually YY-server fit on most of UN*X machines.
For the list of tested system, please refer the release specific
on-line document.

YY assumes proper organization of X11 system directory
structures.

3.2 YY-client

YY-client is executable on the machines which have a 'full' Common Lisp
and have a facility for IPC sockets over TCP/IP.

4. Who do YY project ?
---------------------

YY research is carried by CSRL Aoyama Gakuin University.
Members are from several organizations;
Aoyama Gakuin, CEC, CSK, Fujitsu, Hitachi, NEC, Nihon Symbolics, Nihon Unisys.
Prof. Masayuki Ida is the leader and the principal designer of the YY.
The current YY-server source code is written by Keisuke Tanaka.
The current YY-client source code is written by Takashi Kosaka
(major writer), Yukio Ohta, and Masayuki Ida.
YY specification, design and several guide line source pieces
are written by Masayuki Ida.

The main YYonX developement team:
Keisuke Tanaka (Aoyama Gakuin University),
Takashi Kosaka (Aoyama Gakuin / CSK),
Yukio Ohta (Aoyama Gakuin / CEC),
and Masayuki Ida


5. Mailing List ?
----------------

There is an international mailing list for YYonX.
The name is yyonx@csrl.aoyama.ac.jp
To request, send E-mail to yyonx-request@csrl.aoyama.ac.jp
(as of November 5th, there are six international sites on the list.)

6. Copyright notices ?
----------------------

;;;
;;;  Copyright (C) 1989,1990 Aoyama Gakuin University
;;;
;;;		All Rights Reserved
;;;
;;; This software is developed for the YY project of Aoyama Gakuin University.
;;; Permission to use, copy, modify, and distribute this software
;;; and its documentation for any purpose and without fee is hereby granted,
;;; provided that the above copyright notices appear in all copies and that
;;; both that copyright notice and this permission notice appear in 
;;; supporting documentation, and that the name of Aoyama Gakuin
;;; not be used in advertising or publicity pertaining to distribution of
;;; the software without specific, written prior permission.
;;;
;;; This software is made available AS IS, and Aoyama Gakuin makes no
;;; warranty about the software, its performance or its conformity to
;;; any specification. 
;;;
;;; To make a contact: Send E-mail to ida@csrl.aoyama.ac.jp for overall
;;; issues. To ask specific questions, send to the individual authors at
;;; csrl.aoyama.ac.jp. To request a mailing list, send E-mail to 
;;; yyonx-request@csrl.aoyama.ac.jp.
;;;
;;; Authors:
;;;   version X.X xx/yy/zz by Nanno tarebei (XXX@csrl.aoyama.ac.jp)
;;;   update X.XX xx/yy/zz by ano nenone for such such improvement
;;;   version X.X  ...

