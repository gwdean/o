; "Implementing do" from Paul Graham. /On Lisp/

(defmacro our-do (bindforms (test &rest result) &body body)
  (let ((label (gensym)))
    '(prog ,(make-initforms bindforms)
      ,label
      (if ,test
	  (return (progn ,@result)))
      ,@body
      (psetq ,@(make-stepforms bindforms))
      (go ,label))))

(defun make-initforms (bindforms)
  (mapcan #'(lambda (b)
	      (if (and (consp b) (third b))
		  (list (car b) (third b))
		  nil))
	  bindforms))

(defun make-stepforms (bindforms)
  (mapcan #'(lambda (b)
	      (if (and (consp b) (third b))
		  (list (car b) (third b))
		  nil))
	  bindforms))
