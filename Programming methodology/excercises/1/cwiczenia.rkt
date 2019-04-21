#lang racket
(define (cube a b c)
  (cond
    [(> a b) (+ (* a a) (if (> b c)
                            (* b b)
                            (* c c)))]
    [(> a c) (+ (* b b) (* a a))]
    [else (+ (* b b) (* c c))]))

(define (absol a b)
  ((if (> b 0) + -) a b))

(define (pct b n)
  (define (help b n r)
    (cond
      [(> b n) 1]
      [(< n 1) 0]
      [else (+ 1 (help (* b r) n r))]))
  (help b n b))

(define (pct2 b n)
  (define (help b n res)
    (if (> (expt b res) n) res (help b n (+ 1 res))))
  (help b n 0))

    