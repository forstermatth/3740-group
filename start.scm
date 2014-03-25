; operations
(define oper (lambda (sym)
               (cond
                 ((equal? sym 'DROP) drop)
                 ((equal? sym 'POP) pop)
                 ((equal? sym 'SAVE) save)
                 ((equal? sym 'DUP) dup)
                 ((equal? sym 'SWAP) swap)
                 ((equal? sym 'STACK) printall)
                 ((equal? sym 'CLEAR) clear)
                 ((equal? sym '.) printone)
                 
(define (push x) ; passive to be called when literal is found
  (set! stack (cons x stack)))

(define (pop)
  (begin 
    (set! temp (car stack))
    (set! stack (cdr stack))
    temp))

(define (drop)
         
(define (save)
         
(define (dup)

(define (swap)
  
(define (printall)

(define (clear)
  
(define (printone)


; function definitions


; arithmetic (sorta the same as operations)
(define arithmetic (lambda (op)
                     (cond 
                       ((equal? op '+) plus)
                       ((equal? op '-) minus)
                       ((equal? op '*) mult)
                       ((equal? op '/) div))))

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

; conditionals --  transitive -- code follows


; loop (single definition?) transitive -- code follows



; stack
(define stack `())
(define temp 0)