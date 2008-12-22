;; Exercise 1.20

;; normal-order: 18 remainder operations
;; applicative-order: 4 remainder operations
;;
;; normal-order evaluation process:
;; 206, 40
;; 40 = 0 <==> #f
;; ==> 40, r(206, 40)
;; Let r1 = r(206, 40) = 6,
;; r1 = 0 <==> #f ; count = 1
;; ==> r1, r(40, r1)
;; Let r2 = r(40, r1) = 4,
;; r2 = 0 <==> #f ; count = 1 + 2
;; ==> r2, r(r1, r2)
;; Let r3 = r(r1, r2) = 2,
;; r3 = 0 <==> #f ; count = 1 + 2 + 4
;; ==> r3, r(r2, r3)
;; Let r4 = r(r2, r3) = 0,
;; r4 = 0 <==> #t ; count = 1 + 2 + 4 + 7
;; ==> r3
;; ==> 2 ; count = 1 + 2 + 4 + 7 + 4
;;
;; count = 18
;;
;; R_n数列类似Fibonacci数列,
;; R_1 = 1, R_2 = 2 (= R_1 + 1),
;; R_n = (R_(n-1) + R_(n-2)) + 1,
;; 数列前几项:
;; (0) 1 2 4 7 12 20 33 54 ...
;; 可以看出增长速度是指数级的.
;;
;; 所以, 如果解释器使用正则序(normal-order),
;; 那么欧几里德算法实际执行起来的时间复杂度为
;; Θ(n)(猜测)
;;
