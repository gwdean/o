; Adapted from the "Orc Battle" game in Barski-2011

(defparameter *health* nil)
(defparameter *agility* nil)
(defparameter *strength* nil)
(defparameter *monsters* nil)
(defparameter *monster-builders* nil)
(defparameter *monster-num* 12)

(defun orc-battle ()
  (init-monsters)
  (init-player)
  (game-loop)
  (when (player-dead)
    (princ "Game over."))
  (when (monsters-dead)
    (princ "You win.")))

(defun game-loop ()
  (unless (or (player-dead) (monsters-dead))
    (show-player)
      (dotimes (k (1+ (truncate (/ (max 0 *agility*) 15))))
	(unless (monsters-dead)
	  (show-monsters)
	  (player-attack)))
      (fresh-line)
      (map 'list
	   (lambda (m)
	     (or (monster-dead m) (monster-attack m)))
	   *monsters*)
      (game-loop)))

