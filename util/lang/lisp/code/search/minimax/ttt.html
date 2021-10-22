;;; ****************************************************************
;;; Tic-Tac-Toe (Alpha Beta Search) ********************************
;;; ****************************************************************
;;;
;;; Simple implementation of alpha-beta search for tic-tac-toe.  
;;;
;;; Written by Marco Zagha (marcoz@cs.cmu.edu) at Carnegie Mellon University
;;; for "AI: Representation and Problem Solving" (15-381), Spring 1990
;;; Minor changes by Sven Koenig (skoenig@cs.cmu.edu)
;;;           and by Alon Lavie  (alavie@cs.cmu.edu)
;;;
;;; To play tic-tac-toe, type (play)
;;;
;;; This file may be freely distributed.

(defvar *infinity* 99999) ; maximum value of a board
(defvar *nodes-generated*) ; number of nodes looked at by the game-tree search algorithm

;;; For simplicity, a board is simply a list of 9 elements, either 'X 'O or nil.
;;; (not the ideal data structure, but ok for now...)

;;; returns the initial tic-tac-toe board
(defun make-board ()
  '(nil nil nil nil nil nil nil nil nil))

;;; print a tic-tac-toe board
(defun print-board (board)
  (format t " ~%")
  (format t "    0|1|2~%")
  (format t " ~%")
  (format t "0   ~A|~A|~A~%" (token 0 board) (token 1 board) (token 2 board))
  (format t "    ------~%")
  (format t "1   ~A|~A|~A~%" (token 3 board) (token 4 board) (token 5 board))
  (format t "    ------~%")
  (format t "2   ~A|~A|~A~%" (token 6 board) (token 7 board) (token 8 board))
  (format t " ~%"))

;;; used by print-board
(defun token (index board)
  (let ((item (nth index board)))
    (if item item " "))) ; converts nils to blanks, but leaves 'Xs and 'Os alone

;;; checks whether the board represents a draw
(defun is-draw (board)    ; the game is a draw when the board is full
  (cond
    ((is-win board 'X) nil) ; unless it is a win for X
    ((is-win board 'O) nil) ; or it is a win for O
    (t (not (member nil board)))))

;;; checks whether the board represents a win for the given player
(defun is-win (board player)
  (let ((wins '((0 1 2) (3 4 5) (6 7 8) ; rows
                (0 3 6) (1 4 7) (2 5 8) ; columns
                (0 4 8) (2 4 6)))) ; diagonals
    (check-for-wins wins board player)))

;;; checks whether the boards represents a game that is finished
(defun game-over (board)
  (or (is-win board 'X) (is-win board 'O) (is-draw board)))

;;; used by is-win
(defun check-for-wins (wins board player)
  (cond
    ((null wins) nil) ; got to the end of list and there were no wins
    ((is-a-win board player (car wins)) t)
    (t (check-for-wins (cdr wins) board player))))

;;; used by check-for-wins
(defun is-a-win (board player positions)
  (and (equal (nth (nth 0 positions) board) player)
       (equal (nth (nth 1 positions) board) player)
       (equal (nth (nth 2 positions) board) player)))

;;; converts 'O to 'X and vice versa
(defun other-player (player)
  (case player
    (X 'O)
    (O 'X)))
 
;;; returns a list of next moves for a given board (or nil if there are none)
(defun next-moves (board player)
  (if (is-win board (other-player player))
      nil
      (next-moves-aux nil board player)))

;;; constructs a list where there is a board corresponding to each nil 
;;; slot in the original board.  
(defun next-moves-aux (slots-checked slots-to-check player)
  (cond ((null slots-to-check) nil)
	((null (car slots-to-check)) 
	     (cons (append slots-checked (list player) (cdr slots-to-check))
		   (next-moves-aux (append slots-checked '(()))
				   (cdr slots-to-check) 
				   player)))
        (t (next-moves-aux (append slots-checked (list (car slots-to-check)))
				   (cdr slots-to-check) 
				   player))))

;;; plays tic-tac-toe
(defun play ()
  (let ((board (make-board))
	(search-level nil)
	(human-first nil)
	(player nil))
    (format t "~%Maximum search level (1-9)? ")
    (setf search-level (read))
    (format t "~%X or O? ")
    (setf player (read))
    (format t "~%Would you like to go first? (t or nil) ")
    (setf human-first (read))
    (when human-first
	(print-board board)
	(setf board (get-human-move board player))
	(print-board board))
    (do ()   ; (no do variables)
        ((game-over board) ; until game over
         (cond ((is-draw board)	'draw)
	       ((is-win board player) 'human-wins)
	       (t 'machine-wins)))
        (setf board (get-machine-move board (other-player player) search-level))
	(print-board board)
	(when (not (game-over board))
	      (setf board (get-human-move board player))
	      (print-board board)))))

;;; asks for and executes the move of the human player
(defun get-human-move (board player)
  (let ((row nil)
        (column nil)
	(slot nil))
    (format t "~%Row: ")
    (setf row (read))
    (format t "~%Column: ")
    (setf column (read))
    (setf slot (+ (* 3 row) column))
    (cond ((or (< slot 0) (> slot 8)) (format t "Try again!~%") 
				      (get-human-move board player))
	   ((null (nth slot board)) (place-token board player slot))
	   (t (format t "No cheating!~%") (get-human-move board player)))))

;;; used by get-human-move
(defun place-token (board player index)
  (replace-nth 0 board index player))

;;; used by place-token to make a move on a board
(defun replace-nth (i l index item)
  (cond
    ((equal i index ) (cons item (cdr l)))
    (t (cons (car l) (replace-nth (1+ i) (cdr l) index item)))))

;;; the following function is not yet used
;;; you can use this function to order child nodes by
;;; supplying a list of pairs of boards and heuristic values, e.g
;;; (move-sort '((2 board1) (-1 board2) (0 board3))) => (board2 board3 board1);
;;; use the (reverse list) function on the result to sort in opposite order
(defun move-sort (items)
  (mapcar #'cadr ; extract boards from list of sorted pairs
    (sort items #'< :key #'car)))  ; sort by the key in car of pair

;;; invokes minimax-search with alpha-beta pruning
(defun get-machine-move (board player max-search)
  (setf *nodes-generated* 0)
  (let ((board (minimax-alpha-beta board 0 max-search player 
			   *infinity* (- *infinity*))))
  (format t "Number of nodes generated: ~S~%" *nodes-generated*)
  board))

;;; performs minimax-search with alpha-beta pruning (see pages 317-318 of
;;; Rich and Knight's textbook)
;;; This version differs slightly in that the return value is the value
;;; of the node only, except at the top level where it is the resulting board
;;; only. Rich and Knight return a value and a path.
(defun minimax-alpha-beta (board depth max-depth player use-thresh pass-thresh)
  (if (equal depth max-depth)
   ;; then
      (heuristic board player)
   ;; else
      (let ((successors (next-moves board player)))
	(setf *nodes-generated* (+ *nodes-generated* (length successors)))
	(if (null successors)
         ;; then
	    (heuristic board player)
	 ;; else
	    (do ((new-value nil)
		 (best-move (car successors)))
		;; when no more successors return pass-thresh or
		;; best-move if at top level
		((null successors) (if (= depth 0)
				       best-move
				       pass-thresh))
	       (setf new-value 
		 (- (minimax-alpha-beta 
			(car successors)
			(+ 1 depth) 
			max-depth 
		 	(other-player player)
			(- pass-thresh)
			(- use-thresh))))
		(when (> new-value pass-thresh) 
			      (setf pass-thresh new-value)
			      (setf best-move (car successors)))
		(if (>= pass-thresh use-thresh) 
                 ;; then
		    (setf successors nil)  ; terminate the loop
		 ;; else
		    (setf successors (cdr successors))))))))


;;; this function needs work
;;; determines the heuristic value of a given board for a given player
;;; (= evaluation function)
(defun heuristic (board player)
  (cond 
    ((is-win board player) *infinity*)
    ((is-win board (other-player player)) (- *infinity*))
    ((is-draw board) 0)
    (t (+ (* 10 (count-pairs board player))
	  (*  3 (count-corners board player))
	  (check-center board player)))
))


;;; counts the number of adjacent pairs player has on the board
(defun count-pairs (board player)
  (let ((pairs '((0 1) (1 2) (3 4) (4 5) (6 7) (7 8)  ; rows
		 (0 3) (3 6) (1 4) (4 7) (2 5) (5 8)  ; columns
		 (0 4) (4 8) (2 4) (4 6))))           ; diagonals
    (add-pairs pairs board player)))

;;; adds the number of pairs player has on the board
(defun add-pairs (pairs board player)
  (cond
   ((null pairs) 0)  ; end of pair list
   (t (+ (is-a-pair (car pairs) board player)
	 (add-pairs (cdr pairs) board player)))))

;;; checks if the pair is on the board
(defun is-a-pair (pair board player)
  (cond
   ((and (equal (nth (nth 0 pair) board) player)
	 (equal (nth (nth 1 pair) board) player)) 1)
   (t 0)))

;;; counts the number of corners player has on the board
(defun count-corners (board player)
  (let ((corners '(0 2 6 8)))
    (add-corners corners board player)))

;;; adds the number of corners
(defun add-corners (corners board player)
  (cond
   ((null corners) 0)
   (t (+ (is-a-corner (car corners) board player)
	 (add-corners (cdr corners) board player)))))

;;; checks if the corner position is on the board
(defun is-a-corner (corner board player)
  (cond
   ((equal (nth corner board) player) 1)
   (t 0)))

;;; checks if player has the board center
(defun check-center (board player)
  (cond
   ((equal (nth 4 board) player) 1)
   (t 0)))

;;; *EOF*
