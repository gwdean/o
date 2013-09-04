; Usage. 
; Step 1: Save file.
; Step 2: Open SLIME.
; Step 3: (load "Family.lisp")
; Step 4: T

(setf wood
      '((marion nil nil)
	(edward nil nil)
	(sharon marion edward)
	(susan  marion edward)
	(stacey marion edward)
	(sally  marion edward)
	(meredith sharon jack)
	(jason sharon jack)
	(gregory sharon jack)
	(michael susan paul)
	(beth susan paul)
	(lynne susan paul)
	(benjamin stacey bruce)
	(amanda stacey bruce)
	(mark sally fred)
	(neil sally fred)
	(emily michael bethany)
	(lucas jason karen)
	(isla jason karen)
	(ella mark megan)))

(defun father (x) (second (assoc x family)))

(defun mother (x) (third (assoc x family)))

(defun parents (x)
  (union (and (father x) (list (father x)))
	 (and (mother x) (list (mother x)))))

(defun children (parent)
  (and parent
       (mapcar #'first
	   (remove-if-not
	     #'(lambda (entry)
		 (member parent (rest entry)))
	     family))))

(defun siblings (x)
  (set-difference (union (children (father x))
			 (children (mother x)))
		  (list x)))

(defun mapunion (fn x)
  (and x (reduce #'union (mapcar fn x))))

(defun grandparents (x)
  (mapunion #'parents (parents x)))

(defun cousins (x)
  (mapunion #'children
	    (mapunion #'siblings (parents x))))

(defun descended-from (p1 p2)
  (cond ((null p1) nil)
        ((member p2 (parents p1)) t)
	(t (or (descended-from
		  (father p1) p2)
	       (descended-from
		  (mother p1) p2)))))

(defun ancestors (x)
  (cond ((null x) nil)
	(t (union
	    (parents x)
	    (union (ancestors (father x))
		   (ancestors (mother x)))))))

(defun generation-gap (x y)
  (g-gap-helper x y 0))

(defun g-gap-helper (x y n)
  (cond ((null x) nil)
	((equal x y) n)
	(t (or (g-gap-helper
		  (father x) y (1+ n))
	       (g-gap-helper
		  (mother x) y (1+ n))))))

(descended-from 'isla 'marion)
(ancestors 'lucas)
(generation-gap 'emily 'edward)
(cousins 'greg)
(grandparents 'ella)

