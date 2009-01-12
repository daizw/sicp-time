;; Exercise 1.32

#lang scheme
; iterative
(define (accumulate-i combiner null-value term a next b)
  (define (acc-iter cur result)
    (if (> cur b)
        result
        (acc-iter (next cur) (combiner (term cur) result))))
  (acc-iter a null-value))

; recursive
(define (accumulate-r combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a) (accumulate-r combiner null-value term (next a) next b))))

(define (pi-product b accumulate-process)
  (define (square x) (* x x))
  (define (calc x) (/ (- x 1) x))
  (define (term x)
    (calc (square x)))
  (define (next x) (+ x 2))
  (* (accumulate-process * 1.0 term 3 next b) 4))

(pi-product 1000000 accumulate-i)
(pi-product 1000000 accumulate-r)
