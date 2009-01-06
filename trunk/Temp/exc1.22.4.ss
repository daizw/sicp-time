#lang scheme
(require (lib "19.ss" "srfi"))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))
(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime-verbose (runtime) start-time)
      (report-prime (time-difference (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " xxx ")
  (display elapsed-time))

(define (report-prime-brief elapsed-time)
  (display " *** ")
  (display (time-second elapsed-time))
  (display "s ")
  (display (time-nanosecond elapsed-time))
  (display "ns"))

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
  (display te))



(define (square x) (* x x))
(define (smallest-divisor n)
  (find-divisor n 2))
(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b)
  (= (remainder b a) 0))
(define (prime? n)
  (= n (smallest-divisor n)))

(define (runtime) (current-time time-process))

