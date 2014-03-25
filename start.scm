; operations
(define oper (lambda (sym)
               (cond
                 ((equal? sym 'DROP)(drop))
                 ((equal? sym 'POP) (pop))
                 ((equal? sym 'SAVE) (save))
                 ((equal? sym 'DUP) (dup))
                 ((equal? sym 'SWAP) (swap))
                 ((equal? sym 'STACK) (printall stack))
                 ((equal? sym 'CLEAR) (clear))
                ; ((equal? sym '.) printone) ;wat
                 )))
                 
(define (push x) ; passive to be called when literal is found
  (set! stack (cons x stack)))

(define (pop)
  (begin 
    (set! temp (car stack))
    (set! stack (cdr stack))
    temp))

(define (drop)
  (set! stack (cdr stack)))
         
(define (save)
  (set! stack (cons temp stack)))
         
(define (dup)
  (set! stack (cons (car stack) stack)))
   
(define (swap)
  (begin
    (define first (pop))
    (define second (pop))
    (push first)
    (push second)))
  
(define (printall tempstack)
  (begin
    (newline)
    (if (null? tempstack) 
        (newline)
        (begin
          (display (car tempstack))
          (printall (cdr tempstack))))))
  

(define (clear)
  (set! stack ()))
  
(define (printone)
  (display (car stack)))


; function definitions


; arithmetic (sorta the same as operations)
(define ari (lambda (op)
                     (cond 
                       ((equal? op '+) (plus))
                       ((equal? op '-) (minus))
                       ((equal? op '*) (mult))
                       ((equal? op '/) (div))
                       ((equal? op '<) (less))
                       ((equal? op '>) (more))
                       ((equal? op '<=) (lesseq))
                       ((equal? op '>=) (moreeq)))))

(define (plus)
  (begin
    (define x (pop))
      (define y (pop))
       (push (+ x y))))

(define (minus)
  (begin
    (define x (pop))
      (define y (pop))
       (push (- x y))))

(define (mult)
  (begin
    (define x (pop))
      (define y (pop))
       (push (* x y))))

(define (div)
  (begin
    (define y (pop))
      (define x (pop))
       (push (/ x y))))

(define (less)
  (begin
    (define x (pop))
    (define y (pop))
    (cb (< x y))))
  
(define (more)
  (begin
    (define x (pop))
    (define y (pop))
    (cb (> x y))))
  
(define (lesseq)
  (begin
    (define x (pop))
    (define y (pop))
    (if (= x y)
        (push 1)
        (cb (< x y)))))
  
(define (moreeq)
  (begin
    (define x (pop))
    (define y (pop))
    (if (= x y)
        (push 1)
        (cb (> x y)))))

; conditionals --  transitive -- code follows


; loop (single definition?) transitive -- code follows



; stack
(define stack `())
(define temp 0)

; helpers

(define (cb bool)
  (begin
    (if bool (push 1) (push 0))))