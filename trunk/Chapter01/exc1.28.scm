;; Exercise 1.28

#lang scheme

(define (miller-rabin-full-test n)
  (define (square x) (* x x))
  (define (check-square x m)
    (if (and (not (= x 1)) (not (= x (- n 1))))
        (if (= (remainder (square x) m) 1)
            0 ;if x is not 1 or (n-1),
              ; and is a nontrivial square root of 1 modulo n,
              ;then return 0
            (square x))
        (square x))) ; or just return 1
  (define (expmod base exp m)
    (cond ((= exp 0) 1)
          ((even? exp)
           (remainder (check-square (expmod base (/ exp 2) m) m)
                      m))
          (else
           (remainder (* base (expmod base (- exp 1) m))
                      m))))
  (define (try-it a)
    (= (expmod a (- n 1) n) 1))
  
  (define (ft-iter a)
    ;(newline)
    ;(display a)
    (cond ((> a (cond ((even? n) (/ n 2))
                       (else (/ (- n 1) 2)))) #t)
          ((try-it a) (ft-iter (+ a 1)))
          (else #f)))
  
  (ft-iter 2))


;
; test
;
(display "normal\n")
(miller-rabin-full-test 2)
(miller-rabin-full-test 3)
(miller-rabin-full-test 4)
(miller-rabin-full-test 5)
(miller-rabin-full-test 6)
(miller-rabin-full-test 7)
(miller-rabin-full-test 8)
(miller-rabin-full-test 9)
(miller-rabin-full-test 10)
(miller-rabin-full-test 11)
(miller-rabin-full-test 121) ;#f
(miller-rabin-full-test 131) ;#t
; Camicheal Numbers
(display "Camicheal Numbers\n")
(miller-rabin-full-test 5610)
(miller-rabin-full-test 1105)
(miller-rabin-full-test 1729)
(miller-rabin-full-test 2465)
(miller-rabin-full-test 2821)
(miller-rabin-full-test 6601)
; Big Prime Numbers
(display "Big Prime Numbers\n")
(miller-rabin-full-test 100019)
(miller-rabin-full-test 100043)
(miller-rabin-full-test 1000033)


;; 因为 if n is an odd number that is not prime,
;; then, for at least half the numbers a<n,
;; computing a^(n-1) in this way will reveal
;; a nontrivial square root of 1 modulo n.
;; 所以这里只测试了一半的数字, 即 1 < a <= n/2.
;; 注意: a = 4的时候.
;;
;;
;; 在我机器上每秒钟大约可以测试30K个数,
;; 所以对于100万左右及以下的数字测试时间能够保持在一分钟以内.
;;
