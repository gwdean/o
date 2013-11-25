#lang racket

; Matrix and Vector Multiplication
; Adapted from R.Kent Dybvig's "The Scheme Programming Language" (MIT,2009)

; This program demonstrates a variety of basic programming techniques, such as
; - simple arithmetic and vector operations
; - looping with the do syntactic form
; - dispatching based on object type
; - raising exceptions

; Usage
; -----
; Scalar times scalar
; (mul 3 4) => 12
; 
; Scalar times vector
; (mul 1/2 '#(#(1 2 3))) => #(#(1/2 1 3/2))
;
; Scalar times matrix
;
; Vector times matrix
;
; Matrix times vector
;
; Matrix times matrix

; make-matrix creates a matrix (a vector of vectors).
(define make-matrix
  (lambda (rows columns)
    (do ([m (make-vector rows)]
         [i 0 (+ i 1)])
        ((= i rows) m)
      (vector-set! m i (make-vector columns)))))

; matrix? checks to see if its argument is a matrix.
; It is not foolproof, but works for most intents and purposes.
(define matrix?
  (lambda (x)
    (and (vector? x)
         (> (vector-length x) 0)
         (vector? (vector-ref x 0)))))

; matrix-rows returns the number of rows in a matrix.
(define matrix-rows
  (lambda (x)
    (vector-length x)))

; matrix-columns returns the number of columns in a matrix.
(define matrix-columns
  (lambda (x)
    (vector-length (vector-ref x 0))))

; matrix-ref returns the jth element of the ith row.
(define matrix-ref
  (lambda (m i j)
    (vector-ref (vector-ref m i) j)))

; matrix-set! changes the jth element of the ith row.
(define matrix-set!
  (lambda (m i j x)
    (vector-set! (vector-ref m i) j x)))

; mat-sca-mul multiplies a matrix by a scalar.
(define mat-sca-mul
  (lambda (m x)
    (let* ([nr (matrix-rows m)]
           [nc (matrix-columns m)]
           [r (make-matrix nr nc)])
      (do ([i 0 (+ i 1)])
          ((= i nr) r)
        (do ([j 0 (+ j 1)])
            ((= j nc))
          (matrix-set! r i j (* x (matrix-ref m i j))))))))

; mat-mat-mul multiplies one matrix by another, after verifying
; that the first matrix has as many columns as the second
; matrix has rows.
(define mat-mat-mul
  (lambda (m1 m2)
    (let* ([nr1 (matrix-rows m1)]
           [nr2 (matrix-rows m2)]
           [nc2 (matrix-columns m2)]
           [r (make-matrix nr1 nc2)])
      (unless (= (matrix-columns m1) nr2) (match-error m1 m2))
      (do ([i 0 (+ i 1)])
          ((= i nr1) r)
        (do ([j 0 (+ j 1)])
            ((= j nc2))
          (do ([k 0 (+ k 1)]
               [a 0 (+ a
                       (* (matrix-ref m1 i k)
                          (matrix-ref m2 k j)))])
            ((= k nr2)
             (matrix-set! r i j a))))))))

; type-error is called to complain when mul receives an invalid
; type of argument
(define type-error
  (lambda (what)
    (assertion-violation 'mul
      "not a number or matrix"
      what)))

; match-error is called to complain when mul receives a pair of
; incompatible arguments.
(define match-error
  (lambda (what1 what2)
    (assertion-violation 'mul
      "incompatible operands" what1
      what2)))

; mul is the generic matrix/scalar multiplication procedure
(define mul
  (lambda (x y)
    (cond
      [(number? x)
       (cond
         [(number? y) (* x y)]
         [(matrix? y) (mat-sca-mul y x)]
         [else (type-error y)])]
      [(matrix? x)
       (cond
         [(number? y) (mat-sca-mul x y)]
         [(matrix? y) (mat-mat-mul x y)]
         [else (type-error x)])])))