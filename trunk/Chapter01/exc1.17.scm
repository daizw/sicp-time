#lang scheme
;;Exercise 1.17

(define (even? x) (= (remainder x 2) 0))
(define (double x) (+ x x))
(define (halve x) (/ x 2))

;; linear
(define (m a b)
  (define (m-iter a b c)
    (cond ((or (= a 0) (= b 0)) c)
          (else (m-iter a (- b 1) (+ c a)))))
  (m-iter a b 0))

;; logarithmic
(define (fm a b)
  (define (fm-iter a b c)
    (cond ((or (= a 0) (= b 0)) c)
          ((even? b) (fm-iter (double a) (halve b) c))
          (else (fm-iter (double a) (halve (- b 1)) (+ a c)))))
  (fm-iter a b 0))

;; test case
(define (test a b)
  (= (m a b) (fm a b)))

;; test suite
(define (ts ma mb)
  (define (ts-iter a b ma mb)
    (cond ((> b mb) #t)
          ((> a ma) (ts-iter 0 (+ b 1) ma mb))
          ((test a b) (ts-iter (+ a 1) b ma mb))
          (else #f)))
  (ts-iter 0 0 ma mb))
