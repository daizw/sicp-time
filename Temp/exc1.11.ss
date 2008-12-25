#lang scheme
;; recursive
(define (f n)
  (if (< n 3) n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))
;; iterative
(define (f2 n) (f-iter 2 1 0 n))
(define (f-iter x y z n)
  (cond ((= n 2) x)
        ((= n 1) y)
        ((= n 0) z)
        (else (f-iter (+ x (* 2 y) (* 3 z)) x y (- n 1)))))
;; test-case
(define (test n)
  (test-iter 0 n))
(define (test-iter x count)
  (cond ((< count 0) #t)
        ((= (f x) (f2 x)) (test-iter (+ x 1) (- count 1)))
        (else #f)))