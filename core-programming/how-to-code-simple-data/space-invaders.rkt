;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)
(require 2htdp/universe)

;; Space Invaders


;; ==============
;; Constants:

(define WIDTH 400)
(define HEIGHT 500)
(define MTS (rectangle WIDTH HEIGHT "solid" "black"))
(define TEXT_SIZE 25)
(define TEXT_COLOR "white")

(define GAME_SPEED 0.02)
(define HERO_SPEED 5)
(define LASER_SPEED 13)
(define SPAWN_RATE 100)
(define INITIAL_SPAWN_TIME 10)
(define ENEMY_Y_SPEED 1)
(define ENEMY_X_SPEED 2)
(define MARGIN 10)

(define HERO_SPRITE (polygon (list (make-posn 0 10)
                                   (make-posn 5 5)
                                   (make-posn 10 5)
                                   (make-posn 10 0)
                                   (make-posn 15 0)
                                   (make-posn 15 5)
                                   (make-posn 20 5)
                                   (make-posn 25 10)
                                   (make-posn 25 15)
                                   (make-posn 0 15))
                             "solid" "green"))
(define HERO_Y_POS (- HEIGHT 50))
(define HERO_WIDTH (image-width HERO_SPRITE))
(define HERO_HALF_WIDTH (/ HERO_WIDTH 2))

(define LASER_HEIGHT 10)
(define LASER_HALF_HEIGHT (/ LASER_HEIGHT 2))
(define LASER_SPRITE (rectangle 3 LASER_HEIGHT "solid" "white"))

(define ENEMY_SPRITE (polygon (list (make-posn 0 12)
                                    (make-posn 5 4)
                                    (make-posn 10 0)
                                    (make-posn 15 0)
                                    (make-posn 20 4)
                                    (make-posn 25 12)
                                    (make-posn 23 12)
                                    (make-posn 21 15)
                                    (make-posn 19 12)
                                    (make-posn 14.5 12)
                                    (make-posn 12.5 14)
                                    (make-posn 10.5 12)
                                    (make-posn 6 12)
                                    (make-posn 4 15)
                                    (make-posn 2 12)
                                    (make-posn 0 12))
                              "solid" "red"))

(define ENEMY_WIDTH (image-width ENEMY_SPRITE))
(define ENEMY_HALF_WIDTH (/ ENEMY_WIDTH 2))
(define ENEMY_HEIGHT (image-height ENEMY_SPRITE))
(define ENEMY_HALF_HEIGHT (/ ENEMY_HEIGHT 2))


;; Data Definitions:
(define-struct hero (lives x v))
;; Hero is (make-hero Natural Natural)
;; interp. Hero State. Lives is number of lives, x is the horizontal position of hero.
;; v is one of:
;; - "left"
;; - "right"
;; - false
;; -- denotes whether the hero is going left, right, or stationary (false)
(define DEFAULT_HERO (make-hero 3 (/ WIDTH 2) false))

(define-struct enemy (x y right?))
;; Enemy is (make-enemy Natural Natural Boolean)
;; interp. Enemy and it's coordinate (x, y) and right? is true if going right direction, else false
(define DEFAULT_ENEMY (make-enemy (/ WIDTH 2) (/ HEIGHT 2) true))
(define DEFAULT_ENEMY2 (make-enemy (/ WIDTH 4) (/ HEIGHT 4) false))


;; ListOfEnemies (loe) is one of:
;; - empty
;; - Enemy
(define LOE0 empty)
(define LOE1 (cons DEFAULT_ENEMY empty))
(define LOE2 (list DEFAULT_ENEMY DEFAULT_ENEMY2))

(define-struct position (x y))
;; Position is (make-laser Natural Natural)
;; interp. position of laser in game that kills aliens

;; Laser is one of:
;; - empty
;; - position
(define DEFAULT_LASER (make-position (/ WIDTH 2) (/ HEIGHT 2)))
(define DEFAULT_LASER2 (make-position 0 0))

