$! ................... Cut between dotted lines and save. ...................
$!...........................................................................
$! VAX/VMS archive file created by VMS_SHARE V06.10 7-FEB-1989.
$!
$! VMS_SHARE was written by James Gray (Gray:OSBUSouth@Xerox.COM) from
$! VMS_SHAR by Michael Bednarek (U3369429@ucsvc.dn.mu.oz.au).
$!
$! To unpack, simply save, concatinate all parts into one file and
$! execute (@) that file.
$!
$! This archive was created by user GJC
$! on 25-JUN-1992 12:45:44.43.
$!
$! It contains the following 17 files:
$!        MAKEFILE.
$!        README.
$!        SIOD.1
$!        SIOD.C
$!        SIOD.DOC
$!        SIOD.H
$!        SIOD.SCM
$!        SLIB.C
$!        SIOD.TIM
$!        MAKEFILE.COM
$!        PRATT.SCM
$!        DESCRIP.MMS
$!        SIOD.OPT
$!        SHAR.DB
$!        SIODP.H
$!        SLIBA.C
$!        SIODM.C
$!
$!============================================================================
$ SET SYMBOL/SCOPE=( NOLOCAL, NOGLOBAL )
$ VERSION = F$GETSYI( "VERSION" )
$ IF VERSION .GES "V4.4" THEN GOTO VERSION_OK
$ WRITE SYS$OUTPUT "You are running VMS ''VERSION'; ", -
    "VMS_SHARE V06.10 7-FEB-1989 requires VMS V4.4 or higher."
$ EXIT 44 ! SS$_ABORT
$VERSION_OK:
$ GOTO START
$!
$UNPACK_FILE:
$ WRITE SYS$OUTPUT "Creating ''FILE_IS'"
$ DEFINE/USER_MODE SYS$OUTPUT NL:
$ EDIT/TPU/COMMAND=SYS$INPUT/NODISPLAY/OUTPUT='FILE_IS'/NOSECTION -
    VMS_SHARE_DUMMY.DUMMY
b_part := CREATE_BUFFER( "{Part}", GET_INFO( COMMAND_LINE, "file_name" ) )
; s_file_spec := GET_INFO( COMMAND_LINE, "output_file" ); SET( OUTPUT_FILE
, b_part, s_file_spec ); b_errors := CREATE_BUFFER( "{Errors}" ); i_errors 
:= 0; pat_beg_1 := ANCHOR & "-+-+-+ Beginning"; pat_beg_2 := LINE_BEGIN 
& "+-+-+-+ Beginning"; pat_end := ANCHOR & "+-+-+-+-+ End"; POSITION
( BEGINNING_OF( b_part ) ); LOOP EXITIF SEARCH( SPAN( ' ' )@r_trail 
& LINE_END, FORWARD) = 0; POSITION( r_trail ); ERASE( r_trail ); ENDLOOP
; POSITION( BEGINNING_OF( b_part ) ); i_append_line := 0; LOOP EXITIF MARK
( NONE ) = END_OF( b_part ); s_x := ERASE_CHARACTER( 1 )
; IF s_x = '+' THEN r_skip := SEARCH( pat_beg_1, FORWARD, EXACT ); IF r_skip 
<> 0 THEN s_x := ''; MOVE_HORIZONTAL( -CURRENT_OFFSET ); ERASE_LINE; ENDIF
; ENDIF; IF s_x = '-' THEN r_skip := SEARCH( pat_end, FORWARD, EXACT )
; IF r_skip <> 0 THEN s_x := ''; MOVE_HORIZONTAL( -CURRENT_OFFSET ); m_skip 
:= MARK( NONE ); r_skip := SEARCH( pat_beg_2, FORWARD, EXACT ); IF r_skip 
<> 0 THEN POSITION( END_OF( r_skip ) ); MOVE_HORIZONTAL( -CURRENT_OFFSET )
; MOVE_VERTICAL( 1 ); MOVE_HORIZONTAL( -1 ); ELSE POSITION( END_OF( b_part ) 
); ENDIF; ERASE( CREATE_RANGE( m_skip, MARK( NONE ), NONE ) ); ENDIF; ENDIF
; IF s_x = 'V' THEN s_x := ''; IF i_append_line <> 0 THEN APPEND_LINE
; MOVE_HORIZONTAL( -CURRENT_OFFSET ); ENDIF; i_append_line := 1
; MOVE_VERTICAL( 1 ); ENDIF; IF s_x = 'X' THEN s_x := ''; IF i_append_line 
<> 0 THEN APPEND_LINE; MOVE_HORIZONTAL( -CURRENT_OFFSET ); ENDIF
; i_append_line := 0; MOVE_VERTICAL( 1 ); ENDIF; IF s_x <> '' THEN i_errors 
:= i_errors + 1; s_text := CURRENT_LINE; POSITION( b_errors ); COPY_TEXT
( "The following line could not be unpacked properly:" ); SPLIT_LINE
; COPY_TEXT( s_x ); COPY_TEXT( s_text ); POSITION( b_part ); MOVE_VERTICAL
( 1 ); ENDIF; ENDLOOP; POSITION( BEGINNING_OF( b_part ) ); LOOP r_x := SEARCH
( "`", FORWARD, EXACT ); EXITIF r_x = 0; POSITION( r_x ); ERASE_CHARACTER( 1 
); COPY_TEXT( ASCII( INT( ERASE_CHARACTER( 3 ) ) ) ); ENDLOOP
; IF i_errors = 0 THEN SET( NO_WRITE, b_errors, ON ); ELSE POSITION
( BEGINNING_OF( b_errors ) ); COPY_TEXT( FAO
( "The following !UL errors were detected while unpacking !AS", i_errors
, s_file_spec ) ); SPLIT_LINE; SET( OUTPUT_FILE, b_errors, "SYS$COMMAND" )
; ENDIF; EXIT; 
$ DELETE VMS_SHARE_DUMMY.DUMMY;*
$ CHECKSUM 'FILE_IS
$ WRITE SYS$OUTPUT " CHECKSUM ", -
  F$ELEMENT( CHECKSUM_IS .EQ. CHECKSUM$CHECKSUM, ",", "failed!!,passed." )
