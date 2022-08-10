;  PROBLEM 1:
;
;  Assuming the use of at least one accumulator, design a function that consumes a list of strings,
;  and produces the length of the longest string in the list.
;


(check-expect (longest (list "a" "ababa" "abad" "iel")) "ababa")
(check-expect (longest (list "1231" "1" "1")) "1231")

(define (longest los)
  (local [(define (fn los longest)
            (cond [(empty? los) longest]
                  [(> (string-length (first los)) (string-length longest))
                   (fn (rest los) (first los))]
                  [else
                   (fn (rest los) longest)]))]
    (fn los (first los))))

;  PROBLEM 2:
;
;  The Fibbonacci Sequence https://en.wikipedia.org/wiki/Fibonacci_number is
;  the sequence 0, 1, 1, 2, 3, 5, 8, 13,... where the nth element is equal to
;  n-2 + n-1.
;
;  Design a function that given a list of numbers at least two elements long,
;  determines if the list obeys the fibonacci rule, n-2 + n-1 = n, for every
;  element in the list. The sequence does not have to start at zero, so for
;  example, the sequence 4, 5, 9, 14, 23 would follow the rule.
;


(check-expect (fibonnacci? (list 0 1 1 2 3 5 8 13)) true)
(check-expect (fibonnacci? (list 0 1 1 2 3 5 8 13 15)) false)
(check-expect (fibonnacci? (list 4 5 9 14 23)) true)

(define (fibonnacci? lon)
  (local [(define (fn todo num1 num2)
            (cond [(empty? todo) true]
                  [(not (= (first todo) (+ num1 num2))) false]
                  [else
                   (fn (rest todo) num2 (first todo))]))]
    (fn (rest (rest lon)) (first lon) (first (rest lon)))))


;  PROBLEM 3:
;
;  Refactor the function below to make it tail recursive.
;


;; Natural -> Natural
;; produces the factorial of the given number
(check-expect (fact 0) 1)
(check-expect (fact 3) 6)
(check-expect (fact 5) 120)

#;
(define (fact n)
  (cond [(zero? n) 1]
        [else
         (* n (fact (sub1 n)))]))

(define (fact n)
  (local [(define (fn n rsf)
            (cond [(zero? n) rsf]
                  [else (fn (sub1 n) (* n rsf))]))]
    (fn n 1)))


;  PROBLEM 4:
;
;  Recall the data definition for Region from the Abstraction Quiz. Use a worklist
;  accumulator to design a tail recursive function that counts the number of regions
;  within and including a given region.
;  So (count-regions CANADA) should produce 7



(define-struct region (name type subregions))
;; Region is (make-region String Type (listof Region))
;; interp. a geographical region

;; Type is one of:
;; - "Continent"
;; - "Country"
;; - "Province"
;; - "State"
;; - "City"
;; interp. categories of geographical regions

(define VANCOUVER (make-region "Vancouver" "City" empty))
(define VICTORIA (make-region "Victoria" "City" empty))
(define BC (make-region "British Columbia" "Province" (list VANCOUVER VICTORIA)))
(define CALGARY (make-region "Calgary" "City" empty))
(define EDMONTON (make-region "Edmonton" "City" empty))
(define ALBERTA (make-region "Alberta" "Province" (list CALGARY EDMONTON)))
(define CANADA (make-region "Canada" "Country" (list BC ALBERTA)))

(check-expect (count-regions CANADA) 7)
(check-expect (count-regions VANCOUVER) 1)
(check-expect (count-regions BC) 3)

(define (count-regions r)
  (local [(define (fn-for-region r todo count)
            (fn-for-lor (append (region-subregions r)
                                todo)
                        (add1 count)))

          (define (fn-for-lor lor count)
            (cond [(empty? lor) count]
                  [else
                   (fn-for-region (first lor) (rest lor) count)]))]
    (fn-for-region r empty 0)))

#;
(define (fn-for-region r)
  (local [(define (fn-for-region r)
            (... (region-name r)
                 (fn-for-type (region-type r))
                 (fn-for-lor (region-subregions r))))

          (define (fn-for-type t)
            (cond [(string=? t "Continent") (...)]
                  [(string=? t "Country") (...)]
                  [(string=? t "Province") (...)]
                  [(string=? t "State") (...)]
                  [(string=? t "City") (...)]))

          (define (fn-for-lor lor)
            (cond [(empty? lor) (...)]
                  [else
                   (... (fn-for-region (first lor))
                        (fn-for-lor (rest lor)))]))]
    (fn-for-region r)))
