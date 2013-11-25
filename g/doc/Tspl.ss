; Notes on "The Scheme Programming Language"
; by Kent Dybvig. 2009.

; Online version of book can be found at:
; http://www.scheme.com/tspl

; Useful Functions
(define square
  (lambda (n)
    (* n n)))

; (square 5)
; (square -200)
; (square 0.5)
; (square -1/2)

(define reciprocal
  (lambda (n)
    (if (= n 0)
	"My bad!"
	(/ 1 n))))

; (reciprocal 10)
; (reciprocal 1/10)
; (reciprocal 0)
; (reciprocal (reciprocal 1/10))

; Variables and Let Expressions
; General Form: (let ((var expr) ...) body1 body2 ...)
(let ((x 2))
  (+ x 3))

(let ((y 3))
  (+ 2 y))

(let ((x 2) (y 3))
  (+ x y))

(let ((a (* 4 4))) (+ a a))

(let ([f +])
  (f 2 3))

(let ([f +] [x 2])
  (f x 3))

(let ([f +] [x 2] [y 3])
  (f x y))

; The variables bound by let are visible only within the body
; of the let
(let ([+ *])
  (+ 2 3))    ;=> 6

(+ 2 3)       ;=> 5

; It is possible to nest let expressions
(let ([a 4] [b -3])
  (let ([a-squared (* a a)]
	[b-squared (* b b)])
    (+ a-squared b-squared)))

; When nested let expressions bind the same variable, only the
; binding created by the inner let is visible within its body.

; Shadowing
(let ([x 1])
  (let ([x (+ x 1)])
    (+ x x)))

; Shadowing may be avoided by choosing different names for variables.
(let ([x 1])
  (let ([new-x (+ x 1)])
    (+ new-x new-x)))

; Lambda Expressions

; The syntactic form lambda can be used to create a new procedure
; that has x as a parameter and has the same body as the let 
; expression.
(lambda (x) (+ x x))

; The general form of a lambda expression is
(lambda (var ...) body1 body2 ...)

; A procedure is just as much an object as a number, string,
; symbol or pair.

; The most common operation to perform on a procedure is to
; apply it to one or more values.
((lambda (x) (+ x x)) (* 3 4))

; Because procedures are objects, we can establish a procedure
; as the value of a variable and use the procedure more
; than once.
(let ([double (lambda (x) (+ x x))])
  (list (double (* 3 4))
	(double (/ 99 11))
	(double (- 2 7))))

; Arguments passed to a procedure may themselves be procedures
(let ([double-any (lambda (f x) (f x x))])
  (list (double-any + 13)
	(double-any cons 'a)))  ;=> (26 (a . a))

; Lambda expressions can be nested with other Lambda 
; and Let expressions.
(let ([x 'a])
  (let ([f (lambda (y) (list x y))])
    (f 'b))) ;=> (a b)

; Top-Level Definitions
(define double-any
  (lambda (f x)
    (f x x)))

(double-any + 10)      ;=> 20
(double-any cons 'a)   ;=> (a . a)

; A Top-Level Definition may be established for any object,
; not just for procedures.
(define yo "Greg is the Man")

; Top-Level Definitions may be shadowed by let/lambda bindings.
(define xyz '(x y z))
(let ([xyz '(z y x)])
  xyz)

; Defining list using lambda
(define list (lambda x x))

; Alternative way to define functions
(define (cadr x)
  (car (cdr x)))

(define (list . x) x)

; Although the alternative syntax is shorter, it tends to
; mask the reality that procedures are not intimately tied
; to variables, or names, as they are in many other 
; languages.

; This syntax is often referred to as the "defun" syntax
; for define, after the defun form provided by Lisp
; languages in which procedures are more closely tied
; to their names.

; Doubler turns an "ordinary" two-argument procedure into
; a "doubling" one-argument procedure.
(define doubler
  (lambda (f)
    (lambda (x) (f x x))))

(define double (doubler +))
(double 13/2)

(define double-cons (doubler cons))
(double-cons 'a)

(define double-any
  (lambda (f x)
    ((doubler f) x)))

; Stack object implementation
; The procedure make-stack creates a new stack
; each time it is called.
(define make-stack
  (lambda ()
    (let ([ls '()])
      (lambda (msg . args)
	(cond
	 [(eqv? msg 'empty?) (null? ls)]
	 [(eqv? msg 'push!) (set! ls (cons (car args) ls))]
	 [(eqv? msg 'top) (car ls)]
         [(eqv? msg 'pop!) (set! ls (cdr ls))]
	 [else "My Bad!"])))))
       
