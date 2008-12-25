#lang scheme
(define (sqrt x)
  (sqrt-iter 1.0 0.1 x))

(define (sqrt-iter guess last-guess x)
  (if (good-enough? guess last-guess) guess
      (sqrt-iter (improve guess x) guess x)))

(define (good-enough? guess last-guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.01))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))