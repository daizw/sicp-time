#lang scheme
(require (lib "19.ss" "srfi"))

; test if n is prime
; print the time consumed
; evaluated to #t if n is prime
; #f if not
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (current-time)))
; evaluated to #t if n is prime
; #f if not
(define (start-prime-test n start-time)
  (and (repeat prime? (list n) 1000 #f)
       (report-prime (time-difference (current-time) start-time)))) 
; evaluated to #t
(define (report-prime elapsed-time)
  (display " *** ")
  (display (time-second elapsed-time))
  (display "s ")
  (display (time-nanosecond elapsed-time))
  (display "ns")
  #t)

; gives the smallest divisor of an integer
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (sqr test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

; search for primes starting from the lower bound
; until certain primes are found
(define (search-for-primes number count)
  (cond ((= count 0) (void))
        ; skip it if the starting number is even
        ((even? number) (search-for-primes (+ number 1) count))
        ; prime found
        ((timed-prime-test number) (search-for-primes (+ number 2) (- count 1)))
        ; not prime
        (else (search-for-primes (+ number 2) count))))

(define (repeat f args count value)
  (cond ((<= count 0) value)
        (else (repeat f args (- count 1) (apply f args)))))