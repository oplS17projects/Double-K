# Double-K

## Seokhwan Ko
### April 30, 2017

# Overview
This matching card game helps people to improve their memory ability.
First, user chooses 2 cards randomly. Then, if the cards are matched, those are terminated, otherwise they are flipped again.


# Libraries Used
The code uses three libraries:

```
(require games/cards)
(require racket/gui)
(require racket/class)
```
* The ```games/cards``` library provides the specific activation of cards.
* The ```racket/gui``` library is used to overall background window.
* The ```racket/class``` library is used to control each object.

# Key Code Excerpts


## 1. Define main table

The following code creates a main table, ```table``` which is main window table for this program.

```
;; layout
(define WIDTH 5)
(define HEIGHT 4)
(define MAX-MATCHES (/ (* WIDTH HEIGHT) 2))

;; Set up the table
(define table (make-table "Double-K" (+ 4 WIDTH) (+ 2 HEIGHT)))
(send table show #t)
(send table set-double-click-action #f)

;; random card
(random-seed (modulo (current-milliseconds) 9999))
 ```
It defines size of the table and max value of match count.



## 2. Setup cards in the DECK

The following code creates a deck, ```deck``` which brings card images from the image directory and copy each card in the list.

```
(define deck
  ;; load 10 cards from the image directory
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
    ;; copy the each card of the list
    (append cards
            (map (lambda (c) (send c copy)) cards)
            )
    )
  )
 ```
It loads 10 cards first and then uses ```map``` to duplicate each card.
