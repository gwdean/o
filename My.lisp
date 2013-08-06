; My.lisp is an experiment in Literate Programming
; in Common Lisp. Over the past several months and 
; years I have worked through numerous programming
; books, and I keep coming back to the lambda 
; programming languages. I fluctuate between Scheme
; and Common Lisp, but of late (6/2013) I have 
; been focusing more on Common Lisp for a few 
; reasons. 

; (...list reasons...)

; Anyway after scanning all these books and gaining
; a global understanding of many of them, notably
; 1994-Graham, 1996-Graham, 1985-Abelson, 1996-Friedman,
; 2011-Barski, 2008-Hoyte, 1989-Keene, 2009-Dybvig,
; 2005-Seibel, 2008-Crockford, etc...I am going to focus
; intently on mastering the 2013-Touretzky. This is
; where I will start in my experiment.

;;; -*- Mode: Lisp; Package: USER -*-
;;;
;;; PPMX - pretty prints a macro expansion
;;;
;;; From the book "Common Lisp:  A Gentle Introduction to
;;;      Symbolic Computation" by David S. Touretzky.  
;;; The Benjamin/Cummings Publishing Co., 1990.
;;;
;;; Example of use:  (ppmx (incf a))


(defmacro ppmx (form)
  "Pretty prints the macro expansion of FORM."
  `(let* ((exp1 (macroexpand-1 ',form))
	  (exp (macroexpand exp1))
	  (*print-circle* nil))
     (cond ((equal exp exp1)
	    (format t "~&Macro expansion:")
	    (pprint exp))
	   (t (format t "~&First step of expansion:")
	      (pprint exp1)
	      (format t "~%~%Final expansion:")
	      (pprint exp)))
     (format t "~%~%")
     (values)))

; Run-length encoding: Compression. (1996-Graham.(37))
(defun compress (x)
  (if (consp x)
      (compr (car x) 1 (cdr x))
      x))

(defun compr (elt n lst)
  (if (null lst)
      (list (n-elts elt n))
      (let ((next (car lst)))
	(if (eql next elt)
	    (compr elt (+ n 1) (cdr lst))
	    (cons (n-elts elt n)
		  (compr next 1 (cdr lst)))))))

(defun n-elts (elt n)
  (if (> n 1)
      (list n elt)
      elt))

(defun uncompress (lst)
  (if (null lst)
      nil
      (let ((elt (car lst))
	    (rest (uncompress (cdr lst))))
	(if (consp elt)
	    (append (apply #'list-of elt)
		    rest)
	    (cons elt rest)))))

(defun list-of (n elt)
  (if (zerop n)
      nil
      (cons elt (list-of (- n 1) elt))))


; Inheritance (1996 Graham 270)
(defun rget (prop obj)
  (multiple-value-bind (val in) (gethash prop obj)
    (if in
        (values val in)
	(let ((par (gethash :parent obj)))
	  (and par (rget prop par))))))

(defun tell (obj message &rest args)
  (apply (rget message obj) obj args))