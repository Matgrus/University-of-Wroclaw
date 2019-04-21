#lang racket

(define (const? t)
  (number? t))

(define (binop? t)
  (and (list? t)
       (= (length t) 3)
       (member (car t) '(+ - * /))))

(define (binop-op e)
  (car e))

(define (binop-left e)
  (cadr e))

(define (binop-right e)
  (caddr e))

(define (binop-cons op l r)
  (list op l r))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (let-def? t)
  (and (list? t)
       (= (length t) 2)
       (symbol? (car t))))

(define (let-def-var e)
  (car e))

(define (let-def-expr e)
  (cadr e))

(define (let-def-cons x e)
  (list x e))

(define (let? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (car t) 'let)
       (let-def? (cadr t))))

(define (let-def e)
  (cadr e))

(define (let-expr e)
  (caddr e))

(define (let-cons def e)
  (list 'let def e))

(define (var? t)
  (symbol? t))

(define (var-var e)
  e)

(define (var-cons x)
  x)

(define (hole? t)
  (eq? t 'hole))

(define (arith/let/holes? t)
  (or (hole? t)
      (const? t)
      (and (binop? t)
           (arith/let/holes? (binop-left  t))
           (arith/let/holes? (binop-right t)))
      (and (let? t)
           (arith/let/holes? (let-expr t))
           (arith/let/holes? (let-def-expr (let-def t))))
      (var? t)))

(define (num-of-holes t)
  (cond [(hole? t) 1]
        [(const? t) 0]
        [(binop? t)
         (+ (num-of-holes (binop-left  t))
            (num-of-holes (binop-right t)))]
        [(let? t)
         (+ (num-of-holes (let-expr t))
            (num-of-holes (let-def-expr (let-def t))))]
        [(var? t) 0]))

(define (arith/let/hole-expr? t)
  (and (arith/let/holes? t)
       (= (num-of-holes t) 1)))


(define (hole-context e)
    (define (hole-help wyn e)
    (cond [(binop? e)
           (if (arith/let/hole-expr? (binop-left e))
           (hole-help wyn (binop-left e))
           (hole-help wyn (binop-right e)))]
          [(let? e)
           (if (arith/let/hole-expr? (let-expr e))
               (hole-help (cons (let-def-var (let-def e)) wyn) (let-expr e))
               (hole-help wyn (let-def-expr (let-def e))))]
          [else wyn]
           ))
  (remove-duplicates (hole-help null e)))


(define (test)
  (if (and
       (equal? (sort (hole-context '(let (x (+ z 2)) (let (y w) (+ x hole)))) symbol<?) (sort '(x y) symbol<?))
       (equal? (sort (hole-context '(+ (+ x hole ) y)) symbol<?) (sort '() symbol<?))
       (equal? (sort (hole-context '(+ x hole )) symbol<?) (sort '() symbol<?))
       (equal? (sort (hole-context '(+ 3 hole )) symbol<?) (sort '() symbol<?))
       (equal? (sort (hole-context '(let (x 3) (let (y 7) (+ x hole)))) symbol<?) (sort '(x y) symbol<?))
       (equal? (sort (hole-context '( let ( x 3) ( let ( y hole ) (+ x 3) ) )) symbol<?) (sort '(x) symbol<?))
       (equal? (sort (hole-context '( let ( x hole ) ( let ( y 7) (+ x 3) ) )) symbol<?) (sort '() symbol<?))
       (equal? (sort (hole-context '( let ( piesek 1)
                              ( let ( kotek 7)
                                 ( let ( piesek 9)
                                    ( let ( chomik 5)
                                       hole ) ) ) ) ) symbol<?) (sort '(chomik piesek kotek) symbol<?))
       (equal? (sort (hole-context '(+ ( let ( x 4) 5) hole ) ) symbol<?) (sort '()  symbol<?)))
      #t
      #f))

(test)
