#lang scheme
;; Exercise 1.16

(define (square x) (* x x))
(define (even? x) (= (remainder x 2) 0))

;; b^n = (b^2)^(n/2)
(define (faster-expt b n)
  (fe-iter 1 b n))
(define (fe-iter a b n)
  (cond ((= n 0) a)
        ((or (= a 0) (= b 0)) 0)
        ((even? n) (fe-iter a (square b) (/ n 2)))
        (else (fe-iter (* a b) (square b) (/ (- n 1) 2)))))

;; b^n = (b^(n/2))^2
(define (fast-expt b n)
  (cond ((= n 0) 1)
        ((even? n) (square (fast-expt b (/ n 2))))
        (else (* b (fast-expt b (- n 1))))))

;; test case
(define (test b n)
  (cond ((< n 0) #t)
        ((= (faster-expt b n) (fast-expt b n)) (test b (- n 1)))
        (else #f)))
;; test suite
(define (test235 n)
  (and (test 2 n) (test 3 n) (test 5 n)))
(define (ts list n)
  (map (lambda (b) (test b n)) list))
;; Why? Why?? Why?!
;: (define (ts2 list n)
;:  (apply and (map (lambda (b) (test b n)) list)))
  

