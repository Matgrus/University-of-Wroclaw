#lang racket

(define (nth-root a b)
   (fix-point (repeated (average-damp (lambda (y) (/ b (expt y (- a 1))))) (floor ( log a 2))) 1.0))

(define (sqrt-ad u x)
  (fix-point (average-damp (lambda (y) (/ x (expt y (- u 1))))) 1.0))

(define (dist x y)
    (abs (- x y)))
(define (close-enough? x y)
    (< (dist x y) 0.0000000001))
(define (fix-point f x0)
    (let ((x1 (f x0)))
    (if (close-enough? x0 x1)
      x0
      (fix-point f x1))))
(define (average-damp f)
    (lambda (x) (/ (+ x (f x)) 2)))
(define (repeated p n)
    (define (compose f g)
      (lambda (x) (f (g x))))
    (if (= n 0)
      (lambda (x) x)
      (compose p (repeated p (- n 1)))))

(nth-root 1 4)
(nth-root 2 1024)
(nth-root 3 27)
(nth-root 4 16)
(nth-root 3 -64)

;ponizej testy które wykonywałem. Za każdym razem, gdy nie można było obliczyć pierwiastka danego stopnia stosowałem dodatkowe tłumienie
;Wynika z nich, że dla pierwiastka n-tego stopnia trzeba tłumić funkcję log 2 z n razy

(sqrt-ad 2 256)
(sqrt-ad 3 256)
(sqrt-ad 4 256)
(sqrt-ad 5 256)
(sqrt-ad 6 256)
(sqrt-ad 7 256)
(sqrt-ad 8 256)
(sqrt-ad 9 256)
(sqrt-ad 12 256)
(sqrt-ad 16 256)