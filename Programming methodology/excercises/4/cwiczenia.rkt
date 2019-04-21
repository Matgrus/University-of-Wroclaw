#lang racket

(define (concatMap f xs)
  (if (null? xs)
      null
      (append (f (car xs)) (concatMap f (cdr xs)))))

(define (from-to s e)
  (if (= s e)
      (list s)
      (cons s (from-to (+ s 1) e))))

;cw1

( define ( queens board-size )
;; Return the representation of a board with 0 queens inserted
( define ( empty-board )
   (define (iter i res)
     (if (= i board-size)
         res
         (iter (+ i 1) (cons 0 res))))
   (iter 0 null)
)
   
;; Return the representation of a board with a new queen at
;; (row , col) added to the partial representation `rest '
( define ( adjoin-position row col rest )
   (define (iter i res help)
     (if (eq? help null)
         res
         (if (= i col)
             (iter (+ i 1) (cons row res) (cdr help))
             (iter (+ i 1) (cons (car help) res) (cdr help)))))
   (reverse (iter 1 null rest))
)
;; Return true if the queen in k-th column does not attack any of
;; the others
( define ( safe? k positions )
   (define (find k board)
     (define (iter i help)
       (if (= i k)
           (car help)
           (iter (+ 1 i) (cdr help))))
     (iter 1 board)) 
     (define (safe i help)
       (let ([r (abs (- k i))]
             [queen (find k positions)]
             [size board-size])
       (cond
         [(eq? help null) #t]
         [(= i k) (safe (+ i 1) (cdr help))]
         [(= queen (car help)) #f]
         [(= (car help) (+ queen r)) #f]
         [(= (car help) (- queen r)) #f]
         [else (safe (+ i 1) (cdr help))])))
     (safe 1 positions)
)
;; Return a list of all possible solutions for k first columns
( define ( queen-cols k )
(if (= k 0)
( list ( empty-board ) )
( filter
( lambda ( positions ) ( safe? k positions ) )
( concatMap
( lambda ( rest-of-queens )
( map ( lambda ( new-row )
( adjoin-position new-row k rest-of-queens ) )
( from-to 1 board-size ) ) )
( queen-cols (- k 1) ) ) ) ) )
( queen-cols board-size ) )

;cw2

( define ( btree? t )
(or ( eq? t 'leaf )
( and ( list? t )
(= 4 ( length t ) )
( eq? ( car t ) 'node )
( btree? ( caddr t ) )
( btree? ( cadddr t ) ) ) ) )

(define (leaf? x)
  (eq? x 'leaf))

(define leaf 'leaf)

(define (node? x)
  (and (list? x)
       (= (length x) 4)
       (eq? (car x) 'node)))

(define (node-val x)
  (cadr x))

(define (node-left x)
  (caddr x))

(define (node-right x)
  (cadddr x))

(define (make-node v l r)
  (list 'node v l r))

(define (mirror t)
  (if (leaf? t)
      t
      (make-node (node-val t) (mirror (node-right t)) (mirror (node-left t)))))

;cw4

(define (flatten t)
  (define (flat t acc)
    (if (leaf? t)
        acc
        (flat (node-left t) (cons (node-val t) (flat (node-right t) acc)))))
  (flat t null))

;cw5

(define (bst-find x t)
  (cond [(leaf? t)          false]
        [(= x (node-val t)) true]
        [(< x (node-val t)) (bst-find x (node-left t))]
        [(> x (node-val t)) (bst-find x (node-right t))]))

(define (bst-insert x t)
  (cond [(leaf? t)
         (make-node x leaf leaf)]
        [(< x (node-val t))
         (make-node (node-val t)
                    (bst-insert x (node-left t))
                    (node-right t))]
        [else
         (make-node (node-val t)
                    (node-left t)
                    (bst-insert x (node-right t)))]))

(define (treesort xs)
  (define (iter xs tree)
    (if (null? xs)
        tree
        (iter (cdr xs) (bst-insert (car xs) tree))))
  (flatten (iter xs leaf)))

;cw6

(define (bst-min tree)
  (if (eq? 'leaf (node-left tree))
      (node-val tree)
      (bst-min (node-left tree))))

(define (delete tree x)
  (cond [(null? tree) null]
        [(= x (node-val tree))
         (if (eq? 'leaf (node-right tree))
             (node-left tree)  
             (let ([min (bst-min (node-right tree))])
               (make-node min (node-left tree) (delete (node-right tree) min))))]
        [(> x (node-val tree))
         (make-node (node-val tree) (node-left tree) (delete (node-right tree) x))]
        [else (make-node (node-val tree) (delete (node-left tree) x) (node-right tree))]))