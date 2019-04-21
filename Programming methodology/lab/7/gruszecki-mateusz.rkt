#lang racket

;; expressions

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * /))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op-cons op args)
  (cons op args))

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

(define (arith/let-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith/let-expr? (op-args t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-def-expr (let-def t))))
      (var? t)))

;; let-lifted expressions

(define (arith-expr? t)
  (or (const? t)
      (and (op? t)
           (andmap arith-expr? (op-args t)))
      (var? t)))

(define (let-lifted-expr? t)
  (or (and (let? t)
           (let-lifted-expr? (let-expr t))
           (arith-expr? (let-def-expr (let-def t))))
      (arith-expr? t)))

;; generating a symbol using a counter

(define (number->symbol i)
  (string->symbol (string-append "x" (number->string i))))

;; environments (could be useful for something)

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

;; the let-lift procedure      

(define (let-lift ls)
  ; procedury, ktore wykorzystuje let-lift
  (define (my-op? t)
    (if (and (list? t)
             (member (car t) '(+ - * /)))
        #t
        #f))
  
  (define (collect-let ls) ; tworzy liste let-definicji
    (define (col-let-help ls res)
      (if (null? ls)
          res
          (cond
            [(my-op? ls) (col-let-help (caddr ls) (col-let-help (cadr ls) res))] 
            [(let? ls) (col-let-help (let-expr ls) (col-let-help (let-def-expr (let-def ls)) (cons (let-def ls) res)))]
            [else res])))
    (col-let-help ls null))

  (define (collect-ops ls) ; tworzy liste operacji
    (cond
      [(my-op? ls) ls]
      [(let? ls) (let-expr ls)]
      [else null]))

  (define (op-conv ls) ;usuwa lety z operacji
    (cond
      [(my-op? ls) (op-cons (car ls) (list (op-conv (first (op-args ls))) (op-conv (second (op-args ls)))))]
      [(let? ls) (let-expr ls)]
      [else ls]))

  (define (let-conv ls) ;usuwa zagniezdzone lety z let-definicji
    (define (is-let? arg)
      (define (check-op ls)
        (cond
          [(or (let? (first ls)) (let? (second ls))) #t]
          [(and (const? (first ls)) (const? (second ls))) #f]
          [(and (my-op? (first ls)) (my-op? (second ls))) (ormap check-op (list (op-args (first ls)) (op-args (second ls))))]
          [(my-op? (first ls)) (check-op (op-args (first ls)))]
          [(my-op? (second ls)) (check-op (op-args (second ls)))]
          [else #f]))
      (cond
        [(const? (cadr arg)) #f]
        [(let? (cadr arg)) #t]
        [(my-op? (cadr arg)) (check-op (op-args (cadr arg)))]))
    (define (del-let ls)
      (if (let? (cadr ls))
          (list (car ls) (let-expr (cadr ls)))
          (list (car ls) (op-conv (cadr ls)))))  
    (define (help ls wyn)
      (if (null? ls)
          wyn
          (if (is-let? (car ls))
              (help (cdr ls) (cons (del-let (car ls)) wyn))
              (help (cdr ls) (cons (car ls) wyn)))))
    (help (reverse ls) null))

  (define (vars ls) ;tworzy liste par zmiennych i ich nowych nazw na podstawie listy let-definicji (niestety nie dokonczylem tej czesci zadania)
    (define (help ls wyn i)    ; uzycie: (vars (let-conv (collect-let wyrazenie)))
      (if (null? ls)
          wyn
          (help (cdr ls) (add-to-env (caar ls) (number->symbol i) wyn) (+ 1 i))))
    (help ls null 0))
  
  ; koniec procedur
  (let ([lety (let-conv (collect-let ls))]
        [opy (op-conv (collect-ops ls))])
    
    (define (buduj lety opy)
      (if (null? (cdr lety))
          (let-cons (car lety) opy)
          (let-cons (car lety) (buduj (cdr lety) opy))))
    (buduj lety opy)))

; TESTY  (dwa ostatnie nie wychodza prawidlowo przez powtarzajace sie nazwy zmiennych

(display "przed: ") (newline)

'(+ (let (x 2) x) 2)
'(+ (let (x 2) x) (let (y 3) y))
'(+ 10 (* ( let ( x 7) (+ x 2) ) 2) )
'( let ( x (- 2 ( let ( z (- 3 2)) z ) ))  (+ x 2) )
'(+ (let (x (let (y 2) y)) x) 4)
'( let ( x (- 2 ( let ( z 3) z ) ))  (+ x (let (v 5) (+ 2 v)) ))
'(+ (let (x (+ 2 (+ 3 (- 4 (let (y 5) y))))) x) 2)
'(+ ( let ( x 5) x ) ( let ( x 1) x ))
'(let (x (let (x 4) x)) x)

(display "====================") (newline)

(display "po: ") (newline)

(let-lift '(+ (let (x 2) x) 2))
(let-lift '(+ (let (x 2) x) (let (y 3) y)))
(let-lift '(+ 10 (* ( let ( x 7) (+ x 2) ) 2) ))
(let-lift '( let ( x (- 2 ( let ( z (- 3 2)) z ) ))  (+ x 2) ))
(let-lift '(+ (let (x (let (y 2) y)) x) 4))
(let-lift '( let ( x (- 2 ( let ( z 3) z ) ))  (+ x (let (v 5) (+ 2 v)) )))
(let-lift '(+ (let (x (+ 2 (+ 3 (- 4 (let (y 5) y))))) x) 2))
(let-lift '(+ ( let ( x 5) x ) ( let ( x 1) x )))
(let-lift '(let (x (let (x 4) x)) x))
