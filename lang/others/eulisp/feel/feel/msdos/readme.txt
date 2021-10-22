FEEL 0.75 for MSDOS
===================

Overview:

FEEL (Free and Eventually EuLisp) was originally developed for Unix machines
at the University of Bath, UK. Thanks to DJ Delorie's excellent port of
Gnu C/C++ it has been possible to provide a full version of FEEL
for the PC.

Requirements: 

A 80386/486-based IBM compatible PC or PS/2 running DOS, a hard drive with at 
least 1MB free, and at least 512K RAM. 

Eulisp archive location:

    host:      ftp.bath.ac.uk     
    login:     ftp
    password:  send your e-mail address
    directory: pub/eulisp/feel-75.zip
   
    The Unix distribution and documentation is also available from this site

Installing:

To install, you must do the following:

* Create a directory to install in, for example C:\LANGS\FEEL.

* Un-zip feel-75.zip in that directory using the -d option to create 
  subdirectories.
    C:\LANGS\FEEL>pkunzip -d feel-75.zip

  The following subdirectories will be created:

    bin          The executable and batch files
    modules      Standard modules and sample applications
    man          Manual page and this readme file
    emu387       80387 emulator for non-80387 systems
    tmp          Empty, used for virtual memory page swaps during execution

* Edit all path names in the batch files FEEL.BAT and FEELB.BAT in the bin
  directory to reflect your configuration.
  If your PC has a Maths 80387 chip or equivalent then remove the lines
  SET GO32=emu ....
  from the batch files

* Add your binary directory to your PATH in C:\AUTOEXEC.BAT
    eg SET PATH=...;C:\LANGS\FEEL\BIN

That's it! FEEL is now installed in your system.

Usage:

It is recommended that you do not use the emm386.exe device driver when using
FEEL, as this slows the system down.

To invoke interpreted FEEL, type FEEL. The interpreter will then load.
Type (!> standard) and the standard module should load. If it fails to you
have probably got the path in the FEEL_LOAD_PATH variable wrong or have not
allocated enough environment space to store the environment variable, in which
case you will have to modify your CONFIG.SYS file.  
Type Ctrl-Z followed by return to leave FEEL.

To invoke FEEL with bytecoded standard modules type FEELB. The standard module
in this version is called standard0. 

Bugs:

Please send feel bug reports by email to eubug@maths.bath.ac.uk
Any MS-DOS specific queries to N.Berrington@ecs.soton.ac.uk

Have fun

Neil.








