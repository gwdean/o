; This code is originally from the Prologue of
; Jack Wisdom and Gerald Jay Sussman's  outstanding 
; book "Functional Differential Geometry".

(define ((Lagrange-equations Lagrangian) w)
  (- (D (compose ((partial 2) Lagrangian) (Gamma w)))
     (compose ((partial 1) Lagrangian) (Gamma w))))

(define ((Gamma w) t)
  (up t (w t) ((D w) t)))

(define ((L-harmonic m k) local)
  (let ((q (coordinate local))
	(v (velocity local)))
    (- (* 1/2 m (square v))
       (* 1/2 k (square q)))))  

(define (proposed-solution t)
  (* 'a (cos (+ (* 'omega t) 'phi))))

(show-expression
  (((Lagrange-equations (L-harmonic 'm 'k))
    proposed-solution)
   't))

(show-expression
  (((Lagrange-equations (L-harmonic 'm 'k))
    (literal-function 'x))
   't))
