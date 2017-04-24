#lang racket
;;;;;; Double-K ;;;;;;
;; Seokhwan_Ko [seokhwan_ko@student.uml.edu]
;; Leon_Kang [leon_kang@student.uml.edu]



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

;; top title image
(define logo
  (read-bitmap (cond ((eq? (system-type) 'windows) "images/dklogo.png")
                     ((eq? (system-type) 'unix) "images/dklogo.png")
                     ((eq? (system-type) 'macosx) "images/dklogo.png")
                     (else (error "Platform not supported")))))

(define image-loaded (new message% [parent TablePanel1]
                          [label logo]))


(define TableRight1Panel (new group-box-panel% [parent TablePanel2]
                       [label "Setting"]
                       [min-width 50]
                       [min-height 50]))
; version msg
(define TvMsg (new message% 
                    [label "v2.1"]
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

;; logo box x y w h
;(define logo-x (+ cbw 50))
;(define logo-y (/ cbh 2))
;(define logo-w (+ cw 30))
;(define logo-h (+ ch 50))


(define timebox-h (+ 12 5 5))
(define timebox-x (/ (- cbw dx 25) 2))
(define timebox-y (- cby timebox-h 5))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup engines ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; put the cards on the table
(send table add-cards deck (+ mcbox-x 15) (+ mcbox-y 30))

;; setup
(define (setup)

  ;; reset timer
  (reset-timer)

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
         ;; run timer
         (run-timer)
         ;; flip over a card
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


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;; setup timer ;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup region
(define (make-time-region secs)
  (make-region timebox-x timebox-y cw timebox-h
               (if (>= secs 6000)
                 "--:--"
                 (format
                  "~a:~a"
                  (substring (number->string (+ 100 (quotient secs 60))) 1)
                  (substring (number->string (+ 100 (modulo secs 60))) 1)))
               #f))

(define start-time #f)   ; start-time
(define shown-sec 0) ; used to compute the delay until the next update
(define time-region (make-time-region 0)) ; time region
(send table add-region time-region) ; start with the initial region added


;; display timer
(define (display-time n)
  ;; compute new time
  (set! shown-sec n)
  ;; update the time
  (send table begin-card-sequence)
  (send table remove-region time-region)
  (set! time-region (make-time-region shown-sec))
  (send table add-region time-region)
  (send table end-card-sequence))


(define (get-update-delta)
  ;; figure out how many milliseconds to sleep before the next update
  (max 0 (inexact->exact (floor (- (+ start-time (* 1000 shown-sec) 1000)
                                   (current-inexact-milliseconds))))))


(define time-timer
  (make-object timer%
    (lambda ()
      (unless (= matches MAX-MATCHES)
        (display-time
         (inexact->exact
          (floor (/ (- (current-inexact-milliseconds) start-time) 1000))))
        (send time-timer start (get-update-delta) #t)))))

;; run
(define (run-timer)
  (unless start-time
    (set! start-time (current-inexact-milliseconds))
    (send time-timer start 1000 #t)))

;; reset
(define (reset-timer)
  (send time-timer stop)
  (set! start-time #f)
  (display-time 0))





;; board box region
(define make-cboard-region 
  (make-region cbx cby cbw cbh "Table" #f))

(define cboard-region make-cboard-region)

(send table add-region cboard-region)


;; matched card box region
(define make-mcbox-region 
  (make-region mcbox-x mcbox-y mcbox-w mcbox-h "Matched Card" #f))

(define mcbox-region make-mcbox-region)

(send table add-region mcbox-region)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;





;;;;;;;;;;;;;;;; Display ;;;;;;;;;;;;;;;;;;;;
;;; New Button
(define make-check
  (message-box "Welcome!!" "Double K")
  
)



;; start the game
(send table pause 0.25)
(setup)
