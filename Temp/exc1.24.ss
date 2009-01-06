#lang scheme
(require (lib "19.ss" "srfi"))

;; report prime and the time spent
(define (report-prime elapsed-time)
  (display " *** ")
  (display (time-second elapsed-time))
  (display "s ")
  (display (time-nanosecond elapsed-time))
  (display "ns")
  #t)
(define (report-prime-verbose te ts)
  (display " *** ")
  (display (time-second (time-difference te ts)))
  (display "s ")
  (display (time-nanosecond (time-difference te ts)))
  (display "ns")
  (newline)
  (display (time-difference te ts))
  (newline)
  (display " start time: ")
  (display ts)
  (newline)
  (display " end time: ")
  (display te)
  #t)

;; checking the primality of an integer n
;; with "searching for divisors" algorithm.
(define (fast-prime? n times)
  (define (square x) (* x x))
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (square (expmod base (/ exp 2) m))
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))
  (define (fermat-test n)
    (define (try-it a)
      (= (expmod a n n) a))
    (try-it (+ 1 (random (- n 1)))))
  
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

(define (runtime) (current-time))

(define (timed-prime-test n)
  (define (start-prime-test n start-time)
    (newline)
    (display n)
    (if (fast-prime? n 10)
        (report-prime (time-difference (runtime) start-time))
        #f))
  (start-prime-test n (runtime)))

(define (search-for-primes start-num prime-count)
  ;; even or not
  (define (even?)
    (= (remainder start-num 2) 0))
  ;; make sure start num is odd
  (define (check-start-num)
    (if (even?) (+ start-num 1) start-num))
  ;; iterator
  (define (search-iter cur count)
    (cond ((= count 0) (newline) (display " ****** DONE ****** ") (- cur 2))
          ((timed-prime-test cur) (search-iter (+ cur 2) (- count 1)))
          (else (search-iter (+ cur 2) count))))
  
  (search-iter (check-start-num) prime-count))

;; test-suite
;; find the smallest prime larger than start-num,
;; then test it times-count times,
;; and report the total elapsed time.
(define (test start-num times-count)
  (define (test-report num start-time)
    (newline)
    (display "Test report:")
    (newline)
    (display "Tested number ")
    (display num)
    (display " for ")
    (display times-count)
    (display " times, elapsed time: ")
    ;(report-prime (time-difference (runtime) start-time)))
    (report-prime-verbose (runtime) start-time))
  (define (test-iter num count start-time)
    (cond ((= count 0)
           (test-report num start-time))
          ((fast-prime? num 10) (test-iter num (- count 1) start-time))
          (else (test-iter num (- count 1) start-time))))
  (test-iter (search-for-primes start-num 1) times-count (runtime)))
