Newsgroups: comp.lang.lisp
Subject: Common Lisp implementation of SUN RPC available
Distribution: comp
--text follows this line--
Periodically there have been requests on this group for a Common Lisp
implementation of SUN RPC. We have an implementation available in
source form for anonymous ftp.    

The code was originally written by Jeff Finger while at Stanford, and
has been subsequently revised at Xerox by Bill van Melle.  Currently
it only runs in Xerox Common Lisp, but was written with portability in
mind.  It has been the basis of many robust clients (including NFS)
but includes little support for the implementation of network
services.

We hope that someone will be enticed to: (1) port the code other
Common Lisp implementations; and further (2) extend the system to
support implementation of servers.  Both of these are significant
programming efforts, requiring familiarity with both SUN RPC and the
foreign function interface of the target Lisp.  The first task also
requires some familiarity with Interlisp-D.

The copyright permits almost anything to be done with the code, so
long as changes are made available to Stanford and Xerox at no charge.

The code is available for anonymous FTP from arisia.xerox.com
(13.1.100.206) as /pub/lisp-rpc.tar.Z.  This contains:

rpc.announce		- this message
rpc.tedit		- original documentation
rpc.ps			- postscript version of above
rpc.txt			- plain text version of above
rpc.lisp		- top level, loads the rest of the system
rpcdecls.lisp		- macros, needed at compile time
rpcstruct.lisp		- structure & condition definitions
rpcrpc.lisp		- program definition & invocation
rpcxdr.lisp		- external data representation
rpcudp.lisp		- UDP transport for Xerox D-machine
rpctcp.lisp		- TDP transport for Xerox D-machine
rpcos.lisp		- UDP transport for Xerox Lisp on a Sun
rpcportmapper.lisp	- definition of portmap client
rpcsrv.lisp		- incomplete UDP RPC server, implements portmap

The Lisp files were originally in Interlisp file manager format and
were converted to plain text for this distribution.


	Doug <cutting@parc.xerox.com>
