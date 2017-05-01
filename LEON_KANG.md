# Double-K Memory Card Game

## Leon Kang
### April 30, 2017

# Overview
We built a "Memory" card game using racket. For a long period I had a 
misunderstanding with my partner as to what exactly we were building. 
It could have been due to the lack of communication we had between each other
but I did one thing and he did another. As a result the majority of the project code
was not written by me, but by my partner. 

# Libraries Used
Our project uses these libraries:

(require "cards/cards.rkt")
(require racket/gui)
(require racket/class)

The cards/cards.rkt library provides make-deck,make-card, and make-table which
are useful in creating the logic needed for the deck of cards.

The racket/gui library helps create the interface for the game.

racket/class allows to create classes and use object%

# Key Code Excerpts

## 1. Creating Deck of Cards (Authored by Partner)

```
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
```
This code creates a let variable cards which creates a mapping between
the value of the bitmap and a number to associate that value. then when we have
the variable ready it is appended to the mapping which sends it to the gui. This
code embodies the ideas of the course from the nested lets and nested lambdas as well as
mapping procedures on the cards list. 

## 2. Sending the cards to the table (Authored by Partner)

```
(send table add-cards deck (+ mcbox-x 15) (+ mcbox-y 30))
```

This code uses table which is previously defined with a make-table, 
add-cards a racket/cards function that handles the positioning of the 
cards on the table using deck and the x and y offsets from each card.

## 3. Setup Game on Start/Reset (Authored by Partner)

```
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
```

This code resets the timer to be at 00:00 when the game is starting, shuffles the deck of cards and 
sends the shuffled cards onto the table as a stacked deck. Then when you begin playing it will
moves the cards onto the actual playing field starting at the origin of the playing field and
then using variables i and j then offsetting the i and j so that the cards are equally spaced.

## 4. Timer starter (Authored by me)

```
;; run
(define (run-timer)
  (unless start-time
    (set! start-time (current-inexact-milliseconds))
    (send time-timer start 1000 #t)))
```

This code starts the timer by usings start-time, a boolean which starts as false and 
then changing that boolean to the actual current time. time-timer is defined to create 
the object which will be passed with the time to the run-timer send.