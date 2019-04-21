#lang racket

;cw1

(define (make-rat n d)
    (let ((c (gcd n d)))
    (list (/ n c) (/ d c))))

(define (rat-num x)
  (first x))

(define (rat-denum x)
  (second x))

(define (rat? x)
  (and (list? x)
       (= 2 (length x))
       (not (= 0 (rat-denum x)))
       (= 1 (gcd (rat-num x) (rat-denum x)))))

;cw2

(define (make-point x y)
  (cons x y))

(define (point-x p)
  (car p))

(define (point-y p)
  (cdr p))

(define (point? p)
  (pair? p))

(define (make-vect a b)
  (cons a b))

(define (vect-begin v)
  (car v))

(define (vect-end v)
  (cdr v))

(define (vect? v)
  (and (pair? v)
       (and (point? (vect-begin v)) (point? (vect-end v)))))

( define ( display-point p )
( display "(")
( display ( point-x p ) )
( display ", ")
( display ( point-y p ) )
( display ")") )

( define ( display-vect v )
( display "[")
( display-point ( vect-begin v ) )
( display ", ")
( display-point ( vect-end v ) )
( display "]") )

(define (vect-length v)
  (let ([a (abs (- (point-x (vect-begin v)) (point-x (vect-end v))))]
        [b (abs (- (point-y (vect-begin v)) (point-y (vect-end v))))])
    (sqrt (+ (* a a) (* b b)))))

(define (vect-scale v k)
  (make-vect (vect-begin v) (make-point (* k (point-x (vect-end v)))
                                        (* k (point-y (vect-end v))))))

(define (vect-translate v p)
  (let ([a (+ (point-x (vect-begin v)) (point-x (vect-end v)))]
        [b (+ (point-y (vect-begin v)) (point-y (vect-end v)))])
    (make-vect p (make-point (+ a (point-x p)) (+ b (point-y p))))))

;cw3

(define (vect3 p dir len)
  (list p dir len))

(define (v3-p v)
  (first v))

(define (v3-dir v)
  (second v))

(define (v3-len v)
  (third v))

(define (vect3? v)
  (and (list? v)
       (= 3 (length v))
       (point? (v3-p v))))

(define (v3-length v)
  (v3-len v))

(define (v3-scale v k)
  (vect3 (v3-p v) (v3-dir v) (* k (v3-len v))))

(define (v3-translate v p)
  (vect3 p (v3-dir v) (v3-len v)))

;cw4

(define (rev-iter l)
  (define (iter l res)
    (if (null? l)
        res
        (iter (cdr l) (cons (car l) res))))
  (iter l null))

(define (rev-rec l)
  (if (null? l)
      null
      (append (rev-rec (cdr l)) (list (car l)))))

;cw5

(define (insert n xs)
  (cond
    [(null? xs) (cons n null)]
    [(<= n (car xs)) (cons n xs)]
    [else (cons (car xs) (insert n (cdr xs)))]))

;cw6

(define (add-head v l)
  (define (rek front tail)
    (if (null? tail)
        (cons (append front v) null)
        (cons (append front v tail) (rek (append front (list (car tail))) (cdr tail)))))
  (apply append (map (lambda (x) (rek '() x)) l)))
  

(define (permi s)
  (if (null? s)
      (list null)
      (add-head (list (car s)) (permi (cdr s)))))

;cw 9

(define (append2 . l)
  (if (null? l)
      null
      (append (car l) (apply append2 (cdr l)))))






