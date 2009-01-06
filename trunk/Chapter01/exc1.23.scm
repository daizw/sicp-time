;; Exercise 1.23

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
(define (prime? n)
  (define (square x) (* x x))
  (define (next div)
    (cond ((= div 2) 3)
          (else (+ div 2))))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (next test-divisor)))))
  (define (divides? a b)
    (= (remainder b a) 0))
  (= n (smallest-divisor n)))

(define (runtime) (current-time))

(define (timed-prime-test n)
  (define (start-prime-test n start-time)
    (newline)
    (display n)
    (if (prime? n)
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
          ((prime? num) (test-iter num (- count 1) start-time))
          (else (test-iter num (- count 1) start-time))))
  (test-iter (search-for-primes start-num 1) times-count (runtime)))

;; 测试结果不太稳定,
;; 开始时:
;; > (test 100000000 1000)
;; 
;; 100000001
;; 100000003
;; 100000005
;; 100000007 *** 0s 150000ns
;;  ****** DONE ****** 
;; Test report:
;; Tested number 100000007 for 1000 times, elapsed time:  *** 3s 999690000ns
;; #(struct:tm:time time-duration 999690000 3)
;;  start time: #(struct:tm:time time-utc 8070000 1231227615)
;;  end time: #(struct:tm:time time-utc 7760000 1231227619)#t
;; 
;; 而使用Exercise 1.22的程序跑出来大约是6s, 也就是说新版本快了大约 1/3.
;; 但是过一段时间后再测, 发现新版本快了约 1/2, 有时甚至更多.
;; 理论上讲, 新版本快大约 1/3 的结果是比较靠谱的, 因为新版本虽然少判断了一半的除数, 但是也增加了"过程调用"和判断是否等于2的开销.
;; 应该和测试使用的数字也有关系.
;; 使用(test 10000 100000)测试, 发现结果如下:
;; 新版本: 4s 470000ns
;; 旧版本: 7s 780000ns
;; 减少了大约40%的运行时间.
