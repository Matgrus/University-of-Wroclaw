#lang racket

( define ( var? t )
( symbol? t ) )
( define ( neg? t )
( and ( list? t )
(= 2 ( length t ) )
( eq? 'neg ( car t ) ) ) )
( define ( conj? t )
( and ( list? t )
(= 3 ( length t ) )
( eq? 'conj ( car t ) ) ) )
( define ( disj? t )
( and ( list? t )
(= 3 ( length t ) )
( eq? 'disj ( car t ) ) ) )

( define ( prop? f )
(or ( var? f )
( and ( neg? f )
( prop? ( neg-subf f ) ) )
( and ( disj? f )
( prop? ( disj-left f ) )
( prop? ( disj-rght f ) ) )
( and ( conj? f )
( prop? ( conj-left f ) )
( prop? ( conj-rght f ) ) ) ) )

;cw1

(define (neg-cons x)
  (list 'neg x))

(define (conj-cons x y)
  (list 'conj x y))

(define (disj-cons x y)
  (list 'disj x y))

(define (neg-subf t)
  (second t))

(define (disj-left t)
  (second t))

(define (disj-rght t)
  (third t))

(define (conj-left t)
  (second t))

(define (conj-rght t)
  (third t))

;cw2

(define (free-vars t)
  (define (iter t res)
    (cond
      [(null? t) res]
      [(var? t) (cons t res)]
      [(literal? t) (iter (second t) res)]
      [(neg? t) (iter (neg-subf t) res)]
      [(conj? t) (iter (conj-left t) (iter (conj-rght t) res))]
      [(disj? t) (iter (disj-left t) (iter (disj-rght t) res))]))
  (remove-duplicates (iter t null)))

;cw3

( define ( gen-vals xs )
(if ( null? xs )
( list null )
( let*
(( vss ( gen-vals ( cdr xs ) ) )
( x ( car xs ) )
( vst ( map ( lambda ( vs ) ( cons ( list x true ) vs ) ) vss ) )
( vsf ( map ( lambda ( vs ) ( cons ( list x false ) vs ) ) vss ) ) )
( append vst vsf ) ) ) )


(define (eval-formula f vals)
  (define (find var vals)
    (cond
      [(null? vals) (error "blad")]
      [(eq? (caar vals) var) (cadar vals)]
      [else (find var (cdr vals))]))
  (cond
    [(null? f) null]
    [(var? f) (find f vals)]
    [(literal? f) (eval-formula (second f) vals)]
    [(neg? f) (not (eval-formula (neg-subf f) vals))]
    [(conj? f) (and (eval-formula (conj-left f) vals) (eval-formula (conj-rght f) vals))]
    [(disj? f) (or (eval-formula (disj-left f) vals) (eval-formula (disj-rght f) vals))]))

(define (falsifiable-eval f)
  (define (iter f vals)
    (cond
      [(null? vals) #f]
      [(eq? #f (eval-formula f (car vals))) (car vals)]
      [else (iter f (cdr vals))]))
  (iter f (gen-vals (free-vars f))))

;cw4

(define (literal? l)
  (and (list? l)
       (= (length l) 2)
       (eq? (car l) `lit)
       (or (var? (second l))
           (and (neg? (second l))
                (var? (neg-subf (second l)))))))

(define (literal p)
  (if (or (var? p)
          (and (neg? p)
               (var? (neg-subf p))))
      (list `lit p)
      (error "Podana formuła nie jest zmienna ani negacją zmiennej")))

(define (nnf? f)
  (cond [(literal? f) #t]
        [(conj? f) (and (nnf? (conj-left f))
                        (nnf? (conj-rght f)))]
        [(disj? f) (and (nnf? (disj-left f))
                        (nnf? (disj-rght f)))]
        [(neg? f) #f]
        [else (error "Podano błędną formułę")]))

(define f2 (conj-cons (literal (neg-cons `p)) (disj-cons (literal `q) (literal (neg-cons `r)))))

;cw5

(define (convert-to-nnf-neg f)
  (cond [(var? f) (literal (neg-cons f))]
        [(disj? f) (conj-cons (convert-to-nnf-neg (disj-left f))
                         (convert-to-nnf-neg (disj-rght f)))]
        [(conj? f) (disj-cons (convert-to-nnf-neg (conj-left f))
                         (convert-to-nnf-neg (conj-rght f)))]
        [(neg? f) (convert-to-nnf (neg-subf f))]
        [else (error "Błędna formuła")]))

(define (convert-to-nnf f)
  (cond [(var? f) (literal f)]
        [(disj? f) (disj-cons (convert-to-nnf (disj-left f))
                         (convert-to-nnf (disj-rght f)))]
        [(conj? f) (conj-cons (convert-to-nnf (conj-left f))
                         (convert-to-nnf (conj-rght f)))]
        [(neg? f) (convert-to-nnf-neg (neg-subf f))]
        [else (error "Błędna formuła")]))


