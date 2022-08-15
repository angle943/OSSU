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

(define-struct chirper (name verified? follows))
(define-struct followers-count (name count))

(define c1
  (shared ((-A- (make-chirper "A" true (list -B-)))
           (-B- (make-chirper "B" true (list -A- -C- -D- -E- -F- -G-)))
           (-C- (make-chirper "C" false (list -A- -B- -G-)))
           (-D- (make-chirper "D" true (list -A- -C- -F-)))
           (-E- (make-chirper "E" false (list -A- -B-)))
           (-F- (make-chirper "F" true empty))
           (-G- (make-chirper "G" false (list -E-))))
    -A-))

(define c2
  (shared ((-A- (make-chirper "A" true (list -B- -F-)))
           (-B- (make-chirper "B" true (list -A- -C- -D- -E- -F- -G-)))
           (-C- (make-chirper "C" false (list -A- -B- -G- -F-)))
           (-D- (make-chirper "D" true (list -A- -C- -F-)))
           (-E- (make-chirper "E" false (list -A- -B- -F-)))
           (-F- (make-chirper "F" true empty))
           (-G- (make-chirper "G" false (list -E- -F-))))
    -A-))

(define fc1 (make-followers-count "A" 4))
(define fc2 (make-followers-count "B" 3))
(define fc3 (make-followers-count "C" 1))
(define fc4 (make-followers-count "D" 0))

(check-expect (lofc-includes? "A" empty) false)
(check-expect (lofc-includes? "A" (list fc1)) true)
(check-expect (lofc-includes? "C" (list fc1 fc2 fc3 fc4)) true)
(check-expect (lofc-includes? "F" (list fc1 fc2 fc3 fc4)) false)

(define (lofc-includes? n lofc)
  (cond [(empty? lofc) false]
        [(string=? (followers-count-name (first lofc))
                   n)
         true]
        [else (lofc-includes? n (rest lofc))]))

(check-expect (add1-to-it "A" (list fc1)) (list (make-followers-count "A" 5)))
(check-expect (add1-to-it "C" (list fc1 fc2 fc3 fc4))
              (list fc1 fc2
                    (make-followers-count "C" 2) fc4))

(define (add1-to-it n lofc)
  (cond [(empty? lofc) empty]
        [(string=? (followers-count-name (first lofc))
                   n)
         (cons (make-followers-count n (add1 (followers-count-count (first lofc))))
               (rest lofc))]
        [else (cons (first lofc) (add1-to-it n (rest lofc)))]))

(check-expect (add-followers empty empty) empty)
(check-expect (add-followers (list (make-chirper "A" false empty))
                             (list fc1))
              (list (make-followers-count "A" 5)))
(check-expect (add-followers (list (make-chirper "B" false empty))
                             (list fc1))
              (list (make-followers-count "B" 1) fc1))
(check-expect (add-followers (list (make-chirper "A" false empty)
                                   (make-chirper "B" false empty)
                                   (make-chirper "D" false empty)
                                   (make-chirper "E" false empty))
                             (list fc1 fc2 fc3 fc4))
              (list (make-followers-count "E" 1)
                    (make-followers-count "A" 5)
                    (make-followers-count "B" 4)
                    (make-followers-count "C" 1)
                    (make-followers-count "D" 1)))
(check-expect (add-followers (list (make-chirper "A" false empty)
                                   (make-chirper "B" false empty)
                                   (make-chirper "D" false empty)
                                   (make-chirper "E" false empty))
                             empty)
              (list (make-followers-count "A" 1)
                    (make-followers-count "B" 1)
                    (make-followers-count "D" 1)
                    (make-followers-count "E" 1)))

(define (add-followers loc lofc)
  (cond [(empty? loc) lofc]
        [(lofc-includes? (chirper-name (first loc)) lofc)
         (add-followers (rest loc) (add1-to-it (chirper-name (first loc)) lofc))]
        [else
         (cons (make-followers-count (chirper-name (first loc))
                                     1)
               (add-followers (rest loc) lofc))]))

(check-expect (get-answer (list (make-followers-count "E" 1)
                                (make-followers-count "A" 5)
                                (make-followers-count "B" 4)
                                (make-followers-count "C" 1)
                                (make-followers-count "D" 1))
                          "" -1)
              "A")
(check-expect (get-answer (list (make-followers-count "E" 1)
                                (make-followers-count "A" 5)
                                (make-followers-count "B" 4)
                                (make-followers-count "C" 1)
                                (make-followers-count "D" 1)
                                (make-followers-count "F" 6))
                          "" -1)
              "F")

(define (get-answer lofc rsf max)
  (cond [(empty? lofc) rsf]
        [(> (followers-count-count (first lofc))
            max)
         (get-answer (rest lofc)
                     (followers-count-name (first lofc))
                     (followers-count-count (first lofc)))]
        [else
         (get-answer (rest lofc)
                     rsf
                     max)]))


(check-expect (most-followers c1) "A")
(check-expect (most-followers c2) "F")

(define (most-followers c)
  (local [(define (fn-for-c c todo visited lofc)
            (cond [(member? c visited)
                   (fn-for-loc todo
                               visited
                               lofc)]
                  [else
                   (fn-for-loc (append (chirper-follows c)
                                       todo)
                               (cons c visited)
                               (add-followers (chirper-follows c)
                                              lofc))]))

          (define (fn-for-loc todo visited lofc)
            (cond [(empty? todo) (get-answer lofc "" -1)]
                  [else
                   (fn-for-c (first todo) (rest todo) visited lofc)]))]
    (fn-for-c c empty empty empty)))

#;
(define (most-followers c)
  (local [(define (fn-for-c c todo visited lofc)
            (if (member? (chirper-name c) visited)
                (fn-for-loc todo visited lofc)
                (fn-for-loc (append (chirper-follows c)
                                    todo)
                            (cons (chirper-name c) visited)
                            (add-followers (chirper-follows c)
                                           lofc))))

          (define (fn-for-loc loc visited lofc)
            (cond [(empty? loc) (get-answer lofc "" -1)]
                  [else
                   (fn-for-c (first loc) (rest loc) visited lofc)]))]
    (fn-for-c c empty empty empty)))
