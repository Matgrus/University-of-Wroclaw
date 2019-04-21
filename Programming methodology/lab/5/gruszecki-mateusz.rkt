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

;; reprezentacja danych wejściowych (z ćwiczeń)
(define (var? x)
  (symbol? x))

(define (var x)
  x)

(define (var-name x)
  x)

;; przydatne predykaty na zmiennych
(define (var<? x y)
  (symbol<? x y))

(define (var=? x y)
  (eq? x y))

(define (literal? x)
  (and (tagged-tuple? 'literal 3 x)
       (boolean? (cadr x))
       (var? (caddr x))))

(define (literal pol x)
  (list 'literal pol x))

(define (literal-pol x)
  (cadr x))

(define (literal-var x)
  (caddr x))

(define (clause? x)
  (and (tagged-list? 'clause x)
       (andmap literal? (cdr x))))

(define (clause . lits)
  (cons 'clause lits))

(define (clause-lits c)
  (cdr c))

(define (cnf? x)
  (and (tagged-list? 'cnf x)
       (andmap clause? (cdr x))))

(define (cnf . cs)
    (cons 'cnf cs))

(define (cnf-clauses x)
  (cdr x))

;; oblicza wartość formuły w CNF z częściowym wartościowaniem. jeśli zmienna nie jest
;; zwartościowana, literał jest uznawany za fałszywy.
(define (valuate-partial val form)
  (define (val-lit l)
    (let ((r (assoc (literal-var l) val)))
      (cond
       [(not r)  false]
       [(cadr r) (literal-pol l)]
       [else     (not (literal-pol l))])))
  (define (val-clause c)
    (ormap val-lit (clause-lits c)))
  (andmap val-clause (cnf-clauses form)))

;; reprezentacja dowodów sprzeczności

(define (axiom? p)
  (tagged-tuple? 'axiom 2 p))

(define (proof-axiom c)
  (list 'axiom c))

(define (axiom-clause p)
  (cadr p))

(define (res? p)
  (tagged-tuple? 'resolve 4 p))

(define (proof-res x pp pn)
  (list 'resolve x pp pn))

(define (res-var p)
  (cadr p))

(define (res-proof-pos p)
  (caddr p))

(define (res-proof-neg p)
  (cadddr p))

;; sprawdza strukturę, ale nie poprawność dowodu
(define (proof? p)
  (or (and (axiom? p)
           (clause? (axiom-clause p)))
      (and (res? p)
           (var? (res-var p))
           (proof? (res-proof-pos p))
           (proof? (res-proof-neg p)))))

;; procedura sprawdzająca poprawność dowodu
(define (check-proof pf form)
  (define (run-axiom c)
    (displayln (list 'checking 'axiom c))
    (and (member c (cnf-clauses form))
         (clause-lits c)))
  (define (run-res x cpos cneg)
    (displayln (list 'checking 'resolution 'of x 'for cpos 'and cneg))
    (and (findf (lambda (l) (and (literal-pol l)
                                 (eq? x (literal-var l))))
                cpos)
         (findf (lambda (l) (and (not (literal-pol l))
                                 (eq? x (literal-var l))))
                cneg)
         (append (remove* (list (literal true x))  cpos)
                 (remove* (list (literal false x)) cneg))))
  (define (run-proof pf)
    (cond
     [(axiom? pf) (run-axiom (axiom-clause pf))]
     [(res? pf)   (run-res (res-var pf)
                           (run-proof (res-proof-pos pf))
                           (run-proof (res-proof-neg pf)))]
     [else        false]))
  (null? (run-proof pf)))


;; reprezentacja wewnętrzna

;; sprawdza posortowanie w porządku ściśle rosnącym, bez duplikatów
(define (sorted? vs)
  (or (null? vs)
      (null? (cdr vs))
      (and (var<? (car vs) (cadr vs))
           (sorted? (cdr vs)))))

(define (sorted-varlist? x)
  (and (list? x)
       (andmap var? x)
       (sorted? x)))

;; klauzulę reprezentujemy jako parę list — osobno wystąpienia pozytywne i negatywne. Dodatkowo
;; pamiętamy wyprowadzenie tej klauzuli (dowód) i jej rozmiar.
(define (res-clause? x)
  (and (tagged-tuple? 'res-int 5 x)
       (sorted-varlist? (second x))
       (sorted-varlist? (third x))
       (= (fourth x) (+ (length (second x)) (length (third x))))
       (proof? (fifth x))))

(define (res-clause pos neg proof)
  (list 'res-int pos neg (+ (length pos) (length neg)) proof))

(define (res-clause-pos c)
  (second c))

(define (res-clause-neg c)
  (third c))

(define (res-clause-size c)
  (fourth c))

(define (res-clause-proof c)
  (fifth c))

;; przedstawia klauzulę jako parę list zmiennych występujących odpowiednio pozytywnie i negatywnie
(define (print-res-clause c)
  (list (res-clause-pos c) (res-clause-neg c)))

;; sprawdzanie klauzuli sprzecznej
(define (clause-false? c)
  (and (null? (res-clause-pos c))
       (null? (res-clause-neg c))))

;; pomocnicze procedury: scalanie i usuwanie duplikatów z list posortowanych
(define (merge-vars xs ys)
  (cond [(null? xs) ys]
        [(null? ys) xs]
        [(var<? (car xs) (car ys))
         (cons (car xs) (merge-vars (cdr xs) ys))]
        [(var<? (car ys) (car xs))
         (cons (car ys) (merge-vars xs (cdr ys)))]
        [else (cons (car xs) (merge-vars (cdr xs) (cdr ys)))]))

(define (remove-duplicates-vars xs)
  (cond [(null? xs) xs]
        [(null? (cdr xs)) xs]
        [(var=? (car xs) (cadr xs)) (remove-duplicates-vars (cdr xs))]
        [else (cons (car xs) (remove-duplicates-vars (cdr xs)))]))

(define (rev-append xs ys)
  (if (null? xs) ys
      (rev-append (cdr xs) (cons (car xs) ys))))

;; TODO: miejsce na uzupełnienie własnych funkcji pomocniczych

#|
(define (find-var? var values)  ;wyszukiwanie zmiennej w liscie zmiennych
  (cond [(null? values) #f]
        [(var=? (car values) var) #t]
        [else (find-var? var (cdr values))]))
|#

(define (find-var? var values)  ;wyszukiwanie zmiennej w liscie zmiennych
  (cond [(null? values) #f]
        [(var=? (car values) var) #t]
        [(var<? var (car values)) #f]
        [else (find-var? var (cdr values))]))

(define (del-all x set) ; funkcja usuwajaca wszystkie wystapienia zmiennej "x" z wszystkich klauzul danej formuly (do zadania 2)
  (define (del x clause)
    (let ((y (list x)))
      (list (res-clause (remove* y (res-clause-pos clause)) (remove* y (res-clause-neg clause)) (res-clause-proof clause)))))
  (define (del-iter wyn x set)
    (if (null? set)
        wyn
        (del-iter (append (if (clause-false? (car (del x (car set)))) null (del x (car set)))  wyn) x (cdr set))))
  (del-iter null x set))

#|
(define (clause-trivial? c)
  (define (help-trivial pos-c neg-c)
    (if (or (null? pos-c) (null? neg-c))
        #f
        (let ([x (car pos-c)])
          (if (find-var? x neg-c)
              #t
              (help-trivial (cdr pos-c) neg-c)))))
  (help-trivial (res-clause-pos c) (res-clause-neg c)))
|#

(define (clause-trivial? c)
  (define (help-trivial pos-c neg-c)
      (cond
        [(or (null? pos-c) (null? neg-c)) #f]
        [(let ([x (car pos-c)])(find-var? x neg-c)) #t]
        [else (help-trivial (cdr pos-c) neg-c)]))
  (help-trivial (res-clause-pos c) (res-clause-neg c)))


(define (resolve c1 c2)
  (define (resolve-neg neg-c1 pos-c2)
    (if (or (null? neg-c1) (null? pos-c2))
        #f
        (let ([x1 (car neg-c1)])
          (if (find-var? x1 pos-c2)
              (res-clause (remove-duplicates-vars (merge-vars (res-clause-pos c1) (remove x1 (res-clause-pos c2))))
                          (remove-duplicates-vars (merge-vars (remove x1 (res-clause-neg c1)) (res-clause-neg c2)))
                          (proof-res x1 (res-clause-proof c2) (res-clause-proof c1)))
              (resolve-neg (cdr neg-c1) pos-c2)))))
  (define (resolve-pos pos-c1 neg-c2)
    (if (or (null? pos-c1) (null? neg-c2))
        #f
        (let ([x1 (car pos-c1)])
          (if (find-var? x1 neg-c2)
              (res-clause (remove-duplicates-vars (merge-vars (remove x1 (res-clause-pos c1)) (res-clause-pos c2)))
                          (remove-duplicates-vars (merge-vars (res-clause-neg c1) (remove x1 (res-clause-neg c2))))
                          (proof-res x1 (res-clause-proof c1) (res-clause-proof c2)))
              (resolve-pos (cdr pos-c1) neg-c2)))))
  (if (and (null? (res-clause-pos c1)) (null? (res-clause-neg c1)))
      #f
      (if (null? (res-clause-neg c1))
          (resolve-pos (res-clause-pos c1) (res-clause-neg c2))
          (resolve-neg (res-clause-neg c1) (res-clause-pos c2))
          ))
)




(define (resolve-single-prove s-clause checked pending)
  ;; TODO: zaimplementuj!
  ;; Poniższa implementacja działa w ten sam sposób co dla większych klauzul — łatwo ją poprawić!
  (let* ((resolvents   (filter-map (lambda (c) (resolve c s-clause))
                                     checked))
         (sorted-rs    (sort resolvents < #:key res-clause-size)))
    (subsume-add-prove (cons s-clause checked) pending sorted-rs)))

;; wstawianie klauzuli w posortowaną względem rozmiaru listę klauzul
(define (insert nc ncs)
  (cond
   [(null? ncs)                     (list nc)]
   [(< (res-clause-size nc)
       (res-clause-size (car ncs))) (cons nc ncs)]
   [else                            (cons (car ncs) (insert nc (cdr ncs)))]))

;; sortowanie klauzul względem rozmiaru (funkcja biblioteczna sort)
(define (sort-clauses cs)
  (sort cs < #:key res-clause-size))

;; główna procedura szukająca dowodu sprzeczności
;; zakładamy że w checked i pending nigdy nie ma klauzuli sprzecznej
(define (resolve-prove checked pending)
  (cond
   ;; jeśli lista pending jest pusta, to checked jest zamknięta na rezolucję czyli spełnialna
   [(null? pending) (generate-valuation (sort-clauses checked))]
   ;; jeśli klauzula ma jeden literał, to możemy traktować łatwo i efektywnie ją przetworzyć
   [(= 1 (res-clause-size (car pending)))
    (resolve-single-prove (car pending) checked (cdr pending))]
   ;; w przeciwnym wypadku wykonujemy rezolucję z wszystkimi klauzulami już sprawdzonymi, a
   ;; następnie dodajemy otrzymane klauzule do zbioru i kontynuujemy obliczenia
   [else
    (let* ((next-clause  (car pending))
           (rest-pending (cdr pending))
           (resolvents   (filter-map (lambda (c) (resolve c next-clause))
                                     checked))
           (sorted-rs    (sort-clauses resolvents)))
      (subsume-add-prove (cons next-clause checked) rest-pending sorted-rs))]))

;; procedura upraszczająca stan obliczeń biorąc pod uwagę świeżo wygenerowane klauzule i
;; kontynuująca obliczenia. Do uzupełnienia.
(define (subsume-add-prove checked pending new)
  (cond
   [(null? new)                 (resolve-prove checked pending)]
   ;; jeśli klauzula do przetworzenia jest sprzeczna to jej wyprowadzenie jest dowodem sprzeczności
   ;; początkowej formuły
   [(clause-false? (car new))   (list 'unsat (res-clause-proof (car new)))]
   ;; jeśli klauzula jest trywialna to nie ma potrzeby jej przetwarzać
   [(clause-trivial? (car new)) (subsume-add-prove checked pending (cdr new))]
   [else
    ;; TODO: zaimplementuj!
    ;; Poniższa implementacja nie sprawdza czy nowa klauzula nie jest lepsza (bądź gorsza) od już
    ;; rozpatrzonych; popraw to!
    (subsume-add-prove checked (insert (car new) pending) (cdr new))
    ]))


(define (generate-valuation resolved)
  (define (help-gen wyn res)
      (if (null? res)
          (append (list 'sat wyn))
          (let ([x1 (car (flatten (print-res-clause (car res))))])
            (if (find-var? x1 (res-clause-pos (car res)))
            (help-gen (append (list (list x1 #t)) wyn) (del-all x1 res))
            (help-gen (append (list (list x1 #f)) wyn) (del-all x1 res))
            ))))
  (help-gen null resolved))


;; procedura przetwarzające wejściowy CNF na wewnętrzną reprezentację klauzul
(define (form->clauses f)
  (define (conv-clause c)
    (define (aux ls pos neg)
      (cond
       [(null? ls)
        (res-clause (remove-duplicates-vars (sort pos var<?))
                    (remove-duplicates-vars (sort neg var<?))
                    (proof-axiom c))]
       [(literal-pol (car ls))
        (aux (cdr ls)
             (cons (literal-var (car ls)) pos)
             neg)]
       [else
        (aux (cdr ls)
             pos
             (cons (literal-var (car ls)) neg))]))
    (aux (clause-lits c) null null))
  (map conv-clause (cnf-clauses f)))

(define (prove form)
  (let* ((clauses (form->clauses form)))
    (subsume-add-prove '() '() clauses)))

;; procedura testująca: próbuje dowieść sprzeczność formuły i sprawdza czy wygenerowany
;; dowód/waluacja są poprawne. Uwaga: żeby działała dla formuł spełnialnych trzeba umieć wygenerować
;; poprawną waluację.
(define (prove-and-check form)
  (let* ((res (prove form))
         (sat (car res))
         (pf-val (cadr res)))
    (if (eq? sat 'sat)
        (valuate-partial pf-val form)
        (check-proof pf-val form))))

;;; TODO: poniżej wpisz swoje testy


(define jeden-cnf (cnf (clause (literal #t 'p) (literal #t 'q)) (clause (literal #f 'p) (literal #t 'q) (literal #t 'r))))
(define jeden-clause (form->clauses jeden-cnf))
(define test-jeden (resolve-prove null jeden-clause))

(define dwa-cnf (cnf (clause (literal #t 'p)) (clause (literal #f 'p))))
(define dwa-clause (form->clauses dwa-cnf))
(define test-dwa (resolve-prove null dwa-clause))

(define trzy-cnf (cnf (clause (literal #t 'p) (literal #t 'q)) (clause (literal #f 'p) (literal #t 'r)) (clause (literal #f 'q)) (clause (literal #f 'r))))
(define trzy-clause (form->clauses trzy-cnf))
(define test-trzy (resolve-prove null trzy-clause))

(define cztery-cnf (cnf (clause (literal #t 'p) (literal #t 'q)) (clause (literal #f 'p) (literal #t 'q)) (clause (literal #t 'q) (literal #f 's))
                        (clause (literal #f 'r) (literal #t 'q) (literal #f 's) (literal #t 'u) (literal #f 'p))))
(define cztery-clause (form->clauses cztery-cnf))
(define test-cztery (resolve-prove null cztery-clause))

(define test-trivial (form->clauses (cnf (clause (literal #f 'r) (literal #f 'p) (literal #f 'q) (literal #t 'p)))))



(resolve (first jeden-clause) (second jeden-clause)) ; test resolve dla klauzul ('p v 'q) oraz ('~p v 'q v 'r)
(resolve (third trzy-clause) (fourth trzy-clause))  ; test resolve dla klauzul ('~q) oraz ('~r)

(clause-trivial? (second jeden-clause)) ;dwa testy clause-trivial?
(clause-trivial? (car test-trivial)) 

(prove-and-check jeden-cnf) ;test dla formuly spelnialnej
(prove-and-check dwa-cnf)  ;dwa testy dla formul niespelnialnych
(prove-and-check trzy-cnf)
(prove-and-check cztery-cnf) ;test dla formuly spelnialnej

(prove jeden-cnf) ; wynik dzialania generate-valuation dla dwoch spelnialnych formul
(prove cztery-cnf)