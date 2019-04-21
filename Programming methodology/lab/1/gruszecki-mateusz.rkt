#lang racket
(define (cube-root x)
  (define (cube x)
    (* x x x))
  (define (dist x y)
    (abs (- x y)))
  (define (improve approx)
    (/ (+ (/ x (* approx approx)) (* approx 2)) 3))
  (define (good-enough? approx)
    (< (/ (dist x (cube approx)) (abs x)) 0.000001)) 
  (define (iter approx)
    (cond
      [(= x 0) 0]
      [(good-enough? approx) approx]
      [else (iter (improve approx))]))
  (iter 1.0))

;testy:
> (cube-root 8)
2.000000000012062
> (cube-root -8)
-2.0
> (cube-root 0)
0
> (cube-root -0.002)
-0.12599211887826087
> (cube-root 25346346678)
2937.458900645712
> (cube-root 1)
1.0
> 