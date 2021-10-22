From crabapple.srv.cs.cmu.edu!bb3.andrew.cmu.edu!news.sei.cmu.edu!cis.ohio-state.edu!math.ohio-state.edu!sdd.hp.com!nigel.msen.com!math.fu-berlin.de!cs.tu-berlin.de!net Wed Aug  4 11:58:36 EDT 1993
Article: 7159 of comp.lang.scheme
Xref: crabapple.srv.cs.cmu.edu comp.lang.scheme:7159 comp.sources.d:9385
Path: crabapple.srv.cs.cmu.edu!bb3.andrew.cmu.edu!news.sei.cmu.edu!cis.ohio-state.edu!math.ohio-state.edu!sdd.hp.com!nigel.msen.com!math.fu-berlin.de!cs.tu-berlin.de!net
From: net@cs.tu-berlin.de (Oliver Laumann)
Newsgroups: comp.lang.scheme,comp.sources.d
Subject: Elk 2.1 is available
Date: 3 Aug 1993 15:58:58 GMT
Organization: Technical University of Berlin, Germany
Lines: 44
Message-ID: <23m202$jlk@news.cs.tu-berlin.de>
NNTP-Posting-Host: kugelbus.cs.tu-berlin.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Release 2.1 of Elk, the Extension Language Kit, is now available.

Elk is a Scheme interpreter intended to be used as a general, reusable
extension language subsystem for integration into existing and future
applications.  Elk can also be used as a stand-alone implementation of
the Scheme programming language.

Elk supports several additional language features to increase its
usability as an extension language, among them dynamic, incremental
loading of object files and `freezing' of a fully customized application
into a new executable file (`dump').

The current release of Elk includes several dynamically-loadable
extensions, among them interfaces to the X11 Xlib and to the application
programmer interface of the Xt intrinsics, and interfaces to the Athena
and OSF/Motif widget sets.  These extensions are especially useful for
application writers whose applications have graphical user-interfaces
based on X; they also can be used to interactively explore X and its
libraries and as a platform for rapid prototyping of X-based
applications.


The major new contribution to Release 2.1 is a generational and
incremental garbage collector written by Marco Scheibe
<mykee@cs.tu-berlin.de>.  The generational garbage collector is more
efficient and thus reduces the time the application is disrupted by a
garbage collection.  On platforms supporting advanced memory
management, the garbage collector can be switched to `incremental'
mode, further reducing wait times.  The stop-and-copy garbage collector
is still available as a compile-time option.

Dump and dynamic loading of object files are now supported with System
V Release 4, in particular with Solaris 2, though in a somewhat
limited way (see the comment in the file MACHINES).


Elk release 2.1 can be obtained via anonymous FTP from
tub.cs.tu-berlin.de (pub/elk/elk-2.1.tar.Z), and from
export.lcs.mit.edu (contrib/elk-2.1.tar.Z).


--
Oliver Laumann       net@cs.tu-berlin.de
Carsten Bormann     cabo@cs.tu-berlin.de


