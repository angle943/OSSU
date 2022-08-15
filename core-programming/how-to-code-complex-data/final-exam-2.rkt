;; ta-solver-starter.rkt



;  PROBLEM 1:
;
;  Consider a social network similar to Twitter called Chirper. Each user has a name, a note about
;  whether or not they are a verified user, and follows some number of people.
;
;  Design a data definition for Chirper, including a template that is tail recursive and avoids
;  cycles.
;
;  Then design a function called most-followers which determines which user in a Chirper Network is
;  followed by the most people.
;




;  PROBLEM 2:
;
;  In UBC's version of How to Code, there are often more than 800 students taking
;  the course in any given semester, meaning there are often over 40 Teaching Assistants.
;
;  Designing a schedule for them by hand is hard work - luckily we've learned enough now to write
;  a program to do it for us!
;
;  Below are some data definitions for a simplified version of a TA schedule. There are some
;  number of slots that must be filled, each represented by a natural number. Each TA is
;  available for some of these slots, and has a maximum number of shifts they can work.
;
;  Design a search program that consumes a list of TAs and a list of Slots, and produces one
;  valid schedule where each Slot is assigned to a TA, and no TA is working more than their
;  maximum shifts. If no such schedules exist, produce false.
;
;  You should supplement the given check-expects and remember to follow the recipe!



;; Slot is Natural
;; interp. each TA slot has a number, is the same length, and none overlap

(define-struct ta (name max avail))
;; TA is (make-ta String Natural (listof Slot))
;; interp. the TA's name, number of slots they can work, and slots they're available for

(define SOBA (make-ta "Soba" 2 (list 1 3)))
(define UDON (make-ta "Udon" 1 (list 3 4)))
(define RAMEN (make-ta "Ramen" 1 (list 2)))

(define NOODLE-TAs (list SOBA UDON RAMEN))



(define-struct assignment (ta slot))
;; Assignment is (make-assignment TA Slot)
;; interp. the TA is assigned to work the slot

;; Schedule is (listof Assignment)


;; ============================= FUNCTIONS


;; (listof TA) (listof Slot) -> Schedule or false
;; produce valid schedule given TAs and Slots; false if impossible


(check-expect (get-answer empty 0) empty)
(check-expect (get-answer (list (list (make-assignment SOBA 1))) 1)
              (list (make-assignment SOBA 1)))
(check-expect (get-answer (list (list (make-assignment SOBA 1))) 2) false)
(check-expect (get-answer (list (list (make-assignment SOBA 1))
                                (list (make-assignment SOBA 1)
                                      (make-assignment SOBA 2))
                                (list (make-assignment SOBA 1)
                                      (make-assignment SOBA 2)
                                      (make-assignment SOBA 3))) 2)
              (list (make-assignment SOBA 1)
                    (make-assignment SOBA 2)))


(define (get-answer possibleSolutions size)
  (local [(define filtered (filter (lambda (loa)
                                     (= (length loa) size))
                                   possibleSolutions))]
    (cond [(zero? size) empty]
          [(not (zero? (length filtered))) (first filtered)]
          [else
           false])))




(check-expect (number-of-ta-in-list empty SOBA) 0)
(check-expect (number-of-ta-in-list (list (make-assignment SOBA 1)) SOBA) 1)
(check-expect (number-of-ta-in-list (list (make-assignment RAMEN 1)) SOBA) 0)
(check-expect (number-of-ta-in-list (list (make-assignment SOBA 1)
                                          (make-assignment RAMEN 2)
                                          (make-assignment SOBA 3)) SOBA) 2)


(define (number-of-ta-in-list loa ta)
  (length (filter (lambda (a)
                    (string=? (ta-name (assignment-ta a)) (ta-name ta)))
                  loa)))





(check-expect (add-to-existingSolutions SOBA 1 empty empty) empty)
(check-expect (add-to-existingSolutions SOBA 3 (list (list (make-assignment RAMEN 2)
                                                           (make-assignment SOBA 1))) empty)
              (list (list (make-assignment SOBA 3)
                          (make-assignment RAMEN 2)
                          (make-assignment SOBA 1))))

(define (add-to-existingSolutions ta slot existingSolutions rsf)
  (cond [(empty? existingSolutions) rsf]
        [(< (number-of-ta-in-list (first existingSolutions) ta)
            (ta-max ta))
         (add-to-existingSolutions ta
                                   slot
                                   (rest existingSolutions)
                                   (append (list (cons (make-assignment ta slot)
                                                       (first existingSolutions)))
                                           rsf))]
        [else
         (add-to-existingSolutions ta slot (rest existingSolutions) rsf)]))



(define (fill-slot slot tas existingSolutions rsf)
  (cond [(and (empty? tas) (empty? rsf)) false]
        [(empty? tas) rsf]
        [else (local [(define ta (first tas))

                      (define is-member (member? slot (ta-avail ta)))]
                (cond [(and is-member (empty? existingSolutions))
                       (fill-slot slot
                                  (rest tas)
                                  existingSolutions
                                  (append (list (list (make-assignment ta slot)))
                                          rsf))]
                      [is-member
                       (fill-slot slot
                                  (rest tas)
                                  existingSolutions
                                  (append (add-to-existingSolutions ta slot existingSolutions empty)
                                          rsf))]
                      [else
                       (fill-slot slot (rest tas) existingSolutions rsf)]))]))





(check-expect (schedule-tas empty empty) empty)
(check-expect (schedule-tas empty (list 1 2)) false)
(check-expect (schedule-tas (list SOBA) empty) empty)

(check-expect (schedule-tas (list SOBA) (list 1)) (list (make-assignment SOBA 1)))
(check-expect (schedule-tas (list SOBA) (list 2)) false)
(check-expect (schedule-tas (list SOBA) (list 1 3)) (list (make-assignment SOBA 3)
                                                          (make-assignment SOBA 1)))

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4))
              (list
               (make-assignment UDON 4)
               (make-assignment SOBA 3)
               (make-assignment RAMEN 2)
               (make-assignment SOBA 1)))

(check-expect (schedule-tas NOODLE-TAs (list 1 2 3 4 5)) false)


(define (schedule-tas tas0 slots0)
  (local [(define (fn-for-slots slots possibleSolutions)
            (cond [(false? possibleSolutions) false]
                  [(empty? slots) (get-answer possibleSolutions (length slots0))]
                  [else (fn-for-slots (rest slots)
                                      (fill-slot (first slots)
                                                 tas0
                                                 possibleSolutions
                                                 empty))]))]
    (fn-for-slots slots0 empty)))
