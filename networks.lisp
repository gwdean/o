; adapted from Paul Graham's "On Lisp", pp.76-79

; Representation and definition of nodes
(defstruct node contents yes no)

(defvar *nodes* (make-hash-table))

(defun defnode (name conts &optional yes no)
  (setf (gethash name *nodes*)
	(make-node :contents conts
		   :yes      yes
		   :no       no)))

; Function for traversing networks.
(defun run-node (name)
  (let ((n (gethash name *nodes*)))
    (cond ((node-yes n)
	   (case (read)
	     (yes (run-node (node-yes n)))
	     (t   (run-node (node-no n)))))
	  (t (node-contents n)))))