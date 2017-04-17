#lang racket
;;;;;; Double-K ;;;;;;
;; Seokhwan_Ko
;; Leon_Kang



(require "cards/cards.rkt")
(require racket/gui)
(require racket/class)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; Define main table ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; layout
(define WIDTH 5)
(define HEIGHT 4)
(define MAX-MATCHES (/ (* WIDTH HEIGHT) 2))

;; random card
(random-seed (modulo (current-milliseconds) 10000))

;; Set up the table
(define table (make-table "Double-K" (+ 4 WIDTH) (+ 2 HEIGHT)))
(send table show #t)
(send table set-double-click-action #f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup menu bar ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Menu
(define menu-bar (new menu-bar%
                      (parent table)))
;;; Menu - File
(define file-menu (new menu%
                       (label "&File")
                       (parent menu-bar)))
;;; Menu - File - Quit
(new menu-item%
     (label "&Quit")
     (parent file-menu)
     (callback (lambda (item event)
                 (send table on-exit))))

;;; Menu - Help
(define help-menu (new menu%
                       (label "&Help")
                       (parent menu-bar)))

;;; Menu - Help - About
(new menu-item%
     (label "&About")

     (parent help-menu)
     (callback (lambda (item event)
                  (message-box "About"
                               "
###############   Author   ###############

 - Seokhwan Ko  [seokhwan_ko@student.uml.edu]
 - Leon Kang  [leon_kang@student.uml.edu]"))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup panels ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Main panel
(define TableContent (new horizontal-panel% 
                      [parent table]))
; panel1
(define TablePanel1 (new vertical-panel% 
                        [parent TableContent]))
; panel2
(define TablePanel2 (new vertical-panel% 
                        [parent TableContent]))
; panel3
(define TablePanel3 (new vertical-panel% 
                        [parent TablePanel2]))
; panel4
(define TablePanel4 (new horizontal-panel% 
                        [parent table]))


(define TableRight1Panel (new group-box-panel% [parent TablePanel2]
                       [label "Setting"]
                       [min-width 50]
                       [min-height 50]))
; version msg
(define TvMsg (new message% 
                    [label "v1.0"]
                    [parent TablePanel4]))



(define ((button-reset i) btn evt)
  (set! matches 0)
  (setup)
  )


(make-object button% (format "~a" "RESET") TableRight1Panel (button-reset 1))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup card deck ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define deck 
  (let ([cards (map (lambda (name value)
                      (let ([bm (make-object
                                 bitmap%
                                 (build-path "images"
                                  (format "~a.png" name)))])
                        (make-card bm #f 0 value)))
                    '("club" "heart" "spade" "diamond"
                      "utb" "android"
                      "lnx" "anms"
                      "twt" "dk")
                    '(1 2 3 4 5 6 7 8 9 10))])
    (append cards (map (lambda (c) (send c copy)) cards))))
(for-each (lambda (card)
            (send card user-can-move #f)
            (send card user-can-flip #t))
          deck)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; Define x y w h values ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; table w h
(define w (send table table-width))
(define h (send table table-height))

;; card w h
(define cw (send (car deck) card-width))
(define ch (send (car deck) card-height))

;; dist x y
(define dx (+ 10 (/ cw (+ WIDTH 1))))
(define dy (+ 50 (/ ch (+ HEIGHT 1))))

;; board box x y w h
(define cbx (/ dx 2))
(define cby (+ (/ dy 2) 10))
(define cbw (* (+ dx cw) 5))
(define cbh (* (+ 20 ch) 4))

;; matched card box x y w h
(define mcbox-x (+ cbw 50))
(define mcbox-y (/ cbh 2))
(define mcbox-w (+ cw 30))
(define mcbox-h (+ ch 50))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup engines ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; put the cards on the table
(send table add-cards deck mcbox-x mcbox-y)

;; setup
(define (setup)
  (set! deck (shuffle-list deck 7))
  (send table stack-cards deck)
  (send table move-cards deck 0 0
        (lambda (pos)
          (let ([i (modulo pos WIDTH)]
                [j (quotient pos WIDTH)])
            (values (+ dx (* i (+ cw dx)))
                    (+ dy (* j (+ ch 10))))))))

;; number of matches
(define matches 0)


;; First card flipped, or #f if non flipped, yet
(define card-1 #f)

;; flip and match
(define (flip-and-match c)
  (cond [(eq? c card-1)
         ;; cancel first card
         (send table flip-card c)
         (set! card-1 #f)]
        ;; cannot click the card if it's face-down
        [(not (send c face-down?))
         ;; if the game is over, reset the game by clicking
         (when (= matches MAX-MATCHES)
           (send table flip-cards deck)
           (set! matches 0)
           (setup))]
        [else
         ;; flip over a card...
         (send table flip-card c)
         (send table card-to-front c)
         (cond [(not card-1)
                ;; the first card
                (set! card-1 c)]
               [(and (equal? (send card-1 get-value) (send c get-value))
                     (equal? (send card-1 get-suit) (send c get-suit)))
                ;; if the cards are same
                (send table pause 0.5)
                (send table move-cards (list card-1 c) (+ mcbox-x 15) (+ mcbox-y 30))
                (send table flip-cards (list card-1 c))
                (set! card-1 #f)
                (set! matches (add1 matches))]
               [else
                ;; not same
                (send table pause 0.5)
                (send table flip-cards (list card-1 c))
                (set! card-1 #f)])]))

(send table set-single-click-action flip-and-match)

;; timer
(define start-time #f)   ; start-time


;; board box region
(define make-cboard-region 
  (make-region cbx cby cbw cbh "text region" #f))

(define cboard-region make-cboard-region)

(send table add-region cboard-region)


;; matched card box region
(define make-mcbox-region 
  (make-region mcbox-x mcbox-y mcbox-w mcbox-h "text region" #f))

(define mcbox-region make-mcbox-region)

(send table add-region mcbox-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;; Display ;;;;;;;;;;;;;;;;;;;;

;; start the game
(send table pause 0.25)
(setup)
