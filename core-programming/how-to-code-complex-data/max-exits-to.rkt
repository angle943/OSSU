
;; max-exits-to-starter.rkt

;
; PROBLEM:
;
; Using the following data definition, design a function that produces the room to which the greatest
; number of other rooms have exits (in the case of a tie you can produce any of the rooms in the tie).
;


;; Data Definitions:

(define-struct room (name exits))
;; Room is (make-room String (listof Room))
;; interp. the room's name, and list of rooms that the exits lead to

; .

(define H1 (make-room "A" (list (make-room "B" empty))))

; .

(define H2
  (shared ((-0- (make-room "A" (list (make-room "B" (list -0-))))))
    -0-))


; .

(define H3
  (shared ((-A- (make-room "A" (list -B-)))
           (-B- (make-room "B" (list -C-)))
           (-C- (make-room "C" (list -A-))))
    -A-))



; .

(define H4
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A-)))
           (-F- (make-room "F" (list))))
    -A-))

;; template: structural recursion, encapsulate w/ local, tail-recursive w/ worklist,
;;           context-preserving accumulator what rooms have we already visited

(define (fn-for-house r0)
  ;; todo is (listof Room); a worklist accumulator
  ;; visited is (listof String); context preserving accumulator, names of rooms already visited
  (local [(define (fn-for-room r todo visited)
            (if (member (room-name r) visited)
                (fn-for-lor todo visited)
                (fn-for-lor (append (room-exits r) todo)
                            (cons (room-name r) visited)))) ; (... (room-name r))
          (define (fn-for-lor todo visited)
            (cond [(empty? todo) (...)]
                  [else
                   (fn-for-room (first todo)
                                (rest todo)
                                visited)]))]
    (fn-for-room r0 empty empty)))

(check-expect (greatest-entry H1) "B")
(check-expect (greatest-entry H2) "B")
(check-expect (greatest-entry H4) "B")

(define H5
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A-)))
           (-F- (make-room "F" (list -B-))))
    -A-))

(define H6
  (shared ((-A- (make-room "A" (list -B- -D-)))
           (-B- (make-room "B" (list -C- -E-)))
           (-C- (make-room "C" (list -B-)))
           (-D- (make-room "D" (list -E-)))
           (-E- (make-room "E" (list -F- -A-)))
           (-F- (make-room "F" (list -E- -A-))))
    -A-))

(check-expect (greatest-entry H6) "E")

(define (greatest-entry r)
  (local [(define-struct entry-count (name count))

          (define (fn-for-room r todo visited loec)
            (cond [(member? (room-name r) visited) (fn-for-lor todo visited loec)]
                  [(empty? (room-exits r)) (fn-for-lor todo visited loec)]
                  [else
                   (fn-for-lor (append (room-exits r) todo)
                               (cons (room-name r) visited)
                               (add-exits loec (room-exits r)))]))

          (define (fn-for-lor todo visited loec)
            (cond [(empty? todo) (get-max (rest loec) (first loec))]
                  [else (fn-for-room (first todo) (rest todo) visited loec)]))

          (define (add-exits loec rooms)
            (cond [(empty? rooms) loec]
                  [else (add-exits (add-exits--room loec (first rooms)) (rest rooms))]))

          (define (add-exits--room loec rm)
            (cond [(empty? loec) (list (make-entry-count (room-name rm) 1))]
                  [(string=? (entry-count-name (first loec)) (room-name rm)) (cons (make-entry-count (entry-count-name (first loec)) (add1 (entry-count-count (first loec))))
                                                                                   (rest loec))]
                  [else (cons (first loec) (add-exits--room (rest loec) rm))]))

          (define (get-max loec maxec)
            (cond [(empty? loec) (entry-count-name maxec)]
                  [(> (entry-count-count (first loec))
                      (entry-count-count maxec))
                   (get-max (rest loec) (first loec))]
                  [else
                   (get-max (rest loec) maxec)]))]
    (fn-for-room r empty empty empty)))
