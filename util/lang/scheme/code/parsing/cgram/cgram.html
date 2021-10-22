; Author: Mohd Hanafiah Abdullah (napi@cs.indiana.edu or napi@ms.mimos.my)
; Please report any bugs that you find.  Thanks.
;
; ANSI C LL(k) GRAMMAR (1 <= k <= 2)
;
; THE TERMINALS
;
; "identifier" "octal_constant" "hex_constant" "decimal_constant"
; "float_constant" "char_constant" "string_literal" "sizeof"
; "->" "++" "--" "<<" ">>" "<=" ">=" "==" "!="
; "&&" "||" "*=" "/=" "%=" "+="
; "-=" "<<=" ">>=" "&="
; "^=" "|="

; "typedef" "extern" "static" "auto" "register"
; "char" "short" "int" "long" "signed" "unsigned" "float" "double"
; "const" "volatile" "void"
; "struct" "union" "enum" "..."

; "case" "default" "if" "else" "switch" "while" "do" "for" "goto"
; "continue" "break" "return"
;---------------------------------------------------------------------------

(define g
	'((primary_expr
		("identifier")
		("octal_constant")
		("hex_constant")
		("decimal_constant")
		("float_constant")
		("char_constant")
		("string_literal")
		("(" expr ")"))

	(postfix_expr
		(primary_expr postfix_exprP))

	(postfix_exprP
		("[" expr "]" postfix_exprP)
		("(" fact_postfix_exprP)
		("." "identifier" postfix_exprP)
		("->" "identifier" postfix_exprP)
		("++" postfix_exprP)
		("--" postfix_exprP)
		())

	(fact_postfix_exprP
		(argument_expr_list ")" postfix_exprP)
		(")" postfix_exprP))

	(argument_expr_list
		(assignment_expr argument_expr_listP))

	(argument_expr_listP
		("," assignment_expr argument_expr_listP)
		())

	(unary_expr
		(postfix_expr)
		("++" unary_expr)
		("--" unary_expr)
		(unary_operator cast_expr)
		("sizeof" fact_unary_expr))

	(fact_unary_expr
		("identifier" postfix_exprP)
		("octal_constant" postfix_exprP)
		("hex_constant" postfix_exprP)
		("decimal_constant" postfix_exprP)
		("float_constant" postfix_exprP)
		("char_constant" postfix_exprP)
		("string_literal" postfix_exprP)
		("++" unary_expr)
		("--" unary_expr)
		(unary_operator cast_expr)
		("sizeof" fact_unary_expr)
		("(" fact_fact_unary_expr))

	(fact_fact_unary_expr
		(expr ")" postfix_exprP)
		(type_name ")"))

	(unary_operator
		("&")
		("*")
		("+")
		("-")
		("~")
		("!"))

	(cast_expr
		("identifier" postfix_exprP)
		("octal_constant" postfix_exprP)
		("hex_constant" postfix_exprP)
		("decimal_constant" postfix_exprP)
		("float_constant" postfix_exprP)
		("char_constant" postfix_exprP)
		("string_literal" postfix_exprP)
		("++" unary_expr)
		("--" unary_expr)
		(unary_operator cast_expr)
		("sizeof" fact_unary_expr)
		("(" fact_cast_expr))

	(fact_cast_expr
		(expr ")" postfix_exprP)
		(type_name ")" cast_expr))

	(multiplicative_expr
		(cast_expr multiplicative_exprP))

	(multiplicative_exprP
		("*" cast_expr multiplicative_exprP)
		("/" cast_expr multiplicative_exprP)
		("%" cast_expr multiplicative_exprP)
		())

	(additive_expr
		(multiplicative_expr additive_exprP))

	(additive_exprP
		("+" multiplicative_expr additive_exprP)
		("-" multiplicative_expr additive_exprP)
		())

	(shift_expr
		(additive_expr shift_exprP))

	(shift_exprP
		("<<" additive_expr shift_exprP)
		(">>" additive_expr shift_exprP)
		())

	(relational_expr
		(shift_expr relational_exprP))

	(relational_exprP
		("<" shift_expr relational_exprP)
		(">" shift_expr relational_exprP)
		("<=" shift_expr relational_exprP)
		(">=" shift_expr relational_exprP)
		())

	(equality_expr
		(relational_expr equality_exprP))

	(equality_exprP
		("==" relational_expr equality_exprP)
		("!=" relational_expr equality_exprP)
		())

	(and_expr
		(equality_expr and_exprP))

	(and_exprP
		("&" equality_expr and_exprP)
		())

	(exclusive_or_expr
		(and_expr exclusive_or_exprP))

	(exclusive_or_exprP
		("^" and_expr exclusive_or_exprP)
		())

	(inclusive_or_expr
		(exclusive_or_expr inclusive_or_exprP))

	(inclusive_or_exprP
		("|" exclusive_or_expr inclusive_or_exprP)
		())

	(logical_and_expr
		(inclusive_or_expr logical_and_exprP))

	(logical_and_exprP
		("&&" inclusive_or_expr logical_and_exprP)
		())

	(logical_or_expr
		(logical_and_expr logical_or_exprP))

	(logical_or_exprP
		("||" logical_and_expr logical_or_exprP)
		())

	(conditional_expr
		(logical_or_expr fact_conditional_expr))

	(fact_conditional_expr
		("?" expr ":" conditional_expr)
		())

	(assignment_expr
		(conditional_expr fact_assignment_expr))

	(fact_assignment_expr
		(assignment_operator assignment_expr)
		())

	(assignment_operator
		("=")
		("*=")
		("/=")
		("%=")
		("+=")
		("-=")
		("<<=")
		(">>=")
		("&=")
		("^=")
		("|="))

	(OPT_EXPR
		(expr)
		())

	(expr
		(assignment_expr exprP))

	(exprP
		("," assignment_expr exprP)
		())

	(constant_expr
		(conditional_expr))

	(declaration
		(declaration_specifiers fact_declaration))

	(fact_declaration
		(init_declarator_list ";")
		(";"))

	(declaration_specifiers
		(storage_class_specifier fact_declaration_specifiers1)
		(type_specifier fact_declaration_specifiers2)
		(type_qualifier fact_declaration_specifiers3))

	(fact_declaration_specifiers1
		(declaration_specifiers)
		())

	(fact_declaration_specifiers2
		(declaration_specifiers)
		())

	(fact_declaration_specifiers3
		(declaration_specifiers)
		())

	(init_declarator_list
		(init_declarator init_declarator_listP))

	(init_declarator_listP
		("," init_declarator init_declarator_listP)
		())

	(init_declarator
		(declarator fact_init_declarator))

	(fact_init_declarator
		("=" initializer)
		())

	(storage_class_specifier
		("typedef")
		("extern")
		("static")
		("auto")
		("register"))

	(type_specifier
		("void")
		("char")
		("short")
		("int")
		("long")
		("float")
		("double")
		("signed")
		("unsigned")
		(struct_or_union_specifier)
		(enum_specifier)
		(typedef_name))

	(struct_or_union_specifier
		(struct_or_union fact_struct_or_union_specifier))

	(fact_struct_or_union_specifier
		("{" struct_declaration_list "}")
		("identifier" fact_fact_struct_or_union_specifier))

	(fact_fact_struct_or_union_specifier
		("{" struct_declaration_list "}")
		())

	(struct_or_union
		("struct")
		("union"))

	(struct_declaration_list
		(struct_declaration struct_declaration_listP))

	(struct_declaration_listP
		(struct_declaration struct_declaration_listP)
		())

	(struct_declaration
		(specifier_qualifier_list struct_declarator_list ";"))

	(specifier_qualifier_list
		(type_specifier fact_specifier_qualifier_list1)
		(type_qualifier fact_specifier_qualifier_list2))

	(fact_specifier_qualifier_list1
		(specifier_qualifier_list)
		())

	(fact_specifier_qualifier_list2
		(specifier_qualifier_list)
		())

	(struct_declarator_list
		(struct_declarator struct_declarator_listP))

	(struct_declarator_listP
		("," struct_declarator struct_declarator_listP)
		())

	(struct_declarator
		(declarator fact_struct_declarator)
		(":" constant_expr))

	(fact_struct_declarator
		(":" constant_expr)
		())

	(enum_specifier
		("enum" fact_enum_specifier))

	(fact_enum_specifier
		("{" enumerator_list "}")
		("identifier" fact_fact_enum_specifier))

	(fact_fact_enum_specifier
		("{" enumerator_list "}")
		())

	(enumerator_list
		(enumerator enumerator_listP))

	(enumerator_listP
		("," enumerator enumerator_listP)
		())

	(enumerator
		("identifier" fact_enumerator))

	(fact_enumerator
		("=" constant_expr)
		())

	(type_qualifier
		("const")
		("volatile"))

	(declarator
		(pointer direct_declarator)
		(direct_declarator))

	(direct_declarator
		("identifier" direct_declaratorP)
		("(" declarator ")" direct_declaratorP))

	(direct_declaratorP
		("[" fact_direct_declaratorP1)
		("(" fact_direct_declaratorP2)
		())

	(fact_direct_declaratorP1
		(constant_expr "]" direct_declaratorP)
		("]" direct_declaratorP))

	(fact_direct_declaratorP2
		(parameter_type_list ")" direct_declaratorP)
		(identifier_list ")" direct_declaratorP)
		(")" direct_declaratorP))

	(pointer
		("*" fact_pointer))

	(fact_pointer
		(type_qualifier_list fact_fact_pointer)
		(pointer)
		())

	(fact_fact_pointer
		(pointer)
		())

	(type_qualifier_list
		(type_qualifier type_qualifier_listP))

	(type_qualifier_listP
		(type_qualifier type_qualifier_listP)
		())

	(identifier_list
		("identifier" identifier_listP))

	(identifier_listP
		("," "identifier" identifier_listP)
		())

	(parameter_type_list
		(parameter_list fact_parameter_type_list))

	(fact_parameter_type_list
		("," "...")
		())

	(parameter_list
		(parameter_declaration parameter_listP))

	(parameter_listP
		("," parameter_declaration parameter_listP)
		())

	(parameter_declaration
		(declaration_specifiers fact_parameter_declaration))

	(fact_parameter_declaration
		(modified_declarator)
		())

	(modified_declarator
		(pointer fact_modified_declarator)
		(direct_modified_declarator))

	(fact_modified_declarator
		(direct_modified_declarator)
		())

	(direct_modified_declarator
		("identifier" direct_modified_declaratorP)
		("[" fact_direct_modified_declarator1)
		("(" fact_direct_modified_declarator2))

	(fact_direct_modified_declarator1
		(constant_expr	"]" direct_modified_declaratorP)
		("]" direct_modified_declaratorP))

	(fact_direct_modified_declarator2
		(modified_declarator ")" direct_modified_declaratorP)
		(parameter_type_list ")" direct_modified_declaratorP)
		(")" direct_modified_declaratorP))

	(direct_modified_declaratorP
		("[" fact_direct_modified_declaratorP1)
		("(" fact_direct_modified_declaratorP2)
		())

	(fact_direct_modified_declaratorP1
		(constant_expr  "]" direct_modified_declaratorP)
		("]" direct_modified_declaratorP))

	(fact_direct_modified_declaratorP2
		(parameter_type_list ")" direct_modified_declaratorP)
		(")" direct_modified_declaratorP))

	(type_name
		(specifier_qualifier_list fact_type_name))

	(fact_type_name
		(abstract_declarator)
		())

	(abstract_declarator
		(pointer fact_abstract_declarator)
		(direct_abstract_declarator))

	(fact_abstract_declarator
		(direct_abstract_declarator)
		())

	(direct_abstract_declarator
		("[" fact_direct_abstract_declarator1)
		("(" fact_direct_abstract_declarator2))

	(fact_direct_abstract_declarator1
		(constant_expr "]" direct_abstract_declaratorP)
		("]" direct_abstract_declaratorP))

	(fact_direct_abstract_declarator2
		(abstract_declarator ")" direct_abstract_declaratorP)
		(parameter_type_list ")" direct_abstract_declaratorP)
		(")" direct_abstract_declaratorP))

	(direct_abstract_declaratorP
		("[" fact_direct_abstract_declaratorP1)
		("(" fact_direct_abstract_declaratorP2)
		())

	(fact_direct_abstract_declaratorP1
		(constant_expr "]" direct_abstract_declaratorP)
		("]" direct_abstract_declaratorP))

	(fact_direct_abstract_declaratorP2
		(parameter_type_list ")" direct_abstract_declaratorP)
		(")" direct_abstract_declaratorP))

	(typedef_name
		("identifier"))

	(initializer
		(assignment_expr)
		("{" initializer_list fact_initializer))

	(fact_initializer
		("}")
		("," "}"))

	(initializer_list
		(initializer initializer_listP))

	(initializer_listP
		("," initializer initializer_listP)
		())

	(statement
		(labeled_statement)
		(compound_statement)
		(expression_statement)
		(selection_statement)
		(iteration_statement)
		(jump_statement))

	(labeled_statement
		("identifier" ":" statement)
		("case" constant_expr ":" statement)
		("default" ":" statement))

	(compound_statement
		("{" fact_compound_statement))

	(fact_compound_statement
		(declaration_list fact_fact_compound_statement)
		(statement_list "}")
		("}"))

	(fact_fact_compound_statement
		(statement_list "}")
		("}"))

	(declaration_list
		(declaration declaration_listP))

	(declaration_listP
		(declaration declaration_listP)
		())

	(statement_list
		(statement statement_listP))

	(statement_listP
		(statement statement_listP)
		())

	(expression_statement
		(expr ";")
		(";"))

	(selection_statement
		("if" "(" expr ")" statement fact_selection_statement)
		("switch" "(" expr ")" statement))

	(fact_selection_statement
		("else" statement)
		())

	(iteration_statement
		("while" "(" expr ")" statement)
		("do" statement "while" "(" expr ")" ";")
		("for" "(" OPT_EXPR ";" OPT_EXPR ";" OPT_EXPR ")" statement))

	(jump_statement
		("goto" "identifier" ";")
		("continue" ";")
		("break" ";")
		("return" fact_jump_statement))

	(fact_jump_statement
		(";")
		(expr ";"))

	(translation_unit
		(external_declaration translation_unitP))

	(translation_unitP
		(external_declaration translation_unitP)
		())

	(external_declaration
		(arbitrary_declaration))

	(OPT_DECLARATION_LIST
		(declaration_list)
		())

	(arbitrary_declaration
		(declaration_specifiers fact_arbitrary_declaration)
		(declarator OPT_DECLARATION_LIST compound_statement))

	(fact_arbitrary_declaration
		(choice1)
		(";"))

	(choice1
		(init_declarator fact_choice1))

	(fact_choice1
		("," choice1)
		(";")
		(OPT_DECLARATION_LIST compound_statement))
))

