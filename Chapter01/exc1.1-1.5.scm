;; Exercise 1.1

10
12
8
3
6
19
#f
4
16
6
16

;; Exercise 1.2

(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 1 3))))) (* 3 (- 6 2) (- 2 7)))

;; Exercise 1.3

(define (square x) (* x x))
(define (poly x y) (+ (square x) (square y)))
(define (fun x y z)
     (if (< x y) (if (< x z) (poly y z)
                   (poly x y))
       (if (> y z) (poly x y)
         (poly x z))
       ))
;: (define (fun2 x y z)
(fun 3 4 5)

;; Exercise 1.4
;; (略)

;; Exercise 1.5

;; 如果解释器采用正则序(normal order), 解释过程为:
;: (test 0 (p))
;; =>
;: (if (= 0 0)
;:     0
;:     (p))
;; =>
;: (if #t
;:     0
;:     (p))
;; =>
;: 0
;; 如果采用应用序(applicative order), 解释过程为:
;: (test 0 (p))
;; =>
;: (test 0 (p))
;; =>
;: (test 0 (p))
;; => ...(死循环)
;; 
;; 所以说正则序是lazy的, 需要的时候才真正去求值;
;; 而应用序则不同, "evaluate the arguments and then apply",
;; 在'应用'到if语句之前, 会先对test的两个参数进行求值,
;; 在对第二个参数(p)求值时陷入死循环.
;; p 是一个procedure, 而(p)是p的返回值;
;; 又因为p的定义是其自身, 从而导致在求其返回值时陷入死循环.
;; ==>有时还是看看原文才能更明白
