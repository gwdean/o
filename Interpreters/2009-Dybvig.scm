; Notes on the Metacircular Evaluator in Scheme
(define interpret #f)
(let ()
  (define primitive-environment)
  (define new-env)
  (define lookup)
  (define assign)
  (define exec)
  (set! interpret))

(define primitive-environment
  `((apply . ,apply)
    (assq  . ,assq)
    (symbol? . ,symbol?)))

(define new-env
  (lambda (formals actuals env)
    (cond
     ((null? formals) env)
     ((symbol? formals) (cons (cons formals actuals) env))
     (else
      (cons (cons (car formals) (car actuals))
	    (new-env (cdr formals) (cdr actuals) env))))))

(define lookup
  (lambda (var env)
    (cdr (assq var env))))

(define assign
  (lambda (var val env)
    (set-cdr! (assq var env) val)))

(define exec
  (lambda (exp env)
    (cond
     ((symbol? exp) (lookup exp env))
     ((pair? exp)
;    (...to be continued...)