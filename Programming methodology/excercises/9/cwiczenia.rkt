#lang racket

;; pomocnicza funkcja dla list tagowanych o określonej długości

(define (tagged-tuple? tag len p)
  (and (list? p)
       (= (length p) len)
       (eq? (car p) tag)))

(define (tagged-list? tag p)
  (and (pair? p)
       (eq? (car p) tag)
       (list? (cdr p))))

;;
;; WHILE
;;

; memory

(define empty-mem
  null)

(define (set-mem x v m)
  (cond [(null? m)
         (list (cons x v))]
        [(eq? x (caar m))
         (cons (cons x v) (cdr m))]
        [else
         (cons (car m) (set-mem x v (cdr m)))]))

(define (get-mem x m)
  (cond [(null? m) 0]
        [(eq? x (caar m)) (cdar m)]
        [else (get-mem x (cdr m))]))

; arith and bools

(define (const? t)
  (number? t))

(define (op? t)
  (and (list? t)
       (member (car t) '(+ - * / = > >= < <=))))

(define (op-op e)
  (car e))

(define (op-args e)
  (cdr e))

(define (op->proc op)
  (cond [(eq? op '+) +]
        [(eq? op '*) *]
        [(eq? op '-) -]
        [(eq? op '/) /]
        [(eq? op '=) =]
        [(eq? op '>) >]
        [(eq? op '>=) >=]
        [(eq? op '<)  <]
        [(eq? op '<=) <=]))

(define (var? t)
  (symbol? t))

(define (eval-arith e m)
  (cond [(var? e) (get-mem e m)]
        [(op? e)
         (apply
          (op->proc (op-op e))
          (map (lambda (x) (eval-arith x m))
               (op-args e)))]
        [(const? e) e]))

;;

(define (assign? t)
  (and (list? t)
       (= (length t) 3)
       (eq? (second t) ':=)))

(define (assign-var e)
  (first e))

(define (assign-expr e)
  (third e))

(define (if? t)
  (tagged-tuple? 'if 4 t))

(define (if-cons cond true false)
  (list 'if cond true false))

(define (if-cond e)
  (second e))

(define (if-then e)
  (third e))

(define (if-else e)
  (fourth e))

(define (while? t)
  (tagged-tuple? 'while 3 t))

(define (while-cond t)
  (second t))

(define (while-expr t)
  (third t))

(define (while-cons cond expr)
  (list 'while cond expr))

(define (block? t)
  (list? t))

(define (inc? t)
  (and (list? t)
       (= (length t) 2)
       (eq? (cadr t) '++)))

(define (inc x)
  (list x '++))

(define (dec? t)
  (and (list? t)
       (= (length t) 2)
       (eq? (cadr t) '--)))

(define (dec x)
  (list x '--))

(define (for? t)
  (and
   (tagged-tuple? 'for 5 t)
   (assign? (second t))))

(define (for-assign t)
  (second t))

(define (for-cond t)
  (third t))

(define (for-change t)
  (fourth t))

(define (for-expr t)
  (fifth t))
  
;;

(define (eval e m)
  (cond [(assign? e)
         (set-mem
          (assign-var e)
          (eval-arith (assign-expr e) m)
          m)]
        [(inc? e)
         (set-mem (car e) (+ 1 (get-mem (car e) m)) m)]
        [(dec? e)
         (set-mem (car e) (- (get-mem (car e) m) 1) m)]
        [(if? e)
         (if (eval-arith (if-cond e) m)
             (eval (if-then e) m)
             (eval (if-else e) m))]
        [(while? e)
         (if (eval-arith (while-cond e) m)
             (eval e (eval (while-expr e) m))
             m)]
        [(for? e)
         (eval (while-cons (for-cond e) (list (for-expr e) (for-change e)))
               (set-mem (assign-var (for-assign e)) (eval-arith (assign-expr (for-assign e)) m) m))]
        [(block? e)
         (if (null? e)
             m
             (eval (cdr e) (eval (car e) m)))]))

(define (run e)
  (eval e empty-mem))

;;

(define fact10
  '( (i := 10)
     (r := 1)
     (while (> i 0)
       ( (r := (* i r))
         (i := (- i 1)) ))))

(define (computeFact10)
  (run fact10))

;;;;;;;;;;;;;;

;; pomocnicza funkcja dla list tagowanych o określonej długości

(define (node l r)
  (list 'node l r))

(define (node? n)
  (tagged-tuple? 'node 3 n))

(define (node-left n)
  (second n))

(define (node-right n)
  (third n))

(define (leaf? n)
  (or (symbol? n)
      (number? n)
      (null? n)))

;;

(define (res v s)
  (cons v s))

(define (res-val r)
  (car r))

(define (res-state r)
  (cdr r))

;;

(define (rename t)
  (define (rename-st t i)
    (cond [(leaf? t) (res i (+ i 1))]
          [(node? t)
           (let* ([rl (rename-st (node-left t) i)]
                  [rr (rename-st (node-right t) (res-state rl))])
             (res (node (res-val rl) (res-val rr))
                  (res-state rr)))]))
  (res-val (rename-st t 0)))

;;

(define (st-app f x y)
  (lambda (i)
    (let* ([rx (x i)]
           [ry (y (res-state rx))])
      (res (f (res-val rx) (res-val ry))
           (res-state ry)))))

(define get-st
  (lambda (i)
    (res i i)))

(define (modify-st f)
  (lambda (i)
    (res null (f i))))

;;

(define (incc n)
  (+ n 1))

(define (rename2 t)
  (define (rename-st t)
    (cond [(leaf? t)
           (st-app (lambda (x y) x)
                   get-st
                   (modify-st incc))]
          [(node? t)
           (st-app node
                   (rename-st (node-left  t))
                   (rename-st (node-right t)))]))
  (res-val ((rename-st t) 0)))

;cw2

(define (rand max)
  (lambda (i)
    (let ([v (modulo (+ (* 1103515245 i) 12345) (expt 2 32))])
      (res (modulo v max) v))))

;(define (ran-tree t)
;  (define (help t state max)
;    (cond
;      [(leaf? t) ((rand max) state)

;cw3

(define fibb
  ' ((n := 10)
     (f1 := 0)
     (f2 := 1)
     (while (> n 0)
            (   (f2 := (+ f1 f2))
                (f1 := (- f2 f1))
                (n := (- n 1))))))

(define prime
  '( (res := 0)
     (n := 10)
     (a := 2)
     (while (> n 0)
            ( (l := 2)
              (flag := 1)
              (while (< l a)
                     ( (tmp := a)
                       (while (< 0 tmp)
                              ( (tmp := (- tmp l))))
                       (if (= tmp 0)
                           ( (flag := 0)
                             (l := a))
                           ((l := (+ l 1))))))
              (if (= flag 1)
                  ( (res := (+ res a))
                    (n := (- n 1))
                    (a := (+ a 1)))
                  (a := (+ a 1)))))))

;cw4

(define (vars program)
(define (set-var-mem v m)
  (if (member v m)
      m
      (cons v m)))
  (define (help program res)
    (cond
      [(assign? program) (set-var-mem (assign-var program) res)]
      [(if? program) (help (if-then program) (help (if-else program) res))]
      [(while? program) (help (while-expr program) res)]
      [(block? program) (if (null? program)
                            res
                            (help (cdr program) (help (car program) res)))]))
  (help program null))

;cw7

(define (zmien program)
  (cond
    [(for? program)
     (while-cons (for-cond program) (list (for-expr program) (for-change program)))]
    [(while? program)
     (while-cons (while-cond program) (zmien (while-expr program)))]
    [(if? program)
     (if-cons (if-cond program) (zmien (if-then program)) (zmien (if-else program)))]
    [(block? program)
     (if (null? program)
         null
         (append (list (zmien (car program))) (zmien (cdr program))))]
    [else program]))

