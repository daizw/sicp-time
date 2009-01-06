#lang scheme

(define (fermat-full-test n)
  (define (square x) (* x x))
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))
  (define (try-it a)
      (= (expmod a n n) a))
  
  (define (ft-iter a)
    (cond ((>= a n) #t)
          ((try-it a) (ft-iter (+ a 1)))
          (else #f)))
  
  (ft-iter 2))