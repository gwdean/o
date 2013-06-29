;; Page 95 of /On Lisp/ Paul Graham provides
;; a general model of /defmacro/. While not
;; complete, this model covers all but the
;; most esoteric macros. It works with every
;; function in the book.

(defmacro our-expander (name) '(get ,name 'expander))

(defmacro our-defmacro (name parms &body body)
  (let ((g (gensym)))
    '(progn
      (setf (our-expander ',name)
            #'(lambda (,g)
		(block ,name
		  (destructuring-bind ,parms (cdr ,g)
		    ,@body))))
      ',name)))

(defun our-macroexpand-1 (expr)
  (if (and (consp expr) (our-expander (car expr)))
      (funcall (our-expander (car expr)) expr)
      expr))