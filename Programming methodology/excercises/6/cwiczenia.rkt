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

(define (arith-expr? t)
  (or (const? t)
      (and (binop? t)
           (arith-expr? (binop-left  t))
           (arith-expr? (binop-right t)))))

;(define (let-def? t)
;  (and (list? t)
;       (= (length t) 2)
;       (symbol? (car t))))
;
;(define (let-def-var e)
;  (car e))
;
;(define (let-def-expr e)
;  (cadr e))
;
;(define (let-def-cons x e)
;  (list x e))
;
;(define (let? t)
;  (and (list? t)
;       (= (length t) 3)
;       (eq? (car t) 'let)
;       (let-def? (cadr t))))
;
;(define (let-def e)
;  (cadr e))
;
;(define (let-expr e)
;  (caddr e))
;
;(define (let-cons def e)
;  (list 'let def e))

(define (let-defs? t)
  (and (list? t)
       (andmap list? t)))

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
       (let-defs? (cadr t))))

(define (let-defs e)
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
      (and (if-zero? t)
           (arith/let-expr? (if-zero-expr t))
           (arith/let-expr? (if-zero-true t))
           (arith/let-expr? (if-zero-false t)))
      (and (let? t)
           (arith/let-expr? (let-expr t))
           (arith/let-expr? (let-defs (let-def-expr t))))
      (var? t)))

(define empty-env
  null)

(define (add-to-env x v env)
  (cons (list x v) env))

(define (find-in-env x env)
  (cond [(null? env) (error "undefined variable" x)]
        [(eq? x (caar env)) (cadar env)]
        [else (find-in-env x (cdr env))]))

(define (eval-env e env)
  (cond [(const? e) e]
        [(op? e)
         (apply (op->proc (op-op e))
                (map (lambda (a) (eval-env a env)) (op-args e)))]
        [(if-zero? e)
         (if (eq? 0 (eval-env (if-zero-expr e) env))
             (eval-env (if-zero-true e) env)
             (eval-env (if-zero-false e) env))]
;        [(let? e)
;         (eval-env
;          (let-expr e)
;          (map (lambda (a) (env-for-let a env)) (let-defs e)))]
        [(let? e)
         (eval-env
           (let-expr e)
           (env-for-let (let-defs e) env))]
        [(var? e) (find-in-env (var-var e) env)]))

(define (env-for-let defs env)
  (if (null? defs)
      env
      (env-for-let (cdr defs) (add-to-env (caar defs) (eval-env (cadar defs) env) env))))
             
;(define (env-for-let def env)
;  (add-to-env
;    (let-def-var def)
;    (eval-env (let-def-expr def) env)
;    env))

(define (eval e)
  (eval-env e empty-env))

;cw1

(define (arith->rpn lista)
  (define (onp xs acc)
    (cond  [ (number? xs) (cons xs acc)]
           [ else (onp (cadr xs) ( onp ( caddr xs) (cons (car xs) acc)))])
    )
  (onp lista null))

;cw2

(define (stack? s)
  (list? s))

(define (push arg stack)
  (cons arg stack))

(define (pop stack)
  (cons (car stack) (cdr stack)))

;cw3

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]))

(define (eval-rpn expr)
  (define (iter expr stack)
    (cond
      [(null? expr) (car (pop stack))]
      [(number? (car expr)) (iter (cdr expr) (push (car expr) stack))]
      [else (iter (cdr expr) (push ((op->proc (car expr)) (cadr stack) (car stack)) (cddr stack)))]))
  (iter expr null))

;cw5

(define (if-zero? expr)
  (and (list? expr)
       (= (length expr) 4)
       (eq? (car expr) 'if-zero)))

(define (if-zero-cons expr true false)
  (list 'if-zero expr true false))

(define (if-zero-expr expr)
  (second expr))

(define (if-zero-true expr)
  (third expr))

(define (if-zero-false expr)
  (fourth expr))

;cw6

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <= eq?))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op-cons op args)
  (cons op args))









