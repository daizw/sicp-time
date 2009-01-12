;; Exercise 1.33

#lang scheme
; iterative
(define (filtered-accumulate combiner null-value term a next b filter)
  (define (acc-iter cur result)
    (cond ((> cur b) result)
          ; if cur satisfy some condition
          ((filter cur) (acc-iter (next cur) (combiner (term cur) result)))
          ; else, just jump over it
          (else (acc-iter (next cur) result))))
  (acc-iter a null-value))

; a. the sum of the squares of the prime numbers in the interval a to b 
;  (assuming that you have a prime? predicate already written)
(define (prime-square-sum a b)
  (define (square x) (* x x))
  (define (next x) (+ x 1))
  (define (prime? x) #t) ; fake
  (filtered-accumulate + 0 square a next b prime?))

(prime-square-sum 5 10)
                       
; b. the product of all the positive integers less than n that are
;  relatively prime to n (i.e., all positive integers i < n
;  such that GCD(i,n) = 1).
(define (relative-prime-sum n)
  (define (identity x) x)
  (define (GCD x y) 1) ; fake
  (define (next x) (+ x 1))
  (define (relative-prime? x) (= (GCD x n) 1))
  (filtered-accumulate * 1 identity 1 next n relative-prime?))

(relative-prime-sum 10)