(define-struct game (hero loe points laser spawn-time))
;; Game is (make-game Hero ListOfEnemies Natural Laser Natural)
;; interp. Game state. Hero is hero status.
;; ListOfEnemies is straight forward. Points total number of aliens killed.
;; Laser is laser. spawn-time is how many ticks left to spawn

;; Game -> Game
;; start the world with (main DEFAULT)
(define DEFAULT (make-game DEFAULT_HERO empty 0 empty INITIAL_SPAWN_TIME))


;; --------- GAME --------------
(define (main game)
  (big-bang game
    (on-tick tock GAME_SPEED)
    (on-key handle-key)
    (on-release handle-release)
    (to-draw render)))


;; TOCK BEGINS
(define (tock game)
  (check-if-dead (spawn-enemy (filter-enemies (make-game (move-hero (game-hero game))
                                                         (move-enemies (game-loe game))
                                                         (game-points game)
                                                         (filter-laser (move-laser (game-laser game)))
                                                         (tick-spawn (game-spawn-time game)))))))

(define (filter-enemies game)
  (cond [(or (empty? (game-laser game))
             (empty? (game-loe game)))
         game]
        [(hit? (game-loe game) (game-laser game)) (make-game (game-hero game)
                                                             (filter-enemy (game-loe game) (game-laser game))
                                                             (+ (game-points game) 1)
                                                             empty
                                                             (game-spawn-time game))]
        [else game]))

(define (filter-enemy loe laser)
  (cond [(or (empty? loe) (empty? laser)) loe]
        [else
         (if (is-overlapping (first loe) laser)
             (rest loe)
             (cons (first loe) (filter-enemy (rest loe) laser)))]))


(define (hit? loe laser)
  (cond [(or (empty? loe) (empty? laser)) false]
        [else
         (or (is-overlapping (first loe) laser) (hit? (rest loe) laser))]))

(define (is-overlapping enemy laser)
  (and (>= (position-x laser) (- (enemy-x enemy) ENEMY_HALF_WIDTH))
       (<= (position-x laser) (+ (enemy-x enemy) ENEMY_HALF_WIDTH))
       (or (and (>= (position-y (laser-top-pt laser)) (- (enemy-y enemy) ENEMY_HALF_HEIGHT))
                (<= (position-y (laser-top-pt laser)) (+ (enemy-y enemy) ENEMY_HALF_HEIGHT)))
           (and (>= (position-y (laser-bot-pt laser)) (- (enemy-y enemy) ENEMY_HALF_HEIGHT))
                (<= (position-y (laser-bot-pt laser)) (+ (enemy-y enemy) ENEMY_HALF_HEIGHT))))))

(define (laser-top-pt laser)
  (make-position (position-x laser) (- (position-y laser) LASER_HALF_HEIGHT)))

(define (laser-bot-pt laser)
  (make-position (position-x laser) (+ (position-y laser) LASER_HALF_HEIGHT)))

(define (check-if-dead game)
  (cond [(empty? (game-loe game)) game]
        [(>= (enemy-y (get-last-enemy (game-loe game))) HERO_Y_POS) (lose-life game)]
        [else game]))

(define (lose-life game)
  (make-game (make-hero (sub1 (hero-lives (game-hero game))) (/ WIDTH 2) false)
             empty
             (game-points game)
             empty
             INITIAL_SPAWN_TIME))

(check-expect (get-last-enemy empty) empty)
(check-expect (get-last-enemy LOE1) DEFAULT_ENEMY)
(check-expect (get-last-enemy LOE2) DEFAULT_ENEMY2)

(define (get-last-enemy loe)
  (cond [(empty? loe) empty]
        [(empty? (rest loe)) (first loe)]
        [else (get-last-enemy (rest loe))]))

(define (spawn-enemy game)
  (if (<= (game-spawn-time game) 0)
      (make-game (game-hero game)
                 (cons (random-enemy true) (game-loe game))
                 (game-points game)
                 (game-laser game)
                 (- SPAWN_RATE (* 1.5 (game-points game))))
      game))

(define (random-enemy b)
  (make-enemy (random WIDTH)
              0
              (= (random 2) 1)))