$ RETURN
$!
$START: 
$ FILE_IS = "MAKEFILE."
$ CHECKSUM_IS = 1148977636
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X# If cc doesn't work here, try changing cc to gcc (GNU C)
X`009    CC=cc
X`009    CFLAGS= -O
X
Xsiod:`009siod.o slib.o sliba.o
X`009$(CC) -o siod siod.o slib.o sliba.o
Xsiod.o: siod.c siod.h
X`009$(CC) $(CFLAGS) -c siod.c
Xslib.o:`009slib.c siod.h siodp.h
X`009$(CC) $(CFLAGS) -c slib.c
Xsliba.o:`009sliba.c siod.h siodp.h
X`009$(CC) $(CFLAGS) -c sliba.c
$ GOSUB UNPACK_FILE

$ FILE_IS = "README."
$ CHECKSUM_IS = 172181293
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
XThis is version 2.8 of Siod, Scheme In One Defun.
X
XIt is a very small implementation of the Scheme programming language.
X
XGeorge Carrette, APRIL 3, 1992. gjc@mitech.com, gjc@paradigm.com.
X
XSee siod.doc and the source file slib.c for more information.
X
XThe files slib.c and sliba.c may serve as a subroutine library to add
Xscheme interpreter functionality to any existing program.
X
XEven though this is small, with an executable size of
X38kbytes on VAX/VMS, 50kbytes on Mac, for example,`032
Xthe implementation supports some advanced features such
Xas arrays, hash tables, and fast/binary data saving and restoring.
X
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.1"
$ CHECKSUM_IS = 1881288929
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X.TH SIOD 1C LOCAL`032
X.SH NAME
Xsiod \- small scheme interpreter (Scheme In One Defun).
X.SH SYNOPSIS
X.B siod
X[-hXXXXX] [-iXXXXX] [-gX] [-oXXXXX] [-nXXXX]
X.SH DESCRIPTION
X.I Siod
Xis a very small scheme interpreter which can be used for calculations
Xor included as a command interpreter or extension/macro language in other
Xapplications. See the documentation for interfacing requirements and how to
Xadd user-defined data types.
X
X.RE
X.SS COMMAND LINE OPTIONS
X.TP 8
X.BI \-h "XXXXX"
XThe
X.I XXXXX
Xshould be an integer, specifying the number of cons cells to
Xallocate in the heap. The default is 5000.
X.TP
X.BI \-i "XXXXX"
XThe`032
X.I XXXXX
Xshould be the name of an init file to load before going into
Xthe read/eval/print loop.
X.TP
X.BI \-g "X"
XThe
X.I X
Xis 1 for a stop and copy garbage collector (the default), 0 for a mark
Xand sweep one.
X.TP
X.BI \-o "XXXXX"
XThe
X.I XXXXX
Xshould be an integer, specifying the size of the obarray (symbol hash table)
Xto use. Defaults to 100. Each array element is a list of symbols.
X.TP
X.BI \-n "XXXXX"
XThe
X.I XXXXX
Xshould be an integer, specifying the number of pre-cons numbers
Xto create. The default is 100.
X.TP
X.BI \-s "XXXXX"
XThe
X.I XXXXX
Xshould be an integer, specifying the number of bytes of recursion
Xon the machine (C-call frame) stack to allow. This may be changed
Xwhile the programming is running, and is mainly a convenience for
Xdetecting defects in programs.
X
X.SH FILES
Xsiod.h siod.doc siod.scm slib.c sliba.c siod.c siodp.h
X.PD
X.SH SEE ALSO
X.I Structure and Interpretation of Computer Programs
X, by Ableson and Sussman, MIT Press.
X.SH DIAGNOSTICS
XError messages may also set the variable errobj to the offending object.
X.SH BUGS
XWith -g1 it does not GC during EVAL, only before each READ/EVAL/PRINT cycle.
VIt does GC during EVAL with -g0, but that code may not run without modificati
Xon
Xon all architectures.
X.SH VERSION
XCurrent version is 2.8, 3-APR-92, by George Carrette. GJC\@PARADIGM.COM
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.C"
$ CHECKSUM_IS = 1481995165
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* Scheme In One Defun, but in C this time.
X`032
X *                    COPYRIGHT (c) 1988-1992 BY                            *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *        See the source file SLIB.C for more information.                  *
X
X*/
X
X/*
X
Xgjc@paradigm.com
X
XParadigm Associates Inc          Phone: 617-492-6079
X29 Putnam Ave, Suite 6
XCambridge, MA 02138
X
XAn example main-program call with some customized subrs.
X
X  */
X
X#include <stdio.h>
X#ifdef THINK_C
X#include <console.h>
X#endif
X
X#include "siod.h"
X
XLISP my_one;
XLISP my_two;
X
XLISP cfib(LISP x);
X
X#ifdef VMS
XLISP vms_debug(LISP cmd);
X#endif
X
Xint main(int argc,char **argv)
X`123print_welcome();
X#ifdef THINK_C
X argc = ccommand(&argv);
X#endif
X process_cla(argc,argv,1);
X print_hs_1();
X init_storage();
X init_subrs();
X my_one = flocons((double) 1.0);
X my_two = flocons((double) 2.0);
X gc_protect(&my_one);
X gc_protect(&my_two);
X init_subr("cfib",tc_subr_1,cfib);
X#ifdef VMS
X init_subr("vms-debug",tc_subr_1,vms_debug);
X#endif
X repl_driver(1,1);
X printf("EXIT\n");`125
X
X/* This is cfib, (compiled fib). Test to see what the overhead
X   of interpretation actually is in a given implementation benchmark
X   standard-fib against cfib.
X
X   (define (standard-fib x)
X     (if (< x 2)
X         x
X         (+ (standard-fib (- x 1))
X`009    (standard-fib (- x 2))))) `032
X
X*/
X
XLISP cfib(LISP x)
X`123if NNULLP(lessp(x,my_two))
X   return(x);
X else
X   return(plus(cfib(difference(x,my_one)),
X`009       cfib(difference(x,my_two))));`125
X
X#ifdef VMS
X
X#include <ssdef.h>
X#include <descrip.h>
X
XLISP vms_debug(arg)
X     LISP arg;
X`123unsigned char arg1[257];
X char *data;
X if NULLP(arg)
X   lib$signal(SS$_DEBUG,0);
X else
X   `123data = get_c_string(arg);
X    arg1[0] = strlen(data);
X    memcpy(&arg1[1],data,arg1[0]);
X    lib$signal(SS$_DEBUG,1,arg1);`125
X return(NIL);`125
X
X#endif
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.DOC"
$ CHECKSUM_IS = 657114964
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X *                   COPYRIGHT (c) 1988-1992 BY                             *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *        See the source file SLIB.C for more information.                  *
X
XDocumentation for Release 2.7 17-MAR-92, George Carrette
X
X[Release Notes:]
X
X1.4 This release is functionally the same as release 1.3 but has been
Xremodularized in response to people who have been encorporating SIOD
Xas an interpreted extension language in other systems.
X
X1.5 Added the -g flag to enable mark-and-sweep garbage collection.
X    The default is stop-and-copy.
X
X2.0 Set_Repl_Hooks, catch & throw.`032
X
X2.1 Additions to SIOD.SCM: Backquote, cond.
X
X2.2 User Type extension. Read-Macros. (From C-programmer level).
X
X2.3 save-forms. load with argument t, comment character, faster intern.
X    -o flag gives obarray size. default 100.
X
X2.4 speed up arithmetic and the evaluator. fixes to siod.scm. no_interrupt
X    around calls to C I/O. gen_readr.
X
X2.5 numeric arrays in siod.c
X
X2.6 remodularize .h files, procedure prototypes. gc, eval, print hooks
X    now table-driven.
X
X2.7 hash tables, fasload.
X
Xgjc@paradigm.com
XGeorge Carrette
X
X  `032
XParadigm Associates Inc          Phone: 617-492-6079
X29 Putnam Ave, Suite 6
XCambridge, MA 02138
X
X[Files:]
X
X siod.h    Declarations`032
X siodp.h   private declarations.
X slib.c    scheme library.
X siod.c    a main program.
X siod.scm  Some scheme code
X pratt.scm A pratt-parser in scheme.
X
X
X[Motivation:]
X
XThe most obvious thing one should notice is that this lisp implementation`032
Xis extremely small. For example, the resulting binary executable file`032
Xon a VAX/VMS system with /notraceback/nodebug is 17 kilo-bytes.
X
XSmall enough to understand, the source file slib.c is 30 kilo-bytes.
X
XSmall enough to include in the smallest applications which require
Xcommand interpreters or extension languages.
X
XWe also want to be able to run code from the book "Structure and
XInterpretation of Computer Programs."`032
X
XTechniques used will be familiar to most lisp implementors.  Having
Xobjects be all the same size, and having only two statically allocated
Xspaces simplifies and speeds up both consing and gc considerably.  the
XMSUBR hack allows for a modular implementation of tail recursion, `009
Xan extension of the FSUBR that is, as far as I know, original.
XThe optional mark and sweep garbage collector may be selected at runtime.
X
XError handling is rather crude. A topic taken with machine fault,
Xexception handling, tracing, debugging, and state recovery which we
Xcould cover in detail, but is clearly beyond the scope of this
Ximplementation. Suffice it to say that if you have a good symbolic
Xdebugger you can set a break point at "err" and observe in detail all
Xthe arguments and local variables of the procedures in question, since
Xthere is no casting of data types. For example, if X is an offending
Xor interesting object then examining X->type will give you the type,
Xand X->storage_as.cons will show the car and the cdr.
X
X[Invocation:]
X
Xsiod [-hXXXXX] [-iXXXXX] [-gX] [-oXXXXX] [-nXXXXX] [-sXXXXX]
X -h where XXXXX is an integer, to specify the heap size, in obj cells,
X -i where XXXXX is a filename to load before going into the repl loop.
X -g where X = 1 for stop-and-copy GC, X = 0 for mark-and-sweep.
X -o where XXXXX is the size of the symbol hash table to use, default 100.
X -n where XXXXX is the number of preconsed/interned non-negative numbers.
X -s where XXXXX is the number of bytes of machine recursion stack.
X
X  Example:
X   siod -isiod.scm -h100000
X
X[Garbage Collection:]
X
XThere are two storage management techniques which may be chosen at runtime
Xby specifying the -g argument flag.`032
X
X -g1 (the default) is stop-and-copy. This is the simplest and most
X     portable implementation. GC is only done at toplevel.
X -g0 is mark-and-sweep. GC is done at any time, required or requested.
X     However, the implementation is not as portable.
X
XDiscussion of stop-and-copy follows:
X
XAs one can see from the source, garbage collection is really quite an easy
Xthing. The procedure gc_relocate is about 25 lines of code, and
Xscan_newspace is about 15.
X
XThe real tricks in handling garbage collection are (in a copying gc):
X (1) keeping track of locations containing objects
X (2) parsing the heap (in the space scanning)
X
XThe procedure gc_protect is called once (e.g. at startup) on each
X"global" location which will contain a lisp object.
X
XThat leaves the stack. Now, if we had chosen not to use the argument
Xand return-value passing mechanism provided by the C-language
Ximplementation, (also known as the "machine stack" and "machine
Xprocedure calling mechanism) this lisp would be larger, slower, and
Xrather more difficult to read and understand. Furthermore it would be
Xconsiderably more painful to *add* functionality in the way of SUBR's
Xto the implementation.
X
XAside from writing a very machine and compiler specific assembling language
Xroutine for each C-language implementation, embodying assumptions about
Xthe placement choices for arguments and local values, etc, we
Xare left with the following limitation: "YOU CAN GC ONLY AT TOP-LEVEL"
X
XHowever, this fits in perfectly with the programming style imposed in
Xmany user interface implementations including the MIT X-Windows Toolkit.
XIn the X Toolkit, a callback or work procedure is not supposed to spend
Xmuch time implementing the action. Therefore it cannot have allocated
Xmuch storage, and the callback trampoline mechanism can post a work
Xprocedure to call the garbage collector when needed.
X
XOur simple object format makes parsing the heap rather trivial.
XIn more complex situations one ends up requiring object headers or markers
Xof some kind to keep track of the actual storage lengths of objects
Xand what components of objects are lisp pointers.
X
XBecause of the usefulness of strings, they were added by default into
XSIOD 2.6. The implementation requires a hook that calls the C library
Xmemory free procedure when an object is in oldspace and never
Xgot relocated to newspace. Obviously this slows down the mark-and-sweep
XGC, and removes one of the usual advantages it has over mark-and-sweep.
X
XDiscussion of mark-and-sweep follows:
X
XIn a mark-and-sweep GC the objects are not relocated. Instead
Xone only has to LOOK at objects which are referenced by the argument
Xframes and local variables of the underlying (in this case C-coded)
Ximplementation procedures. If a pointer "LOOKS" like it is a valid
Xlisp object (see the procedure mark_locations_array) then it may be marked,
Xand the objects it points to may be marked, as being in-use storage which
Xis not linked into the freelist in the gc_sweep phase.
X
XAnother advantage of the mark_and_sweep storage management technique is
Xthat only one heap is required.
X
XThis main disadvantages are:
X(1) start-up cost to initially link freelist.
X    (can be avoided by more general but slower NEWCELL code).
X(2) does not COMPACT or LOCALIZE the use of storage. This is poor engineering
X    practice in a virtual memory environment.
V(2) the entire heap must be looked at, not just the parts with useful storage
X.
X
XIn general, mark-and-sweep is slower in that it has to look at more
Xmemory locations for a given heap size, however the heap size can
Xbe smaller for a given problem being solved. More complex analysis
Xis required when READ-ONLY, STATIC, storage spaces are considered.
XAdditionally the most sophisticated stop-and-copy storage management
Xtechniques take into account considerations of object usage temporality.
X
XThe technique assumes that all machine registers the GC needs to
Xlook at will be saved by a setjmp call into the save_regs_gc_mark data.
X
X[Compilation:]
X
XThis code (version 2.7) has been compiled and run under the following:
X- SUN-IV,      GCC (GNU C)
X- VAX/VMS,     VAXC
X- MacIntosh,   THINK C 5.0
X
XEarlier versions were compiled and run on the AMIGA, Encore, and 4.3BSD.
XThere are reports that the code will also compile and run under MS-DOS.
X
XOn all unix machines use (with floating-point flags as needed)
X `032
X  %cc -O -c siod.c
X  %cc -O -c slib.c
X  %cc -O -c sliba.c
X  %cc -o siod siod.o slib.o sliba.o
X
XIf cc doesn't work, try gcc (GNU C, Free Software Foundation, Cambridge MA).
X
Xon VAX/VMS:
X
X  $ cc siod
X  $ cc slib
X  $ cc sliba
X  $ link siod,slib,sliba,sys$input:/opt
X  sys$library:vaxcrtl/share
X  $ siod == "$" + F$ENV("DEFAULT") + "SIOD"
X
Xon AMIGA 500, ignore warning messages about return value mismatches,
X  %lc siod.c
X  %lc slib.c
X  %lc sliba.c
V  %blink lib:c.o,siod.o,slib.o,sliba.o to siod lib lib:lcm.lib,lib:lc.lib,lib
X:amiga.lib
X
Xin THINK C.
X  The siod project must include siod.c,slib.c,slib.c,sliba.c,siodm.c, ANSI.
X  The compilation option "require prototypes" should be used.
X
X[System:]
X`032
XThe interrupts called SIGINT and SIGFPE by the C runtime system are
Xhandled by invoking the lisp error procedure. SIGINT is usually caused
Vby the CONTROL-C character and SIGFPE by floating point overflow or underflow
X.
X
X[Syntax:]
X
XThe only special characters are the parenthesis and single quote.
XEverything else, besides whitespace of course, will make up a regular token.
XThese tokens are either symbols or numbers depending on what they look like.
XDotted-list notation is not supported on input, only on output.
X
X[Special forms:]
X
XThe CAR of a list is evaluated first, if the value is a SUBR of type 9 or 10
Xthen it is a special form.
X
X(define symbol value) is presently like (set! symbol value).
X
X(define (f . arglist) . body) ==> (define f (lambda arglist . body))
X
X(lambda arglist . body) Returns a closure.
X
X(if pred val1 val2) If pred evaluates to () then val2 is evaluated else val1.
X
X(begin . body) Each form in body is evaluated with the result of the last
Xreturned.
X
X(set! symbol value) Evaluates value and sets the local or global value of
Xthe symbol.
X
X(or x1 x2 x3 ...) Returns the first Xn such that Xn evaluated non-().
X
X(and x1 x2 x3 ...) Keeps evaluating Xj until one returns (), or Xn.
X
X(quote form). Input syntax 'form, returns form without evaluation.
X
X(let pairlist . body) Each element in pairlist is (variable value).
XEvaluates each value then sets of new bindings for each of the variables,
Xthen evaluates the body like the body of a progn. This is actually
Ximplemented as a macro turning into a let-internal form.
X
X(the-environment) Returns the current lexical environment.
X
X[Macro Special forms:]
X
XIf the CAR of a list evaluates to a symbol then the value of that symbol
Xis called on a single argument, the original form. The result of this
Xapplication is a new form which is recursively evaluated.
X
X[Built-In functions:]
X
XThese are all SUBR's of type 4,5,6,7, taking from 0 to 3 arguments
Xwith extra arguments ignored, (not even evaluated!) and arguments not
Xgiven defaulting to (). SUBR's of type 8 are lexprs, receiving a list
Xof arguments. Order of evaluation of arguments will depend on the
Ximplementation choice of your system C compiler.
X
Xconsp cons car cdr set-car! set-cdr!
X
Xnumber? + - * / < > eqv?
XThe arithmetic functions all take two arguments.
X
Xeq?, pointer objective identity. (Use eqv? for numbers.)
X
Xsymbolconc, takes symbols as arguments and appends them.`032
X
Xsymbol?
X
Xsymbol-bound? takes an optional environment structure.
Xsymbol-value also takes optional env.
Xset-symbol-value also takes optional env.
X
Xenv-lookup takes a symbol and an environment structure. If it returns
Xnon-nil the CAR will be the value of the symbol.
X
Xassq
X
Xread,print
X
Xeval, takes a second argument, an environment.
X
Xcopy-list. Copies the top level conses in a list.
X
Xoblist, returns a copy of the list of the symbols that have been interned.
X
Xgc-status, prints out the status of garbage collection services, the
Xnumber of cells allocated and the number of cells free. If given
Xa () argument turns gc services off, if non-() turns gc services on.
XIn mark-and-sweep storage management mode the argument only turns on
Xand off verbosity of GC messages.
X
Xgc, does a mark-and-sweep garbage collection. If called with argument nil
Xdoes not print gc messages during the gc.
X
Xload, given a filename (which must be a symbol, there are no strings)
Xwill read/eval all the forms in that file. An optional second argument,
Xif T causes returning of the forms in the file instead of evaluating them.
X
Xsave-forms, given a filename and a list of forms, prints the forms to the
Xfile. 3rd argument is optional, 'a to open the file in append mode.
X
Xquit, will exit back to the operating system.
X
Xerror, takes a symbol as its first argument, prints the pname of this
Xas an error message. The second argument (optional) is an offensive
Xobject. The global variable errobj gets set to this object for later
Xobservation.
X
Xnull?, not. are the same thing.
X
X*catch tag exp, Sets up a dynamic catch frame using tag. Then evaluates exp.
X
X*throw tag value, finds the nearest *catch with an EQ tag, and cause it to
Xreturn value.
X
X[Procedures in main program siod.c]
X
Xcfib is the same as standard-fib. You can time it and compare it with
Xstandard-fib to get an idea of the overhead of interpretation.
X
Xvms-debug invokes the VMS debugger. The one optional argument is
Xa string of vms-debugger commands. To show the current call
Xstack and then continue execution:
X
X    (vms-debug "set module/all;show calls;go")`032
X
XOr, to single step and run at the same time:
X
X    (vms-debug "for i=1 to 100 do (STEP);go")
X
XOr, to set up a breakpoint on errors:
X
X    (vms-debug "set module slib;set break err;go")
X
X
X[Utility procedures in siod.scm:]
X
XShows how to define macros.
X
Xcadr,caddr,cdddr,replace,list.
X
X(defvar variable default-value)
X
XAnd for us old maclisp hackers, setq and defun, and progn, etc.
X
Xcall-with-current-continuation
X
XImplemented in terms of *catch and *throw. So upward continuations
Xare not allowed.
X
XA simple backquote (quasi-quote) implementation.
X
Xcond, a macro.
X
Xappend
X
Xnconc
X
X[A streams implementation:]
X
XThe first thing we must do is decide how to represent a stream.
XThere is only one reasonable data structure available to us, the list.
XSo we might use (<stream-car> <cache-flag> <cdr-cache> <cdr-procedure>)
X
Xthe-empty-stream is just ().
X
Xempty-stream?
X
Xhead
X
Xtail
X
Xcons-stream is a special form. Wraps a lambda around the second argument.
X
X*cons-stream is the low-level constructor used by cons-stream.
X
Xfasload, fasldump. Take the obvious arguments, and are implemented
Xin terms of fast-read and fast-print.
X
Xcompile-file.`032
X
X[Arrays:]
X
X(cons-array size [type]) Where [type] is double, long, string, lisp or nil.
X(aref array index)
X(aset array index value)`032
X
Xfasload and fasdump are effective ways of storing and restoring numeric
Xarray data.
X
X[Benchmarks:]
X
XA standard-fib procedure is included in siod.scm so that everyone will
Xuse the same definition in any reports of speed. Make sure the return
Xresult is correct. use command line argument of
X %siod -h100000 -isiod.scm
X
X(standard-fib 10) => 55 ; 795 cons work.
X(standard-fib 15) => 610 ; 8877 cons work.
X(standard-fib 20) => 6765 ; 98508 cons work.
X
X[Porting:]
X
XSee the #ifdef definition of myruntime, which
Xshould be defined to return a double float, the number of cpu seconds
Xused by the process so far. It uses the the tms_utime slot, and assumes
Xa clock cycle of 1/60'th of a second.
X
XIf your system or C runtime needs to poll for the interrupt signal
Xmechanism to work, then define INTERRUPT_CHECK to be something
Xuseful.
X
XThe STACK_LIMIT and STACK_CHECK macros may need to be conditionized.
XThey currently assume stack growth downward in virtual address.
XThe subr (%%stack-limit setting non-verbose) may be used to change the
Xlimits at runtime.
X
XThe stack and register marking code used in the mark-and-sweep GC
Xis unlikely to work on machines that do not keep the procedure call
Xstack in main memory at all times. It is assumed that setjmp saves
Xall registers into the jmp_buff data structure.
X
XIf the stack is not always aligned (in LISP-PTR sense) then the`032
Xgc_mark_and_sweep procedure will not work properly.`032
X
XExample, assuming a byte addressed 32-bit pointer machine:
X
Xstack_start_ptr: [LISP-PTR(4)]`032
X                 [LISP-PTR(4)]
X                 [RANDOM(4)]
X                 [RANDOM(2)]
X                 [LISP-PTR(4)]
X                 [LISP-PTR(4)]
X                 [RANDOM(2)]
X                 [LISP-PTR(4)]
X                 [LISP-PTR(4)]
Xstack_end:       [LISP-PTR(4)]
X
XAs mark_locations goes from start to end it will get off proper alignment
Xsomewhere in the middle, and therefore the stack marking operation will
Xnot properly identify some valid lisp pointers.
X
XFortunately there is an easy fix to this. A more aggressive use of
Xour mark_locations procedure will suffice.
X
XFor example, say that there might be 2-byte random objects inserted into
Xthe stack. Then use two calls to mark_locations:
X
X mark_locations(((char *)stack_start_ptr) + 0,((char *)&stack_end) + 0);
X mark_locations(((char *)stack_start_ptr) + 2,((char *)&stack_end) + 2);
X
XIf we think there might be 1-byte random objects, then 4 calls are required:
X
X mark_locations(((char *)stack_start_ptr) + 0,((char *)&stack_end) + 0);
X mark_locations(((char *)stack_start_ptr) + 1,((char *)&stack_end) + 1);
X mark_locations(((char *)stack_start_ptr) + 2,((char *)&stack_end) + 2);
X mark_locations(((char *)stack_start_ptr) + 3,((char *)&stack_end) + 3);
X
X
X[Interface to other programs:]
X
XIf your main program does not want to actually have a read/eval/print
Xloop, and instead wants to do something else entirely, then use
Xthe routine set_repl_hooks to set up for procedures for:
X
X * putting the prompt "> " and other info strings to standard output.
X
X * reading (getting) an expression
X
X * evaluating an expression
X
X * printing an expression.
X
XThe routine get_eof_val may be called inside your reading procedure
Xto return a value that will cause exit from the read/eval/print loop.
X
XIn order to call a single C function in the context of the repl loop,
Xyou can do the following:
X
Xint flag = 0;
X
Xvoid my_puts(st)
X char *st;
X`123`125
X
XLISP my_reader()
X`123if (flag == 1)
X  return(get_eof_val());
X flag == 1;
X return(NIL);`125
X
XLISP my_eval(x)
X LISP x;
X`123call_my_c_function();
X return(NIL);`125
X
XLISP my_print(x)
X LISP x;
X`123`125
X
Xdo_my_c_function()
X`123set_repl_hooks(my_puts,my_read,my_eval,my_print);
X repl_driver(1, /* or 0 if we do not want lisp's SIGINT handler */
X             0);`125
X
X
XIf you need a completely different read-eval-print-loop, for example
Xone based in X-Window procedures such as XtAddInput, then you may want to
Xhave your own input-scanner and utilize a read-from-string kind of
Xfunction.
X
X
X[User Type Extension:]
X
XThere are 5 user types currently available. tc_user_1 through tc_user_5.
XIf you use them then you must at least tell the garbage collector about
Xthem. To do this you must have 4 functions,
X * a user_relocate, takes a object and returns a new copy.
X * a user_scan, takes an object and calls relocate on its subparts.
X * a user_mark, takes an object and calls gc_mark on its subparts or
X                it may return one of these to avoid stack growth.
X * a user_free, takes an object to hack before it gets onto the freelist.
X
Xset_gc_hooks(type,
X             user_relocate_fcn,
X             user_scan_fcn,
X             user_mark_fcn,
X             user_free_fcn,
X             &kind_of_gc);
X
Xkind_of_gc should be a long. It will receive 0 for mark-and-sweep, 1 for
Xstop-and-copy. Therefore set_gc_hooks should be called AFTER process_cla.
XYou must specify a relocate function with stop-and-copy. The scan
Xfunction may be NULL if your user types will not have lisp objects in them.
XUnder mark-and-sweep the mark function is required but the free function
Xmay be NULL.
X
XSee SIOD.C for a very simple string-append implementation example.
X
XYou might also want to extend the printer. This is optional.
X
Xset_print_hooks(type,fcn);
X
XThe fcn receives the object which should be printed to its second
Xargument, a FILE*.
X
XThe evaluator may also be extended, with the "application" of user defined
Xtypes following in the manner of an MSUBR.
X
XLastly there is a simple read macro facility.
X
Xvoid set_read_hooks(char *all_set,char *end_set,
X`009`009    LISP (*fcn1)(),LISP (*fcn2)())
X
XAll_set is a string of all read macros. end_set are those
Xthat will end the current token.
X
XThe fcn1 will receive the character used to trigger
Vit and the struct gen_readio * being read from. It should return a lisp objec
Xt.
X
Xthe fnc2 is optional, and is a user hook into the token => lisp object
Xconversion.
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.H"
$ CHECKSUM_IS = 678258050
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* Scheme In One Defun, but in C this time.
X`032
X *                   COPYRIGHT (c) 1988-1992 BY                             *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *        See the source file SLIB.C for more information.                  *
X
X*/
X
Xstruct obj
X`123short gc_mark;
X short type;
X union `123struct `123struct obj * car;
X`009`009struct obj * cdr;`125 cons;
X`009struct `123double data;`125 flonum;
X`009struct `123char *pname;
X`009`009struct obj * vcell;`125 symbol;
X`009struct `123char *name;
X`009`009struct obj * (*f)(
X#if  !defined(VMS) && !defined(CRAY)
X`009`009`009`009  ...
X#endif
X`009`009`009`009  );`125 subr;
X`009struct `123struct obj *env;
X`009`009struct obj *code;`125 closure;
X`009struct `123long dim;
X`009`009long *data;`125 long_array;
X`009struct `123long dim;
X`009`009double *data;`125 double_array;
X`009struct `123long dim;
X`009`009char *data;`125 string;
X`009struct `123long dim;
X`009`009struct obj **data;`125 lisp_array;
X`009struct `123FILE *f;
X`009`009char *name;`125 c_file;`125
X storage_as;`125;
X
X#define CAR(x) ((*x).storage_as.cons.car)
X#define CDR(x) ((*x).storage_as.cons.cdr)
X#define PNAME(x) ((*x).storage_as.symbol.pname)
X#define VCELL(x) ((*x).storage_as.symbol.vcell)
X#define SUBRF(x) (*((*x).storage_as.subr.f))
X#define FLONM(x) ((*x).storage_as.flonum.data)
X
X#define NIL ((struct obj *) 0)
X#define EQ(x,y) ((x) == (y))
X#define NEQ(x,y) ((x) != (y))
X#define NULLP(x) EQ(x,NIL)
X#define NNULLP(x) NEQ(x,NIL)
X
X#define TYPE(x) (((x) == NIL) ? 0 : ((*(x)).type))
X
X#define TYPEP(x,y) (TYPE(x) == (y))
X#define NTYPEP(x,y) (TYPE(x) != (y))
X
X#define tc_nil    0
X#define tc_cons   1
X#define tc_flonum 2
X#define tc_symbol 3
X#define tc_subr_0 4
X#define tc_subr_1 5
X#define tc_subr_2 6
X#define tc_subr_3 7
X#define tc_lsubr  8
X#define tc_fsubr  9
X#define tc_msubr  10
X#define tc_closure 11
X#define tc_free_cell 12
X#define tc_string       13
X#define tc_double_array 14
X#define tc_long_array   15
X#define tc_lisp_array   16
X#define tc_c_file       17
X#define tc_user_1 50
X#define tc_user_2 51
X#define tc_user_3 52
X#define tc_user_4 53
X#define tc_user_5 54
X
X#define FO_fetch 127
X#define FO_store 126
X#define FO_list  125
X#define FO_listd 124
X
X#define tc_table_dim 100
X
Xtypedef struct obj* LISP;
X
X#define CONSP(x)   TYPEP(x,tc_cons)
X#define FLONUMP(x) TYPEP(x,tc_flonum)
X#define SYMBOLP(x) TYPEP(x,tc_symbol)
X
X#define NCONSP(x)   NTYPEP(x,tc_cons)
X#define NFLONUMP(x) NTYPEP(x,tc_flonum)
X#define NSYMBOLP(x) NTYPEP(x,tc_symbol)
X
X#define TKBUFFERN 256
X
Xstruct gen_readio
X`123int (*getc_fcn)(char *);
X void (*ungetc_fcn)(int, char *);
X char *cb_argument;`125;
X
X#define GETC_FCN(x) (*((*x).getc_fcn))((*x).cb_argument)
X#define UNGETC_FCN(c,x) (*((*x).ungetc_fcn))(c,(*x).cb_argument)
X
Xvoid process_cla(int argc,char **argv,int warnflag);
Xvoid print_welcome(void);
Xvoid print_hs_1(void);
Xvoid print_hs_2(void);
Xlong no_interrupt(long n);
XLISP get_eof_val(void);
Xvoid repl_driver(long want_sigint,long want_init);
Xvoid set_repl_hooks(void (*puts_f)(),
X`009`009    LISP (*read_f)(),
X`009`009    LISP (*eval_f)(),
X`009`009    void (*print_f)());
Xvoid repl(void) ;
Xvoid err(char *message, LISP x);
Xchar *get_c_string(LISP x);
Xlong get_c_long(LISP x);
XLISP lerr(LISP message, LISP x);
X
XLISP newcell(long type);
XLISP cons(LISP x,LISP y);
XLISP consp(LISP x);
XLISP car(LISP x);
XLISP cdr(LISP x);
XLISP setcar(LISP cell, LISP value);
XLISP setcdr(LISP cell, LISP value);
XLISP flocons(double x);
XLISP numberp(LISP x);
XLISP plus(LISP x,LISP y);
XLISP ltimes(LISP x,LISP y);
XLISP difference(LISP x,LISP y);
XLISP quotient(LISP x,LISP y);
XLISP greaterp(LISP x,LISP y);
XLISP lessp(LISP x,LISP y);
XLISP eq(LISP x,LISP y);
XLISP eql(LISP x,LISP y);
XLISP symcons(char *pname,LISP vcell);
XLISP symbolp(LISP x);
XLISP symbol_boundp(LISP x,LISP env);
XLISP symbol_value(LISP x,LISP env);
XLISP cintern(char *name);
XLISP rintern(char *name);
XLISP subrcons(long type, char *name, LISP (*f)());
XLISP closure(LISP env,LISP code);
Xvoid gc_protect(LISP *location);
Xvoid gc_protect_n(LISP *location,long n);
Xvoid gc_protect_sym(LISP *location,char *st);
X
Xvoid init_storage(void);
X
Xvoid init_subr(char *name, long type, LISP (*fcn)());
XLISP assq(LISP x,LISP alist);
XLISP delq(LISP elem,LISP l);
Xvoid set_gc_hooks(long type,
X`009`009  LISP (*rel)(),
X`009`009  LISP (*mark)(),
X`009`009  void (*scan)(),
X`009`009  void (*free)(),
X`009`009  long *kind);
XLISP gc_relocate(LISP x);
XLISP user_gc(LISP args);
XLISP gc_status(LISP args);
Xvoid set_eval_hooks(long type,LISP (*fcn)());
XLISP leval(LISP x,LISP env);
XLISP symbolconc(LISP args);
Xvoid set_print_hooks(long type,void (*fcn)());
XLISP lprin1f(LISP exp,FILE *f);
XLISP lprint(LISP exp);
XLISP lread(void);
XLISP lreadtk(long j);
XLISP lreadf(FILE *f);
Xvoid set_read_hooks(char *all_set,char *end_set,
X`009`009    LISP (*fcn1)(),LISP (*fcn2)());
XLISP oblistfn(void);
XLISP vload(char *fname,long cflag);
XLISP load(LISP fname,LISP cflag);
XLISP save_forms(LISP fname,LISP forms,LISP how);
XLISP quit(void);
XLISP nullp(LISP x);
Xvoid init_subrs();
XLISP strcons(long length,char *data);
XLISP read_from_string(LISP x);
XLISP aref1(LISP a,LISP i);
XLISP aset1(LISP a,LISP i,LISP v);
XLISP cons_array(LISP dim,LISP kind);
XLISP string_append(LISP args);
X
Xvoid init_subrs(void);
X
XLISP copy_list(LISP);
X
X
Xlong c_sxhash(LISP,long);
XLISP sxhash(LISP,LISP);
X
XLISP href(LISP,LISP);
XLISP hset(LISP,LISP,LISP);
X
XLISP fast_print(LISP,LISP);
XLISP fast_read(LISP);
X
XLISP equal(LISP,LISP);
X
XLISP assoc(LISP x,LISP alist);
X
XLISP make_list(LISP x,LISP v);
X
Xvoid set_fatal_exit_hook(void (*fcn)(void));
X
XLISP parse_number(LISP x);
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.SCM"
$ CHECKSUM_IS = 1594915310
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
V;; SIOD: Scheme In One Defun                                    -*-mode:lisp-
X*-
X;;
V;; *                        COPYRIGHT (c) 1989-1992 BY                   `032
X   *
V;; *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.  `032
X   *
V;; *        See the source file SLIB.C for more information.             `032
X   *
X
X(puts  ";; Optional Runtime Library for Release 2.7
X")
X
X(define list (lambda n n))
X
X(define (sublis l exp)
X  (if (cons? exp)
X      (cons (sublis l (car exp))
X`009    (sublis l (cdr exp)))
X      (let ((cell (assq exp l)))
X`009(if cell (cdr cell) exp))))
X
X(define (caar x) (car (car x)))
X(define (cadr x) (car (cdr x)))
X(define (cdar x) (cdr (car x)))
X(define (cddr x) (cdr (cdr x)))
X
X(define (caddr x) (car (cdr (cdr x))))
X(define (cdddr x) (cdr (cdr (cdr x))))
X
X(define consp pair?)
X
X(define (replace before after)
X  (set-car! before (car after))
X  (set-cdr! before (cdr after))
X  after)
X
X(define (prognify forms)
X  (if (null? (cdr forms))
X      (car forms)
X    (cons 'begin forms)))
X
X(define (defmac-macro form)
X  (let ((sname (car (cadr form)))
X`009(argl (cdr (cadr form)))
X`009(fname nil)
X`009(body (prognify (cddr form))))
X    (set! fname (symbolconc sname '-macro))
X    (list 'begin
X`009  (list 'define (cons fname argl)
X`009`009(list 'replace (car argl) body))
X`009  (list 'define sname (list 'quote fname)))))
X
X(define defmac 'defmac-macro)
X
X(defmac (push form)
X  (list 'set! (caddr form)
X`009(list 'cons (cadr form) (caddr form))))
X
X(defmac (pop form)
X  (list 'let (list (list 'tmp (cadr form)))
X`009(list 'set! (cadr form) '(cdr tmp))
X`009'(car tmp)))
X
X(defmac (defvar form)
X  (list 'or
X`009(list 'symbol-bound? (list 'quote (cadr form)))
X`009(list 'define (cadr form) (caddr form))))
X
X(defmac (defun form)
X  (cons 'define
X`009(cons (cons (cadr form) (caddr form))
X`009      (cdddr form))))
X
X(defmac (setq form)
X  (let ((l (cdr form))
X`009(result nil))
X    (define (loop)
X      (if l
X`009  (begin (push (list 'set! (car l) (cadr l)) result)
X`009`009 (set! l (cddr l))
X`009`009 (loop))))
X    (loop)
X    (prognify (reverse result))))
X `032
X `032
X(define progn begin)
X
X(define the-empty-stream ())
X
X(define empty-stream? null?)
X
X(define (*cons-stream head tail-future)
X  (list head () () tail-future))
X
X(define head car)
X
X(define (tail x)
X  (if (car (cdr x))
X      (car (cdr (cdr x)))
X      (let ((value ((car (cdr (cdr (cdr x)))))))
X`009(set-car! (cdr x) t)
X`009(set-car! (cdr (cdr x)) value))))
X
X(defmac (cons-stream form)
X  (list '*cons-stream
X`009(cadr form)
X`009(list 'lambda () (caddr form))))
X
X(define (enumerate-interval low high)
X  (if (> low high)
X      the-empty-stream
X      (cons-stream low (enumerate-interval (+ low 1) high))))
X
X(define (print-stream-elements x)
X  (if (empty-stream? x)
X      ()
X      (begin (print (head x))
X`009     (print-stream-elements (tail x)))))
X
X(define (sum-stream-elements x)
X  (define (loop acc x)
X    (if (empty-stream? x)
X`009acc
X      (loop (+ (head x) acc) (tail x))))
X  (loop 0 x))
X
X(define (standard-fib x)
X  (if (< x 2)
X      x
X      (+ (standard-fib (- x 1))
X`009 (standard-fib (- x 2)))))
X
X(define (call-with-current-continuation fcn)
X  (let ((tag (cons nil nil)))
X    (*catch tag
X`009    (fcn (lambda (value)
X`009`009   (*throw tag value))))))
X
X
X(defun atom (x)
X  (not (consp x)))
X
X(define eq eq?)
X
X(defmac (cond form)
X  (cond-convert (cdr form)))
X
X(define null null?)
X
X(defun cond-convert (l)
X  (if (null l)
X      ()
X    (if (null (cdar l))
X`009(if (null (cdr l))
X`009    (caar l)
X`009  (let ((rest (cond-convert (cdr l))))
X`009    (if (and (consp rest) (eq (car rest) 'or))
X`009`009(cons 'or (cons (caar l) (cdr rest)))
X`009      (list 'or (caar l) rest))))
X      (if (or (eq (caar l) 't)
X`009      (and (consp (caar l)) (eq (car (caar l)) 'quote)))
X`009  (prognify (cdar l))
X`009(list 'if
X`009      (caar l)
X`009      (prognify (cdar l))
X`009      (cond-convert (cdr l)))))))
X
X(defmac (+internal-comma form)
X  (error 'comma-not-inside-backquote))
X
X(define +internal-comma-atsign +internal-comma)
X(define +internal-comma-dot +internal-comma)
X
X(defmac (+internal-backquote form)
X  (backquotify (cdr form)))
X
X(defun backquotify (x)
X  (let (a d aa ad dqp)
X    (cond ((atom x) (list 'quote x))
X`009  ((eq (car x) '+internal-comma) (cdr x))
X`009  ((or (atom (car x))
X`009       (not (or (eq (caar x) '+internal-comma-atsign)
X`009`009`009(eq (caar x) '+internal-comma-dot))))
X`009   (setq a (backquotify (car x)) d (backquotify (cdr x))
X`009`009 ad (atom d) aa (atom a)
X`009`009 dqp (and (not ad) (eq (car d) 'quote)))
X`009   (cond ((and dqp (not (atom a)) (eq (car a) 'quote))
X`009`009  (list 'quote (cons (cadr a) (cadr d))))
X`009`009 ((and dqp (null (cadr d)))
X`009`009  (list 'list a))
X`009`009 ((and (not ad) (eq (car d) 'list))
X`009`009  (cons 'list (cons a (cdr d))))
X`009`009 (t (list 'cons a d))))
X`009  ((eq (caar x) '+internal-comma-atsign)
X`009   (list 'append (cdar x) (backquotify (cdr x))))
X`009  ((eq (caar x) '+internal-comma-dot)
X`009   (list 'nconc (cdar x)(backquotify (cdr x)))))))
X
X
X(defun append n
X  (appendl n))
X
X(defun appendl (l)
X  (cond ((null l) nil)
X`009((null (cdr l)) (car l))
X`009((null (cddr l))
X`009 (append2 (car l) (cadr l)))
X`009('else
X`009 (append2 (car l) (appendl (cdr l))))))
X
X(defun append2 (a b)
X  (if (null a)
X      b
X    (cons (car a) (append2 (cdr a) b))))
X
X(defun rplacd (a b)
X  (set-cdr! a b)
X  a)
X
X(defun nconc (a b)
X  (if (null a)
X      b
X    (rplacd (last a) b)))
X
X
X(defun last (a)
X  (cond ((null a) (error'null-arg-to-last))
X`009((null (cdr a)) a)
X`009((last (cdr a)))))
X
X(define sfib
X  (eval `096(lambda (x)
X`009   (,if (,< x 2)
X`009       x
X`009     (,+ (sfib (,- x 1))
X`009`009 (sfib (,- x 2)))))))
X
X(defvar *fasdump-hash* t)
X
X(defun fasl-open (filename mode)
X  (list (fopen filename mode)
X`009(if (or (equal? mode "rb") *fasdump-hash*)
X`009    (cons-array 100))
X`009;; If this is set NIL, then already hashed symbols will be
X`009;; optimized, and additional ones will not.
X`0090))
X
X(defun fasl-close (table)
X  (fclose (car table)))
X
X(defun fasload args
X  (let ((filename (car args))
X`009(head (and (cadr args) (cons nil nil))))
X    (let ((table (fasl-open filename "rb"))
X`009  (exp)
X`009  (tail head))
X      (while (not (eq table (setq exp (fast-read table))))
X`009(cond (head
X`009       (setq exp (cons exp nil))
X`009       (set-cdr! tail exp)
X`009       (setq tail exp))
X`009      ('else
X`009       (eval exp))))
X      (fasl-close table)
X      (and head (cdr head)))))
X
X(defun fasdump (filename forms)
X  (let ((table (fasl-open filename "wb"))
X`009(l forms))
X    (while l
X      (fast-print (car l) table)
X      (setq l (cdr l)))
X    (fasl-close table)))
X
X(defun compile-file (filename)
X  (let ((forms (load (string-append filename ".scm") t)))
X    (puts "Saving forms
X")
X    (fasdump (string-append filename ".bin")
X`009     forms)))
X
X(defvar *properties* (cons-array 100))
X
X(defun get (sym key)
X  (cdr (assq key (href *properties* sym))))
X
X(defun putprop (sym val key)
X  (let ((alist (href *properties* sym)))
X    (let ((cell (assq key alist)))
X      (cond (cell
X`009     (set-cdr! cell val))
X`009    ('else
X`009     (hset *properties* sym (cons (cons key val) alist))
X`009     val)))))
X
X(define (mapcar1 f l1)
X  (and l1 (cons (f (car l1)) (mapcar1 f (cdr l1)))))
X
X
X(define (mapcar2 f l1 l2)
X  (and l1 l2 (cons (f (car l1) (car l2)) (mapcar2 f (cdr l1) (cdr l2)))))
X
X(define (mapcar . args)
X  (cond ((null args)
X`009 (error "too few arguments"))
X`009((null (cdr args))
X`009 (error "too few arguments"))
X`009((null (cdr (cdr args)))
X`009 (mapcar1 (car args) (car (cdr args))))
X`009((null (cdr (cdr (cdr args))))
X`009 (mapcar2 (car args) (car (cdr args)) (car (cdr (cdr args)))))
X`009('else
X`009 (error "two many arguments"))))
X`009
X`009`032
X `032
X
$ GOSUB UNPACK_FILE

$ FILE_IS = "SLIB.C"
$ CHECKSUM_IS = 1947177271
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* Scheme In One Defun, but in C this time.
X`032
X *                      COPYRIGHT (c) 1988-1992 BY                          *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *`009`009`009   ALL RIGHTS RESERVED                              *
X
XPermission to use, copy, modify, distribute and sell this software
Xand its documentation for any purpose and without fee is hereby
Xgranted, provided that the above copyright notice appear in all copies
Xand that both that copyright notice and this permission notice appear
Xin supporting documentation, and that the name of Paradigm Associates
XInc not be used in advertising or publicity pertaining to distribution
Xof the software without specific, written prior permission.
X
XPARADIGM DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
XALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
XPARADIGM BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
XANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
XWHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
XARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
XSOFTWARE.
X
X*/
X
X/*
X
Xgjc@paradigm.com
X
XParadigm Associates Inc          Phone: 617-492-6079
X29 Putnam Ave, Suite 6
XCambridge, MA 02138
X
X
X   Release 1.0: 24-APR-88
X   Release 1.1: 25-APR-88, added: macros, predicates, load. With additions by
X    Barak.Pearlmutter@DOGHEN.BOLTZ.CS.CMU.EDU: Full flonum recognizer,
X    cleaned up uses of NULL/0. Now distributed with siod.scm.
X   Release 1.2: 28-APR-88, name changes as requested by JAR@AI.AI.MIT.EDU,
X    plus some bug fixes.
X   Release 1.3: 1-MAY-88, changed env to use frames instead of alist.
X    define now works properly. vms specific function edit.
X   Release 1.4 20-NOV-89. Minor Cleanup and remodularization.
X    Now in 3 files, siod.h, slib.c, siod.c. Makes it easier to write your
X    own main loops. Some short-int changes for lightspeed C included.
X   Release 1.5 29-NOV-89. Added startup flag -g, select stop and copy
V    or mark-and-sweep garbage collection, which assumes that the stack/regist
Xer
X    marking code is correct for your architecture.`032
V   Release 2.0 1-DEC-89. Added repl_hooks, Catch, Throw. This is significantl
Xy
X    different enough (from 1.3) now that I'm calling it a major release.
X   Release 2.1 4-DEC-89. Small reader features, dot, backquote, comma.
V   Release 2.2 5-DEC-89. gc,read,print,eval, hooks for user defined datatypes
X.
X   Release 2.3 6-DEC-89. save_forms, obarray intern mechanism. comment char.
X   Release 2.3a......... minor speed-ups. i/o interrupt considerations.
X   Release 2.4 27-APR-90 gen_readr, for read-from-string.
X   Release 2.5 18-SEP-90 arrays added to SIOD.C by popular demand. inums.
X   Release 2.6 11-MAR-92 function prototypes, some remodularization.
X   Release 2.7 20-MAR-92 hash tables, fasload. Stack check.
X   Release 2.8  3-APR-92 Bug fixes, \n syntax in string reading.
X
X  */
X
X#include <stdio.h>
X#include <string.h>
X#include <ctype.h>
X#include <setjmp.h>
X#include <signal.h>
X#include <math.h>
X#include <stdlib.h>
X#include <time.h>
X
X#include "siod.h"
X#include "siodp.h"
X
XLISP heap_1,heap_2;
XLISP heap,heap_end,heap_org;
Xlong heap_size = 5000;
Xlong old_heap_used;
Xlong which_heap;
Xlong gc_status_flag = 1;
Xchar *init_file = (char *) NULL;
Xchar *tkbuffer = NULL;
Xlong gc_kind_copying = 1;
Xlong gc_cells_allocated = 0;
Xdouble gc_time_taken;
XLISP *stack_start_ptr;
XLISP freelist;
Xjmp_buf errjmp;
Xlong errjmp_ok = 0;
Xlong nointerrupt = 1;
Xlong interrupt_differed = 0;
XLISP oblistvar = NIL;
XLISP truth = NIL;
XLISP eof_val = NIL;
XLISP sym_errobj = NIL;
XLISP sym_progn = NIL;
XLISP sym_lambda = NIL;
XLISP sym_quote = NIL;
XLISP sym_dot = NIL;
XLISP open_files = NIL;
XLISP unbound_marker = NIL;
XLISP *obarray;
Xlong obarray_dim = 100;
Xstruct catch_frame *catch_framep = (struct catch_frame *) NULL;
Xvoid (*repl_puts)(char *) = NULL;
XLISP (*repl_read)(void) = NULL;
XLISP (*repl_eval)(LISP) = NULL;
Xvoid (*repl_print)(LISP) = NULL;
XLISP *inums;
Xlong inums_dim = 100;
Xstruct user_type_hooks *user_type_hooks = NULL;
Xstruct gc_protected *protected_registers = NULL;
Xjmp_buf save_regs_gc_mark;
Xdouble gc_rt;
Xlong gc_cells_collected;
Xchar *user_ch_readm = "";
Xchar *user_te_readm = "";
XLISP (*user_readm)(int, struct gen_readio *) = NULL;
XLISP (*user_readt)(char *,long, int *) = NULL;
Xvoid (*fatal_exit_hook)(void) = NULL;
X#ifdef THINK_C
Xint ipoll_counter = 0;
X#endif
X
Xchar *stack_limit_ptr = NULL;
Xlong stack_size =`032
X#ifdef THINK_C
X  10000;
X#else
X  50000;
X#endif
X
Xvoid process_cla(int argc,char **argv,int warnflag)
X`123int k;
X for(k=1;k<argc;++k)
X   `123if (strlen(argv[k])<2) continue;
X    if (argv[k][0] != '-')
X      `123if (warnflag) printf("bad arg: %s\n",argv[k]);continue;`125
X    switch(argv[k][1])
X      `123case 'h':
X`009 heap_size = atol(&(argv[k][2]));
X`009 break;
X       case 'o':
X`009 obarray_dim = atol(&(argv[k][2]));
X`009 break;
X       case 'i':
X`009 init_file = &(argv[k][2]);
X`009 break;
X       case 'n':
X`009 inums_dim = atol(&(argv[k][2]));
X`009 break;
X       case 'g':
X`009 gc_kind_copying = atol(&(argv[k][2]));
X`009 break;
X       case 's':
X`009 stack_size = atol(&(argv[k][2]));
X`009 break;
X       default:
X`009 if (warnflag) printf("bad arg: %s\n",argv[k]);`125`125`125
X
Xvoid print_welcome(void)
X`123printf("Welcome to SIOD, Scheme In One Defun, Version 2.8\n");
X printf("(C) Copyright 1988-1992 Paradigm Associates Inc.\n");`125
X
Xvoid print_hs_1(void)
X`123printf("heap_size = %ld cells, %ld bytes. %ld inums. GC is %s\n",
X        heap_size,heap_size*sizeof(struct obj),
X`009inums_dim,
X`009(gc_kind_copying == 1) ? "stop and copy" : "mark and sweep");`125
X
Xvoid print_hs_2(void)
X`123if (gc_kind_copying == 1)
X   printf("heap_1 at 0x%lX, heap_2 at 0x%lX\n",heap_1,heap_2);
X else
X   printf("heap_1 at 0x%lX\n",heap_1);`125
X
Xlong no_interrupt(long n)
X`123long x;
X x = nointerrupt;
X nointerrupt = n;
X if ((nointerrupt == 0) && (interrupt_differed == 1))
X   `123interrupt_differed = 0;
X    err_ctrl_c();`125
X return(x);`125
X
Xvoid handle_sigfpe(int sig SIG_restargs)
X`123signal(SIGFPE,handle_sigfpe);
X err("floating point exception",NIL);`125
X
Xvoid handle_sigint(int sig SIG_restargs)
X`123signal(SIGINT,handle_sigint);
X if (nointerrupt == 1)
X   interrupt_differed = 1;
X else
X   err_ctrl_c();`125
X
Xvoid err_ctrl_c(void)
X`123err("control-c interrupt",NIL);`125
X
XLISP get_eof_val(void)
X`123return(eof_val);`125
X
Xvoid repl_driver(long want_sigint,long want_init)
X`123int k;
X LISP stack_start;
X stack_start_ptr = &stack_start;
X stack_limit_ptr = STACK_LIMIT(stack_start_ptr,stack_size);
X k = setjmp(errjmp);
X if (k == 2) return;
X if (want_sigint) signal(SIGINT,handle_sigint);
X signal(SIGFPE,handle_sigfpe);
X close_open_files();
X catch_framep = (struct catch_frame *) NULL;
X errjmp_ok = 1;
X interrupt_differed = 0;
X nointerrupt = 0;
X if (want_init && init_file && (k == 0)) vload(init_file,0);
X repl();`125
X
X#ifdef vms
Xdouble myruntime(void)
X`123double total;
X struct tbuffer b;
X times(&b);
X total = b.proc_user_time;
X total += b.proc_system_time;
X return(total / CLK_TCK);`125
X#else
X#ifdef unix
X#include <sys/types.h>
X#include <sys/times.h>
Xdouble myruntime(void)
X`123double total;
X struct tms b;
X times(&b);
X total = b.tms_utime;
X total += b.tms_stime;
X return(total / 60.0);`125
X#else
X#ifdef THINK_C
Xdouble myruntime(void)
X`123return(((double) clock()) / ((double) CLOCKS_PER_SEC));`125
X#else
Xdouble myruntime(void)
X`123time_t x;
X time(&x);
X return((double) x);`125
X#endif
X#endif
X#endif
X
Xvoid set_repl_hooks(void (*puts_f)(),
X`009`009    LISP (*read_f)(),
X`009`009    LISP (*eval_f)(),
X`009`009    void (*print_f)())
X`123repl_puts = puts_f;
X repl_read = read_f;
X repl_eval = eval_f;
X repl_print = print_f;`125
X
Xvoid fput_st(FILE *f,char *st)
X`123long flag;
X flag = no_interrupt(1);
X fprintf(f,"%s",st);
X no_interrupt(flag);`125
X
Xvoid put_st(char *st)
X`123fput_st(stdout,st);`125
X    `032
Xvoid grepl_puts(char *st)
X`123if (repl_puts == NULL)
X   put_st(st);
X else
X   (*repl_puts)(st);`125
X    `032
Xvoid repl(void)`032
X`123LISP x,cw;
X double rt;
X while(1)
V   `123if ((gc_kind_copying == 1) && ((gc_status_flag) `124`124 heap >= heap_
Xend))
X     `123rt = myruntime();
X      gc_stop_and_copy();
X      sprintf(tkbuffer,
X`009      "GC took %g seconds, %ld compressed to %ld, %ld free\n",
X`009      myruntime()-rt,old_heap_used,heap-heap_org,heap_end-heap);
X      grepl_puts(tkbuffer);`125
X    grepl_puts("> ");
X    if (repl_read == NULL) x = lread();
X    else x = (*repl_read)();
X    if EQ(x,eof_val) break;
X    rt = myruntime();
X    if (gc_kind_copying == 1)
X      cw = heap;
X    else
X      `123gc_cells_allocated = 0;
X       gc_time_taken = 0.0;`125
X    if (repl_eval == NULL) x = leval(x,NIL);
X    else x = (*repl_eval)(x);
X    if (gc_kind_copying == 1)
X      sprintf(tkbuffer,
X`009      "Evaluation took %g seconds %ld cons work\n",
X`009      myruntime()-rt,
X`009      heap-cw);
X    else
X      sprintf(tkbuffer,
X`009      "Evaluation took %g seconds (%g in gc) %ld cons work\n",
X`009      myruntime()-rt,
X`009      gc_time_taken,
X`009      gc_cells_allocated);
X    grepl_puts(tkbuffer);
X    if (repl_print == NULL) lprint(x);
X    else (*repl_print)(x);`125`125
X
Xvoid set_fatal_exit_hook(void (*fcn)(void))
X`123fatal_exit_hook = fcn;`125
X
Xvoid err(char *message, LISP x)
X`123nointerrupt = 1;
X if NNULLP(x)`032
X    printf("ERROR: %s (see errobj)\n",message);
X  else printf("ERROR: %s\n",message);
X if (errjmp_ok == 1) `123setvar(sym_errobj,x,NIL); longjmp(errjmp,1);`125
X printf("FATAL ERROR DURING STARTUP OR CRITICAL CODE SECTION\n");
X if (fatal_exit_hook)
X   (*fatal_exit_hook)();
X else
X   exit(1);`125
X
Xvoid err_stack(char *ptr)
X     /* The user could be given an option to continue here */
X`123err("the currently assigned stack limit has been exceded",NIL);`125
X
XLISP stack_limit(LISP amount,LISP silent)
X`123if NNULLP(amount)
X   `123stack_size = get_c_long(amount);
X    stack_limit_ptr = STACK_LIMIT(stack_start_ptr,stack_size);`125
X if NULLP(silent)
X   `123sprintf(tkbuffer,"Stack_size = %ld bytes, [%08lX,0%08lX]\n",
X`009    stack_size,stack_start_ptr,stack_limit_ptr);
X    put_st(tkbuffer);
X    return(NIL);`125
X else
X   return(flocons(stack_size));`125
X
Xchar *get_c_string(LISP x)
X`123if TYPEP(x,tc_symbol)
X   return(PNAME(x));
X else if TYPEP(x,tc_string)
X   return(x->storage_as.string.data);
X else
X   err("not a symbol or string",x);`125
X
XLISP lerr(LISP message, LISP x)
X`123err(get_c_string(message),x);
X return(NIL);`125
X
Xvoid gc_fatal_error(void)
X`123err("ran out of storage",NIL);`125
X
XLISP newcell(long type)
X`123LISP z;
X NEWCELL(z,type);
X return(z);`125
X
XLISP cons(LISP x,LISP y)
X`123LISP z;
X NEWCELL(z,tc_cons);
X CAR(z) = x;
X CDR(z) = y;
X return(z);`125
X
XLISP consp(LISP x)
X`123if CONSP(x) return(truth); else return(NIL);`125
X
XLISP car(LISP x)
X`123switch TYPE(x)
X   `123case tc_nil:
X      return(NIL);
X    case tc_cons:
X      return(CAR(x));
X    default:
X      err("wta to car",x);`125`125
X
XLISP cdr(LISP x)
X`123switch TYPE(x)
X   `123case tc_nil:
X      return(NIL);
X    case tc_cons:
X      return(CDR(x));
X    default:
X      err("wta to cdr",x);`125`125
X
XLISP setcar(LISP cell, LISP value)
X`123if NCONSP(cell) err("wta to setcar",cell);
X return(CAR(cell) = value);`125
X
XLISP setcdr(LISP cell, LISP value)
X`123if NCONSP(cell) err("wta to setcdr",cell);
X return(CDR(cell) = value);`125
X
XLISP flocons(double x)
X`123LISP z;
X long n;
X if ((inums_dim > 0) &&
X     ((x - (n = x)) == 0) &&
X     (x >= 0) &&
X     (n < inums_dim))
X   return(inums[n]);
X NEWCELL(z,tc_flonum);
X FLONM(z) = x;
X return(z);`125
X
XLISP numberp(LISP x)
X`123if FLONUMP(x) return(truth); else return(NIL);`125
X
XLISP plus(LISP x,LISP y)
X`123if NFLONUMP(x) err("wta(1st) to plus",x);
X if NFLONUMP(y) err("wta(2nd) to plus",y);
X return(flocons(FLONM(x) + FLONM(y)));`125
X
XLISP ltimes(LISP x,LISP y)
X`123if NFLONUMP(x) err("wta(1st) to times",x);
X if NFLONUMP(y) err("wta(2nd) to times",y);
X return(flocons(FLONM(x)*FLONM(y)));`125
X
XLISP difference(LISP x,LISP y)
X`123LISP z;
X if NFLONUMP(x) err("wta(1st) to difference",x);
X if NFLONUMP(y) err("wta(2nd) to difference",y);
X return(flocons(FLONM(x) - FLONM(y)));`125
X
XLISP quotient(LISP x,LISP y)
X`123LISP z;
X if NFLONUMP(x) err("wta(1st) to quotient",x);
X if NFLONUMP(y) err("wta(2nd) to quotient",y);
X return(flocons(FLONM(x)/FLONM(y)));`125
X
XLISP greaterp(LISP x,LISP y)
X`123if NFLONUMP(x) err("wta(1st) to greaterp",x);
X if NFLONUMP(y) err("wta(2nd) to greaterp",y);
X if (FLONM(x)>FLONM(y)) return(truth);
X return(NIL);`125
X
XLISP lessp(LISP x,LISP y)
X`123if NFLONUMP(x) err("wta(1st) to lessp",x);
X if NFLONUMP(y) err("wta(2nd) to lessp",y);
X if (FLONM(x)<FLONM(y)) return(truth);
X return(NIL);`125
X
XLISP eq(LISP x,LISP y)
X`123if EQ(x,y) return(truth); else return(NIL);`125
X
XLISP eql(LISP x,LISP y)
X`123if EQ(x,y) return(truth); else`032
X if NFLONUMP(x) return(NIL); else
X if NFLONUMP(y) return(NIL); else
X if (FLONM(x) == FLONM(y)) return(truth);
X return(NIL);`125
X
XLISP symcons(char *pname,LISP vcell)
X`123LISP z;
X NEWCELL(z,tc_symbol);
X PNAME(z) = pname;
X VCELL(z) = vcell;
X return(z);`125
X
XLISP symbolp(LISP x)
X`123if SYMBOLP(x) return(truth); else return(NIL);`125
X
XLISP symbol_boundp(LISP x,LISP env)
X`123LISP tmp;
X if NSYMBOLP(x) err("not a symbol",x);
X tmp = envlookup(x,env);
X if NNULLP(tmp) return(truth);
X if EQ(VCELL(x),unbound_marker) return(NIL); else return(truth);`125
X
XLISP symbol_value(LISP x,LISP env)
X`123LISP tmp;
X if NSYMBOLP(x) err("not a symbol",x);
X tmp = envlookup(x,env);
X if NNULLP(tmp) return(CAR(tmp));
X tmp = VCELL(x);
X if EQ(tmp,unbound_marker) err("unbound variable",x);
X return(tmp);`125
X
Xchar *must_malloc(unsigned long size)
X`123char *tmp;
X tmp = (char *) malloc(size);
X if (tmp == (char *)NULL) err("failed to allocate storage from system",NIL);
X return(tmp);`125
X
XLISP gen_intern(char *name,long copyp)
X`123LISP l,sym,sl;
X char *cname;
X long hash,n,c,flag;
X flag = no_interrupt(1);
X if (obarray_dim > 1)
X   `123hash = 0;
X    n = obarray_dim;
X    cname = name;
X    while(c = *cname++) hash = ((hash * 17) `094 c) % n;
X    sl = obarray[hash];`125
X else
X   sl = oblistvar;
X for(l=sl;NNULLP(l);l=CDR(l))
X   if (strcmp(name,PNAME(CAR(l))) == 0)
X     `123no_interrupt(flag);
X      return(CAR(l));`125
X if (copyp == 1)
X   `123cname = (char *) must_malloc(strlen(name)+1);
X    strcpy(cname,name);`125
X else
X   cname = name;
X sym = symcons(cname,unbound_marker);
X if (obarray_dim > 1) obarray[hash] = cons(sym,sl);
X oblistvar = cons(sym,oblistvar);
X no_interrupt(flag);
X return(sym);`125
X
XLISP cintern(char *name)
X`123return(gen_intern(name,0));`125
X
XLISP rintern(char *name)
X`123return(gen_intern(name,1));`125
X
XLISP subrcons(long type, char *name, LISP (*f)())
X`123LISP z;
X NEWCELL(z,type);
X (*z).storage_as.subr.name = name;
X (*z).storage_as.subr.f = f;
X return(z);`125
X
XLISP closure(LISP env,LISP code)
X`123LISP z;
X NEWCELL(z,tc_closure);
X (*z).storage_as.closure.env = env;
X (*z).storage_as.closure.code = code;
X return(z);`125
X
Xvoid gc_protect(LISP *location)
X`123gc_protect_n(location,1);`125
X
Xvoid gc_protect_n(LISP *location,long n)
X`123struct gc_protected *reg;
X reg = (struct gc_protected *) must_malloc(sizeof(struct gc_protected));
X (*reg).location = location;
X (*reg).length = n;
X (*reg).next = protected_registers;
X  protected_registers = reg;`125
X
Xvoid gc_protect_sym(LISP *location,char *st)
X`123*location = cintern(st);
X gc_protect(location);`125
X
Xvoid scan_registers(void)
X`123struct gc_protected *reg;
X LISP *location;
X long j,n;
X for(reg = protected_registers; reg; reg = (*reg).next)
X   `123location = (*reg).location;
X    n = (*reg).length;
X    for(j=0;j<n;++j)
X      location[j] = gc_relocate(location[j]);`125`125
X
Xvoid init_storage(void)
X`123long j;
X init_storage_1();
X init_storage_a();
X set_gc_hooks(tc_c_file,0,0,0,file_gc_free,&j);
X set_print_hooks(tc_c_file,file_prin1);`125
X
Xvoid init_storage_1(void)
X`123LISP ptr,next,end;
X long j;
X tkbuffer = (char *) must_malloc(TKBUFFERN+1);
X heap_1 = (LISP) must_malloc(sizeof(struct obj)*heap_size);
X heap = heap_1;
X which_heap = 1;
X heap_org = heap;
X heap_end = heap + heap_size;
X if (gc_kind_copying == 1)
X   heap_2 = (LISP) must_malloc(sizeof(struct obj)*heap_size);
X else
X   `123ptr = heap_org;
X    end = heap_end;
X    while(1)
X      `123(*ptr).type = tc_free_cell;
X       next = ptr + 1;
X       if (next < end)
X`009 `123CDR(ptr) = next;
X`009  ptr = next;`125
X       else
X`009 `123CDR(ptr) = NIL;
X`009  break;`125`125
X    freelist = heap_org;`125
X gc_protect(&oblistvar);
X if (obarray_dim > 1)
X   `123obarray = (LISP *) must_malloc(sizeof(LISP) * obarray_dim);
X    for(j=0;j<obarray_dim;++j)
X      obarray[j] = NIL;
X    gc_protect_n(obarray,obarray_dim);`125
X unbound_marker = cons(cintern("**unbound-marker**"),NIL);
X gc_protect(&unbound_marker);
X eof_val = cons(cintern("eof"),NIL);
X gc_protect(&eof_val);
X gc_protect_sym(&truth,"t");
X setvar(truth,truth,NIL);
X setvar(cintern("nil"),NIL,NIL);
X setvar(cintern("let"),cintern("let-internal-macro"),NIL);
X gc_protect_sym(&sym_errobj,"errobj");
X setvar(sym_errobj,NIL,NIL);
X gc_protect_sym(&sym_progn,"begin");
X gc_protect_sym(&sym_lambda,"lambda");
X gc_protect_sym(&sym_quote,"quote");
X gc_protect_sym(&sym_dot,".");
X gc_protect(&open_files);
X if (inums_dim > 0)
X   `123inums = (LISP *) must_malloc(sizeof(LISP) * inums_dim);
X    for(j=0;j<inums_dim;++j)
X      `123NEWCELL(ptr,tc_flonum);
X       FLONM(ptr) = j;
X       inums[j] = ptr;`125
X    gc_protect_n(inums,inums_dim);`125`125
X`032
Xvoid init_subr(char *name, long type, LISP (*fcn)())
X`123setvar(cintern(name),subrcons(type,name,fcn),NIL);`125
X
XLISP assq(LISP x,LISP alist)
X`123LISP l,tmp;
X for(l=alist;CONSP(l);l=CDR(l))
X   `123tmp = CAR(l);
X    if (CONSP(tmp) && EQ(CAR(tmp),x)) return(tmp);`125
X if EQ(l,NIL) return(NIL);
X err("improper list to assq",alist);`125
X
Xstruct user_type_hooks *get_user_type_hooks(long type)
X`123long j;
X if (user_type_hooks == NULL)
X   `123user_type_hooks = (struct user_type_hooks *)
X      must_malloc(sizeof(struct user_type_hooks) * tc_table_dim);
X    for(j=0;j<tc_table_dim;++j)
X      memset(&user_type_hooks[j],0,sizeof(struct user_type_hooks));`125
X if ((type >= 0) && (type < tc_table_dim))
X   return(&user_type_hooks[type]);
X else
X   err("type number out of range",NIL);`125
X
Xvoid set_gc_hooks(long type,
X`009`009  LISP (*rel)(),
X`009`009  LISP (*mark)(),
X`009`009  void (*scan)(),
X`009`009  void (*free)(),
X`009`009  long *kind)
X`123struct user_type_hooks *p;
X p = get_user_type_hooks(type);
X p->gc_relocate = rel;
X p->gc_scan = scan;
X p->gc_mark = mark;
X p->gc_free = free;
X *kind = gc_kind_copying;`125
X
XLISP gc_relocate(LISP x)
X`123LISP new;
X struct user_type_hooks *p;
X if EQ(x,NIL) return(NIL);
X if ((*x).gc_mark == 1) return(CAR(x));
X switch TYPE(x)
X   `123case tc_flonum:
X    case tc_cons:
X    case tc_symbol:
X    case tc_closure:
X    case tc_subr_0:
X    case tc_subr_1:
X    case tc_subr_2:
X    case tc_subr_3:
X    case tc_lsubr:
X    case tc_fsubr:
X    case tc_msubr:
X      if ((new = heap) >= heap_end) gc_fatal_error();
X      heap = new+1;
X      memcpy(new,x,sizeof(struct obj));
X      break;
X    default:
X      p = get_user_type_hooks(TYPE(x));
X      if (p->gc_relocate)
X`009new = (*p->gc_relocate)(x);
X      else
X`009`123if ((new = heap) >= heap_end) gc_fatal_error();
X`009 heap = new+1;
X`009 memcpy(new,x,sizeof(struct obj));`125`125
X (*x).gc_mark = 1;
X CAR(x) = new;
X return(new);`125
X
XLISP get_newspace(void)
X`123LISP newspace;
X if (which_heap == 1)
X   `123newspace = heap_2;
X    which_heap = 2;`125
X else
X   `123newspace = heap_1;
X    which_heap = 1;`125
X heap = newspace;
X heap_org = heap;
X heap_end = heap + heap_size;
X return(newspace);`125
X
Xvoid scan_newspace(LISP newspace)
X`123LISP ptr;
X struct user_type_hooks *p;
X for(ptr=newspace; ptr < heap; ++ptr)
X   `123switch TYPE(ptr)
X      `123case tc_cons:
X       case tc_closure:
X`009 CAR(ptr) = gc_relocate(CAR(ptr));
X`009 CDR(ptr) = gc_relocate(CDR(ptr));
X`009 break;
X       case tc_symbol:
X`009 VCELL(ptr) = gc_relocate(VCELL(ptr));
X`009 break;
X       case tc_flonum:
X       case tc_subr_0:
X       case tc_subr_1:
X       case tc_subr_2:
X       case tc_subr_3:
X       case tc_lsubr:
X       case tc_fsubr:
X       case tc_msubr:
X`009 break;
X       default:
X`009 p = get_user_type_hooks(TYPE(ptr));
X`009 if (p->gc_scan) (*p->gc_scan)(ptr);`125`125`125
X
Xvoid free_oldspace(LISP space,LISP end)
X`123LISP ptr;
X struct user_type_hooks *p;
X for(ptr=space; ptr < end; ++ptr)
X   if (ptr->gc_mark == 0)
X     switch TYPE(ptr)
X       `123case tc_cons:
X`009case tc_closure:
X`009case tc_symbol:
X`009case tc_flonum:
X`009case tc_subr_0:
X`009case tc_subr_1:
X`009case tc_subr_2:
X`009case tc_subr_3:
X`009case tc_lsubr:
X`009case tc_fsubr:
X`009case tc_msubr:
X`009  break;
X`009default:
X`009  p = get_user_type_hooks(TYPE(ptr));
X`009  if (p->gc_free) (*p->gc_free)(ptr);`125`125
X     `032
Xvoid gc_stop_and_copy(void)
X`123LISP newspace,oldspace,end;
X long flag;
X flag = no_interrupt(1);
X errjmp_ok = 0;
X oldspace = heap_org;
X end = heap;
X old_heap_used = end - oldspace;
X newspace = get_newspace();
X scan_registers();
X scan_newspace(newspace);
X free_oldspace(oldspace,end);
X errjmp_ok = 1;
X no_interrupt(flag);`125
X
Xvoid gc_for_newcell(void)
X`123long flag;
X if (errjmp_ok == 0) gc_fatal_error();
X flag = no_interrupt(1);
X errjmp_ok = 0;
X gc_mark_and_sweep();
X errjmp_ok = 1;
X no_interrupt(flag);
X if NULLP(freelist) gc_fatal_error();`125
X
Xvoid gc_mark_and_sweep(void)
X`123LISP stack_end;
X gc_ms_stats_start();
X setjmp(save_regs_gc_mark);
X mark_locations((LISP *) save_regs_gc_mark,
X`009`009(LISP *) (((char *) save_regs_gc_mark) + sizeof(save_regs_gc_mark)));
X mark_protected_registers();
X mark_locations((LISP *) stack_start_ptr,
X`009`009(LISP *) &stack_end);
X#ifdef THINK_C
X mark_locations((LISP *) ((char *) stack_start_ptr + 2),
X`009`009(LISP *) ((char *) &stack_end + 2));
X#endif
X gc_sweep();
X gc_ms_stats_end();`125
X
Xvoid gc_ms_stats_start(void)
X`123gc_rt = myruntime();
X gc_cells_collected = 0;
X if (gc_status_flag)
X   printf("[starting GC]\n");`125
X
Xvoid gc_ms_stats_end(void)
X`123gc_rt = myruntime() - gc_rt;
X gc_time_taken = gc_time_taken + gc_rt;
X if (gc_status_flag)
X   printf("[GC took %g cpu seconds, %ld cells collected]\n",
X`009  gc_rt,
X`009  gc_cells_collected);`125
X
Xvoid gc_mark(LISP ptr)
X`123struct user_type_hooks *p;
X gc_mark_loop:
X if NULLP(ptr) return;
X if ((*ptr).gc_mark) return;
X (*ptr).gc_mark = 1;
X switch ((*ptr).type)
X   `123case tc_flonum:
X      break;
X    case tc_cons:
X      gc_mark(CAR(ptr));
X      ptr = CDR(ptr);
X      goto gc_mark_loop;
X    case tc_symbol:
X      ptr = VCELL(ptr);
X      goto gc_mark_loop;
X    case tc_closure:
X      gc_mark((*ptr).storage_as.closure.code);
X      ptr = (*ptr).storage_as.closure.env;
X      goto gc_mark_loop;
X    case tc_subr_0:
X    case tc_subr_1:
X    case tc_subr_2:
X    case tc_subr_3:
X    case tc_lsubr:
X    case tc_fsubr:
X    case tc_msubr:
X      break;
X    default:
X      p = get_user_type_hooks(TYPE(ptr));
X      if (p->gc_mark)
X`009ptr = (*p->gc_mark)(ptr);`125`125
X
Xvoid mark_protected_registers(void)
X`123struct gc_protected *reg;
X LISP *location;
X long j,n;
X for(reg = protected_registers; reg; reg = (*reg).next)
X   `123location = (*reg).location;
X    n = (*reg).length;
X    for(j=0;j<n;++j)
X      gc_mark(location[j]);`125`125
X
Xvoid mark_locations(LISP *start,LISP *end)
X`123LISP *tmp;
X long n;
X if (start > end)
X   `123tmp = start;
X    start = end;
X    end = tmp;`125
X n = end - start;
X mark_locations_array(start,n);`125
X
Xvoid mark_locations_array(LISP *x,long n)
X`123int j;
X LISP p;
X for(j=0;j<n;++j)
X   `123p = x[j];
X    if ((p >= heap_org) &&
X`009(p < heap_end) &&
X`009(((((char *)p) - ((char *)heap_org)) % sizeof(struct obj)) == 0) &&
X`009NTYPEP(p,tc_free_cell))
X      gc_mark(p);`125`125
X
Xvoid gc_sweep(void)
X`123LISP ptr,end,nfreelist;
X long n;
X struct user_type_hooks *p;
X end = heap_end;
X n = 0;
X nfreelist = freelist;
X for(ptr=heap_org; ptr < end; ++ptr)
X   if (((*ptr).gc_mark == 0))
X     `123switch((*ptr).type)
X`009`123case tc_free_cell:
X`009 case tc_cons:
X`009 case tc_closure:
X`009 case tc_symbol:
X`009 case tc_flonum:
X`009 case tc_subr_0:
X`009 case tc_subr_1:
X`009 case tc_subr_2:
X`009 case tc_subr_3:
X`009 case tc_lsubr:
X`009 case tc_fsubr:
X`009 case tc_msubr:
X`009   break;
X`009 default:
X`009   p = get_user_type_hooks(TYPE(ptr));
X`009   if (p->gc_free)
X`009     (*p->gc_free)(ptr);`125
X      ++n;
X      (*ptr).type = tc_free_cell;
X      CDR(ptr) = nfreelist;
X      nfreelist = ptr;`125
X   else
X     (*ptr).gc_mark = 0;
X gc_cells_collected = n;
X freelist = nfreelist;`125
X
XLISP user_gc(LISP args)
X`123long old_status_flag,flag;
X if (gc_kind_copying == 1)
X   err("implementation cannot GC at will with stop-and-copy\n",
X       NIL);
X flag = no_interrupt(1);
X errjmp_ok = 0;
X old_status_flag = gc_status_flag;
X if NNULLP(args)
X   if NULLP(car(args)) gc_status_flag = 0; else gc_status_flag = 1;
X gc_mark_and_sweep();
X gc_status_flag = old_status_flag;
X errjmp_ok = 1;
X no_interrupt(flag);
X return(NIL);`125
X`032
XLISP gc_status(LISP args)
X`123LISP l;
X int n;
X if NNULLP(args)`032
X   if NULLP(car(args)) gc_status_flag = 0; else gc_status_flag = 1;
X if (gc_kind_copying == 1)
X   `123if (gc_status_flag)
X      put_st("garbage collection is on\n");
X   else
X     put_st("garbage collection is off\n");
X    sprintf(tkbuffer,"%ld allocated %ld free\n",
X`009    heap - heap_org, heap_end - heap);
X    put_st(tkbuffer);`125
X else
X   `123if (gc_status_flag)
X      put_st("garbage collection verbose\n");
X    else
X      put_st("garbage collection silent\n");
X    `123for(n=0,l=freelist;NNULLP(l); ++n) l = CDR(l);
X     sprintf(tkbuffer,"%ld allocated %ld free\n",
X`009     (heap_end - heap_org) - n,n);
X     put_st(tkbuffer);`125`125
X return(NIL);`125
X
XLISP leval_args(LISP l,LISP env)
X`123LISP result,v1,v2,tmp;
X if NULLP(l) return(NIL);
X if NCONSP(l) err("bad syntax argument list",l);
X result = cons(leval(CAR(l),env),NIL);
X for(v1=result,v2=CDR(l);
X     CONSP(v2);
X     v1 = tmp, v2 = CDR(v2))
X  `123tmp = cons(leval(CAR(v2),env),NIL);
X   CDR(v1) = tmp;`125
X if NNULLP(v2) err("bad syntax argument list",l);
X return(result);`125
X
XLISP extend_env(LISP actuals,LISP formals,LISP env)
X`123if SYMBOLP(formals)
X   return(cons(cons(cons(formals,NIL),cons(actuals,NIL)),env));
X return(cons(cons(formals,actuals),env));`125
X
XLISP envlookup(LISP var,LISP env)
X`123LISP frame,al,fl,tmp;
X for(frame=env;CONSP(frame);frame=CDR(frame))
X   `123tmp = CAR(frame);
X    if NCONSP(tmp) err("damaged frame",tmp);
X    for(fl=CAR(tmp),al=CDR(tmp);
X`009CONSP(fl);
X`009fl=CDR(fl),al=CDR(al))
X      `123if NCONSP(al) err("too few arguments",tmp);
X       if EQ(CAR(fl),var) return(al);`125`125
X if NNULLP(frame) err("damaged env",env);
X return(NIL);`125
X
Xvoid set_eval_hooks(long type,LISP (*fcn)())
X`123struct user_type_hooks *p;
X p = get_user_type_hooks(type);
X p->leval = fcn;`125
X
XLISP leval(LISP x,LISP env)
X`123LISP tmp,arg1;
X struct user_type_hooks *p;
X STACK_CHECK(&x);
X loop:
X INTERRUPT_CHECK();
X switch TYPE(x)
X   `123case tc_symbol:
X      tmp = envlookup(x,env);
X      if NNULLP(tmp) return(CAR(tmp));
X      tmp = VCELL(x);
X      if EQ(tmp,unbound_marker) err("unbound variable",x);
X      return(tmp);
X    case tc_cons:
X      tmp = CAR(x);
X      switch TYPE(tmp)
X`009`123case tc_symbol:
X`009   tmp = envlookup(tmp,env);
X`009   if NNULLP(tmp)
X`009     `123tmp = CAR(tmp);
X`009      break;`125
X`009   tmp = VCELL(CAR(x));
X`009   if EQ(tmp,unbound_marker) err("unbound variable",CAR(x));
X`009   break;
X`009 case tc_cons:
X`009   tmp = leval(tmp,env);
X`009   break;`125
X      switch TYPE(tmp)
X`009`123case tc_subr_0:
X`009   return(SUBRF(tmp)());
X`009 case tc_subr_1:
X`009   return(SUBRF(tmp)(leval(car(CDR(x)),env)));
X`009 case tc_subr_2:
X`009   x = CDR(x);
X`009   arg1 = leval(car(x),env);
X`009   x = NULLP(x) ? NIL : CDR(x);
X`009   return(SUBRF(tmp)(arg1,
X`009`009`009     leval(car(x),env)));
X`009 case tc_subr_3:
X`009   x = CDR(x);
X`009   arg1 = leval(car(x),env);
X`009   x = NULLP(x) ? NIL : CDR(x);
X`009   return(SUBRF(tmp)(arg1,
X`009`009`009     leval(car(x),env),
X`009`009`009     leval(car(cdr(x)),env)));
X`009 case tc_lsubr:
X`009   return(SUBRF(tmp)(leval_args(CDR(x),env)));
X`009 case tc_fsubr:
X`009   return(SUBRF(tmp)(CDR(x),env));
X`009 case tc_msubr:
X`009   if NULLP(SUBRF(tmp)(&x,&env)) return(x);
X`009   goto loop;
X`009 case tc_closure:
X`009   env = extend_env(leval_args(CDR(x),env),
X`009`009`009    car((*tmp).storage_as.closure.code),
X`009`009`009    (*tmp).storage_as.closure.env);
X`009   x = cdr((*tmp).storage_as.closure.code);
X`009   goto loop;
X`009 case tc_symbol:
X`009   x = cons(tmp,cons(cons(sym_quote,cons(x,NIL)),NIL));
X`009   x = leval(x,NIL);
X`009   goto loop;
X`009 default:
X`009   p = get_user_type_hooks(TYPE(tmp));
X`009   if (p->leval)
V`009     `123if NULLP((*p->leval)(tmp,&x,&env)) return(x); else goto loop;`12
X5
X`009   err("bad function",tmp);`125
X    default:
X      return(x);`125`125
X
XLISP setvar(LISP var,LISP val,LISP env)
X`123LISP tmp;
X if NSYMBOLP(var) err("wta(non-symbol) to setvar",var);
X tmp = envlookup(var,env);
X if NULLP(tmp) return(VCELL(var) = val);
X return(CAR(tmp)=val);`125
X`032
XLISP leval_setq(LISP args,LISP env)
X`123return(setvar(car(args),leval(car(cdr(args)),env),env));`125
X
XLISP syntax_define(LISP args)
X`123if SYMBOLP(car(args)) return(args);
X return(syntax_define(
X        cons(car(car(args)),
X`009cons(cons(sym_lambda,
X`009     cons(cdr(car(args)),
X`009`009  cdr(args))),
X`009     NIL))));`125
X     `032
XLISP leval_define(LISP args,LISP env)
X`123LISP tmp,var,val;
X tmp = syntax_define(args);
X var = car(tmp);
X if NSYMBOLP(var) err("wta(non-symbol) to define",var);
X val = leval(car(cdr(tmp)),env);
X tmp = envlookup(var,env);
X if NNULLP(tmp) return(CAR(tmp) = val);
X if NULLP(env) return(VCELL(var) = val);
X tmp = car(env);
X setcar(tmp,cons(var,car(tmp)));
X setcdr(tmp,cons(val,cdr(tmp)));
X return(val);`125
X`032
XLISP leval_if(LISP *pform,LISP *penv)
X`123LISP args,env;
X args = cdr(*pform);
X env = *penv;
X if NNULLP(leval(car(args),env))`032
X    *pform = car(cdr(args)); else *pform = car(cdr(cdr(args)));
X return(truth);`125
X
XLISP leval_lambda(LISP args,LISP env)
X`123LISP body;
X if NULLP(cdr(cdr(args)))
X   body = car(cdr(args));
X  else body = cons(sym_progn,cdr(args));
X return(closure(env,cons(arglchk(car(args)),body)));`125
X                        `032
XLISP leval_progn(LISP *pform,LISP *penv)
X`123LISP env,l,next;
X env = *penv;
X l = cdr(*pform);
X next = cdr(l);
X while(NNULLP(next)) `123leval(car(l),env);l=next;next=cdr(next);`125
X *pform = car(l);`032
X return(truth);`125
X
XLISP leval_or(LISP *pform,LISP *penv)
X`123LISP env,l,next,val;
X env = *penv;
X l = cdr(*pform);
X next = cdr(l);
X while(NNULLP(next))
X   `123val = leval(car(l),env);
X    if NNULLP(val) `123*pform = val; return(NIL);`125
X    l=next;next=cdr(next);`125
X *pform = car(l);`032
X return(truth);`125
X
XLISP leval_and(LISP *pform,LISP *penv)
X`123LISP env,l,next;
X env = *penv;
X l = cdr(*pform);
X if NULLP(l) `123*pform = truth; return(NIL);`125
X next = cdr(l);
X while(NNULLP(next))
X   `123if NULLP(leval(car(l),env)) `123*pform = NIL; return(NIL);`125
X    l=next;next=cdr(next);`125
X *pform = car(l);`032
X return(truth);`125
X
XLISP leval_catch(LISP args,LISP env)
X`123struct catch_frame frame;
X int k;
X LISP l,val;
X frame.tag = leval(car(args),env);
X frame.next = catch_framep;
X k = setjmp(frame.cframe);
X catch_framep = &frame;
X if (k == 2)
X   `123catch_framep = frame.next;
X    return(frame.retval);`125
X for(l=cdr(args); NNULLP(l); l = cdr(l))
X   val = leval(car(l),env);
X catch_framep = frame.next;
X return(val);`125
X
XLISP lthrow(LISP tag,LISP value)
X`123struct catch_frame *l;
X for(l=catch_framep; l; l = (*l).next)
X   if EQ((*l).tag,tag)
X     `123(*l).retval = value;
X      longjmp((*l).cframe,2);`125
X err("no *catch found with this tag",tag);
X return(NIL);`125
X
XLISP leval_let(LISP *pform,LISP *penv)
X`123LISP env,l;
X l = cdr(*pform);
X env = *penv;
X *penv = extend_env(leval_args(car(cdr(l)),env),car(l),env);
X *pform = car(cdr(cdr(l)));
X return(truth);`125
X
XLISP reverse(LISP l)
X`123LISP n,p;
X n = NIL;
X for(p=l;NNULLP(p);p=cdr(p)) n = cons(car(p),n);
X return(n);`125
X
XLISP let_macro(LISP form)
X`123LISP p,fl,al,tmp;
X fl = NIL;
X al = NIL;
X for(p=car(cdr(form));NNULLP(p);p=cdr(p))
X  `123tmp = car(p);
X   if SYMBOLP(tmp) `123fl = cons(tmp,fl); al = cons(NIL,al);`125
X   else `123fl = cons(car(tmp),fl); al = cons(car(cdr(tmp)),al);`125`125
X p = cdr(cdr(form));
X if NULLP(cdr(p)) p = car(p); else p = cons(sym_progn,p);
X setcdr(form,cons(reverse(fl),cons(reverse(al),cons(p,NIL))));
X setcar(form,cintern("let-internal"));
X return(form);`125
X  `032
XLISP leval_quote(LISP args,LISP env)
X`123return(car(args));`125
X
XLISP leval_tenv(LISP args,LISP env)
X`123return(env);`125
X
XLISP leval_while(LISP args,LISP env)
X`123LISP l;
X while NNULLP(leval(car(args),env))
X   for(l=cdr(args);NNULLP(l);l=cdr(l))
X     leval(car(l),env);
X return(NIL);`125
X
XLISP symbolconc(LISP args)
X`123long size;
X LISP l,s;
X size = 0;
X tkbuffer[0] = 0;
X for(l=args;NNULLP(l);l=cdr(l))
X   `123s = car(l);
X    if NSYMBOLP(s) err("wta(non-symbol) to symbolconc",s);
X    size = size + strlen(PNAME(s));
X    if (size >  TKBUFFERN) err("symbolconc buffer overflow",NIL);
X    strcat(tkbuffer,PNAME(s));`125
X return(rintern(tkbuffer));`125
X
Xvoid set_print_hooks(long type,void (*fcn)())
X`123struct user_type_hooks *p;
X p = get_user_type_hooks(type);
X p->prin1 = fcn;`125
X
XLISP lprin1f(LISP exp,FILE *f)
X`123LISP tmp;
X struct user_type_hooks *p;
X STACK_CHECK(&exp);
X INTERRUPT_CHECK();
X switch TYPE(exp)
X   `123case tc_nil:
X      fput_st(f,"()");
X      break;
X   case tc_cons:
X      fput_st(f,"(");
X      lprin1f(car(exp),f);
X      for(tmp=cdr(exp);CONSP(tmp);tmp=cdr(tmp))
X`009`123fput_st(f," ");lprin1f(car(tmp),f);`125
X      if NNULLP(tmp) `123fput_st(f," . ");lprin1f(tmp,f);`125
X      fput_st(f,")");
X      break;
X    case tc_flonum:
X      sprintf(tkbuffer,"%g",FLONM(exp));
X      fput_st(f,tkbuffer);
X      break;
X    case tc_symbol:
X      fput_st(f,PNAME(exp));
X      break;
X    case tc_subr_0:
X    case tc_subr_1:
X    case tc_subr_2:
X    case tc_subr_3:
X    case tc_lsubr:
X    case tc_fsubr:
X    case tc_msubr:
X      sprintf(tkbuffer,"#<SUBR(%d) ",TYPE(exp));
X      fput_st(f,tkbuffer);
X      fput_st(f,(*exp).storage_as.subr.name);
X      fput_st(f,">");
X      break;
X    case tc_closure:
X      fput_st(f,"#<CLOSURE ");
X      lprin1f(car((*exp).storage_as.closure.code),f);
X      fput_st(f," ");
X      lprin1f(cdr((*exp).storage_as.closure.code),f);
X      fput_st(f,">");
X      break;
X    default:
X      p = get_user_type_hooks(TYPE(exp));
X      if (p->prin1)
X`009(*p->prin1)(exp,f);
X      else
X`009`123sprintf(tkbuffer,"#<UNKNOWN %d %lX>",TYPE(exp),exp);
X`009 fput_st(f,tkbuffer);`125`125
X return(NIL);`125
X
XLISP lprint(LISP exp)
X`123lprin1f(exp,stdout);
X put_st("\n");
X return(NIL);`125
X
XLISP lread(void)
X`123return(lreadf(stdin));`125
X
Xint f_getc(FILE *f)
X`123long iflag,dflag;
X int c;
X iflag = no_interrupt(1);
X dflag = interrupt_differed;
X c = getc(f);
X#ifdef VMS
X if ((dflag == 0) & interrupt_differed & (f == stdin))
X   while((c != 0) & (c != EOF)) c = getc(f);
X#endif
X no_interrupt(iflag);
X return(c);`125
X
Xvoid f_ungetc(int c, FILE *f)
X`123ungetc(c,f);`125
X
Xint flush_ws(struct gen_readio *f,char *eoferr)
X`123int c,commentp;
X commentp = 0;
X while(1)
X   `123c = GETC_FCN(f);
X    if (c == EOF) if (eoferr) err(eoferr,NIL); else return(c);
X    if (commentp) `123if (c == '\n') commentp = 0;`125
X    else if (c == ';') commentp = 1;
X    else if (!isspace(c)) return(c);`125`125
X
XLISP lreadf(FILE *f)
X`123struct gen_readio s;
X s.getc_fcn = (int (*)(char *))f_getc;
X s.ungetc_fcn = (void (*)(int, char *))f_ungetc;
X s.cb_argument = (char *) f;
X return(readtl(&s));`125
X
XLISP readtl(struct gen_readio *f)
X`123int c;
X c = flush_ws(f,(char *)NULL);
X if (c == EOF) return(eof_val);
X UNGETC_FCN(c,f);
X return(lreadr(f));`125
X`032
Xvoid set_read_hooks(char *all_set,char *end_set,
X`009`009    LISP (*fcn1)(),LISP (*fcn2)())
X`123user_ch_readm = all_set;
X user_te_readm = end_set;
X user_readm = fcn1;
X user_readt = fcn2;`125
X
XLISP lreadr(struct gen_readio *f)
X`123int c,j;
X char *p;
X STACK_CHECK(&f);
X p = tkbuffer;
X c = flush_ws(f,"end of file inside read");
X switch (c)
X   `123case '(':
X      return(lreadparen(f));
X    case ')':
X      err("unexpected close paren",NIL);
X    case '\'':
X      return(cons(sym_quote,cons(lreadr(f),NIL)));
X    case '`096':
X      return(cons(cintern("+internal-backquote"),lreadr(f)));
X    case ',':
X      c = GETC_FCN(f);
X      switch(c)
X`009`123case '@':
X`009   p = "+internal-comma-atsign";
X`009   break;
X`009 case '.':
X`009   p = "+internal-comma-dot";
X`009   break;
X`009 default:
X`009   p = "+internal-comma";
X`009   UNGETC_FCN(c,f);`125
X      return(cons(cintern(p),lreadr(f)));
X    case '"':
X      return(lreadstring(f));
X    default:
X      if ((user_readm != NULL) && strchr(user_ch_readm,c))
X`009return((*user_readm)(c,f));`125
X *p++ = c;
X for(j = 1; j<TKBUFFERN; ++j)
X   `123c = GETC_FCN(f);
X    if (c == EOF) return(lreadtk(j));
X    if (isspace(c)) return(lreadtk(j));
X    if (strchr("()'`096,;\"",c) `124`124 strchr(user_te_readm,c))
X      `123UNGETC_FCN(c,f);return(lreadtk(j));`125
X    *p++ = c;`125
X err("token larger than TKBUFFERN",NIL);`125
X
XLISP lreadparen(struct gen_readio *f)
X`123int c;
X LISP tmp;
X c = flush_ws(f,"end of file inside list");
X if (c == ')') return(NIL);
X UNGETC_FCN(c,f);
X tmp = lreadr(f);
X if EQ(tmp,sym_dot)
X   `123tmp = lreadr(f);
X    c = flush_ws(f,"end of file inside list");
X    if (c != ')') err("missing close paren",NIL);
X    return(tmp);`125
X return(cons(tmp,lreadparen(f)));`125
X
XLISP lreadtk(long j)
X`123int k,flag;
X char c,*p;
X LISP tmp;
X int adigit;
X p = tkbuffer;
X p[j] = 0;
X if (user_readt != NULL)
X   `123tmp = (*user_readt)(p,j,&flag);
X    if (flag) return(tmp);`125
X if (*p == '-') p+=1;
X adigit = 0;
X while(isdigit(*p)) `123p+=1; adigit=1;`125
X if (*p=='.')
X   `123p += 1;
X    while(isdigit(*p)) `123p+=1; adigit=1;`125`125
X if (!adigit) goto a_symbol;
X if (*p=='e')
X   `123p+=1;
X    if (*p=='-'`124`124*p=='+') p+=1;
X    if (!isdigit(*p)) goto a_symbol; else p+=1;
X    while(isdigit(*p)) p+=1;`125
X if (*p) goto a_symbol;
X return(flocons(atof(tkbuffer)));
X a_symbol:
X return(rintern(tkbuffer));`125
X     `032
XLISP copy_list(LISP x)
X`123if NULLP(x) return(NIL);
X STACK_CHECK(&x);
X return(cons(car(x),copy_list(cdr(x))));`125
X
XLISP oblistfn(void)
X`123return(copy_list(oblistvar));`125
X
Xvoid close_open_files(void)
X`123LISP l,p;
X for(l=open_files;NNULLP(l);l=cdr(l))
X   `123p = car(l);
X    if (p->storage_as.c_file.f)
X      `123printf("closing a file left open: %s\n",
X`009      (p->storage_as.c_file.name) ? p->storage_as.c_file.name : "");
X       file_gc_free(p);`125`125
X open_files = NIL;`125
X
XLISP fopen_c(char *name,char *how)
X`123LISP sym;
X long flag;
X flag = no_interrupt(1);
X sym = newcell(tc_c_file);
X sym->storage_as.c_file.f = (FILE *)NULL;
X sym->storage_as.c_file.name = (char *)NULL;
X open_files = cons(sym,open_files);
X if (!(sym->storage_as.c_file.f = fopen(name,how)))
X   `123perror(name);
X    put_st("\n");
X    err("could not open file",NIL);`125
X sym->storage_as.c_file.name = (char *) must_malloc(strlen(name)+1);
X strcpy(sym->storage_as.c_file.name,name);
X no_interrupt(flag);
X return(sym);`125
X
XLISP fopen_l(LISP name,LISP how)
V`123return(fopen_c(get_c_string(name),NULLP(how) ? "r" : get_c_string(how)));
X`125
X
XLISP delq(LISP elem,LISP l)
X`123if NULLP(l) return(l);
X STACK_CHECK(&elem);
X if EQ(elem,car(l)) return(cdr(l));
X setcdr(l,delq(elem,cdr(l)));
X return(l);`125
X
XLISP fclose_l(LISP p)
X`123long flag;
X flag = no_interrupt(1);
X if NTYPEP(p,tc_c_file) err("not a file",p);
X file_gc_free(p);
X open_files = delq(p,open_files);
X no_interrupt(flag);
X return(NIL);`125
X
XLISP vload(char *fname,long cflag)
X`123LISP form,result,tail,lf;
X FILE *f;
X put_st("loading ");
X put_st(fname);
X put_st("\n");
X lf = fopen_c(fname,"r");
X f = lf->storage_as.c_file.f;
X result = NIL;
X tail = NIL;
X while(1)
X   `123form = lreadf(f);
X    if EQ(form,eof_val) break;
X    if (cflag)
X      `123form = cons(form,NIL);
X       if NULLP(result)
X`009 result = tail = form;
X       else
X`009 tail = setcdr(tail,form);`125
X    else
X      leval(form,NIL);`125
X fclose_l(lf);
X put_st("done.\n");
X return(result);`125
X
XLISP load(LISP fname,LISP cflag)
X`123return(vload(get_c_string(fname),NULLP(cflag) ? 0 : 1));`125
X
XLISP save_forms(LISP fname,LISP forms,LISP how)
X`123char *cname,*chow;
X LISP l,lf;
X FILE *f;
X cname = get_c_string(fname);
X if EQ(how,NIL) chow = "w";
X else if EQ(how,cintern("a")) chow = "a";
X else err("bad argument to save-forms",how);
X put_st((*chow == 'a') ? "appending" : "saving");
X put_st(" forms to ");
X put_st(cname);
X put_st("\n");
X lf = fopen_c(cname,chow);
X f = lf->storage_as.c_file.f;
X for(l=forms;NNULLP(l);l=cdr(l))
X   `123lprin1f(car(l),f);
X    putc('\n',f);`125
X fclose_l(lf);
X put_st("done.\n");
X return(truth);`125
X
XLISP quit(void)
X`123longjmp(errjmp,2);
X return(NIL);`125
X
XLISP nullp(LISP x)
X`123if EQ(x,NIL) return(truth); else return(NIL);`125
X
XLISP arglchk(LISP x)
X`123LISP l;
X if SYMBOLP(x) return(x);
X for(l=x;CONSP(l);l=CDR(l));
X if NNULLP(l) err("improper formal argument list",x);
X return(x);`125
X
Xvoid file_gc_free(LISP ptr)
X`123if (ptr->storage_as.c_file.f)
X   `123fclose(ptr->storage_as.c_file.f);
X    ptr->storage_as.c_file.f = (FILE *) NULL;`125
X if (ptr->storage_as.c_file.name)
X   `123free(ptr->storage_as.c_file.name);
X    ptr->storage_as.c_file.name = NULL;`125`125
X  `032
Xvoid file_prin1(LISP ptr,FILE *f)
X`123char *name;
X name = ptr->storage_as.c_file.name;
X fput_st(f,"#<FILE ");
X sprintf(tkbuffer," %lX",ptr->storage_as.c_file.f);
X fput_st(f,tkbuffer);
X if (name)
X   `123fput_st(f," ");
X    fput_st(f,name);`125
X fput_st(f,">");`125
X
XFILE *get_c_file(LISP p,FILE *deflt)
X`123if (NULLP(p) && deflt) return(deflt);
X if NTYPEP(p,tc_c_file) err("not a file",p);
X if (!p->storage_as.c_file.f) err("file is closed",p);
X return(p->storage_as.c_file.f);`125
X
XLISP lgetc(LISP p)
X`123int i;
X i = f_getc(get_c_file(p,stdin));
X return((i == EOF) ? NIL : flocons((double)i));`125
X
XLISP lputc(LISP c,LISP p)
X`123long flag;
X int i;
X FILE *f;
X f = get_c_file(p,stdout);
X if FLONUMP(c)
X   i = FLONM(c);
X else
X   i = *get_c_string(c);
X flag = no_interrupt(1);
X putc(i,f);
X no_interrupt(flag);
X return(NIL);`125
X    `032
XLISP lputs(LISP str,LISP p)
X`123fput_st(get_c_file(p,stdout),get_c_string(str));
X return(NIL);`125
X
XLISP parse_number(LISP x)
X`123char *c;
X c = get_c_string(x);
X return(flocons(atof(c)));`125
X
Xvoid init_subrs(void)
X`123init_subrs_1();
X init_subrs_a();`125
X
Xvoid init_subrs_1(void)
X`123init_subr("cons",tc_subr_2,cons);
X init_subr("car",tc_subr_1,car);
X init_subr("cdr",tc_subr_1,cdr);
X init_subr("set-car!",tc_subr_2,setcar);
X init_subr("set-cdr!",tc_subr_2,setcdr);
X init_subr("+",tc_subr_2,plus);
X init_subr("-",tc_subr_2,difference);
X init_subr("*",tc_subr_2,ltimes);
X init_subr("/",tc_subr_2,quotient);
X init_subr(">",tc_subr_2,greaterp);
X init_subr("<",tc_subr_2,lessp);
X init_subr("eq?",tc_subr_2,eq);
X init_subr("eqv?",tc_subr_2,eql);
X init_subr("assq",tc_subr_2,assq);
X init_subr("delq",tc_subr_2,delq);
X init_subr("read",tc_subr_0,lread);
X init_subr("eof-val",tc_subr_0,get_eof_val);
X init_subr("print",tc_subr_1,lprint);
X init_subr("eval",tc_subr_2,leval);
X init_subr("define",tc_fsubr,leval_define);
X init_subr("lambda",tc_fsubr,leval_lambda);
X init_subr("if",tc_msubr,leval_if);
X init_subr("while",tc_fsubr,leval_while);
X init_subr("begin",tc_msubr,leval_progn);
X init_subr("set!",tc_fsubr,leval_setq);
X init_subr("or",tc_msubr,leval_or);
X init_subr("and",tc_msubr,leval_and);
X init_subr("*catch",tc_fsubr,leval_catch);
X init_subr("*throw",tc_subr_2,lthrow);
X init_subr("quote",tc_fsubr,leval_quote);
X init_subr("oblist",tc_subr_0,oblistfn);
X init_subr("copy-list",tc_subr_1,copy_list);
X init_subr("gc-status",tc_lsubr,gc_status);
X init_subr("gc",tc_lsubr,user_gc);
X init_subr("load",tc_subr_2,load);
X init_subr("pair?",tc_subr_1,consp);
X init_subr("symbol?",tc_subr_1,symbolp);
X init_subr("number?",tc_subr_1,numberp);
X init_subr("let-internal",tc_msubr,leval_let);
X init_subr("let-internal-macro",tc_subr_1,let_macro);
X init_subr("symbol-bound?",tc_subr_2,symbol_boundp);
X init_subr("symbol-value",tc_subr_2,symbol_value);
X init_subr("set-symbol-value!",tc_subr_3,setvar);
X init_subr("the-environment",tc_fsubr,leval_tenv);
X init_subr("error",tc_subr_2,lerr);
X init_subr("quit",tc_subr_0,quit);
X init_subr("not",tc_subr_1,nullp);
X init_subr("null?",tc_subr_1,nullp);
X init_subr("env-lookup",tc_subr_2,envlookup);
X init_subr("reverse",tc_subr_1,reverse);
X init_subr("symbolconc",tc_lsubr,symbolconc);
X init_subr("save-forms",tc_subr_3,save_forms);
X init_subr("fopen",tc_subr_2,fopen_l);
X init_subr("fclose",tc_subr_1,fclose_l);
X init_subr("getc",tc_subr_1,lgetc);
X init_subr("putc",tc_subr_2,lputc);
X init_subr("puts",tc_subr_2,lputs);
X init_subr("parse-number",tc_subr_1,parse_number);
X init_subr("%%stack-limit",tc_subr_2,stack_limit);`125
X
X/* err0,pr,prp are convenient to call from the C-language debugger */
X
Xvoid err0(void)
X`123err("0",NIL);`125
X
Xvoid pr(LISP p)
X`123if ((p >= heap_org) &&
X     (p < heap_end) &&
X     (((((char *)p) - ((char *)heap_org)) % sizeof(struct obj)) == 0))
X   lprint(p);
X else
X   put_st("invalid\n");`125
X
Xvoid prp(LISP *p)
X`123if (!p) return;
X pr(*p);`125
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.TIM"
$ CHECKSUM_IS = 654458232
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
XNew timings, SIOD v2.7
X
X
XMake     Model             FIB(5) FIB(10) FIB(15) FIB(20)  20/FIB(20)
XSUN      ?                 0.00   0.02     0.12   1.17
XSUN      4/690             0.00   0.00     0.10   1.27
X
X
X
X
XHere are some timings taken with version 1.3 of SIOD. The new version 1.5
Xis slightly faster. If you do timings it is interesting to try it
Xwith and without the mark-and-sweep GC, and with various heap sizes.
X
XPlease report both total and GC times, heap size, and kinds of GC's used
Xto: GJC@PARADIGM.COM
X
XMake     Model             FIB(5) FIB(10) FIB(15) FIB(20)  20/FIB(20)
XSun      4                  0.00   0.02    0.38     4.2     4.76
XDIGITAL  8530(VMS)          0.00   0.07    0.78     8.5     2.35
XSun      3/280              0.00   0.10    0.88     8.5     2.35
XDIGITAL  VS-3200(VMS)       0.01   0.11    1.28    14.2     1.41
XSun      3/180              0.02   0.15    1.56    17.5     1.14
XEncore   Multimax(NS32)     0.02   0.17    1.85    20.5     0.97
XDIGITAL  VS-2000            0.02   0.30    3.56    39.7     0.50
XEncore   Multimax(NS16)     0.03   0.33    3.63    40.4     0.49
XAMIGA    500 LATTICE C      0.00   0.00    5.00    55.0(x)  0.36
X
XUnix compilations done with the -O flag. All 68020 machines
Xwith -f68881. Heap size of 120000 used. Timing done with standard-fib
Xprocedure in siod.scm using SIOD Version 1.3 (which is slightly slower
Xthan earlier versions). AMIGA 500 FIB(20) time is extrapolated from
Xthe FIB(15) time.
X
XCheck to be sure that your standard-fib returns the following:
X
X n  FIB(n)  Cons Work
X 5      5      66
X10     55     795
X15    610    8877
X20   6765   98508
X
X(Figures above for -n0, no inums)
$ GOSUB UNPACK_FILE

$ FILE_IS = "MAKEFILE.COM"
$ CHECKSUM_IS = 726546442
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X$ CFLAGS = ""
X$ LFLAGS = ""
X$!
X$ CC'CFLAGS'   SLIB.C
X$ CC'CFLAGS'   SLIBA.C
X$ CC'CFLAGS'   SIOD.C
X$ LINK'LFLAGS' SIOD.OBJ,SLIB.OBJ,SLIBA.OBJ,SYS$INPUT:/OPT
XSYS$LIBRARY:VAXCRTL/SHARE
X$ SIOD == "$" + F$ENV("DEFAULT") + "SIOD"
$ GOSUB UNPACK_FILE

$ FILE_IS = "PRATT.SCM"
$ CHECKSUM_IS = 1010490348
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X;; -*-mode:lisp-*-
X;;
V;; A simple Pratt-Parser for SIOD: 2-FEB-90, George Carrette, GJC@PARADIGM.CO
XM
X;; Siod version 2.4 may be obtained by anonymous FTP to BU.EDU (128.197.2.6)
X;; Get the file users/gjc/siod-v2.4-shar
X;;
X;;                   COPYRIGHT (c) 1990 BY                      `032
X;;     PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.
X;;         See the source file SLIB.C for more information.`032
X;;
X;;
X;; Based on a theory of parsing presented in:                      `032
X;;                                                                     `032
X;;  Pratt, Vaughan R., `096`096Top Down Operator Precedence,''        `032
X;;  ACM Symposium on Principles of Programming Languages        `032
X;;  Boston, MA; October, 1973.                                  `032
X;;                                                                     `032
X
X;; The following terms may be useful in deciphering this code:
X
X;; NUD -- NUll left Denotation (op has nothing to its left (prefix))
X;; LED -- LEft Denotation      (op has something to left (postfix or infix))
X
X;; LBP -- Left Binding Power  (the stickiness to the left)
X;; RBP -- Right Binding Power (the stickiness to the right)
X;;
X;;
X
X;; Example calls
X;;
X;; (pl '(f [ a ] = a + b / c)) => (= (f a) (+ a (/ b c)))
X;;
X;; (pl '(if g [ a COMMA b ] then a > b else k * c + a * b))
X;;  => (if (g a b) (> a b) (+ (* k c) (* a b)))
X;;
X;; Notes:`032
X;;
X;;   This code must be used with siod.scm loaded, in siod version 2.3
X;;
X;;   For practical use you will want to write some code to
X;;   break up input into tokens.
X
X
X(defvar *eof* (list '*eof*))
X
X;;`032
X
X(defun pl (l)
X  ;; parse a list of tokens
X  (setq l (append l '($)))
X  (toplevel-parse (lambda (op arg)
X`009`009    (cond ((eq op 'peek)
X`009`009`009   (if l (car l) *eof*))
X`009`009`009  ((eq op 'get)
X`009`009`009   (if l (pop l) *eof*))
X`009`009`009  ((eq op 'unget)
X`009`009`009   (push arg l))))))
X
X(defun peek-token (stream)
X  (stream 'peek nil))
X
X(defun read-token (stream)
X  (stream 'get nil))
X
X(defun unread-token (x stream)
X  (stream 'unget x))
X
X(defun toplevel-parse (stream)
X  (if (eq *eof* (peek-token stream))
X      (read-token stream)
X    (parse -1 stream)))
X
X(defun value-if-symbol (x)
X  (if (symbol? x)
X      (symbol-value x)
X    x))
X
X(defun nudcall (token stream)
X  (if (symbol? token)
X      (if (get token 'nud)
X`009  ((value-if-symbol (get token 'nud)) token stream)
X`009(if (get token 'led)
X`009    (error 'not-a-prefix-operator token)
X`009  token)
X`009token)
X    token))
X
X(defun ledcall (token left stream)
X  ((value-if-symbol (or (and (symbol? token)
X`009`009`009     (get token 'led))
X`009`009`009(error 'not-an-infix-operator token)))
X   token
X   left
X   stream))
X
X
X(defun lbp (token)
X  (or (and (symbol? token) (get token 'lbp))
X      200))
X
X(defun rbp (token)
X  (or (and (symbol? token) (get token 'rbp))
X      200))
X
X(defvar *parse-debug* nil)
X
X(defun parse (rbp-level stream)
X  (if *parse-debug* (print `096(parse ,rbp-level)))
X  (defun parse-loop (translation)
X    (if (< rbp-level (lbp (peek-token stream)))
X`009(parse-loop (ledcall (read-token stream) translation stream))
X      (begin (if *parse-debug* (print translation))
X`009     translation)))
X  (parse-loop (nudcall (read-token stream) stream)))
X
X(defun header (token)
X  (or (get token 'header) token))
X
X(defun parse-prefix (token stream)
X  (list (header token)
X`009(parse (rbp token) stream)))
X
X(defun parse-infix (token left stream)
X  (list (header token)
X`009left
X`009(parse (rbp token) stream)))
X
X(defun parse-nary (token left stream)
X  (cons (header token) (cons left (prsnary token stream))))
X
X(defun parse-matchfix (token left stream)
X  (cons (header token)
X`009(prsmatch (or (get token 'match) token)
X`009`009  stream)))
X
X(defun prsnary (token stream)
X  (defun loop (l)
X    (if (eq? token (peek-token stream))
X`009(begin (read-token stream)
X`009       (loop (cons (parse (rbp token) stream) l)))
X      (reverse l)))
X  (loop (list (parse (rbp token) stream))))
X
X(defun prsmatch (token stream)
X  (if (eq? token (peek-token stream))
X      (begin (read-token stream)
X`009     nil)
X    (begin (defun loop (l)
X`009     (if (eq? token (peek-token stream))
X`009`009 (begin (read-token stream)
X`009`009`009(reverse l))
X`009       (if (eq? 'COMMA (peek-token stream))
X`009`009   (begin (read-token stream)
X`009`009`009  (loop (cons (parse 10 stream) l)))
X`009`009 (error 'comma-or-match-not-found (read-token stream)))))
X`009   (loop (list (parse 10 stream))))))
X
X(defun delim-err (token stream)
X  (error 'illegal-use-of-delimiter token))
X
X(defun erb-error (token left stream)
X  (error 'too-many token))
X
X(defun premterm-err (token stream)
X  (error 'premature-termination-of-input token))
X
X(defmac (defprops form)
X  (defun loop (l result)
X    (if (null? l)
X`009`096(begin ,@result)
X      (loop (cddr l)
X`009    `096((putprop ',(cadr form) ',(cadr l) ',(car l))
X`009      ,@result))))
X  (loop (cddr form) nil))
X
X
X(defprops $
X  lbp -1
X  nud premterm-err)
X
X(defprops COMMA
X  lbp 10
X  nud delim-err)
X
X
X(defprops ]
X  nud delim-err
X  led erb-err
X  lbp 5)
X
X(defprops [
X  nud open-paren-nud
X  led open-paren-led
X  lbp 200)
X
X(defprops if
X  nud if-nud
X  rbp 45)
X
X(defprops then
X  nud delim-err
X  lbp 5
X  rbp 25)
X
X(defprops else
X  nud delim-err
X  lbp 5
X  rbp 25)
X
X(defprops -
X  nud parse-prefix
X  led parse-nary
X  lbp 100
X  rbp 100)
X
X(defprops +
X  nud parse-prefix
X  led parse-nary
X  lbp 100
X  rbp 100)
X
X(defprops *
X  led parse-nary
X  lbp 120)
X
X(defprops =
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X(defprops **
X  lbp 140
X  rbp 139
X  led parse-infix)
X
X(defprops :=
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X
X(defprops /
X  led parse-infix
X  lbp 120
X  rbp 120)
X
X(defprops >
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X(defprops <
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X(defprops >=
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X(defprops <=
X  led parse-infix
X  lbp 80
X  rbp 80)
X
X(defprops not
X  nud parse-prefix
X  lbp 70
X  rbp 70)
X
X(defprops and
X  led parse-nary
X  lbp 65)
X
X(defprops or
X  led parse-nary
X  lbp 60)
X
X
X(defun open-paren-nud (token stream)
X  (if (eq (peek-token stream) '])
X      nil
X    (let ((right (prsmatch '] stream)))
X      (if (cdr right)
X`009  (cons 'sequence right)
X`009(car right)))))
X
X(defun open-paren-led (token left stream)
X  (cons (header left) (prsmatch '] stream)))
X
X
X(defun if-nud (token stream)
X  (define pred (parse (rbp token) stream))
X  (define then (if (eq? (peek-token stream) 'then)
X`009`009   (parse (rbp (read-token stream)) stream)
X`009`009 (error 'missing-then)))
X  (if (eq? (peek-token stream) 'else)
X      `096(if ,pred ,then ,(parse (rbp (read-token stream)) stream))
X    `096(if ,pred ,then)))
$ GOSUB UNPACK_FILE

$ FILE_IS = "DESCRIP.MMS"
$ CHECKSUM_IS = 1126381153
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X! VMS MAKEFILE (using MMS)
X!
X
XCFLAGS = /DEBUG/LIST/SHOW=(NOSOURCE)/OPTIMIZE=(NOINLINE)/STANDARD=PORTABLE
X
XOBJS = siod.obj,slib.obj,sliba.obj
X
Xsiod.exe depends_on $(OBJS),siod.opt
X dflag = ""
X if f$type(setdebug) .nes. "" then dflag = "/DEBUG"
X link'dflag'/exe=siod.exe $(OBJS),siod.opt/opt
X if f$type(setdebug) .nes. "" then setdebug siod.exe 0
X ! re-execute the next line in your superior process:
X siod == "$" + f$env("DEFAULT") + "SIOD"
X
XDISTRIB depends_on siod.shar,siod.1_of_1
X !(ALL DONE)
X
Xsiod.obj depends_on siod.c,siod.h,
X
Xslib.obj depends_on slib.c,siod.h,siodp.h
Xsliba,obj depends_on sliba.c,siod.h,siodp.h
X
XDISTRIB_FILES = MAKEFILE.,README.,SIOD.1,SIOD.C,SIOD.DOC,SIOD.H,SIOD.SCM,\
X                SLIB.C,SIOD.TIM,MAKEFILE.COM,PRATT.SCM,DESCRIP.MMS,SIOD.OPT,\
X                SHAR.DB,SIODP.H,SLIBA.C,SIODM.C
X
Xsiod.shar depends_on $(DISTRIB_FILES)
X minishar siod.shar shar.db
X
XSIOD.1_OF_1  depends_on $(DISTRIB_FILES)
X DEFINE share_max_part_size 300
X @NTOOLS_DIR:VMS_SHARE "$(DISTRIB_FILES)" SIOD
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIOD.OPT"
$ CHECKSUM_IS = 1511619186
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
XIDENTIFICATION = "SIOD 2.6"
Xsys$library:vaxcrtl/share
$ GOSUB UNPACK_FILE

$ FILE_IS = "SHAR.DB"
$ CHECKSUM_IS = 2132950022
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
Xreadme
X! the source
Xsiod.h
Xsiodp.h
Xsiod.c
Xslib.c
Xsliba.c
Xsiodm.c
X! documentation
Xsiod.doc
Xsiod.tim
X! lisp code
Xpratt.scm
Xsiod.scm
X! unix-specific
Xmakefile
Xsiod.1
X! vms-specific
Xmakefile.com
Xdescrip.mms
Xsiod.opt
X! this file:
Xshar.db
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIODP.H"
$ CHECKSUM_IS = 1028115566
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* Scheme In One Defun, but in C this time.
X
X *                        COPYRIGHT (c) 1988-1992 BY                        *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *        See the source file SLIB.C for more information.                  *
X
XDeclarations which are private to SLIB.C internals.
X
X*/
X
X
Xextern char *tkbuffer;
Xextern LISP heap,heap_end,heap_org;
Xextern LISP truth;
X
Xstruct user_type_hooks
X`123LISP (*gc_relocate)(LISP);
X void (*gc_scan)(LISP);
X LISP (*gc_mark)(LISP);
X void (*gc_free)(LISP);
X void (*prin1)(LISP, FILE *);
X LISP (*leval)(LISP, LISP *, LISP *);
X long (*c_sxhash)(LISP,long);
X LISP (*fast_print)(LISP,LISP);
X LISP (*fast_read)(int,LISP);
X LISP (*equal)(LISP,LISP);`125;
X
Xstruct catch_frame
X`123LISP tag;
X LISP retval;
X jmp_buf cframe;
X struct catch_frame *next;`125;
X
Xstruct gc_protected
X`123LISP *location;
X long length;
X struct gc_protected *next;`125;
X
X#define NEWCELL(_into,_type)          \
X`123if (gc_kind_copying == 1)            \
X   `123if ((_into = heap) >= heap_end)   \
X      gc_fatal_error();               \
X    heap = _into+1;`125                  \
X else                                 \
X   `123if NULLP(freelist)                \
X      gc_for_newcell();               \
X    _into = freelist;                 \
X    freelist = CDR(freelist);         \
X    ++gc_cells_allocated;`125            \
X (*_into).gc_mark = 0;                \
X (*_into).type = _type;`125
X
X#ifdef THINK_C
Xextern int ipoll_counter;
Xvoid full_interrupt_poll(int *counter);
V#define INTERRUPT_CHECK() if (--ipoll_counter < 0) full_interrupt_poll(&ipoll
X_counter)
X#else
X#define INTERRUPT_CHECK()
X#endif
X
Xextern char *stack_limit_ptr;
X
X#define STACK_LIMIT(_ptr,_amt) (((char *)_ptr) - (_amt))
X
X#define STACK_CHECK(_ptr) \
X  if (((char *) (_ptr)) < stack_limit_ptr) err_stack((char *) _ptr);
X
Xvoid err_stack(char *);
X
X#ifdef VMS
X#define SIG_restargs ,...
X#else
X#define SIG_restargs
X#endif
X
Xvoid handle_sigfpe(int sig SIG_restargs);
Xvoid handle_sigint(int sig SIG_restargs);
Xvoid err_ctrl_c(void);
Xdouble myruntime(void);
Xvoid fput_st(FILE *f,char *st);
Xvoid put_st(char *st);
Xvoid grepl_puts(char *st);
Xvoid gc_fatal_error(void);
Xchar *must_malloc(unsigned long size);
XLISP gen_intern(char *name,long copyp);
Xvoid scan_registers(void);
Xvoid init_storage_1(void);
Xstruct user_type_hooks *get_user_type_hooks(long type);
XLISP get_newspace(void);
Xvoid scan_newspace(LISP newspace);
Xvoid free_oldspace(LISP space,LISP end);
Xvoid gc_stop_and_copy(void);
Xvoid gc_for_newcell(void);
Xvoid gc_mark_and_sweep(void);
Xvoid gc_ms_stats_start(void);
Xvoid gc_ms_stats_end(void);
Xvoid gc_mark(LISP ptr);
Xvoid mark_protected_registers(void);
Xvoid mark_locations(LISP *start,LISP *end);
Xvoid mark_locations_array(LISP *x,long n);
Xvoid gc_sweep(void);
XLISP leval_args(LISP l,LISP env);
XLISP extend_env(LISP actuals,LISP formals,LISP env);
XLISP envlookup(LISP var,LISP env);
XLISP setvar(LISP var,LISP val,LISP env);
XLISP leval_setq(LISP args,LISP env);
XLISP syntax_define(LISP args);
XLISP leval_define(LISP args,LISP env);
XLISP leval_if(LISP *pform,LISP *penv);
XLISP leval_lambda(LISP args,LISP env);
XLISP leval_progn(LISP *pform,LISP *penv);
XLISP leval_or(LISP *pform,LISP *penv);
XLISP leval_and(LISP *pform,LISP *penv);
XLISP leval_catch(LISP args,LISP env);
XLISP lthrow(LISP tag,LISP value);
XLISP leval_let(LISP *pform,LISP *penv);
XLISP reverse(LISP l);
XLISP let_macro(LISP form);
XLISP leval_quote(LISP args,LISP env);
XLISP leval_tenv(LISP args,LISP env);
Xint flush_ws(struct gen_readio *f,char *eoferr);
Xint f_getc(FILE *f);
Xvoid f_ungetc(int c, FILE *f);
XLISP readtl(struct gen_readio *f);
XLISP lreadr(struct gen_readio *f);
XLISP lreadparen(struct gen_readio *f);
Xvoid close_open_files(void);
XLISP arglchk(LISP x);
Xvoid init_storage_a1(long type);
Xvoid init_storage_a(void);
XLISP array_gc_relocate(LISP ptr);
Xvoid array_gc_scan(LISP ptr);
XLISP array_gc_mark(LISP ptr);
Xvoid array_gc_free(LISP ptr);
Xvoid array_prin1(LISP ptr,FILE *f);
Xlong array_sxhaxh(LISP,long);
XLISP array_fast_print(LISP,LISP);
XLISP array_fast_read(int,LISP);
XLISP array_equal(LISP,LISP);
Xlong array_sxhash(LISP,long);
X
Xint rfs_getc(unsigned char **p);
Xvoid rfs_ungetc(unsigned char c,unsigned char **p);
Xvoid err1_aset1(LISP i);
Xvoid err2_aset1(LISP v);
XLISP lreadstring(struct gen_readio *f);
X
Xvoid file_gc_free(LISP ptr);
Xvoid file_prin1(LISP ptr,FILE *f);
XLISP fopen_c(char *name,char *how);
XLISP fopen_l(LISP name,LISP how);
XLISP fclose_l(LISP p);
XFILE *get_c_file(LISP p,FILE *deflt);
XLISP lgetc(LISP p);
XLISP lputc(LISP c,LISP p);
XLISP lputs(LISP str,LISP p);
X
XLISP leval_while(LISP args,LISP env);
X
Xvoid init_subrs_a(void);
Xvoid init_subrs_1(void);
X
Xlong href_index(LISP table,LISP key);
X
Xvoid put_long(long,FILE *);
Xlong get_long(FILE *);
X
Xlong fast_print_table(LISP obj,LISP table);
X
XLISP stack_limit(LISP,LISP);
X
X
Xvoid err0(void);
Xvoid pr(LISP);
Xvoid prp(LISP *);
X
$ GOSUB UNPACK_FILE

$ FILE_IS = "SLIBA.C"
$ CHECKSUM_IS = 1296885096
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* `032
X *                   COPYRIGHT (c) 1988-1992 BY                             *
X *        PARADIGM ASSOCIATES INCORPORATED, CAMBRIDGE, MASSACHUSETTS.       *
X *        See the source file SLIB.C for more information.                  *
X
XArray-hacking code moved to another source file.
X
X*/
X
X#include <stdio.h>
X#include <string.h>
X#include <setjmp.h>
X#include <stdlib.h>
X#include <ctype.h>
X
X#include "siod.h"
X#include "siodp.h"
X
XLISP bashnum = NIL;
X
Xvoid init_storage_a1(long type)
X`123long j;
X struct user_type_hooks *p;
X set_gc_hooks(type,
X`009      array_gc_relocate,
X`009      array_gc_mark,
X`009      array_gc_scan,
X`009      array_gc_free,
X`009      &j);
X set_print_hooks(type,array_prin1);
X p = get_user_type_hooks(type);
X p->fast_print = array_fast_print;
X p->fast_read = array_fast_read;
X p->equal = array_equal;
X p->c_sxhash = array_sxhash;`125
X
Xvoid init_storage_a(void)
X`123long j;
X gc_protect(&bashnum);
X bashnum = newcell(tc_flonum);
X init_storage_a1(tc_string);
X init_storage_a1(tc_double_array);
X init_storage_a1(tc_long_array);
X init_storage_a1(tc_lisp_array);`125
X
XLISP array_gc_relocate(LISP ptr)
X`123LISP new;
X if ((new = heap) >= heap_end) gc_fatal_error();
X heap = new+1;
X memcpy(new,ptr,sizeof(struct obj));
X return(new);`125
X
Xvoid array_gc_scan(LISP ptr)
X`123long j;
X if TYPEP(ptr,tc_lisp_array)
X   for(j=0;j < ptr->storage_as.lisp_array.dim; ++j)
X     ptr->storage_as.lisp_array.data[j] =    `032
X       gc_relocate(ptr->storage_as.lisp_array.data[j]);`125
X
XLISP array_gc_mark(LISP ptr)
X`123long j;
X if TYPEP(ptr,tc_lisp_array)
X   for(j=0;j < ptr->storage_as.lisp_array.dim; ++j)
X     gc_mark(ptr->storage_as.lisp_array.data[j]);
X return(NIL);`125
X
Xvoid array_gc_free(LISP ptr)
X`123switch (ptr->type)
X   `123case tc_string:
X      free(ptr->storage_as.string.data);
X      break;
X    case tc_double_array:
X      free(ptr->storage_as.double_array.data);
X      break;
X    case tc_long_array:
X      free(ptr->storage_as.long_array.data);
X      break;
X    case tc_lisp_array:
X      free(ptr->storage_as.lisp_array.data);
X      break;`125`125
X
Xvoid array_prin1(LISP ptr,FILE *f)
X`123int j;
X switch (ptr->type)
X   `123case tc_string:
X      fput_st(f,"\"");
X      fput_st(f,ptr->storage_as.string.data);
X      fput_st(f,"\"");
X      break;
X    case tc_double_array:
X      fput_st(f,"#(");
X      for(j=0; j < ptr->storage_as.double_array.dim; ++j)
X`009`123sprintf(tkbuffer,"%g",ptr->storage_as.double_array.data[j]);
X`009 fput_st(f,tkbuffer);
X`009 if ((j + 1) < ptr->storage_as.double_array.dim)
X`009   fput_st(f," ");`125
X      fput_st(f,")");
X      break;
X    case tc_long_array:
X      fput_st(f,"#(");
X      for(j=0; j < ptr->storage_as.long_array.dim; ++j)
X`009`123sprintf(tkbuffer,"%ld",ptr->storage_as.long_array.data[j]);
X`009 fput_st(f,tkbuffer);
X`009 if ((j + 1) < ptr->storage_as.long_array.dim)
X`009   fput_st(f," ");`125
X      fput_st(f,")");
X      break;
X    case tc_lisp_array:
X      fput_st(f,"#(");
X      for(j=0; j < ptr->storage_as.lisp_array.dim; ++j)
X`009`123lprin1f(ptr->storage_as.lisp_array.data[j],f);
X`009 if ((j + 1) < ptr->storage_as.lisp_array.dim)
X`009   fput_st(f," ");`125
X      fput_st(f,")");
X      break;`125`125
X
XLISP strcons(long length,char *data)
X`123long flag;
X LISP s;
X flag = no_interrupt(1);
X s = cons(NIL,NIL);
X s->type = tc_string;
X s->storage_as.string.data = must_malloc(length+1);
X s->storage_as.string.dim = length;
X if (data)
X   strcpy(s->storage_as.string.data,data);
X no_interrupt(flag);
X return(s);`125
X
Xint rfs_getc(unsigned char **p)
X`123int i;
X i = **p;
X if (!i) return(EOF);
X *p = *p + 1;
X return(i);`125
X
Xvoid rfs_ungetc(unsigned char c,unsigned char **p)
X`123*p = *p - 1;`125
X
XLISP read_from_string(LISP x)
X`123char *p;
X struct gen_readio s;
X p = get_c_string(x);
X s.getc_fcn = (int (*)(char *))rfs_getc;
X s.ungetc_fcn = (void (*)(int, char *))rfs_ungetc;
X s.cb_argument = (char *) &p;
X return(readtl(&s));`125
X
XLISP aref1(LISP a,LISP i)
X`123long k;
X if NFLONUMP(i) err("bad index to aref",i);
X k = FLONM(i);
X if (k < 0) err("negative index to aref",i);
X switch (a->type)
X   `123case tc_string:
X      if (k >= (a->storage_as.string.dim - 1)) err("index too large",i);
X      return(flocons((double) a->storage_as.string.data[k]));
X    case tc_double_array:
X      if (k >= a->storage_as.double_array.dim) err("index too large",i);
X      return(flocons(a->storage_as.double_array.data[k]));
X    case tc_long_array:
X      if (k >= a->storage_as.long_array.dim) err("index too large",i);
X      return(flocons(a->storage_as.long_array.data[k]));
X    case tc_lisp_array:
X      if (k >= a->storage_as.lisp_array.dim) err("index too large",i);
X      return(a->storage_as.lisp_array.data[k]);
X    default:
X      err("invalid argument to aref",a);`125`125
X
Xvoid err1_aset1(LISP i)
X`123err("index to aset too large",i);`125
X
Xvoid err2_aset1(LISP v)
X`123err("bad value to store in array",v);`125
X
XLISP aset1(LISP a,LISP i,LISP v)
X`123long k;
X if NFLONUMP(i) err("bad index to aset",i);
X k = FLONM(i);
X if (k < 0) err("negative index to aset",i);
X switch (a->type)
X   `123case tc_string:
X      if NFLONUMP(v) err2_aset1(v);
X      if (k >= (a->storage_as.string.dim - 1)) err1_aset1(i);
X      a->storage_as.string.data[k] = (char) FLONM(v);
X      return(v);
X    case tc_double_array:
X      if NFLONUMP(v) err2_aset1(v);
X      if (k >= a->storage_as.double_array.dim) err1_aset1(i);
X      a->storage_as.double_array.data[k] = FLONM(v);
X      return(v);
X    case tc_long_array:
X      if NFLONUMP(v) err2_aset1(v);
X      if (k >= a->storage_as.long_array.dim) err1_aset1(i);
X      a->storage_as.long_array.data[k] = (long) FLONM(v);
X      return(v);
X    case tc_lisp_array:
X      if (k >= a->storage_as.lisp_array.dim) err1_aset1(i);
X      a->storage_as.lisp_array.data[k] = v;
X      return(v);
X    default:
X      err("invalid argument to aset",a);`125`125
X
XLISP cons_array(LISP dim,LISP kind)
X`123LISP a;
X long flag,n,j;
X if (NFLONUMP(dim) `124`124 (FLONM(dim) < 0))
X   err("bad dimension to cons-array",dim);
X else
X   n = FLONM(dim);
X flag = no_interrupt(1);
X a = cons(NIL,NIL);
X if EQ(cintern("double"),kind)
X   `123a->type = tc_double_array;
X    a->storage_as.double_array.dim = n;
X    a->storage_as.double_array.data = (double *) must_malloc(n *
X`009`009`009`009`009`009`009     sizeof(double));
X    for(j=0;j<n;++j) a->storage_as.double_array.data[j] = 0.0;`125
X else if EQ(cintern("long"),kind)
X   `123a->type = tc_long_array;
X    a->storage_as.long_array.dim = n;
X    a->storage_as.long_array.data = (long *) must_malloc(n * sizeof(long));
X    for(j=0;j<n;++j) a->storage_as.long_array.data[j] = 0;`125
X else if EQ(cintern("string"),kind)
X   `123a->type = tc_string;
X    a->storage_as.double_array.dim = n+1;
X    a->storage_as.string.data = (char *) must_malloc(n+1);
X    a->storage_as.string.data[n] = 0;
X    for(j=0;j<n;++j) a->storage_as.string.data[j] = ' ';`125
X else if (EQ(cintern("lisp"),kind) `124`124 NULLP(kind))
X   `123a->type = tc_lisp_array;
X    a->storage_as.lisp_array.dim = n;
X    a->storage_as.lisp_array.data = (LISP *) must_malloc(n * sizeof(LISP));
X    for(j=0;j<n;++j) a->storage_as.lisp_array.data[j] = NIL;`125
X else
X   err("bad type of array",kind);
X no_interrupt(flag);
X return(a);`125
X
XLISP string_append(LISP args)
X`123long size;
X LISP l,s;
X char *data;
X size = 0;
X for(l=args;NNULLP(l);l=cdr(l))
X   size += strlen(get_c_string(car(l)));
X s = strcons(size,NULL);
X data = s->storage_as.string.data;
X data[0] = 0;
X for(l=args;NNULLP(l);l=cdr(l))
X   strcat(data,get_c_string(car(l)));
X return(s);`125
X
XLISP lreadstring(struct gen_readio *f)
X`123int j,c,n;
X char *p;
X j = 0;
X p = tkbuffer;
X while(((c = GETC_FCN(f)) != '"') && (c != EOF))
X   `123if (c == '\\')
X      `123c = GETC_FCN(f);
X       if (c == EOF) err("eof after \\",NIL);
X       switch(c)
X`009 `123case 'n':
X`009    c = '\n';
X`009    break;
X`009  case 't':
X`009    c = '\t';
X`009    break;
X`009  case 'r':
X`009    c = '\r';
X`009    break;
X`009  case 'd':
X`009    c = 0x04;
X`009    break;
X`009  case 'N':
X`009    c = 0;
X`009    break;
X`009  case 's':
X`009    c = ' ';
X`009    break;
X`009  case '0':
X`009    n = 0;
X`009    while(1)
X`009      `123c = GETC_FCN(f);
X`009       if (c == EOF) err("eof after \\0",NIL);
X`009       if (isdigit(c))
X`009`009 n = n * 8 + c - '0';
X`009       else
X`009`009 `123UNGETC_FCN(c,f);
X`009`009  break;`125`125
X`009    c = n;`125`125
X    if ((j + 1) >= TKBUFFERN) err("read string overflow",NIL);
X    ++j;
X    *p++ = c;`125
X *p = 0;
X return(strcons(j,tkbuffer));`125
X
X#define HASH_COMBINE(_h1,_h2,_mod) (((_h1 * 17) `094 _h2) % _mod)
X
Xlong c_sxhash(LISP obj,long n)
X`123long hash,c;
X unsigned char *s;
X LISP tmp;
X struct user_type_hooks *p;
X STACK_CHECK(&obj);
X INTERRUPT_CHECK();
X switch TYPE(obj)
X   `123case tc_nil:
X      return(0);
X    case tc_cons:
X      hash = c_sxhash(car(obj),n);
X      for(tmp=cdr(obj);CONSP(tmp);tmp=cdr(tmp))
X`009hash = HASH_COMBINE(hash,c_sxhash(car(tmp),n),n);
X      hash = HASH_COMBINE(hash,c_sxhash(cdr(tmp),n),n);
X      return(hash);
X    case tc_symbol:
X      for(hash=0,s=(unsigned char *)PNAME(obj);*s;++s)
X`009hash = HASH_COMBINE(hash,*s,n);
X      return(hash);
X    case tc_subr_0:
X    case tc_subr_1:
X    case tc_subr_2:
X    case tc_subr_3:
X    case tc_lsubr:
X    case tc_fsubr:
X    case tc_msubr:
X      for(hash=0,s=(unsigned char *) obj->storage_as.subr.name;*s;++s)
X`009hash = HASH_COMBINE(hash,*s,n);
X      return(hash);
X    case tc_flonum:
X      return(((unsigned long)FLONM(obj)) % n);
X    default:
X      p = get_user_type_hooks(TYPE(obj));
X      if (p->c_sxhash)
X`009return((*p->c_sxhash)(obj,n));
X      else
X`009return(0);`125`125
X
XLISP sxhash(LISP obj,LISP n)
X`123return(flocons(c_sxhash(obj,FLONUMP(n) ? FLONM(n) : 10000)));`125
X
XLISP equal(LISP a,LISP b)
X`123struct user_type_hooks *p;
X long atype;
X STACK_CHECK(&a);
X loop:
X INTERRUPT_CHECK();
X if EQ(a,b) return(truth);
X atype = TYPE(a);
X if (atype != TYPE(b)) return(NIL);
X switch(atype)
X   `123case tc_cons:
X      if NULLP(equal(car(a),car(b))) return(NIL);
X      a = cdr(a);
X      b = cdr(b);
X      goto loop;
X    case tc_flonum:
X      return((FLONM(a) == FLONM(b)) ? truth : NIL);
X    case tc_symbol:
X      return(NIL);
X    default:
X      p = get_user_type_hooks(atype);
X      if (p->equal)
X`009return((*p->equal)(a,b));
X      else
X`009return(NIL);`125`125
X
XLISP array_equal(LISP a,LISP b)
X`123long j,len;
X switch(TYPE(a))
X   `123case tc_string:
X      len = a->storage_as.string.dim;
X      if (len != b->storage_as.string.dim) return(NIL);
V      if (memcmp(a->storage_as.string.data,b->storage_as.string.data,len) ==
X 0)
X`009return(truth);
X      else
X`009return(NIL);
X    case tc_long_array:
X      len = a->storage_as.long_array.dim;
X      if (len != b->storage_as.long_array.dim) return(NIL);
X      if (memcmp(a->storage_as.long_array.data,
X`009`009 b->storage_as.long_array.data,
X`009`009 len * sizeof(long)) == 0)
X`009return(truth);
X      else
X`009return(NIL);
X    case tc_double_array:
X      len = a->storage_as.double_array.dim;
X      if (len != b->storage_as.double_array.dim) return(NIL);
X      for(j=0;j<len;++j)
X`009if (a->storage_as.double_array.data[j] !=
X`009    b->storage_as.double_array.data[j])
X`009  return(NIL);
X      return(truth);
X    case tc_lisp_array:
X      len = a->storage_as.lisp_array.dim;
X      if (len != b->storage_as.lisp_array.dim) return(NIL);
X      for(j=0;j<len;++j)
X`009if NULLP(equal(a->storage_as.lisp_array.data[j],
X`009`009       b->storage_as.lisp_array.data[j]))
X`009  return(NIL);
X      return(truth);`125`125
X
Xlong array_sxhash(LISP a,long n)
X`123long j,len,hash;
X unsigned char *char_data;
X unsigned long *long_data;
X double *double_data;
X switch(TYPE(a))
X   `123case tc_string:
X      len = a->storage_as.string.dim;
X      for(j=0,hash=0,char_data=(unsigned char *)a->storage_as.string.data;
X`009  j < len;
X`009  ++j,++char_data)
X`009hash = HASH_COMBINE(hash,*char_data,n);
X      return(hash);
X    case tc_long_array:
X      len = a->storage_as.long_array.dim;
V      for(j=0,hash=0,long_data=(unsigned long *)a->storage_as.long_array.data
X;
X`009  j < len;
X`009  ++j,++long_data)
X`009hash = HASH_COMBINE(hash,*long_data % n,n);
X      return(hash);
X    case tc_double_array:
X      len = a->storage_as.double_array.dim;
X      for(j=0,hash=0,double_data=a->storage_as.double_array.data;
X`009  j < len;
X`009  ++j,++double_data)
X`009hash = HASH_COMBINE(hash,(unsigned long)*double_data % n,n);
X      return(hash);
X    case tc_lisp_array:
X      len = a->storage_as.lisp_array.dim;
X      for(j=0,hash=0; j < len; ++j)
X`009hash = HASH_COMBINE(hash,
X`009`009`009    c_sxhash(a->storage_as.lisp_array.data[j],n),
X`009`009`009    n);
X      return(hash);`125`125
X
Xlong href_index(LISP table,LISP key)
X`123long index;
X if NTYPEP(table,tc_lisp_array) err("not a hash table",table);
X index = c_sxhash(key,table->storage_as.lisp_array.dim);
X if ((index < 0) `124`124 (index >= table->storage_as.lisp_array.dim))
X   err("sxhash inconsistency",table);
X else
X   return(index);`125
X`032
XLISP href(LISP table,LISP key)
X`123return(cdr(assoc(key,
X`009`009  table->storage_as.lisp_array.data[href_index(table,key)])));`125
X
XLISP hset(LISP table,LISP key,LISP value)
X`123long index;
X LISP cell,l;
X index = href_index(table,key);
X l = table->storage_as.lisp_array.data[index];
X if NNULLP(cell = assoc(key,l))
X   return(setcdr(cell,value));
X cell = cons(key,value);
X table->storage_as.lisp_array.data[index] = cons(cell,l);
X return(value);`125
X
XLISP assoc(LISP x,LISP alist)
X`123LISP l,tmp;
X for(l=alist;CONSP(l);l=CDR(l))
X   `123tmp = CAR(l);
X    if (CONSP(tmp) && equal(CAR(tmp),x)) return(tmp);`125
X if EQ(l,NIL) return(NIL);
X err("improper list to assoc",alist);`125
X
Xvoid put_long(long i,FILE *f)
X`123fwrite(&i,sizeof(long),1,f);`125
X
Xlong get_long(FILE *f)
X`123long i;
X fread(&i,sizeof(long),1,f);
X return(i);`125
X
Xlong fast_print_table(LISP obj,LISP table)
X`123FILE *f;
X LISP ht,index;
X f = get_c_file(car(table),(FILE *) NULL);
X if NULLP(ht = car(cdr(table)))
X   return(1);
X index = href(ht,obj);
X if NNULLP(index)
X   `123putc(FO_fetch,f);
X    put_long(get_c_long(index),f);
X    return(0);`125
X if NULLP(index = car(cdr(cdr(table))))
X   return(1);
X hset(ht,obj,index);
X FLONM(bashnum) = 1.0;
X setcar(cdr(cdr(table)),plus(index,bashnum));
X putc(FO_store,f);
X put_long(get_c_long(index),f);
X return(1);`125
X
XLISP fast_print(LISP obj,LISP table)
X`123FILE *f;
X long len;
X LISP tmp;
X struct user_type_hooks *p;
X STACK_CHECK(&obj);
X f = get_c_file(car(table),(FILE *) NULL);
X switch(TYPE(obj))
X   `123case tc_nil:
X      putc(tc_nil,f);
X      return(NIL);
X    case tc_cons:
V      for(len=0,tmp=obj;CONSP(tmp);tmp=CDR(tmp)) `123INTERRUPT_CHECK();++len;
X`125
X      if (len == 1)
X`009`123putc(tc_cons,f);
X`009 fast_print(car(obj),table);
X`009 fast_print(cdr(obj),table);`125
X      else if NULLP(tmp)
X`009`123putc(FO_list,f);
X`009 put_long(len,f);
X`009 for(tmp=obj;CONSP(tmp);tmp=CDR(tmp))
X`009   fast_print(CAR(tmp),table);`125
X      else
X`009`123putc(FO_listd,f);
X`009 put_long(len,f);
X`009 for(tmp=obj;CONSP(tmp);tmp=CDR(tmp))
X`009   fast_print(CAR(tmp),table);
X`009 fast_print(tmp,table);`125
X      return(NIL);
X    case tc_flonum:
X      putc(tc_flonum,f);
X      fwrite(&obj->storage_as.flonum.data,
X`009     sizeof(obj->storage_as.flonum.data),
X`009     1,
X`009     f);
X      return(NIL);
X    case tc_symbol:
X      if (fast_print_table(obj,table))
X`009`123putc(tc_symbol,f);
X`009 len = strlen(PNAME(obj));
X`009 if (len >= TKBUFFERN)
X`009   err("symbol name too long",obj);
X`009 put_long(len,f);
X`009 fwrite(PNAME(obj),len,1,f);
X`009 return(truth);`125
X      else
X`009return(NIL);
X    default:
X      p = get_user_type_hooks(TYPE(obj));
X      if (p->fast_print)
X`009return((*p->fast_print)(obj,table));
X      else
X`009err("cannot fast-print",obj);`125`125
X
XLISP fast_read(LISP table)
X`123FILE *f;
X LISP tmp,l;
X struct user_type_hooks *p;
X int c;
X long len;
X f = get_c_file(car(table),(FILE *) NULL);
X c = getc(f);
X if (c == EOF) return(table);
X switch(c)
X   `123case FO_fetch:
X      len = get_long(f);
X      FLONM(bashnum) = len;
X      return(href(car(cdr(table)),bashnum));
X    case FO_store:
X      len = get_long(f);
X      tmp = fast_read(table);
X      hset(car(cdr(table)),flocons(len),tmp);
X      return(tmp);
X    case tc_nil:
X      return(NIL);
X    case tc_cons:
X      tmp = fast_read(table);
X      return(cons(tmp,fast_read(table)));
X    case FO_list:
X    case FO_listd:
X      len = get_long(f);
X      FLONM(bashnum) = len;
X      l = make_list(bashnum,NIL);
X      tmp = l;
X      while(len > 1)
X`009`123CAR(tmp) = fast_read(table);
X`009 tmp = CDR(tmp);
X`009 --len;`125
X      CAR(tmp) = fast_read(table);
X      if (c == FO_listd)
X`009CDR(tmp) = fast_read(table);
X      return(l);
X    case tc_flonum:
X      tmp = newcell(tc_flonum);
X      fread(&tmp->storage_as.flonum.data,
X`009    sizeof(tmp->storage_as.flonum.data),
X`009    1,
X`009    f);
X      return(tmp);
X    case tc_symbol:
X      len = get_long(f);
X      if (len >= TKBUFFERN)
X`009err("symbol name too long",NIL);
X      fread(tkbuffer,len,1,f);
X      tkbuffer[len] = 0;
X      return(rintern(tkbuffer));
X    default:
X      p = get_user_type_hooks(c);
X      if (p->fast_read)
X`009return(*p->fast_read)(c,table);
X      else
X`009err("unknown fast-read opcode",flocons(c));`125`125
X
XLISP array_fast_print(LISP ptr,LISP table)
X`123int j,len;
X FILE *f;
X f = get_c_file(car(table),(FILE *) NULL);
X switch (ptr->type)
X   `123case tc_string:
X      putc(tc_string,f);
X      len = ptr->storage_as.string.dim;
X      put_long(len,f);
X      fwrite(ptr->storage_as.string.data,len,1,f);
X      return(NIL);
X    case tc_double_array:
X      putc(tc_double_array,f);
X      len = ptr->storage_as.double_array.dim * sizeof(double);
X      put_long(len,f);
X      fwrite(ptr->storage_as.double_array.data,len,1,f);
X      return(NIL);
X    case tc_long_array:
X      putc(tc_long_array,f);
X      len = ptr->storage_as.long_array.dim * sizeof(long);
X      put_long(len,f);
X      fwrite(ptr->storage_as.long_array.data,len,1,f);
X      return(NIL);
X    case tc_lisp_array:
X      putc(tc_lisp_array,f);
X      len = ptr->storage_as.lisp_array.dim;
X      put_long(len,f);
X      for(j=0; j < len; ++j)
X`009fast_print(ptr->storage_as.lisp_array.data[j],table);
X      return(NIL);`125`125
X
XLISP array_fast_read(int code,LISP table)
X`123long j,len,iflag;
X FILE *f;
X LISP ptr;
X f = get_c_file(car(table),(FILE *) NULL);
X switch (code)
X   `123case tc_string:
X      len = get_long(f);
X      ptr = strcons(len,NULL);
X      fread(ptr->storage_as.string.data,len,1,f);
X      ptr->storage_as.string.data[len] = 0;
X      return(ptr);
X    case tc_double_array:
X      len = get_long(f);
X      iflag = no_interrupt(1);
X      ptr = newcell(tc_double_array);
X      ptr->storage_as.double_array.dim = len;
X      ptr->storage_as.double_array.data =
X`009(double *) must_malloc(len * sizeof(double));
X      fread(ptr->storage_as.double_array.data,sizeof(double),len,f);
X      no_interrupt(iflag);
X      return(ptr);
X    case tc_long_array:
X      len = get_long(f);
X      iflag = no_interrupt(1);
X      ptr = newcell(tc_long_array);
X      ptr->storage_as.long_array.dim = len;
X      ptr->storage_as.long_array.data =
X`009(long *) must_malloc(len * sizeof(long));
X      fread(ptr->storage_as.long_array.data,sizeof(long),len,f);
X      no_interrupt(iflag);
X      return(ptr);
X    case tc_lisp_array:
X      len = get_long(f);
X      FLONM(bashnum) = len;
X      ptr = cons_array(bashnum,NIL);
X      for(j=0; j < len; ++j)
X`009ptr->storage_as.lisp_array.data[j] = fast_read(table);
X      return(ptr);`125`125
X
Xlong get_c_long(LISP x)
X`123if NFLONUMP(x) err("not a number",x);
X return(FLONM(x));`125
X
XLISP make_list(LISP x,LISP v)
X`123long n;
X LISP l;
X n = get_c_long(x);
X l = NIL;
X while(n > 0)
X   `123l = cons(v,l); --n;`125
X return(l);`125
X
Xvoid init_subrs_a(void)
X`123init_subr("aref",tc_subr_2,aref1);
X init_subr("aset",tc_subr_3,aset1);
X init_subr("string-append",tc_lsubr,string_append);
X init_subr("read-from-string",tc_subr_1,read_from_string);
X init_subr("cons-array",tc_subr_2,cons_array);
X init_subr("sxhash",tc_subr_2,sxhash);
X init_subr("equal?",tc_subr_2,equal);
X init_subr("href",tc_subr_2,href);
X init_subr("hset",tc_subr_3,hset);
X init_subr("assoc",tc_subr_2,assoc);
X init_subr("fast-read",tc_subr_1,fast_read);
X init_subr("fast-print",tc_subr_2,fast_print);
X init_subr("make-list",tc_subr_2,make_list);`125
$ GOSUB UNPACK_FILE

$ FILE_IS = "SIODM.C"
$ CHECKSUM_IS = 604228036
$ COPY SYS$INPUT VMS_SHARE_DUMMY.DUMMY
X/* Code specific to Lightspeed C on MacIntosh.
X   This detects that the character APPLE-DOT is depressed,
X   and then expects that sending a newline to the console
X   will invoke the proper signal handling code.`032
X
X   See the file "THINK C 5.0 FOLDER/C LIBRARIES/SOURCES/CONSOLE.C"
X
X   It would be a good thing to have some code in here that would call
X   the proper inside-mac OS routines to determine allowable machine
X   stack size, because of lack of protection against stack
X   overflow bashing another program.
X
X */
X `032
X
X#include <stdio.h>
X#include <console.h>
X
X#include <MacHeaders>
X
Xstatic int interrupt_key_down(void);
Xvoid full_interrupt_poll(int *counter);
X
Xvoid full_interrupt_poll(int *counter)
X`123SystemTask();
X if (interrupt_key_down())
X     putc('\n',stdout);
X  /* 200 seems to be a good compromise here between
X     interrupt latency and cpu-bound performance */  `032
X *counter = 200;`125
X
Xstatic int interrupt_key_down(void)
X`123EvQElPtr l;
X for(l = (EvQElPtr) EventQueue.qHead; l; l = (EvQElPtr) l->qLink)
X   if ((l->evtQWhat == keyDown) &&
X       ((char) l->evtQMessage == '.') &&
X       (l->evtQModifiers & cmdKey))
X     return(1);
X return(0);`125
$ GOSUB UNPACK_FILE
$ EXIT

