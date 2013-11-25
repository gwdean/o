#lang racket
; Grades.rkt
; An implementation of the (grades) library from TSPL.86
; For some reason "assertion-violation" is not working in DrRacket.
; So I took the "assert-violation" out of the "letter->number" function.
(define in-range?
  (lambda (x n y)
    (and (>= n x) (< n y))))


(define letter->number
  (lambda (x)
    (case x
      [(a) 4.0]
      [(b) 3.0]
      [(c) 2.0]
      [(d) 1.0]
      [(f) 0.0])))

(define gpa->grade
  (lambda (x)
    (range-case x
      [(0.0 - 0.5) 'f]
      [(0.5 - 1.5) 'd]
      [(1.5 - 2.5) 'c]
      [(2.5 - 3.5) 'b]
      [else 'a])))