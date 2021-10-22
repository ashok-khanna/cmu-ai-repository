GINA RELEASE 2.2
================

GINA (Generic Interactive Application) is an application framework based on
Common Lisp and OSF/Motif to simplify the construction of graphical
interactive applications. It consists of:

 o  CLM, a language binding for OSF/Motif in Common Lisp.

 o  the GINA application framework, a class library implemented in CLOS
    (the Common Lisp Object System).

 o  the GINA interface builder, an interactive tool implemented with GINA
    to design Motif windows.

To run GINA, you need OSF/Motif 1.1 or higher and a Common Lisp implementation
with CLX, CLOS or PCL and processes (directly supported are Franz Allegro,
Lucid, CMU CL and Symbolics Genera).

GINA is publicly available under similar terms as the X Window System.
The GINA 2.2 distribution consists of three files:

    CLM+GINA.README     this file
    CLM2.2.tar.Z        compressed tar file of CLM version 2.2
    GINA2.2.tar.Z       compressed tar file of GINA and the interface
                        builder, including documentation

These files reside on
    export.lcs.mit.edu (18.30.0.238)      in /contrib
    ftp.gmd.de (129.26.8.90)              in /gmd/gina

How to ftp:

    ftp export.lcs.mit.edu
    [...]
    login: anonymous
    password: your-name@your-site
    [...]
    cd contrib
    get CLM+GINA.README
    binary
    get CLM2.2.tar.Z
    get GINA2.2.tar.Z
    quit

Installation:
    1. Create a directory for the sources and cd to this directory.
    2. uncompress and unpack the GINA tar file.
    3. make a directory for CLM
    4. uncompress and unpack CLM in this directory
    5. Follow the directions in clm/INSTALL and gina/INSTALL.

There is a mailing list for gina users where problems can be discussed
and new developments are announced. Send mail to 
    gina-users-request@gmdzi.gmd.de
if you want to be added to the list. If you want to contribute to the
discussion, send mail to gina-users@gmdzi.gmd.de.

If you have any questions concerning GINA, you can contact

    Mike Spenke, Project GINA      (spenke@gmdzi.gmd.de)
    GMD (German National Research Center for Computer Science)
    P.O. Box 1316
    W-5205 Sankt Augustin 1
    Germany

==============================================================================

CLM -- A Language Binding for Common Lisp and OSF/Motif

Author: Andreas Baecker (baecker@gmd.de)

CLM is a language binding for Common Lisp and OSF/Motif.  It provides access to
the functionality of the X Toolkit Intrinsics and the Motif convenience
functions for Common Lisp.  Client programs can use the OSF/Motif widget classes
for their graphical user interface.  Additionally, client programs can use the
CLX graphics functions to draw into Motif widgets, especially into widgets of
classes XmDrawingArea and XmDrawnButton.  This functionality is only available
when the CLX package was loaded before compiling CLM. 

CLM consists of three components: A CLM daemon, a CLM server, and a package
of Common Lisp functions.  Both the CLM daemon and server are implemented in
``C''.  The CLM daemon runs on an arbitrary machine in the network and listens
for Lisp processes requesting to use CLM.  The CLM daemon forks CLM server
processes which communicate with their Lisp processes over a network-transparent
TCP/IP connection.  The CLM server offers the X toolkit and the Motif
functionality as remote procedure calls.  The package of Common Lisp functions
provides a high-level interface to these remote procedures. 

From the X server's point of view, the CLM server is an ordinary X client. 
The CLM server's functionality is to operate as a gateway between Motif and
Common Lisp.  The CLM functions send commands to the CLM server to create and
modify widgets.  The CLM server sends callbacks to the CLM application as a
reaction to user actions suchs as moving a scrollbar's slider or pressing a
push-button. 

A CLM application is a single (lightweight) process which runs inside a Lisp
process and uses CLM.  There may be an arbitrary number of concurrent CLM
applications in a single Lisp process.  The CLM daemon forks a CLM server
process for each CLM application.  This architecture protects concurrent
processes from getting in trouble with the non-reentrant Motif code.  The
multiprocessing facility is an extension to Common Lisp and may not be
available in all Lisp systems.  In this case, it is only possible to run one
CLM application per Lisp process. 

Lisp processes must not necessarily run on the same host as the CLM daemon. 
This allows CLM applications to run on hardware which is not capable of running
X and Motif.  CLM automatically chooses the right communication media for local
and remote Lisp processes. Where supported, the CLM server may also be
directly forked from the Lisp process without needing a daemon.

The CLM server solution is very efficient and results in good performance at
the user interface level.  Redraw operations and geometry management operations
are performed by the X Toolkit Intrinsics and the Motif widgets and are handled
locally in the CLM server.  User interaction like browsing through menu items
is also handled by the Motif widgets and requires only the execution of C code. 
Interactions like clicking a push-button lead to the execution of callbacks and
cause an interaction with Lisp.  Communication time is typically small and
doesn't cause any substantial delays. 

===============================================================================

GINA - the Generic Interactive Application
	
Author: Mike Spenke (spenke@gmd.de)

GINA is an object-oriented application framework written in Common Lisp
and CLOS. It is based on CLM.

The generic interactive application is executable and has a complete 
graphical user interface, but lacks any application-specific behaviour. 
New applications are created by defining subclasses of GINA classes and 
adding or overriding methods. The standard functionality of a typical 
application is already implemented in GINA. Only the differences to the 
standard application have to be coded. For example, commands for opening, 
closing, saving and creating new documents are already available in GINA. 
The programmer only has to write a method to translate the document contents 
into a stream of characters and vice versa. Motif widgets are encapsulated 
in CLOS objects. Instantiating an object implicitly creates a widget within 
OSF/Motif. Graphical output and direct manipulation with individual graphical 
feedback are also supported. The combination of framework concepts, the 
flexible Motif toolkit, and the interactive Lisp environment lead to an 
extremely powerful user interface development environment (UIDE). There are 
already a dozen demo applications including a Finder to start applications 
and documents, a simple text editor and a simple graphic editor, each 
consisting of only a few pages of code. 

GINA consists of three parts: the basic application framework (directory
"gina"), a set of demo applications for the framework (directory "gina-demos")
and an Interface Builder (directory "ib").

The GINA documentation is contained in the directory "documentation".
The concepts of GINA are described in the file "gina-overview.ps". Further
instructions and a roadmap to the available documentation can be found in
the User Manual ("gina-manual.ps").

===============================================================================

An Interface Builder for GINA and OSF/Motif

Author: Thomas Berlage (berlage@gmd.de)

The IB can be used to design windows constructed from OSF/Motif components.
It generates Lisp code to be used with GINA.

Features:

- Widgets can be dragged from a palette and dropped onto the work area.

- Dialog boxes are constructed bottom-up by first creating the basic widgets
  like buttons and labels etc. and then grouping them together into RowColumns,
  Forms etc.

- All relevant widget resources can be set interactively

- Layout parameters for manager widgets are generated automatically.

- Cut and paste is implemented for groups of widgets.

- The output of the IB is a definition of a new composite widget class
  with the structure defined by the user.

- Code for new dialog classes and constructor functions can be generated,
  saved, loaded and compiled. This code can be used with GINA applications.

- Unlimited Undo/Redo for all commands
