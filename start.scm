; globals
(define stack `())
(define prev2 `())
(define temp 0)
(define inputbuffer 0)
(define input `())
(define funclist `())

; helpers
(define (cb bool)
  (begin
    (if bool (push 1) (push 0))))

(define (top)
  (car stack))

(define (lastof l)
  (cond ((null? (cdr l)) (car l))
        (else (lastof (cdr l)))))

(define (removelast l)
  (reverse (cdr (reverse l))))

(define (moveto tokens sentinel)
  (if(equal? (car tokens) sentinel)
     tokens
     (moveto (cdr tokens) sentinel)))

(define (upto tokens sentinel)
  (if(equal? (car tokens) sentinel)
     ()
     (cons (car tokens) (upto (cdr tokens) sentinel))))

; operations
(define oper (lambda (sym tokenlist)
               (begin
                 (display stack)
               (cond
                 ((integer? (string->number sym)) 
                  (begin
                    (push (string->number sym))))
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
                 ((equal? sym "LOOP") 
                  (begin
                    (set! prev2 (removelast prev2))
                    (loopcomp (car prev2) (car (cdr prev2)) tokenlist)))
                 ((equal? sym "IF") 
                    (ifcond (upto tokenlist "ELSE") (upto (cdr (moveto tokenlist "ELSE")) "THEN")))
                 ((equal? sym "FUNC") (addfunc (car tokenlist) (cdr tokenlist)))
                 (else (findfunc sym funclist)))
                 )))
                 
(define (push x) ; passive to be called when literal is found
  (set! stack (cons x stack)))

(define (pop)
  (begin
    (if (null? stack)
      (begin
        (display "nothing to drop")
        (newline))
       (begin 
         (set! temp (car stack))
         (set! stack (cdr stack))
         temp))))

(define (drop)
  (begin
    (define local ())
    (if (null? stack)
      (begin
        (display "nothing to drop")
        (newline))
      (begin
        (set! local (car stack))
        (set! stack (cdr stack))
        local))))
         
(define (save)
  (set! stack (cons temp stack)))
         
(define (dup)
  (set! stack (cons (car stack) stack)))
   
(define (swap)
  (begin
    (define first (drop))
    (define second (drop))
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
  (set! stack '()))
  
(define (printone)
  (display (car stack))(newline))

(define (plus)
  (begin
    (define x (drop))
      (define y (drop))
       (push (+ y x))))

(define (minus)
  (begin
    (define x (drop))
      (define y (drop))
       (push (- y x))))

(define (mult)
  (begin
    (define x (drop))
      (define y (drop))
       (push (* y x))))

(define (div)
  (begin
    (define x (drop))
      (define y (drop))
       (push (/ y x))))

(define (less)
  (begin
    (define x (drop))
    (define y (drop))
    (cb (< y x))))
  
(define (more)
  (begin
    (define x (drop))
    (define y (drop))
    (cb (> y x))))
  
(define (lesseq)
  (begin
    (define x (drop))
    (define y (drop))
    (if (= x y)
        (push 1)
        (cb (< y x)))))
  
(define (moreeq)
  (begin
    (define x (drop))
    (define y (drop))
    (if (= x y)
        (push 1)
        (cb (> y x)))))

; if
(define (ifcond tokens1 tokens2) 
  (define result (top))
  (if (= result 1)
      (tokenhandler tokens1)
      (tokenhandler tokens2)))
  
; loop
(define (loopcomp condi comp tokens)
  (begin
    (if (= (top) 1)
        (begin
          (tokenhandler tokens)
          (oper condi '())
          (oper comp `())
          (loopcomp condi comp tokens))
        (values))))

;functions 
(define (printfuncs funcs)
  (if (pair? funcs)
      (begin
        (display (car(car funcs)))
        (newline)
        (printfuncs (cdr funcs)))
      (values)))

(define (addfunc name tokens)
  (begin
    (set! funclist (cons (list name tokens) funclist))
    (printfuncs funclist)))

(define (findfunc name list)
  (if (pair? list)
      (if (equal? (car (car list)) name)
          (tokenhandler (car (cdr (car list))))
            (findfunc name (cdr list)))
      (begin
        (display "Function not found: ")
        (display name)
        (newline))))

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
         (set! prev2 (append prev2 (list(car tokenlist))))
         
         (if (< 3 (length prev2))
           (set! prev2 (cdr prev2))
           (values))
         (cond 
             ((equal? (car tokenlist) "LOOP")
              (begin
                (oper (car tokenlist) (upto (cdr tokenlist) "POOL"))
                (set! tokenlist (moveto tokenlist "POOL"))))
             ((equal? (car tokenlist) "FUNC")
              (begin
                (oper (car tokenlist) (upto (cdr tokenlist) "CNUF"))
                (set! tokenlist (moveto tokenlist "CNUF"))))
             ((equal? (car tokenlist) "IF")
              (begin
                (oper (car tokenlist) (cdr tokenlist)))
                (set! tokenlist (moveto tokenlist "THEN")))
             (else (oper (car tokenlist) (cdr tokenlist))))
         (set! tokenlist (cdr tokenlist))
         (if (null? tokenlist)
	     (values)
	     (tokenhandler tokenlist))))

;parsing input
(define (main)
  (display "UOFL > ")
  (set! input '())
  (read-line)
  (if (null? input)
      (values)
      (begin
       (set! input (removelast input))
       (set! input (tokenizer `() (list->string input) 1))
       (tokenhandler input)
       (main))))
  
(define (read-line)
  (begin
    (set! inputbuffer (read-char))
    (if (char? inputbuffer)
        (set! inputbuffer (char-upcase inputbuffer)))
    (if (eof-object? inputbuffer) 
        (values)
        (begin
          (set! input (append input (list inputbuffer)))
          (if (equal? #\newline (lastof input))
              (values)
              (read-line))))))

    
              
        

