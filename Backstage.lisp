; Basic Backstage Structures

; Example CLOS Program

(defclass rectangle ()
     ((height :initform 0.0 :initarg :height)
      (width  :initform 0.0 :initarg :width)))

(defclass color-mixin ()
     ((cyan     :initform 0 :initarg :cyan)
      (magenta  :initform 0 :initarg :magenta)
      (yellow   :initform 0 :initarg :yellow)))

(defclass color-rectangle (color-mixin rectangle)
     ((clearp :initform (y-or-n-p "But is it transparent?")
              :initarg :clearp :accessor clearp)))

(defgeneric paint (x))

(defmethod paint ((x rectangle))                ;Method #1
  (vertical-stroke (slot-value x 'height)
                   (slot-value x 'width)))

(defmethod paint :before ((x color-mixin))      ;Method #2
  (set-brush-color (slot-value x 'cyan)
                   (slot-value x 'magenta)
		   (slot-value x 'yellow)))

(defmethod paint ((x color-rectangle))          ;Method #3
  (unless (clearp x) (call-next-method)))

(setq door
      (make-instance 'color-rectangle
        :width 38 :height 84 :cyan 60 :yellow 55 :clearp nil))

; Class metaobjects are instances of "standard-class"
(defclass standard-class ()
  ((name :initarg :name
	 :accessor class-name)
   (direct-superclasses :initarg :direct-superclasses
			:accessor class-direct-superclasses)
   (direct-slots :accessor class-direct-slots)
   (class-precedence-list :accessor class-precedence-list)
   (effective-slots :accessor class-slots)
   (direct-subclasses :initform ()
		      :accessor class-direct-subclasses)
   (direct-methods :initform ()
		   :accessor class-direct-methods)))

; The defclass macro

; The implementation of defclass is organized so that 
; the bulk of the macro-expansion work is carried out
; by canonicalize-... procedures:

(defmacro defclass (name direct-superclasses direct-slots &rest options)
  `(ensure-class ',name
     :direct-superclasses ,(canonicalize-direct-superclasses
			    direct-slots)
     ,@(canonicalize-defclass-options options)))


; An Introduction to the Common Lisp Object System

; Example class definition: rectangle
(defclass rectangle ()
  ((height :initarg :start-height
	   :initform 5
	   :accessor rectangle-height)
   (width  :initarg :start-width
	   :initform 8
	   :accessor rectangle-width)))

; color-rectangle is a subclass of rectangle
(defclass color-rectangle (rectangle)
  ((color :initform 'red
	  :initarg :color
	  :accessor color)
   (clearp :initform nil
	   :initarg :clearp
	   :accessor clearp)
   (height :initform 10)))

; alternative definition of color-rectangle
(defclass color-mixin ()
  ((color :initform 'red
	  :initarg :color
	  :accessor color)))

(defclass color-rectangle (color-mixin rectangle)
  ((clearp :initform nil
	   :initarg :clearp
	   :accessor clearp)
   (height :initform 10)))

