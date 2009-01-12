#lang scheme

(define (normal-sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (normal-sum term (next a) next b))))

(define (fast-sum term a next b)
  (define (sum-iter term a next b s)
    (if (> a b)
        s
        (sum-iter term (next a) next b (+ (term a) s))))
  (sum-iter term a next b 0))

(define (sum-integers a b sum)
  (define (identity x) x)
  (sum identity a inc b))

(define (inc n) (+ n 1))
(define (cube x) (* x x x))  

(define (sum-cubes a b sum)
  (sum cube a inc b))

(define (pi-sum a b sum)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term a pi-next b))

(define (integral f a b dx sum)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(sum-integers 1 10 normal-sum)
(sum-cubes 1 10 normal-sum)
(* 8 (pi-sum 1 1000000 normal-sum))
(integral cube 0 1 0.0001 normal-sum)
(integral cube 0 1 0.00001 normal-sum)

(sum-integers 1 10 fast-sum)
(sum-cubes 1 10 fast-sum)
(* 8 (pi-sum 1 1000000 fast-sum))
(integral cube 0 1 0.0001 fast-sum)
(integral cube 0 1 0.00001 fast-sum)
(integral cube 0 1 0.0000001 fast-sum)