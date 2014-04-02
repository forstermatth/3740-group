; operations
(define oper (lambda (sym tokenlist)
               (cond
                 ((equal? sym "DROP")(drop))
                 ((equal? sym "POP") (pop))
                 ((equal? sym "SAVE") (save))
                 ((equal? sym "DUP") (dup))
                 ((equal? sym "SWAP") (swap))
                 ((equal? sym "STACK") (printall stack))
                 ((equal? sym "CLEAR") (clear))
                 ((equal? sym ".") (printone))
		 ((equal? sym "+") (plus))
		 ((equal? sym "-") (minus))
		 ((equal? sym "*") (mult))
		 ((equal? sym "/") (div))
		 ((equal? sym "<") (less))
		 ((equal? sym ">") (more))
		 ((equal? sym "<=") (lesseq))
		 ((equal? sym ">=") (moreeq))
                 (else (findfunc sym funclist))
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

(define (plus)
  (begin
    (define x (pop))
      (define y (pop))
       (push (+ y x))))

(define (minus)
  (begin
    (define x (pop))
      (define y (pop))
       (push (- y x))))

(define (mult)
  (begin
    (define x (pop))
      (define y (pop))
       (push (* y x))))

(define (div)
  (begin
    (define x (pop))
      (define y (pop))
       (push (/ y x))))

(define (less)
  (begin
    (define x (pop))
    (define y (pop))
    (cb (< y x))))
  
(define (more)
  (begin
    (define x (pop))
    (define y (pop))
    (cb (> y x))))
  
(define (lesseq)
  (begin
    (define x (pop))
    (define y (pop))
    (if (= x y)
        (push 1)
        (cb (< y x)))))
  
(define (moreeq)
  (begin
    (define x (pop))
    (define y (pop))
    (if (= x y)
        (push 1)
        (cb (> y x)))))


; conditionals --  transitive -- code follows
(define (ifcond tokens1 tokens2) 
  (define result (pop))
  (if (= result 1)
      (tokenhandler tokens1)
      (tokenhandler tokens2)))
  

; loop (single definition?) transitive -- code follows
(define (loop comp condi tokens)
  (begin 
    (push comp)
    (oper condi)
    (if (= (top) 1)
        (begin
          (tokenhandler tokens)
          (loop comp condi tokens))
        ())))

;functions 
(define (addfunc name tokens)
  (begin
    (set! funclist (cons (list name (parsefunc tokens)) funclist))
    (movetocnuf tokens)))

(define (findfunc name list)
  (if (equal? (car (car list)) name)
      (tokenhandler (car (cdr (car list))))
      (findfunc name (cdr list))))

(define (parsefunc list)
  (if(equal? (car list) "CNUF") 
     () 
     (cons (car list) (parsefunc (cdr list)))))

(define (movetocnuf tokens)
  (if(equal? (car tokens) "CNUF")
     tokens
     (movetocnuf (cdr tokens))))
  
      
;tokens
(define (tokenizer tokenlist str end)
  (begin
  (if (= (string-length str) end)
      (set! tokenlist (append tokenlist (list str)))
       (if (char=? (string-ref str end) #\space)
           (begin
             (set! tokenlist (append tokenlist (list (substring str 0 end))))
             (set! tokenlist (tokenizer tokenlist (substring str (+ end 1)) 1)))
          (set! tokenlist (tokenizer tokenlist str (+ end 1)))))
  tokenlist))

(define (tokenhandler tokenlist)
       (begin     
           (if (integer? (string->number (car tokenlist)))
               (push (string->number (car tokenlist)))
               (if(equal? (car tokenlist) "FUNC")
                  (set! tokenlist (addfunc (car (cdr tokenlist)) (cdr (cdr tokenlist))))
                  (oper (car tokenlist) (cdr tokenlist))))
           (set! tokenlist (cdr tokenlist))
           (if (null? tokenlist) 
	       ()
	       (tokenhandler tokenlist)))) 	
	

; stack()
(define stack `())
(define temp 0)

(define funclist `())

; helpers

(define (cb bool)
  (begin
    (if bool (push 1) (push 0))))

(define (top)
  (car stack))



