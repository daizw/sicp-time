;; Exercise 1.22

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

;; checking the primality of an integer n
;; with "searching for divisors" algorithm.
(define (prime? n)
  (define (square x) (* x x))
  (define (smallest-divisor n)
    (find-divisor n 2))
  (define (find-divisor n test-divisor)
    (cond ((> (square test-divisor) n) n)
          ((divides? test-divisor n) test-divisor)
          (else (find-divisor n (+ test-divisor 1)))))
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
    (report-prime (time-difference (runtime) start-time)))
  (define (test-iter num count start-time)
    (cond ((= count 0)
           (test-report num start-time))
          ((prime? num) (test-iter num (- count 1) start-time))
          (else (test-iter num (- count 1) start-time))))
  (test-iter (search-for-primes start-num 1) times-count (runtime)))

;; Lazy Scheme果然是lazy的, 用它重新做Exercise 1.5时, 发现结果为0.
;; 所以用它做Exercise 1.22的时候, 发现elapsed time基本为0.
;;
;; 在DrSchme中设置语言为Module时, 才"正常"起来.
;; 不过测得的时间仍然很不准确(当然更不精确),
;; 程序跑了一分多钟, 测出来的时间却只有一两秒.
;;
;; 即使我写了个test函数, 用它每轮对同一个prime判断100000次,
;; 最后测得的各轮时间花费也相差巨大...
;;
;; 后来才知道问题出在:
;: (define (runtime) (current-time time-process))
;; (current-time time-process)返回的是"进程时间",
;; 即在该进程上累计用掉的"CPU时间".
;; 而(current-time)返回的是utc时间.
;; 参考:
;; http://www.gnu.org/software/guile/manual/html_node/SRFI_002d19-Time.html
;; http://panxz.blogbus.com/logs/10190959.html
;; 虽然知道问题所在, 但是仍然不知道原因...
;;
;;
