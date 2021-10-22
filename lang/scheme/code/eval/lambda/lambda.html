;;;
;;;
;;;	Interprete de lambda-calcul
;;;
;;;		Olivier Besson
;;;
;
;
;	lancement par (lamb)
;
;
; pour sauver le dictionnaire
(define dictionnaire '())

; retourne la forme d'un lambda-terme (variable, abstraction, application)
(define form-term
   (lambda (term)
      (cond
         ((pair? term) (if (eq? (car term) '\ ) 'abstraction 'application))
         (else 'variable))))


; verifie qu'un lambda-terme en est bien un
(define ok-term?
   (lambda (term)
      (let ((forme '()))
      (set! forme (form-term term))
      (cond   ((eq? forme 'abstraction) (and (eq? (form-term (cadr term)) 'variable) (ok-term? (caddr term))))
         ((eq? forme 'application) (and (not (null? (cdr term))) (ok-term? (car term)) (ok-term? (cadr term))))
         ((eq? forme 'variable) (not (null? term)))))))

(define set-empty? null?)

; ele figure-t-il dans la structure(de paires) set?
(define element?
  (lambda (ele set)
    (cond
      ((set-empty? set) #f)
      (else (if (pair?  set) (or (element? ele (car set)) (element? ele (cdr set))) (eq? ele set))))))

; si ele n'y est pas deja, il est place cdr-maximalement dans set
(define element!
  (lambda (ele set)
    (if (set-empty? set) (set! set ele) (if (element? ele set) '()
                  (let loop ((bip set))
                    (if
                      (null? (cdr bip)) (set-cdr! bip (cons ele '())) (loop (cdr bip)))
               )))))

(define set-union
  (lambda (set1 set2)
    (if (set-empty? set1) set2
      (if (pair? set1)
   (set-union (car set1) (set-union (cdr set1) set2))
   (if (element? set1 set2) set2 (cons set1 set2))))))

(define set-intersection
  (lambda (set1 set2)
    (if (set-empty? set1) '()
      (if (pair? set1)
   (set-union (set-intersection (car set1) set2) (set-intersection (cdr set1) set2))
   (if (element? set1 set2) set1 '())))))

(define set-display
  (lambda (set)
    (if (set-empty? set) '()
      (if (pair? set) (begin (set-display (car set)) (set-display (cdr set)))
   (begin (write set) (write-char  #\,))))))

(define set->pretty-set
  (lambda (set)
    (cond
      ((pair? set) (append (set->pretty-set (car set)) (set->pretty-set (cdr set))))
      ((null? set) '())
      (else (list set)))))

; retourne l'ensemble des variables libres du terme
(define fri-variabeulz
  (lambda (term var-list)
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) (if (element? term var-list) '() term))
   ((eq? forme 'application) (set-union (fri-variabeulz (car term) var-list) (fri-variabeulz (cadr term) var-list)))
   ((eq? forme 'abstraction) (fri-variabeulz (caddr term) (cons (cadr term) var-list)))
      ))))

; retourne l'ensemble des variables liees du terme
(define baounde-variabeulz
  (lambda (term )
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) '())
   ((eq? forme 'application) (set-union (baounde-variabeulz (car term)) (baounde-variabeulz (cadr term))))
   ((eq? forme 'abstraction) (cons (cadr term) (baounde-variabeulz (caddr term))))
      ))))


;substitue new a var en TOUTES ses occurences
(define substitut-brut
  (lambda (new var term)
    (let ((forme '()))
      (set! forme (form-term term))
      (cond
   ((eq? forme 'variable) (if (eq? term var) new term))
   ((eq? forme 'application) (list (substitut-brut new var (car term)) (substitut-brut new var (cadr term))))
   ((eq? forme 'abstraction)
     (list '\ (substitut-brut new var (cadr term)) (substitut-brut new var (caddr term))))
      ))))


;substitue new a var en ses occurences  libres
(define substitut
  (lambda (new var term)
    (let ((forme '()))
      (set! forme (form-term term))
      (cond
   ((eq? forme 'variable) (if (eq? term var) new term))
   ((eq? forme 'application) (list (substitut new var (car term)) (substitut new var (cadr term))))
   ((eq? forme 'abstraction)
     (if (eq? var (cadr term))
       term
     (list '\ (substitut new var (cadr term)) (substitut new var (caddr term)))))
      ))))


;rend #T si les deux termes sont alpha-equivalents
; pb: fact vaut nil au depart, et n'est pas modifie.
; quel est le sens des tests sur fact ? a revoir %%%% !
(define alpha-eq?
  (lambda (term1 term2 var-list)
    (let ((forme1 '()) (forme2 '()) (fact '()))
      (set! forme1 (form-term term1))
      (set! forme2 (form-term term2))
      (if (eq? forme1 forme2)
         (cond
           ((eq? forme1 'variable)
             (if (not (null? var-list))
                 (let ((result '()))
                   (set! result
                      (let loop ((fact var-list))
                        (if (not (null? fact))
                            (if (eq? (caar fact) term1) (cdar fact) (loop (cdr fact))) '() )))
                   (if (not (null? result)) (eq? result term2) (eq? term1 term2)))))
           ((eq? forme1'application)
              (and (alpha-eq? (car term1) (car term2) var-list)
                   (alpha-eq? (cadr term1) (cadr term2) var-list)))
           ((eq? forme1 'abstraction)
              (alpha-eq? (caddr term1) (caddr term2) (cons (cons (cadr term1) (cadr term2)) var-list))))
      #f))))

(define (new-symbol-var init-var)
  (lambda ()
    (begin
    (set! init-var (+ init-var 1))
    (string->symbol (string-append "v" (number->string init-var))))))

; rend #T si var2 apparait sous le scope de \var1 dans term
(define scan
  (lambda (term var1 var2)
    (let ((forme '()))
      (set! forme (form-term term))
      (cond
   ((eq? forme 'application) (or (scan (car term) var1 var2) (scan (cadr term) var1 var2)))
   ((eq? forme 'abstraction) (if (eq? var1 (cadr term)) (element? var2 (caddr term)) (scan (caddr term) var1 var2)))
   (else '())
    ))))

; un remplaceur de symboles (inadequats) etant donne, SUBST-VALIDE
;substitue aux occurences de VAR le terme NEW, pourvu que les variables libres
;de celui-ci n'aient pas d'occurence liee dans TERM (cas de capture de variable)
;dans ce cas, les variables liantes sont renommees (nom generique: v1, v2,...)
;a l'aide de la substitution brutale
;et ensuite, la substitution normale est effectuee
(define subst-valide
  (lambda (new var term remplaceur)
    (let ((ambigus '()))
      (set! ambigus (set-intersection (baounde-variabeulz term) (fri-variabeulz new '())))
      (let looping ((new-term term))
   (let loop ((gus ambigus))
     (if (null? gus) '()
       (if (pair? gus) (begin (loop (car gus)) (loop (cdr gus)))
         (if (scan term gus var) (set! new-term (substitut-brut (remplaceur) gus new-term))))))
   (substitut new var new-term)))))

(define normale?
  (lambda (term)
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) #t)
   ((eq? forme 'application)
     (if (eq? 'abstraction (form-term (car term))) '()
       (and (normale? (car term)) (normale? (cadr term)))))
   ((eq? forme 'abstraction) (normale? (caddr term)))
      ))))

; une etape de reduction en ordre normal
(define reduc-nor
  (lambda (term remplaceur)
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) term)
   ((eq? forme 'application) (if (normale? (car term))
                (if (eq? 'abstraction (form-term (car term)))
                  (subst-valide (cadr term) (cadar term) (caddar term) remplaceur)
                  (list (car term) (reduc-nor (cadr term) remplaceur)))
                (list (reduc-nor (car term) remplaceur) (cadr term))))
   ((eq? forme 'abstraction) (list '\ (cadr term) (reduc-nor (caddr term) remplaceur)))))))


(define reduc-app
  (lambda (term remplaceur)
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) term)
   ((eq? forme 'application) (if (normale? (cadr term))
                (if (eq? 'abstraction (form-term (car term)))
                  (subst-valide (cadr term) (cadar term) (caddar term) remplaceur)
                  (list (reduc-app (car term) remplaceur) (cadr term)))
                (list (car term) (reduc-app (cadr term) remplaceur) )))
   ((eq? forme 'abstraction) (list '\ (cadr term) (reduc-app (caddr term) remplaceur)))))))

;rend le sup(i/ Vi element de T)
(define inspect
  (lambda (term)
    (let ((forme (form-term term)))
      (cond
      ((eq? forme 'variable)
      (if
        (and (eq? (string-ref (symbol->string term) 0) #\v)
          (string=? (string-trim (string-tail (symbol->string term) 1) char-set:numeric) (string-tail (symbol->string term) 1))
          (not (string-null? (string-tail (symbol->string term) 1))))
        (string->number (string-tail (symbol->string term) 1))
        0))

   ((eq? forme 'application) (max (inspect (car term)) (inspect (cadr term))))
   ((eq? forme 'abstraction) (max (inspect (cadr term)) (inspect (caddr term))))))))


; remplace les occurences libres de noms dans TERM par leur signification dans DICO
;DICO doit etre une liste de CONS (( . ) ( . )...)
;remarque importante: les \-termes de DICO n'ont jamais de v1, v2,...(variables reservees) LIBRES
;donc les substitutions de ces termes n'entrainent pas de capture de variable, pour ces variables
;du moins.
(define remplace
  (lambda (term dico)
    (define look-for-term
      (lambda (term)
         (let loop ((fact dico))
           (if (not (null? fact))
           (if (eq? (caar fact) term) (cdar fact) (loop (cdr fact))) term ))))
     (define remplaceur (new-symbol-var
       (if (null? (fri-variabeulz term '())) 0
         (apply max (map inspect (map look-for-term (set->pretty-set (fri-variabeulz term '()))))))))
     (let loop ((result term) (fact (set->pretty-set (fri-variabeulz term '()))))
       (if (null? fact) result
          (if (eq? (car fact) (look-for-term (car fact)))
            (loop result (cdr fact))
            (loop (subst-valide (look-for-term (car fact)) (car fact) result remplaceur) (cdr fact)))))))

;accomplit N etapes de reduction en ordre normal
(define beta
  (lambda (term n remplaceur)
    (if (normale? term)
      (begin
      (write-string "forme normale atteinte; etapes residuelles:  ")
      (write n)
      (newline)
      term)
      (if (= n 0) (begin
        (write-string "toujours pas de forme normale...")
        (newline)
        term)
   (beta (reduc-nor term remplaceur) (- n 1) remplaceur)))))

; replace les occurences d'entiers dans un terme
;par des occurences de SYMBOLE du meme nom
(define no-int-term
  (lambda (term)
    (let ((forme (form-term term)))
      (cond
   ((eq? forme 'variable) (if (number? term) (string->symbol (number->string term)) term))
   ((eq? forme 'application) (list (no-int-term (car term)) (no-int-term (cadr term))))
   ((eq? forme 'abstraction) (list '\ (no-int-term (cadr term)) (no-int-term (caddr term))))
   ))))

(define display-help
  (lambda ()
       (newline)
       (write-string " >exp TERM :             introduit le terme TERM")
       (newline)
       (write-string " >def T TERM :           definit sous le nom T le terme TERM")
       (newline)
       (write-string " >redn TERM :            une etape de reduction en ordre normal")
       (newline)
       (write-string " >reda TERM :            une etape de reduction en ordre applicatif")
       (newline)
       (write-string " >nf N TERM :            N etapes de reduction en ordre normal")
       (newline)
       (write-string " >normale TERM :         indique si TERM est sous forme normale")
       (newline)
       (write-string " >alpha TERM1 TERM2 :    indique si deux termes sont alpha-equivalents")
       (newline)
       (write-string " >sub VAR TERM1 TERM2:   substitue a VAR le terme TERM1 dans TERM2")
       (newline)
       (write-string " >list :                 liste des definitions")
       (newline)
       (write-string " >quit :                 fin du lambda-interprete, sans sauvegarde des resultats")
       (newline)
       (write-string "ATTENTION: * pas de difference entre majuscules et minuscules")
       (newline)
       (write-string "           * les noms de variable de la forme v1, v2... sont reserves au systeme")
       (newline)
       (write-string "SYNTAXE des TERMES du LAMBDA-INTERPRETE:")
       (newline)
       (write-string "  -variable (VAR) :    x")
       (newline)
       (write-string "  -application :       (TERM1 TERM2)")
       (newline)
       (write-string "  -abstraction :       (\\ VAR TERM)")
       (newline)
       (write-string "Les trois combinateurs classiques I,K et S sont inclus au")
       (newline)
       (write-string "   depart sous les noms respectifs ic, kc et sc")
       (newline)
#|
       (write-string "pour plus d'informations appeler le (16.1)43.87.75.76")
       (newline)
|#
  ))

(define search
  (lambda (term dico)
    (let loop ((fact dico))
      (if (not (null? fact))
      (if (eq? (caar fact) term) (cdar fact) (loop (cdr fact))) term))))

(define display-dico
  (lambda (dico)
    (let loop ((fact dico))
      (if (not (null? fact))
   (begin
   (write (caar fact))
   (write-string " = ")
   (write (cdar fact))
   (newline)
   (loop (cdr fact)))))))

(define combinateurs
  (list (cons 'ic '(\ x x)) (cons 'kc '(\ x (\ y x))) (cons 'sc '(\ x (\ y (\ z ((x z) (y z))))))))

(define go
  (lambda ()
    (begin
    (ge user-initial-environment)
    (sf "lambda")
    (load "lambda"))))

(define display-title
  (lambda ()
    (begin
    (newline)
    (write-string "   \\ ")
    (newline)
    (write-string "    \\ ")
    (newline)
    (write-string "    /\\  - INTERPRETE")
    (newline)
    (write-string "   /  \\ ")
    (newline))))

(define lamb
 (lambda ()
  (begin
  (display-title)
  (let loop ((defs combinateurs) (numero 1))
    (newline)
    (display '>)
    (let lecture ((entree (read-string char-set:not-graphic))
         (term1 '()) (term2 '()) (result '()))
      (read-char)
      (if (null? (string-find-next-char-in-set entree char-set:whitespace))
        ; contient un seul symbole
        (cond
          ((string=? entree "quit")
            (set! dictionnaire defs)
            'bye)
          ((string=? entree "help")
            (display-help)
            (loop defs numero))
          ((string=? entree "list")
            (display-dico defs)
            (loop defs numero))
          (else
            (begin
              (newline)
              (write-string "je ne comprends pas cette requete (tapez help pour info)")
              (loop defs numero))))
        ; chaine multi-symbole
        (begin (let ((commande '()))
          (set! commande (string-head entree (string-find-next-char-in-set entree char-set:whitespace)))
          (cond
            ((string=? commande "normale")
                (if (string-null? (string-trim (string-tail entree 7)))
                  (begin
               (write-string "syntaxe: alpha TERM ")
               (loop defs numero))
                (begin
                  (set! term1 (with-input-from-string  (string-trim (string-tail entree 7)) read))
                  (if (not (ok-term? term1))
               (begin
                 (write-string "terme invalide (cf. syntaxe avec HELP)")
               (loop defs numero))
                  (if (normale? (remplace (no-int-term term1) defs))
               (begin
                 (write-string "true")
                 (loop defs numero))
               (begin
                 (write-string "false")
                 (loop defs numero)))))))
            ((string=? commande "reda")
                (if (string-null? (string-trim (string-tail entree 4)))
                  (begin
               (write-string "syntaxe: reda TERM ")
               (loop defs numero))
                  (begin
               (set! term1 (with-input-from-string (string-trim (string-tail entree 4)) read))
               (if (not (ok-term? term1))
                 (begin
                   (write-string "terme invalide (cf. syntaxe avec HELP)")
                   (loop defs numero))
                 (begin (let ((remp '()))
                   (set! term1 (no-int-term (with-input-from-string  (string-trim (string-tail entree 4)) read)))
                   (set! term1 (remplace term1 defs))
                   (set! remp (new-symbol-var (inspect term1)))
                   (set! result (reduc-app term1 remp))
                   (write numero)
                   (write-string " = ")
                   (display result)
                   (loop (append (list (cons (string->symbol (number->string numero)) result)) defs) (+ numero 1))))))))
            ((string=? commande "redn")
                (if (string-null? (string-trim (string-tail entree 4)))
                  (begin
               (write-string "syntaxe: redn TERM ")
               (loop defs numero))
                  (begin
               (set! term1 (with-input-from-string (string-trim (string-tail entree 4)) read))
               (if (not (ok-term? term1))
                 (begin
                   (write-string "terme invalide (cf. syntaxe avec HELP)")
                   (loop defs numero))
                 (begin (let ((remp '()))
                   (set! term1 (no-int-term (with-input-from-string  (string-trim (string-tail entree 4)) read)))
                   (set! term1 (remplace term1 defs))
                   (set! remp (new-symbol-var (inspect term1)))
                   (set! result (reduc-nor term1 remp))
                   (write numero)
                   (write-string " = ")
                   (display result)
                   (loop (append (list (cons (string->symbol (number->string numero)) result)) defs) (+ numero 1))))))))
            ((string=? commande "nf")
                (if (string-null? (string-trim (string-tail entree 2)))
                  (begin
                     (write-string "syntaxe: nf N TERM ")
                     (loop defs numero))
                  (begin (let ((pop '()))
                     (set! pop (string->input-port (string-trim (string-tail entree 2))))
                     (set! term1 (with-input-from-port pop read))
                     (set! term2 (with-input-from-port pop read))
                     (if (not (ok-term? term2))
                       (begin
                         (write-string "terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero))
                       (begin (let ((remp '()))
                         (set! term2 (no-int-term term2))
                         (set! term2 (remplace term2 defs))
                         (set! remp (new-symbol-var (inspect term2)))
                         (set! result (beta term2 term1 remp))
                         (write numero)
                         (write-string " = ")
                         (display result)
                         (loop (append (list (cons (string->symbol (number->string numero)) result)) defs) (+ numero 1)))))))))
            ((string=? commande "alpha")
                (if (string-null? (string-trim (string-tail entree 5)))
                  (begin
                     (write-string "syntaxe: alpha TERM1 TERM2 ")
                     (loop defs numero))
                  (begin (let ((pop '()))
                     (set! pop (string->input-port (string-trim (string-tail entree 5))))
                     (set! term1 (with-input-from-port pop read))
                     (set! term2 (with-input-from-port pop read))
                     (cond
                     ((not (ok-term? term1))
                       (begin
                         (write-string "1er terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     ((not (ok-term? term2))
                       (begin
                         (write-string "2eme terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     (else
                       (begin
                         (set! term1 (no-int-term term1))
                         (set! term1 (remplace term1 defs))
                         (set! term2 (no-int-term term2))
                         (set! term2 (remplace term2 defs))
                         (if (alpha-eq? term1 term2 '())
                           (begin
                              (write-string "true")
                              (loop defs numero))
                           (begin
                              (write-string "false")
                              (loop defs numero))))))))))
            ((string=? commande "def")
                (if (string-null? (string-trim (string-tail entree 3)))
                  (begin
                     (write-string "syntaxe: def VAR TERM2 ")
                     (loop defs numero))
                  (begin (let ((pop '()))
                     (set! pop (string->input-port (string-trim (string-tail entree 3))))
                     (set! term1 (with-input-from-port pop read))
                     (set! term2 (with-input-from-port pop read))
                     (cond
                     ((not (symbol? term1))
                       (begin
                         (write-string "1ere variable invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     ((not (eq? term1 (search term1 defs)))
                       (begin
                         (write-string "nom deja utilise. operation impossible")
                         (loop defs numero)))
                     ((not (ok-term? term2))
                       (begin
                         (write-string "2eme terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     (else
                       (begin
                         (set! term2 (no-int-term term2))
                         (set! term2 (remplace term2 defs))
                         (write term1)
                         (write-string " = ")
                         (write term2)
                         (loop (append (list (cons term1 term2)) defs) numero))))))))
            ((string=? commande "exp")
                (if (string-null? (string-trim (string-tail entree 3)))
                  (begin
                     (write-string "syntaxe: exp TERM ")
                     (loop defs numero))
                  (begin (let ((pop '()))
                     (set! pop (string->input-port (string-trim (string-tail entree 3))))
                     (set! term2 (with-input-from-port pop read))
                     (cond
                       ((not (ok-term? term2))
                         (begin
                           (write-string "terme invalide (cf. syntaxe avec HELP)")
                           (loop defs numero)))
                       (else
                         (begin
                           (set! term2 (no-int-term term2))
                           (set! term2 (remplace term2 defs))
                           (write numero)
                           (write-string " = ")
                           (write term2)
                           (loop (append (list (cons (string->symbol (number->string numero)) term2)) defs) (+ numero 1)))))))))
            ((string=? commande "sub")
                (if (string-null? (string-trim (string-tail entree 3)))
                  (begin
                     (write-string "syntaxe: sub VAR TERM1 TERM2 ")
                     (loop defs numero))
                  (begin (let ((pop '()) (var '()))
                     (set! pop (string->input-port (string-trim (string-tail entree 3))))
                     (set! var (with-input-from-port pop read))
                     (set! term1 (with-input-from-port pop read))
                     (set! term2 (with-input-from-port pop read))
                     (cond
                     ((not (symbol? var))
                       (begin
                         (write-string "1ere variable invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     ((not (ok-term? term1))
                       (begin
                         (write-string "1er terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     ((not (ok-term? term2))
                       (begin
                         (write-string "2eme terme invalide (cf. syntaxe avec HELP)")
                         (loop defs numero)))
                     (else
                       (begin (let ((indice '()) (remp '()))
                         (set! term1 (no-int-term term1))
                         (set! term1 (remplace term1 defs))
                         (set! term2 (no-int-term term2))
                         (set! term2 (remplace term2 defs))
                         (set! indice (max (inspect term1) (inspect term2)))
                         (set! remp (new-symbol-var indice))
                         (set! result (subst-valide term1 var term2 remp))
                         (write numero)
                         (write-string " = ")
                         (display result)
                         (loop (append (list (cons (string->symbol (number->string numero)) result)) defs) (+ numero 1))))))))))
            (else
              (begin
                (newline)
                (write-string "je ne comprends pas cette requete (tapez help pour info)")
                (loop defs numero))))))))))))

