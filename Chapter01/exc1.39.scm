#lang scheme
;; Exercise 1.39

; Lambert's formula
(define (tan-cf x k)
  (define (tcf-iter n d i frac)
    (if (< i 1)
        frac
        (tcf-iter n d (- i 1) (/ (n i) (- (d i) frac)))))
  (tcf-iter (lambda (i)
              (if (= i 1)
                  x
                  (* x x)))
            (lambda (i)
              (- (* i 2) 1))
            k
            0.0))

(tan-cf 0.7864816 100000)