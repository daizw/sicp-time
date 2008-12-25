#lang scheme
(define (p a b)
  (define (dec x) (- x 1))
  (define (inc x) (+ x 1))
  (if (= a 0)
      b
      (inc (p (dec a) b))))

(define (p2 a b)
  (define (dec x) (- x 1))
  (define (inc x) (+ x 1))
  (if (= a 0)
      b
      (p2 (dec a) (inc b))))