------------------------------Cut Here---------------------------------------
; f-f-d.s
;
; Computation of the LL(1) condition, LL(1) director sets,
; and FIRST and FOLLOW sets.
;
; Grammars are represented as a list of entries, where each
; entry is a list giving the productions for a nonterminal.
; The first entry in the grammar must be for the start symbol.
; The car of an entry is the nonterminal; the cdr is a list
; of productions.  Each production is a list of grammar symbols
; giving the right hand side for the production; the empty string
; is represented by the empty list.
; A nonterminal is represented as a Scheme symbol.
; A terminal is represented as a Scheme string.
;
; Example:
;
;  (define g
;    '((S ("id" ":=" E "\;")
;         ("while" E S)
;         ("do" S A "od"))
;      (A ()
;         (S A))
;      (E (T E'))
;      (E' () ("+" T E') ("-" T E'))
;      (T (F T'))
;      (T' () ("*" F T') ("/" F T'))
;      (F ("id") ("(" E ")"))))

; Given a grammar, returns #t if it is LL(1), else returns #f.

(define (LL1? g)
  (define (loop dsets)
    (cond ((null? dsets) #t)
          ((disjoint? (cdr (car dsets))) (loop (cdr dsets)))
          (else (display "Failure of LL(1) condition ")
                (write (car dsets))
                (newline)
                (loop (cdr dsets)))))
  (define (disjoint? sets)
    (cond ((null? sets) #t)
          ((null? (car sets)) (disjoint? (cdr sets)))
          ((member-remaining-sets? (caar sets) (cdr sets))
           #f)
          (else (disjoint? (cons (cdr (car sets)) (cdr sets))))))
  (define (member-remaining-sets? x sets)
    (cond ((null? sets) #f)
          ((member x (car sets)) #t)
          (else (member-remaining-sets? x (cdr sets)))))
  (loop (director-sets g)))

; Given a grammar, returns the director sets for each production.
; In a director set, the end of file token is represented as the
; Scheme symbol $.

(define (director-sets g)
  (let ((follows (follow-sets g)))
    (map (lambda (p)
           (let ((lhs (car p))
                 (alternatives (cdr p)))
             (cons lhs
                   (map (lambda (rhs)
                          (let ((f (first rhs g '())))
                            (if (member "" f)
                                (union (lookup lhs follows)
                                       (remove "" f))
                                f)))
                        alternatives))))
         g)))

; Given a string of grammar symbols, a grammar, and a list of nonterminals
; that have appeared in the leftmost position during the recursive
; computation of FIRST(s), returns FIRST(s).
; In the output, the empty string is represented as the Scheme string "".
; Prints a warning message if left recursion is detected.

(define (first s g recursion)
  (cond ((null? s) '(""))
        ((memq (car s) recursion)
         (display "Left recursion for ")
         (write (car s))
         (newline)
         '())
        ((and (null? (cdr s)) (string? (car s))) s)
        ((and (null? (cdr s)) (symbol? (car s)))
         (let ((p (assoc (car s) g))
               (newrecursion (cons (car s) recursion)))
           (cond ((not p)
                  (error "No production for " (car s)))
                 (else (apply union
                              (map (lambda (s) (first s g newrecursion))
                                   (cdr p)))))))
        (else (let ((x (first (list (car s)) g recursion)))
                (if (member "" x)
                    (append (remove "" x)
                            (first (cdr s) g recursion))
                    x)))))

; Given a grammar g, returns FOLLOW(g).
; In the output, the end of file token is represented as the Scheme
; symbol $.
; Warning messages will be printed if left recursion is detected.

(define (follow-sets g)
  
  ; Uses a relaxation algorithm.
  
  (define (loop g table)
    (let* ((new (map (lambda (x) (cons x (fol x g table)))
                     (map car g)))
           (new (cons (cons (caar new) (union '($) (cdar new)))
                      (cdr new))))
      (if (equal-table? table new)
          table
          (loop g new))))
  
  ; Given a nonterminal, a grammar, and a table giving
  ; preliminary follow sets for all nonterminals, returns
  ; the next approximation to the follow set for the given
  ; nonterminal.
  
  (define (fol x g t)
    (define (fol-production p)
      (let ((lhs (car p))
            (alternatives (cdr p)))
        (do ((l alternatives (cdr l))
             (f '() (union (fol-alternative x (car l)) f)))
            ((null? l)
             (if (member "" f)
                 (union (lookup lhs t)
                        (remove "" f))
                 f)))))
    (define (fol-alternative x rhs)
      (cond ((null? rhs) '())
            ((eq? x (car rhs))
             (union (first (cdr rhs) g '())
                    (fol-alternative x (cdr rhs))))
            (else (fol-alternative x (cdr rhs)))))
    (apply union (map fol-production g)))
  
  (loop g
        (cons (list (caar g) '$)
              (map (lambda (p) (cons (car p) '()))
                   (cdr g)))))

; Tables represented as association lists using eq? for equality.

(define (lookup x t)
  (cdr (assq x t)))

(define (equal-table? x y)
  (cond ((and (null? x) (null? y)) #t)
        ((or (null? x) (null? y)) #f)
        (else (let ((entry (assoc (caar x) y)))
                (if entry
                    (and (equal-as-sets? (cdr (car x)) (cdr entry))
                         (equal-table? (cdr x) (remove entry y)))
                    #f)))))

; Sets represented as lists.

(define (equal-as-sets? x y)
  (and (every? (lambda (a) (member a y)) x)
       (every? (lambda (a) (member a x)) y)))

(define (union . args)
  (define (union2 x y)
    (cond ((null? x) y)
          ((member (car x) y)
           (union (cdr x) y))
          (else (cons (car x)
                      (union (cdr x) y)))))
  (cond ((null? args) '())
        ((null? (cdr args)) (car args))
        ((null? (cddr args)) (union2 (car args) (cadr args)))
        (else (union2 (union2 (car args) (cadr args))
                      (apply union (cddr args))))))

(define (every? p? l)
  (cond ((null? l) #t)
        ((p? (car l)) (every? p? (cdr l)))
        (else #f)))

 (define remove
   (lambda (item ls)
    (cond
       ((null? ls) '())
       ((equal? (car ls) item) (remove item (cdr ls)))
       (else (cons (car ls) (remove item (cdr ls)))))))
 
  (define pp-director-sets
    (lambda (g)
      (pp (director-sets g))))
    
  (define pp-follow-sets
    (lambda (g)
      (pp (follow-sets g))))
