;; Exercise 1.11

;; recursive
(define (f n)
  (if (< n 3) n
      (+ (f (- n 1))
         (* 2 (f (- n 2)))
         (* 3 (f (- n 3))))))
;; iterative
(define (f2 n) (f-iter 2 1 0 n))
(define (f-iter x y z n)
  (cond ((= n 2) x)
        ((= n 1) y)
        ((= n 0) z)
        (else (f-iter (+ x (* 2 y) (* 3 z)) x y (- n 1)))))
;; test-case
(define (test n)
  (test-iter 0 n))
(define (test-iter x count)
  (cond ((< count 0) #t)
        ((= (f x) (f2 x)) (test-iter (+ x 1) (- count 1)))
        (else #f)))

;; Exercise 1.12

;; recursive
(define (pascal r c)
  (cond ((> c r) -1)
        ((= c 1) 1)
        ((= c r) 1)
        (else (+ (pascal (- r 1) (- c 1))
                 (pascal (- r 1) c)))))

;; Exercise 1.13

;; 令Psi = (1-sqrt(5))/2,
;; 因为Phi = (1+sqrt(5))/2, 所以
;; Fib(0) = 0 = (Phi^0 - Psi^0)/sqrt(5)
;; Fib(1) = 1 = (Phi^1 - Psi^1)/sqrt(5)
;; 现在证Fib(n) = (Phi^n - Psi^n)/sqrt(5),
;; 使用数学归纳法: 对于 k >= 2,
;; 假设当 n = k-1, n = k-2时等式均成立, 那么当n = k时,
;; Fib(k) = Fib(k-1) + Fib(k-2)
;;        = (Phi^(k-1) - Psi^(k-1))/sqrt(5)
;;          + (Phi^(k-2) - Psi^(k-2))/sqrt(5)
;;        = (Phi^(k-2)*(Phi+1) - Psi^(k-2)*(Psi+1))/sqrt(5)
;;        = (Phi^k - Psi^k)/sqrt(5)
;; 等式也成立, 结论得证.
;; 现在证Fib(n)是最接近Phi^n/sqrt(5)的正整数,
;; 即证 |Fib(n) - Phi^n/sqrt(5)| <= 1/2
;; <==> |Psi^n/sqrt(5)| <= 1/2
;; <==> ((sqrt(5)-1)/2)^n <= sqrt(5)/2
;; 因为 0 < (sqrt(5)-1)/2 < 1,
;; 所以对于正整数n, 不等式左项始终小于1,
;; 右项 sqrt(5)/2 > 1,
;; 所以不等式成立, 即Fib(n)是最接近Phi^n/sqrt(5)的正整数.
;; 
