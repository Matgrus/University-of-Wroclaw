#lang racket

(require racklog)

;; predykat unarny %male reprezentuje zbiór mężczyzn
(define %male
  (%rel ()
        [('adam)]
        [('john)]
        [('joshua)]
        [('mark)]
        [('david)]))

;; predykat unarny %female reprezentuje zbiór kobiet
(define %female
  (%rel ()
        [('eve)]
        [('helen)]
        [('ivonne)]
        [('anna)]))

;; predykat binarny %parent reprezentuje relację bycia rodzicem
(define %parent
  (%rel ()
        [('adam 'helen)]
        [('adam 'ivonne)]
        [('adam 'anna)]
        [('eve 'helen)]
        [('eve 'ivonne)]
        [('eve 'anna)]
        [('john 'joshua)]
        [('helen 'joshua)]
        [('ivonne 'david)]
        [('mark 'david)]))

;; predykat binarny %sibling reprezentuje relację bycia rodzeństwem
(define %sibling
  (%rel (a b c)
        [(a b)
         (%parent c a)
         (%parent c b)]))

;; predykat binarny %sister reprezentuje relację bycia siostrą
(define %sister
  (%rel (a b)
        [(a b)
         (%sibling a b)
         (%female a)]))

;; predykat binarny %ancestor reprezentuje relację bycia przodkiem
(define %ancestor
  (%rel (a b c)
        [(a b)
         (%parent a b)]
        [(a b)
         (%parent a c)
         (%ancestor c b)]))

;;;;;;;;;;;

(define %my-append
  (%rel (x xs ys zs)
        [(null ys ys)]
        [((cons x xs) ys (cons x zs))
         (%my-append xs ys zs)]))

(define %my-member
  (%rel (x xs y)
        [(x (cons x xs))]
        [(y (cons x xs))
         (%my-member y xs)]))

(define %select
  (%rel (x xs y ys)
        [(x (cons x xs) xs)]
        [(y (cons x xs) (cons x ys))
         (%select y xs ys)]))

;; prosta rekurencyjna definicja
(define %simple-length
  (%rel (x xs n m)
        [(null 0)]
        [((cons x xs) n)
         (%simple-length xs m)
         (%is n (+ m 1))]))

;cw1

(define %grandson
  (%rel (x y z)
        [(x y)
         (%male x)
         (%parent y z)
         (%parent z x)]))

(define %cousin
  (%rel (w x y z)
        [(x y)
         (%parent w x)
         (%parent z y)
         (%sibling w z)]))

(define %is_mother
  (%rel (x y)
        [(x)
         (%female x)
         (%parent x y)]))

(define %is_father
  (%rel (x y)
        [(x)
         (%male x)
         (%parent x y)]))

;cw2

;(%which () (%ancestor 'john 'mark))
;(%find-all (x) (%ancestor 'adam x))
;(%find-all (x) (%sister x 'ivonne))
;(%find-all (x y) (%cousin x y))

;cw3

;(%which (xs ys) (%my-append xs xs ys))
;(%which (x) (%select x '(1 2 3 4) '(1 2 4)))
;(%which (xs) (%my-append xs '(1 2 3) '(1 2 3 4 5)))

;cw6

(define %sublist
  (%rel (xs ys x)
;        [(xs ys)
;         (null? xs)]
;        [(xs ys)
;         (if (= (car xs ) (car ys))
;             (%sublist (cdr xs) (cdr ys))
;             (%sublist xs (cdr ys)))]))
        [(null null)]
        [((cons x xs) (cons x ys))
         (%sublist xs ys)]
        [(xs (cons x ys))
         (%sublist xs ys)]))

;(%which () (%sublist (list 1 3 5) (list 1 2 3 4 5 6)))
;(%which () (%sublist (list 1 2 3 4 5 6) (list 1 2 3 4 5 6)))
;(%which () (%sublist (list 1 3 15) (list 1 2 3 4 5 6)))
;(%which () (%sublist (list 1 5 2) (list 1 2 3 4 5 6)))
;(%find-all (xs) (%sublist xs (list 1 2 3)))

;cw7

(define %perm
  (%rel (xs ys x zs)
        [(xs xs)]
        [((cons x xs) ys)
         (%select x ys zs)
         (%perm xs zs)]))
;        [(xs ys)
;         (= (length xs) (length ys))
;         (%perm (cdr xs) (%select (car xs) ys))]))
  

(%which () (%perm (list 1 3 5 6 4 2) (list 1 2 3 4 5 6)))
(%which () (%perm (list 1 2 2 3 4) (list 1 2 3 4)))
(%which () (%perm (list 1 2 2 3 4) (list 1 2 3 4 2 4)))

;cw8

(define (list->num xs)
  (define (helper xs n)
    (if (null? xs)
        n
        (helper (cdr xs) (+ (* n 10) (car xs)))))
  (helper xs 0))

(define riddle
  (lambda ()
    (%let (xs a b)
          (%which (d e m n o r s y)
                  (%and (%sublist xs (list 1 2 3 4 5 6 7 8 9 0))
                        (%simple-length xs 8)
                        (%perm (list d e m n o r s y) xs)
                        (%=/= s 0)
                        (%=/= m 0)
                        (%is a (+ (list->num (list s e n d))
                                  (list->num (list m o r e))))
                        (%is b (list->num (list m o n e y)))
                        (%= a b))))))
;(riddle)