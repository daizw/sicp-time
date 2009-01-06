;; Exercise 1.25

;; 一方面效率低, 另一方面求得的幂值可能超出编译器允许的最大值.
;;
;; 原程序中expmod基于这样一个恒等式:
;; X mod m = (X^(1/2) mod m)^2 mod m
;; 证明:
;; 令 X = (am + b)^2, 其中a >= 0, 0 < b < m, 则
;; X mod m = b^2 mod m
;; (X^(1/2) mod m)^2 mod m
;;     = ((am + b) mod m)^2 mod m
;;     = b^2 mod m = X mod m


;; Exercise 1.26

;; 如果解释器采用应用序,
;; 则原程序每次递归只需要执行一次(expmod base (/ exp 2) m);
;; 而Louis的程序中每次递归会执行两次(expmod base (/ exp 2) m).
;; 代价是原来的两倍, 经过logn次的递归,
;; 代价为Θ(2^logn) = Θ(n) 
