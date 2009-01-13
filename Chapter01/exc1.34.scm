#lang scheme
;; Exercise 1.34

(define (f g)
  (g 2))
(define (square x) (* x x))

;; 运行结果:
;> (f f)
;. . procedure application: expected procedure, given: 2; arguments were: 2
;> 

;; 过程:
;; (f f) =>
;; (f 2) =>
;; (2 2)
