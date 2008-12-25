#lang scheme
(define (crt x)
  (crt-iter 1.0 0.1 x))

(define (crt-iter guess last-guess x)
  (if (good-enough? guess last-guess) guess
      (crt-iter (improve guess x) guess x)))

(define (good-enough? guess last-guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.000001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

(define (square x) (* x x))
(define (square2 x)
  (exp (double (log x))))
(define (double x) (+ x x))