;; Exercise 1.6

;; 与Exc1.5类似, 因为解释器采用应用序, 导致
;; sqrt-iter在"应用"new-if的参数之前, 对其三个参数进行了计算, 
;; 其中在计算第三个参数时总是调用sqrt-iter自身, 
;; 不满足递归算法的必要条件之一: 要有递归的终止条件,
;; 从而陷入死循环.
;; 
;; 如果将new-if语句直接改为cond语句, 而不是采用定义过程的方式,
;; 则可以避免这种情况的发生.

;; Exercise 1.7

(define (sqrt x)
  (sqrt-iter 1.0 0.1 x))

(define (sqrt-iter guess last-guess x)
  (if (good-enough? guess last-guess) guess
      (sqrt-iter (improve guess x) guess x)))

(define (good-enough? guess last-guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.01))

(define (improve guess x)
  (average guess (/ x guess)))

(define (average x y)
  (/ (+ x y) 2))

;; Exercise 1.8

(define (crt x)
  (crt-iter 1.0 0.1 x))

(define (crt-iter guess last-guess x)
  (if (good-enough? guess last-guess) guess
      (crt-iter (improve guess x) guess x)))

(define (good-enough? guess last-guess)
  (< (abs (/ (- guess last-guess) last-guess)) 0.00001))

(define (improve guess x)
  (/ (+ (/ x (* guess guess)) (* 2 guess)) 3))

