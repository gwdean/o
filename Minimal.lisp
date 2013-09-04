; Minimal.lisp

; This is a collection of Lisp gems curated by gwdean.
; The goal of this software is beauty. 

; S-expressions
(()())

; Prefix notation
(+ (* a b) (* c d))

; Atom
1

; List
(1 2 3)
((x 1) (y 2) (z 3))

; Function
(f x y)

; if form
(if condition true-value false-value)

(if true (+ 1 2) (+ 3 4))  ; gives 3
(if false (+ 1 2) (+ 3 4)) ; gives 4

; quote function
(' (a b c))

; equality
(= x y)

; atom
(atom x)

; let
(let x y expression)

(let n (+ 1 2)
  (* 3 n)
)

(let (f n) (* n n)
  (f 10)
)

; car
(car (' (a b c)))

; cdr
(cdr (' (a b c)))

; cons
(cons (' a) (' (b c)))

; factorial
(let (factorial N)
        (if (= N 0)
            1
            (* N (factorial (- N 1)))
	)
  (factorial 5)
)

; list of factorials
(let (factorial N)
        (if (= N 0)
	    1
	    (* N (factorial (- N 1)))
	)
  (let (map f x)
     (if (atom x)
	 x
	 (cons (f (car x))
	       (map f (cdr x))
	 )
     )
  (map factorial (' (4 1 3 2 5)))

))
; Sources
; 2005-Chaitin