;; Exercise 1.29

#lang scheme

(define (fast-sum term a next b next-coef)
  (define (sum-iter a s)
    (if (> a b)
        s
        (sum-iter (next a) (+ (* (next-coef a) (term a)) s))))
  (sum-iter a 0))

(define (simpsons-rule f a b n)
  (define (h) (/ (- b a) n))
  (define (add-h x) (+ x (h)))
  (define (next-coef x)
    (cond ((= x a) 1)
          ((= x b) 1)
          ((= (remainder (/ (- x a) (h)) 2) 0) 2)
          (else 4)))
  (/ (* (fast-sum f a add-h b next-coef)
        (h))
     3))

(define (cube x) (* x x x))

(simpsons-rule cube 0 1 100)
(simpsons-rule cube 0 1 1000)

;; Exercise 1.30
;;
;; see Exercise 1.29
