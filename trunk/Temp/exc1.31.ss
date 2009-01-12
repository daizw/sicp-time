#lang scheme
;; iterative
(define (product term a next b)
  (define (iter x p)
    (if (> x b)
        p
        (iter (next x) (* (term x) p))))
  (iter a 1.0)) ; try 1, not 1.0
;; recursive
(define (product-rec term a next b)
  (if (> a b)
      1.0 ; try 1, not 1.0
      (* (term a) (product-rec term (next a) next b))))

(define (pi-product b product-process)
  (define (square x) (* x x))
  (define (calc x) (/ (- x 1) x))
  (define (term x)
    (calc (square x)))
  (define (next x) (+ x 2))
  (* (product-process term 3 next b) 4))

(pi-product 1000000 product)
(pi-product 1000000 product-rec)