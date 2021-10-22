"Visualizing Evaluation in Applicative Languages", by David S. Touretzky
and Peter Lee.  Communications of the ACM, October, 1992.

Here's how to retrieve the evaltrace files:

- Open an FTP connection to B.GP.CS.CMU.EDU (128.2.242.8)
- Log in as user "anonymous"
- set mode Binary (very important)
- cd *directly* to /usr/dst/public/evaltrace
  (Note:  our security system blocks access to /usr/dst.)
- get evaltrace.tar.Z
- close the FTP connection
- uncompress evaltrace.tar.Z
- tar -xf evlatrace.tar

You should also take a look in /usr/dst/public/lisp for a couple
of educational tools (SDRAW and DTRACE) you might find useful.

-- Dave  Touretzky
