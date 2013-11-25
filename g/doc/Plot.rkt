#lang racket   
; draw a graph of cos and deriv^3(cos)
(require plot) 

(define ((deriv f) x)
  (/ (- (f x) (f (- x 0.001))) 0.001))

(define (square x) (* x x))

(define (twice f) (lambda (x) (f (f x))))

(define (thrice f) (lambda (x) (f (f (f x)))))

(plot (list (function ((twice deriv) sin) -5 5 #:color 'green)
            (function ((thrice deriv) sin) -5 5 #:color 'yellow)
            (function cos -5 5 #:color 'blue)))
