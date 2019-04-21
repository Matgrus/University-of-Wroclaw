#lang racket

;cw1

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch p m)
    (if (eq? p password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                       m)))
        (error "incorrect-password")))
  dispatch)

;( define acc ( make-account 100 'secret-password ) )
; (( acc 'secret-password 'withdraw ) 40)
; (( acc 'some-other-password 'deposit ) 50)

;: (define acc (make-account 100))

;: ((acc 'withdraw) 50)
;: ((acc 'withdraw) 60)
;: ((acc 'deposit) 40)
;: ((acc 'withdraw) 60)

;cw2

(define (make-cycle xs)
  (define (lastt ls)
    (if (null? (mcdr ls))
        ls
        (lastt (mcdr ls))))
  (set-mcdr! (lastt xs) xs))

(define ls (mcons 1 (mcons 2 (mcons 3 null))))
ls
(make-cycle ls)
ls

(define (has-cycle? ls)
  (define (help ls x y)
    (cond
      [(eq? x y) #t]
      [(or (null? ls) (null? (mcdr ls)) (null? (mcdr (mcdr ls)))) #f]
      [else (help (mcdr ls) (mcdr x) (mcdr (mcdr y)))]))
  (help ls ls (mcdr ls)))

(define ds (mcons 1 (mcons 2 null)))
(has-cycle? ds)

(define ys (mcons 1 null))
(make-cycle ys)
(has-cycle? (mcons 0 ys))


;cw4

(define (make-monitored func)
  (define (main counter func)
;      (begin (set! counter (+ counter 1))
;             func))
;    (define (how-many counter)
;      counter)
;    (define (reset counter)
;      (begin (set! counter 0)
;             counter))
    (define (count)
      (define (dispatch m)
        (cond
          [(eq? m 'inc) (begin (set! counter (+ counter 1)) func)]
          [(eq? m 'how-many?) counter]
          [(eq? m 'reset) (begin (set! counter 0) counter)]
          [else (error "unknown request")]))
      dispatch)
    (define (arg)
      (begin (set! counter (+ 1 counter)) func))
    (cons (arg) (count)))
  (main 0 func))

(define p (make-monitored +))

;cw5

(define (bucket-sort xs)
  (define (max ls)
    (define (helpmax ls max)
      (cond
        [(null? ls) max]
        [(> (caar ls) max) (helpmax (cdr ls) (caar ls))]
        [else (helpmax (cdr ls) max)]))
    (helpmax ls (caar ls)))
  (let* ((vect (make-vector (+ 1 (max xs))))
         (len (vector-length vect)))
(define (fill-vect v xs)
      (define (h v)
        (if (or (null? v) (eq? 0 v))
            #t
            #f))
      (if (null? xs)
          v
          (fill-vect (if (h (vector-ref v (- (caar xs) 1)))
                         (begin (vector-set! v (- (caar xs) 1) (list (car xs))) v)
                         (begin (vector-set! v (- (caar xs) 1) (append (vector-ref v (- (caar xs) 1)) (list (car xs)))) v)) (cdr xs))))
    (define (print-vec v n acc)
      (cond
        [(= n len) acc]
        [(or (null? (vector-ref v n)) (eq? 0 (vector-ref v n)))
         (print-vec v (+ n 1) acc)]
        [else (print-vec v (+ n 1) (if (list? (vector-ref v n))
                                       (append acc (vector-ref v n))
                                       (append acc (list (vector-ref v n)))))]))
    (print-vec (fill-vect vect xs) 0 null)))

(define test ( list ( cons 2 'x ) ( cons 1 'y ) ( cons 2 'z ) ) )
(bucket-sort test)

;cw6

(define (lcons x f)
  (cons x f))

(define (lhead l)
  (car l))

(define (ltail l)
  ((cdr l)))

(define (ltake n l)
  (if (or (null? l) (= n 0))
      null
      (cons (lhead l)
            (ltake (- n 1) (ltail l)))))

(define (lfilter p l)
  (cond [(null? l) null]
        [(p (lhead l))
         (lcons (lhead l)
                (lambda ()
                  (lfilter p (ltail l))))]
        [else (lfilter p (ltail l))]))

(define (lmap f . ls)
  (if (ormap null? ls) null
      (lcons (apply f (map lhead ls))
             (lambda ()
               (apply lmap (cons f (map ltail ls)))))))

(define (integers-starting-from n)
  (lcons n (lambda () (integers-starting-from (+ n 1)))))

;(define fact-list
;  (lcons 1
;         (lambda () (lcons 2
;                           (lambda () (lmap * (ltail (ltake n (integers-starting-from 1)))))))))
;
;(define facts (fact-list 1))
