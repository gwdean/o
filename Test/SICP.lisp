; Code from Eli Bendersky's SICP Examples

; 1.3.1
(defun cube (x)
  (* x x x))

(defun sum (term a next b)
  (if (> a b)
    0
    (+ (funcall term a)
       (sum term (funcall next a) next b))))

(defun sum-integers (a b)
  (sum #'identity a #'1+ b))

(defun pi-sum (a b)
  (defun pi-term (x)
    (/ 1.0 (* x (+ x 2))))
  (defun pi-next (x)
    (+ x 4))
  (sum #'pi-term a #'pi-next b))

(defun integral (f a b dx)
  (defun add-dx (x)
    (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) #'add-dx b)
     dx))
