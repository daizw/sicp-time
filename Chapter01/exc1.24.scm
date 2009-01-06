;; Exercise 1.24

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

;; 首先, 计算幂并取模(求余)的操作应该比仅仅求余的代价要大得多.
;; 所以, 如果执行Fermat测试的次数如果为(n-2)即对所有小于n的a都测试一遍的话,
;; 其代价肯定比测试minimal divisor(不妨称之为MDT)要大得多.
;; 其次, 通过执行费马检查来判断素数的算法(不妨称之为FT)的执行代价与检查次数
;; 成正比, 所以FT的复杂度很大程度上依赖于检查的次数.
;;
;; 对于较小的数, FT甚至不如MDT快(Fermat test次数取10,
;; MDT程序使用exercise1.23中的程序), 例如:
;; FT:
;; > (test 1000 10000)
;; 
;; 1001
;; 1003
;; 1005
;; 1007
;; 1009 *** 0s 0ns
;;  ****** DONE ****** 
;; Test report:
;; Tested number 1009 for 10000 times, elapsed time:  *** 1s 5000000ns
;; #(struct:tm:time time-duration 5000000 1)
;;  start time: #(struct:tm:time time-utc 4940000 1231231915)
;;  end time: #(struct:tm:time time-utc 9940000 1231231916)#t
;;
;; MDT:
;; > (test 1000 10000)
;; 
;; 1001
;; 1003
;; 1005
;; 1007
;; 1009 *** 0s 0ns
;;  ****** DONE ****** 
;; Test report:
;; Tested number 1009 for 10000 times, elapsed time:  *** 0s 1410000ns
;; #(struct:tm:time time-duration 1410000 0)
;;  start time: #(struct:tm:time time-utc 600000 1231232821)
;;  end time: #(struct:tm:time time-utc 2010000 1231232821)#t
;; 
;; 而对于较大的数, 则情况正好相反:
;; FT:
;; > (test 100000000 10000)
;; 
;; 100000001
;; 100000003
;; 100000005
;; 100000007 *** 0s 0ns
;;  ****** DONE ****** 
;; Test report:
;; Tested number 100000007 for 10000 times, elapsed time:  *** 9s 1250000ns
;; #(struct:tm:time time-duration 1250000 9)
;;  start time: #(struct:tm:time time-utc 1130000 1231234542)
;;  end time: #(struct:tm:time time-utc 2380000 1231234551)#t
;;  
;; MDT:
;; > (test 100000000 10000)
;; 
;; 100000001
;; 100000003
;; 100000005
;; 100000007 *** 0s 160000ns
;;  ****** DONE ****** 
;; Test report:
;; Tested number 100000007 for 10000 times, elapsed time:  *** 43s 997310000ns
;; #(struct:tm:time time-duration 997310000 43)
;;  start time: #(struct:tm:time time-utc 6210000 1231234449)
;;  end time: #(struct:tm:time time-utc 3520000 1231234493)#t
;; 
;; 所以总的来说, fast-prime的性能究竟比prime如何,
;; 一方面依赖于FT的检查次数和数的平方根的大小(即MDT的次数)之比,
;; 另一方面依赖于每次FT的代价与每次MDT的代价大小之比.
;; ......这么说有点像废话了.
