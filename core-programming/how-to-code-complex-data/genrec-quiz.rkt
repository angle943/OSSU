(require 2htdp/image)

;  PROBLEM 1:
;
;  In the lecture videos we designed a function to make a Sierpinski triangle fractal.
;
;  Here is another geometric fractal that is made of circles rather than triangles:
;
;  .
;
;  Design a function to create this circle fractal of size n and colour c.
;


(define CUT-OFF 5)

;; Natural String -> Image
;; produce a circle fractal of size n and colour c
(define (circle-fractal n c)
  (if (<= n CUT-OFF)
      (circle n "outline" c)
      (local [(define sub (circle-fractal (/ n 2) c))]
        (overlay (beside sub sub)
                 (circle n "outline" c)))))





;  PROBLEM 2:
;
;  Below you will find some data definitions for a tic-tac-toe solver.
;
;  In this problem we want you to design a function that produces all
;  possible filled boards that are reachable from the current board.
;
;  In actual tic-tac-toe, O and X alternate playing. For this problem
;  you can disregard that. You can also assume that the players keep
;  placing Xs and Os after someone has won. This means that boards that
;  are completely filled with X, for example, are valid.
;
;  Note: As we are looking for all possible boards, rather than a winning
;  board, your function will look slightly different than the solve function
;  you saw for Sudoku in the videos, or the one for tic-tac-toe in the
;  lecture questions.
;


;; Value is one of:
;; - false
;; - "X"
;; - "O"
;; interp. a square is either empty (represented by false) or has and "X" or an "O"

#;
(define (fn-for-value v)
  (cond [(false? v) (...)]
        [(string=? v "X") (...)]
        [(string=? v "O") (...)]))

;; Board is (listof Value)
;; a board is a list of 9 Values
(define B0 (list false false false
                 false false false
                 false false false))

(define B1 (list false "X"   "O"   ; a partly finished board
                 "O"   "X"   "O"
                 false false "X"))

(define B2 (list "X"  "X"  "O"     ; a board where X will win
                 "O"  "X"  "O"
                 "X" false "X"))

(define B3 (list "X" "O" "X"       ; a board where Y will win
                 "O" "O" false
                 "X" "X" false))

#;
(define (fn-for-board b)
  (cond [(empty? b) (...)]
        [else
         (... (fn-for-value (first b))
              (fn-for-board (rest b)))]))

(check-expect (find-empty-idx B0) 0)
(check-expect (find-empty-idx B2) 7)

(define (find-empty-idx bd)
  (cond [(empty? bd) (error "this board is complete")]
        [(false? (first bd)) 0]
        [else (+ 1 (find-empty-idx (rest bd)))]))


(check-expect (complete? (list B0)) false)
(check-expect (complete? (list B2)) false)
(check-expect (complete? (list (list "X" "X" "X"
                                     "O" "O" "O"
                                     "X" "O" "X"))) true)

(define (complete? lobd)
  (andmap string? (first lobd)))


(check-expect (get-next-boards (list B0)) ( list (list "X" false false
                                                       false false false
                                                       false false false)
                                                 (list "O" false false
                                                       false false false
                                                       false false false)))

(check-expect (get-next-boards (list (list "X" false false
                                           false false false
                                           false false false)
                                     (list "O" false false
                                           false false false
                                           false false false)))
              ( list (list "X" "X" false
                           false false false
                           false false false)
                     (list "X" "O" false
                           false false false
                           false false false)
                     (list "O" "X" false
                           false false false
                           false false false)
                     (list "O" "O" false
                           false false false
                           false false false)))

(define (get-next-boards lobd)
  (cond [(empty? lobd) empty]
        [else (local [(define i (find-empty-idx (first lobd)))]
                (cons (fill-square (first lobd) "X" i)
                      (cons (fill-square (first lobd) "O" i)
                            (get-next-boards (rest lobd)))))]))



(check-expect (fill-square B1 "X" 0) (list "X" "X"   "O"
                                           "O"   "X"   "O"
                                           false false "X"))

(check-expect (fill-square B1 "O" 6) (list false "X"   "O"
                                           "O"   "X"   "O"
                                           "O" false "X"))

(define (fill-square bd piece i)
  (cond [(zero? i) (cons piece (rest bd))]
        [else (cons (first bd) (fill-square (rest bd) piece (sub1 i)))]))

(define (get-all-boards bd)
  (local [(define (get-all-boards--lobd lobd)
            (if (complete? lobd)
                lobd
                (get-all-boards--lobd (get-next-boards lobd))))]
    (get-all-boards--lobd (list bd))))



;  PROBLEM 3:
;
;  Now adapt your solution to filter out the boards that are impossible if
;  X and O are alternating turns. You can continue to assume that they keep
;  filling the board after someone has won though.
;
;  You can assume X plays first, so all valid boards will have 5 Xs and 4 Os.
;
;  NOTE: make sure you keep a copy of your solution from problem 2 to answer
;  the questions on edX.
;

(define (count-x bd)
  (cond [(empty? bd) 0]
        [(string=? (first bd) "X") (+ 1 (count-x (rest bd)))]
        [else (count-x (rest bd))]))

(define (is-proper? bd)
  (= (count-x bd) 5))

(define (get-all-proper-boards bd)
  (filter is-proper? (get-all-boards bd)))

(get-all-proper-boards B0)