(check-expect (move-hero DEFAULT_HERO) DEFAULT_HERO)
(check-expect (move-hero (make-hero 3 (/ WIDTH 2) "right")) (make-hero 3 (+ (/ WIDTH 2) HERO_SPEED) "right"))
(check-expect (move-hero (make-hero 3 (/ WIDTH 2) "left")) (make-hero 3 (- (/ WIDTH 2) HERO_SPEED) "left"))
(check-expect (move-hero (make-hero 3 0 "left")) (make-hero 3 0 false))
(check-expect (move-hero (make-hero 3 WIDTH "right")) (make-hero 3 WIDTH false))

(define (move-hero hero)
  (cond [(false? (hero-v hero)) hero]
        [(string=? (hero-v hero) "left") (if (> (hero-x hero) (+ HERO_HALF_WIDTH HERO_SPEED))
                                             (make-hero (hero-lives hero) (- (hero-x hero) HERO_SPEED) "left")
                                             (make-hero (hero-lives hero) (hero-x hero) false))]
        [(string=? (hero-v hero) "right") (if (< (hero-x hero) (- WIDTH HERO_HALF_WIDTH HERO_SPEED))
                                              (make-hero (hero-lives hero) (+ (hero-x hero) HERO_SPEED) "right")
                                              (make-hero (hero-lives hero) (hero-x hero) false))]))

(check-expect (move-enemies empty) empty)
(check-expect (move-enemies LOE1) (list (move-enemy DEFAULT_ENEMY)))
(check-expect (move-enemies LOE2) (list (move-enemy DEFAULT_ENEMY) (move-enemy DEFAULT_ENEMY2)))

(define (move-enemies loe)
  (cond [(empty? loe) empty]
        [else (cons (move-enemy (first loe)) (move-enemies (rest loe)))]))

(check-expect (move-enemy DEFAULT_ENEMY) (move-enemy-right (move-enemy-down DEFAULT_ENEMY)))
(check-expect (move-enemy DEFAULT_ENEMY2) (move-enemy-left (move-enemy-down DEFAULT_ENEMY2)))
(check-expect (move-enemy (make-enemy 0 0 false)) (make-enemy 0 ENEMY_Y_SPEED true))
(check-expect (move-enemy (make-enemy WIDTH 0 true)) (make-enemy WIDTH ENEMY_Y_SPEED false))

(define (move-enemy enemy)
  (if (enemy-right? enemy)
      (if (< (enemy-x enemy) (- WIDTH ENEMY_HALF_WIDTH ENEMY_X_SPEED))
          (move-enemy-right (move-enemy-down enemy))
          (change-enemy-dir (move-enemy-down enemy)))
      (if (> (enemy-x enemy) (+ ENEMY_HALF_WIDTH ENEMY_X_SPEED))
          (move-enemy-left (move-enemy-down enemy))
          (change-enemy-dir (move-enemy-down enemy)))))

(check-expect (move-enemy-left DEFAULT_ENEMY) (make-enemy (- (enemy-x DEFAULT_ENEMY) ENEMY_X_SPEED) (enemy-y DEFAULT_ENEMY) (enemy-right? DEFAULT_ENEMY)))
(define (move-enemy-left enemy)
  (make-enemy (- (enemy-x enemy) ENEMY_X_SPEED) (enemy-y enemy) (enemy-right? enemy)))

(check-expect (move-enemy-right DEFAULT_ENEMY) (make-enemy (+ (enemy-x DEFAULT_ENEMY) ENEMY_X_SPEED) (enemy-y DEFAULT_ENEMY) (enemy-right? DEFAULT_ENEMY)))
(define (move-enemy-right enemy)
  (make-enemy (+ (enemy-x enemy) ENEMY_X_SPEED) (enemy-y enemy) (enemy-right? enemy)))

(check-expect (change-enemy-dir DEFAULT_ENEMY) (make-enemy (enemy-x DEFAULT_ENEMY) (enemy-y DEFAULT_ENEMY) (not (enemy-right? DEFAULT_ENEMY))))
(define (change-enemy-dir enemy)
  (make-enemy (enemy-x enemy) (enemy-y enemy) (not (enemy-right? enemy))))

