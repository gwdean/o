;;; Code from AMOP. 

;;; Appendix A. An Introduction to the Common Lisp Object System.

(defclass rectangle ()
     ((height :initarg  :start-height
              :initform 5
	      :accessor rectangle-height)
      (width :initarg :start-width
	     :initform 8
	     :accessor rectangle-width)))

(setq r1 (make-instance 'rectangle :start-height 50 :start-width 100))

(defclass color-rectangle (rectangle)
     ((color :initform 'red
	     :initarg  :color
	     :accessor color)
      (clearp :initform nil
	      :initarg :clearp
	      :accessor clearp)
      (height :initform 10)))

(defclass color-mixin ()
     ((color :initform 'red
	     :initarg :color
	     :accessor color)))

(defclass color-rectangle (color-mixin rectangle)
     ((clearp :initform nil
              :initarg :clearp
	      :accessor clearp)
      (height :initform 10)))

(defgeneric paint (shape medium))

(defmethod paint ((shape rectangle) medium)
  (vertical-stroke (rectangle-height shape)
		   (rectangle-width shape)
		   medium))

(defmethod paint ((shape circle) medium)
  (draw-circle (radius shape)
	       medium))

(paint r1 *standard-display*)

(defmethod paint ((shape color-rectangle) medium)
  (unless (clearp shape)
    (call-next-method)))

(defmethod paint ((shape rectangle) (medium vector-display))
  ... draw vectors on display ...)

(defmethod paint ((shape rectangle) (medium bitmap-display))
  ... paint pixels on display ...)

(defmethod paint ((shape rectangle) (medium pdl-stream))
  ... create PS lines...)

(defmethod paint ((shape circle) (medium pd1-stream))
  ... create PS circle...)

(rectangle-height r1)             ;fetches the value of the height slot
(setf (rectangle-height r1) 75)   ;sets the value of height slot to 75

(slot-value r1 'height)
(setf (slot-value r1 'height) 75)

(defmethod paint :before ((shape color-mixin))
  (set-brush-color (color shape)))