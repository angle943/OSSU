
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; 1
(define (sequence low high stride)
  (if (< high low)
      null
      (cons low (sequence (+ low stride) high stride))))

;; 2
(define (string-append-map xs suffix)
  (map (λ (str) (string-append str suffix)) xs))

;; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs
                            (remainder n (length xs))))]))

;; 4
(define (stream-for-n-steps s n)
  (cond [(= n 0) null]
        [#t (let* ([stream-result (s)]
                   [current-value (car stream-result)]
                   [next-stream (cdr stream-result)])
              (cons current-value (stream-for-n-steps next-stream (- n 1))))]))

;; 5
(define funny-number-stream
  (letrec ([f (λ (n)
                (if (= (remainder n 5) 0)
                    (cons (* -1 n) (λ () (f (+ n 1))))
                    (cons n (λ () (f (+ n 1))))))])
    (λ () (f 1))))

;; 6
(define dan-then-dog
  (letrec ([dan (λ () (cons "dan.jpg" dog))]
           [dog (λ () (cons "dog.jpg" dan))])
    dan))

;; 7
(define (stream-add-zero s)
  (letrec ([stream-result (s)]
           [stream-value (car stream-result)]
           [next-stream (cdr stream-result)]
           [f (λ () (cons (cons 0 stream-value) (stream-add-zero next-stream)))])
    f))

;; 8
(define (cycle-lists xs ys)
  (letrec ([f (λ (n)
                (cons (cons (list-nth-mod xs n) (list-nth-mod ys n))
                      (λ () (f (+ n 1)))))])
    (λ () (f 0))))

;; 9
(define (vector-assoc v vec)
  (letrec ([loop (λ (i)
                   (if (= i (vector-length vec))
                       #f
                       (let ([x (vector-ref vec i)])
                         (if (and (pair? x) (equal? (car x) v))
                             x
                             (loop (+ i 1))))))])
    (loop 0)))

;; 10
(define (cached-assoc xs n)
  (letrec ([current-pos 0]
           [memo (make-vector n #f)]
           [f (λ (v)
                (let ([ans (vector-assoc v memo)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (assoc v xs)])
                        (begin
                          (vector-set! memo current-pos new-ans)
                          (set! current-pos (remainder (+ current-pos 1) n))
                          new-ans)))))])
    f))

;; Challenge
(define-syntax while-less
  (syntax-rules (do)
    [(while-less e1 do e2)
     (let ([c1 e1])
       (letrec ([loop (λ ()
                        (if (>= e2 c1)
                            #t
                            (loop)))])
         (loop)))]))