(check-expect (move-enemy-down DEFAULT_ENEMY) (make-enemy (enemy-x DEFAULT_ENEMY) (+ (enemy-y DEFAULT_ENEMY) ENEMY_Y_SPEED) (enemy-right? DEFAULT_ENEMY)))
(define (move-enemy-down enemy)
  (make-enemy (enemy-x enemy) (+ (enemy-y enemy) ENEMY_Y_SPEED) (enemy-right? enemy)))

(check-expect (move-laser empty) empty)
(check-expect (move-laser DEFAULT_LASER) (make-position (position-x DEFAULT_LASER) (- (position-y DEFAULT_LASER) LASER_SPEED)))

(define (move-laser laser)
  (cond [(empty? laser) empty]
        [else (make-position (position-x laser) (- (position-y laser) LASER_SPEED))]))

(check-expect (filter-laser empty) empty)
(check-expect (filter-laser DEFAULT_LASER) DEFAULT_LASER)
(check-expect (filter-laser (make-position 4 0)) empty)

(define (filter-laser laser)
  (if (laser-in-frame? laser)
      laser
      empty))

(check-expect (laser-in-frame? empty) false)
(check-expect (laser-in-frame? DEFAULT_LASER) true)
(check-expect (laser-in-frame? (make-position 4 0)) false)

(define (laser-in-frame? laser)
  (cond [(empty? laser) false]
        [(> (position-y laser) 0) true]
        [else false]))

(check-expect (tick-spawn 5) 4)
(define (tick-spawn n)
  (- n 1))

;; TOCK ENDS

;; HANDLE-KEY BEGINS
(check-expect (handle-key DEFAULT "left") (make-game (hero-go-left (game-hero DEFAULT))
                                                     (game-loe DEFAULT)
                                                     (game-points DEFAULT)
                                                     (game-laser DEFAULT)
                                                     (game-spawn-time DEFAULT)))
(check-expect (handle-key DEFAULT "right") (make-game (hero-go-right (game-hero DEFAULT))
                                                      (game-loe DEFAULT)
                                                      (game-points DEFAULT)
                                                      (game-laser DEFAULT)
                                                      (game-spawn-time DEFAULT)))
(check-expect (handle-key DEFAULT "q") DEFAULT)

(define (handle-key game ke)
  (cond [(key=? ke "left") (make-game (hero-go-left (game-hero game))
                                      (game-loe game)
                                      (game-points game)
                                      (game-laser game)
                                      (game-spawn-time game))]
        [(key=? ke "right") (make-game (hero-go-right (game-hero game))
                                       (game-loe game)
                                       (game-points game)
                                       (game-laser game)
                                       (game-spawn-time game))]
        [(key=? ke " ") (make-game (game-hero game)
                                   (game-loe game)
                                   (game-points game)
                                   (game-laser (shoot-laser game)) (game-spawn-time game))]
        [else game]))

(define (shoot-laser game)
  (cond [(empty? (game-laser game)) (make-game (game-hero game)
                                               (game-loe game)
                                               (game-points game)
                                               (make-position (hero-x (game-hero game)) HERO_Y_POS)
                                               (game-spawn-time game))]
        [else game]))
  

(check-expect (hero-go-left DEFAULT_HERO) (make-hero (hero-lives DEFAULT_HERO) (hero-x DEFAULT_HERO) "left"))

(define (hero-go-left hero)
  (make-hero (hero-lives hero)
             (hero-x hero)
             "left"))

(check-expect (hero-go-right DEFAULT_HERO) (make-hero (hero-lives DEFAULT_HERO) (hero-x DEFAULT_HERO) "right"))

(define (hero-go-right hero)
  (make-hero (hero-lives hero)
             (hero-x hero)
             "right"))
;; HANDLE-KEY ENDS

