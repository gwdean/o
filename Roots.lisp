; Roots.lisp

; An implementation of the interpreter presented 
; in Paul Graham's "Roots of Lisp". (2002)

; Eval. The main function.
(defun eval. (e a)
  (cond
    ((atom e) (assoc. e a))
    ((atom (car e))
     (cond
       ((eq (car e) 'quote) (cadr e))
       ((eq (car e) 'atom)  (atom   (eval. (cadr e) a)))
       ((eq (car e) 'eq)    (eq     (eval. (cadr e) a) (eval. (caddr e) a)))
       ((eq (car e) 'car)   (car    (eval. (cadr e) a)))
       ((eq (car e) 'cdr)   (cdr    (eval. (cadr e) a)))
       ((eq (car e) 'cons)  (cons   (eval. (cadr e) a) (eval. (caddr e) a)))
       ((eq (car e) 'cond)  (evcon. (cdr e) a))
       ('t (eval. (cons (assoc. (car e) a)
			(cdr e))
		  a))))
    ((eq (caar e) 'label)
     (eval. (cons (caddar e) (cdr e))
	    (cons (list (cadar e) (car e)) a)))
    ((eq (caar e) 'lambda)
     (eval. (caddar e)
	    (append. (pair. (cadar e) (evlis. (cdr e) a))
		     a)))))

(defun evcon. (c a)
  (cond ((eval. (caar c) a)
	 (eval. (cadar c) a))
	('t (evcon. (cdr c) a))))

(defun evlis. (m a)
  (cond ((null. m) '())
	('t (cons (eval.  (car m) a)
		  (evlis. (cdr m) a)))))

; Auxiliary functions.

(defun assoc. (x y)
  (cond ((eq (caar y) x) (cadar y))
	('t (assoc. x (cdr y)))))

(defun null. (x)
  (eq x '()))

(defun append. (x y)
  (cond ((null. x) y)
	('t (cons (car x) (append. (cdr x) y)))))

(defun pair. (x y)
  (cond ((and. (null. x) (null. y)) '())
	((and. (not. (atom x)) (not. (atom y)))
	 (cons (list (car x) (car y))
	       (pair. (cdr x) (cdr y))))))

(defun and. (x y)
  (cond (x (cond (y 't) ('t '())))
	('t '())))

(defun not. (x)
  (cond (x '())
	('t 't)))

; Seven Primitives

; (quote x) 
; (atom x) 
; (eq x y) 
; (car x) 
; (cdr x) 
; (cons x y) 
; (cond (p1 e1) ... (pn en))

; Tests

> (eval. 'x '((x a) (y b))) 
a

> (eval. '(eq 'a 'a) '())
t

> (eval. '(cons x '(b c))
	 '((x a) (y b)))
(a b c)




; Greg Dean.