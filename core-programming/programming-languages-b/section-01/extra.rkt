#lang racket

; #1
(define (palindromic xs)
  (letrec ([sx (reverse xs)]
           [f (λ (xsa sxa)
                (if (null? xsa)
                    null
                    (cons (+ (car xsa) (car sxa)) (f (cdr xsa) (cdr sxa)))))])
    (f xs sx)))

; #2
(define fibonacci
  (letrec ([f (λ (n1 n2)
                (cond [(= -1 n2) (cons 0 (λ () (f -1 0)))]
                      [(= -1 n1) (cons 1 (λ () (f n2 1)))]
                      [#t (let ([sum (+ n1 n2)])
                            (cons sum (λ () (f n2 sum))))]))])
    (λ () (f -1 -1))))

;(car (fibonacci))
;(car ((cdr (fibonacci))))
;(car ((cdr ((cdr (fibonacci))))))
;(car ((cdr ((cdr ((cdr (fibonacci))))))))


; #3
(define (stream-until f s)
  (let* ([stream-val (s)]
         [applying-f (f (car stream-val))]
         [next-stream (cdr stream-val)])
    (if (not applying-f)
        #t
        (stream-until f next-stream))))

#;
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))
#;
(define (f n)
  (begin (print "fing")
         (print n)
         (< n 100)))

; #4
(define (stream-map f s)
  (let* ([stream-val (s)]
         [applying-f (f (car stream-val))]
         [next-stream (cdr stream-val)])
    (λ () (cons applying-f (stream-map f next-stream)))))

#;
(define powers-of-two
  (letrec ([f (lambda (x) (cons x (lambda () (f (* x 2)))))])
    (lambda () (f 2))))
#;
(define (add-one n)
  (+ n 1))
#;
(car ((cdr ((stream-map add-one powers-of-two)))))

; #5