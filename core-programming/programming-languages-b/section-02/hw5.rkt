;; Programming Languages, Homework 5

#lang racket
(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body) 
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs but /is/ a MUPL value; it is what functions evaluate to
(struct closure (env fun) #:transparent) 

;; Problem 1

(define (racketlist->mupllist xs)
  (cond [(null? xs) (aunit)]
        [#t (apair (car xs) (racketlist->mupllist (cdr xs)))]))

(define (mupllist->racketlist xs)
  (cond [(aunit? xs) null]
        [#t (cons (apair-e1 xs) (mupllist->racketlist (apair-e2 xs)))]))

;; Problem 2

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.  
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  ; (struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
  (cond [(var? e) 
         (envlookup env (var-string e))]
        
        ; (struct add  (e1 e2)  #:transparent)  ;; add two expressions
        [(add? e) 
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1) 
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        
        ;; CHANGE add more cases here
        
        ; (struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
        [(int? e) e]

        ; (struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (if (> (int-num v1)
                      (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env))
               (error "MUPL ifgreater's passed conditional arguments that are non-number")))]

        ; (struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
        [(fun? e) (closure env e)]

        ; (struct call (funexp actual)       #:transparent) ;; function call
        [(call? e)
         (let* ([closure-from-e (eval-under-env (call-funexp e) env)]
                [arg-from-e (eval-under-env (call-actual e) env)])
           
           (if (not (closure? closure-from-e))
               
               (error "MUPL call applied to non-function")
               
               (let* ([closure-environment (closure-env closure-from-e)]
                      [closure-function (closure-fun closure-from-e)]

                      [function-name (fun-nameopt closure-function)]
                      [function-arg (fun-formal closure-function)]
                      [function-body (fun-body closure-function)]

                      [arg-pair (cons function-arg arg-from-e)]
                      [function-pair (cons function-name closure-from-e)])

                 (if (not function-name)

                     ;; is lambda function
                     (eval-under-env function-body (cons arg-pair closure-environment))

                     ;; is named function
                     (eval-under-env function-body (cons function-pair (cons arg-pair closure-environment)))))))]

        ; (struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body)
        [(mlet? e)
         (let* ([e-var (mlet-var e)]
                [e-e (eval-under-env (mlet-e e) env)]
                [e-body (mlet-body e)]

                [var-pair (cons e-var e-e)])

           (eval-under-env e-body (cons var-pair env)))]

        ; (struct apair (e1 e2)     #:transparent) ;; make a new pair
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]

        ; (struct fst  (e)    #:transparent) ;; get first part of a pair
        [(fst? e)
         (let ([v (eval-under-env (fst-e e) env)])
           (if (apair? v)
               (apair-e1 v)
               (error "MUPL fst applied to non-pair")))]
        
        ; (struct snd  (e)    #:transparent) ;; get second part of a pair
        [(snd? e)
         (let ([v (eval-under-env (snd-e e) env)])
           (if (apair? v)
               (apair-e2 v)
               (error "MUPL snd applied to non-pair")))]

        ; (struct aunit ()    #:transparent) ;; unit value -- good for ending a list
        [(aunit? e) e]

        ; (struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0
        [(isaunit? e)
         (let ([v (eval-under-env (isaunit-e e) env)])
           (if (aunit? v)
               (int 1)
               (int 0)))]

        ; (struct closure (env fun) #:transparent)
        [(closure? e) e]
         
        
        ;; END MY CHANGE
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))
        
;; Problem 3

(define (ifaunit e1 e2 e3) (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (cond [(null? lstlst) e2]
        [#t (let* ([head (car lstlst)]
                   [tail (cdr lstlst)]
                   
                   [variable-name (car head)]
                   [variable-value (cdr head)])
              (mlet variable-name variable-value (mlet* tail e2)))]))

(define (ifeq e1 e2 e3 e4)
  (mlet* (list (cons "_x" e1) (cons "_y" e2))
         (ifgreater (var "_x")
                    (var "_y")
                    e4
                    (ifgreater (var "_y")
                               (var "_x")
                               e4
                               e3))))

;; Problem 4

; (struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
; (struct call (funexp actual)       #:transparent) ;; function call
(define mupl-map
  (fun #f "f" (fun "map-f" "xs" (ifeq (isaunit (var "xs"))
                                      (int 1)
                                      (aunit)
                                      (apair
                                       (call (var "f") (fst (var "xs")))
                                       (call (var "map-f") (snd (var "xs"))))))))

(define mupl-mapAddN 
  (mlet "map" mupl-map
        (fun #f "i" (call (var "map")
                          (fun #f "x" (add (var "x")
                                           (var "i")))))))

;; Challenge Problem

(struct fun-challenge (nameopt formal body freevars) #:transparent) ;; a recursive(?) 1-argument function

;; We will test this function directly, so it must do
;; as described in the assignment
(define (compute-free-vars e) "CHANGE")

;; Do NOT share code with eval-under-env because that will make
;; auto-grading and peer assessment more difficult, so
;; copy most of your interpreter here and make minor changes
(define (eval-under-env-c e env) "CHANGE")

;; Do NOT change this
(define (eval-exp-c e)
  (eval-under-env-c (compute-free-vars e) null))
