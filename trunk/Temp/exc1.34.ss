#lang scheme
(define (f g)
  (g 2))
(define (square x) (* x x))

;> (f f)
;procedure application: expected procedure, given: 2; arguments were: 2
;> 