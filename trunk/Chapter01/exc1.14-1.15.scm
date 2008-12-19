;; Exercise 1.14

;; The space required grows as Θ(n);
;; and the steps required grows as Θ(n^5).
;; 证明时间复杂度:
;; 对于种类数为k = 1的情况, 令f(n)表示程序步数,
;; 则 f(n) = Θ(2n) = Θ(n)
;; k = 2时, 令g(n)表示程序步数,
;; 则 g(n) = f(n) + g(n-5)
;;         = f(n) + f(n-5) + g(n-5*2)
;;         = ...
;;         = n/5 * Θ(n) + Θ(1)
;;         = Θ(n^2)
;; k = 3时, 令h(n)表示程序步数,
;; 则 h(n) = g(n) + h(n-10)
;;         = g(n) + g(n-10) + h(n-10*2)
;;         = ...
;;         = n/10 * Θ(n^2) + Θ(1)
;;         = Θ(n^3)
;; 依此类推, 可知 k = 5时, 程序步数为Θ(n^5)

;; Exercise 1.15

;; a. 5 times. (12.15 = 0.05*3^5)
;; b. space: Θ(log a)
;;    steps: Θ(log a)
