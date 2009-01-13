#lang scheme
;; Exercise 1.37

; iterative
(define (cont-frac-i n d k)
  (define (cf-iter i frac)
    (if (< i 1)
        frac
        (cf-iter (- i 1) (/ (n i) (+ (d i) frac)))))
  (cf-iter k 0.0))

; recursive
(define (cont-frac-r n d k)
  (define (cf-r i)
    (if (> i k)
        0.0
        (/ (n i) (+ (d i) (cf-r (+ i 1))))))
  (cf-r 1))

(cont-frac-i (lambda (i) 1.0)
             (lambda (i) 1.0)
             11)
(cont-frac-r (lambda (i) 1.0)
             (lambda (i) 1.0)
             11)
(cont-frac-i (lambda (i) 1.0)
             (lambda (i) 1.0)
             12)
(cont-frac-r (lambda (i) 1.0)
             (lambda (i) 1.0)
             12)


;; Exercise 1.38

; De Fractionibus Continuis
(+ (cont-frac-i (lambda (i) 1.0) ; n
             (lambda (i)
               (if (= (remainder i 3) 2)
                   (* (/ (+ i 1) 3) 2.0)
                   1.0)) ; d
             13)
   2)