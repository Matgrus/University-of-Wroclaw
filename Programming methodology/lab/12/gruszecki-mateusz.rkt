#lang racket

;; sygnatura: grafy
(define-signature graph^
  ((contracted
    [graph        (-> list? (listof edge?) graph?)]
    [graph?       (-> any/c boolean?)]
    [graph-nodes  (-> graph? list?)]
    [graph-edges  (-> graph? (listof edge?))]
    [edge         (-> any/c any/c edge?)]
    [edge?        (-> any/c boolean?)]
    [edge-start   (-> edge? any/c)]
    [edge-end     (-> edge? any/c)]
    [has-node?    (-> graph? any/c boolean?)]
    [outnodes     (-> graph? any/c list?)]
    [remove-node  (-> graph? any/c graph?)]
    )))

;; prosta implementacja grafów
(define-unit simple-graph@
  (import)
  (export graph^)

  (define (graph? g)
    (and (list? g)
         (eq? (length g) 3)
         (eq? (car g) 'graph)))

  (define (edge? e)
    (and (list? e)
         (eq? (length e) 3)
         (eq? (car e) 'edge)))

  (define (graph-nodes g) (cadr g))

  (define (graph-edges g) (caddr g))

  (define (graph n e) (list 'graph n e))

  (define (edge n1 n2) (list 'edge n1 n2))

  (define (edge-start e) (cadr e))

  (define (edge-end e) (caddr e))

  (define (has-node? g n) (not (not (member n (graph-nodes g)))))
  
  (define (outnodes g n)
    (filter-map
     (lambda (e)
       (and (eq? (edge-start e) n)
            (edge-end e)))
     (graph-edges g)))

  (define (remove-node g n)
    (graph
     (remove n (graph-nodes g))
     (filter
      (lambda (e)
        (not (eq? (edge-start e) n)))
      (graph-edges g)))))

;; sygnatura dla struktury danych
(define-signature bag^
  ((contracted
    [bag?       (-> any/c boolean?)]
    [empty-bag  (and/c bag? bag-empty?)]
    [bag-empty? (-> bag? boolean?)]
    [bag-insert (-> bag? any/c (and/c bag? (not/c bag-empty?)))]
    [bag-peek   (-> (and/c bag? (not/c bag-empty?)) any/c)]
    [bag-remove (-> (and/c bag? (not/c bag-empty?)) bag?)])))

;; struktura danych - stos
(define-unit bag-stack@
  (import)
  (export bag^)

  (define (bag? x)
    (list? x))
  
  (define (bag-empty? x)
    (eq? (length x) 0))

  (define empty-bag null)

  (define (bag-insert x val)
    (cons val x))

  (define (bag-peek x)
    (car x))

  (define (bag-remove x)
    (cdr x))
  
)

;; struktura danych - kolejka FIFO
;; do zaimplementowania przez studentów
(define-unit bag-fifo@
  (import)
  (export bag^)
  
  (define (bag? x)
    (and (list? x) (eq? (length x) 2) (list? (first x)) (list? (second x))))

  (define (bag-empty? x)
    (and (eq? (length (first x)) 0) (eq? (length (second x)) 0)))

  (define empty-bag (list (list) (list)))

  (define (bag-insert x val)
    (if (bag-empty? x)
        (list (list) (list val))
        (if (eq? (length (second x)) 0)
            (bag-insert (list (list) (reverse (first x))) val)
            (list (cons val (first x)) (second x)))))
  
  (define (bag-peek x)
    (car (reverse (second x))))

  (define (bag-remove x)
    (if (eq? (length (second x)) 0)
        (bag-remove (list (list) (reverse (first x))))
        (if (eq? (length (second x)) 1)
            (list (list) (reverse (first x)))
            (list (first x) (reverse (cdr (reverse (second x))))))))
)

;; sygnatura dla przeszukiwania grafu
(define-signature graph-search^
  (search))

;; implementacja przeszukiwania grafu
;; uzależniona od implementacji grafu i struktury danych
(define-unit/contract graph-search@
  (import bag^ graph^)
  (export (graph-search^
           [search (-> graph? any/c (listof any/c))]))
  (define (search g n)
    (define (it g b l)
      (cond
        [(bag-empty? b) (reverse l)]
        [(has-node? g (bag-peek b))
         (it (remove-node g (bag-peek b))
             (foldl
              (lambda (n1 b1) (bag-insert b1 n1))
              (bag-remove b)
              (outnodes g (bag-peek b)))
             (cons (bag-peek b) l))]
        [else (it g (bag-remove b) l)]))
    (it g (bag-insert empty-bag n) '()))
  )

;; otwarcie komponentu grafu
(define-values/invoke-unit/infer simple-graph@)

;; graf testowy
(define test-graph
  (graph
   (list 1 2 3 4)
   (list (edge 1 3)
         (edge 1 2)
         (edge 2 4))))
;; TODO: napisz inne testowe grafy!

(define test1
  (graph
   (list 1)
   (list (edge 1 1)
         )))

(define test2
  (graph
   (list 1 2 3 4 5)
   (list (edge 1 1)
         (edge 2 2)
         (edge 3 3)
         (edge 4 4)
         (edge 5 5)
         )))

(define test3
  (graph
   (list 1 2 3 4 5)
   (list (edge 5 4)
         (edge 4 3)
         (edge 3 2)
         (edge 2 1)
         (edge 1 5)
         )))

(define test4
  (graph
   (list 1 2 3 4 5 6)
   (list (edge 1 4)
         (edge 2 5)
         (edge 3 1)
         (edge 4 6)
         (edge 5 4)
         (edge 6 5)
         )))

(define test5
  (graph
   (list 1 2 3 4 5 6 7 8 9 10)
   (list (edge 1 2)
         (edge 1 3)
         (edge 1 4)
         (edge 1 5)
         (edge 1 6)
         (edge 1 7)
         (edge 1 8)
         (edge 1 9)
         (edge 1 10)
         (edge 10 6)
         (edge 6 7)
         )))

(define test6
  (graph
   (list 1 2 3 4 5)
   (list (edge 5 4)
         (edge 4 3)
         (edge 3 2)
         (edge 2 1)
         )))

;; otwarcie komponentu stosu
(define-values/invoke-unit/infer bag-stack@)
;; opcja 2: otwarcie komponentu kolejki
 ;(define-values/invoke-unit/infer bag-fifo@)

;; testy w Quickchecku
(require quickcheck)

;; test przykładowy: jeśli do pustej struktury dodamy element
;; i od razu go usuniemy, wynikowa struktura jest pusta
(quickcheck
 (property ([s arbitrary-symbol])
           (bag-empty? (bag-remove (bag-insert empty-bag s)))))



;; TODO: napisz inne własności do sprawdzenia!
;; jeśli jakaś własność dotyczy tylko stosu lub tylko kolejki,
;; wykomentuj ją i opisz to w komentarzu powyżej własności

(define arbitrary-bag-stack
  (arbitrary-list arbitrary-symbol))

;;Element dodany do pustej struktury to element, który z niej wyciągniemy
(quickcheck
 (property ([s arbitrary-symbol])
           (eq? s (bag-peek (bag-insert empty-bag s)))))

;;STOS
;;Element, który wyciągamy ze stosu, to element który jako ostatni do niego włożyliśmy
(quickcheck
 (property ([s arbitrary-symbol]
            [b arbitrary-bag-stack])
           (eq? s (bag-peek (bag-insert b s)))))

;;STOS
;;Dodając i usuwając taka samą ilość elementów ze stosu jego długość nie zmienia się
(quickcheck
 (property ([s arbitrary-symbol]
            [b arbitrary-bag-stack])
           (eq? (length (bag-remove (bag-insert b s))) (length b))))


;; otwarcie komponentu przeszukiwania
(define-values/invoke-unit/infer graph-search@)

;; uruchomienie przeszukiwania na przykładowym grafie
(search test-graph 1)
(search test1 1)
(search test2 3)
(search test3 5)
(search test4 1)
(search test5 1)
(search test6 1)
;; TODO: uruchom przeszukiwanie na swoich przykładowych grafach!