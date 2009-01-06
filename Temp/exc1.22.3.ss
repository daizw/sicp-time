(require (lib "19.ss" "srfi"))

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

(define (timed-prime-test n start-time)
  (newline)
  (display n)
  (start-prime-test n start-time))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (time-difference (current-time time-process) start-time))
      #f)) ; have timed-prime-test return false

(define (report-prime elapsed-time)
  (display " *** ")
  (display (time-second elapsed-time))
  (display "s ")
  (display (time-nanosecond elapsed-time))
  (display "ns")
  #t) ; have timed-prime-test return true

(define (search-for-primes start count start-time)
  (define checked-start (if (even? start) (+ 1 start) start))
  (define (iter cur count)
    (cond ((= 0 count)
           (newline)
           (display "***** FINISHED *****")
           (newline))
          ((timed-prime-test cur start-time) (iter (+ 2 cur) (- count 1)))
          (else (iter (+ 2 cur) count))))
  (iter checked-start count))

(define (s4p start-num count)
  (search-for-primes start-num count (current-time time-process)))