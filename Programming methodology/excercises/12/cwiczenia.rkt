#lang racket


;cw1

(define/contract (suffixes xs)
  (let ([a (new-∀/c 'a)])
    (-> (listof a) (listof (listof a))))
  (if (null? xs)
      null
      (cons (cdr xs) (suffixes (cdr xs)))))

;cw2

(define/contract (dist x y)
  (-> number? number? number?)
  (abs (- x y)))

(define/contract (average x y)
  (-> number? number? number?)
  (/ (+ x y) 2))

(define/contract (square x)
  (-> number? number?)
  (* x x))

(define/contract (sqrt x)
  (->i ([n (and/c number? (not/c negative?))])
       (result (and/c number? (not/c negative?)))
       #:post (result n)
       (< (dist n (square (sqrt n))) 0.0001))
  (define (improve approx)
    (average (/ x approx) approx))
  (define (good-enough? approx)
    (< (dist x (square approx)) 0.0001))
  (define (iter approx)
    (cond [(good-enough? approx) approx]
          [else (iter (improve approx))]))
  (iter 1.0))

;cw3

(define (fil-chck1 xs res)
  (andmap (lambda (x) (member x xs)) res))

(define/contract (filter1 f xs)
;  (let ([a (new-∀/c 'a)])
;    (-> (-> a boolean?) (listof a) (listof a)))
  (->i ([f (-> any/c boolean?)]
        [xs list?])
       (result list?)
       #:post (result xs)
       (fil-chck1 xs result))
  (cond [(null? xs) null]
        [(f (car xs)) (cons (car xs) (filter1 f (cdr xs)))]
        [else (filter1 f (cdr xs))]))

;cw4

(define-signature monoid^
  ((contracted
    [elem? (-> any/c boolean?)]
    [neutral elem?]
    [oper (-> elem? elem? elem?)])))

(define-unit monoid-integer@
  (import)
  (export monoid^)

  (define (elem? x)
    (integer? x))

  (define neutral 0)

  (define (oper x y)
    (+ x y))
  )

(define-unit monoid-list@
  (import)
  (export monoid^)

  (define (elem? x)
    (list? x))

  (define neutral null)

  (define (oper xs ys)
    (append xs ys))
  )

;cw5

(require quickcheck)

;(define-values/invoke-unit/infer monoid-integer@)
;
;(quickcheck
; (property
;  ([e1 arbitrary-integer]
;   [e2 arbitrary-integer]
;   [e3 arbitrary-integer])
;  (and (equal? (oper (oper e1 e2) e3) (oper e1 (oper e2 e3)))
;       (equal? (oper neutral e1) e1)
;       (equal? (oper e1 neutral) e1))))

(define-values/invoke-unit/infer monoid-list@)

(quickcheck
 (property
  ([e1 (arbitrary-list arbitrary-string)]
   [e2 (arbitrary-list arbitrary-string)]
   [e3 (arbitrary-list arbitrary-string)])
  (and (equal? (oper (oper e1 e2) e3) (oper e1 (oper e2 e3)))
       (equal? (oper e1 neutral) e1)
       (equal? (oper neutral e1) e1))))
