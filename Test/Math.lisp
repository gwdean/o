; Test-driven Math in Common Lisp

; Functions to test
(defun square (x) (* x x))
(defun triple (x) (+ x x x))

; How things should work

(deftest test-square ()
  (check
    (= (square 0) 0)
    (= (square 1) 1)
    (= (square 2) 4)))

(deftest test-triple ()
  (check
    (= (triple 0) 0)
    (= (triple 1) 3)
    (= (triple 2) 6)))