;; HANDLE-RELEASE BEGINS
(define (handle-release game ke)
  (cond [(false? (hero-v (game-hero game))) game]
        [(and (key=? ke "left") (string=? (hero-v (game-hero game)) "left")) (make-game (stop-hero (game-hero game))
                                                                                        (game-loe game)
                                                                                        (game-points game)
                                                                                        (game-laser game)
                                                                                        (game-spawn-time game))]
        [(and (key=? ke "right") (string=? (hero-v (game-hero game)) "right")) (make-game (stop-hero (game-hero game))
                                                                                          (game-loe game)
                                                                                          (game-points game)
                                                                                          (game-laser game)
                                                                                          (game-spawn-time game))]
        [else game]))
        
(check-expect (stop-hero (make-hero 3 0 "right")) (make-hero 3 0 false))
(check-expect (stop-hero (make-hero 3 0 "left")) (make-hero 3 0 false))
(check-expect (stop-hero (make-hero 3 0 false)) (make-hero 3 0 false))
(define (stop-hero hero)
  (make-hero (hero-lives hero) (hero-x hero) false))
;; HANDLE-RELEASE ENDS

;; RENDER BEGINS
(define (render game)
  (if (game-over? game)
      (place-lives (game-hero game)
                   (place-points (game-points game)
                                 MTS))
      (place-hero (game-hero game)
                  (place-enemies (game-loe game)
                                 (place-laser (game-laser game) (place-lives (game-hero game)
                                                                             (place-points (game-points game)
                                                                                           MTS)))))))

(define (game-over? game)
  (<= (hero-lives (game-hero game)) 0))

(check-expect (place-hero DEFAULT_HERO MTS) (place-image HERO_SPRITE (hero-x DEFAULT_HERO) HERO_Y_POS MTS))

(define (place-hero hero bg)
  (place-image HERO_SPRITE (hero-x hero) HERO_Y_POS bg))

(check-expect (place-enemy DEFAULT_ENEMY MTS) (place-image ENEMY_SPRITE (enemy-x DEFAULT_ENEMY) (enemy-y DEFAULT_ENEMY) MTS))

(define (place-enemy enemy bg)
  (place-image ENEMY_SPRITE (enemy-x enemy) (enemy-y enemy) bg))

(check-expect (place-enemies empty MTS) MTS)
(check-expect (place-enemies (cons DEFAULT_ENEMY empty) MTS) (place-enemy DEFAULT_ENEMY MTS))
(check-expect (place-enemies (list DEFAULT_ENEMY DEFAULT_ENEMY2) MTS) (place-enemy DEFAULT_ENEMY (place-enemy DEFAULT_ENEMY2 MTS)))

(define (place-enemies loe bg)
  (cond [(empty? loe) bg]
        [else (place-enemy (first loe) (place-enemies (rest loe) bg))]))

(check-expect (place-laser empty MTS) MTS)
(check-expect (place-laser (make-position 2 4) MTS) (place-image LASER_SPRITE 2 4 MTS))

(define (place-laser laser bg)
  (cond [(empty? laser) bg]
        [else (place-image LASER_SPRITE (position-x laser) (position-y laser) bg)]))

(define (place-lives hero bg)
  (place-image HERO_SPRITE
               (+ MARGIN HERO_HALF_WIDTH)
               (- HEIGHT MARGIN HERO_HALF_WIDTH)
               (place-image (text (number->string (hero-lives hero)) TEXT_SIZE TEXT_COLOR)
                            (+ MARGIN HERO_WIDTH 25)
                            (- HEIGHT MARGIN HERO_HALF_WIDTH)
                            bg)))

(define (place-points points bg)
  (place-image (text (number->string points) TEXT_SIZE TEXT_COLOR)
               (- WIDTH MARGIN 25)
               (- HEIGHT MARGIN HERO_HALF_WIDTH)
               bg))
#;
(define (place-spawn-time game bg)
  (place-image (text (number->string (game-spawn-time game)) TEXT_SIZE TEXT_COLOR)
               (/ WIDTH 2)
               (- HEIGHT MARGIN HERO_HALF_WIDTH)
               bg))
;; RENDER ENDS