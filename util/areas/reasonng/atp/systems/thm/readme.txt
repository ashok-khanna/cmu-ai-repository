If you are running a 4.2 Unix, then to get the Common Lisp version of
our theorem-prover, ftp the file thm.tar.Z (don't forget to use binary
mode).  Checksum information for thm.tar.Z may be found in the file
SUM.  See the file make.thm.tar.Z for information on how thm.tar.Z and
SUM are created.

The next step is to:

       UNCOMPRESS

%uncompress thm.tar.Z


       UNTAR

%tar xvf thm.tar
%rm thm.tar


       COMPILE

%kcl  ;or any other Common Lisp
> (load "thm.lisp")
> (compile-thm)  ; maybe 40 minutes on a Sun-3/280, 12 on a 36xx
> (bye)  ;however you get out, if you can.


       LOAD

%kcl
> (load "thm.lisp")
> (load-thm)
> (boot-strap)
> ...


If you are not running a 4.2 Unix, then ftp all of the files on this
directory except thm.tar.Z and goto COMPILE.


Boyer and Moore, November 1987