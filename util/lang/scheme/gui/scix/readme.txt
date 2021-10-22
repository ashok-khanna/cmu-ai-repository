
         SCIX -- A Scheme Interface to the X Window System


The file scix-0.97.tar.Z contains the entire source for the SCIX
system. SCIX is a completely object-oriented interface between the
X Window System and the programming language Scheme. It is currently
at version 0.97, i.e., it is a beta release.

It has been implemented with the Scheme->C system developed at Digital
Western Research Laboratory in Palo Alto by Joel Bartlett (Scheme->C is
available by anonymous ftp from gatekeeper.dec.com [16.1.0.2]). A
consequence of this is that SCIX is currently only working on
architectures that Scheme->C works on (today this is DECstations, VAXes,
Sun3, Sun386 and Sparc). SCIX has been thoroughly tested on DECstations
and Sparcs. Both SCIX and Scheme->C should be rather easy to port. Most
of the SCIX system is written in standard Scheme (according to the
R^3.99RS). A few low-level routines are written in C. No programming
libraries (like Xlib or Xt) are used to generate SCIX, but some include
files from the X distribution are.

The added functionality is primarily described in our report, the
PostScript source of which is available in the file scix-report.ps.Z.
A few sample demonstrations are provided with the system.

To install, SCIX needs approximately 10 Mb of disk space. The built
system consists of a SCIX interpreter of 1.8 Mb (including demos),
and two libraries taking up less than 2 Mb. A minimal interpreter is
just below 1 Mb in size.

The entire SCIX system was developed by us as the subject of our
masters thesis. The project was initiated, advised, and sponsored
by Magnus Persson at Digital Equipment AB, Sweden.

Hakan Huss and Johan Ihren
<huss@nada.kth.se> and <johani@nada.kth.se>

Department of Computing Science (NADA),
Royal Institute of Technology (KTH), Stockholm, Sweden
