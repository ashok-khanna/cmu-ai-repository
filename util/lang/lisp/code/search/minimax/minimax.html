;;; -*- Mode: LISP; Syntax: Common-lisp -*-
;;; Sun Nov 18 13:36:11 1990 by Mark Kantrowitz <mkant@GLINDA.OZ.CS.CMU.EDU>
;;; alpha-beta.lisp

;;; ****************************************************************
;;; Alpha Beta MiniMax Search **************************************
;;; ****************************************************************

;;; We give implementations of alpha-beta minimax and negmax game tree search.
;;; 
;;; Written by Mark Kantrowitz, November 18, 1990.


;;; ********************************
;;; Alpha-Beta MiniMax Search ******
;;; ********************************

(defvar *infinity* 1000000)
(defvar *report-cutoffs* t)

;;; Trees are list structures; the children are the elements of the list,
;;; terminal elements are numbers. 

;;; Test Tree
(defvar tree-1
  '(((4 1 9)
     (3 5 -2)
     (-5 3 4))
    ((2 6 1)
     (3 7 1)
     (8 4 2))
    ((-3 4 5)
     (4 1 8)
     (9 1 8))))

(defun alpha-beta-max-search (tree &optional (alpha (- *infinity*)) (beta *infinity*))
  (if (numberp tree)
    tree
    (do* ((branches tree (cdr branches))
          (branch (car branches) (car branches)))
         ((or (null branches)  ; no more branches
              (>= alpha beta)) ; cutoff
          (cond (branches
                 (when *report-cutoffs*
                   (format t "~&Cutting off branches ~{~&  ~A~}"
                         branches))
                 beta)  ; if a >= b, return beta
                (t alpha))) ; if last node, return max of the nodes
      (setq alpha
            (max alpha
                 (alpha-beta-min-search branch alpha beta))))))

(defun alpha-beta-min-search (tree &optional (alpha (- *infinity*)) (beta *infinity*))
  (if (numberp tree)
    tree
    (do* ((branches tree (cdr branches))
          (branch (car branches) (car branches)))
         ((or (null branches)  ; no more branches
              (>= alpha beta)) ; cutoff
          (cond (branches
                 (when *report-cutoffs*
                   (format t "~&Cutting off branches ~{~&  ~A~}"
                         branches))
                 alpha)  ; if a >= b, return alpha
                (t beta))) ; if last node, return min of the nodes.
      (setq beta
            (min beta
                 (alpha-beta-max-search branch alpha beta))))))


;;; ********************************
;;; Neg-Max version ****************
;;; ********************************

;;; Neg-Max is like alpha-beta MiniMax, except it notes that the max of
;;; negative numbers is the same as the min of positive numbers.

(defun alpha-beta-search (tree &optional (alpha (- *infinity*))
                               (beta *infinity*)(mult 1))
  (if (numberp tree)
    (* mult tree)
    (do* ((branches tree (cdr branches))
          (branch (car branches) (car branches)))
         ((or (null branches)  ; no more branches
              (>= alpha beta)) ; cutoff
          (cond (branches
                 (when *report-cutoffs*
                   (format t "~&Cutting off branches ~{~&  ~A~}"
                         branches))
                  beta)  ; if a >= b, return beta
                (t alpha))) ; if last node, return max of the nodes
      (setq alpha
            (max alpha
                 (- (alpha-beta-search branch (- beta) (- alpha) (- mult)))
                 )))))


;;; *EOF*
