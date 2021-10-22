From net@cs.tu-berlin.de Wed Feb  9 13:49:46 EST 1994
Article: 11962 of comp.lang.lisp
Xref: glinda.oz.cs.cmu.edu comp.lang.scheme:8255 comp.lang.lisp:11962 comp.lang.misc:15208
Path: honeydew.srv.cs.cmu.edu!fs7.ece.cmu.edu!europa.eng.gtefsd.com!howland.reston.ans.net!cs.utexas.edu!uunet!Germany.EU.net!news.dfn.de!zib-berlin.de!zrz.TU-Berlin.DE!cs.tu-berlin.de!net
From: net@cs.tu-berlin.de (Oliver Laumann)
Newsgroups: comp.lang.scheme,comp.lang.lisp,comp.lang.misc
Subject: Release 2.2 of Elk (Extension Language Kit) is out.
Date: 9 Feb 1994 15:01:52 GMT
Organization: Technical University of Berlin, Germany
Lines: 151
Message-ID: <2jatt0$gvr@news.cs.tu-berlin.de>
NNTP-Posting-Host: kugelbus.cs.tu-berlin.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit


Release 2.2 of Elk, the Extension Language Kit, is now available.


What is Elk?

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

What is new in this release?

   The major new items of release 2.2 of Elk are three new extensions:
   `unix' -- access to the UNIX system interface, `record' -- constructing
   and accessing record data types, and `bitstring' -- arbitrary-length
   bitstrings.  You can find reference manuals for the new extensions
   in doc/unix, doc/record, and doc/bitstring in the Elk 2.2 distribution
   (as preformatted PostScript and troff input).

   The new UNIX extension provides Scheme access to most UNIX system calls
   and C library functions.  The extension supports a wide range of
   different UNIX platforms without restricting its functionality to the
   lowest common denominator or the POSIX 1003.1 functions.  To facilitate
   writing portable Scheme programs, the extension attempts to hide
   differences between the types of supported UNIX flavors.

   The UNIX extension defines procedures for low-level, file-descriptor-based
   I/O; creation of pipes; file/record locking; file and directory system
   calls; process creation and control; signal handling; error handling;
   and obtaining information about date, time, users, limits, process
   resources, etc.  (Two examples are appended: one forks off a process
   and communicates with it through pipes; the other one measure the maximum
   capacity of a pipe using non-blocking I/O.)

   New platforms supported by Elk 2.2 are SGI Irix 5.1 and HP-UX 9.0.
   The mechanism to link the Scheme interpreter with extensions has
   been simplified significantly.  In addition, Elk can now be integrated
   with applications that must have their own main() function.  The
   number system has been cleaned up, and several bugs have been fixed.

   See CHANGES and MIGRATE in the distribution for a complete list of
   changes in Elk 2.2.

How to obtain Elk:

   Elk release 2.2 can be obtained via anonymous FTP from
   ftp.fu-berlin.de (pub/unix/languages/scheme/elk-2.2.tar.gz),
   and from ftp.x.org (contrib/elk-2.2.tar.gz).

--
Oliver Laumann       net@cs.tu-berlin.de
Carsten Bormann     cabo@cs.tu-berlin.de

-----------------------------------------------------------------------------
;;; Demonstrate pipes, fork, exec.
;;;
;;;  (calc-open)  --  Open two pipes to/from UNIX dc command
;;;  (calc expr)  --  Send expression to dc, return result as a string
;;;  (calc-close) --  Close pipes, wait for child process

(require 'unix)

(define calc-from-dc)   ; input port: standard output of dc command
(define calc-to-dc)     ; output port: standard input of dc command
(define calc-dc-pid)    ; process-ID of child process running dc

(define calc-dc-command "/usr/bin/dc")

(define (calc-open)
  (let* ((from (unix-pipe))
	 (to (unix-pipe))
	 (redirect-fd (lambda (a b)
			(unix-dup a b) (unix-close a))))
    (set! calc-dc-pid (unix-fork))
    (if (zero? calc-dc-pid)
	(begin
	  (unix-close (car from))
	  (unix-close (cdr to))
	  (redirect-fd (car to) 0)
	  (redirect-fd (cdr from) 1)
	  (unix-exec calc-dc-command '("dc")))
	(begin
	  (unix-close (cdr from))
	  (unix-close (car to))
	  (set! calc-to-dc   (unix-filedescriptor->port (cdr to)   "w"))
	  (set! calc-from-dc (unix-filedescriptor->port (car from) "r"))))))

(define (calc expr)
  (format calc-to-dc "~a~%" expr)
  (flush-output-port calc-to-dc)
  (read-string calc-from-dc))

(define (calc-close)
  (close-output-port calc-to-dc)
  (close-input-port calc-from-dc)
  (if (feature? 'unix:wait-process)
      (unix-wait-process calc-dc-pid)
      (unix-wait)))


;;; Test -- print sqrt(2):

(calc-open)
(display (calc "10k 2v p")) (newline)
(calc-close)
-----------------------------------------------------------------------------
;;; Demonstrate non-blocking I/O
;;;
;;;  (pipe-size)  --  Calculate maximum capacity of pipe.

(require 'unix)

(define (pipe-size)
  (let* ((pipe (unix-pipe))
	 (flags (unix-filedescriptor-flags (cdr pipe)))
	 (len 32)                    ; assumes capacity is multiple of len
	 (noise (make-string len))
	 (flag (if (memq 'nonblock (unix-list-filedescriptor-flags))
		   'nonblock
		   'ndelay)))

    ;; enable non-blocking I/O for write end of pipe:
    (unix-filedescriptor-flags (cdr pipe) (cons flag flags))

    (unwind-protect
      (let loop ((size 0))
	   (if (unix-error? (unix-errval (unix-write (cdr pipe) noise)))
	       (if (memq (unix-errno) '(eagain ewouldblock edeadlk))
		   size
		   (error 'pipe-size "~E"))
	       (loop (+ size 32))))
      (unix-close (car pipe))
      (unix-close (cdr pipe)))))

(print (pipe-size))
-----------------------------------------------------------------------------


