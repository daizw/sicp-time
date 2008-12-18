;; Exercise 1.9

;: (define (+ a b)
;:   (if (= a 0)
;:     b
;:     (inc (+ (dec a) b))))
;;
;; recursive. process:
;; (+ 4 5)
;; (inc (+ (dec 4) 5))
;; (inc (+ 3 5))
;; (inc (inc (+ 2 5)))
;; (inc (inc (inc (+ 1 5))))
;; (inc (inc (inc (inc (+ 0 5)))))
;; (inc (inc (inc (inc 5))))
;; (inc (inc (inc 6)))
;; (inc (inc 7))
;; (inc 8)
;; 9
;; 
;: (define (+ a b)
;:   (if (= a 0)
;:     b
;:     (+ (dec a) (inc b))))
;; 
;; iterative. process:
;; (+ 4 5)
;; (+ (dec 4) (inc 5))
;; (+ 3 6)
;; (+ (dec 3) (inc 6))
;; (+ 2 7)
;; (+ (dec 2) (inc 7))
;; (+ 1 8)
;; (+ (dec 1) (inc 8))
;; (+ 0 9)
;; 9
;; 

;; Exercise 1.10

;; 1024
;; 65536
;; 65536
;;
;; (f n) computes 2n
;; (g n) computes 2^n
;; (h n) computes 2^(2^(2^(...2^(2^2)))), 共n个2, 包括底数与指数
;;
;;; (A n 2) = 4
;;; (A 3 4) = (A 4 3) = (h 65536)
