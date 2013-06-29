; *Finite state machines* are a technique from
; theoretical computer science for describing
; how simple devices work.

; This section implements a general purpose
; simulator for finite state machines.

; The example given in Touretzky-2013 is a 
; vending machine example, but the core simulator
; is not limited to vending machines. 

; Any device that can be described in a finite
; number of states and state transitions can
; be simulated by this program.

(defstruct (node (:print-function print-node))
  (name nil)
  (inputs nil)
  (outputs nil))

(defun print-node (node stream depth)
  (format stream "#<Node ~A>"
	  (node-name node)))

(defstruct (arc (:print-function print-arc))
  (from nil)
  (to nil)
  (label nil)
  (action nil))

(defun print-arc (arc stream depth)
  (format stream "#<ARC ~A / ~A / ~A>"
	  (node-name (arc-from arc))
	  (arc-label arc)
	  (node-name (arc-to arc))))

(defvar *nodes*)
(defvar *arcs*)
(defvar *current-node*)

(defun initialize ()
  (setf *nodes* nil)
  (setf *arcs* nil)
  (setf *current-node* nil))

(defmacro defnode (name)
  `(add-node ',name))

(defun add-node (name)
  (let ((new-node (make-node :name name)))
    (setf *nodes* (nconc *nodes* (list new-node)))
    new-node))

(defun find-node (name)
  (or (find name *nodes* :key #'node-name)
      (error "No node named ~A exists." name)))

(defmacro defarc (from label to &optional action)
  `(add-arc ',from ',label ',to ',action))

(defun add-arc (from-name label to-name action)
  (let* ((from (find-node from-name))
	 (to (find-node to-name))
	 (new-arc (make-arc :from from
			    :label label
			    :to to
			    :action action)))
    (setf *arcs* (nconc *arcs* (list new-arc)))
    (setf (node-outputs from)
	  (nconc (node-outputs from)
		 (list new-arc)))
    (setf (node-inputs to)
	  (nconc (node-inputs to)
		 (list new-arc)))
    new-arc))

(defun fsm (&optional (starting-point 'start))
  (setf *current-node* (find-node starting-point))
  (do ()
      ((null (node-outputs *current-node*)))
    (one-transition)))

(defun one-transition ()
  (format t "~&State ~A. Input: "
	  (node-name *current-node*))
  (let* ((ans (read))
	 (arc (find ans
		    (node-outputs *current-node*)
		    :key #'arc-label)))
    (unless arc
      (format t "~&No arc from ~A has label ~A.~%"
              (node-name *current-node*) ans)
      (return-from one-transition nil))
    (let ((new (arc-to arc)))
      (format t "~&~A" (arc-action arc))
      (setf *current-node* new))))
	  
(defnode start)
(defnode have-5)
(defnode have-10)
(defnode have-15)
(defnode have-20)
(defnode end)

(defarc start   nickel        have-5   "Clunk!") 
(defarc start   dime          have-10  "Clink!")
(defarc start   coin-return   start    "Nothing to return.")
(defarc have-5  nickel        have-10  "Clunk!")
(defarc have-5  dime          have-15  "Clink!")
(defarc have-5  coin-return   start    "Returned five cents.")
(defarc have-10 nickel        have-15  "Clunk!")
(defarc have-10 dime          have-20  "Clink!")
(defarc have-10 coin-return   start    "Returned ten cents.")
(defarc have-15 nickel        have-20  "Clunk!")
(defarc have-15 dime          have-20  "Nickel change.")
(defarc have-15 gum-button    end      "Deliver gum.")
(defarc have-15 coin-return   start    "Returned fifteen cents.")
(defarc have-20 nickel        have-20  "Nickel returned.")
(defarc have-20 dime          have-20  "Dime returned.")
(defarc have-20 gum-button    end      "Deliver gum, nickel change.")
(defarc have-20 mint-button   end      "Deliver mints.")  
(defarc have-20 coin-return   start    "Returned twenty cents.")

(fsm)

; Compiler Code

(defun compile-arc (arc)
  (let ((a (arc-action arc)))
    `((equal this-input ',(arc-label arc))
      (format t "~&~A" ,a)
      (, (node-name (arc-to arc))
	 (rest input-syms)))))

(defun compile-node (node)
  (let ((name (node-name node))
	(arc-clauses
	 (mapcar #'compile-arc
		 (node-outputs node))))
    `(defun ,name (input-syms
		   &aux (this-input
			 (first input-syms)))
       (cond ((null input-syms) ',name)
	     ,@arc-clauses
	     (t (format t
       "~&There is no arc from ~A with label ~S"
                  ',name this-input))))))

(defmacro compile-machine ()
  `(progn ,@(mapcar #'compile-node *nodes*)))

(compile-machine)

; Simplified data set
(defnode 0)
(defnode 1)
(defnode 2)
(defnode 3)
(defnode 4)
(defnode 5)

(defarc 0 x 1)
(defarc 0 x 2)
(defarc 0 x 0)
