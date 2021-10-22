$! ------------------ CUT HERE -----------------------
$ v='f$verify(f$trnlnm("SHARE_VERIFY"))'
$!
$! This archive created by VMS_SHARE Version 7.2-007  22-FEB-1990
$!   On  5-APR-1993 16:14:31.58   By user TKB 
$!
$! This VMS_SHARE Written by:
$!    Andy Harper, Kings College London UK
$!
$! Acknowledgements to:
$!    James Gray       - Original VMS_SHARE
$!    Michael Bednarek - Original Concept and implementation
$!
$! TO UNPACK THIS SHARE FILE, CONCATENATE ALL PARTS IN ORDER
$! AND EXECUTE AS A COMMAND PROCEDURE  (  @name  )
$!
$! THE FOLLOWING FILE(S) WILL BE CREATED AFTER UNPACKING:
$!       1. DEF-MAC.SCM;2
$!       2. DEF-REC.SCM;2
$!       3. GENSCMINT.SCM;21
$!       4. GENSMG.SCM;5
$!       5. READSTRING.SCM;13
$!       6. SCMINT.C;13
$!       7. SCMINT.H;5
$!       8. SDLSCM.C;32
$!       9. SMG$ROUTINES.SI;4
$!      10. SMG.C;2
$!      11. SMG.DOC;16
$!      12. SMG.MAKEFILE;8
$!      13. SMG.MANIFEST;17
$!      14. SMG.README;6
$!      15. SMGDEF.SCM;2
$!      16. SMGFUNS.DOC;4
$!      17. SYSDEP.C;3
$!      18. TRYSMG.SCM;10
$!      19. TRYSMG2.SCM;6
$!      20. VMSBUILD.COM-SMG;3
$!      21. VMSGCC.COM-SMG;5
$!
$set="set"
$set symbol/scope=(nolocal,noglobal)
$f=f$parse("SHARE_TEMP","SYS$SCRATCH:.TMP_"+f$getjpi("","PID"))
$e="write sys$error  ""%UNPACK"", "
$w="write sys$output ""%UNPACK"", "
$ if f$trnlnm("SHARE_LOG") then $ w = "!"
$ ve=f$getsyi("version")
$ if ve-f$extract(0,1,ve) .ges. "4.4" then $ goto START
$ e "-E-OLDVER, Must run at least VMS 4.4"
$ v=f$verify(v)
$ exit 44
$UNPACK: SUBROUTINE ! P1=filename, P2=checksum
$ if f$search(P1) .eqs. "" then $ goto file_absent
$ e "-W-EXISTS, File ''P1' exists. Skipped."
$ delete 'f'*
$ exit
$file_absent:
$ if f$parse(P1) .nes. "" then $ goto dirok
$ dn=f$parse(P1,,,"DIRECTORY")
$ w "-I-CREDIR, Creating directory ''dn'."
$ create/dir 'dn'
$ if $status then $ goto dirok
$ e "-E-CREDIRFAIL, Unable to create ''dn'. File skipped."
$ delete 'f'*
$ exit
$dirok:
$ w "-I-PROCESS, Processing file ''P1'."
$ if .not. f$verify() then $ define/user sys$output nl:
$ EDIT/TPU/NOSEC/NODIS/COM=SYS$INPUT 'f'/OUT='P1'
PROCEDURE Unpacker ON_ERROR ENDON_ERROR;SET(FACILITY_NAME,"UNPACK");SET(
SUCCESS,OFF);SET(INFORMATIONAL,OFF);f:=GET_INFO(COMMAND_LINE,"file_name");b:=
CREATE_BUFFER(f,f);p:=SPAN(" ")@r&LINE_END;POSITION(BEGINNING_OF(b));
LOOP EXITIF SEARCH(p,FORWARD)=0;POSITION(r);ERASE(r);ENDLOOP;POSITION(
BEGINNING_OF(b));g:=0;LOOP EXITIF MARK(NONE)=END_OF(b);x:=ERASE_CHARACTER(1);
IF g=0 THEN IF x="X" THEN MOVE_VERTICAL(1);ENDIF;IF x="V" THEN APPEND_LINE;
MOVE_HORIZONTAL(-CURRENT_OFFSET);MOVE_VERTICAL(1);ENDIF;IF x="+" THEN g:=1;
ERASE_LINE;ENDIF;ELSE IF x="-" THEN IF INDEX(CURRENT_LINE,"+-+-+-+-+-+-+-+")=
1 THEN g:=0;ENDIF;ENDIF;ERASE_LINE;ENDIF;ENDLOOP;t:="0123456789ABCDEF";
POSITION(BEGINNING_OF(b));LOOP r:=SEARCH("`",FORWARD);EXITIF r=0;POSITION(r);
ERASE(r);x1:=INDEX(t,ERASE_CHARACTER(1))-1;x2:=INDEX(t,ERASE_CHARACTER(1))-1;
COPY_TEXT(ASCII(16*x1+x2));ENDLOOP;WRITE_FILE(b,GET_INFO(COMMAND_LINE,
"output_file"));ENDPROCEDURE;Unpacker;QUIT;
$ delete/nolog 'f'*
$ CHECKSUM 'P1'
$ IF CHECKSUM$CHECKSUM .eqs. P2 THEN $ EXIT
$ e "-E-CHKSMFAIL, Checksum of ''P1' failed."
$ ENDSUBROUTINE
$START:
$ create 'f'
X;;; def-mac.scm -- Simple-minded macros for SCM4a14 or greater.
X;;;
X;;; (define-macro (name args)
X;;;   ;;; expr returning list to be evaluated in place of (name ...)
X;;;  )
X;;;
X;;; An Example:
X;;; (define-macro inc
X;;;   (lambda (val)
X;;;     `60(set! ,val (+ ,val 1))))
X
X(define define-macro
X  (procedure->memoizing-macro
X   (lambda (exp env)
X     (if (symbol? (cadr exp))
X`09 `60(define ,(cadr exp) (procedure->memoizing-macro
X`09`09`09       (lambda (exp env)
X`09`09`09`09 (apply ,(caddr exp) (cdr exp)))))
X`09 `60(define ,(caadr exp) (procedure->memoizing-macro
X`09`09`09`09(lambda (exp env)
X`09`09`09`09  (apply (lambda ,(cdadr exp)
X`09`09`09`09`09   ,(caddr exp))
X`09`09`09`09`09 (cdr exp)))))))))
$ CALL UNPACK DEF-MAC.SCM;2 1835870114
$ create 'f'
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;;
V                                                                         ;;;
X;;;  define-record and variant-case macros for SCM4a14
V                      ;;;
X;;;
V                                                                         ;;;
X;;;  Hacked from Brent Benson's macros for MIT Scheme, hacked from
V          ;;;
X;;;  Jeff Alexander's and ShinnDer Li's macro's for PC Scheme
V               ;;;
X;;;
V                                                                         ;;;
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X
X(define gensym
X  (let ((n 0))
X    (lambda ()
X      (set! n (add1 n))
X      (string->symbol (string-append ".g." (number->string n) ".")))))
X
X(define add1 1+)
X
X(define error/define-record-or-variant-case
X  (lambda args
X    (for-each (lambda (x) (display x) (display " ")) args)
X    (newline)
X    (error "Error from define-record or variant-case.")))
X
X(define every?     ; In MacScheme, this definition can be deleted.
X  (lambda (pred ls)
X    (if (null? ls)
X        #t
X        (and (pred (car ls)) (every? pred (cdr ls))))))
X
X(define all-true? every?)`20
X(define null-ended-list? list?)
X
X(define-macro (define-record record-name record-fields)
X    (if (and (symbol? record-name)
X             (null-ended-list? record-fields)
X             (all-true? symbol? record-fields))
X        (let* ((vec-sym (gensym))
X               (name (symbol->string record-name))
X               (name? (string->symbol (string-append name "?"))))
X          (letrec
X            ((loop
X               (lambda (fields i)
X                 (cond ((null? fields) '())
X                       ((member (car fields) (cdr fields))
X                        (error/define-record-or-variant-case
X                          "define-record syntax error:"
X                          (string-append name ",")
X                          "duplicate field:"
X                          (car fields)))`20
X                       (#t
X                         (let* ((accessor
X                                 (string-append
X`09`09`09`09  name
X`09`09`09`09  "->"
X`09`09`09`09  (symbol->string (car fields))))
X`09`09`09`09(settor`20
X`09`09`09`09 (string-append accessor "!")))
X                           (cons
X`09`09`09    `60(define ,(string->symbol accessor)
X`09`09`09       (lambda (obj)
X`09`09`09`09 (if (,name? obj)
X`09`09`09`09     (vector-ref obj ,i)
X`09`09`09`09     (error/define-record-or-variant-case
X`09`09`09`09      ,accessor ": bad record" obj))))
X`09`09`09    (cons
X`09`09`09     `60(define ,(string->symbol settor)
X`09`09`09`09(lambda (obj val)
X`09`09`09`09  (if (,name? obj)
X`09`09`09`09      (vector-set! obj ,i val)
X`09`09`09`09      (error/define-record-or-variant-case
X`09`09`09`09       ,settor ": bad record" obj))))
X`09`09`09     (loop (cdr fields) (add1 i))))))))))
X            `60(begin
X               ,@(loop record-fields 1)
X               (define ,name?
X                 (lambda (obj)
X                   (and (vector? obj)
X                        (= (vector-length obj) ,(+ 1 (length record-fields))
V)
X                        (eq? (vector-ref obj 0) ',record-name))))
X               (define ,(string->symbol
X                          (string-append (symbol->string 'make-) name))
X                 (let ((,vec-sym vector))
X                   (lambda ,record-fields
X                     (,vec-sym ',record-name ,@record-fields)))))))
X        (error/define-record-or-variant-case
X          "define-record syntax error:" record-name)))
X
X(define-macro (variant-case record-var . clauses)
X    (let ((var (gensym)))
X      (letrec
X        ((loop
X          (lambda (clause)
X            (cond
X             ((null? clause)
X              `60((#t (error/define-record-or-variant-case
X                      "no clause matches:" ,var))))
X             ((eq? (caar clause) 'else)
X              (if (not (null? (cdr clause)))
X                  (error/define-record-or-variant-case
X                    "variant-case syntax error: clauses after an else."
X                    (cdr clause))
X                  `60((#t ,@(cdar clause)))))
X             ((assoc (caar clause) (cdr clause))
X              (error/define-record-or-variant-case
X                "variant-case syntax error: duplicate clause:"
X                (caar clause)))
X             (else
X              (let ((name (symbol->string (caar clause))))
X                (cons
X                 `60((,(string->symbol (string-append name "?")) ,var)
X                   (let ,(let-vars name (cadar clause))
X                     ,@(cddar clause)))
X                 (loop (cdr clause))))))))
X         (let-vars
X           (lambda (name fields)
X             (cond
X              ((null? fields) '())
X              ((member (car fields) (cdr fields))
X               (error/define-record-or-variant-case
X                 "variant-case syntax error: duplicate field. record:"
X                 (string-append name "," " field:") (car fields)))
X              (#t
X               (cons
X                `60(,(car fields)
X                  (,(string->symbol
X                     (string-append
X                      name "->" (symbol->string (car fields))))
X                   ,var))
X                (let-vars name (cdr fields))))))))
X        (if (and (all-true?
X                  (lambda (clause)
X                    (and (null-ended-list? clause)
X                         (not (null? clause))
X                         (symbol? (car clause))
X                         (if (eq? (car clause) 'else)
X                             (not (null? (cdr clause)))
X                             (and (> (length clause) 2)
X                                  (null-ended-list? (cadr clause))
X                                  (all-true? symbol? (cadr clause))))))
X                  clauses))
X            `60(let ((,var ,record-var))
X                  (cond ,@(loop clauses)))
X            (error/define-record-or-variant-case
X              "variant-case syntax error:" record-var)))))
$ CALL UNPACK DEF-REC.SCM;2 74751202
$ create 'f'
X;;; genscmint.scm -- Generate an SCM interface to foreign functions.
X;;;
X;;; This reads a file containing forms that define foreign functions and
X;;; generates an output file containing C source code that can be compiled a
Vnd
X;;; linked with SCM to provide Scheme functions that convert parameters to t
Vhe
X;;; form expected by the foreign functions, call the foreign functions, and
X;;; convert any results to SCM's internal form and return them in a vector.
X;;; The generated C source code includes the file SCMINT.H and calls functio
Vns
X;;; defined in SCMINT.C.
X;;;
X;;; The define-foreign forms each describe one foreign function.  Each
X;;; function returns a vector that is at least one element long.  The
X;;; first element is the status code returned by the routine.  Any
X;;; other elements are the values of the out parameters after the
X;;; call.
X;;;
X;;; Optional parameters may be replaced by a boolean, in which case
X;;; they are ignored.
X;;;
X;;; Out parameters are returned in the result vector.
X;;;
X;;; In-out parameters appear in both the parameter list and the result
X;;; vector.
X;;;
X;;;
X;;; I use this to generate a SMG interface for SCM from a file generated fro
Vm
X;;; a .SDI file, so it has lots of VMSisms.
X;;;
X;;; Usage:`20
X;;;        (driver "in.file" "module-name" "out.file")
X;;;
X;;; Note: the generated code uses BIGNUMS!
X;;;
X;;; Here is the definition of the define-foreign form:
X;;;
X;;; (define-foreign <internal-name>
X;;;   (<external-name> <return-type>
X;;;                    (<param-name> <param-type> <access> <pass-mechanism>
X;;;                                  `5B<modifiers> ...`5D)
X;;;                    ...
X;;;                    ))
X;;; Where:
X;;;  param-type is one of  longword, byte, word, character
X;;;             (character is a string)
X;;; access is one of in, out, in-out
X;;; pass-mechanism is one of reference, value
X;;; modifiers is zero or more of optional, descriptor.
X;;;
X;;;
X;;; Todo:  Modify to produce additional files that contain wrapper Scheme
X;;;        routines that return multiple results or take success and failure
X;;;        continuations (as per suggestions from comp.lang.scheme).
X
X(load "def-mac.scm")
X(load "def-rec.scm")
X;(require 'pretty-print)
X
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;; Data Structures
X
X(define-record foreign (internal-name external-name result-type parameters))
X
X(define-record parameter (name type access mechanism modifiers))
X
X(define-record function-entry (name-var int-fun))
X
X
X`0C
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;; Support routines
X
X(define (tell . objs)
X  (for-each display objs)
X  (newline))
X
X(define (count-trues pred? ls)
X  (let loop ((n 0)
X`09     (ls ls))
X    (if (null? ls)
X`09n
X`09(loop (if (pred? (car ls)) (+ 1 n) n) (cdr ls)))))
X
X
X(define (in-parameter? param)
X  (or (eq? (parameter->access param) 'in)
X      (eq? (parameter->access param) 'in-out)))
X
X
X(define (out-parameter? param)
X  (or (eq? (parameter->access param) 'out)
X      (eq? (parameter->access param) 'in-out)))
X
X
X(define (for-each-with-count fun ls)`09;returns number of items processed
X  (let loop ((idx 0)
X`09     (ls ls))
X    (cond ((null? ls)
X`09   idx)
X`09  (else
X`09   (fun (car ls) idx)
X`09   (loop (+ 1 idx) (cdr ls))))))
X`09
X
X`0C
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;; Parsing
X
X(define (parse-foreign obj)
X  (let ((ext (caddr obj)))
X    (make-foreign (cadr obj)
X`09`09  (car ext)
X`09`09  (cadr ext)
X`09`09  (parse-parameters (cddr ext)))))
X
X(define (parse-parameters param-list)
X  (let loop ((param-list param-list)
X`09     (out-list '()))
X    (cond
X     ((null? param-list)
X      (reverse out-list))
X     (else
X      (let ((param (car param-list)))
X`09(loop (cdr param-list)
X`09      (cons (make-parameter (car param)
X`09`09`09`09    (cadr param)
X`09`09`09`09    (caddr param)
X`09`09`09`09    (cadddr param)
X`09`09`09`09    (cddddr param))
X`09`09    out-list)))))))
X
X`0C
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;; Processing
X
X(define (external-parameter->string param)
X  (case (parameter->type param)
X    ((ADDRESS)
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*address*/long *"
X`09 "/*address*/long"))
X    ((ANY)
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*any*/long *"
X`09 "/*any*/long"))
X    ((BYTE)
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*byte*/unsigned char*"
X`09 "/*byte*/unsigned char"))
X   `20
X    ((CHARACTER)`09`09`09;string, actually
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*character*/struct dsc$descriptor_s *"
X`09 "/*character*/struct dsc$descriptor_s"))
X    ((LONGWORD)
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*longword*/long *"
X`09 "/*longword*/long"))
X    ((WORD)
X     (if (eq? (parameter->mechanism param) 'ref)
X`09 "/*word*/unsigned short *"
X`09 "/*word*/unsigned short"))
X    (else
X     (tell "internal: unhandled type: " (paramater->type param))
X     "/*oops*/unknown")))
X
X
X(define (write-external-parameters param-list)
X  (let loop ((param-list param-list)
X`09     (first #t))
X    (cond
X     ((not (null? param-list))
X      (if (not first)
X`09  (display-out ", "))
X      (display-out (external-parameter->string (car param-list)))
X      (loop (cdr param-list) #f)))))
X
X
X(define (type->string type)
X  (case type
X    ((ADDRESS) "long")
X    ((BYTE) "unsigned char")
X    ((CHARACTER) "struct dsc$descriptor_s")
X    ((BOOLEAN) "long")
X    ((DECIMAL) "long")
X    ((DFLOAT) "double")
X    ((FFLOAT) "float")
X    ((GFLOAT) "/*oops*/gfloat")
X    ((HFLOAT) "/*oops*/hfloat")
X    ((LONGWORD) "long")
X    ((OCTAWORD) "/*oops*/octaword")
X    ((QUADWORD) "/*oops*/quadword")
X    ((BITFIELD) "/*oops*/bitfield")
X    ((WORD) "unsigned short")
X    ((STRUCTURE) "/*oops*/structureX")
X    ((UNION) "/*oops*/unionX")
X    ((ANY) "long")
X    ((ENTRY) "long")
X    ((DLFOAT_COMPLEX) "/*oops*/dfloat_complex")
X    ((FLFOAT_COMPLEX) "/*oops*/ffloat_complex")
X    ((GLFOAT_COMPLEX) "/*oops*/gfloat_complex")
X    ((HLFOAT_COMPLEX) "/*oops*/hfloat_complex")
X    (else
X     (tell "internal: unknown type: " type)
X     "/*oops*/unknown")))
X
X
X(define external-name->string symbol->string)
X
X
X(define (write-external f)
X  (display-out "extern "
X`09       (type->string (foreign->result-type f))
X`09       " "`20
X`09       (external-name->string (foreign->external-name f))
X`09       " (")
X  (write-external-parameters (foreign->parameters f))
X  (display-out ");" nl))
X
X
X;;; sis = Scm Interface String
X(define (external-name->name-var ext-name)
X  (string-append "sis_" (external-name->string ext-name)))
X
X;;; sif = Scm Interface Function
X(define (external-name->int-fun ext-name)
X  (string-append "sif_" (external-name->string ext-name)))
X
X
X(define (write-internal-name-string f)
X  (display-out "static char "
X`09       (external-name->name-var (foreign->external-name f))
X`09       "`5B`5D = \""
X`09       (foreign->internal-name f)
X`09       "\";"
X`09       nl))
X
X
X(define (write-internal-defn f)
X  (display-out "SCM" nl
X`09       (external-name->int-fun (foreign->external-name f))
X`09       " (SCM l)" nl))
X
X
X(define (declare-inargs param-list)
X  (for-each-with-count
X   (lambda (param idx)
X     (cond ((in-parameter? param)
X`09    (display-out "  SCM "
X`09`09`09 "inarg_" (number->string (+ 1 idx)) ";" nl) )))
X   param-list))
X
X
X(define (for-each-with-count&true-count fun ls pred?)
X  (let loop ((idx 0)
X`09     (in-idx 0)
X`09     (ls ls))
X    (cond ((null? ls)
X`09   idx)
X`09  (else
X`09   (fun (car ls) idx in-idx)
X`09   (loop (+ 1 idx)
X`09`09 (if (pred? (car ls))
X`09`09`09       (+ 1 in-idx)
X`09`09`09       in-idx)`09;was idx, why?
X`09`09 (cdr ls))))))
X
X
X(define (declare-outres param-list)
X  (for-each-with-count
X   (lambda (param idx)
X     (cond ((out-parameter? param)
X`09    (display-out "  SCM "
X`09`09`09 "outres_" (number->string (+ 1 idx)) ";" nl) )))
X   param-list))
X
X
X(define (declare-params param-list)
X  (for-each-with-count
X   (lambda (param idx)
X     (display-out "  " (type->string (parameter->type param)) " "
X`09`09  (parameter->name param))
X     (if (eq? 'CHARACTER (parameter->type param))
X`09 (display-out " = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D"))
X     (display-out ";" nl))
X   param-list))
X
X
X(define (write-call f)
X  (display-out "  extres = " (foreign->external-name f) nl
X`09       "    (")
X  (for-each-with-count&true-count
X   (lambda (param idx in-idx)
X     (if (> idx 0) (display-out ", " nl "     "))
X     (cond
X      ((and (in-parameter? param)
X`09    (member 'optional (parameter->modifiers param)))
X       (display-out "((num_args > " (number->string in-idx)
X`09`09    ") && !si_booleanp (inarg_" (number->string (+ idx 1))
X`09`09    ") ? " (if (eq? (parameter->mechanism param) 'ref) "&" "")
X`09`09    (parameter->name param) " : 0)"))
X      (else
X       (if (eq? (parameter->mechanism param) 'ref) (display-out "&"))
X       (display-out (parameter->name param)))))
X   (foreign->parameters f)
X   in-parameter?)
X  (display-out ");" nl))
X
X;;; couldn't this be replaced with (count-trues in-parameter? param-list) ??
V?
X(define (number-of-in-parameters param-list)
X  (let loop ((n 0)
X`09     (param-list param-list))
X    (if (null? param-list)
X`09n
X`09(loop (if (in-parameter? (car param-list))
X`09`09  (+ 1 n)
X`09`09  n)
X`09      (cdr param-list)))))
X
X;;; couldn't this be replaced with (count-trues out-parameter? param-list) ?
V??
X(define (last-required-in-arg param-list)
X  (let loop ((lra 0)
X`09     (idx 0)
X`09     (param-list param-list))
X    (if (null? param-list)
X`09lra
X`09(let ((param (car param-list)))
X`09  (loop (if (and (in-parameter? param)
X`09`09`09 (not (member 'optional
X`09`09`09`09      (parameter->modifiers param))))
X`09`09    (+ 1 idx)
X`09`09    lra)
X`09`09(if (in-parameter? param)
X`09`09    (+ 1 idx)
X`09`09    idx)
X`09`09(cdr param-list))))))
X
X
X(define (check-number-of-args f)
X  (let ((param-list (foreign->parameters f))
X`09(name-var (external-name->name-var (foreign->external-name f))))
X    (cond
X     ((null? param-list)
X      (display-out "  ASSERT (num_args == 0, l, SI_WNA, " name-var ");" nl))
X     (else
X      (display-out "  ASSERT ((num_args >= " (last-required-in-arg param-lis
Vt)
X`09`09   ") && (num_args <= " (number-of-in-parameters param-list)
X`09`09   "), l, WNA, " name-var ");" nl)))))
X
X
X(define (type->type-test type)
X  (case type
X    ((ADDRESS) "si_longwordp")
X    ((BYTE) "si_unsigned_charp")
X    ((CHARACTER) "si_stringp")
X    ((BOOLEAN) "si_longwordp")
X    ((DECIMAL) "si_longwordp")
X    ((DFLOAT) "si_doublep")
X    ((FFLOAT) "si_floatp")
X    ((GFLOAT) "/*oops*/si_gfloatp")
X    ((HFLOAT) "/*oops*/si_hfloatp")
X    ((LONGWORD) "si_longwordp")
X    ((OCTAWORD) "/*oops*/si_octawordp")
X    ((QUADWORD) "/*oops*/si_quadwordp")
X    ((BITFIELD) "/*oops*/si_bitfieldp")
X    ((WORD) "si_unsigned_shortp")
X    ((STRUCTURE) "/*oops*/si_structureXp")
X    ((UNION) "/*oops*/si_unionXp")
X    ((ANY) "si_longwordp")
X    ((ENTRY) "si_longwordp")
X    ((DLFOAT_COMPLEX) "/*oops*/si_dfloat_complexp")
X    ((FLFOAT_COMPLEX) "/*oops*/si_ffloat_complexp")
X    ((GLFOAT_COMPLEX) "/*oops*/si_gfloat_complexp")
X    ((HLFOAT_COMPLEX) "/*oops*/si_hfloat_complexp")
X    (else
X     (tell "internal: unknown type: " type)
X     "/*oops*/si_unknownp")))
X
X
X(define (type->from-scm-proc type)
X  (case type
X    ((ADDRESS) "si_to_longword")
X    ((BYTE) "si_to_unsigned_char")
X    ((CHARACTER) "si_to_string")
X    ((BOOLEAN) "si_to_longword")
X    ((DECIMAL) "si_to_longword")
X    ((DFLOAT) "si_to_double")
X    ((FFLOAT) "si_to_float")
X    ((GFLOAT) "/*oops*/si_to_gfloat")
X    ((HFLOAT) "/*oops*/si_to_hfloat")
X    ((LONGWORD) "si_to_longword")
X    ((OCTAWORD) "/*oops*/si_to_octaword")
X    ((QUADWORD) "/*oops*/si_to_quadword")
X    ((BITFIELD) "/*oops*/si_to_bitfield")
X    ((WORD) "si_to_unsigned_short")
X    ((STRUCTURE) "/*oops*/si_to_structureX")
X    ((UNION) "/*oops*/si_to_unionX")
X    ((ANY) "si_to_longword")
X    ((ENTRY) "si_to_longword")
X    ((DLFOAT_COMPLEX) "/*oops*/si_to_dfloat_complex")
X    ((FLFOAT_COMPLEX) "/*oops*/si_to_ffloat_complex")
X    ((GLFOAT_COMPLEX) "/*oops*/si_to_gfloat_complex")
X    ((HLFOAT_COMPLEX) "/*oops*/si_to_hfloat_complex")
X    (else
X     (tell "internal: unknown type: " type)
X     "/*oops*/si_to_unknown")))
X
X
X(define (type->to-scm-proc type)
X  (case type
X    ((ADDRESS) "si_from_longword")
X    ((BYTE) "si_from_unsigned_char")
X    ((CHARACTER) "si_from_string")
X    ((BOOLEAN) "si_from_longword")
X    ((DECIMAL) "si_from_longword")
X    ((DFLOAT) "si_from_double")
X    ((FFLOAT) "si_from_float")
X    ((GFLOAT) "/*oops*/si_from_gfloat")
X    ((HFLOAT) "/*oops*/si_from_hfloat")
X    ((LONGWORD) "si_from_longword")
X    ((OCTAWORD) "/*oops*/si_from_octaword")
X    ((QUADWORD) "/*oops*/si_from_quadword")
X    ((BITFIELD) "/*oops*/si_from_bitfield")
X    ((WORD) "si_from_unsigned_short")
X    ((STRUCTURE) "/*oops*/si_from_structureX")
X    ((UNION) "/*oops*/si_from_unionX")
X    ((ANY) "si_from_longword")
X    ((ENTRY) "si_from_longword")
X    ((DLFOAT_COMPLEX) "/*oops*/si_from_dfloat_complex")
X    ((FLFOAT_COMPLEX) "/*oops*/si_from_ffloat_complex")
X    ((GLFOAT_COMPLEX) "/*oops*/si_from_gfloat_complex")
X    ((HLFOAT_COMPLEX) "/*oops*/si_from_hfloat_complex")
X    (else
X     (tell "internal: unknown type: " type)
X     "/*oops*/si_from_unknown")))
X
X
X(define (initialize-inargs f)
X  (let ((name-var (external-name->name-var (foreign->external-name f)))
X`09(param-list (foreign->parameters f)))
X    (for-each-with-count&true-count
X     (lambda (param idx in-idx)
X       (if (in-parameter? param)
X`09   (let ((arg (string-append "inarg_" (number->string (+ idx 1)))))
X`09     (display-out "  if (num_args > " in-idx ")" nl
X`09`09`09  "    `7B" nl
X`09`09`09  "      " arg " = CAR (l); l = CDR (l);" nl
X`09`09`09  "      ASSERT (" (type->type-test
X`09`09`09`09`09    (parameter->type param))
X`09`09`09  " (" arg ")")
X`09     (if (member 'optional (parameter->modifiers param))
X`09`09 (display-out " `7C`7C si_booleanp (" arg ")"))
X`09     (display-out ", " arg ", ARG" (number->string (+ in-idx 1)) ", "
X`09`09`09  name-var ");" nl)
X`09     (if (member 'optional (parameter->modifiers param))
X`09`09 (display-out "      if (!si_booleanp (" arg "))"))`09;???
X`09     (display-out "      " (parameter->name param) " = "
X`09`09`09  (type->from-scm-proc (parameter->type param))
X`09`09`09  " (" arg ");" nl)
X`09     (display-out "    `7D" nl))))
X`09   param-list
X`09   in-parameter?)))
X
X
X(define (initialize-params f)
X  #f)
X
X
X(define (build-result f)
X  (let* ((param-list (foreign->parameters f))
X`09 (num-out-params (count-trues out-parameter? param-list)))
X    (display-out "  result = make_vector (MAKINUM (" num-out-params
X`09`09 "+1), UNSPECIFIED);" nl
X`09`09 "  data = VELTS (result); " nl)
X    (display-out "  *data++ = " (type->to-scm-proc (foreign->result-type f))
X`09`09 " (extres);" nl)
X    (for-each-with-count&true-count
X     (lambda (param idx out-idx)
X       (if (out-parameter? param)
X`09   (display-out "  *data++ = " (type->to-scm-proc
X`09`09`09`09`09(parameter->type param))
X`09`09`09" (" (parameter->name param) ");" nl)))
X     param-list
X     out-parameter?)))
X
X
X(define (write-internal-body f)
X  (let* ((param-list (foreign->parameters f))
X`09 (num-in-params (count-trues in-parameter? param-list))
X`09 (num-out-params (count-trues out-parameter? param-list))
X`09 (num-results (+ 1 num-out-params)))
X    (display-out "`7B" nl)
X    ;; interesting stuff goes here
X    (display-out "  int num_args = ilength (l);" nl
X`09`09 "  SCM result;" nl
X`09`09 "  " (type->string (foreign->result-type f)) " extres;" nl
X`09`09 "  SCM *data;" nl
X`09`09 )
X    (declare-inargs param-list)
X;    (declare-outres param-list);; not needed, stuffed in array
X    (declare-params param-list)
X    (check-number-of-args f)
X    (initialize-inargs f)
X    (initialize-params f)
X    (write-call f)
X    (build-result f)
X    (display-out "  return result;" nl)
X    (display-out "`7D /* " (external-name->int-fun (foreign->external-name f
V))
X`09`09 " */" nl)))
X
X
X(define (save-function-entry f)
X  (let ((ext-name (foreign->external-name f)))
X    (set! function-entries
X`09  (cons (make-function-entry (external-name->name-var ext-name)
X`09`09`09`09     (external-name->int-fun ext-name))
X`09`09function-entries))))
X
X
X(define (write-internal f)
X  (write-internal-name-string f)
X  (write-internal-defn f)
X  (write-internal-body f)
X  (save-function-entry f))
X
X
X(define (process-foreign f)
X  (write-external f)
X  (write-internal f)
X  (display-out nl nl nl))
X
X
X(define (write-function-entries entry-list)
X  (display-out "static iproc si_lsubrs`5B`5D = `7B" nl)
X  (for-each
X   (lambda (entry)
X     (display-out "  `7B "
X`09`09  (function-entry->name-var entry)
X`09`09  ", "
X`09`09  (function-entry->int-fun entry)
X`09`09  " `7D,"
X`09`09  nl))
X   (reverse entry-list))
X  (display-out "  `7B 0, 0 `7D," nl
X`09       "`7D;" nl))
X
X`0C
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;;
X;;; Simpleminded documentation
X
X(define (write-doc f)
X  (doc-out (foreign->external-name f) nl "    Inputs:" nl)
X  (for-each-with-count&true-count
X   (lambda (param idx tidx)
X     (cond ((in-parameter? param)
X`09    (doc-out "        " (parameter->name param) " (" (+ idx 1) ") "
X`09`09     (parameter->type param))
X`09    (if (member 'optional (parameter->modifiers param))
X`09`09(doc-out " optional"))
X`09    (doc-out nl))))
X   (foreign->parameters f)
X   in-parameter?)
X  (doc-out "    Results:" nl)
X  (doc-out "        status (return value) longword" nl)
X  (for-each-with-count&true-count
X   (lambda (param idx tidx)
X     (cond ((out-parameter? param)
X`09    (doc-out "        " (parameter->name param) " (" (+ idx 1) ") "
X`09`09     (parameter->type param) nl))))
X   (foreign->parameters f)
X   out-parameter?)
X  (doc-out nl nl nl)
X  #f)
X
X
X`0C
X;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
V;;
X;;; Read from file
X
X(define write-out 'forward)`09`09;write on output file
X(define display-out 'forward)`09`09;display on output file
X;(define pretty-print-out 'forward)`09;pretty-print on output file
X(define doc-out 'forward)`09`09;display on documentation file
X
X(define nl #\newline)
X
X(define function-entries '())
X
X(define prog-name "genscmint")
X(define prog-version "0.3")
X
X(define (driver in-name module-name . rest)
X  (let ((in-file (open-input-file in-name))
X`09(out-file (if (null? rest)
X`09`09      (current-output-port)
X`09`09      (open-output-file (car rest))))
X`09(doc-file (if (= (length rest) 2)
X`09`09      (open-output-file (cadr rest))
X`09`09      #f)))
X    (set! write-out
X`09  (lambda objs (for-each (lambda (obj) (write obj out-file)) objs)))
X    (set! display-out
X`09  (lambda objs (for-each (lambda (obj) (display obj out-file)) objs)))
X    (if doc-file
X`09(set! doc-out
X`09      (lambda objs (for-each (lambda (obj)
X`09`09`09`09       (display obj doc-file)) objs)))
X`09(set! doc-out (lambda objs #f)))
X;    (set! pretty-print-out (lambda (obj)
X;`09`09`09     (pretty-print obj out-file)))
X    (set! function-entries '())
X    (display-out "/* -*- C -*-    Module " module-name " generated by "
X`09`09 prog-name " "
X`09`09 prog-version " */" nl nl)
X    (display-out "#include \"scmint.h\"" nl nl nl)
X    (let loop ((obj (read in-file))
X`09       (num 1))
X      (cond ((eof-object? obj)
X`09     (tell "items processed: " num nl))
X`09    (else
X`09     (if (and (pair? obj)
X`09`09      (eq? (car obj) 'define-foreign))
X`09`09 (let ((f (parse-foreign obj)))
X`09`09   (process-foreign f)
X`09`09   (if doc-file (write-doc f))))
X`09     (loop (read in-file) (+ num 1)))))
X    (write-function-entries function-entries)
X    (display-out "void " nl
X`09`09 "init_" module-name "()" nl
X`09`09 "`7B" nl
X`09`09 "  init_iprocs (si_lsubrs, tc7_lsubr);" nl
X`09`09 "`7D" nl)
X    (close-input-port in-file)
X    (if doc-file (close-output-port doc-file))
X    (or (null? rest) (close-output-port out-file))))
X`09
$ CALL UNPACK GENSCMINT.SCM;21 626361858
$ create 'f'
X(driver "smg$routines.si" "smg" "smg.c" "smgfuns.doc")
X(exit)
$ CALL UNPACK GENSMG.SCM;5 1564743814
$ create 'f'
X(define dodbg #f)
X(if dodbg (require 'debug))
X;;; readstring.scm
X;;;
X;;; READSTRING.SCM is a longer example that is slightly more interesting.
X;;; It uses several virtual displays to prompt for user input in fields,
X;;; allowing the user to move around in the fields and edit them.  The
X;;; input routine, a slightly more user-friendly version of
X;;; SMG$READ_STRING, is written in scheme using the SMG extensions, though
X;;; not particularly clearly, and has most of the standard VMS line
X;;; editing keys.
X
X
X
X;;;
X;;; Define names for the values that (read-keystroke <kbd>) returns.
X;;; These are the SMG termcodes, SMG$K_TRM_*.
X;;;
X
X;; Control keys.
X(define CTRL_B 002)
X(define CTRL_D 004)
X(define CTRL_E 005)
X(define CTRL_F 006)
X(define CTRL_H 008)
X(define CTRL_H 008) (define BS 8)
X(define CTRL_I 009) (define TAB 9)
X(define CTRL_K 011)
X(define CTRL_M 013) (define RETURN 013)
X(define CTRL_N 014)
X(define CTRL_P 016)
X(define CTRL_R 018)
X(define CTRL_U 021)
X(define CTRL_W 023)
X(define CTRL_Z 026)
X
X;; Normal letters.
X(define UP_N   78)`20
X(define LOW_N 110)
X(define UP_P   80)
X(define LOW_P 112)
X(define UP_Q   81)
X(define LOW_Q 113)
X(define UP_Y   89)
X(define LOW_Y 121)
X
X;; Other printable characters (more or less)
X(define SPACE 32)
X(define TILDE 126)
X
X;; Misc.
X(define DELETE 127)
X
X;; Arrow keys.
X(define UP 274)
X(define DOWN 275)
X(define LEFT 276)
X(define RIGHT 277)
X
X;; Special Keys
X(define HELP   295)
X(define DO_KEY 296)
X(define FIND   311)
X(define INSERT 312)
X(define REMOVE 313)
X(define SELECT 314)
X(define F10    290)
X(define F12    292)
X(define F20    300)
X(define PF1    256)
X(define PF2    257)
X(define PF3    258)
X(define PF4    259)
X
X;; For checking that a key is a movement key
X(define movement-keys
X  (list UP CTRL_P DOWN CTRL_N LEFT CTRL_B RIGHT CTRL_F TAB BS F12))
X
X
X`0C
X(define (pair-string x y width)
X  (let ((xs (pad (number->string x) width "0"))
X`09(ys (pad (number->string y) width "0")))
X    (string-append "(" xs "," ys ")")))
X
X(define (pad s w padding)
X  (do ((s s (string-append padding s)))
X      ((>= (string-length s) w)
X       s)))
X
X
X`0C
X;;;
X;;; Define variables for SMG output and input.
X;;;
X
X;; pasteboard
X(define pbd #f)
X
X;; keyboard
X(define kbd #f)
X
X;; Virtual Display and associated info
X(define vd #f)
X(define vd-width 80)
X(define vd-height 23)
X(define vd-row 1)
X(define vd-col 1)
X
X;; Current row and column
X(define row 1)
X(define col 1)
X
X;; Message virtual display.  This is the last line on the physical screen
X;; and is used for short messages and questions.
X(define mvd #f)
X(define mvd-height 1)
X(define mvd-width 80)
X(define mvd-row 24)
X(define mvd-col 1)
X
X
X
X`0C
X;;;
X;;; Functions dealing with the message area.
X;;;`20
X
X(define putmsg-clear (make-string mvd-width #\ )) ;for blanking the whole li
Vne
X
X(define (get-yesno msg default)
X  (let loop ()
X    (smg$put_chars mvd putmsg-clear 1 1)
X    (smg$put_chars mvd (string-append msg " (Y,N) " (if default "`5BY`5D " "
V`5BN`5D "))
X`09       1 1)
X    (let ((key (vector-ref (smg$read_keystroke kbd) 1)))
X      (cond
X       ((= key RETURN)
X`09default)
X       ((or (= key LOW_Y) (= key UP_Y))
X`09#t)
X       ((or (= key LOW_N) (= key UP_N))
X`09#f)
X       (else
X`09(putmsg #t "Invalid Key!")
X`09(smg$read_keystroke kbd)
X`09(loop))))))
X
X
X;; Output a debug message to the the message area.
X(define (sdbg msg)
X  (cond (#f
X`09 (putmsg #t (string-append "sdbg: " msg " (press return)"))
X`09 (smg$read_keystroke kbd))))
X
X
X;; Display a message in the message area.
X;; If MSG then ring the bell.  Display MSG on the message line.  If REST is
X;; non-null (a third parameter was specified) then pause till next key press
Ved.
X(define (putmsg ring-bell? msg . rest)
X  (smg$put_chars mvd putmsg-clear 1 1)`09;clear the line.  ???smg$erase_line
X  (smg$put_chars mvd (if (null? rest)
X`09`09     msg
X`09`09     (string-append msg " (press return)"))
X`09     1 1)
X  (if ring-bell?
X      (smg$ring_bell mvd 1))
X  (if (not (null? rest))
X      (smg$read_keystroke kbd)))
X
X`0C
X;; Invoke this to start it.
X(define (driver)
X  (set! pbd (vector-ref (smg$create_pasteboard) 1))
X  (set! kbd (vector-ref (smg$create_virtual_keyboard) 1))
X  (set! vd (vector-ref (smg$create_virtual_display vd-height vd-width 0) 1))
X  (smg$put_chars vd "Press PF1 for new-comment box" 1 1)
X  (smg$put_chars vd "Press PF2 for new-field box" 2 1)
X  (smg$put_chars vd "In boxes, F10 & Ctrl-Z exit, F20 abandons, arrows move.
V"
X`09     6 1)
X  (set! mvd (vector-ref (smg$create_virtual_display mvd-height mvd-width 0)
V 1))
X  (smg$paste_virtual_display vd pbd vd-row vd-col)
X  (smg$paste_virtual_display mvd pbd mvd-row mvd-col)
X  (do ((key (vector-ref (smg$read_keystroke kbd) 1) (vector-ref (smg$read_ke
Vystroke kbd) 1)))
X      ((or (not (number? key))`09`09;exit on error from read-keystroke
X`09   (= key CTRL_Z)`09`09;exit on Ctrl-Z
X`09   (= key F10)))
X    (cond ((= key PF1)
X`09   (new-comment))
X`09  ((= key PF2)
X`09   (new-field))
X`09  (else
X`09   (putmsg #t "Oops!  Bad Key!  Baaad Keeey!"))))
X  (smg$set_physical_cursor pbd 24 1)
X  (smg$delete_pasteboard pbd 0)
X  (newline)
X  (smg$delete_virtual_display vd)
X  (smg$delete_virtual_display mvd)
X  (smg$delete_virtual_keyboard kbd))
X
X
X`0C
X;;;
X;;; read-string and supporting routines.  Reads input from an area on the
X;;; screen of a specified length, allowing editing.  This was a quick
X;;; translation of a routine in VAX BASIC, which was in turn based on
X;;; an turbo pascal routine.
X;;;
X
X(define (delete_ s p l sl)
X;  (newline) (display "delete_ ") (display sl) (display " ") (display p)`20
X  (do ((i p (+ i 1)))
X      ((>= i (- sl 1)))
X;    (newline) (display sl) (display " ") (display p) (display " ") (display
V i)
X;    (display " ") (display (+ i l))
X    (string-set! s i (if (> (+ i l) sl)
X`09`09`09 #\
X`09`09`09 (string-ref s (+ i l)))))
X  (string-set! s (- sl 1) #\ ))
X
X(define (insert_ ch s p sl)
X;  (newline) (display sl) (display " ") (display p)`20
X  (do ((i sl (- i 1)))
X      ((= i p))
X;    (newline) (display sl) (display " ") (display p)
X    (string-set! s i (string-ref s (- i 1))))
X  (string-set! s p (integer->char ch)))
X
X
X;; This key and anything after it are automatically terminators.
X(define START_AUTO_TERM 256)
X
X
X(define (read-string vd`09`09`09;virtual display
X`09`09     kbd`09`09;keyboard
X`09`09     s`09`09`09;default data
X`09`09     l`09`09`09;max length of field
X`09`09     row`09`09;row on vd where field is
X`09`09     col`09`09;column on vd where field is
X`09`09     term`09`09;list of terminators
X`09`09     )
X  (let* ((sl (string-length s))
X`09 (p sl)
X`09 (s (let ((x (make-string l #\ )))
X`09      (do ((i 0 (+ i 1)))
X`09`09  ((>= i sl))
X`09`09(string-set! x i (string-ref s i)))
X`09      x)))
X    (smg$put_chars vd (string-append (substring s 0 sl)
X`09`09`09`09 (make-string (- l sl) #\_))
X`09       row col)
X    (smg$set_cursor_abs vd row (+ col p))
X    (let loop ((ch (vector-ref (smg$read_keystroke kbd) 1)))
X      (cond
X       ((and (>= ch SPACE) (<= ch TILDE))
X`09(if (< p l)
X`09    (begin (if (= sl l)
X`09`09       (begin (delete_ s (- sl 1) 1 sl) (set! sl (- sl 1))))
X`09`09   (insert_ ch s p sl)
X`09`09   (set! sl (+ sl 1))
X`09`09   (set! p (+ p 1))
X`09`09   (smg$put_chars vd (substring s (- p 1) sl) row (+ col p -1))
X`09`09   )
X`09    (smg$ring_bell vd 1))`09   `20
X`09)
X       ((or (= ch LEFT) (= ch CTRL_B))
X`09(if (> p 0)
X`09    (set! p (- p 1))
X`09    (smg$ring_bell vd 1))
X`09)
X       ((or (= ch RIGHT) (= ch CTRL_F))
X`09(if (< p sl)
X`09    (set! p (+ p 1))
X`09    (smg$ring_bell vd 1))
X`09)
X       ((= ch CTRL_H)
X`09(set! p 0)
X`09)
X       ((= ch CTRL_E)
X`09(set! p sl)
X`09)
X       ((= ch CTRL_D)
X`09(if (< p sl)
X`09    (begin (delete_ s p 1 sl)
X`09`09   (set! sl (- sl 1))
X`09`09   (smg$put_chars vd (string-append (substring s p sl)
X`09`09`09`09`09`09"_")
X`09`09`09      row (+ col p)))
X`09    (smg$ring_bell vd 1))
X`09)
X       ((= ch DELETE)
X`09(if (> p 0)
X`09    (begin (delete_ s (- p 1) 1 sl)
X`09`09   (set! sl (- sl 1))
X;`09`09   (newline) (display "smg$put_chars")(display p)(display " ")
X;`09`09   (display sl)
X`09`09   (set! p (- p 1))
X`09`09   (smg$put_chars vd (string-append (substring s p sl) "_")
X`09`09`09      row (+ col p)))
X`09    (smg$ring_bell vd 1))
X`09)
X       ((= ch CTRL_R)
X`09(smg$put_chars vd (string-append (substring s 0 sl)
X`09`09`09`09     (make-string (- l sl) #\_))
X`09`09   row col)
X`09)
X       ((= ch CTRL_U)
X`09(if (> p 0)
X`09    (begin
X`09      (delete_ s 0 p sl)
X`09      (set! sl (- sl p))
X`09      (set! p 0)
X`09      (smg$put_chars vd (string-append (substring s 0 sl)
X`09`09`09`09`09   (make-string (- l sl) #\_))
X`09`09`09 row col))
X`09    (smg$ring_bell vd 1))
X`09)
X       ((= ch CTRL_K)
X`09(if (< p sl)
X`09    (begin
X`09      (delete_ s p (- sl p) sl)
X`09      (set! sl (- sl (- sl p)))
X`09      (smg$put_chars vd (string-append (substring s 0 sl)
X`09`09`09`09`09   (make-string (- l sl) #\_))
X`09`09`09 row col)
X`09      )
X`09    (smg$ring_bell vd 1))
X`09)
X       (else
X`09(if (not (or (> ch START_AUTO_TERM)
X`09`09     (member ch term)))
X`09    (smg$ring_bell vd 1)))
X      )
X      (smg$set_cursor_abs vd row (+ col p))
X      (if (and (or (>= ch START_AUTO_TERM)
X`09`09   (member ch term))
X`09       (not (member ch (list LEFT RIGHT))))
X`09  (cons (substring s 0 sl) ch)`09;return something
X`09  (loop (vector-ref (smg$read_keystroke kbd) 1))))))
X
X
X;;(define test-vd #f)
X;;(define test-kbd #f)
X;;(define test-pbd #f)
X;;
X;;(define (test-read)
X;;  (set! test-pbd (vector-ref (smg$create_pasteboard) 1))
X;;  (set! test-vd (vector-ref (smg$create_virtual_display 10 70 1) 1))
X;;  (set! test-kbd (vector-ref (smg$create_virtual_keyboard) 1))
X;;  (smg$paste_virtual_display  test-vd test-pbd 2 2)
X;;  (smg$put_chars test-vd ">" 2 9)
X;;  (smg$put_chars test-vd "<" 2 30)
X;;  (let loop ((res (read-string test-vd test-kbd  "default" 20 2 10
X;;`09`09`09   (list RETURN DO_KEY))))
X;;    (smg$put_chars test-vd (string-append (car res)
X;;`09`09`09`09      (make-string (- 20 (string-length
X;;`09`09`09`09`09`09`09  (car res)))
X;;`09`09`09`09`09`09   #\_))
X;;`09       5 10)
X;;    (if (not (= (cdr res) DO_KEY))
X;;`09(loop (read-string test-vd test-kbd (car res) 20 2 10
X;;`09`09`09   (list RETURN DO_KEY))))))
X
X
X
X`0C
X;;;
X;;; Frame Field data structure
X;;;
X;;; I use a naming convention for record accessors that is that
X;;; in _Essentials of Programming Languages_.
X;;;      (make-<record-name> <field-data> ...)
X;;;      (<record-name>-><field-name> <record>)
X;;;      (<record-name>-><field-name>! <record> <new-field-data>)
X;;;
X;(define-record ff (name`09; name of the field, a symbol
X;`09`09    prow        ; row of prompt
X;`09`09    pcol        ; col of prompt
X;`09`09    ptxt        ; prompt text
X;`09`09    drow        ; row of data area
X;`09`09    dcol        ; col of data area
X;`09`09    dlen        ; length of data area
X;`09`09    data        ; data, a string
X;`09`09   ))
X
X(define make-ff #f)
X(define ff? #f)
X(define ff->name #f)
X(define ff->name! #f)
X(define ff->prow #f)
X(define ff->prow! #f)
X(define ff->pcol #f)
X(define ff->pcol! #f)
X(define ff->ptxt #f)
X(define ff->ptxt! #f)
X(define ff->drow #f)
X(define ff->drow! #f)
X(define ff->dcol #f)
X(define ff->dcol! #f)
X(define ff->dlen #f)
X(define ff->dlen! #f)
X(define ff->data #f)
X(define ff->data! #f)
X(let ((xity (cons 'ff '())))
X  (set! make-ff
X    (lambda ( name prow pcol ptxt drow dcol dlen data)
X      (vector xity name prow pcol ptxt drow dcol dlen data)))
X  (set! ff?`20
X    (lambda (vec)`20
X      (and (vector? vec)`20
X           (> (vector-length vec) 0)`20
X           (eq? xity (vector-ref vec 0)))))
X  (set! ff->name
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 1)`20
X          (error "not a ff record" vec))))
X  (set! ff->prow
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 2)`20
X          (error "not a ff record" vec))))
X  (set! ff->pcol
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 3)`20
X          (error "not a ff record" vec))))
X  (set! ff->ptxt
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 4)`20
X          (error "not a ff record" vec))))
X  (set! ff->drow
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 5)`20
X          (error "not a ff record" vec))))
X  (set! ff->dcol
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 6)`20
X          (error "not a ff record" vec))))
X  (set! ff->dlen
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 7)`20
X          (error "not a ff record" vec))))
X  (set! ff->data
X    (lambda (vec)`20
X      (if (ff? vec)`20
X          (vector-ref vec 8)`20
X          (error "not a ff record" vec))))
X  (set! ff->name!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 1 obj)
X           (error "not a ff record" vec))))
X  (set! ff->prow!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 2 obj)
X           (error "not a ff record" vec))))
X  (set! ff->pcol!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 3 obj)
X           (error "not a ff record" vec))))
X  (set! ff->ptxt!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 4 obj)
X           (error "not a ff record" vec))))
X  (set! ff->drow!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 5 obj)
X           (error "not a ff record" vec))))
X  (set! ff->dcol!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 6 obj)
X           (error "not a ff record" vec))))
X  (set! ff->dlen!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 7 obj)
X           (error "not a ff record" vec))))
X  (set! ff->data!`20
X     (lambda (vec obj)`20
X       (if (ff? vec)`20
X           (vector-set! vec 8 obj)
X           (error "not a ff record" vec))))
X)
X
X`0C
X;;;
X;;; Routines for displaying and prompting fields in frames on a screen.
X;;;
X
X
X
X;; Display on the virtual display VD all the fields described in the vector
X;; of fields FV.  Each element in FV is a ff record.
X(define (display-fields vd fv)
X  ;;don't do the following, or we can't display anything else in the vd!
X;  (erase-display vd)
X  (do ((i 0 (+ i 1))
X       (fl (vector-length fv)))
X      ((>= i fl))
X    (let ((ff (vector-ref fv i)))
X      (smg$put_chars vd (ff->ptxt ff) (ff->prow ff) (ff->pcol ff))
X      (smg$put_chars vd (string-append (ff->data ff)
X`09`09`09`09   (make-string
X`09`09`09`09    (- (ff->dlen ff)
X`09`09`09`09       (string-length (ff->data ff)))
X`09`09`09`09    #\_))
X`09`09 (ff->drow ff)
X`09`09 (ff->dcol ff)))))
X
X
X;; Displaying on VD and reading input from KBD, prompt the user for
X;; changes to each field in FV, a vector of ff (frame field) records.
X;; Exit abandoning changes if F20 is pressed, otherwise exit with
X;; changes if F10 or Ctrl-Z are pressed or RETURN is pressed in the
X;; last field.
X(define (prompt-fields vd kbd fv)
X  (let* ((fv-len (vector-length fv))
X`09 (orig (make-vector fv-len)))
X    (do ((i 0 (+ i 1)))
X`09((>= i fv-len))
X      (vector-set! orig i (ff->data (vector-ref fv i))))
X    (let loop ((i 0))
X      (let* ((ff (vector-ref fv i))
X`09     (res (read-string vd kbd (ff->data ff)
X`09`09`09       (ff->dlen ff)
X`09`09`09       (ff->drow ff)
X`09`09`09       (ff->dcol ff)
X`09`09`09       (list RETURN CTRL_P CTRL_N UP DOWN
X`09`09`09`09     CTRL_Z F10 F20)))
X`09     (text (car res))
X`09     (tc (cdr res)))
X`09(ff->data! ff text)`09`09;set field data to whatever entered
X`09(cond ((= tc F20)
X`09       ;; Abandoning changes, set field data back to
X`09       ;; the saved original data.
X`09       (do ((i 0 (+ i 1)))
X`09`09   ((>= i fv-len))
X`09`09 (ff->data! (vector-ref fv i) (vector-ref orig i)))
X`09       ;; Return false, changes abandoned.
X`09       #f)
X`09      ((or (= tc CTRL_Z) (= tc F10))
X`09       ;; Return true, changes accepted.
X`09       #t)
X`09      ((member tc (list RETURN CTRL_N DOWN))
X`09       (cond ((>= i (- (vector-length fv) 1))
X`09`09      ;; Stepped off last field.
X`09`09      ;; Return true, changes accepted.
X`09`09      #t)
X`09`09     (else
X`09`09      ;; Step to the next field.
X`09`09      (loop (+ i 1)))))
X`09      ((member tc (list CTRL_P UP))
X`09       (cond ((= i 0)
X`09`09      (smg$ring_bell vd 1)
X`09`09      (loop i))
X`09`09     (else
X`09`09      (loop (- i 1)))))
X`09      (else
X`09       (smg$ring_bell vd 1)
X`09       (loop i)))))))
X
X
X;; Get in field vector FV the data value of a field called NAME.
X(define (field-value fv name)
X  (let loop ((i 0))
X    (if (>= i (vector-length fv))
X`09#f
X`09(if (eq? (ff->name (vector-ref fv i)) name)
X`09    (ff->data (vector-ref fv i))
X`09    (loop (+ i 1))))))
X
X
X;; Set in field vector FV the data of a field called NAME to VAL.
X(define (field-value! fv name val)
X  (let loop ((i 0))
X    (if (>= i (vector-length fv))
X`09#f
X`09(if (eq? (ff->name (vector-ref fv i)) name)
X`09    (ff->data! (vector-ref fv i) val)
X`09    (loop (+ i 1))))))
X
X
X;; Clear the data value of all fields in field vector FV to the null string.
X(define (clear-field-values! fv)
X  (let loop ((i 0))
X    (if (< i (vector-length fv))
X`09(begin (ff->data! (vector-ref fv i) "")
X`09       (loop (+ i 1))))))
X
X
X;;(define (test-it)
X;;  (let ((frm (vector (make-ff 'one 1 1 "one:" 1 6 10 "")
X;;`09`09     (make-ff 'two 2 1 "two:" 2 6 10 "")
X;;`09`09     (make-ff 'tri 3 1 "tri:" 3 6 15 "")))
X;;`09(pbd (create-pasteboard 24 80))
X;;`09(vd (create-display 10 70 (bits 0)))
X;;`09(kbd (create-keyboard)))
X;;    (paste-display vd pbd 2 3)
X;;    (display-fields vd frm)
X;;    (prompt-fields vd kbd frm)
X;;    (newline) (display (field-value frm 'one))
X;;    (newline) (display (field-value frm 'two))
X;;    (newline) (display (field-value frm 'tri))))
X
X
X`0C
X;;;
X;;; Add a new comment or field.
X;;;
X
X;; These variables define the window used to edit a comment.
X(define cmt-height 4)
X(define cmt-width 70)
X(define cmt-row 5)
X(define cmt-col 5)
X(define cmt-vd (vector-ref
X`09`09(smg$create_virtual_display cmt-height cmt-width 1) 1))
X
X;; This defines the fields that will be edited for a frame-comment.
X(define cmt-fv (vector (make-ff 'row 2 1 " Row:" 2 7 3 "")
X`09`09       (make-ff 'col 3 1 " Col:" 3 7 3 "")
X`09`09       (make-ff 'txt 4 1 "Text:" 4 7 60 "")))
X
X
X;; This is a top level command.
X(define (new-comment)
X  (smg$erase_display cmt-vd)
X  (clear-field-values! cmt-fv)
X  (field-value! cmt-fv 'row (number->string row))
X  (field-value! cmt-fv 'col (number->string col))
X  (smg$put_chars cmt-vd "New Comment Entry" 1 1)
X  (display-fields cmt-vd cmt-fv)
X  (smg$paste_virtual_display cmt-vd pbd cmt-row cmt-col)
X  (let ((res (prompt-fields cmt-vd kbd cmt-fv)))
X    (if res
X`09(cond ((get-yesno "Add the new comment?" #t)
X`09       (putmsg #t "If we could do it, we would!"))
X`09      (else
X`09       (putmsg #t "Ok, not adding new comment!")))
X`09(putmsg #t "Ok, abandoning the new comment!")))
X  (smg$unpaste_virtual_display cmt-vd pbd))
X
X
X;; These variables define the window used to edit a field.
X(define fld-height 8)
X(define fld-width 70)
X(define fld-row 5)
X(define fld-col 5)
X(define fld-vd (vector-ref (smg$create_virtual_display
X`09`09`09    fld-height fld-width 1) 1))
X
X;; This defines the fields that will be edited for a frame-field.
X;; It is a Field-Vector, a vector of fields to be prompted.
X(define fld-fv (vector (make-ff 'name 2 1 "Field Name:" 2 13 32 "")
X`09`09       (make-ff 'prow 3 1 "Prompt Row:" 3 13 3  "")
X`09`09       (make-ff 'pcol 4 1 "    Column:" 4 13 3  "")
X`09`09       (make-ff 'ptxt 5 1 "      Text:" 5 13 40 "")
X`09`09       (make-ff 'drow 6 1 "  Data Row:" 6 13 3  "")
X`09`09       (make-ff 'dcol 7 1 "    Column:" 7 13 3  "")
X`09`09       (make-ff 'dlen 8 1 "    Length:" 8 13 3  "")))
X
X
X;; This is a top level command.
X(define (new-field)
X  (smg$erase_display fld-vd)
X  (clear-field-values! fld-fv)
X  (field-value! fld-fv 'prow (number->string row))
X  (field-value! fld-fv 'pcol (number->string col))
X  (field-value! fld-fv 'drow (number->string row))
X  (field-value! fld-fv 'dcol (number->string col))
X  (smg$put_chars fld-vd "New Field Entry Screen" 1 1)
X  (smg$paste_virtual_display fld-vd pbd fld-row fld-col)
X  (display-fields fld-vd fld-fv)
X  (let ((res (prompt-fields fld-vd kbd fld-fv)))
X    (if res
X`09(cond  ((get-yesno "Add the new field?" #t)
X`09`09(putmsg #t "If we could do it, we would!"))
X`09       (else
X`09`09(putmsg #t "Ok, not adding new field!")))
X`09(putmsg #t "Ok, abandoning new field!")))
X  (smg$unpaste_virtual_display fld-vd pbd))
X
X`0C
X(if dodbg
X    (begin`20
X      (set! smg$create_pasteboard
X`09    (tracef smg$create_pasteboard 'smg$create_pasteboard))
X      (set! smg$create_virtual_display
X`09    (tracef smg$create_virtual_display 'smg$create_virtual_display))
X      (set! smg$create_virtual_keyboard
X`09    (tracef smg$create_virtual_keyboard 'smg$create_virtual_keyboard))
X      (set! smg$delete_virtual_keyboard
X`09    (tracef smg$delete_virtual_keyboard 'smg$delete_virtual_keyboard))
X      (set! smg$delete_pasteboard
X`09    (tracef smg$delete_pasteboard 'smg$delete_pasteboard))
X      (set! smg$delete_virtual_display
X`09    (tracef smg$delete_virtual_display 'smg$delete_virtual_display))
X      (set! smg$erase_display
X`09    (tracef smg$erase_display 'smg$erase_display))
X      (set! smg$paste_virtual_display
X`09    (tracef smg$paste_virtual_display 'smg$paste_virtual_display))
X      (set! smg$put_chars
X`09    (tracef smg$put_chars 'smg$put_chars))
X      (set! smg$read_keystroke
X`09    (tracef smg$read_keystroke 'smg$read_keystroke))
X      (set! smg$ring_bell
X`09    (tracef smg$ring_bell 'smg$ring_bell))
X      (set! smg$set_cursor_abs
X`09    (tracef smg$set_cursor_abs 'smg$set_cursor_abs))
X      (set! smg$set_physical_cursor
X`09    (tracef smg$set_physical_cursor 'smg$set_physical_cursor))
X      (set! smg$unpaste_virtual_display
X`09    (tracef smg$unpaste_virtual_display 'smg$unpaste_virtual_display))
X      ))
X`0C
X
X
X(driver)
$ CALL UNPACK READSTRING.SCM;13 1665865162
$ create 'f'
X/* scmint.c -- SCM Interface; support routines. */
X
X#include "scmint.h"
X
Xchar scmint_version`5B`5D = "0.1";
X
X
X/* Determine whether an SCM object is of the appropriate type.
X   Most of these don't have the proper range checks. */
Xint
Xsi_booleanp (SCM obj)
X`7B
X  return (BOOL_F == obj) `7C`7C (BOOL_T == obj);
X`7D
X
X
Xint
Xsi_stringp (SCM obj)
X`7B
X  return NIMP (obj) && STRINGP (obj);
X`7D
X
X
Xint
Xsi_longwordp (SCM obj)
X`7B
X  return INUMP (obj) `7C`7C BIGP (obj); /* ???check to see if in range? */
X`7D
X
Xint
Xsi_unsigned_charp (SCM obj)
X`7B
X  return INUMP (obj);
X`7D
X
Xint
Xsi_doublep (SCM obj)
X`7B
X  return NUMP (obj);
X`7D
X
Xint`20
Xsi_floatp (SCM obj)
X`7B
X  return NUMP (obj);
X`7D
X
Xint
Xsi_unsigned_shortp (SCM obj)
X`7B
X  return INUMP (obj);
X`7D
X
X
X`0C
X/* Convert from an SCM object to the proper VMS type. */
X
Xlong
Xsi_to_longword (SCM obj)
X`7B
X  if (INUMP (obj))
X    return INUM (obj);
X  else if (BIGP (obj))
X    `7B
X      unsigned long num = 0;
X      BIGDIG *tmp = BDIGITS(obj);
X      sizet nlen = NUMDIGS (obj);
X      while (nlen--) num = BIGUP (num) + tmp`5Bnlen`5D;
X      if (TYP16 (obj) == tc16_bigpos)
X`09  return num;
X      else
X`09return -num;
X    `7D
X  else
X    wta (obj, "not a FIXNUM or a BIGNUM", "internal: si_to_longword");
X`7D
X
X
Xunsigned char
Xsi_to_unsigned_char (SCM obj)
X`7B
X  return (unsigned char) INUM (obj);
X`7D
X
X
Xstruct dsc$descriptor_s
Xsi_to_string (SCM obj)
X`7B
X  struct dsc$descriptor_s str = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  str.dsc$w_length = LENGTH (obj);
X  str.dsc$a_pointer = CHARS (obj);
X  return str;
X`7D
X
X
Xunsigned short
Xsi_to_unsigned_short (SCM obj)
X`7B
X  return INUM (obj);
X`7D
X
X
X`0C
X/* Convert from a VMS type to an SCM object. */
X
X
XSCM`20
Xsi_from_longword (long n)
X`7B
X  if (POSFIXABLE (n))
X    return MAKINUM (n);
X  else if (UNEGFIXABLE (n))
X    return MAKINUM (-n);
X  else
X    return long2big (n);
X`7D
X
X
XSCM`20
Xsi_from_unsigned_char (unsigned char uch)
X`7B
X  return MAKINUM (uch);
X`7D
X
X
XSCM`20
Xsi_from_string (struct dsc$descriptor_s str)
X`7B
X  SCM s;
X  s = makfromstr (str.dsc$a_pointer, str.dsc$w_length);
X  return s;
X`7D
X
X
XSCM
Xsi_from_unsigned_short (unsigned short n)
X`7B
X  return MAKINUM (n);
X`7D
$ CALL UNPACK SCMINT.C;13 1680747277
$ create 'f'
X/* scmint.h -- SCM interface header */
X#include <descrip.h>
X#include "scm.h"
X
X#define SI_WNA "Wrong number of args: "
X#define ARG6 "Wrong type in arg 6"
X#define ARG7 "Wrong type in arg 7"
X#define ARG8 "Wrong type in arg 8"
X#define ARG9 "Wrong type in arg 9"
X#define ARG10 "Wrong type in arg 10"
X#define ARG11 "Wrong type in arg 11"
X#define ARG12 "Wrong type in arg 12"
X#define ARG13 "Wrong type in arg 13"
X#define ARG14 "Wrong type in arg 14"
X#define ARG15 "Wrong type in arg 15"
X
X
Xextern int si_booleanp (SCM);
Xextern int si_stringp (SCM);
Xextern int si_longwordp (SCM);
Xextern int si_unsigned_charp (SCM);
Xextern int si_doublep (SCM);
Xextern int si_floatp (SCM);
Xextern int si_unsigned_shortp (SCM);
X
Xextern long si_to_longword (SCM);
Xextern unsigned char si_to_unsigned_char (SCM);
Xextern struct dsc$descriptor_s si_to_string (SCM);
Xextern unsigned short si_to_unsigned_short (SCM);
X
Xextern SCM si_from_longword (long);
Xextern SCM si_from_unsigned_char (unsigned char);
Xextern SCM si_from_string (struct dsc$descriptor_s);
Xextern SCM si_from_unsigned_short (unsigned short);
$ CALL UNPACK SCMINT.H;5 2050759671
$ create 'f'
X/* sdlscm.c -- Generate declarations of VMS functions and values from
X   .SDI files that GENSCMINT.SCM can read and produce C code for interface
X   routines from.
X
X   Link with sdlscm.obj, misc.obj, readable.obj, and sdlcc-cld.obj from the
X   UNSDL distribution.  (I got it by anonymous ftp from ftp.spc.edu in the
X   file `5B.macro32.savesets`5Dunsdl.zip.)
X
X   */
X
X#include <stdio.h>
X#include <ctype.h>
X#include <descrip.h>
X#include <jpidef.h>
X#include "sdldef.h"
X
X#define CLI$_NEGATED 0X000381F8
X
Xint readable();
Xint uncc();
X
X#define INDENT 4
X#define MAXLEVEL 20
X#define CASE 3
X#define MASK 1
X#define COMMENTS 1
X#define PROTOTYPES 0
X#define SEPARATE 0
X#define VARIANTS 0
X
Xstatic FILE *outfile = 0;
Xstatic char out`5B256`5D;
Xstatic int maxlevel;
Xstatic char spaces`5BINDENT*MAXLEVEL+1`5D;
Xstatic int column;
Xstatic char *datatypes`5B`5D = `7B"int "/*void*/,"int *","char ","char ","ch
Var ",
X`09"char "/*decimal*/,"double float "/*dfloat*/,"float ",
X`09"double float "/*gfloat*/,"int "/*hfloat*/,"long int ",
X`09"int "/*octaword*/,"int "/*quadword*/,"unsigned ",
X`09"short int ","struct ","union ","int "/*anything*/,
X`09"int (*","DFLOAT_COMPLEX","FFLOAT_COMPLEX","GFLOAT_COMPLEX",
X`09"HFLOAT_COMPLEX"/* possibly, just guessing */ `7D;
X
Xstatic struct dsc$descriptor null =
X       `7B1,DSC$K_DTYPE_T,DSC$K_CLASS_S,"\0"`7D;
Xstatic struct dsc$descriptor cmd_prefix =
X       `7B8,DSC$K_DTYPE_T,DSC$K_CLASS_S,"UNSDLCC "`7D;
Xstatic struct dsc$descriptor command =
X`09`7B0,DSC$K_DTYPE_T,DSC$K_CLASS_D,0`7D;
Xstatic struct dsc$descriptor string =
X`09`7B0,DSC$K_DTYPE_T,DSC$K_CLASS_D,0`7D;
X
Xstatic struct Head *main_arg3;
Xstatic struct `7B
X    int indent;             /* number of spaces to indent per level */
X    unsigned outcase : 2;      /* 0=Original, 1=Natural, 2=Upper, 3=Lower */
X    unsigned mask : 1;      /* 0=decimal, 1=hex */
X    unsigned comments : 1;  /* 0=no comments, 1=comments */
X    unsigned separate : 1;  /* 0=don't separate, 1=do */
X    unsigned prototype : 1; /* 0=don't include prototypes, 1=do */
X    unsigned variant : 1;   /* 0=don't use variant_struct/union, 1=do */
X`7D options;
X
Xstruct ModuleName `7B
X  struct dsc$descriptor name;
X  struct ModuleName *next;
X`7D;
Xstatic struct ModuleName SelectModules;
X
Xsdl$output(outputname,module,root)
X  struct sptr *outputname, *module;
X  struct Head *root;
X`7B
X  struct Node *node;
X  char out`5B256`5D;
X  int status,i;
X  int four=4;
X  int five=5;
X  long int imagecount,imagecountsaved;
X  struct dsc$descriptor imagecnt =
X           `7B4,DSC$K_DTYPE_T,DSC$K_CLASS_S,&imagecount`7D;
X  struct itmlst jpi`5B2`5D = `7B`7B4,JPI$_IMAGECOUNT,&imagecount,0`7D,`7B0,0
V,0,0`7D`7D;
X  struct ModuleName *mod;
X
X  for (i=0; i < (INDENT*MAXLEVEL); i++)
X    spaces`5Bi`5D = ' ';
X  spaces`5Bi`5D = '\0';
X
X  options.indent = INDENT;
X  options.mask = MASK;
X  options.outcase = CASE;
X  options.comments = COMMENTS;
X  options.separate = SEPARATE;
X  options.prototype = PROTOTYPES;
X  options.variant = VARIANTS;
X
X  /* let's check for the symbol SDL_SYMBOL (defined in sdldef.h),
X     if it exists, we should set things up accordingly */
X  status = lib_get_symbol(SDL_SYMBOL,&string);
X  if (status & 1) `7B
X    /* pull out the first four bytes (the imagecount) and compare it
X       with our image count (make sure this isn't an old symbol */
X    /* well, get around to it eventually */
X    str$left(&imagecnt,&string,&four); /* numeric result in 'imagecount' */
X    str$right(&string,&string,&five);
X
X    /* save the image count (plus 1 for new image activation since unsdl) */
X    imagecountsaved = imagecount + 1;
X    /* get the real imagecount */
X    status = sys$getjpiw(0,0,0,&jpi,0,0,0);
X    if (!(status & 1)) return(status);
X    /* compare the imagecounts - should be equal */
X    if (imagecount == imagecountsaved) `7B
X      /* prefix command string with command */
X      str$copy_dx(&command,&cmd_prefix);
X      str$append(&command,&string);
X
X      /* need to parse the string */
X      status = cli$dcl_parse(&command,uncc);
X      if (!(status & 1))
X        return;
X
X      if (cli_get_value("P1.INDENT",&string) & 1) `7B
X        str$append(&string,&null);
X        options.indent = atoi(string.dsc$a_pointer);
X      `7D;
X
X      if (cli_present("P1.MASK.DECIMAL") & 1) options.mask = 0;
X      if (cli_present("P1.MASK.HEX") & 1) options.mask = 1;
X      if (cli_present("P1.CASE.ORIGINAL") & 1) options.outcase = 0;
X      if (cli_present("P1.CASE.MIXED") & 1) options.outcase = 1;
X      if (cli_present("P1.CASE.UPPER") & 1) options.outcase = 2;
X      if (cli_present("P1.CASE.LOWER") & 1) options.outcase = 3;
X      status = cli_present("P1.COMMENTS");
X      if (status & 1) options.comments = 1;
X      if (status == CLI$_NEGATED) options.comments = 0;
X      if (cli_present("P1.PROTOTYPES") & 1) options.prototype = 1;
X      if (cli_present("P1.VARIANTS") & 1) options.variant = 1;
X      if (cli_present("P1.SEPARATE") & 1) options.separate = 1;
X      if (cli_present("P1.MODULES") & 1) `7B
X        mod = &SelectModules;
X        while (cli_get_value("P1.MODULES",&string) & 1) `7B
X          mod->next = calloc(1,sizeof(struct ModuleName));
X`09  mod = mod->next;
X          mod->name = string;
X          string.dsc$w_length = 0;
X          string.dsc$a_pointer = 0;
X        `7D
X      `7D
X    `7D
X  `7D
X
X  maxlevel = (INDENT*MAXLEVEL) / ((options.indent == 0)?1:options.indent);
X
X  printf("Source: %.*s\n",root->banner_len,root->banner);
X
X  if (options.separate == 0) `7B
X    /* get outputname copied into local space, so I can add a zero to it. */
X    for (i=0; (i < outputname->len) && (outputname->str`5Bi`5D != ' '); i++)
X      out`5Bi`5D = outputname->str`5Bi`5D;
X    out`5Bi`5D = '\0';
X    /* if no output file name present, use module name. */
X    if (i==0) `7B
X      for (i=0; (i < module->len) && (module->str`5Bi`5D != ' '); i++)
X        out`5Bi`5D = module->str`5Bi`5D;
X      out`5Bi`5D = '.';
X      out`5Bi+1`5D = 'S';
X      out`5Bi+2`5D = 'I';
X      out`5Bi+3`5D = '\0';
X    `7D;
X    printf("Creating file %s\n",out);
X    outfile = fopen(out,"w","rfm=var","rat=cr");
X    fprintf(outfile,";;; Created by SDL %.*s -*- scheme -*- \n",
X`09    10,root->version);
X    fprintf(outfile,";;; Source: %.*s\n",root->banner_len,root->banner);
X    out`5Bi`5D = '_';
X    column = 1;
X  `7D;
X  main_arg3 = root;
X
X  node = root->head;
X  if ((readable(node)) && (node->type == SDL$C_NODE_ROOT)) `7B
X    if (readable(node->flink))
X      traverse_modules(node->flink); /* this should be the root node */
X    else
X      printf("INTERNAL ERROR, ROOT NODE FORWARD POINTER CORRUPT\n");
X    `7D
X  else
X    printf("INTERNAL ERROR, ROOT NODE CORRUPT\n");
X
X  fclose(outfile);
X
X  /* should reset the dcl parse tables somehow... */
X  /* but since that is imposible, the local tables include 'infile' */
X`7D
X
Xtraverse_modules(node)
X  struct Node *node;`20
X`7B
X  while (node->type == SDL$C_NODE_MODULE) `7B
X    printf("Reading module %.*s\n",node->name.len,node->name.str);
X    if (check_module(node)) `7B
X      setcase(node,1);
X      if (options.separate == 1) `7B
X        if (outfile) `7B
X          fclose(outfile);
X        `7D;
X        sprintf(out,"%.*s.H",node->name.len,node->name.str);
X        outfile = fopen(out,"w","rfm=var","rat=cr");
X
X        printf("Creating file %s\n",out);
X        fprintf(outfile,";;; Created by SDL %.*s\n",
X`09`0910,main_arg3->version);
X        fprintf(outfile,";;; Source: %.*s\n",
X`09`09main_arg3->banner_len,main_arg3->banner);
X      `7D;
X      fprintf(outfile," \n");
X      fprintf(outfile,";;; * MODULE %.*s * \n",node->name.len,node->name.str
V);
X      column = 1;
X      if (node->comment) `7B
X        print_comment(node);
X      `7D;
X      if (readable(node->child))
X        traverse_module(node->child,0);
X      else `7B
X        printf("INTERNAL ERROR, MODULE NODES CHILD POINTER CORRUPT\n");
X        printf("MODULE NOT BEING PROCESSED\n");
X      `7D;
X    `7D;
X    node = node->flink;
X    if (!readable(node)) `7B
X      printf("INTERNAL ERROR, MODULE NODE FORWARD POINTER CORRUPT\n");
X      printf("ABORTING\n");
X      return;
X    `7D;
X  `7D;
X`7D
X
Xtraverse_module(node,level)
X  struct Node *node;
X  int level;
X`7B
X  /* the first node should always be a head node, let's verify that
X     and then move forward. Note that we then simply loop until we
X     get back to the head node again */
X  if (node->type == SDL$C_NODE_HEAD) `7B
X    node = node->flink;
X    while(readable(node) && (node->type != SDL$C_NODE_HEAD)) `7B
X      print_module(node,level);
X      node = node->flink;
X    `7D;
X    if (!readable(node))
X      printf("INTERNAL ERROR, FORWARD POINTER CORRUPT\n");
X  `7D
X  else
X    printf("INTERNAL ERROR, NODE NOT A HEAD NODE\n");
X`7D
X
Xprint_module(node,level)
X  struct Node *node;
X  int level;
X`7B
X  column = 1;
X  switch (node->type) `7B
X    case SDL$C_NODE_COMMENT:
X      setcase(node,0);
X      if (options.comments) `7B
X        print_comment(node);
X      `7D;
X      break;
X    case SDL$C_NODE_CONSTANT:
X      setcase(node,1);
X      column += fprintf(outfile,"(define ");
X      print_name(node);
X      column += fprintf(outfile," ");
X      if (node->sdl_flag_bits.flag.m_mask && options.mask)
X        column += fprintf(outfile,"#x%08X",node->typeinfo);
X      else
X        column += fprintf(outfile,"%d",node->typeinfo);
X      column += fprintf (outfile, ")");
X      print_comment(node);
X      if (column != 1)
X`09newline ();
X      break;
X    case SDL$C_NODE_ENTRY:
X      setcase(node,-1);
X      column += fprintf (outfile, "(define-foreign ");
X      print_name (node);`09/* internal name */
X      newline ();
X      column += fprintf (outfile, " (");
X      print_name (node);`09/* external name */
X      column += fprintf(outfile," ");
X      print_datatype(node);
X      newline ();
X
X      if (node->child) `7B`09/* any arguments? */
X`09column += fprintf (outfile, " ");
X`09print_comment(node);
X`09column = 1;
X`09if (readable(node->child))
X`09  print_prototype(node->child);
X`09else `7B
X`09  printf("INTERNAL ERROR, ENTRY NODE CHILD POINTER CORRUPT\n");
X`09  fprintf(outfile,
X`09`09  ";;; INTERNAL ERROR, UNABLE TO INCLUDE PROTOTYPE\n");
X`09  column = 1;
X`09`7D
X`09column += fprintf(outfile,"%.*s))",options.indent,spaces);
X      `7D
X      else `7B`09`09`09/* if not, just display the rest of line */
X`09column += fprintf(outfile,"))");
X`09print_comment(node);
X      `7D
X      newline();
X      break;
X    case SDL$C_NODE_ITEM:
X      print_item(node,level);
X      break;
X  `7D;
X`7D
X
Xprint_item(node,level)
X  struct Node *node;
X  int level;
X`7B
X  setcase(node,-1);
X  if (level > maxlevel)
X    level = maxlevel;
X  column += fprintf(outfile,"%.*s",level*options.indent,spaces);
X  column += fprintf (outfile, ";??? unhandled item: ");
X  print_name (node);
X  column += fprintf (outfile, " ");
X  print_datatype (node);
X  print_comment (node);
X  if (column != 1)
X    newline ();
X#if 0
X  switch (node->datatype) `7B
X    case SDL$C_TYPE_STRUCTURE:
X    case SDL$C_TYPE_UNION:
X      if (level==0) `7B
X        print_name(node);
X        column += fprintf(outfile," ");
X      `7D;
X      if ((level==0) && (node->sdl_flag_bits.flag.m_based) && (node->typeinf
Vo))
X        column += fprintf(outfile," /* WARNING: aggregate has origin of %d *
V/",
X`09`09node->typeinfo);
X      print_comment(node);
X      column = 1;
X      if (readable(node->child))
X        traverse_module(node->child,level+1);
X      else
X        printf("INTERNAL ERROR, ITEM NODE CHILD POINTER CORRUPT\n");
X      if (level > 0) `7B
X        column += fprintf(outfile,"%.*s`7D ",(level+1)*options.indent,spaces
V);
X        print_name(node);
X        column += fprintf(outfile,";");
X        newline();
X      `7D
X      else `7B
X        column += fprintf(outfile,"%.*s`7D ;",level*options.indent,spaces);
X        newline();
X      `7D
X      break;
X    default:
X      print_name(node);
X      print_postdatatype(node);
X      column += fprintf(outfile,";");
X      print_comment(node);
X      break;
X  `7D
X#endif
X`7D
X
Xprint_comment(node)
X  struct Node *node;
X`7B
X  struct sptr *ptr;
X  char *c;
X  int l,x;
X `20
X  if (node->comment && options.comments) `7B
X    /* print leading space if not at start of line */
X    if (column > 1)
X      column += fprintf(outfile," ");
X
X    /* print white space up to next tab */
X    x = 8 - ((column - 1) % 8);
X    if (x == 8)
X      x = 0;
X    if (x)
X      column += fprintf(outfile,"%.*s",x,spaces);
X         `20
X    ptr = node->comment;
X
X    column += fprintf(outfile,"; ");
X    c = ptr->str;
X    l = ptr->len;
X    for (x = 0;(x < l) && (c`5Bx`5D != '\t');++x);
X    while (c`5Bx`5D == '\t') `7B
X      column += fprintf(outfile,"%.*s",x,c);
X      ++x;
X      c += x;
X      l -= x;
X      /* print white space up to next tab */
X      x = 8 - ((column - 1) % 8);
X      if (x == 8)
X        x = 0;
X      if (x)
X        column += fprintf(outfile,"%.*s",x,spaces);
X      for (x = 0;(x < l) && (c`5Bx`5D != '\t');++x);
X    `7D;
X    column += fprintf(outfile,"%.*s",x,c);
X
X    x = 79 - column; /* pad to 80 columns if possible */
X    if (x < 0) `7B
X      x = 8 - ((column + 1) % 8); /* pad to next tab if over 80 chars */
X      if (x == 8)
X        x = 0;
X    `7D;
X    column += fprintf(outfile,"%.*s",x,spaces);
X
X    fputc ('\n', outfile); column = 1;
X  `7D;
X`7D
X
Xprint_name(node)
X  struct Node *node;
X`7B
X  column += fprintf(outfile,"%.*s",node->name.len,node->name.str);
X`7D
X
X
Xprint_datatype (node)
X     struct Node *node;
X`7B
X  static char *datatype_names`5B`5D = `7B
X    "unknown",
X    "ADDRESS",
X    "BYTE",
X    "CHARACTER",
X    "BOOLEAN",
X    "DECIMAL",
X    "DFLOAT",
X    "FFLOAT",
X    "GFLOAT",
X    "HFLOAT",
X    "LONGWORD",
X    "OCTAWORD",
X    "QUADWORD",
X    "BITFIELD",
X    "WORD",
X    "STRUCTURE",
X    "UNION",
X    "ANY",
X    "ENTRY",
X    "DFLOAT_COMPLEX",
X    "FFLOAT_COMPLEX",
X    "GFLOAT_COMPLEX",
X    "HFLOAT_COMPLEX",`20
X  `7D;
X  int i = node->datatype;
X  column += fprintf (outfile, "%s",
X`09`09     datatype_names `5B(((i >= SDL$C_TYPE_ADDRESS)
X`09`09`09`09       && (i <= SDL$C_TYPE_HFLOAT_COMPLEX))
X`09`09`09`09      ? i : 0)`5D);
X`7D
X
Xprint_predatatype(node, level)
X  struct Node *node;
X  int level;
X`7B
X  static char tmpname`5B9`5D = "        ";
X  static int tmpindx = -1;
X  int i;
X
X  if (node->sdl_flag_bits.flag.m_unsigned)
X    column += fprintf(outfile,"unsigned ");
X
X  switch (node->datatype) `7B
X    case SDL$C_TYPE_HFLOAT:
X    case SDL$C_TYPE_OCTAWORD:
X      for (i=0; (i < 8) && (i < node->name.len); i++) `7B
X        if (tmpname`5Bi`5D != node->name.str`5Bi`5D)
X          tmpindx = -1;
X        tmpname`5Bi`5D = node->name.str`5Bi`5D;
X      `7D;
X      ++tmpindx;
X      tmpname`5Bi`5D = '\0';
X      column += fprintf(outfile,"struct `7Bint %s$$ret_%d_ `5B4`5D;`7D ",
X`09`09tmpname,tmpindx);
X      /* hmm, the above name is used by the VWS SDLCC for ENTRY nodes,
X         I need to find an example in an ITEM node and see if they do it
X         any differently.. Probably they change the "ret" to something else
X      */
X      break;
X    case SDL$C_TYPE_STRUCTURE:
X    case SDL$C_TYPE_UNION:
X      if ((options.variant) && (level > 0))
X        column += fprintf(outfile,"variant_");
X      column += fprintf(outfile,"%s",datatypes`5Bnode->datatype`5D);
X      break;
X    default:
X      column += fprintf(outfile,"%s",datatypes`5Bnode->datatype`5D);
X      break;
X  `7D;
X`7D
X
Xprint_postdatatype(node)
X  struct Node *node;
X`7B
X  switch(node->datatype) `7B
X    case SDL$C_TYPE_BITFIELD:
X      column += fprintf(outfile," : %d",node->fldsiz);
X      break;
X    case SDL$C_TYPE_DECIMAL:
X      /* I don't know how to do this, I have seen no uses of it yet.
X         I would think I need to use node->size or (hidim-lodim)/2 or
X         something along those lines. */
X      column += fprintf(outfile," `5B%d`5D",node->size);
X      break;
X    case SDL$C_TYPE_QUADWORD:
X      column += fprintf(outfile," `5B2`5D");
X      break;
X    case SDL$C_TYPE_OCTAWORD:
X      column += fprintf(outfile," `5B4`5D");
X      break;
X    case SDL$C_TYPE_STRUCTURE:
X    case SDL$C_TYPE_UNION:
X      column += fprintf(outfile,"`7B");
X      break;
X    case SDL$C_TYPE_ENTRY:
X      column += fprintf(outfile,")()");
X      break;
X  `7D;
X  if (node->sdl_flag_bits.flag.m_dimen)
X    column += fprintf(outfile," `5B%d`5D",node->hidim - node->lodim + 1);
X
X  if (node->datatype == SDL$C_TYPE_CHARACTER) `7B
X    if (node->typeinfo == 0)
X      column += fprintf(outfile," `5B`5D");
X    else
X      if (node->typeinfo > 1)
X        column += fprintf(outfile," `5B%d`5D",node->typeinfo);
X  `7D;
X`7D
X
Xcheck_module(node)
X  struct Node *node;
X`7B
X  static char symbol_name`5B80`5D;
X  static struct dsc$descriptor module =
X`09`7B0,DSC$K_DTYPE_T,DSC$K_CLASS_S,0`7D;
X  static struct dsc$descriptor string = `7B0,DSC$K_DTYPE_T,DSC$K_CLASS_D,0`7
VD;
X  struct ModuleName *mod;
X  int found = 0, i = 0;
X
X  if ((mod = SelectModules.next) == 0)
X    return(1);
X
X  module.dsc$w_length = node->name.len;
X  module.dsc$a_pointer = node->name.str;
X  /* this needs to loop through all the modules and see if one matches */
X  while (mod && !found) `7B
X    found = str$match_wild(&module,&(mod->name)) & 1;
X    mod = mod->next;
X  `7D;
X  return(found);
X`7D
X
Xprint_prototype(node)
X  struct Node *node;
X`7B
X  int firstparam = 1, firstopt = 1;
X
X  if (node->type == SDL$C_NODE_HEAD) `7B
X    node = node->flink;
X    while(readable(node) && (node->type != SDL$C_NODE_HEAD)) `7B
X      if (!firstparam)
X`09column += fprintf (outfile, " ");
X      print_parameter(node,0);
X      node = node->flink;
X      firstparam = 0;
X    `7D;
X    if (!readable(node))
X      printf("INTERNAL ERROR, FORWARD POINTER CORRUPT\n");
X  `7D
X  else
X    printf("INTERNAL ERROR, NODE NOT A HEAD NODE\n");
X`7D;
X
Xcheck_if_args_optional(node)
X  struct Node *node;
X`7B /* this function check if this node and all further parameter
X     nodes are optional, if so, it returns a 1, if not, it returns
X     a 0 */
X  int optional = 1;
X
X  while(readable(node) && (node->type != SDL$C_NODE_HEAD) && optional) `7B
X    optional = node->sdl_flag_bits.flag.m_optional;
X    node = node->flink;
X  `7D;
X  if (!readable(node))
X    printf("INTERNAL ERROR, FORWARD POINTER CORRUPT\n");
X  return(optional);
X`7D
X
Xprint_parameter(node,commented)
X  struct Node *node;
X  int commented;
X`7B
X  setcase(node,-1);
X  column += fprintf(outfile,"%.*s",options.indent,spaces);
X
X  if (commented)
X    column += fprintf(outfile,";; ");
X
X  column += fprintf (outfile, "(");
X
X  /* parameter name: required */
X  print_name (node);
X  column += fprintf (outfile, " ");
X
X  /* parameter type: required */
X  print_datatype(node);
X
X  /* parameter access: required */
X  if ((node->sdl_flag_bits.flag.m_in) && (node->sdl_flag_bits.flag.m_out))
X    column += fprintf(outfile," in-out");
X  else if (node->sdl_flag_bits.flag.m_in)
X    column += fprintf (outfile, " in");
X  else if (node->sdl_flag_bits.flag.m_out)
X    column += fprintf (outfile, " out");
X  else
X    column += fprintf (outfile, " not-in-or-out");
X
X  /* parameter passing mechanism: required */
X  if (node->sdl_flag_bits.flag.m_value)
X    column += fprintf (outfile, " value");
X  else`09`09`09`09/* must be passed by ref. */
X    column += fprintf(outfile," ref");
X
X  /* optional modifiers, may not be present */
X  if ((node->sdl_flag_bits.flag.m_descriptor)
X      `7C`7C (node->sdl_flag_bits.flag.m_rtl_str_desc))
X    column += fprintf(outfile," descriptor");
X
X  if (node->sdl_flag_bits.flag.m_optional)
X    column += fprintf (outfile, " optional");
X
X  column += fprintf (outfile, ")\n"); column = 1;
X
X#if 0
X  if ((node->flink)->type != SDL$C_NODE_HEAD)
X    column += fprintf(outfile," ");
X
X  if (commented)
X    `7B
X      column += fprintf(outfile,"\n");
X      column = 1;
X    `7D
X#endif
X  print_comment(node);
X
X`7D
X
Xsetcase(node,casetype)
X  struct Node *node;
X  int casetype;
X`7B
X  char *p = node->name.str;
X  int i;
X
X  switch (options.outcase)
X  `7B
X    case 0:
X      casetype = 0;
X      break;
X    case 1:
X      break;
X    case 2:
X      casetype = 1;
X      break;
X    case 3:
X      casetype = -1;
X      break;
X  `7D
X
X  switch (casetype)
X  `7B
X    case 1: /* uppercase name */
X      for (i = 0; i < node->name.len; i++, p++)
X        if (islower(*p)) *p = toupper(*p);
X      break;
X    case -1: /* lowercase name */
X      for (i = 0; i < node->name.len; i++, p++)
X        if (isupper(*p)) *p = tolower(*p);
X      break;
X  `7D; `20
X`7D
X
Xnewline()
X`7B
X  fprintf(outfile,"\n"); column = 1;
X`7D
$ CALL UNPACK SDLSCM.C;32 1886552763
$ create 'f'
X;;; Created by SDL V3.1-7     -*- scheme -*-`20
X;;; Source: 23-MAR-1993 09:24:45 MPL$DATA:`5BMPL.TKB.UNSDL.X`5DSMG$ROUTINES.
VSDI;1
X`20
X;;; * MODULE smg$routines *`20
X(define-foreign smg$add_key_def
X (smg$add_key_def LONGWORD
X     (key_table_id LONGWORD in ref)
X     (key_name CHARACTER in ref descriptor)
X     (if_state CHARACTER in ref descriptor optional)
X     (attributes LONGWORD in ref optional)
X     (equivalence_string CHARACTER in ref descriptor optional)
X     (state_string CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$allow_escape
X (smg$allow_escape LONGWORD
X     (display_id LONGWORD in ref)
X     (flags LONGWORD in ref)
X    ))
X(define-foreign smg$begin_display_update
X (smg$begin_display_update LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$begin_pasteboard_update
X (smg$begin_pasteboard_update LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$cancel_input
X (smg$cancel_input LONGWORD
X     (keyboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$cursor_column
X (smg$cursor_column LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$check_for_occlusion
X (smg$check_for_occlusion LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X     (occlusion_state LONGWORD out ref)
X    ))
X(define-foreign smg$change_viewport
X (smg$change_viewport LONGWORD
X     (display_id LONGWORD in ref)
X     (viewport_row_start LONGWORD in ref optional)
X     (viewport_column_start LONGWORD in ref optional)
X     (viewport_number_rows LONGWORD in ref optional)
X     (viewport_number_columns LONGWORD in ref optional)
X    ))
X(define-foreign smg$create_key_table
X (smg$create_key_table LONGWORD
X     (key_table_id LONGWORD out ref)
X    ))
X(define-foreign smg$create_menu
X (smg$create_menu LONGWORD
X     (display_id LONGWORD in ref)
X     (choices CHARACTER in ref descriptor)
X     (menu_type LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (row LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$control_mode
X (smg$control_mode LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (new_mode LONGWORD in ref optional)
X     (old_mode LONGWORD out ref optional)
X     (buffer_size WORD in ref optional)
X    ))
X(define-foreign smg$copy_virtual_display
X (smg$copy_virtual_display LONGWORD
X     (current_display_id LONGWORD in ref)
X     (new_display_id LONGWORD out ref)
X    ))
X(define-foreign smg$create_pasteboard
X (smg$create_pasteboard LONGWORD
X     (pasteboard_id LONGWORD out ref)
X     (output_device CHARACTER in ref descriptor optional)
X     (number_of_pasteboard_rows LONGWORD out ref optional)
X     (number_of_pasteboard_columns LONGWORD out ref optional)
X     (flags LONGWORD in ref optional)
X     (type_of_terminal LONGWORD out ref optional)
X    ))
X(define-foreign smg$change_pbd_characteristics
X (smg$change_pbd_characteristics LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (desired_width LONGWORD in ref optional)
X     (width LONGWORD out ref optional)
X     (desired_height LONGWORD in ref optional)
X     (height LONGWORD out ref optional)
X     (desired_background_color LONGWORD in ref optional)
X     (background_color LONGWORD out ref optional)
X    ))
X(define-foreign smg$change_rendition
X (smg$change_rendition LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X     (number_of_rows LONGWORD in ref)
X     (number_of_columns LONGWORD in ref)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$cursor_row
X (smg$cursor_row LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$create_subprocess
X (smg$create_subprocess LONGWORD
X     (display_id LONGWORD in ref)
X     (ast_routine ADDRESS in value optional)
X     (ast_argument LONGWORD in value optional)
X    ))
X(define-foreign smg$create_virtual_display
X (smg$create_virtual_display LONGWORD
X     (number_of_rows LONGWORD in ref)
X     (number_of_columns LONGWORD in ref)
X     (display_id LONGWORD out ref)
X     (display_attributes LONGWORD in ref optional)
X     (video_attributes LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$change_virtual_display
X (smg$change_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (number_of_rows LONGWORD in ref optional)
X     (number_of_columns LONGWORD in ref optional)
X     (display_attributes LONGWORD in ref optional)
X     (video_attributes LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$create_virtual_keyboard
X (smg$create_virtual_keyboard LONGWORD
X     (keyboard_id LONGWORD out ref)
X     (input_device CHARACTER in ref descriptor optional)
X     (default_filespec CHARACTER in ref descriptor optional)
X     (resultant_filespec CHARACTER out ref descriptor optional)
X     (recall_size BYTE in ref optional)
X    ))
X(define-foreign smg$create_viewport
X (smg$create_viewport LONGWORD
X     (display_id LONGWORD in ref)
X     (viewport_row_start LONGWORD in ref)
X     (viewport_column_start LONGWORD in ref)
X     (viewport_number_rows LONGWORD in ref)
X     (viewport_number_columns LONGWORD in ref)
X    ))
X(define-foreign smg$delete_chars
X (smg$delete_chars LONGWORD
X     (display_id LONGWORD in ref)
X     (number_of_characters LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X    ))
X(define-foreign smg$define_key
X (smg$define_key LONGWORD
X     (key_table_id LONGWORD in ref)
X     (command_string CHARACTER in ref descriptor)
X    ))
X(define-foreign smg$disable_broadcast_trapping
X (smg$disable_broadcast_trapping LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$disable_unsolicited_input
X (smg$disable_unsolicited_input LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$delete_key_def
X (smg$delete_key_def LONGWORD
X     (key_table_id LONGWORD in ref)
X     (key_name CHARACTER in ref descriptor)
X     (if_state CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$delete_line
X (smg$delete_line LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (number_of_rows LONGWORD in ref optional)
X    ))
X(define-foreign smg$delete_menu
X (smg$delete_menu LONGWORD
X     (display_id LONGWORD in ref)
X     (flags LONGWORD in ref optional)
X    ))
X(define-foreign smg$delete_pasteboard
X (smg$delete_pasteboard LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (flags LONGWORD in ref optional)
X    ))
X(define-foreign smg$draw_char
X (smg$draw_char LONGWORD
X     (display_id LONGWORD in ref)
X     (flags LONGWORD in ref)
X     (row LONGWORD in ref optional)
X     (column LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$draw_line
X (smg$draw_line LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X     (end_row LONGWORD in ref)
X     (end_column LONGWORD in ref)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$draw_rectangle
X (smg$draw_rectangle LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X     (end_row LONGWORD in ref)
X     (end_column LONGWORD in ref)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$delete_subprocess
X (smg$delete_subprocess LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$del_term_table
X (smg$del_term_table LONGWORD
X))
X(define-foreign smg$delete_virtual_display
X (smg$delete_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$delete_virtual_keyboard
X (smg$delete_virtual_keyboard LONGWORD
X     (keyboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$delete_viewport
X (smg$delete_viewport LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$erase_chars
X (smg$erase_chars LONGWORD
X     (display_id LONGWORD in ref)
X     (number_of_characters LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X    ))
X(define-foreign smg$end_display_update
X (smg$end_display_update LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$end_pasteboard_update
X (smg$end_pasteboard_update LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$enable_unsolicited_input
X (smg$enable_unsolicited_input LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (ast_routine ADDRESS in value)
X     (ast_argument LONGWORD in value optional)
X    ))
X(define-foreign smg$erase_column
X (smg$erase_column LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (column_number LONGWORD in ref optional)
X     (end_row LONGWORD in ref optional)
X    ))
X(define-foreign smg$erase_display
X (smg$erase_display LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (end_row LONGWORD in ref optional)
X     (end_column LONGWORD in ref optional)
X    ))
X(define-foreign smg$erase_line
X (smg$erase_line LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X    ))
X(define-foreign smg$erase_pasteboard
X (smg$erase_pasteboard LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$execute_command
X (smg$execute_command LONGWORD
X     (display_id LONGWORD in ref)
X     (command_desc CHARACTER in ref descriptor)
X     (flags LONGWORD in ref optional)
X     (ret_status LONGWORD out ref optional)
X    ))
X(define-foreign smg$find_cursor_display
X (smg$find_cursor_display LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (display_id LONGWORD out ref)
X     (pasteboard_row LONGWORD in ref optional)
X     (pasteboard_column LONGWORD in ref optional)
X    ))
X(define-foreign smg$flush_buffer
X (smg$flush_buffer LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$get_broadcast_message
X (smg$get_broadcast_message LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (message CHARACTER out ref descriptor optional)
X     (message_length WORD out ref optional)
X     (message_type WORD out ref optional)
X    ))
X(define-foreign smg$get_char_at_physical_cursor
X (smg$get_char_at_physical_cursor LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (character_code BYTE out ref)
X    ))
X(define-foreign smg$get_display_attr
X (smg$get_display_attr LONGWORD
X     (display_id LONGWORD in ref)
X     (height LONGWORD out ref optional)
X     (width LONGWORD out ref optional)
X     (display_attributes LONGWORD out ref optional)
X     (video_attributes LONGWORD out ref optional)
X     (character_set LONGWORD in ref optional)
X     (flags LONGWORD out ref optional)
X    ))
X(define-foreign smg$get_keyboard_attributes
X (smg$get_keyboard_attributes LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (p_kit ADDRESS out ref)
X     (p_kit_size LONGWORD in ref)
X    ))
X(define-foreign smg$get_key_def
X (smg$get_key_def LONGWORD
X     (key_table_id LONGWORD in ref)
X     (key_name CHARACTER in ref descriptor)
X     (if_state CHARACTER in ref descriptor optional)
X     (attributes LONGWORD out ref optional)
X     (equivalence_string CHARACTER out ref descriptor optional)
X     (state_string CHARACTER out ref descriptor optional)
X    ))
X(define-foreign smg$get_numeric_data
X (smg$get_numeric_data LONGWORD
X     (termtable_address ADDRESS in ref)
X     (request_code LONGWORD in ref)
X     (buffer_address ADDRESS out ref)
X    ))
X(define-foreign smg$get_pasting_info
X (smg$get_pasting_info LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X     (flags LONGWORD out ref optional)
X     (pasteboard_row LONGWORD out ref optional)
X     (pasteboard_column LONGWORD out ref optional)
X    ))
X(define-foreign smg$get_pasteboard_attributes
X (smg$get_pasteboard_attributes LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (pasteboard_info_table ANY out ref)
X     (pasteboard_info_table_size LONGWORD in ref)
X    ))
X(define-foreign smg$get_term_data
X (smg$get_term_data LONGWORD
X     (termtable_address ADDRESS in ref)
X     (request_code LONGWORD in ref)
X     (maximum_buffer_length LONGWORD in ref)
X     (return_length LONGWORD out ref)
X     (buffer_address ADDRESS out ref)
X     (input_argument_vector LONGWORD in ref optional)
X    ))
X(define-foreign smg$get_viewport_char
X (smg$get_viewport_char LONGWORD
X     (display_id LONGWORD in ref)
X     (viewport_row_start LONGWORD out ref optional)
X     (viewport_column_start LONGWORD out ref optional)
X     (viewport_number_rows LONGWORD out ref optional)
X     (viewport_number_columns LONGWORD out ref optional)
X    ))
X(define-foreign smg$home_cursor
X (smg$home_cursor LONGWORD
X     (display_id LONGWORD in ref)
X     (position_code LONGWORD in ref optional)
X    ))
X(define-foreign smg$init_term_table
X (smg$init_term_table LONGWORD
X     (terminal_name CHARACTER in ref descriptor)
X     (termtable_address ADDRESS out ref)
X    ))
X(define-foreign smg$insert_chars
X (smg$insert_chars LONGWORD
X     (display_id LONGWORD in ref)
X     (character_string CHARACTER in ref descriptor)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$insert_line
X (smg$insert_line LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (character_string CHARACTER in ref descriptor optional)
X     (direction LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$init_term_table_by_type
X (smg$init_term_table_by_type LONGWORD
X     (terminal_type BYTE in ref)
X     (termtable_address ADDRESS out ref)
X     (terminal_name CHARACTER out ref descriptor optional)
X    ))
X(define-foreign smg$invalidate_display
X (smg$invalidate_display LONGWORD
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$keycode_to_name
X (smg$keycode_to_name LONGWORD
X     (key_code WORD in ref)
X     (key_name CHARACTER out ref descriptor)
X    ))
X(define-foreign smg$label_border
X (smg$label_border LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor optional)
X     (position_code LONGWORD in ref optional)
X     (units LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$load_key_defs
X (smg$load_key_defs LONGWORD
X     (key_table_id LONGWORD in ref)
X     (filespec CHARACTER in ref descriptor)
X     (default_filespec CHARACTER in ref descriptor optional)
X     (flags LONGWORD in ref optional)
X    ))
X(define-foreign smg$list_key_defs
X (smg$list_key_defs LONGWORD
X     (key_table_id LONGWORD in ref)
X     (context LONGWORD in-out ref)
X     (key_name CHARACTER in-out ref descriptor optional)
X     (if_state CHARACTER out ref descriptor optional)
X     (attributes LONGWORD out ref optional)
X     (equivalence_string CHARACTER out ref descriptor optional)
X     (state_string CHARACTER out ref descriptor optional)
X    ))
X(define-foreign smg$list_pasting_order
X (smg$list_pasting_order LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (context LONGWORD in-out ref)
X     (display_id LONGWORD out ref)
X     (pasteboard_row LONGWORD out ref optional)
X     (pasteboard_column LONGWORD out ref optional)
X    ))
X(define-foreign smg$load_virtual_display
X (smg$load_virtual_display LONGWORD
X     (display_id LONGWORD out ref)
X     (filespec CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$move_virtual_display
X (smg$move_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X     (pasteboard_row LONGWORD in ref)
X     (pasteboard_column LONGWORD in ref)
X     (top_display_id LONGWORD in ref optional)
X    ))
X(define-foreign smg$move_text
X (smg$move_text LONGWORD
X     (display_id LONGWORD in ref)
X     (top_left_row LONGWORD in ref)
X     (top_left_column LONGWORD in ref)
X     (bottom_right_row LONGWORD in ref)
X     (bottom_right_column LONGWORD in ref)
X     (display_id2 LONGWORD in ref)
X     (top_left_row2 LONGWORD in ref optional)
X     (top_left_column2 LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X    ))
X(define-foreign smg$name_to_keycode
X (smg$name_to_keycode LONGWORD
X     (key_name CHARACTER in ref descriptor)
X     (key_code WORD out ref)
X    ))
X(define-foreign smg$paste_virtual_display
X (smg$paste_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X     (pasteboard_row LONGWORD in ref)
X     (pasteboard_column LONGWORD in ref)
X     (top_display_id LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_chars
X (smg$put_chars LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_chars_highwide
X (smg$put_chars_highwide LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_chars_multi
X (smg$put_chars_multi LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (line_number LONGWORD in ref optional)
X     (column_number LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_chars_wide
X (smg$put_chars_wide LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_help_text
X (smg$put_help_text LONGWORD
X     (display_id LONGWORD in ref)
X     (keyboard_id LONGWORD in ref optional)
X     (help_topic CHARACTER in ref descriptor optional)
X     (help_library CHARACTER in ref descriptor optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_line
X (smg$put_line LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (line_advance LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X     (direction LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_line_highwide
X (smg$put_line_highwide LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (line_advance LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_line_multi
X (smg$put_line_multi LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (rendition_set LONGWORD in ref optional) ;???
X     (rendition_complement LONGWORD in ref optional)
X     (line_advance LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (direction LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_line_wide
X (smg$put_line_wide LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X     (line_advance LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$pop_virtual_display
X (smg$pop_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$put_pasteboard
X (smg$put_pasteboard LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (action_routine ADDRESS in value)
X     (user_argument ANY in value)
X     (flags LONGWORD in ref)
X    ))
X(define-foreign smg$print_pasteboard
X (smg$print_pasteboard LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (queue_name CHARACTER in ref descriptor optional)
X     (copies LONGWORD in ref optional)
X     (form_name CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$put_status_line
X (smg$put_status_line LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor)
X    ))
X(define-foreign smg$put_virtual_display_encoded
X (smg$put_virtual_display_encoded LONGWORD
X     (display_id LONGWORD in ref)
X     (encoded_length LONGWORD in ref)
X     (encoded_text ANY in ref)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (placeholder_argument LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$put_with_scroll
X (smg$put_with_scroll LONGWORD
X     (display_id LONGWORD in ref)
X     (text CHARACTER in ref descriptor optional)
X     (direction LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (character_set LONGWORD in ref optional)
X    ))
X(define-foreign smg$ring_bell
X (smg$ring_bell LONGWORD
X     (display_id LONGWORD in ref)
X     (number_of_times LONGWORD in ref optional)
X    ))
X(define-foreign smg$read_composed_line
X (smg$read_composed_line LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (key_table_id LONGWORD in ref)
X     (resultant_string CHARACTER out ref descriptor)
X     (prompt_string CHARACTER in ref descriptor optional)
X     (resultant_length WORD out ref optional)
X     (display_id LONGWORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (initial_string CHARACTER in ref descriptor optional)
X     (timeout LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (word_terminator_code WORD out ref optional)
X    ))
X(define-foreign smg$remove_line
X (smg$remove_line LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (start_column LONGWORD in ref)
X     (end_row LONGWORD in ref)
X     (end_column LONGWORD in ref)
X    ))
X(define-foreign smg$replace_input_line
X (smg$replace_input_line LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (replace_string CHARACTER in ref descriptor optional)
X     (line_count BYTE in ref optional)
X    ))
X(define-foreign smg$return_input_line
X (smg$return_input_line LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (resultant_string CHARACTER out ref descriptor)
X     (match_string CHARACTER in ref descriptor optional)
X     (byte_integer_line_number BYTE in ref optional)
X     (resultant_length WORD out ref optional)
X    ))
X(define-foreign smg$read_from_display
X (smg$read_from_display LONGWORD
X     (display_id LONGWORD in ref)
X     (resultant_string CHARACTER out ref descriptor)
X     (terminator_string CHARACTER in ref descriptor optional)
X     (start_row LONGWORD in ref optional)
X    ))
X(define-foreign smg$read_keystroke
X (smg$read_keystroke LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (word_terminator_code WORD out ref)
X     (prompt_string CHARACTER in ref descriptor optional)
X     (timeout LONGWORD in ref optional)
X     (display_id LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$repaint_line
X (smg$repaint_line LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (start_row LONGWORD in ref)
X     (number_of_lines LONGWORD in ref optional)
X    ))
X(define-foreign smg$repaint_screen
X (smg$repaint_screen LONGWORD
X     (pasteboard_id LONGWORD in ref)
X    ))
X(define-foreign smg$repaste_virtual_display
X (smg$repaste_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X     (pasteboard_row LONGWORD in ref)
X     (pasteboard_column LONGWORD in ref)
X     (top_display_id LONGWORD in ref optional)
X    ))
X(define-foreign smg$restore_physical_screen
X (smg$restore_physical_screen LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (display_id LONGWORD in ref)
X    ))
X(define-foreign smg$read_string
X (smg$read_string LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (resultant_string CHARACTER out ref descriptor)
X     (prompt_string CHARACTER in ref descriptor optional)
X     (maximum_length LONGWORD in ref optional)
X     (modifiers LONGWORD in ref optional)
X     (timeout LONGWORD in ref optional)
X     (terminator_set ANY in ref optional)
X     (resultant_length WORD out ref optional)
X     (word_terminator_code WORD out ref optional)
X     (display_id LONGWORD in ref optional)
X     (initial_string CHARACTER in ref descriptor optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X     (terminator_string CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$return_cursor_pos
X (smg$return_cursor_pos LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD out ref)
X     (start_column LONGWORD out ref)
X    ))
X(define-foreign smg$read_verify
X (smg$read_verify LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (resultant_string CHARACTER out ref descriptor)
X     (initial_string CHARACTER in ref descriptor)
X     (picture_string CHARACTER in ref descriptor)
X     (fill_character CHARACTER in ref descriptor)
X     (clear_character CHARACTER in ref descriptor)
X     (prompt_string CHARACTER in ref descriptor optional)
X     (modifiers LONGWORD in ref optional)
X     (timeout LONGWORD in ref optional)
X     (terminator_set ANY in ref optional)
X     (initial_offset LONGWORD in ref optional)
X     (word_terminator_code WORD out ref optional)
X     (display_id LONGWORD in ref optional)
X     (alternate_echo_string CHARACTER in ref descriptor optional)
X     (alternate_display_id LONGWORD in ref optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_broadcast_trapping
X (smg$set_broadcast_trapping LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (ast_routine ADDRESS in value optional)
X     (ast_argument LONGWORD in value optional)
X    ))
X(define-foreign smg$scroll_display_area
X (smg$scroll_display_area LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X     (height LONGWORD in ref optional)
X     (width LONGWORD in ref optional)
X     (direction LONGWORD in ref optional)
X     (count LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_cursor_abs
X (smg$set_cursor_abs LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (start_column LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_cursor_rel
X (smg$set_cursor_rel LONGWORD
X     (display_id LONGWORD in ref)
X     (delta_row LONGWORD in ref optional)
X     (delta_column LONGWORD in ref optional)
X    ))
X(define-foreign smg$scroll_viewport
X (smg$scroll_viewport LONGWORD
X     (display_id LONGWORD in ref)
X     (direction LONGWORD in ref optional)
X     (count LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_display_scroll_region
X (smg$set_display_scroll_region LONGWORD
X     (display_id LONGWORD in ref)
X     (start_row LONGWORD in ref optional)
X     (end_row LONGWORD in ref optional)
X    ))
X(define-foreign smg$select_from_menu
X (smg$select_from_menu LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (display_id LONGWORD in ref)
X     (selected_choice_number WORD out ref)
X     (default_choice_number WORD in ref optional)
X     (flags LONGWORD in ref optional)
X     (help_library CHARACTER in ref descriptor optional)
X     (timeout LONGWORD in ref optional)
X     (terminator_code WORD out ref optional)
X     (selected_choice_string CHARACTER out ref descriptor optional)
X     (rendition_set LONGWORD in ref optional)
X     (rendition_complement LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_cursor_mode
X (smg$set_cursor_mode LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (flags LONGWORD in ref)
X    ))
X(define-foreign smg$set_keypad_mode
X (smg$set_keypad_mode LONGWORD
X     (keyboard_id LONGWORD in ref)
X     (flags LONGWORD in ref)
X    ))
X(define-foreign smg$snapshot
X (smg$snapshot LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (flags LONGWORD in ref optional)
X    ))
X(define-foreign smg$set_out_of_band_asts
X (smg$set_out_of_band_asts LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (control_character_mask LONGWORD in ref)
X     (ast_routine ADDRESS in value)
X     (ast_argument LONGWORD in value optional)
X    ))
X(define-foreign smg$set_physical_cursor
X (smg$set_physical_cursor LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (pasteboard_row LONGWORD in ref)
X     (pasteboard_column LONGWORD in ref)
X    ))
X(define-foreign smg$set_default_state
X (smg$set_default_state LONGWORD
X     (key_table_id LONGWORD in ref)
X     (new_state CHARACTER in ref descriptor optional)
X     (old_state CHARACTER out ref descriptor optional)
X    ))
X(define-foreign smg$set_term_characteristics
X (smg$set_term_characteristics LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (on_characteristics1 LONGWORD in ref optional)
X     (on_characteristics2 LONGWORD in ref optional)
X     (off_characteristics1 LONGWORD in ref optional)
X     (off_characteristics2 LONGWORD in ref optional)
X     (old_characteristics1 LONGWORD out ref optional)
X     (old_characteristics2 LONGWORD out ref optional)
X    ))
X(define-foreign smg$save_virtual_display
X (smg$save_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (filespec CHARACTER in ref descriptor optional)
X    ))
X(define-foreign smg$save_physical_screen
X (smg$save_physical_screen LONGWORD
X     (pasteboard_id LONGWORD in ref)
X     (display_id LONGWORD out ref)
X     (desired_start_row LONGWORD in ref optional)
X     (desired_end_row LONGWORD in ref optional)
X    ))
X(define-foreign smg$unpaste_virtual_display
X (smg$unpaste_virtual_display LONGWORD
X     (display_id LONGWORD in ref)
X     (pasteboard_id LONGWORD in ref)
X    ))
$ CALL UNPACK SMG$ROUTINES.SI;4 1767220212
$ create 'f'
X/* -*- C -*-    Module smg generated by genscmint 0.3 */
X
X#include "scmint.h"
X
X
Xextern long smg$add_key_def (/*longword*/long *, /*character*/struct dsc$des
Vcriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/long *, /*c
Vharacter*/struct dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *)
V;
Xstatic char sis_smg$add_key_def`5B`5D = "smg$add_key_def";
XSCM
Xsif_smg$add_key_def (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  long key_table_id;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  struct dsc$descriptor_s if_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  long attributes;
X  struct dsc$descriptor_s equivalence_string = `7B0, DSC$K_DTYPE_T, DSC$K_CL
VASS_S, 0`7D;
X  struct dsc$descriptor_s state_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  ASSERT ((num_args >= 2) && (num_args <= 6), l, WNA, sis_smg$add_key_def);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$add_key_def);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$add_key_def);
X      key_name = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$add_key_def);
X      if (!si_booleanp (inarg_3))      if_state = si_to_string (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$add_key_def);
X      if (!si_booleanp (inarg_4))      attributes = si_to_longword (inarg_4)
V;
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5, AR
VG5, sis_smg$add_key_def);
X      if (!si_booleanp (inarg_5))      equivalence_string = si_to_string (in
Varg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6, AR
VG6, sis_smg$add_key_def);
X      if (!si_booleanp (inarg_6))      state_string = si_to_string (inarg_6)
V;
X    `7D
X  extres = smg$add_key_def
X    (&key_table_id,`20
X     &key_name,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &if_state : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &attributes : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &equivalence_string : 0),`2
V0
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &state_string : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$add_key_def */
X
X
X
Xextern long smg$allow_escape (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$allow_escape`5B`5D = "smg$allow_escape";
XSCM
Xsif_smg$allow_escape (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long flags;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$allow_escape);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$allow_escape);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$allow_escape);
X      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$allow_escape
X    (&display_id,`20
X     &flags);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$allow_escape */
X
X
X
Xextern long smg$begin_display_update (/*longword*/long *);
Xstatic char sis_smg$begin_display_update`5B`5D = "smg$begin_display_update";
XSCM
Xsif_smg$begin_display_update (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$begin_display_
Vupdate);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$begin_display_u
Vpdate);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$begin_display_update
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$begin_display_update */
X
X
X
Xextern long smg$begin_pasteboard_update (/*longword*/long *);
Xstatic char sis_smg$begin_pasteboard_update`5B`5D = "smg$begin_pasteboard_up
Vdate";
XSCM
Xsif_smg$begin_pasteboard_update (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$begin_pasteboa
Vrd_update);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$begin_pasteboar
Vd_update);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$begin_pasteboard_update
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$begin_pasteboard_update */
X
X
X
Xextern long smg$cancel_input (/*longword*/long *);
Xstatic char sis_smg$cancel_input`5B`5D = "smg$cancel_input";
XSCM
Xsif_smg$cancel_input (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long keyboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$cancel_input);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$cancel_input);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$cancel_input
X    (&keyboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$cancel_input */
X
X
X
Xextern long smg$cursor_column (/*longword*/long *);
Xstatic char sis_smg$cursor_column`5B`5D = "smg$cursor_column";
XSCM
Xsif_smg$cursor_column (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$cursor_column)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$cursor_column);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$cursor_column
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$cursor_column */
X
X
X
Xextern long smg$check_for_occlusion (/*longword*/long *, /*longword*/long *,
V /*longword*/long *);
Xstatic char sis_smg$check_for_occlusion`5B`5D = "smg$check_for_occlusion";
XSCM
Xsif_smg$check_for_occlusion (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long pasteboard_id;
X  long occlusion_state;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$check_for_occl
Vusion);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$check_for_occlu
Vsion);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$check_for_occlu
Vsion);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  extres = smg$check_for_occlusion
X    (&display_id,`20
X     &pasteboard_id,`20
X     &occlusion_state);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (occlusion_state);
X  return result;
X`7D /* sif_smg$check_for_occlusion */
X
X
X
Xextern long smg$change_viewport (/*longword*/long *, /*longword*/long *, /*l
Vongword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$change_viewport`5B`5D = "smg$change_viewport";
XSCM
Xsif_smg$change_viewport (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long viewport_row_start;
X  long viewport_column_start;
X  long viewport_number_rows;
X  long viewport_number_columns;
X  ASSERT ((num_args >= 1) && (num_args <= 5), l, WNA, sis_smg$change_viewpor
Vt);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$change_viewport
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$change_viewport);
X      if (!si_booleanp (inarg_2))      viewport_row_start = si_to_longword (
Vinarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$change_viewport);
X      if (!si_booleanp (inarg_3))      viewport_column_start = si_to_longwor
Vd (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$change_viewport);
X      if (!si_booleanp (inarg_4))      viewport_number_rows = si_to_longword
V (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$change_viewport);
X      if (!si_booleanp (inarg_5))      viewport_number_columns = si_to_longw
Vord (inarg_5);
X    `7D
X  extres = smg$change_viewport
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &viewport_row_start : 0),`2
V0
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &viewport_column_start : 0)
V,`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &viewport_number_rows : 0),
V`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &viewport_number_columns :
V 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$change_viewport */
X
X
X
Xextern long smg$create_key_table (/*longword*/long *);
Xstatic char sis_smg$create_key_table`5B`5D = "smg$create_key_table";
XSCM
Xsif_smg$create_key_table (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  long key_table_id;
X  ASSERT ((num_args >= 0) && (num_args <= 0), l, WNA, sis_smg$create_key_tab
Vle);
X  extres = smg$create_key_table
X    (&key_table_id);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (key_table_id);
X  return result;
X`7D /* sif_smg$create_key_table */
X
X
X
Xextern long smg$create_menu (/*longword*/long *, /*character*/struct dsc$des
Vcriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*l
Vongword*/long *, /*longword*/long *);
Xstatic char sis_smg$create_menu`5B`5D = "smg$create_menu";
XSCM
Xsif_smg$create_menu (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s choices = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D
V;
X  long menu_type;
X  long flags;
X  long row;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 2) && (num_args <= 7), l, WNA, sis_smg$create_menu);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$create_menu);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$create_menu);
X      choices = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$create_menu);
X      if (!si_booleanp (inarg_3))      menu_type = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$create_menu);
X      if (!si_booleanp (inarg_4))      flags = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$create_menu);
X      if (!si_booleanp (inarg_5))      row = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$create_menu);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$create_menu);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  extres = smg$create_menu
X    (&display_id,`20
X     &choices,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &menu_type : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &flags : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &row : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$create_menu */
X
X
X
Xextern long smg$control_mode (/*longword*/long *, /*longword*/long *, /*long
Vword*/long *, /*word*/unsigned short *);
Xstatic char sis_smg$control_mode`5B`5D = "smg$control_mode";
XSCM
Xsif_smg$control_mode (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_4;
X  long pasteboard_id;
X  long new_mode;
X  long old_mode;
X  unsigned short buffer_size;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$control_mode);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$control_mode);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$control_mode);
X      if (!si_booleanp (inarg_2))      new_mode = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_shortp (inarg_4) `7C`7C si_booleanp (inarg_4), ina
Vrg_4, ARG3, sis_smg$control_mode);
X      if (!si_booleanp (inarg_4))      buffer_size = si_to_unsigned_short (i
Vnarg_4);
X    `7D
X  extres = smg$control_mode
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &new_mode : 0),`20
X     &old_mode,`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &buffer_size : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (old_mode);
X  return result;
X`7D /* sif_smg$control_mode */
X
X
X
Xextern long smg$copy_virtual_display (/*longword*/long *, /*longword*/long *
V);
Xstatic char sis_smg$copy_virtual_display`5B`5D = "smg$copy_virtual_display";
XSCM
Xsif_smg$copy_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long current_display_id;
X  long new_display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$copy_virtual_d
Visplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$copy_virtual_di
Vsplay);
X      current_display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$copy_virtual_display
X    (&current_display_id,`20
X     &new_display_id);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (new_display_id);
X  return result;
X`7D /* sif_smg$copy_virtual_display */
X
X
X
Xextern long smg$create_pasteboard (/*longword*/long *, /*character*/struct d
Vsc$descriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long
V *, /*longword*/long *);
Xstatic char sis_smg$create_pasteboard`5B`5D = "smg$create_pasteboard";
XSCM
Xsif_smg$create_pasteboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_2;
X  SCM inarg_5;
X  long pasteboard_id;
X  struct dsc$descriptor_s output_device = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  long number_of_pasteboard_rows;
X  long number_of_pasteboard_columns;
X  long flags;
X  long type_of_terminal;
X  ASSERT ((num_args >= 0) && (num_args <= 2), l, WNA, sis_smg$create_pastebo
Vard);
X  if (num_args > 0)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG1, sis_smg$create_pasteboard);
X      if (!si_booleanp (inarg_2))      output_device = si_to_string (inarg_2
V);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG2, sis_smg$create_pasteboard);
X      if (!si_booleanp (inarg_5))      flags = si_to_longword (inarg_5);
X    `7D
X  extres = smg$create_pasteboard
X    (&pasteboard_id,`20
X     ((num_args > 0) && !si_booleanp (inarg_2) ? &output_device : 0),`20
X     &number_of_pasteboard_rows,`20
X     &number_of_pasteboard_columns,`20
X     ((num_args > 1) && !si_booleanp (inarg_5) ? &flags : 0),`20
X     &type_of_terminal);
X  result = make_vector (MAKINUM (4+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (pasteboard_id);
X  *data++ = si_from_longword (number_of_pasteboard_rows);
X  *data++ = si_from_longword (number_of_pasteboard_columns);
X  *data++ = si_from_longword (type_of_terminal);
X  return result;
X`7D /* sif_smg$create_pasteboard */
X
X
X
Xextern long smg$change_pbd_characteristics (/*longword*/long *, /*longword*/
Vlong *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*longwo
Vrd*/long *, /*longword*/long *);
Xstatic char sis_smg$change_pbd_characteristics`5B`5D = "smg$change_pbd_chara
Vcteristics";
XSCM
Xsif_smg$change_pbd_characteristics (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_4;
X  SCM inarg_6;
X  long pasteboard_id;
X  long desired_width;
X  long width;
X  long desired_height;
X  long height;
X  long desired_background_color;
X  long background_color;
X  ASSERT ((num_args >= 1) && (num_args <= 4), l, WNA, sis_smg$change_pbd_cha
Vracteristics);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$change_pbd_char
Vacteristics);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$change_pbd_characteristics);
X      if (!si_booleanp (inarg_2))      desired_width = si_to_longword (inarg
V_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$change_pbd_characteristics);
X      if (!si_booleanp (inarg_4))      desired_height = si_to_longword (inar
Vg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG4, sis_smg$change_pbd_characteristics);
X      if (!si_booleanp (inarg_6))      desired_background_color = si_to_long
Vword (inarg_6);
X    `7D
X  extres = smg$change_pbd_characteristics
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &desired_width : 0),`20
X     &width,`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &desired_height : 0),`20
X     &height,`20
X     ((num_args > 3) && !si_booleanp (inarg_6) ? &desired_background_color :
V 0),`20
X     &background_color);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (width);
X  *data++ = si_from_longword (height);
X  *data++ = si_from_longword (background_color);
X  return result;
X`7D /* sif_smg$change_pbd_characteristics */
X
X
X
Xextern long smg$change_rendition (/*longword*/long *, /*longword*/long *, /*
Vlongword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *
V, /*longword*/long *);
Xstatic char sis_smg$change_rendition`5B`5D = "smg$change_rendition";
XSCM
Xsif_smg$change_rendition (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  long start_row;
X  long start_column;
X  long number_of_rows;
X  long number_of_columns;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 5) && (num_args <= 7), l, WNA, sis_smg$change_renditi
Von);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$change_renditio
Vn);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$change_renditio
Vn);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$change_renditio
Vn);
X      start_column = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$change_renditio
Vn);
X      number_of_rows = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$change_renditio
Vn);
X      number_of_columns = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$change_rendition);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$change_rendition);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  extres = smg$change_rendition
X    (&display_id,`20
X     &start_row,`20
X     &start_column,`20
X     &number_of_rows,`20
X     &number_of_columns,`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$change_rendition */
X
X
X
Xextern long smg$cursor_row (/*longword*/long *);
Xstatic char sis_smg$cursor_row`5B`5D = "smg$cursor_row";
XSCM
Xsif_smg$cursor_row (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$cursor_row);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$cursor_row);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$cursor_row
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$cursor_row */
X
X
X
Xextern long smg$create_subprocess (/*longword*/long *, /*address*/long, /*lo
Vngword*/long);
Xstatic char sis_smg$create_subprocess`5B`5D = "smg$create_subprocess";
XSCM
Xsif_smg$create_subprocess (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long ast_routine;
X  long ast_argument;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$create_subproc
Vess);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$create_subproce
Vss);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$create_subprocess);
X      if (!si_booleanp (inarg_2))      ast_routine = si_to_longword (inarg_2
V);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$create_subprocess);
X      if (!si_booleanp (inarg_3))      ast_argument = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$create_subprocess
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? ast_routine : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? ast_argument : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$create_subprocess */
X
X
X
Xextern long smg$create_virtual_display (/*longword*/long *, /*longword*/long
V *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/
Vlong *);
Xstatic char sis_smg$create_virtual_display`5B`5D = "smg$create_virtual_displ
Vay";
XSCM
Xsif_smg$create_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  long number_of_rows;
X  long number_of_columns;
X  long display_id;
X  long display_attributes;
X  long video_attributes;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 5), l, WNA, sis_smg$create_virtual
V_display);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$create_virtual_
Vdisplay);
X      number_of_rows = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$create_virtual_
Vdisplay);
X      number_of_columns = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$create_virtual_display);
X      if (!si_booleanp (inarg_4))      display_attributes = si_to_longword (
Vinarg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG4, sis_smg$create_virtual_display);
X      if (!si_booleanp (inarg_5))      video_attributes = si_to_longword (in
Varg_5);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG5, sis_smg$create_virtual_display);
X      if (!si_booleanp (inarg_6))      character_set = si_to_longword (inarg
V_6);
X    `7D
X  extres = smg$create_virtual_display
X    (&number_of_rows,`20
X     &number_of_columns,`20
X     &display_id,`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &display_attributes : 0),`2
V0
X     ((num_args > 3) && !si_booleanp (inarg_5) ? &video_attributes : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_6) ? &character_set : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (display_id);
X  return result;
X`7D /* sif_smg$create_virtual_display */
X
X
X
Xextern long smg$change_virtual_display (/*longword*/long *, /*longword*/long
V *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/
Vlong *);
Xstatic char sis_smg$change_virtual_display`5B`5D = "smg$change_virtual_displ
Vay";
XSCM
Xsif_smg$change_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  long display_id;
X  long number_of_rows;
X  long number_of_columns;
X  long display_attributes;
X  long video_attributes;
X  long character_set;
X  ASSERT ((num_args >= 1) && (num_args <= 6), l, WNA, sis_smg$change_virtual
V_display);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$change_virtual_
Vdisplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$change_virtual_display);
X      if (!si_booleanp (inarg_2))      number_of_rows = si_to_longword (inar
Vg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$change_virtual_display);
X      if (!si_booleanp (inarg_3))      number_of_columns = si_to_longword (i
Vnarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$change_virtual_display);
X      if (!si_booleanp (inarg_4))      display_attributes = si_to_longword (
Vinarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$change_virtual_display);
X      if (!si_booleanp (inarg_5))      video_attributes = si_to_longword (in
Varg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$change_virtual_display);
X      if (!si_booleanp (inarg_6))      character_set = si_to_longword (inarg
V_6);
X    `7D
X  extres = smg$change_virtual_display
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &number_of_rows : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &number_of_columns : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &display_attributes : 0),`2
V0
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &video_attributes : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$change_virtual_display */
X
X
X
Xextern long smg$create_virtual_keyboard (/*longword*/long *, /*character*/st
Vruct dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /*character
V*/struct dsc$descriptor_s *, /*byte*/unsigned char*);
Xstatic char sis_smg$create_virtual_keyboard`5B`5D = "smg$create_virtual_keyb
Voard";
XSCM
Xsif_smg$create_virtual_keyboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_5;
X  long keyboard_id;
X  struct dsc$descriptor_s input_device = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  struct dsc$descriptor_s default_filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s resultant_filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CL
VASS_S, 0`7D;
X  unsigned char recall_size;
X  ASSERT ((num_args >= 0) && (num_args <= 3), l, WNA, sis_smg$create_virtual
V_keyboard);
X  if (num_args > 0)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG1, sis_smg$create_virtual_keyboard);
X      if (!si_booleanp (inarg_2))      input_device = si_to_string (inarg_2)
V;
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG2, sis_smg$create_virtual_keyboard);
X      if (!si_booleanp (inarg_3))      default_filespec = si_to_string (inar
Vg_3);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_charp (inarg_5) `7C`7C si_booleanp (inarg_5), inar
Vg_5, ARG3, sis_smg$create_virtual_keyboard);
X      if (!si_booleanp (inarg_5))      recall_size = si_to_unsigned_char (in
Varg_5);
X    `7D
X  extres = smg$create_virtual_keyboard
X    (&keyboard_id,`20
X     ((num_args > 0) && !si_booleanp (inarg_2) ? &input_device : 0),`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &default_filespec : 0),`20
X     &resultant_filespec,`20
X     ((num_args > 2) && !si_booleanp (inarg_5) ? &recall_size : 0));
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (keyboard_id);
X  *data++ = si_from_string (resultant_filespec);
X  return result;
X`7D /* sif_smg$create_virtual_keyboard */
X
X
X
Xextern long smg$create_viewport (/*longword*/long *, /*longword*/long *, /*l
Vongword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$create_viewport`5B`5D = "smg$create_viewport";
XSCM
Xsif_smg$create_viewport (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long viewport_row_start;
X  long viewport_column_start;
X  long viewport_number_rows;
X  long viewport_number_columns;
X  ASSERT ((num_args >= 5) && (num_args <= 5), l, WNA, sis_smg$create_viewpor
Vt);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$create_viewport
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$create_viewport
V);
X      viewport_row_start = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$create_viewport
V);
X      viewport_column_start = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$create_viewport
V);
X      viewport_number_rows = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$create_viewport
V);
X      viewport_number_columns = si_to_longword (inarg_5);
X    `7D
X  extres = smg$create_viewport
X    (&display_id,`20
X     &viewport_row_start,`20
X     &viewport_column_start,`20
X     &viewport_number_rows,`20
X     &viewport_number_columns);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$create_viewport */
X
X
X
Xextern long smg$delete_chars (/*longword*/long *, /*longword*/long *, /*long
Vword*/long *, /*longword*/long *);
Xstatic char sis_smg$delete_chars`5B`5D = "smg$delete_chars";
XSCM
Xsif_smg$delete_chars (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long display_id;
X  long number_of_characters;
X  long start_row;
X  long start_column;
X  ASSERT ((num_args >= 4) && (num_args <= 4), l, WNA, sis_smg$delete_chars);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_chars);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$delete_chars);
X      number_of_characters = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$delete_chars);
X      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$delete_chars);
X      start_column = si_to_longword (inarg_4);
X    `7D
X  extres = smg$delete_chars
X    (&display_id,`20
X     &number_of_characters,`20
X     &start_row,`20
X     &start_column);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_chars */
X
X
X
Xextern long smg$define_key (/*longword*/long *, /*character*/struct dsc$desc
Vriptor_s *);
Xstatic char sis_smg$define_key`5B`5D = "smg$define_key";
XSCM
Xsif_smg$define_key (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long key_table_id;
X  struct dsc$descriptor_s command_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$define_key);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$define_key);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$define_key);
X      command_string = si_to_string (inarg_2);
X    `7D
X  extres = smg$define_key
X    (&key_table_id,`20
X     &command_string);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$define_key */
X
X
X
Xextern long smg$disable_broadcast_trapping (/*longword*/long *);
Xstatic char sis_smg$disable_broadcast_trapping`5B`5D = "smg$disable_broadcas
Vt_trapping";
XSCM
Xsif_smg$disable_broadcast_trapping (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$disable_broadc
Vast_trapping);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$disable_broadca
Vst_trapping);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$disable_broadcast_trapping
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$disable_broadcast_trapping */
X
X
X
Xextern long smg$disable_unsolicited_input (/*longword*/long *);
Xstatic char sis_smg$disable_unsolicited_input`5B`5D = "smg$disable_unsolicit
Ved_input";
XSCM
Xsif_smg$disable_unsolicited_input (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$disable_unsoli
Vcited_input);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$disable_unsolic
Vited_input);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$disable_unsolicited_input
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$disable_unsolicited_input */
X
X
X
Xextern long smg$delete_key_def (/*longword*/long *, /*character*/struct dsc$
Vdescriptor_s *, /*character*/struct dsc$descriptor_s *);
Xstatic char sis_smg$delete_key_def`5B`5D = "smg$delete_key_def";
XSCM
Xsif_smg$delete_key_def (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long key_table_id;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  struct dsc$descriptor_s if_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$delete_key_def
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_key_def)
V;
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$delete_key_def);
X      key_name = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$delete_key_def);
X      if (!si_booleanp (inarg_3))      if_state = si_to_string (inarg_3);
X    `7D
X  extres = smg$delete_key_def
X    (&key_table_id,`20
X     &key_name,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &if_state : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_key_def */
X
X
X
Xextern long smg$delete_line (/*longword*/long *, /*longword*/long *, /*longw
Vord*/long *);
Xstatic char sis_smg$delete_line`5B`5D = "smg$delete_line";
XSCM
Xsif_smg$delete_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long start_row;
X  long number_of_rows;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$delete_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$delete_line);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$delete_line);
X      if (!si_booleanp (inarg_3))      number_of_rows = si_to_longword (inar
Vg_3);
X    `7D
X  extres = smg$delete_line
X    (&display_id,`20
X     &start_row,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &number_of_rows : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_line */
X
X
X
Xextern long smg$delete_menu (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$delete_menu`5B`5D = "smg$delete_menu";
XSCM
Xsif_smg$delete_menu (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long flags;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$delete_menu);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_menu);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$delete_menu);
X      if (!si_booleanp (inarg_2))      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$delete_menu
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &flags : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_menu */
X
X
X
Xextern long smg$delete_pasteboard (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$delete_pasteboard`5B`5D = "smg$delete_pasteboard";
XSCM
Xsif_smg$delete_pasteboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  long flags;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$delete_pastebo
Vard);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_pasteboa
Vrd);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$delete_pasteboard);
X      if (!si_booleanp (inarg_2))      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$delete_pasteboard
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &flags : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_pasteboard */
X
X
X
Xextern long smg$draw_char (/*longword*/long *, /*longword*/long *, /*longwor
Vd*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$draw_char`5B`5D = "smg$draw_char";
XSCM
Xsif_smg$draw_char (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  long display_id;
X  long flags;
X  long row;
X  long column;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 2) && (num_args <= 6), l, WNA, sis_smg$draw_char);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$draw_char);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$draw_char);
X      flags = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$draw_char);
X      if (!si_booleanp (inarg_3))      row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$draw_char);
X      if (!si_booleanp (inarg_4))      column = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$draw_char);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$draw_char);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  extres = smg$draw_char
X    (&display_id,`20
X     &flags,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &row : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &column : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$draw_char */
X
X
X
Xextern long smg$draw_line (/*longword*/long *, /*longword*/long *, /*longwor
Vd*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*lon
Vgword*/long *);
Xstatic char sis_smg$draw_line`5B`5D = "smg$draw_line";
XSCM
Xsif_smg$draw_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  long start_row;
X  long start_column;
X  long end_row;
X  long end_column;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 5) && (num_args <= 7), l, WNA, sis_smg$draw_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$draw_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$draw_line);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$draw_line);
X      start_column = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$draw_line);
X      end_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$draw_line);
X      end_column = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$draw_line);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$draw_line);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  extres = smg$draw_line
X    (&display_id,`20
X     &start_row,`20
X     &start_column,`20
X     &end_row,`20
X     &end_column,`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$draw_line */
X
X
X
Xextern long smg$draw_rectangle (/*longword*/long *, /*longword*/long *, /*lo
Vngword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *,
V /*longword*/long *);
Xstatic char sis_smg$draw_rectangle`5B`5D = "smg$draw_rectangle";
XSCM
Xsif_smg$draw_rectangle (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  long start_row;
X  long start_column;
X  long end_row;
X  long end_column;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 5) && (num_args <= 7), l, WNA, sis_smg$draw_rectangle
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$draw_rectangle)
V;
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$draw_rectangle)
V;
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$draw_rectangle)
V;
X      start_column = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$draw_rectangle)
V;
X      end_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$draw_rectangle)
V;
X      end_column = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$draw_rectangle);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$draw_rectangle);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  extres = smg$draw_rectangle
X    (&display_id,`20
X     &start_row,`20
X     &start_column,`20
X     &end_row,`20
X     &end_column,`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$draw_rectangle */
X
X
X
Xextern long smg$delete_subprocess (/*longword*/long *);
Xstatic char sis_smg$delete_subprocess`5B`5D = "smg$delete_subprocess";
XSCM
Xsif_smg$delete_subprocess (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$delete_subproc
Vess);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_subproce
Vss);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$delete_subprocess
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_subprocess */
X
X
X
Xextern long smg$del_term_table ();
Xstatic char sis_smg$del_term_table`5B`5D = "smg$del_term_table";
XSCM
Xsif_smg$del_term_table (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  ASSERT (num_args == 0, l, SI_WNA, sis_smg$del_term_table);
X  extres = smg$del_term_table
X    ();
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$del_term_table */
X
X
X
Xextern long smg$delete_virtual_display (/*longword*/long *);
Xstatic char sis_smg$delete_virtual_display`5B`5D = "smg$delete_virtual_displ
Vay";
XSCM
Xsif_smg$delete_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$delete_virtual
V_display);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_virtual_
Vdisplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$delete_virtual_display
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_virtual_display */
X
X
X
Xextern long smg$delete_virtual_keyboard (/*longword*/long *);
Xstatic char sis_smg$delete_virtual_keyboard`5B`5D = "smg$delete_virtual_keyb
Voard";
XSCM
Xsif_smg$delete_virtual_keyboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long keyboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$delete_virtual
V_keyboard);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_virtual_
Vkeyboard);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$delete_virtual_keyboard
X    (&keyboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_virtual_keyboard */
X
X
X
Xextern long smg$delete_viewport (/*longword*/long *);
Xstatic char sis_smg$delete_viewport`5B`5D = "smg$delete_viewport";
XSCM
Xsif_smg$delete_viewport (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$delete_viewpor
Vt);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$delete_viewport
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$delete_viewport
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$delete_viewport */
X
X
X
Xextern long smg$erase_chars (/*longword*/long *, /*longword*/long *, /*longw
Vord*/long *, /*longword*/long *);
Xstatic char sis_smg$erase_chars`5B`5D = "smg$erase_chars";
XSCM
Xsif_smg$erase_chars (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long display_id;
X  long number_of_characters;
X  long start_row;
X  long start_column;
X  ASSERT ((num_args >= 4) && (num_args <= 4), l, WNA, sis_smg$erase_chars);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$erase_chars);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$erase_chars);
X      number_of_characters = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$erase_chars);
X      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$erase_chars);
X      start_column = si_to_longword (inarg_4);
X    `7D
X  extres = smg$erase_chars
X    (&display_id,`20
X     &number_of_characters,`20
X     &start_row,`20
X     &start_column);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$erase_chars */
X
X
X
Xextern long smg$end_display_update (/*longword*/long *);
Xstatic char sis_smg$end_display_update`5B`5D = "smg$end_display_update";
XSCM
Xsif_smg$end_display_update (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$end_display_up
Vdate);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$end_display_upd
Vate);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$end_display_update
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$end_display_update */
X
X
X
Xextern long smg$end_pasteboard_update (/*longword*/long *);
Xstatic char sis_smg$end_pasteboard_update`5B`5D = "smg$end_pasteboard_update
V";
XSCM
Xsif_smg$end_pasteboard_update (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$end_pasteboard
V_update);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$end_pasteboard_
Vupdate);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$end_pasteboard_update
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$end_pasteboard_update */
X
X
X
Xextern long smg$enable_unsolicited_input (/*longword*/long *, /*address*/lon
Vg, /*longword*/long);
Xstatic char sis_smg$enable_unsolicited_input`5B`5D = "smg$enable_unsolicited
V_input";
XSCM
Xsif_smg$enable_unsolicited_input (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long pasteboard_id;
X  long ast_routine;
X  long ast_argument;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$enable_unsolic
Vited_input);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$enable_unsolici
Vted_input);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$enable_unsolici
Vted_input);
X      ast_routine = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$enable_unsolicited_input);
X      if (!si_booleanp (inarg_3))      ast_argument = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$enable_unsolicited_input
X    (&pasteboard_id,`20
X     ast_routine,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? ast_argument : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$enable_unsolicited_input */
X
X
X
Xextern long smg$erase_column (/*longword*/long *, /*longword*/long *, /*long
Vword*/long *, /*longword*/long *);
Xstatic char sis_smg$erase_column`5B`5D = "smg$erase_column";
XSCM
Xsif_smg$erase_column (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long display_id;
X  long start_row;
X  long column_number;
X  long end_row;
X  ASSERT ((num_args >= 1) && (num_args <= 4), l, WNA, sis_smg$erase_column);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$erase_column);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$erase_column);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$erase_column);
X      if (!si_booleanp (inarg_3))      column_number = si_to_longword (inarg
V_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$erase_column);
X      if (!si_booleanp (inarg_4))      end_row = si_to_longword (inarg_4);
X    `7D
X  extres = smg$erase_column
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &column_number : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &end_row : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$erase_column */
X
X
X
Xextern long smg$erase_display (/*longword*/long *, /*longword*/long *, /*lon
Vgword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$erase_display`5B`5D = "smg$erase_display";
XSCM
Xsif_smg$erase_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long start_row;
X  long start_column;
X  long end_row;
X  long end_column;
X  ASSERT ((num_args >= 1) && (num_args <= 5), l, WNA, sis_smg$erase_display)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$erase_display);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$erase_display);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$erase_display);
X      if (!si_booleanp (inarg_3))      start_column = si_to_longword (inarg_
V3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$erase_display);
X      if (!si_booleanp (inarg_4))      end_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$erase_display);
X      if (!si_booleanp (inarg_5))      end_column = si_to_longword (inarg_5)
V;
X    `7D
X  extres = smg$erase_display
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_column : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &end_row : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &end_column : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$erase_display */
X
X
X
Xextern long smg$erase_line (/*longword*/long *, /*longword*/long *, /*longwo
Vrd*/long *);
Xstatic char sis_smg$erase_line`5B`5D = "smg$erase_line";
XSCM
Xsif_smg$erase_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long start_row;
X  long start_column;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$erase_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$erase_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$erase_line);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$erase_line);
X      if (!si_booleanp (inarg_3))      start_column = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$erase_line
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_column : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$erase_line */
X
X
X
Xextern long smg$erase_pasteboard (/*longword*/long *);
Xstatic char sis_smg$erase_pasteboard`5B`5D = "smg$erase_pasteboard";
XSCM
Xsif_smg$erase_pasteboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$erase_pasteboa
Vrd);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$erase_pasteboar
Vd);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$erase_pasteboard
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$erase_pasteboard */
X
X
X
Xextern long smg$execute_command (/*longword*/long *, /*character*/struct dsc
V$descriptor_s *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$execute_command`5B`5D = "smg$execute_command";
XSCM
Xsif_smg$execute_command (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  struct dsc$descriptor_s command_desc = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  long flags;
X  long ret_status;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$execute_comman
Vd);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$execute_command
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$execute_command);
X      command_desc = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$execute_command);
X      if (!si_booleanp (inarg_3))      flags = si_to_longword (inarg_3);
X    `7D
X  extres = smg$execute_command
X    (&display_id,`20
X     &command_desc,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &flags : 0),`20
X     &ret_status);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (ret_status);
X  return result;
X`7D /* sif_smg$execute_command */
X
X
X
Xextern long smg$find_cursor_display (/*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$find_cursor_display`5B`5D = "smg$find_cursor_display";
XSCM
Xsif_smg$find_cursor_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  long pasteboard_id;
X  long display_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$find_cursor_di
Vsplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$find_cursor_dis
Vplay);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG2, sis_smg$find_cursor_display);
X      if (!si_booleanp (inarg_3))      pasteboard_row = si_to_longword (inar
Vg_3);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$find_cursor_display);
X      if (!si_booleanp (inarg_4))      pasteboard_column = si_to_longword (i
Vnarg_4);
X    `7D
X  extres = smg$find_cursor_display
X    (&pasteboard_id,`20
X     &display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &pasteboard_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &pasteboard_column : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (display_id);
X  return result;
X`7D /* sif_smg$find_cursor_display */
X
X
X
Xextern long smg$flush_buffer (/*longword*/long *);
Xstatic char sis_smg$flush_buffer`5B`5D = "smg$flush_buffer";
XSCM
Xsif_smg$flush_buffer (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$flush_buffer);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$flush_buffer);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$flush_buffer
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$flush_buffer */
X
X
X
Xextern long smg$get_broadcast_message (/*longword*/long *, /*character*/stru
Vct dsc$descriptor_s *, /*word*/unsigned short *, /*word*/unsigned short *);
Xstatic char sis_smg$get_broadcast_message`5B`5D = "smg$get_broadcast_message
V";
XSCM
Xsif_smg$get_broadcast_message (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  struct dsc$descriptor_s message = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D
V;
X  unsigned short message_length;
X  unsigned short message_type;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$get_broadcast_
Vmessage);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_broadcast_m
Vessage);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$get_broadcast_message
X    (&pasteboard_id,`20
X     &message,`20
X     &message_length,`20
X     &message_type);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (message);
X  *data++ = si_from_unsigned_short (message_length);
X  *data++ = si_from_unsigned_short (message_type);
X  return result;
X`7D /* sif_smg$get_broadcast_message */
X
X
X
Xextern long smg$get_char_at_physical_cursor (/*longword*/long *, /*byte*/uns
Vigned char*);
Xstatic char sis_smg$get_char_at_physical_cursor`5B`5D = "smg$get_char_at_phy
Vsical_cursor";
XSCM
Xsif_smg$get_char_at_physical_cursor (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  unsigned char character_code;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$get_char_at_ph
Vysical_cursor);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_char_at_phy
Vsical_cursor);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$get_char_at_physical_cursor
X    (&pasteboard_id,`20
X     &character_code);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_unsigned_char (character_code);
X  return result;
X`7D /* sif_smg$get_char_at_physical_cursor */
X
X
X
Xextern long smg$get_display_attr (/*longword*/long *, /*longword*/long *, /*
Vlongword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *
V, /*longword*/long *);
Xstatic char sis_smg$get_display_attr`5B`5D = "smg$get_display_attr";
XSCM
Xsif_smg$get_display_attr (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_6;
X  long display_id;
X  long height;
X  long width;
X  long display_attributes;
X  long video_attributes;
X  long character_set;
X  long flags;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$get_display_at
Vtr);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_display_att
Vr);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG2, sis_smg$get_display_attr);
X      if (!si_booleanp (inarg_6))      character_set = si_to_longword (inarg
V_6);
X    `7D
X  extres = smg$get_display_attr
X    (&display_id,`20
X     &height,`20
X     &width,`20
X     &display_attributes,`20
X     &video_attributes,`20
X     ((num_args > 1) && !si_booleanp (inarg_6) ? &character_set : 0),`20
X     &flags);
X  result = make_vector (MAKINUM (5+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (height);
X  *data++ = si_from_longword (width);
X  *data++ = si_from_longword (display_attributes);
X  *data++ = si_from_longword (video_attributes);
X  *data++ = si_from_longword (flags);
X  return result;
X`7D /* sif_smg$get_display_attr */
X
X
X
Xextern long smg$get_keyboard_attributes (/*longword*/long *, /*address*/long
V *, /*longword*/long *);
Xstatic char sis_smg$get_keyboard_attributes`5B`5D = "smg$get_keyboard_attrib
Vutes";
XSCM
Xsif_smg$get_keyboard_attributes (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  long keyboard_id;
X  long p_kit;
X  long p_kit_size;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$get_keyboard_a
Vttributes);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_keyboard_at
Vtributes);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG2, sis_smg$get_keyboard_at
Vtributes);
X      p_kit_size = si_to_longword (inarg_3);
X    `7D
X  extres = smg$get_keyboard_attributes
X    (&keyboard_id,`20
X     &p_kit,`20
X     &p_kit_size);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (p_kit);
X  return result;
X`7D /* sif_smg$get_keyboard_attributes */
X
X
X
Xextern long smg$get_key_def (/*longword*/long *, /*character*/struct dsc$des
Vcriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/long *, /*c
Vharacter*/struct dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *)
V;
Xstatic char sis_smg$get_key_def`5B`5D = "smg$get_key_def";
XSCM
Xsif_smg$get_key_def (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long key_table_id;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  struct dsc$descriptor_s if_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  long attributes;
X  struct dsc$descriptor_s equivalence_string = `7B0, DSC$K_DTYPE_T, DSC$K_CL
VASS_S, 0`7D;
X  struct dsc$descriptor_s state_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$get_key_def);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_key_def);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$get_key_def);
X      key_name = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$get_key_def);
X      if (!si_booleanp (inarg_3))      if_state = si_to_string (inarg_3);
X    `7D
X  extres = smg$get_key_def
X    (&key_table_id,`20
X     &key_name,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &if_state : 0),`20
X     &attributes,`20
X     &equivalence_string,`20
X     &state_string);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (attributes);
X  *data++ = si_from_string (equivalence_string);
X  *data++ = si_from_string (state_string);
X  return result;
X`7D /* sif_smg$get_key_def */
X
X
X
Xextern long smg$get_numeric_data (/*address*/long *, /*longword*/long *, /*a
Vddress*/long *);
Xstatic char sis_smg$get_numeric_data`5B`5D = "smg$get_numeric_data";
XSCM
Xsif_smg$get_numeric_data (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long termtable_address;
X  long request_code;
X  long buffer_address;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$get_numeric_da
Vta);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_numeric_dat
Va);
X      termtable_address = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$get_numeric_dat
Va);
X      request_code = si_to_longword (inarg_2);
X    `7D
X  extres = smg$get_numeric_data
X    (&termtable_address,`20
X     &request_code,`20
X     &buffer_address);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (buffer_address);
X  return result;
X`7D /* sif_smg$get_numeric_data */
X
X
X
Xextern long smg$get_pasting_info (/*longword*/long *, /*longword*/long *, /*
Vlongword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$get_pasting_info`5B`5D = "smg$get_pasting_info";
XSCM
Xsif_smg$get_pasting_info (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long pasteboard_id;
X  long flags;
X  long pasteboard_row;
X  long pasteboard_column;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$get_pasting_in
Vfo);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_pasting_inf
Vo);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$get_pasting_inf
Vo);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  extres = smg$get_pasting_info
X    (&display_id,`20
X     &pasteboard_id,`20
X     &flags,`20
X     &pasteboard_row,`20
X     &pasteboard_column);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (flags);
X  *data++ = si_from_longword (pasteboard_row);
X  *data++ = si_from_longword (pasteboard_column);
X  return result;
X`7D /* sif_smg$get_pasting_info */
X
X
X
Xextern long smg$get_pasteboard_attributes (/*longword*/long *, /*any*/long *
V, /*longword*/long *);
Xstatic char sis_smg$get_pasteboard_attributes`5B`5D = "smg$get_pasteboard_at
Vtributes";
XSCM
Xsif_smg$get_pasteboard_attributes (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  long pasteboard_id;
X  long pasteboard_info_table;
X  long pasteboard_info_table_size;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$get_pasteboard
V_attributes);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_pasteboard_
Vattributes);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG2, sis_smg$get_pasteboard_
Vattributes);
X      pasteboard_info_table_size = si_to_longword (inarg_3);
X    `7D
X  extres = smg$get_pasteboard_attributes
X    (&pasteboard_id,`20
X     &pasteboard_info_table,`20
X     &pasteboard_info_table_size);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (pasteboard_info_table);
X  return result;
X`7D /* sif_smg$get_pasteboard_attributes */
X
X
X
Xextern long smg$get_term_data (/*address*/long *, /*longword*/long *, /*long
Vword*/long *, /*longword*/long *, /*address*/long *, /*longword*/long *);
Xstatic char sis_smg$get_term_data`5B`5D = "smg$get_term_data";
XSCM
Xsif_smg$get_term_data (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_6;
X  long termtable_address;
X  long request_code;
X  long maximum_buffer_length;
X  long return_length;
X  long buffer_address;
X  long input_argument_vector;
X  ASSERT ((num_args >= 3) && (num_args <= 4), l, WNA, sis_smg$get_term_data)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_term_data);
X      termtable_address = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$get_term_data);
X      request_code = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$get_term_data);
X      maximum_buffer_length = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG4, sis_smg$get_term_data);
X      if (!si_booleanp (inarg_6))      input_argument_vector = si_to_longwor
Vd (inarg_6);
X    `7D
X  extres = smg$get_term_data
X    (&termtable_address,`20
X     &request_code,`20
X     &maximum_buffer_length,`20
X     &return_length,`20
X     &buffer_address,`20
X     ((num_args > 3) && !si_booleanp (inarg_6) ? &input_argument_vector : 0)
V);
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (return_length);
X  *data++ = si_from_longword (buffer_address);
X  return result;
X`7D /* sif_smg$get_term_data */
X
X
X
Xextern long smg$get_viewport_char (/*longword*/long *, /*longword*/long *, /
V*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$get_viewport_char`5B`5D = "smg$get_viewport_char";
XSCM
Xsif_smg$get_viewport_char (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  long viewport_row_start;
X  long viewport_column_start;
X  long viewport_number_rows;
X  long viewport_number_columns;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$get_viewport_c
Vhar);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$get_viewport_ch
Var);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$get_viewport_char
X    (&display_id,`20
X     &viewport_row_start,`20
X     &viewport_column_start,`20
X     &viewport_number_rows,`20
X     &viewport_number_columns);
X  result = make_vector (MAKINUM (4+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (viewport_row_start);
X  *data++ = si_from_longword (viewport_column_start);
X  *data++ = si_from_longword (viewport_number_rows);
X  *data++ = si_from_longword (viewport_number_columns);
X  return result;
X`7D /* sif_smg$get_viewport_char */
X
X
X
Xextern long smg$home_cursor (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$home_cursor`5B`5D = "smg$home_cursor";
XSCM
Xsif_smg$home_cursor (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long position_code;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$home_cursor);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$home_cursor);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$home_cursor);
X      if (!si_booleanp (inarg_2))      position_code = si_to_longword (inarg
V_2);
X    `7D
X  extres = smg$home_cursor
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &position_code : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$home_cursor */
X
X
X
Xextern long smg$init_term_table (/*character*/struct dsc$descriptor_s *, /*a
Vddress*/long *);
Xstatic char sis_smg$init_term_table`5B`5D = "smg$init_term_table";
XSCM
Xsif_smg$init_term_table (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  struct dsc$descriptor_s terminal_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  long termtable_address;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$init_term_tabl
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_1), inarg_1, ARG1, sis_smg$init_term_table);
X      terminal_name = si_to_string (inarg_1);
X    `7D
X  extres = smg$init_term_table
X    (&terminal_name,`20
X     &termtable_address);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (termtable_address);
X  return result;
X`7D /* sif_smg$init_term_table */
X
X
X
Xextern long smg$insert_chars (/*longword*/long *, /*character*/struct dsc$de
Vscriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*
Vlongword*/long *, /*longword*/long *);
Xstatic char sis_smg$insert_chars`5B`5D = "smg$insert_chars";
XSCM
Xsif_smg$insert_chars (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s character_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  long start_row;
X  long start_column;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 4) && (num_args <= 7), l, WNA, sis_smg$insert_chars);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$insert_chars);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$insert_chars);
X      character_string = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$insert_chars);
X      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$insert_chars);
X      start_column = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$insert_chars);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$insert_chars);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$insert_chars);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$insert_chars
X    (&display_id,`20
X     &character_string,`20
X     &start_row,`20
X     &start_column,`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$insert_chars */
X
X
X
Xextern long smg$insert_line (/*longword*/long *, /*longword*/long *, /*chara
Vcter*/struct dsc$descriptor_s *, /*longword*/long *, /*longword*/long *, /*l
Vongword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$insert_line`5B`5D = "smg$insert_line";
XSCM
Xsif_smg$insert_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  long display_id;
X  long start_row;
X  struct dsc$descriptor_s character_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  long direction;
X  long rendition_set;
X  long rendition_complement;
X  long flags;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$insert_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$insert_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$insert_line);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$insert_line);
X      if (!si_booleanp (inarg_3))      character_string = si_to_string (inar
Vg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$insert_line);
X      if (!si_booleanp (inarg_4))      direction = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$insert_line);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$insert_line);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$insert_line);
X      if (!si_booleanp (inarg_7))      flags = si_to_longword (inarg_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$insert_line);
X      if (!si_booleanp (inarg_8))      character_set = si_to_longword (inarg
V_8);
X    `7D
X  extres = smg$insert_line
X    (&display_id,`20
X     &start_row,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &character_string : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &direction : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &flags : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$insert_line */
X
X
X
Xextern long smg$init_term_table_by_type (/*byte*/unsigned char*, /*address*/
Vlong *, /*character*/struct dsc$descriptor_s *);
Xstatic char sis_smg$init_term_table_by_type`5B`5D = "smg$init_term_table_by_
Vtype";
XSCM
Xsif_smg$init_term_table_by_type (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  unsigned char terminal_type;
X  long termtable_address;
X  struct dsc$descriptor_s terminal_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$init_term_tabl
Ve_by_type);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_charp (inarg_1), inarg_1, ARG1, sis_smg$init_term_
Vtable_by_type);
X      terminal_type = si_to_unsigned_char (inarg_1);
X    `7D
X  extres = smg$init_term_table_by_type
X    (&terminal_type,`20
X     &termtable_address,`20
X     &terminal_name);
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (termtable_address);
X  *data++ = si_from_string (terminal_name);
X  return result;
X`7D /* sif_smg$init_term_table_by_type */
X
X
X
Xextern long smg$invalidate_display (/*longword*/long *);
Xstatic char sis_smg$invalidate_display`5B`5D = "smg$invalidate_display";
XSCM
Xsif_smg$invalidate_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$invalidate_dis
Vplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$invalidate_disp
Vlay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$invalidate_display
X    (&display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$invalidate_display */
X
X
X
Xextern long smg$keycode_to_name (/*word*/unsigned short *, /*character*/stru
Vct dsc$descriptor_s *);
Xstatic char sis_smg$keycode_to_name`5B`5D = "smg$keycode_to_name";
XSCM
Xsif_smg$keycode_to_name (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  unsigned short key_code;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$keycode_to_nam
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_shortp (inarg_1), inarg_1, ARG1, sis_smg$keycode_t
Vo_name);
X      key_code = si_to_unsigned_short (inarg_1);
X    `7D
X  extres = smg$keycode_to_name
X    (&key_code,`20
X     &key_name);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (key_name);
X  return result;
X`7D /* sif_smg$keycode_to_name */
X
X
X
Xextern long smg$label_border (/*longword*/long *, /*character*/struct dsc$de
Vscriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*
Vlongword*/long *, /*longword*/long *);
Xstatic char sis_smg$label_border`5B`5D = "smg$label_border";
XSCM
Xsif_smg$label_border (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long position_code;
X  long units;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 1) && (num_args <= 7), l, WNA, sis_smg$label_border);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$label_border);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$label_border);
X      if (!si_booleanp (inarg_2))      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$label_border);
X      if (!si_booleanp (inarg_3))      position_code = si_to_longword (inarg
V_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$label_border);
X      if (!si_booleanp (inarg_4))      units = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$label_border);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$label_border);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$label_border);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$label_border
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &text : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &position_code : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &units : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$label_border */
X
X
X
Xextern long smg$load_key_defs (/*longword*/long *, /*character*/struct dsc$d
Vescriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/long *);
Xstatic char sis_smg$load_key_defs`5B`5D = "smg$load_key_defs";
XSCM
Xsif_smg$load_key_defs (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long key_table_id;
X  struct dsc$descriptor_s filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  struct dsc$descriptor_s default_filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  long flags;
X  ASSERT ((num_args >= 2) && (num_args <= 4), l, WNA, sis_smg$load_key_defs)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$load_key_defs);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$load_key_defs);
X      filespec = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$load_key_defs);
X      if (!si_booleanp (inarg_3))      default_filespec = si_to_string (inar
Vg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$load_key_defs);
X      if (!si_booleanp (inarg_4))      flags = si_to_longword (inarg_4);
X    `7D
X  extres = smg$load_key_defs
X    (&key_table_id,`20
X     &filespec,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &default_filespec : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &flags : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$load_key_defs */
X
X
X
Xextern long smg$list_key_defs (/*longword*/long *, /*longword*/long *, /*cha
Vracter*/struct dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /
V*longword*/long *, /*character*/struct dsc$descriptor_s *, /*character*/stru
Vct dsc$descriptor_s *);
Xstatic char sis_smg$list_key_defs`5B`5D = "smg$list_key_defs";
XSCM
Xsif_smg$list_key_defs (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long key_table_id;
X  long context;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  struct dsc$descriptor_s if_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  long attributes;
X  struct dsc$descriptor_s equivalence_string = `7B0, DSC$K_DTYPE_T, DSC$K_CL
VASS_S, 0`7D;
X  struct dsc$descriptor_s state_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$list_key_defs)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$list_key_defs);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$list_key_defs);
X      context = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$list_key_defs);
X      if (!si_booleanp (inarg_3))      key_name = si_to_string (inarg_3);
X    `7D
X  extres = smg$list_key_defs
X    (&key_table_id,`20
X     &context,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &key_name : 0),`20
X     &if_state,`20
X     &attributes,`20
X     &equivalence_string,`20
X     &state_string);
X  result = make_vector (MAKINUM (6+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (context);
X  *data++ = si_from_string (key_name);
X  *data++ = si_from_string (if_state);
X  *data++ = si_from_longword (attributes);
X  *data++ = si_from_string (equivalence_string);
X  *data++ = si_from_string (state_string);
X  return result;
X`7D /* sif_smg$list_key_defs */
X
X
X
Xextern long smg$list_pasting_order (/*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$list_pasting_order`5B`5D = "smg$list_pasting_order";
XSCM
Xsif_smg$list_pasting_order (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  long context;
X  long display_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$list_pasting_o
Vrder);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$list_pasting_or
Vder);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$list_pasting_or
Vder);
X      context = si_to_longword (inarg_2);
X    `7D
X  extres = smg$list_pasting_order
X    (&pasteboard_id,`20
X     &context,`20
X     &display_id,`20
X     &pasteboard_row,`20
X     &pasteboard_column);
X  result = make_vector (MAKINUM (4+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (context);
X  *data++ = si_from_longword (display_id);
X  *data++ = si_from_longword (pasteboard_row);
X  *data++ = si_from_longword (pasteboard_column);
X  return result;
X`7D /* sif_smg$list_pasting_order */
X
X
X
Xextern long smg$load_virtual_display (/*longword*/long *, /*character*/struc
Vt dsc$descriptor_s *);
Xstatic char sis_smg$load_virtual_display`5B`5D = "smg$load_virtual_display";
XSCM
Xsif_smg$load_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_2;
X  long display_id;
X  struct dsc$descriptor_s filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  ASSERT ((num_args >= 0) && (num_args <= 1), l, WNA, sis_smg$load_virtual_d
Visplay);
X  if (num_args > 0)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG1, sis_smg$load_virtual_display);
X      if (!si_booleanp (inarg_2))      filespec = si_to_string (inarg_2);
X    `7D
X  extres = smg$load_virtual_display
X    (&display_id,`20
X     ((num_args > 0) && !si_booleanp (inarg_2) ? &filespec : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (display_id);
X  return result;
X`7D /* sif_smg$load_virtual_display */
X
X
X
Xextern long smg$move_virtual_display (/*longword*/long *, /*longword*/long *
V, /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$move_virtual_display`5B`5D = "smg$move_virtual_display";
XSCM
Xsif_smg$move_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long pasteboard_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  long top_display_id;
X  ASSERT ((num_args >= 4) && (num_args <= 5), l, WNA, sis_smg$move_virtual_d
Visplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$move_virtual_di
Vsplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$move_virtual_di
Vsplay);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$move_virtual_di
Vsplay);
X      pasteboard_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$move_virtual_di
Vsplay);
X      pasteboard_column = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$move_virtual_display);
X      if (!si_booleanp (inarg_5))      top_display_id = si_to_longword (inar
Vg_5);
X    `7D
X  extres = smg$move_virtual_display
X    (&display_id,`20
X     &pasteboard_id,`20
X     &pasteboard_row,`20
X     &pasteboard_column,`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &top_display_id : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$move_virtual_display */
X
X
X
Xextern long smg$move_text (/*longword*/long *, /*longword*/long *, /*longwor
Vd*/long *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*lon
Vgword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$move_text`5B`5D = "smg$move_text";
XSCM
Xsif_smg$move_text (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  SCM inarg_9;
X  long display_id;
X  long top_left_row;
X  long top_left_column;
X  long bottom_right_row;
X  long bottom_right_column;
X  long display_id2;
X  long top_left_row2;
X  long top_left_column2;
X  long flags;
X  ASSERT ((num_args >= 6) && (num_args <= 9), l, WNA, sis_smg$move_text);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$move_text);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$move_text);
X      top_left_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$move_text);
X      top_left_column = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$move_text);
X      bottom_right_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$move_text);
X      bottom_right_column = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6), inarg_6, ARG6, sis_smg$move_text);
X      display_id2 = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$move_text);
X      if (!si_booleanp (inarg_7))      top_left_row2 = si_to_longword (inarg
V_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$move_text);
X      if (!si_booleanp (inarg_8))      top_left_column2 = si_to_longword (in
Varg_8);
X    `7D
X  if (num_args > 8)
X    `7B
X      inarg_9 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_9) `7C`7C si_booleanp (inarg_9), inarg_9,
V ARG9, sis_smg$move_text);
X      if (!si_booleanp (inarg_9))      flags = si_to_longword (inarg_9);
X    `7D
X  extres = smg$move_text
X    (&display_id,`20
X     &top_left_row,`20
X     &top_left_column,`20
X     &bottom_right_row,`20
X     &bottom_right_column,`20
X     &display_id2,`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &top_left_row2 : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &top_left_column2 : 0),`20
X     ((num_args > 8) && !si_booleanp (inarg_9) ? &flags : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$move_text */
X
X
X
Xextern long smg$name_to_keycode (/*character*/struct dsc$descriptor_s *, /*w
Vord*/unsigned short *);
Xstatic char sis_smg$name_to_keycode`5B`5D = "smg$name_to_keycode";
XSCM
Xsif_smg$name_to_keycode (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  struct dsc$descriptor_s key_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  unsigned short key_code;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$name_to_keycod
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_1), inarg_1, ARG1, sis_smg$name_to_keycode);
X      key_name = si_to_string (inarg_1);
X    `7D
X  extres = smg$name_to_keycode
X    (&key_name,`20
X     &key_code);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_unsigned_short (key_code);
X  return result;
X`7D /* sif_smg$name_to_keycode */
X
X
X
Xextern long smg$paste_virtual_display (/*longword*/long *, /*longword*/long
V *, /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$paste_virtual_display`5B`5D = "smg$paste_virtual_display
V";
XSCM
Xsif_smg$paste_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long pasteboard_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  long top_display_id;
X  ASSERT ((num_args >= 4) && (num_args <= 5), l, WNA, sis_smg$paste_virtual_
Vdisplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$paste_virtual_d
Visplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$paste_virtual_d
Visplay);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$paste_virtual_d
Visplay);
X      pasteboard_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$paste_virtual_d
Visplay);
X      pasteboard_column = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$paste_virtual_display);
X      if (!si_booleanp (inarg_5))      top_display_id = si_to_longword (inar
Vg_5);
X    `7D
X  extres = smg$paste_virtual_display
X    (&display_id,`20
X     &pasteboard_id,`20
X     &pasteboard_row,`20
X     &pasteboard_column,`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &top_display_id : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$paste_virtual_display */
X
X
X
Xextern long smg$put_chars (/*longword*/long *, /*character*/struct dsc$descr
Viptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*lon
Vgword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_chars`5B`5D = "smg$put_chars";
XSCM
Xsif_smg$put_chars (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long start_row;
X  long start_column;
X  long flags;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$put_chars);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_chars);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_chars);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_chars);
X      if (!si_booleanp (inarg_3))      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_chars);
X      if (!si_booleanp (inarg_4))      start_column = si_to_longword (inarg_
V4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_chars);
X      if (!si_booleanp (inarg_5))      flags = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_chars);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_chars);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$put_chars);
X      if (!si_booleanp (inarg_8))      character_set = si_to_longword (inarg
V_8);
X    `7D
X  extres = smg$put_chars
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_row : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &start_column : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &flags : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0),
V`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_chars */
X
X
X
Xextern long smg$put_chars_highwide (/*longword*/long *, /*character*/struct
V dsc$descriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/lon
Vg *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_chars_highwide`5B`5D = "smg$put_chars_highwide";
XSCM
Xsif_smg$put_chars_highwide (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long start_row;
X  long start_column;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 7), l, WNA, sis_smg$put_chars_high
Vwide);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_chars_highw
Vide);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_chars_highwid
Ve);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_chars_highwide);
X      if (!si_booleanp (inarg_3))      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_chars_highwide);
X      if (!si_booleanp (inarg_4))      start_column = si_to_longword (inarg_
V4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_chars_highwide);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_chars_highwide);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_chars_highwide);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_chars_highwide
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_row : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &start_column : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_chars_highwide */
X
X
X
Xextern long smg$put_chars_multi (/*longword*/long *, /*character*/struct dsc
V$descriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_chars_multi`5B`5D = "smg$put_chars_multi";
XSCM
Xsif_smg$put_chars_multi (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long line_number;
X  long column_number;
X  long flags;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$put_chars_mult
Vi);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_chars_multi
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_chars_multi);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_3))      line_number = si_to_longword (inarg_3
V);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_4))      column_number = si_to_longword (inarg
V_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_5))      flags = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$put_chars_multi);
X      if (!si_booleanp (inarg_8))      character_set = si_to_longword (inarg
V_8);
X    `7D
X  extres = smg$put_chars_multi
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &line_number : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &column_number : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &flags : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &rendition_complement : 0),
V`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_chars_multi */
X
X
X
Xextern long smg$put_chars_wide (/*longword*/long *, /*character*/struct dsc$
Vdescriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_chars_wide`5B`5D = "smg$put_chars_wide";
XSCM
Xsif_smg$put_chars_wide (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long start_row;
X  long start_column;
X  long rendition_set;
X  long rendition_complement;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 7), l, WNA, sis_smg$put_chars_wide
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_chars_wide)
V;
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_chars_wide);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_chars_wide);
X      if (!si_booleanp (inarg_3))      start_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_chars_wide);
X      if (!si_booleanp (inarg_4))      start_column = si_to_longword (inarg_
V4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_chars_wide);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_chars_wide);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_chars_wide);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_chars_wide
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_row : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &start_column : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_chars_wide */
X
X
X
Xextern long smg$put_help_text (/*longword*/long *, /*longword*/long *, /*cha
Vracter*/struct dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /
V*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_help_text`5B`5D = "smg$put_help_text";
XSCM
Xsif_smg$put_help_text (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  long display_id;
X  long keyboard_id;
X  struct dsc$descriptor_s help_topic = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0
V`7D;
X  struct dsc$descriptor_s help_library = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 1) && (num_args <= 6), l, WNA, sis_smg$put_help_text)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_help_text);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$put_help_text);
X      if (!si_booleanp (inarg_2))      keyboard_id = si_to_longword (inarg_2
V);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG3, sis_smg$put_help_text);
X      if (!si_booleanp (inarg_3))      help_topic = si_to_string (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4, AR
VG4, sis_smg$put_help_text);
X      if (!si_booleanp (inarg_4))      help_library = si_to_string (inarg_4)
V;
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_help_text);
X      if (!si_booleanp (inarg_5))      rendition_set = si_to_longword (inarg
V_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_help_text);
X      if (!si_booleanp (inarg_6))      rendition_complement = si_to_longword
V (inarg_6);
X    `7D
X  extres = smg$put_help_text
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &keyboard_id : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &help_topic : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &help_library : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_help_text */
X
X
X
Xextern long smg$put_line (/*longword*/long *, /*character*/struct dsc$descri
Vptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*long
Vword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_line`5B`5D = "smg$put_line";
XSCM
Xsif_smg$put_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long line_advance;
X  long rendition_set;
X  long rendition_complement;
X  long flags;
X  long character_set;
X  long direction;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$put_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_line);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_line);
X      if (!si_booleanp (inarg_3))      line_advance = si_to_longword (inarg_
V3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_line);
X      if (!si_booleanp (inarg_4))      rendition_set = si_to_longword (inarg
V_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_line);
X      if (!si_booleanp (inarg_5))      rendition_complement = si_to_longword
V (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_line);
X      if (!si_booleanp (inarg_6))      flags = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_line);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$put_line);
X      if (!si_booleanp (inarg_8))      direction = si_to_longword (inarg_8);
X    `7D
X  extres = smg$put_line
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &line_advance : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &rendition_set : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_complement : 0),
V`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &flags : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &direction : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_line */
X
X
X
Xextern long smg$put_line_highwide (/*longword*/long *, /*character*/struct d
Vsc$descriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long
V *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_line_highwide`5B`5D = "smg$put_line_highwide";
XSCM
Xsif_smg$put_line_highwide (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long line_advance;
X  long rendition_set;
X  long rendition_complement;
X  long flags;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 7), l, WNA, sis_smg$put_line_highw
Vide);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_line_highwi
Vde);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_line_highwide
V);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_line_highwide);
X      if (!si_booleanp (inarg_3))      line_advance = si_to_longword (inarg_
V3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_line_highwide);
X      if (!si_booleanp (inarg_4))      rendition_set = si_to_longword (inarg
V_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_line_highwide);
X      if (!si_booleanp (inarg_5))      rendition_complement = si_to_longword
V (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_line_highwide);
X      if (!si_booleanp (inarg_6))      flags = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_line_highwide);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_line_highwide
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &line_advance : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &rendition_set : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_complement : 0),
V`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &flags : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_line_highwide */
X
X
X
Xextern long smg$put_line_multi (/*longword*/long *, /*character*/struct dsc$
Vdescriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_line_multi`5B`5D = "smg$put_line_multi";
XSCM
Xsif_smg$put_line_multi (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long rendition_set;
X  long rendition_complement;
X  long line_advance;
X  long flags;
X  long direction;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$put_line_multi
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_line_multi)
V;
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_line_multi);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_3))      rendition_set = si_to_longword (inarg
V_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_4))      rendition_complement = si_to_longword
V (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_5))      line_advance = si_to_longword (inarg_
V5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_6))      flags = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_7))      direction = si_to_longword (inarg_7);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG8, sis_smg$put_line_multi);
X      if (!si_booleanp (inarg_8))      character_set = si_to_longword (inarg
V_8);
X    `7D
X  extres = smg$put_line_multi
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &rendition_set : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &rendition_complement : 0),
V`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &line_advance : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &flags : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &direction : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_8) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_line_multi */
X
X
X
Xextern long smg$put_line_wide (/*longword*/long *, /*character*/struct dsc$d
Vescriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /
V*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_line_wide`5B`5D = "smg$put_line_wide";
XSCM
Xsif_smg$put_line_wide (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long line_advance;
X  long rendition_set;
X  long rendition_complement;
X  long flags;
X  long character_set;
X  ASSERT ((num_args >= 2) && (num_args <= 7), l, WNA, sis_smg$put_line_wide)
V;
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_line_wide);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_line_wide);
X      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_line_wide);
X      if (!si_booleanp (inarg_3))      line_advance = si_to_longword (inarg_
V3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_line_wide);
X      if (!si_booleanp (inarg_4))      rendition_set = si_to_longword (inarg
V_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_line_wide);
X      if (!si_booleanp (inarg_5))      rendition_complement = si_to_longword
V (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_line_wide);
X      if (!si_booleanp (inarg_6))      flags = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_line_wide);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_line_wide
X    (&display_id,`20
X     &text,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &line_advance : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &rendition_set : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_complement : 0),
V`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &flags : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_line_wide */
X
X
X
Xextern long smg$pop_virtual_display (/*longword*/long *, /*longword*/long *)
V;
Xstatic char sis_smg$pop_virtual_display`5B`5D = "smg$pop_virtual_display";
XSCM
Xsif_smg$pop_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long pasteboard_id;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$pop_virtual_di
Vsplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$pop_virtual_dis
Vplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$pop_virtual_dis
Vplay);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  extres = smg$pop_virtual_display
X    (&display_id,`20
X     &pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$pop_virtual_display */
X
X
X
Xextern long smg$put_pasteboard (/*longword*/long *, /*address*/long, /*any*/
Vlong, /*longword*/long *);
Xstatic char sis_smg$put_pasteboard`5B`5D = "smg$put_pasteboard";
XSCM
Xsif_smg$put_pasteboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long pasteboard_id;
X  long action_routine;
X  long user_argument;
X  long flags;
X  ASSERT ((num_args >= 4) && (num_args <= 4), l, WNA, sis_smg$put_pasteboard
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_pasteboard)
V;
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$put_pasteboard)
V;
X      action_routine = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$put_pasteboard)
V;
X      user_argument = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$put_pasteboard)
V;
X      flags = si_to_longword (inarg_4);
X    `7D
X  extres = smg$put_pasteboard
X    (&pasteboard_id,`20
X     action_routine,`20
X     user_argument,`20
X     &flags);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_pasteboard */
X
X
X
Xextern long smg$print_pasteboard (/*longword*/long *, /*character*/struct ds
Vc$descriptor_s *, /*longword*/long *, /*character*/struct dsc$descriptor_s *
V);
Xstatic char sis_smg$print_pasteboard`5B`5D = "smg$print_pasteboard";
XSCM
Xsif_smg$print_pasteboard (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long pasteboard_id;
X  struct dsc$descriptor_s queue_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0
V`7D;
X  long copies;
X  struct dsc$descriptor_s form_name = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`
V7D;
X  ASSERT ((num_args >= 1) && (num_args <= 4), l, WNA, sis_smg$print_pasteboa
Vrd);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$print_pasteboar
Vd);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$print_pasteboard);
X      if (!si_booleanp (inarg_2))      queue_name = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$print_pasteboard);
X      if (!si_booleanp (inarg_3))      copies = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4, AR
VG4, sis_smg$print_pasteboard);
X      if (!si_booleanp (inarg_4))      form_name = si_to_string (inarg_4);
X    `7D
X  extres = smg$print_pasteboard
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &queue_name : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &copies : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &form_name : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$print_pasteboard */
X
X
X
Xextern long smg$put_status_line (/*longword*/long *, /*character*/struct dsc
V$descriptor_s *);
Xstatic char sis_smg$put_status_line`5B`5D = "smg$put_status_line";
XSCM
Xsif_smg$put_status_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$put_status_lin
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_status_line
V);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2), inarg_2, ARG2, sis_smg$put_status_line);
X      text = si_to_string (inarg_2);
X    `7D
X  extres = smg$put_status_line
X    (&pasteboard_id,`20
X     &text);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_status_line */
X
X
X
Xextern long smg$put_virtual_display_encoded (/*longword*/long *, /*longword*
V/long *, /*any*/long *, /*longword*/long *, /*longword*/long *, /*longword*/
Vlong *, /*longword*/long *);
Xstatic char sis_smg$put_virtual_display_encoded`5B`5D = "smg$put_virtual_dis
Vplay_encoded";
XSCM
Xsif_smg$put_virtual_display_encoded (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  long encoded_length;
X  long encoded_text;
X  long start_row;
X  long start_column;
X  long placeholder_argument;
X  long character_set;
X  ASSERT ((num_args >= 3) && (num_args <= 7), l, WNA, sis_smg$put_virtual_di
Vsplay_encoded);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_virtual_dis
Vplay_encoded);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$put_virtual_dis
Vplay_encoded);
X      encoded_length = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$put_virtual_dis
Vplay_encoded);
X      encoded_text = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_virtual_display_encoded);
X      if (!si_booleanp (inarg_4))      start_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_virtual_display_encoded);
X      if (!si_booleanp (inarg_5))      start_column = si_to_longword (inarg_
V5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_virtual_display_encoded);
X      if (!si_booleanp (inarg_6))      placeholder_argument = si_to_longword
V (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_virtual_display_encoded);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_virtual_display_encoded
X    (&display_id,`20
X     &encoded_length,`20
X     &encoded_text,`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &start_row : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &start_column : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &placeholder_argument : 0),
V`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_virtual_display_encoded */
X
X
X
Xextern long smg$put_with_scroll (/*longword*/long *, /*character*/struct dsc
V$descriptor_s *, /*longword*/long *, /*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$put_with_scroll`5B`5D = "smg$put_with_scroll";
XSCM
Xsif_smg$put_with_scroll (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  struct dsc$descriptor_s text = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7D;
X  long direction;
X  long rendition_set;
X  long rendition_complement;
X  long flags;
X  long character_set;
X  ASSERT ((num_args >= 1) && (num_args <= 7), l, WNA, sis_smg$put_with_scrol
Vl);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$put_with_scroll
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_2))      text = si_to_string (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_3))      direction = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_4))      rendition_set = si_to_longword (inarg
V_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_5))      rendition_complement = si_to_longword
V (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_6))      flags = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$put_with_scroll);
X      if (!si_booleanp (inarg_7))      character_set = si_to_longword (inarg
V_7);
X    `7D
X  extres = smg$put_with_scroll
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &text : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &direction : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &rendition_set : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &rendition_complement : 0),
V`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &flags : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &character_set : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$put_with_scroll */
X
X
X
Xextern long smg$ring_bell (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$ring_bell`5B`5D = "smg$ring_bell";
XSCM
Xsif_smg$ring_bell (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long number_of_times;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$ring_bell);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$ring_bell);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$ring_bell);
X      if (!si_booleanp (inarg_2))      number_of_times = si_to_longword (ina
Vrg_2);
X    `7D
X  extres = smg$ring_bell
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &number_of_times : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$ring_bell */
X
X
X
Xextern long smg$read_composed_line (/*longword*/long *, /*longword*/long *,
V /*character*/struct dsc$descriptor_s *, /*character*/struct dsc$descriptor_
Vs *, /*word*/unsigned short *, /*longword*/long *, /*longword*/long *, /*cha
Vracter*/struct dsc$descriptor_s *, /*longword*/long *, /*longword*/long *, /
V*longword*/long *, /*word*/unsigned short *);
Xstatic char sis_smg$read_composed_line`5B`5D = "smg$read_composed_line";
XSCM
Xsif_smg$read_composed_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_4;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  SCM inarg_9;
X  SCM inarg_10;
X  SCM inarg_11;
X  long keyboard_id;
X  long key_table_id;
X  struct dsc$descriptor_s resultant_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s prompt_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  unsigned short resultant_length;
X  long display_id;
X  long flags;
X  struct dsc$descriptor_s initial_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  long timeout;
X  long rendition_set;
X  long rendition_complement;
X  unsigned short word_terminator_code;
X  ASSERT ((num_args >= 2) && (num_args <= 9), l, WNA, sis_smg$read_composed_
Vline);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$read_composed_l
Vine);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$read_composed_l
Vine);
X      key_table_id = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4, AR
VG3, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_4))      prompt_string = si_to_string (inarg_4
V);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG4, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_6))      display_id = si_to_longword (inarg_6)
V;
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG5, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_7))      flags = si_to_longword (inarg_7);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8, AR
VG6, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_8))      initial_string = si_to_string (inarg_
V8);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_9 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_9) `7C`7C si_booleanp (inarg_9), inarg_9,
V ARG7, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_9))      timeout = si_to_longword (inarg_9);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_10 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_10) `7C`7C si_booleanp (inarg_10), inarg_1
V0, ARG8, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_10))      rendition_set = si_to_longword (inar
Vg_10);
X    `7D
X  if (num_args > 8)
X    `7B
X      inarg_11 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_11) `7C`7C si_booleanp (inarg_11), inarg_1
V1, ARG9, sis_smg$read_composed_line);
X      if (!si_booleanp (inarg_11))      rendition_complement = si_to_longwor
Vd (inarg_11);
X    `7D
X  extres = smg$read_composed_line
X    (&keyboard_id,`20
X     &key_table_id,`20
X     &resultant_string,`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &prompt_string : 0),`20
X     &resultant_length,`20
X     ((num_args > 3) && !si_booleanp (inarg_6) ? &display_id : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_7) ? &flags : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_8) ? &initial_string : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_9) ? &timeout : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_10) ? &rendition_set : 0),`20
X     ((num_args > 8) && !si_booleanp (inarg_11) ? &rendition_complement : 0)
V,`20
X     &word_terminator_code);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (resultant_string);
X  *data++ = si_from_unsigned_short (resultant_length);
X  *data++ = si_from_unsigned_short (word_terminator_code);
X  return result;
X`7D /* sif_smg$read_composed_line */
X
X
X
Xextern long smg$remove_line (/*longword*/long *, /*longword*/long *, /*longw
Vord*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$remove_line`5B`5D = "smg$remove_line";
XSCM
Xsif_smg$remove_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long start_row;
X  long start_column;
X  long end_row;
X  long end_column;
X  ASSERT ((num_args >= 5) && (num_args <= 5), l, WNA, sis_smg$remove_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$remove_line);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$remove_line);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$remove_line);
X      start_column = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$remove_line);
X      end_row = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5), inarg_5, ARG5, sis_smg$remove_line);
X      end_column = si_to_longword (inarg_5);
X    `7D
X  extres = smg$remove_line
X    (&display_id,`20
X     &start_row,`20
X     &start_column,`20
X     &end_row,`20
X     &end_column);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$remove_line */
X
X
X
Xextern long smg$replace_input_line (/*longword*/long *, /*character*/struct
V dsc$descriptor_s *, /*byte*/unsigned char*);
Xstatic char sis_smg$replace_input_line`5B`5D = "smg$replace_input_line";
XSCM
Xsif_smg$replace_input_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long keyboard_id;
X  struct dsc$descriptor_s replace_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  unsigned char line_count;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$replace_input_
Vline);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$replace_input_l
Vine);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$replace_input_line);
X      if (!si_booleanp (inarg_2))      replace_string = si_to_string (inarg_
V2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_charp (inarg_3) `7C`7C si_booleanp (inarg_3), inar
Vg_3, ARG3, sis_smg$replace_input_line);
X      if (!si_booleanp (inarg_3))      line_count = si_to_unsigned_char (ina
Vrg_3);
X    `7D
X  extres = smg$replace_input_line
X    (&keyboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &replace_string : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &line_count : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$replace_input_line */
X
X
X
Xextern long smg$return_input_line (/*longword*/long *, /*character*/struct d
Vsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /*byte*/unsigned
V char*, /*word*/unsigned short *);
Xstatic char sis_smg$return_input_line`5B`5D = "smg$return_input_line";
XSCM
Xsif_smg$return_input_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  long keyboard_id;
X  struct dsc$descriptor_s resultant_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s match_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  unsigned char byte_integer_line_number;
X  unsigned short resultant_length;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$return_input_l
Vine);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$return_input_li
Vne);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG2, sis_smg$return_input_line);
X      if (!si_booleanp (inarg_3))      match_string = si_to_string (inarg_3)
V;
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_charp (inarg_4) `7C`7C si_booleanp (inarg_4), inar
Vg_4, ARG3, sis_smg$return_input_line);
X      if (!si_booleanp (inarg_4))      byte_integer_line_number = si_to_unsi
Vgned_char (inarg_4);
X    `7D
X  extres = smg$return_input_line
X    (&keyboard_id,`20
X     &resultant_string,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &match_string : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &byte_integer_line_number :
V 0),`20
X     &resultant_length);
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (resultant_string);
X  *data++ = si_from_unsigned_short (resultant_length);
X  return result;
X`7D /* sif_smg$return_input_line */
X
X
X
Xextern long smg$read_from_display (/*longword*/long *, /*character*/struct d
Vsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/long
V *);
Xstatic char sis_smg$read_from_display`5B`5D = "smg$read_from_display";
XSCM
Xsif_smg$read_from_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  long display_id;
X  struct dsc$descriptor_s resultant_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s terminator_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLA
VSS_S, 0`7D;
X  long start_row;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$read_from_disp
Vlay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$read_from_displ
Vay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG2, sis_smg$read_from_display);
X      if (!si_booleanp (inarg_3))      terminator_string = si_to_string (ina
Vrg_3);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$read_from_display);
X      if (!si_booleanp (inarg_4))      start_row = si_to_longword (inarg_4);
X    `7D
X  extres = smg$read_from_display
X    (&display_id,`20
X     &resultant_string,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &terminator_string : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &start_row : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (resultant_string);
X  return result;
X`7D /* sif_smg$read_from_display */
X
X
X
Xextern long smg$read_keystroke (/*longword*/long *, /*word*/unsigned short *
V, /*character*/struct dsc$descriptor_s *, /*longword*/long *, /*longword*/lo
Vng *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$read_keystroke`5B`5D = "smg$read_keystroke";
XSCM
Xsif_smg$read_keystroke (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long keyboard_id;
X  unsigned short word_terminator_code;
X  struct dsc$descriptor_s prompt_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  long timeout;
X  long display_id;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 1) && (num_args <= 6), l, WNA, sis_smg$read_keystroke
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$read_keystroke)
V;
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG2, sis_smg$read_keystroke);
X      if (!si_booleanp (inarg_3))      prompt_string = si_to_string (inarg_3
V);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$read_keystroke);
X      if (!si_booleanp (inarg_4))      timeout = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG4, sis_smg$read_keystroke);
X      if (!si_booleanp (inarg_5))      display_id = si_to_longword (inarg_5)
V;
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG5, sis_smg$read_keystroke);
X      if (!si_booleanp (inarg_6))      rendition_set = si_to_longword (inarg
V_6);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG6, sis_smg$read_keystroke);
X      if (!si_booleanp (inarg_7))      rendition_complement = si_to_longword
V (inarg_7);
X    `7D
X  extres = smg$read_keystroke
X    (&keyboard_id,`20
X     &word_terminator_code,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &prompt_string : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &timeout : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_5) ? &display_id : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_6) ? &rendition_set : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_7) ? &rendition_complement : 0))
V;
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_unsigned_short (word_terminator_code);
X  return result;
X`7D /* sif_smg$read_keystroke */
X
X
X
Xextern long smg$repaint_line (/*longword*/long *, /*longword*/long *, /*long
Vword*/long *);
Xstatic char sis_smg$repaint_line`5B`5D = "smg$repaint_line";
XSCM
Xsif_smg$repaint_line (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long pasteboard_id;
X  long start_row;
X  long number_of_lines;
X  ASSERT ((num_args >= 2) && (num_args <= 3), l, WNA, sis_smg$repaint_line);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$repaint_line);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$repaint_line);
X      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$repaint_line);
X      if (!si_booleanp (inarg_3))      number_of_lines = si_to_longword (ina
Vrg_3);
X    `7D
X  extres = smg$repaint_line
X    (&pasteboard_id,`20
X     &start_row,`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &number_of_lines : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$repaint_line */
X
X
X
Xextern long smg$repaint_screen (/*longword*/long *);
Xstatic char sis_smg$repaint_screen`5B`5D = "smg$repaint_screen";
XSCM
Xsif_smg$repaint_screen (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long pasteboard_id;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$repaint_screen
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$repaint_screen)
V;
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$repaint_screen
X    (&pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$repaint_screen */
X
X
X
Xextern long smg$repaste_virtual_display (/*longword*/long *, /*longword*/lon
Vg *, /*longword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$repaste_virtual_display`5B`5D = "smg$repaste_virtual_dis
Vplay";
XSCM
Xsif_smg$repaste_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long display_id;
X  long pasteboard_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  long top_display_id;
X  ASSERT ((num_args >= 4) && (num_args <= 5), l, WNA, sis_smg$repaste_virtua
Vl_display);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$repaste_virtual
V_display);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$repaste_virtual
V_display);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$repaste_virtual
V_display);
X      pasteboard_row = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4), inarg_4, ARG4, sis_smg$repaste_virtual
V_display);
X      pasteboard_column = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$repaste_virtual_display);
X      if (!si_booleanp (inarg_5))      top_display_id = si_to_longword (inar
Vg_5);
X    `7D
X  extres = smg$repaste_virtual_display
X    (&display_id,`20
X     &pasteboard_id,`20
X     &pasteboard_row,`20
X     &pasteboard_column,`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &top_display_id : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$repaste_virtual_display */
X
X
X
Xextern long smg$restore_physical_screen (/*longword*/long *, /*longword*/lon
Vg *);
Xstatic char sis_smg$restore_physical_screen`5B`5D = "smg$restore_physical_sc
Vreen";
XSCM
Xsif_smg$restore_physical_screen (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  long display_id;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$restore_physic
Val_screen);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$restore_physica
Vl_screen);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$restore_physica
Vl_screen);
X      display_id = si_to_longword (inarg_2);
X    `7D
X  extres = smg$restore_physical_screen
X    (&pasteboard_id,`20
X     &display_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$restore_physical_screen */
X
X
X
Xextern long smg$read_string (/*longword*/long *, /*character*/struct dsc$des
Vcriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/long *, /*l
Vongword*/long *, /*longword*/long *, /*any*/long *, /*word*/unsigned short *
V, /*word*/unsigned short *, /*longword*/long *, /*character*/struct dsc$desc
Vriptor_s *, /*longword*/long *, /*longword*/long *, /*character*/struct dsc$
Vdescriptor_s *);
Xstatic char sis_smg$read_string`5B`5D = "smg$read_string";
XSCM
Xsif_smg$read_string (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_10;
X  SCM inarg_11;
X  SCM inarg_12;
X  SCM inarg_13;
X  SCM inarg_14;
X  long keyboard_id;
X  struct dsc$descriptor_s resultant_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s prompt_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  long maximum_length;
X  long modifiers;
X  long timeout;
X  long terminator_set;
X  unsigned short resultant_length;
X  unsigned short word_terminator_code;
X  long display_id;
X  struct dsc$descriptor_s initial_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  long rendition_set;
X  long rendition_complement;
X  struct dsc$descriptor_s terminator_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLA
VSS_S, 0`7D;
X  ASSERT ((num_args >= 1) && (num_args <= 11), l, WNA, sis_smg$read_string);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$read_string);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3, AR
VG2, sis_smg$read_string);
X      if (!si_booleanp (inarg_3))      prompt_string = si_to_string (inarg_3
V);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$read_string);
X      if (!si_booleanp (inarg_4))      maximum_length = si_to_longword (inar
Vg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG4, sis_smg$read_string);
X      if (!si_booleanp (inarg_5))      modifiers = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG5, sis_smg$read_string);
X      if (!si_booleanp (inarg_6))      timeout = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG6, sis_smg$read_string);
X      if (!si_booleanp (inarg_7))      terminator_set = si_to_longword (inar
Vg_7);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_10 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_10) `7C`7C si_booleanp (inarg_10), inarg_1
V0, ARG7, sis_smg$read_string);
X      if (!si_booleanp (inarg_10))      display_id = si_to_longword (inarg_1
V0);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_11 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_11) `7C`7C si_booleanp (inarg_11), inarg_11,
V ARG8, sis_smg$read_string);
X      if (!si_booleanp (inarg_11))      initial_string = si_to_string (inarg
V_11);
X    `7D
X  if (num_args > 8)
X    `7B
X      inarg_12 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_12) `7C`7C si_booleanp (inarg_12), inarg_1
V2, ARG9, sis_smg$read_string);
X      if (!si_booleanp (inarg_12))      rendition_set = si_to_longword (inar
Vg_12);
X    `7D
X  if (num_args > 9)
X    `7B
X      inarg_13 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_13) `7C`7C si_booleanp (inarg_13), inarg_1
V3, ARG10, sis_smg$read_string);
X      if (!si_booleanp (inarg_13))      rendition_complement = si_to_longwor
Vd (inarg_13);
X    `7D
X  if (num_args > 10)
X    `7B
X      inarg_14 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_14) `7C`7C si_booleanp (inarg_14), inarg_14,
V ARG11, sis_smg$read_string);
X      if (!si_booleanp (inarg_14))      terminator_string = si_to_string (in
Varg_14);
X    `7D
X  extres = smg$read_string
X    (&keyboard_id,`20
X     &resultant_string,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &prompt_string : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &maximum_length : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_5) ? &modifiers : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_6) ? &timeout : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_7) ? &terminator_set : 0),`20
X     &resultant_length,`20
X     &word_terminator_code,`20
X     ((num_args > 6) && !si_booleanp (inarg_10) ? &display_id : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_11) ? &initial_string : 0),`20
X     ((num_args > 8) && !si_booleanp (inarg_12) ? &rendition_set : 0),`20
X     ((num_args > 9) && !si_booleanp (inarg_13) ? &rendition_complement : 0)
V,`20
X     ((num_args > 10) && !si_booleanp (inarg_14) ? &terminator_string : 0));
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (resultant_string);
X  *data++ = si_from_unsigned_short (resultant_length);
X  *data++ = si_from_unsigned_short (word_terminator_code);
X  return result;
X`7D /* sif_smg$read_string */
X
X
X
Xextern long smg$return_cursor_pos (/*longword*/long *, /*longword*/long *, /
V*longword*/long *);
Xstatic char sis_smg$return_cursor_pos`5B`5D = "smg$return_cursor_pos";
XSCM
Xsif_smg$return_cursor_pos (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  long display_id;
X  long start_row;
X  long start_column;
X  ASSERT ((num_args >= 1) && (num_args <= 1), l, WNA, sis_smg$return_cursor_
Vpos);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$return_cursor_p
Vos);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  extres = smg$return_cursor_pos
X    (&display_id,`20
X     &start_row,`20
X     &start_column);
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (start_row);
X  *data++ = si_from_longword (start_column);
X  return result;
X`7D /* sif_smg$return_cursor_pos */
X
X
X
Xextern long smg$read_verify (/*longword*/long *, /*character*/struct dsc$des
Vcriptor_s *, /*character*/struct dsc$descriptor_s *, /*character*/struct dsc
V$descriptor_s *, /*character*/struct dsc$descriptor_s *, /*character*/struct
V dsc$descriptor_s *, /*character*/struct dsc$descriptor_s *, /*longword*/lon
Vg *, /*longword*/long *, /*any*/long *, /*longword*/long *, /*word*/unsigned
V short *, /*longword*/long *, /*character*/struct dsc$descriptor_s *, /*long
Vword*/long *, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$read_verify`5B`5D = "smg$read_verify";
XSCM
Xsif_smg$read_verify (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_8;
X  SCM inarg_9;
X  SCM inarg_10;
X  SCM inarg_11;
X  SCM inarg_13;
X  SCM inarg_14;
X  SCM inarg_15;
X  SCM inarg_16;
X  SCM inarg_17;
X  long keyboard_id;
X  struct dsc$descriptor_s resultant_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLAS
VS_S, 0`7D;
X  struct dsc$descriptor_s initial_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  struct dsc$descriptor_s picture_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  struct dsc$descriptor_s fill_character = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_
VS, 0`7D;
X  struct dsc$descriptor_s clear_character = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS
V_S, 0`7D;
X  struct dsc$descriptor_s prompt_string = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S
V, 0`7D;
X  long modifiers;
X  long timeout;
X  long terminator_set;
X  long initial_offset;
X  unsigned short word_terminator_code;
X  long display_id;
X  struct dsc$descriptor_s alternate_echo_string = `7B0, DSC$K_DTYPE_T, DSC$K
V_CLASS_S, 0`7D;
X  long alternate_display_id;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 5) && (num_args <= 15), l, WNA, sis_smg$read_verify);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$read_verify);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_3), inarg_3, ARG2, sis_smg$read_verify);
X      initial_string = si_to_string (inarg_3);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_4), inarg_4, ARG3, sis_smg$read_verify);
X      picture_string = si_to_string (inarg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_5), inarg_5, ARG4, sis_smg$read_verify);
X      fill_character = si_to_string (inarg_5);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_6), inarg_6, ARG5, sis_smg$read_verify);
X      clear_character = si_to_string (inarg_6);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7, AR
VG6, sis_smg$read_verify);
X      if (!si_booleanp (inarg_7))      prompt_string = si_to_string (inarg_7
V);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_8 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_8) `7C`7C si_booleanp (inarg_8), inarg_8,
V ARG7, sis_smg$read_verify);
X      if (!si_booleanp (inarg_8))      modifiers = si_to_longword (inarg_8);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_9 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_9) `7C`7C si_booleanp (inarg_9), inarg_9,
V ARG8, sis_smg$read_verify);
X      if (!si_booleanp (inarg_9))      timeout = si_to_longword (inarg_9);
X    `7D
X  if (num_args > 8)
X    `7B
X      inarg_10 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_10) `7C`7C si_booleanp (inarg_10), inarg_1
V0, ARG9, sis_smg$read_verify);
X      if (!si_booleanp (inarg_10))      terminator_set = si_to_longword (ina
Vrg_10);
X    `7D
X  if (num_args > 9)
X    `7B
X      inarg_11 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_11) `7C`7C si_booleanp (inarg_11), inarg_1
V1, ARG10, sis_smg$read_verify);
X      if (!si_booleanp (inarg_11))      initial_offset = si_to_longword (ina
Vrg_11);
X    `7D
X  if (num_args > 10)
X    `7B
X      inarg_13 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_13) `7C`7C si_booleanp (inarg_13), inarg_1
V3, ARG11, sis_smg$read_verify);
X      if (!si_booleanp (inarg_13))      display_id = si_to_longword (inarg_1
V3);
X    `7D
X  if (num_args > 11)
X    `7B
X      inarg_14 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_14) `7C`7C si_booleanp (inarg_14), inarg_14,
V ARG12, sis_smg$read_verify);
X      if (!si_booleanp (inarg_14))      alternate_echo_string = si_to_string
V (inarg_14);
X    `7D
X  if (num_args > 12)
X    `7B
X      inarg_15 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_15) `7C`7C si_booleanp (inarg_15), inarg_1
V5, ARG13, sis_smg$read_verify);
X      if (!si_booleanp (inarg_15))      alternate_display_id = si_to_longwor
Vd (inarg_15);
X    `7D
X  if (num_args > 13)
X    `7B
X      inarg_16 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_16) `7C`7C si_booleanp (inarg_16), inarg_1
V6, ARG14, sis_smg$read_verify);
X      if (!si_booleanp (inarg_16))      rendition_set = si_to_longword (inar
Vg_16);
X    `7D
X  if (num_args > 14)
X    `7B
X      inarg_17 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_17) `7C`7C si_booleanp (inarg_17), inarg_1
V7, ARG15, sis_smg$read_verify);
X      if (!si_booleanp (inarg_17))      rendition_complement = si_to_longwor
Vd (inarg_17);
X    `7D
X  extres = smg$read_verify
X    (&keyboard_id,`20
X     &resultant_string,`20
X     &initial_string,`20
X     &picture_string,`20
X     &fill_character,`20
X     &clear_character,`20
X     ((num_args > 5) && !si_booleanp (inarg_7) ? &prompt_string : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_8) ? &modifiers : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_9) ? &timeout : 0),`20
X     ((num_args > 8) && !si_booleanp (inarg_10) ? &terminator_set : 0),`20
X     ((num_args > 9) && !si_booleanp (inarg_11) ? &initial_offset : 0),`20
X     &word_terminator_code,`20
X     ((num_args > 10) && !si_booleanp (inarg_13) ? &display_id : 0),`20
X     ((num_args > 11) && !si_booleanp (inarg_14) ? &alternate_echo_string :
V 0),`20
X     ((num_args > 12) && !si_booleanp (inarg_15) ? &alternate_display_id : 0
V),`20
X     ((num_args > 13) && !si_booleanp (inarg_16) ? &rendition_set : 0),`20
X     ((num_args > 14) && !si_booleanp (inarg_17) ? &rendition_complement : 0
V));
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (resultant_string);
X  *data++ = si_from_unsigned_short (word_terminator_code);
X  return result;
X`7D /* sif_smg$read_verify */
X
X
X
Xextern long smg$set_broadcast_trapping (/*longword*/long *, /*address*/long,
V /*longword*/long);
Xstatic char sis_smg$set_broadcast_trapping`5B`5D = "smg$set_broadcast_trappi
Vng";
XSCM
Xsif_smg$set_broadcast_trapping (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long pasteboard_id;
X  long ast_routine;
X  long ast_argument;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$set_broadcast_
Vtrapping);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_broadcast_t
Vrapping);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$set_broadcast_trapping);
X      if (!si_booleanp (inarg_2))      ast_routine = si_to_longword (inarg_2
V);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$set_broadcast_trapping);
X      if (!si_booleanp (inarg_3))      ast_argument = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$set_broadcast_trapping
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? ast_routine : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? ast_argument : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_broadcast_trapping */
X
X
X
Xextern long smg$scroll_display_area (/*longword*/long *, /*longword*/long *,
V /*longword*/long *, /*longword*/long *, /*longword*/long *, /*longword*/lon
Vg *, /*longword*/long *);
Xstatic char sis_smg$scroll_display_area`5B`5D = "smg$scroll_display_area";
XSCM
Xsif_smg$scroll_display_area (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  long display_id;
X  long start_row;
X  long start_column;
X  long height;
X  long width;
X  long direction;
X  long count;
X  ASSERT ((num_args >= 1) && (num_args <= 7), l, WNA, sis_smg$scroll_display
V_area);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$scroll_display_
Varea);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_3))      start_column = si_to_longword (inarg_
V3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_4))      height = si_to_longword (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_5))      width = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6,
V ARG6, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_6))      direction = si_to_longword (inarg_6);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG7, sis_smg$scroll_display_area);
X      if (!si_booleanp (inarg_7))      count = si_to_longword (inarg_7);
X    `7D
X  extres = smg$scroll_display_area
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_column : 0),`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &height : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &width : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_6) ? &direction : 0),`20
X     ((num_args > 6) && !si_booleanp (inarg_7) ? &count : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$scroll_display_area */
X
X
X
Xextern long smg$set_cursor_abs (/*longword*/long *, /*longword*/long *, /*lo
Vngword*/long *);
Xstatic char sis_smg$set_cursor_abs`5B`5D = "smg$set_cursor_abs";
XSCM
Xsif_smg$set_cursor_abs (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long start_row;
X  long start_column;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$set_cursor_abs
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_cursor_abs)
V;
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$set_cursor_abs);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$set_cursor_abs);
X      if (!si_booleanp (inarg_3))      start_column = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$set_cursor_abs
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &start_column : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_cursor_abs */
X
X
X
Xextern long smg$set_cursor_rel (/*longword*/long *, /*longword*/long *, /*lo
Vngword*/long *);
Xstatic char sis_smg$set_cursor_rel`5B`5D = "smg$set_cursor_rel";
XSCM
Xsif_smg$set_cursor_rel (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long delta_row;
X  long delta_column;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$set_cursor_rel
V);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_cursor_rel)
V;
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$set_cursor_rel);
X      if (!si_booleanp (inarg_2))      delta_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$set_cursor_rel);
X      if (!si_booleanp (inarg_3))      delta_column = si_to_longword (inarg_
V3);
X    `7D
X  extres = smg$set_cursor_rel
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &delta_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &delta_column : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_cursor_rel */
X
X
X
Xextern long smg$scroll_viewport (/*longword*/long *, /*longword*/long *, /*l
Vongword*/long *);
Xstatic char sis_smg$scroll_viewport`5B`5D = "smg$scroll_viewport";
XSCM
Xsif_smg$scroll_viewport (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long direction;
X  long count;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$scroll_viewpor
Vt);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$scroll_viewport
V);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$scroll_viewport);
X      if (!si_booleanp (inarg_2))      direction = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$scroll_viewport);
X      if (!si_booleanp (inarg_3))      count = si_to_longword (inarg_3);
X    `7D
X  extres = smg$scroll_viewport
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &direction : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &count : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$scroll_viewport */
X
X
X
Xextern long smg$set_display_scroll_region (/*longword*/long *, /*longword*/l
Vong *, /*longword*/long *);
Xstatic char sis_smg$set_display_scroll_region`5B`5D = "smg$set_display_scrol
Vl_region";
XSCM
Xsif_smg$set_display_scroll_region (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long display_id;
X  long start_row;
X  long end_row;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$set_display_sc
Vroll_region);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_display_scr
Voll_region);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$set_display_scroll_region);
X      if (!si_booleanp (inarg_2))      start_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$set_display_scroll_region);
X      if (!si_booleanp (inarg_3))      end_row = si_to_longword (inarg_3);
X    `7D
X  extres = smg$set_display_scroll_region
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &end_row : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_display_scroll_region */
X
X
X
Xextern long smg$select_from_menu (/*longword*/long *, /*longword*/long *, /*
Vword*/unsigned short *, /*word*/unsigned short *, /*longword*/long *, /*char
Vacter*/struct dsc$descriptor_s *, /*longword*/long *, /*word*/unsigned short
V *, /*character*/struct dsc$descriptor_s *, /*longword*/long *, /*longword*/
Vlong *);
Xstatic char sis_smg$select_from_menu`5B`5D = "smg$select_from_menu";
XSCM
Xsif_smg$select_from_menu (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_4;
X  SCM inarg_5;
X  SCM inarg_6;
X  SCM inarg_7;
X  SCM inarg_10;
X  SCM inarg_11;
X  long keyboard_id;
X  long display_id;
X  unsigned short selected_choice_number;
X  unsigned short default_choice_number;
X  long flags;
X  struct dsc$descriptor_s help_library = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S,
V 0`7D;
X  long timeout;
X  unsigned short terminator_code;
X  struct dsc$descriptor_s selected_choice_string = `7B0, DSC$K_DTYPE_T, DSC$
VK_CLASS_S, 0`7D;
X  long rendition_set;
X  long rendition_complement;
X  ASSERT ((num_args >= 2) && (num_args <= 8), l, WNA, sis_smg$select_from_me
Vnu);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$select_from_men
Vu);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$select_from_men
Vu);
X      display_id = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_unsigned_shortp (inarg_4) `7C`7C si_booleanp (inarg_4), ina
Vrg_4, ARG3, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_4))      default_choice_number = si_to_unsigne
Vd_short (inarg_4);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG4, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_5))      flags = si_to_longword (inarg_5);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_6 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_6) `7C`7C si_booleanp (inarg_6), inarg_6, AR
VG5, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_6))      help_library = si_to_string (inarg_6)
V;
X    `7D
X  if (num_args > 5)
X    `7B
X      inarg_7 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_7) `7C`7C si_booleanp (inarg_7), inarg_7,
V ARG6, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_7))      timeout = si_to_longword (inarg_7);
X    `7D
X  if (num_args > 6)
X    `7B
X      inarg_10 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_10) `7C`7C si_booleanp (inarg_10), inarg_1
V0, ARG7, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_10))      rendition_set = si_to_longword (inar
Vg_10);
X    `7D
X  if (num_args > 7)
X    `7B
X      inarg_11 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_11) `7C`7C si_booleanp (inarg_11), inarg_1
V1, ARG8, sis_smg$select_from_menu);
X      if (!si_booleanp (inarg_11))      rendition_complement = si_to_longwor
Vd (inarg_11);
X    `7D
X  extres = smg$select_from_menu
X    (&keyboard_id,`20
X     &display_id,`20
X     &selected_choice_number,`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &default_choice_number : 0)
V,`20
X     ((num_args > 3) && !si_booleanp (inarg_5) ? &flags : 0),`20
X     ((num_args > 4) && !si_booleanp (inarg_6) ? &help_library : 0),`20
X     ((num_args > 5) && !si_booleanp (inarg_7) ? &timeout : 0),`20
X     &terminator_code,`20
X     &selected_choice_string,`20
X     ((num_args > 6) && !si_booleanp (inarg_10) ? &rendition_set : 0),`20
X     ((num_args > 7) && !si_booleanp (inarg_11) ? &rendition_complement : 0)
V);
X  result = make_vector (MAKINUM (3+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_unsigned_short (selected_choice_number);
X  *data++ = si_from_unsigned_short (terminator_code);
X  *data++ = si_from_string (selected_choice_string);
X  return result;
X`7D /* sif_smg$select_from_menu */
X
X
X
Xextern long smg$set_cursor_mode (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$set_cursor_mode`5B`5D = "smg$set_cursor_mode";
XSCM
Xsif_smg$set_cursor_mode (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  long flags;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$set_cursor_mod
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_cursor_mode
V);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$set_cursor_mode
V);
X      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$set_cursor_mode
X    (&pasteboard_id,`20
X     &flags);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_cursor_mode */
X
X
X
Xextern long smg$set_keypad_mode (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$set_keypad_mode`5B`5D = "smg$set_keypad_mode";
XSCM
Xsif_smg$set_keypad_mode (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long keyboard_id;
X  long flags;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$set_keypad_mod
Ve);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_keypad_mode
V);
X      keyboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$set_keypad_mode
V);
X      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$set_keypad_mode
X    (&keyboard_id,`20
X     &flags);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_keypad_mode */
X
X
X
Xextern long smg$snapshot (/*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$snapshot`5B`5D = "smg$snapshot";
XSCM
Xsif_smg$snapshot (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long pasteboard_id;
X  long flags;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$snapshot);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$snapshot);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$snapshot);
X      if (!si_booleanp (inarg_2))      flags = si_to_longword (inarg_2);
X    `7D
X  extres = smg$snapshot
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &flags : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$snapshot */
X
X
X
Xextern long smg$set_out_of_band_asts (/*longword*/long *, /*longword*/long *
V, /*address*/long, /*longword*/long);
Xstatic char sis_smg$set_out_of_band_asts`5B`5D = "smg$set_out_of_band_asts";
XSCM
Xsif_smg$set_out_of_band_asts (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  long pasteboard_id;
X  long control_character_mask;
X  long ast_routine;
X  long ast_argument;
X  ASSERT ((num_args >= 3) && (num_args <= 4), l, WNA, sis_smg$set_out_of_ban
Vd_asts);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_out_of_band
V_asts);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$set_out_of_band
V_asts);
X      control_character_mask = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$set_out_of_band
V_asts);
X      ast_routine = si_to_longword (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$set_out_of_band_asts);
X      if (!si_booleanp (inarg_4))      ast_argument = si_to_longword (inarg_
V4);
X    `7D
X  extres = smg$set_out_of_band_asts
X    (&pasteboard_id,`20
X     &control_character_mask,`20
X     ast_routine,`20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? ast_argument : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_out_of_band_asts */
X
X
X
Xextern long smg$set_physical_cursor (/*longword*/long *, /*longword*/long *,
V /*longword*/long *);
Xstatic char sis_smg$set_physical_cursor`5B`5D = "smg$set_physical_cursor";
XSCM
Xsif_smg$set_physical_cursor (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  long pasteboard_id;
X  long pasteboard_row;
X  long pasteboard_column;
X  ASSERT ((num_args >= 3) && (num_args <= 3), l, WNA, sis_smg$set_physical_c
Vursor);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_physical_cu
Vrsor);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$set_physical_cu
Vrsor);
X      pasteboard_row = si_to_longword (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3), inarg_3, ARG3, sis_smg$set_physical_cu
Vrsor);
X      pasteboard_column = si_to_longword (inarg_3);
X    `7D
X  extres = smg$set_physical_cursor
X    (&pasteboard_id,`20
X     &pasteboard_row,`20
X     &pasteboard_column);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$set_physical_cursor */
X
X
X
Xextern long smg$set_default_state (/*longword*/long *, /*character*/struct d
Vsc$descriptor_s *, /*character*/struct dsc$descriptor_s *);
Xstatic char sis_smg$set_default_state`5B`5D = "smg$set_default_state";
XSCM
Xsif_smg$set_default_state (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long key_table_id;
X  struct dsc$descriptor_s new_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`
V7D;
X  struct dsc$descriptor_s old_state = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`
V7D;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$set_default_st
Vate);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_default_sta
Vte);
X      key_table_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$set_default_state);
X      if (!si_booleanp (inarg_2))      new_state = si_to_string (inarg_2);
X    `7D
X  extres = smg$set_default_state
X    (&key_table_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &new_state : 0),`20
X     &old_state);
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_string (old_state);
X  return result;
X`7D /* sif_smg$set_default_state */
X
X
X
Xextern long smg$set_term_characteristics (/*longword*/long *, /*longword*/lo
Vng *, /*longword*/long *, /*longword*/long *, /*longword*/long *, /*longword
V*/long *, /*longword*/long *);
Xstatic char sis_smg$set_term_characteristics`5B`5D = "smg$set_term_character
Vistics";
XSCM
Xsif_smg$set_term_characteristics (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  SCM inarg_3;
X  SCM inarg_4;
X  SCM inarg_5;
X  long pasteboard_id;
X  long on_characteristics1;
X  long on_characteristics2;
X  long off_characteristics1;
X  long off_characteristics2;
X  long old_characteristics1;
X  long old_characteristics2;
X  ASSERT ((num_args >= 1) && (num_args <= 5), l, WNA, sis_smg$set_term_chara
Vcteristics);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$set_term_charac
Vteristics);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2,
V ARG2, sis_smg$set_term_characteristics);
X      if (!si_booleanp (inarg_2))      on_characteristics1 = si_to_longword
V (inarg_2);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG3, sis_smg$set_term_characteristics);
X      if (!si_booleanp (inarg_3))      on_characteristics2 = si_to_longword
V (inarg_3);
X    `7D
X  if (num_args > 3)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG4, sis_smg$set_term_characteristics);
X      if (!si_booleanp (inarg_4))      off_characteristics1 = si_to_longword
V (inarg_4);
X    `7D
X  if (num_args > 4)
X    `7B
X      inarg_5 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_5) `7C`7C si_booleanp (inarg_5), inarg_5,
V ARG5, sis_smg$set_term_characteristics);
X      if (!si_booleanp (inarg_5))      off_characteristics2 = si_to_longword
V (inarg_5);
X    `7D
X  extres = smg$set_term_characteristics
X    (&pasteboard_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &on_characteristics1 : 0),`
V20
X     ((num_args > 2) && !si_booleanp (inarg_3) ? &on_characteristics2 : 0),`
V20
X     ((num_args > 3) && !si_booleanp (inarg_4) ? &off_characteristics1 : 0),
V`20
X     ((num_args > 4) && !si_booleanp (inarg_5) ? &off_characteristics2 : 0),
V`20
X     &old_characteristics1,`20
X     &old_characteristics2);
X  result = make_vector (MAKINUM (2+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (old_characteristics1);
X  *data++ = si_from_longword (old_characteristics2);
X  return result;
X`7D /* sif_smg$set_term_characteristics */
X
X
X
Xextern long smg$save_virtual_display (/*longword*/long *, /*character*/struc
Vt dsc$descriptor_s *);
Xstatic char sis_smg$save_virtual_display`5B`5D = "smg$save_virtual_display";
XSCM
Xsif_smg$save_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  struct dsc$descriptor_s filespec = `7B0, DSC$K_DTYPE_T, DSC$K_CLASS_S, 0`7
VD;
X  ASSERT ((num_args >= 1) && (num_args <= 2), l, WNA, sis_smg$save_virtual_d
Visplay);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$save_virtual_di
Vsplay);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_stringp (inarg_2) `7C`7C si_booleanp (inarg_2), inarg_2, AR
VG2, sis_smg$save_virtual_display);
X      if (!si_booleanp (inarg_2))      filespec = si_to_string (inarg_2);
X    `7D
X  extres = smg$save_virtual_display
X    (&display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_2) ? &filespec : 0));
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$save_virtual_display */
X
X
X
Xextern long smg$save_physical_screen (/*longword*/long *, /*longword*/long *
V, /*longword*/long *, /*longword*/long *);
Xstatic char sis_smg$save_physical_screen`5B`5D = "smg$save_physical_screen";
XSCM
Xsif_smg$save_physical_screen (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_3;
X  SCM inarg_4;
X  long pasteboard_id;
X  long display_id;
X  long desired_start_row;
X  long desired_end_row;
X  ASSERT ((num_args >= 1) && (num_args <= 3), l, WNA, sis_smg$save_physical_
Vscreen);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$save_physical_s
Vcreen);
X      pasteboard_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_3 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_3) `7C`7C si_booleanp (inarg_3), inarg_3,
V ARG2, sis_smg$save_physical_screen);
X      if (!si_booleanp (inarg_3))      desired_start_row = si_to_longword (i
Vnarg_3);
X    `7D
X  if (num_args > 2)
X    `7B
X      inarg_4 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_4) `7C`7C si_booleanp (inarg_4), inarg_4,
V ARG3, sis_smg$save_physical_screen);
X      if (!si_booleanp (inarg_4))      desired_end_row = si_to_longword (ina
Vrg_4);
X    `7D
X  extres = smg$save_physical_screen
X    (&pasteboard_id,`20
X     &display_id,`20
X     ((num_args > 1) && !si_booleanp (inarg_3) ? &desired_start_row : 0),`20
X     ((num_args > 2) && !si_booleanp (inarg_4) ? &desired_end_row : 0));
X  result = make_vector (MAKINUM (1+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  *data++ = si_from_longword (display_id);
X  return result;
X`7D /* sif_smg$save_physical_screen */
X
X
X
Xextern long smg$unpaste_virtual_display (/*longword*/long *, /*longword*/lon
Vg *);
Xstatic char sis_smg$unpaste_virtual_display`5B`5D = "smg$unpaste_virtual_dis
Vplay";
XSCM
Xsif_smg$unpaste_virtual_display (SCM l)
X`7B
X  int num_args = ilength (l);
X  SCM result;
X  long extres;
X  SCM *data;
X  SCM inarg_1;
X  SCM inarg_2;
X  long display_id;
X  long pasteboard_id;
X  ASSERT ((num_args >= 2) && (num_args <= 2), l, WNA, sis_smg$unpaste_virtua
Vl_display);
X  if (num_args > 0)
X    `7B
X      inarg_1 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_1), inarg_1, ARG1, sis_smg$unpaste_virtual
V_display);
X      display_id = si_to_longword (inarg_1);
X    `7D
X  if (num_args > 1)
X    `7B
X      inarg_2 = CAR (l); l = CDR (l);
X      ASSERT (si_longwordp (inarg_2), inarg_2, ARG2, sis_smg$unpaste_virtual
V_display);
X      pasteboard_id = si_to_longword (inarg_2);
X    `7D
X  extres = smg$unpaste_virtual_display
X    (&display_id,`20
X     &pasteboard_id);
X  result = make_vector (MAKINUM (0+1), UNSPECIFIED);
X  data = VELTS (result);`20
X  *data++ = si_from_longword (extres);
X  return result;
X`7D /* sif_smg$unpaste_virtual_display */
X
X
X
Xstatic iproc si_lsubrs`5B`5D = `7B
X  `7B sis_smg$add_key_def, sif_smg$add_key_def `7D,
X  `7B sis_smg$allow_escape, sif_smg$allow_escape `7D,
X  `7B sis_smg$begin_display_update, sif_smg$begin_display_update `7D,
X  `7B sis_smg$begin_pasteboard_update, sif_smg$begin_pasteboard_update `7D,
X  `7B sis_smg$cancel_input, sif_smg$cancel_input `7D,
X  `7B sis_smg$cursor_column, sif_smg$cursor_column `7D,
X  `7B sis_smg$check_for_occlusion, sif_smg$check_for_occlusion `7D,
X  `7B sis_smg$change_viewport, sif_smg$change_viewport `7D,
X  `7B sis_smg$create_key_table, sif_smg$create_key_table `7D,
X  `7B sis_smg$create_menu, sif_smg$create_menu `7D,
X  `7B sis_smg$control_mode, sif_smg$control_mode `7D,
X  `7B sis_smg$copy_virtual_display, sif_smg$copy_virtual_display `7D,
X  `7B sis_smg$create_pasteboard, sif_smg$create_pasteboard `7D,
X  `7B sis_smg$change_pbd_characteristics, sif_smg$change_pbd_characteristics
V `7D,
X  `7B sis_smg$change_rendition, sif_smg$change_rendition `7D,
X  `7B sis_smg$cursor_row, sif_smg$cursor_row `7D,
X  `7B sis_smg$create_subprocess, sif_smg$create_subprocess `7D,
X  `7B sis_smg$create_virtual_display, sif_smg$create_virtual_display `7D,
X  `7B sis_smg$change_virtual_display, sif_smg$change_virtual_display `7D,
X  `7B sis_smg$create_virtual_keyboard, sif_smg$create_virtual_keyboard `7D,
X  `7B sis_smg$create_viewport, sif_smg$create_viewport `7D,
X  `7B sis_smg$delete_chars, sif_smg$delete_chars `7D,
X  `7B sis_smg$define_key, sif_smg$define_key `7D,
X  `7B sis_smg$disable_broadcast_trapping, sif_smg$disable_broadcast_trapping
V `7D,
X  `7B sis_smg$disable_unsolicited_input, sif_smg$disable_unsolicited_input `
V7D,
X  `7B sis_smg$delete_key_def, sif_smg$delete_key_def `7D,
X  `7B sis_smg$delete_line, sif_smg$delete_line `7D,
X  `7B sis_smg$delete_menu, sif_smg$delete_menu `7D,
X  `7B sis_smg$delete_pasteboard, sif_smg$delete_pasteboard `7D,
X  `7B sis_smg$draw_char, sif_smg$draw_char `7D,
X  `7B sis_smg$draw_line, sif_smg$draw_line `7D,
X  `7B sis_smg$draw_rectangle, sif_smg$draw_rectangle `7D,
X  `7B sis_smg$delete_subprocess, sif_smg$delete_subprocess `7D,
X  `7B sis_smg$del_term_table, sif_smg$del_term_table `7D,
X  `7B sis_smg$delete_virtual_display, sif_smg$delete_virtual_display `7D,
X  `7B sis_smg$delete_virtual_keyboard, sif_smg$delete_virtual_keyboard `7D,
X  `7B sis_smg$delete_viewport, sif_smg$delete_viewport `7D,
X  `7B sis_smg$erase_chars, sif_smg$erase_chars `7D,
X  `7B sis_smg$end_display_update, sif_smg$end_display_update `7D,
X  `7B sis_smg$end_pasteboard_update, sif_smg$end_pasteboard_update `7D,
X  `7B sis_smg$enable_unsolicited_input, sif_smg$enable_unsolicited_input `7D
V,
X  `7B sis_smg$erase_column, sif_smg$erase_column `7D,
X  `7B sis_smg$erase_display, sif_smg$erase_display `7D,
X  `7B sis_smg$erase_line, sif_smg$erase_line `7D,
X  `7B sis_smg$erase_pasteboard, sif_smg$erase_pasteboard `7D,
X  `7B sis_smg$execute_command, sif_smg$execute_command `7D,
X  `7B sis_smg$find_cursor_display, sif_smg$find_cursor_display `7D,
X  `7B sis_smg$flush_buffer, sif_smg$flush_buffer `7D,
X  `7B sis_smg$get_broadcast_message, sif_smg$get_broadcast_message `7D,
X  `7B sis_smg$get_char_at_physical_cursor, sif_smg$get_char_at_physical_curs
Vor `7D,
X  `7B sis_smg$get_display_attr, sif_smg$get_display_attr `7D,
X  `7B sis_smg$get_keyboard_attributes, sif_smg$get_keyboard_attributes `7D,
X  `7B sis_smg$get_key_def, sif_smg$get_key_def `7D,
X  `7B sis_smg$get_numeric_data, sif_smg$get_numeric_data `7D,
X  `7B sis_smg$get_pasting_info, sif_smg$get_pasting_info `7D,
X  `7B sis_smg$get_pasteboard_attributes, sif_smg$get_pasteboard_attributes `
V7D,
X  `7B sis_smg$get_term_data, sif_smg$get_term_data `7D,
X  `7B sis_smg$get_viewport_char, sif_smg$get_viewport_char `7D,
X  `7B sis_smg$home_cursor, sif_smg$home_cursor `7D,
X  `7B sis_smg$init_term_table, sif_smg$init_term_table `7D,
X  `7B sis_smg$insert_chars, sif_smg$insert_chars `7D,
X  `7B sis_smg$insert_line, sif_smg$insert_line `7D,
X  `7B sis_smg$init_term_table_by_type, sif_smg$init_term_table_by_type `7D,
X  `7B sis_smg$invalidate_display, sif_smg$invalidate_display `7D,
X  `7B sis_smg$keycode_to_name, sif_smg$keycode_to_name `7D,
X  `7B sis_smg$label_border, sif_smg$label_border `7D,
X  `7B sis_smg$load_key_defs, sif_smg$load_key_defs `7D,
X  `7B sis_smg$list_key_defs, sif_smg$list_key_defs `7D,
X  `7B sis_smg$list_pasting_order, sif_smg$list_pasting_order `7D,
X  `7B sis_smg$load_virtual_display, sif_smg$load_virtual_display `7D,
X  `7B sis_smg$move_virtual_display, sif_smg$move_virtual_display `7D,
X  `7B sis_smg$move_text, sif_smg$move_text `7D,
X  `7B sis_smg$name_to_keycode, sif_smg$name_to_keycode `7D,
X  `7B sis_smg$paste_virtual_display, sif_smg$paste_virtual_display `7D,
X  `7B sis_smg$put_chars, sif_smg$put_chars `7D,
X  `7B sis_smg$put_chars_highwide, sif_smg$put_chars_highwide `7D,
X  `7B sis_smg$put_chars_multi, sif_smg$put_chars_multi `7D,
X  `7B sis_smg$put_chars_wide, sif_smg$put_chars_wide `7D,
X  `7B sis_smg$put_help_text, sif_smg$put_help_text `7D,
X  `7B sis_smg$put_line, sif_smg$put_line `7D,
X  `7B sis_smg$put_line_highwide, sif_smg$put_line_highwide `7D,
X  `7B sis_smg$put_line_multi, sif_smg$put_line_multi `7D,
X  `7B sis_smg$put_line_wide, sif_smg$put_line_wide `7D,
X  `7B sis_smg$pop_virtual_display, sif_smg$pop_virtual_display `7D,
X  `7B sis_smg$put_pasteboard, sif_smg$put_pasteboard `7D,
X  `7B sis_smg$print_pasteboard, sif_smg$print_pasteboard `7D,
X  `7B sis_smg$put_status_line, sif_smg$put_status_line `7D,
X  `7B sis_smg$put_virtual_display_encoded, sif_smg$put_virtual_display_encod
Ved `7D,
X  `7B sis_smg$put_with_scroll, sif_smg$put_with_scroll `7D,
X  `7B sis_smg$ring_bell, sif_smg$ring_bell `7D,
X  `7B sis_smg$read_composed_line, sif_smg$read_composed_line `7D,
X  `7B sis_smg$remove_line, sif_smg$remove_line `7D,
X  `7B sis_smg$replace_input_line, sif_smg$replace_input_line `7D,
X  `7B sis_smg$return_input_line, sif_smg$return_input_line `7D,
X  `7B sis_smg$read_from_display, sif_smg$read_from_display `7D,
X  `7B sis_smg$read_keystroke, sif_smg$read_keystroke `7D,
X  `7B sis_smg$repaint_line, sif_smg$repaint_line `7D,
X  `7B sis_smg$repaint_screen, sif_smg$repaint_screen `7D,
X  `7B sis_smg$repaste_virtual_display, sif_smg$repaste_virtual_display `7D,
X  `7B sis_smg$restore_physical_screen, sif_smg$restore_physical_screen `7D,
X  `7B sis_smg$read_string, sif_smg$read_string `7D,
X  `7B sis_smg$return_cursor_pos, sif_smg$return_cursor_pos `7D,
X  `7B sis_smg$read_verify, sif_smg$read_verify `7D,
X  `7B sis_smg$set_broadcast_trapping, sif_smg$set_broadcast_trapping `7D,
X  `7B sis_smg$scroll_display_area, sif_smg$scroll_display_area `7D,
X  `7B sis_smg$set_cursor_abs, sif_smg$set_cursor_abs `7D,
X  `7B sis_smg$set_cursor_rel, sif_smg$set_cursor_rel `7D,
X  `7B sis_smg$scroll_viewport, sif_smg$scroll_viewport `7D,
X  `7B sis_smg$set_display_scroll_region, sif_smg$set_display_scroll_region `
V7D,
X  `7B sis_smg$select_from_menu, sif_smg$select_from_menu `7D,
X  `7B sis_smg$set_cursor_mode, sif_smg$set_cursor_mode `7D,
X  `7B sis_smg$set_keypad_mode, sif_smg$set_keypad_mode `7D,
X  `7B sis_smg$snapshot, sif_smg$snapshot `7D,
X  `7B sis_smg$set_out_of_band_asts, sif_smg$set_out_of_band_asts `7D,
X  `7B sis_smg$set_physical_cursor, sif_smg$set_physical_cursor `7D,
X  `7B sis_smg$set_default_state, sif_smg$set_default_state `7D,
X  `7B sis_smg$set_term_characteristics, sif_smg$set_term_characteristics `7D
V,
X  `7B sis_smg$save_virtual_display, sif_smg$save_virtual_display `7D,
X  `7B sis_smg$save_physical_screen, sif_smg$save_physical_screen `7D,
X  `7B sis_smg$unpaste_virtual_display, sif_smg$unpaste_virtual_display `7D,
X  `7B 0, 0 `7D,
X`7D;
Xvoid`20
Xinit_smg()
X`7B
X  init_iprocs (si_lsubrs, tc7_lsubr);
X`7D
$ CALL UNPACK SMG.C;2 1834188156
$ create 'f'
XSMG-SCM version 2a0 -- A SMG interface for SCM`20
X
XTerse Documentation
X===================
X
XCompiling this into SCM
X-----------------------
X
XThe files VMSGCC.COM-SMG and VMSBUILD.COM-SMG should compile and link
Xthe appropriate files, resulting in SMGSCM.EXE.  SMG.MAKEFILE is an
Xexample makefile.  Essentially, you need to compile SCMINT.C and
XSMG.C, recompile SCM.C with INITS defined as `60init_SMG();init_sc2();',
Xand relink with SCMINT.OBJ and SMG.OBJ.
X
XI've compiled this into SCM4b4 and SCM4c0.  It should probably work
Xwith any version of SCM that has BIGNUMs.
X
XIf you are having trouble with some of the output from SCM being
Xspread over several lines when it should have only been on one line,
Xyou might want to add the following lines to SCM.H, recompile
Xeverything, compile SYSDEP.C, and link everything with SYSDEP.OBJ.
X(VMS's fwrite writes one record when it is used to write to
Xrecord-structured files, such as the normal VMS text files, so every
Xcall to fwrite produces a seperate line.)
X
X`09#ifdef VMS
X`09#define fwrite sys_fwrite
X`09#endif /* VMS */
X
XSMGFUNS.DOC contains terse descriptions of the calling sequences of
Xthe SMG routines.  Since the SMG routines return results in
Xcall-by-reference parameters and Scheme doesn't have call-by-reference
Xparameters I had to change how the SMG routines were called and how
Xthey returned their results.  The routines now only expect the input
Xparameters (what Ada calls IN parameters, what VMS calls ACCESS:
XREAD).  The output parameters (what Ada calls OUT parameters, what VMS
Xcalls ACCESS: WRITE) are returned (along with the status code returned
Xby the routine) in a vector.  Any parameters that are both IN and OUT
Xappear in both the input parameters and in the output vector.
X
XFor example, SMG$CREATE_PASTEBOARD did take six parameters:
Xpasteboard-id, output-device, number-of-pasteboard-rows,
Xnumber-of-pasteboard-columns, flags, and type-of-terminal.  All of
Xthose except output-device and flags were output parameters that the
Xroutine writes infomation into.  In SMG-SCM SMG$CREATE_PASTEBOARD
Xtakes two parameters, output-device and flags, and returns a five
Xelement vector containing the return value of the routine,
Xpasteboard-id, number-of-pasteboard-rows,
Xnumber-of-pasteboard-columns, and type-of-terminal.
X
XOptional parameters can be omitted, or specified as a boolean, in
Xwhich case they are ignored.
X
X
XDifferences from the first (unnumbered) version
X-----------------------------------------------
X
X* All the SMG routines are now included, although not all have been
X  tested.
X* The Scheme routines now have exactly the same names as the SMG
X  routines they call. (In other words, it's SMG$CREATE_PASTEBOARD
X  instead of CREATE-PASTEBOARD.)
X* Where the earlier version used the BITS data type extension this
X  version uses integers.  (It uses BIGNUMs if the number doesn't fit
X  into a FIXNUM.)
X* All routines now return a vector with the return status as the first
X  element. Any output parameters are in the other elements.
X
X
X
XSome explanations
X-----------------
X
XSMG.C contains the SCM interface routines for the VMS SMG library.
XBasically, for each SMG routine there is one function in SMG.C that
Xchecks that there are the correct number of arguments, that they are
Xof the correct type, converts the arguments from SCM values to C
Xvalues, calls the SMG function, packs the return value and any other
Xresults into a SCM vector as SCM values and returns that.
X
XSMGFUNS.DOC contains terse documentation describing the calling
Xsequence for the interface routines.  Basically, it lists the routine
Xname, the input parameters it expects, and the output results that it
Xreturns in a vector.
X
XThe file SMCINT.C contains the support routines used by SMG.C.  The file
XSCMINT.H is included by SCMINT.C and SMG.C and is the header for the
Xsupport routines.
X
XGENSCMINT.SCM and GENSMG.SCM together are used to generate SMG.C and
XSMGFUNS.DOC from SMG$ROUTINES.SI.  To use them, load GENSCMINT.SCM
Xinto a Scheme and then load GENSMG.SCM while in the same directory as
XSMG$ROUTINES.SI.  (GENSMG.SCM just calls the main function in
XGENSCMINT.SCM with the appropriate values to generate SMG.C.)
XSMG$ROUTINES.SI has descriptions of the calling sequences of all the
XSMG routines; the functions in GENSCMINT.SCM read these descriptions
Xand create SMG.C from them.
X
XSMG$ROUTINES.SI was generated from SMG$ROUTINES.SDI (extracted from
XSYS$LIBRARY:STARLETSD.TLB) by the command`20
X
X`09$ UNSDL/LANG=SCM="NOCOMMENT,CASE=LOWER" SMG$ROUTINES.SDI which
X
Xuses the executable generated from SDLSCM.C by SDL.MAKEFILE.  To use
Xthis command you need the UNSDL package, but you shouldn't need it
Xsince you shouldn't need to to regenerate SMG$ROUTINES.SI.  SDLSCM.C
Xcan only be used if you get the rest of the UNSDL package.  It is
Xincluded only in case you want to generate your own interfaces and are
Xwilling to hack on it.
$ CALL UNPACK SMG.DOC;16 1244536805
$ create 'f'
XCCFLAGS=/nodebug/noopt /define=("FLOATS","INITS=init_smg();init_sc2();","FIN
VALS=;","IMPLINIT=""''f$env(""DEFAULT"")'Init.scm""")
XLDFLAGS=/nodebug
XMAFLAGS=/debug
X
X*.obj: *.mar
X`09macro $*.mar $(MAFLAGS)
X
X*.obj: *.c
X`09gcc $*.c $(CCFLAGS)`20
X
XSYSDEP=
X#SYSDEP=sysdep.obj,
X
XOBJS = `09scm.obj, repl.obj, eval.obj, time.obj, scl.obj, subr.obj,\
X`09sys.obj, sc2.obj, unif.obj, setjump.obj, $(SYSDEP) scmint.obj,\
X`09smg.obj
X`09
Xsmgscm.exe: $(OBJS)
X`09link /exe=smgscm.exe $(LDFLAGS) $(OBJS), sys$input:/opt
X`09`09gnu_cc:`5B000000`5Dgcclib/lib,-$
X`09`09sys$share:vaxcrtl/share$
X#`09setdebug smgscm.exe 0
X
X$(OBJS): scm.h
X
Xscmint.obj smg.obj: scmint.h
X
Xsmg.c: smg$routines.si
X`09scm genscmint.scm gensmg.scm
$ CALL UNPACK SMG.MAKEFILE;8 1632115948
$ create 'f'
XSMG-SCM version 2a0 -- A SMG interface for SCM`20
X
XManifest: What files are in this package.`20
X
X`09smg.readme`09-- What this is all about.
X`09smg.manifest`09-- This file.
X`09smg.doc`09`09-- Terse documentation.
X`09smgfuns.doc`09-- Automatically generated description of the`20
X`09`09`09   calling sequence for the SMG-SCM functions, which
X`09`09`09   differ slightly from the original SMG routines
X`09`09`09   because Scheme doesn't have call-by-reference.
X
X`09smg.c`09`09-- The routines that provide SCM with scheme versions
X`09`09`09   of the SMG routines.
X`09scmint.h`09-- The header file for the SCM INTerface routines.
X`09scmint.c`09-- The source code for the routines used by the SCM`20
X`09`09`09   INTerface
X`09vmsgcc.com-smg,`09-- Command procedures to compile smg-scm.
X`09vmsbuild.com-smg
X`09smg.makefile`09-- An example VMS makefile.
X`09sysdep.c`09-- optional; fixes annoying feature of VMS fwrite.
X
X`09smgdef.scm`09-- Defines constants used by SMG.
X`09trysmg.scm,`09-- Tests/Examples of using SMG.
X`09trysmg2.scm,
X`09readstring.scm
X`09
X`09smg$routines.si`09-- Describes the parameters and results of the`20
X`09`09`09   SMG routines.
X`09genscmint.scm`09-- Generates interface routines given SMG$ROUTINES.SI`20
X`09`09`09   as input.
X`09def-mac.scm`09-- Simpleminded and familiar macros.
X`09def-rec.scm`09-- Macros to define records, hacked from _EOPL_.
X`09gensmg.scm`09-- Load this after GENSCMINT.SCM to generate SMG.C`20
X`09`09`09   and SMGFUNS.DOC.
X`09sdlscm.c`09-- Useful only if you have UNSDL; generates
X`09`09`09   SMG$ROUTINES.SI.`20
X`09
$ CALL UNPACK SMG.MANIFEST;17 67390798
$ create 'f'
XSMG-SCM version 2a0 -- A SMG interface for SCM`20
X
XThe files in this package provide an interface to the VMS Screen
XManagement (SMG) routines for SCM.  (SMG is VMS's equivalent of
Xcurses.)  All SMG routines defined in the SMG$ROUTINES module in
XSYS$LIBRARY:STARTLETSD.TLB are included, although some are not
Xparticularly useful; routines that use ASTs, for instance.
X
XAlso included is a Scheme program that reads a file of declarations of
Xroutines and generates C source that can be compiled and linked with
XSCM to provide an interface to these routines.  This code is ugly,
Xunpolished, undocumented, fragile, and full of assumptions that the
Xroutines follow certain VMS conventions, so it isn't a general purpose
Xsolution to adding external routines to SCM.  It was included because
XSMG.C was generated by it and in hopes that someone else might find it
Xuseful.
X
XSend comments, bugs, and suggestions to tkb@mtnet2.wvnet.edu; I don't
Xpromise to fix bugs or add suggested items, but as I use this myself
XI'm likely to at least fix bugs if I have the time.  Also, if you use
Xit for anything interesting (or anything at all) I'd like to hear
Xabout it.
X--
XT.K. Bond, tkb@mtnet2.wvnet.edu  or  Kurt.Bond@launchpad.unc.edu
$ CALL UNPACK SMG.README;6 1144853384
$ create 'f'
X;;; Created by SDL V3.1-7     -*- scheme -*-`20
X;;; Source: 23-MAR-1993 09:25:02 MPL$DATA:`5BMPL.TKB.UNSDL.X`5DSMGDEF.SDI;1
X`20
X;;; * MODULE $smgdef *`20
X(define smg$k_trm_null_char 0)
X(define smg$k_trm_ctrla 1)
X(define smg$k_trm_ctrlb 2)
X(define smg$k_trm_ctrlc 3)
X(define smg$k_trm_ctrld 4)
X(define smg$k_trm_ctrle 5)
X(define smg$k_trm_ctrlf 6)
X(define smg$k_trm_ctrlg 7)
X(define smg$k_trm_ctrlh 8)
X(define smg$k_trm_ctrli 9)
X(define smg$k_trm_ctrlj 10)
X(define smg$k_trm_ctrlk 11)
X(define smg$k_trm_ctrll 12)
X(define smg$k_trm_ctrlm 13)
X(define smg$k_trm_ctrln 14)
X(define smg$k_trm_ctrlo 15)
X(define smg$k_trm_ctrlp 16)
X(define smg$k_trm_ctrlq 17)
X(define smg$k_trm_ctrlr 18)
X(define smg$k_trm_ctrls 19)
X(define smg$k_trm_ctrlt 20)
X(define smg$k_trm_ctrlu 21)
X(define smg$k_trm_ctrlv 22)
X(define smg$k_trm_ctrlw 23)
X(define smg$k_trm_ctrlx 24)
X(define smg$k_trm_ctrly 25)
X(define smg$k_trm_ctrlz 26)
X(define smg$k_trm_escape 27)
X(define smg$k_trm_fs 28)
X(define smg$k_trm_gs 29)
X(define smg$k_trm_rs 30)
X(define smg$k_trm_us 31)
X(define smg$k_trm_space 32)
X(define smg$k_trm_exclamation_point 33)
X(define smg$k_trm_double_quote 34)
X(define smg$k_trm_number_sign 35)
X(define smg$k_trm_dollar_sign 36)
X(define smg$k_trm_percent_sign 37)
X(define smg$k_trm_ampersand 38)
X(define smg$k_trm_quote 39)
X(define smg$k_trm_left_paren 40)
X(define smg$k_trm_right_paren 41)
X(define smg$k_trm_asterisk 42)
X(define smg$k_trm_plus_sign 43)
X(define smg$k_trm_comma_char 44)
X(define smg$k_trm_dash 45)
X(define smg$k_trm_dot 46)
X(define smg$k_trm_slash 47)
X(define smg$k_trm_zero 48)
X(define smg$k_trm_one 49)
X(define smg$k_trm_two 50)
X(define smg$k_trm_three 51)
X(define smg$k_trm_four 52)
X(define smg$k_trm_five 53)
X(define smg$k_trm_six 54)
X(define smg$k_trm_seven 55)
X(define smg$k_trm_eight 56)
X(define smg$k_trm_nine 57)
X(define smg$k_trm_colon 58)
X(define smg$k_trm_semicolon 59)
X(define smg$k_trm_less_than 60)
X(define smg$k_trm_equal 61)
X(define smg$k_trm_greater_than 62)
X(define smg$k_trm_question_mark 63)
X(define smg$k_trm_at_sign 64)
X(define smg$k_trm_uppercase_a 65)
X(define smg$k_trm_uppercase_b 66)
X(define smg$k_trm_uppercase_c 67)
X(define smg$k_trm_uppercase_d 68)
X(define smg$k_trm_uppercase_e 69)
X(define smg$k_trm_uppercase_f 70)
X(define smg$k_trm_uppercase_g 71)
X(define smg$k_trm_uppercase_h 72)
X(define smg$k_trm_uppercase_i 73)
X(define smg$k_trm_uppercase_j 74)
X(define smg$k_trm_uppercase_k 75)
X(define smg$k_trm_uppercase_l 76)
X(define smg$k_trm_uppercase_m 77)
X(define smg$k_trm_uppercase_n 78)
X(define smg$k_trm_uppercase_o 79)
X(define smg$k_trm_uppercase_p 80)
X(define smg$k_trm_uppercase_q 81)
X(define smg$k_trm_uppercase_r 82)
X(define smg$k_trm_uppercase_s 83)
X(define smg$k_trm_uppercase_t 84)
X(define smg$k_trm_uppercase_u 85)
X(define smg$k_trm_uppercase_v 86)
X(define smg$k_trm_uppercase_w 87)
X(define smg$k_trm_uppercase_x 88)
X(define smg$k_trm_uppercase_y 89)
X(define smg$k_trm_uppercase_z 90)
X(define smg$k_trm_left_bracket 91)
X(define smg$k_trm_backslash 92)
X(define smg$k_trm_right_bracket 93)
X(define smg$k_trm_caret 94)
X(define smg$k_trm_underline 95)
X(define smg$k_trm_grave_accent 96)
X(define smg$k_trm_lowercase_a 97)
X(define smg$k_trm_lowercase_b 98)
X(define smg$k_trm_lowercase_c 99)
X(define smg$k_trm_lowercase_d 100)
X(define smg$k_trm_lowercase_e 101)
X(define smg$k_trm_lowercase_f 102)
X(define smg$k_trm_lowercase_g 103)
X(define smg$k_trm_lowercase_h 104)
X(define smg$k_trm_lowercase_i 105)
X(define smg$k_trm_lowercase_j 106)
X(define smg$k_trm_lowercase_k 107)
X(define smg$k_trm_lowercase_l 108)
X(define smg$k_trm_lowercase_m 109)
X(define smg$k_trm_lowercase_n 110)
X(define smg$k_trm_lowercase_o 111)
X(define smg$k_trm_lowercase_p 112)
X(define smg$k_trm_lowercase_q 113)
X(define smg$k_trm_lowercase_r 114)
X(define smg$k_trm_lowercase_s 115)
X(define smg$k_trm_lowercase_t 116)
X(define smg$k_trm_lowercase_u 117)
X(define smg$k_trm_lowercase_v 118)
X(define smg$k_trm_lowercase_w 119)
X(define smg$k_trm_lowercase_x 120)
X(define smg$k_trm_lowercase_y 121)
X(define smg$k_trm_lowercase_z 122)
X(define smg$k_trm_left_brace 123)
X(define smg$k_trm_vertical_line 124)
X(define smg$k_trm_right_brace 125)
X(define smg$k_trm_tilde 126)
X(define smg$k_trm_delete 127)
X(define smg$k_trm_bs 8)
X(define smg$k_trm_ht 9)
X(define smg$k_trm_lf 10)
X(define smg$k_trm_vt 11)
X(define smg$k_trm_ff 12)
X(define smg$k_trm_cr 13)
X(define smg$k_trm_pf1 256)
X(define smg$k_trm_pf2 257)
X(define smg$k_trm_pf3 258)
X(define smg$k_trm_pf4 259)
X(define smg$k_trm_kp0 260)
X(define smg$k_trm_kp1 261)
X(define smg$k_trm_kp2 262)
X(define smg$k_trm_kp3 263)
X(define smg$k_trm_kp4 264)
X(define smg$k_trm_kp5 265)
X(define smg$k_trm_kp6 266)
X(define smg$k_trm_kp7 267)
X(define smg$k_trm_kp8 268)
X(define smg$k_trm_kp9 269)
X(define smg$k_trm_enter 270)
X(define smg$k_trm_minus 271)
X(define smg$k_trm_comma 272)
X(define smg$k_trm_period 273)
X(define smg$k_trm_up 274)
X(define smg$k_trm_down 275)
X(define smg$k_trm_left 276)
X(define smg$k_trm_right 277)
X(define smg$k_trm_f1 281)
X(define smg$k_trm_f2 282)
X(define smg$k_trm_f3 283)
X(define smg$k_trm_f4 284)
X(define smg$k_trm_f5 285)
X(define smg$k_trm_f6 286)
X(define smg$k_trm_f7 287)
X(define smg$k_trm_f8 288)
X(define smg$k_trm_f9 289)
X(define smg$k_trm_f10 290)
X(define smg$k_trm_f11 291)
X(define smg$k_trm_f12 292)
X(define smg$k_trm_f13 293)
X(define smg$k_trm_f14 294)
X(define smg$k_trm_f15 295)
X(define smg$k_trm_f16 296)
X(define smg$k_trm_f17 297)
X(define smg$k_trm_f18 298)
X(define smg$k_trm_f19 299)
X(define smg$k_trm_f20 300)
X(define smg$k_trm_help 295)
X(define smg$k_trm_do 296)
X(define smg$k_trm_e1 311)
X(define smg$k_trm_e2 312)
X(define smg$k_trm_e3 313)
X(define smg$k_trm_e4 314)
X(define smg$k_trm_e5 315)
X(define smg$k_trm_e6 316)
X(define smg$k_trm_find 311)
X(define smg$k_trm_insert_here 312)
X(define smg$k_trm_remove 313)
X(define smg$k_trm_select 314)
X(define smg$k_trm_prev_screen 315)
X(define smg$k_trm_next_screen 316)
X(define smg$k_trm_first_down 321)
X(define smg$k_trm_second_down 322)
X(define smg$k_trm_third_down 323)
X(define smg$k_trm_fourth_down 324)
X(define smg$k_trm_first_up 325)
X(define smg$k_trm_second_up 326)
X(define smg$k_trm_third_up 327)
X(define smg$k_trm_fourth_up 328)
X(define smg$k_trm_cancelled 508)
X(define smg$k_trm_timeout 509)
X(define smg$k_trm_buffer_full 510)
X(define smg$k_trm_unknown 511)
X(define smg$c_change_rendition 10)
X(define smg$c_delete_chars 11)
X(define smg$c_erase_display 12)
X(define smg$c_erase_line 13)
X(define smg$c_home_cursor 14)
X(define smg$c_insert_chars 15)
X(define smg$c_insert_line 16)
X(define smg$c_put_chars 17)
X(define smg$c_put_line 18)
X(define smg$c_put_display_encoded 19)
X(define smg$c_return_cursor_pos 20)
X(define smg$c_put_with_scroll 21)
X(define smg$c_set_cursor_abs 22)
X(define smg$c_set_cursor_rel 23)
X(define smg$c_delete_line 24)
X(define smg$c_erase_chars 25)
X(define smg$c_scroll_display_area 26)
X(define smg$c_change_virtual_display 27)
X(define smg$c_label_border 28)
X(define smg$c_end_display_update 29)
X(define smg$c_move_text 30)
X(define smg$c_united_kingdom 0)
X(define smg$c_ascii 1)
X(define smg$c_spec_graphics 2)
X(define smg$c_alt_char 3)
X(define smg$c_alt_graphics 4)
X(define smg$c_unknown 5)
X(define smg$c_supplemental 6)
X(define smg$c_jis_roman 7)
X(define smg$c_jis_kana 8)
X(define smg$c_kanji 9)
X(define smg$c_hanzi 10)
X(define smg$c_hanyu 11)
X(define smg$c_hangul 12)
X(define smg$c_ks_roman 13)
X(define smg$c_upper_left 0)
X(define smg$c_lower_left 1)
X(define smg$c_upper_right 2)
X(define smg$c_lower_right 3)
X(define smg$k_top 0)
X(define smg$k_bottom 1)
X(define smg$k_left 2)
X(define smg$k_right 3)
X(define smg$k_block 0)
X(define smg$k_vertical 1)
X(define smg$k_horizontal 2)
X(define smg$c_color_unknown 0)
X(define smg$c_color_white 1)
X(define smg$c_color_black 2)
X(define smg$c_color_blue 3)
X(define smg$c_color_cyan 4)
X(define smg$c_color_green 5)
X(define smg$c_color_magenta 6)
X(define smg$c_color_red 7)
X(define smg$c_color_yellow 8)
X(define smg$c_color_light 9)
X(define smg$c_color_dark 10)
X(define smg$c_color_user1 11)
X(define smg$c_color_user2 12)
X(define smg$c_color_user3 13)
X(define smg$c_color_user4 14)
X(define smg$c_color_user5 15)
X(define smg$c_color_user6 16)
X(define smg$c_color_user7 17)
X(define smg$c_color_user8 18)
X(define smg$k_unknown 0)
X(define smg$k_vt05 1)
X(define smg$k_vt52 2)
X(define smg$k_vt100 3)
X(define smg$k_vtforeign 4)
X(define smg$k_hardcopy 5)
X(define smg$k_vttermtable 6)
X(define smg$k_first_priv_type 191)
X(define smg$k_buf_enabled 0)
X(define smg$k_minupd 1)
X(define smg$k_clear_screen 2)
X(define smg$k_notabs 3)
X(define smg$k_protect 4)
X(define smg$k_ignore 5)
X(define smg$k_release_pbd 6)
X(define smg$m_buf_enabled #x00000001)
X(define smg$m_minupd #x00000002)
X(define smg$m_clear_screen #x00000004)
X(define smg$m_notabs #x00000008)
X(define smg$m_protect #x00000010)
X(define smg$m_ignore #x00000020)
X(define smg$m_release_pbd #x00000040)
X(define smg$m_spare15 #xFFFFFF80)
X;??? unhandled item: smgmode_bits STRUCTURE
X(define smg$m_key_noecho #x00000001)
X(define smg$m_key_terminate #x00000002)
X(define smg$m_key_lock #x00000004)
X(define smg$m_key_protected #x00000008)
X(define smg$m_key_setstate #x00000010)
X(define smg$m_spare18 #xFFFFFFE0)
X;??? unhandled item: smg$r_key_def_attr STRUCTURE
X(define smg$m_bold #x00000001)
X(define smg$m_reverse #x00000002)
X(define smg$m_blink #x00000004)
X(define smg$m_underline #x00000008)
X(define smg$m_invisible #x00000010)
X(define smg$m_user1 #x00000100)
X(define smg$m_user2 #x00000200)
X(define smg$m_user3 #x00000400)
X(define smg$m_user4 #x00000800)
X(define smg$m_user5 #x00001000)
X(define smg$m_user6 #x00002000)
X(define smg$m_user7 #x00004000)
X(define smg$m_user8 #x00008000)
X(define smg$m_spare14 #xFFFF0000)
X;??? unhandled item: smgdef_bits STRUCTURE
X(define smg$m_normal 0)
X(define smg$m_border #x00000001)
X(define smg$m_trunc_icon #x00000002)
X(define smg$m_display_controls #x00000004)
X(define smg$m_user_display #x00000008)
X(define smg$m_block_border #x00000010)
X(define smg$m_protect_display #x00000020)
X(define smg$m_spare12 #xFFFFFFC0)
X;??? unhandled item: display_attributes STRUCTURE
X(define smg$m_data_follows #x00000001)
X(define smg$m_send_eof #x00000002)
X(define smg$m_spare11 #xFFFFFFFC)
X;??? unhandled item: smg$r_subprocess_flags STRUCTURE
X(define smg$m_erase_pbd #x00000001)
X(define smg$m_ignore_batched #x00000002)
X(define smg$m_spare10 #xFFFFFFFC)
X;??? unhandled item: smg$r_delete_pbd_flags STRUCTURE
X(define smg$m_keep_contents #x00000001)
X(define smg$m_workstation #x00000002)
X(define smg$m_spare9 #xFFFFFFFC)
X;??? unhandled item: smg$r_create_pbd_flags STRUCTURE
X(define smg$m_func_keys #x00000001)
X(define smg$m_nokeep #x00000002)
X(define smg$m_norecall #x00000004)
X(define smg$m_spare8 #xFFFFFFF8)
X;??? unhandled item: smg$r_read_flags STRUCTURE
X(define smg$m_cursor_off #x00000001)
X(define smg$m_cursor_on #x00000002)
X(define smg$m_scroll_jump #x00000004)
X(define smg$m_scroll_smooth #x00000008)
X(define smg$m_spare16 #xFFFFFFF0)
X;??? unhandled item: smg$r_set_cursor_flags STRUCTURE
X(define smg$m_viewport #x00000001)
X(define smg$m_subprocess #x00000002)
X(define smg$m_menu #x00000004)
X(define smg$m_spare7 #xFFFFFFF8)
X;??? unhandled item: smg$r_get_display_flags STRUCTURE
X(define smg$m_erase_line #x00000001)
X(define smg$m_erase_to_eol #x00000002)
X(define smg$m_spare6 #xFFFFFFFC)
X;??? unhandled item: smg$r_put_chars_flags STRUCTURE
X(define smg$m_text_save #x00000001)
X(define smg$m_text_only #x00000002)
X(define smg$m_spare17 #xFFFFFFFC)
X;??? unhandled item: smg$r_move_text_flags STRUCTURE
X(define smg$m_form_feed #x00000001)
X(define smg$m_spare5 #xFFFFFFFE)
X;??? unhandled item: smg$r_snapshot_flags STRUCTURE
X(define smg$m_wrap_char #x00000001)
X(define smg$m_wrap_word #x00000002)
X(define smg$m_spare4 #xFFFFFFFC)
X;??? unhandled item: smg$r_put_line_flags STRUCTURE
X(define smg$m_keypad_application #x00000001)
X(define smg$m_keypad_numeric #x00000002)
X(define smg$m_spare3 #xFFFFFFFC)
X;??? unhandled item: smg$r_keypad_modes STRUCTURE
X(define smg$m_display_pasted #x00000001)
X(define smg$m_spare19 #xFFFFFFFE)
X;??? unhandled item: smg$r_pasting_info_flags STRUCTURE
X(define smg$m_remove_item #x00000001)
X(define smg$m_fixed_format #x00000002)
X(define smg$m_double_space #x00000004)
X(define smg$m_return_immed #x00000008)
X(define smg$m_erase_menu #x00000010)
X(define smg$m_wide_menu #x00000020)
X(define smg$m_wrap_menu #x00000040)
X(define smg$m_full_field #x00000080)
X(define smg$m_spare2 #xFFFFFF00)
X;??? unhandled item: smg$r_menu_flags STRUCTURE
X(define smg$m_up #x00000001)
X(define smg$m_down #x00000002)
X(define smg$m_right #x00000004)
X(define smg$m_left #x00000008)
X(define smg$m_spare1 #xFFFFFFF0)
X;??? unhandled item: scroll_dirs STRUCTURE
X(define smg$c_band_information_table 12)
X(define smg$c_pasteboard_info_block 32)
X(define smg$c_keyboard_info_block 20)
X;??? unhandled item: smgdef UNION
X;??? unhandled item: smg$r_out_of_band_table STRUCTURE
X(define smg$c_out_of_band_table 12)
X;??? unhandled item: smg$r_subprocess_info_table STRUCTURE
X(define smg$c_subprocess_info_table 12)
X;??? unhandled item: smg$r_attribute_info_block STRUCTURE
X(define smg$c_attribute_info_block 32)
$ CALL UNPACK SMGDEF.SCM;2 707646202
$ create 'f'
Xsmg$add_key_def
X    Inputs:
X        key_table_id (1) longword
X        key_name (2) character
X        if_state (3) character optional
X        attributes (4) longword optional
X        equivalence_string (5) character optional
X        state_string (6) character optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$allow_escape
X    Inputs:
X        display_id (1) longword
X        flags (2) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$begin_display_update
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$begin_pasteboard_update
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$cancel_input
X    Inputs:
X        keyboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$cursor_column
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$check_for_occlusion
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X    Results:
X        status (return value) longword
X        occlusion_state (3) longword
X
X
X
Xsmg$change_viewport
X    Inputs:
X        display_id (1) longword
X        viewport_row_start (2) longword optional
X        viewport_column_start (3) longword optional
X        viewport_number_rows (4) longword optional
X        viewport_number_columns (5) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$create_key_table
X    Inputs:
X    Results:
X        status (return value) longword
X        key_table_id (1) longword
X
X
X
Xsmg$create_menu
X    Inputs:
X        display_id (1) longword
X        choices (2) character
X        menu_type (3) longword optional
X        flags (4) longword optional
X        row (5) longword optional
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$control_mode
X    Inputs:
X        pasteboard_id (1) longword
X        new_mode (2) longword optional
X        buffer_size (4) word optional
X    Results:
X        status (return value) longword
X        old_mode (3) longword
X
X
X
Xsmg$copy_virtual_display
X    Inputs:
X        current_display_id (1) longword
X    Results:
X        status (return value) longword
X        new_display_id (2) longword
X
X
X
Xsmg$create_pasteboard
X    Inputs:
X        output_device (2) character optional
X        flags (5) longword optional
X    Results:
X        status (return value) longword
X        pasteboard_id (1) longword
X        number_of_pasteboard_rows (3) longword
X        number_of_pasteboard_columns (4) longword
X        type_of_terminal (6) longword
X
X
X
Xsmg$change_pbd_characteristics
X    Inputs:
X        pasteboard_id (1) longword
X        desired_width (2) longword optional
X        desired_height (4) longword optional
X        desired_background_color (6) longword optional
X    Results:
X        status (return value) longword
X        width (3) longword
X        height (5) longword
X        background_color (7) longword
X
X
X
Xsmg$change_rendition
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        start_column (3) longword
X        number_of_rows (4) longword
X        number_of_columns (5) longword
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$cursor_row
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$create_subprocess
X    Inputs:
X        display_id (1) longword
X        ast_routine (2) address optional
X        ast_argument (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$create_virtual_display
X    Inputs:
X        number_of_rows (1) longword
X        number_of_columns (2) longword
X        display_attributes (4) longword optional
X        video_attributes (5) longword optional
X        character_set (6) longword optional
X    Results:
X        status (return value) longword
X        display_id (3) longword
X
X
X
Xsmg$change_virtual_display
X    Inputs:
X        display_id (1) longword
X        number_of_rows (2) longword optional
X        number_of_columns (3) longword optional
X        display_attributes (4) longword optional
X        video_attributes (5) longword optional
X        character_set (6) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$create_virtual_keyboard
X    Inputs:
X        input_device (2) character optional
X        default_filespec (3) character optional
X        recall_size (5) byte optional
X    Results:
X        status (return value) longword
X        keyboard_id (1) longword
X        resultant_filespec (4) character
X
X
X
Xsmg$create_viewport
X    Inputs:
X        display_id (1) longword
X        viewport_row_start (2) longword
X        viewport_column_start (3) longword
X        viewport_number_rows (4) longword
X        viewport_number_columns (5) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_chars
X    Inputs:
X        display_id (1) longword
X        number_of_characters (2) longword
X        start_row (3) longword
X        start_column (4) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$define_key
X    Inputs:
X        key_table_id (1) longword
X        command_string (2) character
X    Results:
X        status (return value) longword
X
X
X
Xsmg$disable_broadcast_trapping
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$disable_unsolicited_input
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_key_def
X    Inputs:
X        key_table_id (1) longword
X        key_name (2) character
X        if_state (3) character optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_line
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        number_of_rows (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_menu
X    Inputs:
X        display_id (1) longword
X        flags (2) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_pasteboard
X    Inputs:
X        pasteboard_id (1) longword
X        flags (2) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$draw_char
X    Inputs:
X        display_id (1) longword
X        flags (2) longword
X        row (3) longword optional
X        column (4) longword optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$draw_line
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        start_column (3) longword
X        end_row (4) longword
X        end_column (5) longword
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$draw_rectangle
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        start_column (3) longword
X        end_row (4) longword
X        end_column (5) longword
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_subprocess
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$del_term_table
X    Inputs:
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_virtual_display
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_virtual_keyboard
X    Inputs:
X        keyboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$delete_viewport
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$erase_chars
X    Inputs:
X        display_id (1) longword
X        number_of_characters (2) longword
X        start_row (3) longword
X        start_column (4) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$end_display_update
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$end_pasteboard_update
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$enable_unsolicited_input
X    Inputs:
X        pasteboard_id (1) longword
X        ast_routine (2) address
X        ast_argument (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$erase_column
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        column_number (3) longword optional
X        end_row (4) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$erase_display
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        start_column (3) longword optional
X        end_row (4) longword optional
X        end_column (5) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$erase_line
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        start_column (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$erase_pasteboard
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$execute_command
X    Inputs:
X        display_id (1) longword
X        command_desc (2) character
X        flags (3) longword optional
X    Results:
X        status (return value) longword
X        ret_status (4) longword
X
X
X
Xsmg$find_cursor_display
X    Inputs:
X        pasteboard_id (1) longword
X        pasteboard_row (3) longword optional
X        pasteboard_column (4) longword optional
X    Results:
X        status (return value) longword
X        display_id (2) longword
X
X
X
Xsmg$flush_buffer
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$get_broadcast_message
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X        message (2) character
X        message_length (3) word
X        message_type (4) word
X
X
X
Xsmg$get_char_at_physical_cursor
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X        character_code (2) byte
X
X
X
Xsmg$get_display_attr
X    Inputs:
X        display_id (1) longword
X        character_set (6) longword optional
X    Results:
X        status (return value) longword
X        height (2) longword
X        width (3) longword
X        display_attributes (4) longword
X        video_attributes (5) longword
X        flags (7) longword
X
X
X
Xsmg$get_keyboard_attributes
X    Inputs:
X        keyboard_id (1) longword
X        p_kit_size (3) longword
X    Results:
X        status (return value) longword
X        p_kit (2) address
X
X
X
Xsmg$get_key_def
X    Inputs:
X        key_table_id (1) longword
X        key_name (2) character
X        if_state (3) character optional
X    Results:
X        status (return value) longword
X        attributes (4) longword
X        equivalence_string (5) character
X        state_string (6) character
X
X
X
Xsmg$get_numeric_data
X    Inputs:
X        termtable_address (1) address
X        request_code (2) longword
X    Results:
X        status (return value) longword
X        buffer_address (3) address
X
X
X
Xsmg$get_pasting_info
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X    Results:
X        status (return value) longword
X        flags (3) longword
X        pasteboard_row (4) longword
X        pasteboard_column (5) longword
X
X
X
Xsmg$get_pasteboard_attributes
X    Inputs:
X        pasteboard_id (1) longword
X        pasteboard_info_table_size (3) longword
X    Results:
X        status (return value) longword
X        pasteboard_info_table (2) any
X
X
X
Xsmg$get_term_data
X    Inputs:
X        termtable_address (1) address
X        request_code (2) longword
X        maximum_buffer_length (3) longword
X        input_argument_vector (6) longword optional
X    Results:
X        status (return value) longword
X        return_length (4) longword
X        buffer_address (5) address
X
X
X
Xsmg$get_viewport_char
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X        viewport_row_start (2) longword
X        viewport_column_start (3) longword
X        viewport_number_rows (4) longword
X        viewport_number_columns (5) longword
X
X
X
Xsmg$home_cursor
X    Inputs:
X        display_id (1) longword
X        position_code (2) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$init_term_table
X    Inputs:
X        terminal_name (1) character
X    Results:
X        status (return value) longword
X        termtable_address (2) address
X
X
X
Xsmg$insert_chars
X    Inputs:
X        display_id (1) longword
X        character_string (2) character
X        start_row (3) longword
X        start_column (4) longword
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$insert_line
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        character_string (3) character optional
X        direction (4) longword optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X        flags (7) longword optional
X        character_set (8) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$init_term_table_by_type
X    Inputs:
X        terminal_type (1) byte
X    Results:
X        status (return value) longword
X        termtable_address (2) address
X        terminal_name (3) character
X
X
X
Xsmg$invalidate_display
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$keycode_to_name
X    Inputs:
X        key_code (1) word
X    Results:
X        status (return value) longword
X        key_name (2) character
X
X
X
Xsmg$label_border
X    Inputs:
X        display_id (1) longword
X        text (2) character optional
X        position_code (3) longword optional
X        units (4) longword optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$load_key_defs
X    Inputs:
X        key_table_id (1) longword
X        filespec (2) character
X        default_filespec (3) character optional
X        flags (4) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$list_key_defs
X    Inputs:
X        key_table_id (1) longword
X        context (2) longword
X        key_name (3) character optional
X    Results:
X        status (return value) longword
X        context (2) longword
X        key_name (3) character
X        if_state (4) character
X        attributes (5) longword
X        equivalence_string (6) character
X        state_string (7) character
X
X
X
Xsmg$list_pasting_order
X    Inputs:
X        pasteboard_id (1) longword
X        context (2) longword
X    Results:
X        status (return value) longword
X        context (2) longword
X        display_id (3) longword
X        pasteboard_row (4) longword
X        pasteboard_column (5) longword
X
X
X
Xsmg$load_virtual_display
X    Inputs:
X        filespec (2) character optional
X    Results:
X        status (return value) longword
X        display_id (1) longword
X
X
X
Xsmg$move_virtual_display
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X        pasteboard_row (3) longword
X        pasteboard_column (4) longword
X        top_display_id (5) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$move_text
X    Inputs:
X        display_id (1) longword
X        top_left_row (2) longword
X        top_left_column (3) longword
X        bottom_right_row (4) longword
X        bottom_right_column (5) longword
X        display_id2 (6) longword
X        top_left_row2 (7) longword optional
X        top_left_column2 (8) longword optional
X        flags (9) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$name_to_keycode
X    Inputs:
X        key_name (1) character
X    Results:
X        status (return value) longword
X        key_code (2) word
X
X
X
Xsmg$paste_virtual_display
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X        pasteboard_row (3) longword
X        pasteboard_column (4) longword
X        top_display_id (5) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_chars
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        start_row (3) longword optional
X        start_column (4) longword optional
X        flags (5) longword optional
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X        character_set (8) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_chars_highwide
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        start_row (3) longword optional
X        start_column (4) longword optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_chars_multi
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        line_number (3) longword optional
X        column_number (4) longword optional
X        flags (5) longword optional
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X        character_set (8) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_chars_wide
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        start_row (3) longword optional
X        start_column (4) longword optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_help_text
X    Inputs:
X        display_id (1) longword
X        keyboard_id (2) longword optional
X        help_topic (3) character optional
X        help_library (4) character optional
X        rendition_set (5) longword optional
X        rendition_complement (6) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_line
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        line_advance (3) longword optional
X        rendition_set (4) longword optional
X        rendition_complement (5) longword optional
X        flags (6) longword optional
X        character_set (7) longword optional
X        direction (8) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_line_highwide
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        line_advance (3) longword optional
X        rendition_set (4) longword optional
X        rendition_complement (5) longword optional
X        flags (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_line_multi
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        rendition_set (3) longword optional
X        rendition_complement (4) longword optional
X        line_advance (5) longword optional
X        flags (6) longword optional
X        direction (7) longword optional
X        character_set (8) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_line_wide
X    Inputs:
X        display_id (1) longword
X        text (2) character
X        line_advance (3) longword optional
X        rendition_set (4) longword optional
X        rendition_complement (5) longword optional
X        flags (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$pop_virtual_display
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_pasteboard
X    Inputs:
X        pasteboard_id (1) longword
X        action_routine (2) address
X        user_argument (3) any
X        flags (4) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$print_pasteboard
X    Inputs:
X        pasteboard_id (1) longword
X        queue_name (2) character optional
X        copies (3) longword optional
X        form_name (4) character optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_status_line
X    Inputs:
X        pasteboard_id (1) longword
X        text (2) character
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_virtual_display_encoded
X    Inputs:
X        display_id (1) longword
X        encoded_length (2) longword
X        encoded_text (3) any
X        start_row (4) longword optional
X        start_column (5) longword optional
X        placeholder_argument (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$put_with_scroll
X    Inputs:
X        display_id (1) longword
X        text (2) character optional
X        direction (3) longword optional
X        rendition_set (4) longword optional
X        rendition_complement (5) longword optional
X        flags (6) longword optional
X        character_set (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$ring_bell
X    Inputs:
X        display_id (1) longword
X        number_of_times (2) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$read_composed_line
X    Inputs:
X        keyboard_id (1) longword
X        key_table_id (2) longword
X        prompt_string (4) character optional
X        display_id (6) longword optional
X        flags (7) longword optional
X        initial_string (8) character optional
X        timeout (9) longword optional
X        rendition_set (10) longword optional
X        rendition_complement (11) longword optional
X    Results:
X        status (return value) longword
X        resultant_string (3) character
X        resultant_length (5) word
X        word_terminator_code (12) word
X
X
X
Xsmg$remove_line
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword
X        start_column (3) longword
X        end_row (4) longword
X        end_column (5) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$replace_input_line
X    Inputs:
X        keyboard_id (1) longword
X        replace_string (2) character optional
X        line_count (3) byte optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$return_input_line
X    Inputs:
X        keyboard_id (1) longword
X        match_string (3) character optional
X        byte_integer_line_number (4) byte optional
X    Results:
X        status (return value) longword
X        resultant_string (2) character
X        resultant_length (5) word
X
X
X
Xsmg$read_from_display
X    Inputs:
X        display_id (1) longword
X        terminator_string (3) character optional
X        start_row (4) longword optional
X    Results:
X        status (return value) longword
X        resultant_string (2) character
X
X
X
Xsmg$read_keystroke
X    Inputs:
X        keyboard_id (1) longword
X        prompt_string (3) character optional
X        timeout (4) longword optional
X        display_id (5) longword optional
X        rendition_set (6) longword optional
X        rendition_complement (7) longword optional
X    Results:
X        status (return value) longword
X        word_terminator_code (2) word
X
X
X
Xsmg$repaint_line
X    Inputs:
X        pasteboard_id (1) longword
X        start_row (2) longword
X        number_of_lines (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$repaint_screen
X    Inputs:
X        pasteboard_id (1) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$repaste_virtual_display
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X        pasteboard_row (3) longword
X        pasteboard_column (4) longword
X        top_display_id (5) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$restore_physical_screen
X    Inputs:
X        pasteboard_id (1) longword
X        display_id (2) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$read_string
X    Inputs:
X        keyboard_id (1) longword
X        prompt_string (3) character optional
X        maximum_length (4) longword optional
X        modifiers (5) longword optional
X        timeout (6) longword optional
X        terminator_set (7) any optional
X        display_id (10) longword optional
X        initial_string (11) character optional
X        rendition_set (12) longword optional
X        rendition_complement (13) longword optional
X        terminator_string (14) character optional
X    Results:
X        status (return value) longword
X        resultant_string (2) character
X        resultant_length (8) word
X        word_terminator_code (9) word
X
X
X
Xsmg$return_cursor_pos
X    Inputs:
X        display_id (1) longword
X    Results:
X        status (return value) longword
X        start_row (2) longword
X        start_column (3) longword
X
X
X
Xsmg$read_verify
X    Inputs:
X        keyboard_id (1) longword
X        initial_string (3) character
X        picture_string (4) character
X        fill_character (5) character
X        clear_character (6) character
X        prompt_string (7) character optional
X        modifiers (8) longword optional
X        timeout (9) longword optional
X        terminator_set (10) any optional
X        initial_offset (11) longword optional
X        display_id (13) longword optional
X        alternate_echo_string (14) character optional
X        alternate_display_id (15) longword optional
X        rendition_set (16) longword optional
X        rendition_complement (17) longword optional
X    Results:
X        status (return value) longword
X        resultant_string (2) character
X        word_terminator_code (12) word
X
X
X
Xsmg$set_broadcast_trapping
X    Inputs:
X        pasteboard_id (1) longword
X        ast_routine (2) address optional
X        ast_argument (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$scroll_display_area
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        start_column (3) longword optional
X        height (4) longword optional
X        width (5) longword optional
X        direction (6) longword optional
X        count (7) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_cursor_abs
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        start_column (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_cursor_rel
X    Inputs:
X        display_id (1) longword
X        delta_row (2) longword optional
X        delta_column (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$scroll_viewport
X    Inputs:
X        display_id (1) longword
X        direction (2) longword optional
X        count (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_display_scroll_region
X    Inputs:
X        display_id (1) longword
X        start_row (2) longword optional
X        end_row (3) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$select_from_menu
X    Inputs:
X        keyboard_id (1) longword
X        display_id (2) longword
X        default_choice_number (4) word optional
X        flags (5) longword optional
X        help_library (6) character optional
X        timeout (7) longword optional
X        rendition_set (10) longword optional
X        rendition_complement (11) longword optional
X    Results:
X        status (return value) longword
X        selected_choice_number (3) word
X        terminator_code (8) word
X        selected_choice_string (9) character
X
X
X
Xsmg$set_cursor_mode
X    Inputs:
X        pasteboard_id (1) longword
X        flags (2) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_keypad_mode
X    Inputs:
X        keyboard_id (1) longword
X        flags (2) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$snapshot
X    Inputs:
X        pasteboard_id (1) longword
X        flags (2) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_out_of_band_asts
X    Inputs:
X        pasteboard_id (1) longword
X        control_character_mask (2) longword
X        ast_routine (3) address
X        ast_argument (4) longword optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_physical_cursor
X    Inputs:
X        pasteboard_id (1) longword
X        pasteboard_row (2) longword
X        pasteboard_column (3) longword
X    Results:
X        status (return value) longword
X
X
X
Xsmg$set_default_state
X    Inputs:
X        key_table_id (1) longword
X        new_state (2) character optional
X    Results:
X        status (return value) longword
X        old_state (3) character
X
X
X
Xsmg$set_term_characteristics
X    Inputs:
X        pasteboard_id (1) longword
X        on_characteristics1 (2) longword optional
X        on_characteristics2 (3) longword optional
X        off_characteristics1 (4) longword optional
X        off_characteristics2 (5) longword optional
X    Results:
X        status (return value) longword
X        old_characteristics1 (6) longword
X        old_characteristics2 (7) longword
X
X
X
Xsmg$save_virtual_display
X    Inputs:
X        display_id (1) longword
X        filespec (2) character optional
X    Results:
X        status (return value) longword
X
X
X
Xsmg$save_physical_screen
X    Inputs:
X        pasteboard_id (1) longword
X        desired_start_row (3) longword optional
X        desired_end_row (4) longword optional
X    Results:
X        status (return value) longword
X        display_id (2) longword
X
X
X
Xsmg$unpaste_virtual_display
X    Inputs:
X        display_id (1) longword
X        pasteboard_id (2) longword
X    Results:
X        status (return value) longword
X
X
X
$ CALL UNPACK SMGFUNS.DOC;4 1746825152
$ create 'f'
X#ifdef VMS
X#include <stddef.h>
X#include <stdio.h>
X/* sys_fwrite -- A replacement for fwrite.
X   VAX/VMS C's fwrite has been extended so that when writing to a record
X   oriented file each call to fwrite produces one record.  This is convenien
Vt
X   when one is working with RMS files.  However, if one is writing to a
X   non-streamLF text file or a mailbox, which are also record oriented, each
X   call to fwrite still produces one record WITH AN IMPLICIT END-OF-RECORD!
X   This means that if you write out two strings with two calls to fwrite
X   they will be seperate lines, even if there is no embedded newline.
X   This version of fwrite just uses fputc to write out each byte in the
X   object, thus avoiding the whole mess.
X */
Xsize_t
Xsys_fwrite (const void *ptr, size_t size, size_t nelem, FILE *stream)
X`7B
X  size_t i;
X  char *cptr;
X  size_t nchars;
X  char ch;
X  int stat;
X `20
X  cptr = (char *) ptr;
X  nchars = size * nelem;
X  for (i = 0; i < nchars; i++)
X    `7B
X      ch = *cptr++;
X      stat = fputc (ch, stream);
X      if (EOF == stat)
X`09return i / size;`09/* error, so quit */
X    `7D
X  return i / size;
X`7D
X#endif /* defined (VMS) */
$ CALL UNPACK SYSDEP.C;3 1461916929
$ create 'f'
X;;; trysmg.scm
X
X;;; This code is ugly and poorly written, but should give you some
X;;; idea how to use these routines.
X
X(define dodbg #f)
X(if dodbg`20
X    (require 'debug))
X
X(define input-device #f)
X(define pbd (vector-ref (smg$create_pasteboard input-device) 1))
X(define kbd (vector-ref (smg$create_virtual_keyboard input-device) 1))
X(define display-id (vector-ref (smg$create_virtual_display 24 80) 1))
X
X(define smg$m_reverse #x00000002)
X
X
X(define (beginning-screen)
X  (smg$put_chars display-id "Hello!" 1 1 #f smg$m_reverse)
X  (smg$put_chars display-id "Hello!" 24 1)
X  (smg$put_chars display-id "Hello!" 1 75 #f #f smg$m_reverse)
X  (smg$put_chars display-id "Hello!" 24 75)
X  (smg$put_chars display-id ">" 12 39)
X  (smg$put_chars display-id "Press HELP for a list of keys" 24 30 #f #f
X`09`09 smg$m_reverse))
X
X;; Define the SMG termcodes for the keys we'll use.
X(define smg$k_trm_ctrlz 26)
X(define smg$k_trm_up 274)
X(define smg$k_trm_down 275)
X(define smg$k_trm_left 276)
X(define smg$k_trm_right 277)
X(define smg$k_trm_ctrli 9)
X(define smg$k_trm_ctrlh 8)
X(define smg$k_trm_help 295)
X(define smg$k_trm_do 296)
X(define smg$k_trm_insert_here 312)
X(define smg$k_trm_ctrlr 18)
X(define smg$k_trm_f19 299)
X(define smg$k_trm_f20 300)
X
X
X(define row 1)
X(define col 1)
X
X(define (set-pos r c)
X  (set! row (if (> r 24)
X`09`09(- r 24)
X`09`09(if (< r 1)
X`09`09    (+ r 24)
X`09`09    r)))
X  (set! col (if (> c 80)
X`09`09(- c 80)
X`09`09(if (< c 1)
X`09`09    (+ c 80)
X`09`09    c)))
X  (smg$set_cursor_abs display-id row col))
X
X(define (reset-pos)
X  (smg$set_cursor_abs display-id row col))
X
X(define (main)
X  (smg$paste_virtual_display display-id pbd 1 1)
X  (beginning-screen)
X  (set-pos 12 40)
X  (do ((key (vector-ref (smg$read_keystroke kbd) 1)
X`09    (vector-ref (smg$read_keystroke kbd) 1)))
X      ((or (not (number? key))
X`09   (= key SMG$K_TRM_CTRLZ)))
X    (action key))
X  (smg$set_physical_cursor pbd 24 1)
X  (smg$delete_pasteboard pbd 0)
X  (smg$delete_virtual_display display-id)
X  (smg$delete_virtual_keyboard kbd))
X
X(define (action key)
X  (cond
X   ((= key SMG$K_TRM_UP)
X    (set-pos (- row 1) col))
X   ((= key SMG$K_TRM_DOWN)
X    (set-pos (+ row 1) col))
X   ((= key SMG$K_TRM_LEFT)
X    (set-pos row (- col 1)))
X   ((= key SMG$K_TRM_RIGHT)
X    (set-pos row (+ col 1)))
X   ((= key SMG$K_TRM_CTRLI)
X    (set-pos row (+ col 8)))
X   ((= key SMG$K_TRM_CTRLH)`20
X    (set-pos row (- col 8)))
X   ((= key SMG$K_TRM_DO)
X    (let ((pos (smg$return_cursor_pos display-id)))
X;    (smg$put_chars display-id (pair-string row col 3) 12 41)
X      (smg$put_chars display-id (pair-string (vector-ref pos 1)
X`09`09`09`09`09     (vector-ref pos 2) 3) 12 41))
X    (reset-pos))
X   ((= key SMG$K_TRM_INSERT_HERE)
X    (smg$put_chars display-id "*" row col)
X    (reset-pos))
X   ((= key SMG$K_TRM_CTRLR)
X    (smg$repaint_screen pbd))
X   ((= key SMG$K_TRM_F20)
X    (box)
X    (reset-pos))
X   ((= key SMG$K_TRM_HELP)
X    (help-screen)
X    (reset-pos))
X   ((= key SMG$K_TRM_F19)
X    (cond (rend-toggle
X`09   (smg$change_rendition
X`09    display-id 12 41 1 10 on-bits-set on-bits-comp)
X`09   (set! rend-toggle #f))
X`09  (else
X`09   (smg$change_rendition
X`09    display-id 12 41 1 10 off-bits-set off-bits-comp)
X`09   (set! rend-toggle #t))))
X   (else
X    (smg$ring_bell display-id 2))))
X
X(define rend-toggle #t)
X(define on-bits-set smg$m_reverse)`09`09;bit 1 is SMG$M_REVERSE
X(define on-bits-comp 0)
X(define off-bits-set smg$m_reverse)
X(define off-bits-comp smg$m_reverse)
X
X(define (pair-string x y width)
X  (let ((xs (pad (number->string x) width "0"))
X`09(ys (pad (number->string y) width "0")))
X    (string-append "(" xs "," ys ")")))
X
X(define (pad s w padding)
X  (do ((s s (string-append padding s)))
X      ((>= (string-length s) w)
X       s)))
X
X(define (the-end)
X  (smg$delete_virtual_display display-id)
X  (smg$delete_virtual_keyboard kbd)
X  (smg$delete_pasteboard pbd 1))
X
X(define (box)
X  (define display-id (vector-ref (smg$create_virtual_display 5 10 1) 1))
X  (smg$paste_virtual_display display-id pbd row col)
X  (smg$put_chars display-id "Golly!" 1 1)
X  (smg$put_chars display-id "A Box!" 3 1)
X  (smg$read_keystroke kbd)
X  (smg$delete_virtual_display display-id))
X
X(define (help-screen)
X  (let ((display-id (vector-ref (smg$create_virtual_display 15 50 1) 1))
X`09(text-list '("Help Screen"
X`09`09     ""
X`09`09     "Ctrl-Z: Exit        Ctrl-R: Repaint"
X`09`09     "Up Arrow: Up        Down Arrow: Down"
X`09`09     "Left Arrow: Left    Right Arrow: Right"
X`09`09     "Ctrl-I: Right 8     Ctrl-H: Left 8"
X`09`09     "Do: Location        Insert Here: Insert a `60*'"
X`09`09     "F20: Popup Box      F19: Change Rendition"
X`09`09     "Help: This screen"
X`09`09     ""
X`09`09     "Press any key to continue"`20
X`09`09     )))
X    (smg$paste_virtual_display display-id pbd 3 15)
X    (do ((i 1 (+ i 1))
X`09 (l text-list (cdr l)))
X`09((null? l) #f)
X      (smg$put_chars display-id (car l) i 1))
X    (smg$read_keystroke kbd)
X    (smg$delete_virtual_display display-id)))
X
X
X`0C
X
X(cond (dodbg
X       (set! smg$create_pasteboard
X`09     (tracef smg$create_pasteboard 'smg$create_pasteboard))
X       (set! smg$create_virtual_keyboard
X`09     (tracef smg$create_virtual_keyboard 'smg$create_virtual_keyboard))
X       (set! smg$create_virtual_display
X`09     (tracef smg$create_virtual_display 'smg$create_virtual_display))
X       (set! smg$put_chars
X`09     (tracef smg$put_chars 'smg$put_chars))
X       (set! smg$set_cursor_abs
X`09     (tracef smg$set_cursor_abs 'smg$set_cursor_abs))
X       (set! smg$paste_virtual_display
X`09     (tracef smg$paste_virtual_display 'smg$paste_virtual_display))
X       (set! smg$read_keystroke
X`09     (tracef smg$read_keystroke 'smg$read_keystroke))
X       (set! smg$set_physical_cursor
X`09     (tracef smg$set_physical_cursor 'smg$set_physical_cursor))
X       (set! smg$delete_pasteboard
X`09     (tracef smg$delete_pasteboard 'smg$delete_pasteboard))
X       (set! smg$delete_virtual_display
X`09     (tracef smg$delete_virtual_display 'smg$delete_virtual_display))
X       (set! smg$delete_virtual_keyboard
X`09     (tracef smg$delete_virtual_keyboard 'smg$delete_virtual_keyboard))
X       ))
X`0C
X
X
X(main)
$ CALL UNPACK TRYSMG.SCM;10 1845841291
$ create 'f'
X;;; trysmg2.scm
X
X;;; This code is ugly and poorly written, but should give you some
X;;; idea how to use these routines.
X
X(define reverse_bits 2)`09`09;SMG$M_REVERSE
X(define SMG$K_BOTTOM 1)
X(define SMG$M_BORDER 1)
X
X
X(define input-device #f)
X(define pbd (vector-ref (smg$create_pasteboard input-device) 1))
X(define kbd (vector-ref (smg$create_virtual_keyboard input-device) 1))
X(define display-id (vector-ref
X`09`09    (smg$create_virtual_display 22 78 SMG$M_BORDER) 1))
X
X
X(define (beginning-screen)
X  (smg$label_border display-id " Stuff " SMG$K_BOTTOM #f reverse_bits)
X  (smg$put_chars display-id "Hello!" 1 1 #f reverse_bits)
X  (smg$put_chars display-id "Hello!" 22 1)
X  (smg$put_chars display-id "Hello!" 1 73 #f #f reverse_bits)
X  (smg$put_chars display-id "Hello!" 22 73)
X  (smg$put_chars display-id ">" 10 37))
X
X;; Define the SMG termcodes for the keys we'll use.
X(define CTRL_Z 26)
X(define UP 274)
X(define DOWN 275)
X(define LEFT 276)
X(define RIGHT 277)
X(define TAB 9)
X(define BS 8)
X(define DO_KEY 296)
X(define INSERT 312)
X(define REPAINT 18)
X(define F19 299)
X(define F20 300)
X
X(define row 1)
X(define col 1)
X
X(define (set-pos r c)
X  (set! row (if (> r 22)
X`09`09(- r 22)
X`09`09(if (< r 1)
X`09`09    (+ r 22)
X`09`09    r)))
X  (set! col (if (> c 78)
X`09`09(- c 78)
X`09`09(if (< c 1)
X`09`09    (+ c 78)
X`09`09    c)))
X  (smg$set_cursor_abs display-id row col))
X
X(define (reset-pos)
X  (smg$set_cursor_abs display-id row col))
X
X(define (main)
X  (smg$paste_virtual_display display-id pbd 2 2)
X  (beginning-screen)
X  (smg$begin_display_update display-id)
X  (smg$put_chars display-id "`5BDown`5D" 22 37)
X  (smg$put_chars display-id "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Vxxxxxxxxxxxxxxxxxxx" 21 1)
X  (smg$put_chars display-id "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Vxxxxxxxxxxxxxxxxxxx" 2 1)
X  (smg$put_chars display-id "`5BUp`5D" 1 37)
X  (smg$end_display_update display-id)
X  (cond (#f
X`09 (set-pos 10 35)
X`09 (display (smg$change_pbd_characteristics pbd))
X`09 (set-pos 15 1)
X`09 (smg$change_virtual_display display-id 16 20)))
X  (cond (#t
X`09 (display " (should be no) ")
X`09 (display (smg$check_for_occlusion display-id pbd))
X`09 (smg$read_keystroke kbd)
X`09 (let ((nd (vector-ref
X`09`09    (smg$create_virtual_display 10 20 SMG$M_BORDER) 1)))
X`09   (smg$paste_virtual_display nd pbd 8 20)
X`09   (smg$put_chars nd "Hello!" 3 3)
X`09   (smg$label_border nd " Over " #f #f reverse_bits)
X`09   (display " (should be yes) ")
X`09   (display (smg$check_for_occlusion display-id pbd))
X`09   (display " (should be no) ")
X`09   (display (smg$check_for_occlusion nd pbd))
X`09   (smg$read_keystroke kbd))))
X  ;;
X  (do ((key (vector-ref (smg$read_keystroke kbd) 1)
X`09    (vector-ref (smg$read_keystroke kbd) 1)))
X      ((or (not (number? key))
X`09   (= key CTRL_Z)))
X    (action key))
X  (smg$set_physical_cursor pbd 22 1)
X  (smg$delete_pasteboard pbd #f)
X  (smg$delete_virtual_display display-id)
X  (smg$delete_virtual_keyboard kbd))
X
X(define (action key)
X  (cond
X   ((= key UP)
X    (set-pos (- row 1) col))
X   ((= key DOWN)
X    (set-pos (+ row 1) col))
X   ((= key LEFT)
X    (set-pos row (- col 1)))
X   ((= key RIGHT)
X    (set-pos row (+ col 1)))
X   ((= key TAB)
X    (set-pos row (+ col 8)))
X   ((= key BS)`20
X    (set-pos row (- col 8)))
X   ((= key DO_KEY)
X    (let ((pos (smg$return_cursor_pos display-id)))
X;    (put-chars display-id (pair-string row col 3) 12 41)
X      (smg$put_chars display-id (pair-string (vector-ref pos 1)
X`09`09`09`09`09 (vector-ref pos 2) 3) 12 41))
X    (reset-pos))
X   ((= key INSERT)
X    (smg$put_chars display-id "*" row col)
X    (reset-pos))
X   ((= key REPAINT)
X    (smg$repaint_screen pbd))
X   ((= key F20)
X    (box)
X    (reset-pos))
X   ((= key F19)
X    (cond (rend-toggle
X`09   (smg$change_rendition display-id
X`09`09`09`09 12 41 1 10 on-bits-set on-bits-comp)
X`09   (set! rend-toggle #f))
X`09  (else
X`09   (smg$change_rendition display-id
X`09`09`09`09 12 41 1 10 off-bits-set off-bits-comp)
X`09   (set! rend-toggle #t))))
X   (else
X    (smg$ring_bell display-id 1))))
X
X(define rend-toggle #t)
X(define on-bits-set 2)`09`09;bit 1 is SMG$M_REVERSE
X(define on-bits-comp 0)
X(define off-bits-set 2)
X(define off-bits-comp 2)
X
X(define (pair-string x y width)
X  (let ((xs (pad (number->string x) width "0"))
X`09(ys (pad (number->string y) width "0")))
X    (string-append "(" xs "," ys ")")))
X
X(define (pad s w padding)
X  (do ((s s (string-append padding s)))
X      ((>= (string-length s) w)
X       s)))
X
X(define (the-end)
X  (smg$delete_virtual_display display-id)
X  (smg$delete_virtual_keyboard kbd)
X  (smg$delete_pasteboard pbd 1))
X
X(define (box)
X  (define display-id (vector-ref (smg$create_virtual_display 5 10 1) 1))
X  (smg$paste_virtual_display display-id pbd row col)
X  (smg$put_chars display-id "Golly!" 1 1)
X  (smg$put_chars display-id "A Box!" 3 1)
X  (smg$read_keystroke kbd)
X  (write (smg$get_display_attr display-id))
X  (smg$read_keystroke kbd)
X  (smg$delete_virtual_display display-id))
X
X
X(main)
$ CALL UNPACK TRYSMG2.SCM;6 1716419210
$ create 'f'
X$ ! output will be in build.log
X$ define/user sys$output build.log
X$ ! From: T. Kurt Bond, tkb@mtnet2.wvnet.edu
X$ !
X$ ! Build scm on VMS systems.
X$ !
X$ ! p1: Options for cc.
X$ ! p2: Options for link.
X$ ! p3: Options for macro.
X$ !
X$ ! The following lines define IMPLINIT as the directory in which this comma
Vnd
X$ ! procedure is followed by "Init.scm".  If you want it someplace else,`20
X$ ! replace the `60init = ...' line with `60init = "yourfile".
X$ !
X$ where = f$environment("PROCEDURE")`09!full pathname of this procedure
X$ where = f$parse(where,,,"DEVICE")+f$parse(where,,,"DIRECTORY") !device:`5B
Vdir`5D
X$ init = where + "init.scm" `09`09!device:`5Bdir`5Dinit.scm
X$ SYSDEP=""
X$ !SYSDEP="sysdep"
X$ !
X$ ! If you don't want floating point, delete the `60"FLOATS",' on the lines
X$ ! below.
X$ cc /define=("FLOATS","IMPLINIT=""''init'""") 'p1 repl
X$ cc /define=("FLOATS","INITS=") 'p1 scm,time,eval,scl,subr,sys,sc2,unif
X$ cc smg,scmint
X$ if SYSDEP .nes. ""`20
X$ then`20
X$`09cc 'p1 'SYSDEP'
X$`09SYSDEP = SYSDEP + ","
X$ endif
X$ macro 'p3 setjump
X$   link/exe=smgscm.exe 'p2 -
X`09scm,repl,time,eval,scl,subr,sys,sc2,unif,setjump,smg,scmint,'SYSDEP' -
X`09sys$input/opt
X`09`09sys$share:vaxcrtl/share
$ CALL UNPACK VMSBUILD.COM-SMG;3 335652
$ create 'f'
X$ ! output will be in build.log
X$ define/user sys$output build.log
X$ ! From: T. Kurt Bond, tkb@mtnet2.wvnet.edu
X$ !
X$ ! Build scm on VMS systems.
X$ !
X$ ! p1: Options for cc.
X$ ! p2: Options for link.
X$ ! p3: Options for macro.
X$ !
X$ ! The following lines define IMPLINIT as the directory in which this comma
Vnd
X$ ! procedure is followed by "Init.scm".  If you want it someplace else,`20
X$ ! replace the `60init = ...' line with `60init = "yourfile".
X$ !
X$ where = f$environment("PROCEDURE")`09!full pathname of this procedure
X$ where = f$parse(where,,,"DEVICE")+f$parse(where,,,"DIRECTORY") !device:`5B
Vdir`5D
X$ init = where + "init.scm" `09`09!device:`5Bdir`5Dinit.scm
X$ SYSDEP=""
X$ !SYSDEP="sysdep"
X$ !
X$ ! If you don't want floating point, delete the `60"FLOATS",' on the lines
X$ ! below.
X$ gcc 'p1 scm  /define=("FLOATS","INITS=init_smg();init_sc2();","FINALS=;")
X$ gcc 'p1 repl /define=("FLOATS","IMPLINIT=""''init'""")
X$ gcc 'p1 eval /define=("FLOATS")
X$ gcc 'p1 time /define=("FLOATS")
X$ gcc 'p1 scl  /define=("FLOATS")
X$ gcc 'p1 subr
X$ gcc 'p1 sys  /define=("FLOATS")
X$ gcc 'p1 sc2
X$ gcc 'p1 unif /define=("FLOATS")
X$ macro 'p3 setjump
X$ gcc 'p1 smg.c
X$ gcc 'p1 scmint.c
X$ if SYSDEP .nes. ""`20
X$ then`20
X$`09gcc 'p1 'SYSDEP'
X$`09SYSDEP = SYSDEP + ","
X$ endif
X$ gcc 'p1 pi
X$
X$   link/exe=smgscm.exe 'p2 -
X`09scm,repl,time,eval,scl,subr,sys,sc2,unif,setjump,smg,scmint,'SYSDEP'-
X`09sys$input/opt
X`09`09gnu_cc:`5B000000`5Dgcclib/lib,-
X`09`09sys$share:vaxcrtl/share
$ CALL UNPACK VMSGCC.COM-SMG;5 125331421
$ v=f$verify(v)
$ EXIT
