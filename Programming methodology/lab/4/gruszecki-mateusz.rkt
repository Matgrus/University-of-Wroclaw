#lang racket

(define (inc n)
  (+ n 1))

;;; ordered elements
(define (make-elem pri val)
  (cons pri val))

(define (elem-priority x)
  (car x))

(define (elem-val x)
  (cdr x))

;;; leftist heaps (after Okasaki)

;; data representation
(define leaf 'leaf)

(define (leaf? h) (eq? 'leaf h))

(define (hnode? h)
  (and (list? h)
       (= 5 (length h))
       (eq? (car h) 'hnode)
       (natural? (caddr h))))

(define (make-node elem heap-a heap-b)
  (define (heap-rank h)
    (if (or (leaf? h) (leaf? (node-right h))) 0
        (+ 1 (heap-rank (node-right h)))))
  (let ([rank-a (heap-rank heap-a)]
        [rank-b (heap-rank heap-b)])
    (if (>= rank-a rank-b) (list 'hnode elem (if (leaf? heap-b) 0 (+ 1 rank-b)) heap-a heap-b)
        (list 'hnode elem (if (leaf? heap-a) 0 (+ 1 rank-a)) heap-b heap-a))
  ))


(define (node-elem h)
  (second h))

(define (node-left h)
  (fourth h))

(define (node-right h)
  (fifth h))

(define (hord? p h)
  (or (leaf? h)
      (<= p (elem-priority (node-elem h)))))

(define (heap? h)
  (or (leaf? h)
      (and (hnode? h)
           (heap? (node-left h))
           (heap? (node-right h))
           (<= (rank (node-right h))
               (rank (node-left h)))
           (= (rank h) (inc (rank (node-right h))))
           (hord? (elem-priority (node-elem h))
                  (node-left h))
           (hord? (elem-priority (node-elem h))
                  (node-right h)))))

(define (rank h)
  (if (leaf? h)
      0
      (third h)))

;; operations

(define empty-heap leaf)

(define (heap-empty? h)
  (leaf? h))

(define (heap-insert elt heap)
  (heap-merge heap (make-node elt leaf leaf)))

(define (heap-min heap)
  (node-elem heap))

(define (heap-pop heap)
  (heap-merge (node-left heap) (node-right heap)))

(define (heap-merge h1 h2)
  (cond
   [(leaf? h1) h2]
   [(leaf? h2) h1]
   [else
    (let ([e (if (<= (elem-priority (heap-min h1)) (elem-priority (heap-min h2))) (heap-min h1) (heap-min h2))]
          [hl (if (<= (elem-priority (heap-min h1)) (elem-priority (heap-min h2))) (node-left h1) (node-left h2))]
          [hr (if (<= (elem-priority (heap-min h1)) (elem-priority (heap-min h2))) (node-right h1) (node-right h2))]
          [h (if (<= (elem-priority (heap-min h1)) (elem-priority (heap-min h2))) h2 h1)])
      (let ([help-merge (heap-merge hr h)])
        (make-node e hl help-merge)))            
    ]))


;;; heapsort. sorts a list of numbers.
(define (heapsort xs)
  (define (popAll h)
    (if (heap-empty? h)
        null
        (cons (elem-val (heap-min h)) (popAll (heap-pop h)))))
  (let ((h (foldl (lambda (x h)
                    (heap-insert (make-elem x x) h))
            empty-heap xs)))
    (popAll h)))

;;; check that a list is sorted (useful for longish lists)
(define (sorted? xs)
  (cond [(null? xs)              true]
        [(null? (cdr xs))        true]
        [(<= (car xs) (cadr xs)) (sorted? (cdr xs))]
        [else                    false]))

;;; generate a list of random numbers of a given length
(define (randlist len max)
  (define (aux len lst)
    (if (= len 0)
        lst
        (aux (- len 1) (cons (random max) lst))))
  (aux len null))


; TESTY

(define x1 (randlist 10 100))
(display x1)
(display " = ")
(heapsort x1)
(sorted? (heapsort x1))

(define x2 (randlist 10 100))
(display x2)
(display " = ")
(heapsort x2)
(sorted? (heapsort x2))

(define x3 (randlist 10 100))
(display x3)
(display " = ")
(heapsort x3)
(sorted? (heapsort x3))

(make-node (make-elem 3 "asd") (make-node (make-elem 3 "asd") (make-node (make-elem 3 "asd") leaf leaf) (make-node (make-elem 3 "asd") leaf leaf))
           (make-node (make-elem 3 "asd") (make-node (make-elem 3 "asd") leaf leaf)
                     (make-node (make-elem 3 "asd") (make-node (make-elem 3 "asd") leaf leaf)
                      (make-node (make-elem 3 "asd") (make-node (make-elem 3 "asd") leaf leaf) (make-node (make-elem 3 "asd") leaf leaf)))))
(define y1
(make-node (make-elem 1 "asd") (make-node (make-elem 3 "asd") leaf leaf) leaf))
(define y2 (make-node (make-elem 2 "asd") leaf leaf))

(define wyn (heap-merge y1 y2))
(define wyn1 (heap-insert (make-elem 0 "dfg") wyn))
(define wyn2 (heap-insert (make-elem 1 "dfg") wyn1))
wyn
wyn1
wyn2
