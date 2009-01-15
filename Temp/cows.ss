#lang scheme
(define (cows y)
  (define (cow-iter y1 y2 y3 count)
    (newline)
    (display y3)
    (if (> count y)
        y3
        (cow-iter y2 y3 (+ y1 y3) (+ count 1))))
  (cow-iter 1 1 1 4))

(cows 10)
(cows 100)