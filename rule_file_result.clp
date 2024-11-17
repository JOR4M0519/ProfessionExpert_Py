

;[RECOMMENDS]



;If the student belongs to category ‘C’ or ‘D’ in mathematics, and 
;belongs to category C in natural sciences, 
;he can study whatever he wishes.

(defrule recommend-any
  (declare (salience 1))
  ?f <- (estudiante (c_math ?cm) (c_natural "C") (recommend ?rec))
  (test (eq ?rec "N/A"))
  (test (or (eq ?cm "C") (eq ?cm "D")))
  =>
  (modify ?f (recommend "Puede estudiar cualquier carrera"))
)


;Si sobresale en Matematicas por encima de C
;Entonces puede estudiar ingeniería

(defrule recommend-engineering
  (declare (salience 5))
  ?f <- (estudiante (c_math ?cm) (p_engineering ?pe) (recommend ?rec))
  (test (eq ?rec "N/A"))
  (test (or (eq ?cm "C") (eq ?cm "D")))
  (test (>= ?pe 6))   
  =>
  (modify ?f (recommend "Puede estudiar Ingeniería"))
)



;If the student is category ‘A’ in mathematics, 
;he cannot study science and engineering.

(defrule no-engineering-or-sciences
  (declare (salience 10))
  ?f <- (estudiante (c_math "A") (recommend ?rec))
  (test (eq ?rec "N/A"))
  =>
  (modify ?f (recommend "No puede estudiar ciencias ni ingeniería"))
) 



;If the student is doing poorly in Natural Sciences AND
;he wants to study Health,
;he can study Humanities.

(defrule suggest-humanities
  (declare (salience 20))
  ?f <- (estudiante (p_health ?ph) (natural ?n) (recommend ?rec))
  (test (eq ?rec "N/A"))
  (test (and (<= ?n 40) (>= ?ph 6)))
  =>
  (modify ?f (recommend "Puede estudiar Humanidades"))
)



;If the student wants to study Engineering OR Science AND
;he is doing poorly in Mathematics,
;he can study Humanities OR Health

(defrule suggest-health-or-humanities
  (declare (salience 40))
  ?f <- (estudiante (p_engineering ?pe) (p_sciences ?pc) (math ?m) (recommend ?rec))
  (test (eq ?rec "N/A"))
  (test (or (< ?pe 40) (< ?pc 40)))
   (test (<= ?m 40))
  =>
  (modify ?f (recommend "Puede estudiar Humanidades o Salud"))
)



;The student can only study health 
;if he is in category ‘C’ in Natural Sciences and
;at least in category ‘C’ in Mathematics.

(defrule recommend-health
  (declare (salience 100))                             ;Se le agrega una mayor a cualquiera
  ?f <- (estudiante (c_natural "C") (c_math ?cm) (p_health ?ph) (recommend ?rec))
  (test (eq ?rec "N/A"))
  (test (or (eq ?cm "C") (eq ?cm "D")))
  (test (>= ?ph 7))                                  
  =>
  (modify ?f (recommend "Puede estudiar Salud"))
) 

