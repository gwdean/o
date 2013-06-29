; A collection of eight different kinds of 
; recursion as described in Chapter 8 of 
; David Touretzky's "Common Lisp: A Gentle
; Introduction to Symbolic Computation.

; Double-Test Tail Recursion
(defun anyoddp (x)
  (cond ((null x) nil)
	((oddp (first x)) t)
	(t (anyoddp (rest x)))))

; Single-Test Tail Recursion
(defun find-first-atom (x)
  (cond ((atom x) x)
	(t (find-first-atom (first x)))))

; Single-Test Augmenting Recursion
(defun count-slices (x)
  (cond ((null x) 0)
	(t (+ 1 (count-slices (rest x))))))

; List-Consing Recursion 
; (A Special Case of Augmenting Recursion)
(defun laugh (n)
  (cond ((zerop n) nil)
	(t (cons 'ha (laugh (- n 1))))))

; Simultaneous Recursion on Several Variables
; (Using the Single-Test Tail Recursion Template)
(defun my-nth (n x)
  (cond ((zerop n) (first x))
	(t (my-nth (- n 1) (rest x)))))

; Conditional Augmentation
(defun extract-symbols (x)
  (cond ((null x) nil)
	((symbolp (first x))
	 (cons (first x) 
	       (extract-symbols (rest x))))
	(t (extract-symbols (rest x)))))

; Multiple Recursion
(defun fib (n)
  (cond ((equal n 0) 1)
	((equal n 1) 1)
	(t (+ (fib (- n 1))
	      (fib (- n 2))))))

; CAR/CDR Recursion
; (A Special Case of Multiple Recursion)
(defun find-number (x)
  (cond ((numberp x) x)
	((atom x) nil)
	(t (or (find-number (car x))
	       (find-number (cdr x))))))