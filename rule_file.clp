;[MATH]

;If the student got "equal or" less than 40 in math, he belongs to category 'A' in math.
(defrule classify-math-A
  ?f <- (estudiante (math ?m))
  (test (<= ?m 40))
  =>
  (modify ?f (c_math "A"))
)

;If the student scored between 41 and 60 in math, he belongs to category 'B' in math.
(defrule classify-math-B
  ?f <- (estudiante (math ?m))
  (test (and (>= ?m 41) (<= ?m 60)))
  =>
  (modify ?f (c_math "B"))
)

;If the student scored between 61 and 80 in math, he belongs to category 'C' in math.
(defrule classify-math-C
  ?f <- (estudiante (math ?m))
  (test (and (>= ?m 61) (<= ?m 80)))
  =>
  (modify ?f (c_math "C"))
)

;If the student got more than 80 in math, he belongs to category 'D' in math.
(defrule classify-math-D
  ?f <- (estudiante (math ?m))
  (test (> ?m 80))
  =>
  (modify ?f (c_math "D"))
)

;[NATURAL_SCIENCE]

;If the student got "equal or" less than 40 in Natural Sciences, he belongs to category 'A' in Natural Sciences.
(defrule classify-natural-A
  ?f <- (estudiante (natural ?n))
  (test (<= ?n 40))
  =>
  (modify ?f (c_natural "A"))
)

;If the student scored between 41 and 80 in Natural Sciences, he belongs to category 'B' in Natural Sciences.
(defrule classify-natural-B
  ?f <- (estudiante (natural ?n))
  (test (and (>= ?n 41) (<= ?n 80)))
  =>
  (modify ?f (c_natural "B"))
)

;If the student got more than 80 in Natural Sciences, he belongs to category 'C' in Natural Sciences
(defrule classify-natural-C
  ?f <- (estudiante (natural ?n))
  (test (> ?n 80))
  =>
  (modify ?f (c_natural "C"))
)


;[SOCIAL_SCIENCE]

;If the student got "equal or" less than '60' in Social Sciences, he belongs to category 'A' in Social Sciences.
(defrule classify-social-A
  ?f <- (estudiante (social ?s))
  (test (<= ?s 60))
  =>
  (modify ?f (c_social "A"))
)

;If the student got more than 60 in Social Sciences, he belongs to category 'B' in Social Sciences.
(defrule classify-social-B
  ?f <- (estudiante (social ?s))
  (test (> ?s 60))
  =>
  (modify ?f (c_social "B"))
)



;[RECOMMENDS]


;The student can only study health 
;if he is in category ‘C’ in Natural Sciences and
;at least in category ‘C’ in Mathematics.

(defrule recommend-health
  (declare (salience 100))                             ;Se le agrega una menor a cualquiera
  ?f <- (estudiante (c_natural "C") (c_math ?cm) (p_health ?ph))
  (test (or (eq ?cm "C") (eq ?cm "D")))
  (test (>= ?ph 7))                                   ;Si la preferencia por Salud es alta
  =>
  (modify ?f (recommend "Puede estudiar Salud"))
) 



;If the student belongs to category ‘C’ or ‘D’ in mathematics, and 
;belongs to category C in natural sciences, 
;he can study whatever he wishes.

(defrule recommend-any
  (declare (salience -5))
  (priority third)
  ?f <- (estudiante (c_math ?cm) (c_natural "C") )
  (test (or (eq ?cm "C") (eq ?cm "D")))
  =>
  (modify ?f (recommend "Puede estudiar cualquier carrera"))
)

(defrule recommend-engineering
  (declare (salience 5))
  ?f <- (estudiante (c_math ?cm) (p_engineering ?pe))
  (test (or (eq ?cm "C") (eq ?cm "D")))
  (test (>= ?pe 6))  ; Preferencia por ingeniería alta
  =>
  (modify ?f (recommend "Puede estudiar Ingeniería"))
)



;If the student is category ‘A’ in mathematics, 
;he cannot study science and engineering.

(defrule no-engineering-or-sciences
  (declare (salience 10))
  ?f <- (estudiante (c_math "A") )
  =>
  (modify ?f (recommend "No puede estudiar ciencias ni ingeniería"))
) 




;If the student wants to study Engineering OR Science AND
;he is doing poorly in Mathematics,
;he can study Humanities OR Health

(defrule suggest-health-or-humanities
  ?f <- (estudiante (p_engineering ?pe) (p_sciences ?pc) (math ?m))
  (test (or (< ?pe 40) (< ?pc 40)))
   (test (<= ?m 40))
  =>
  (modify ?f (recommend "Puede estudiar Humanidades o Salud"))
)



;If the student is doing poorly in Natural Sciences AND
;he wants to study Health,
;he can study Humanities.

(defrule suggest-humanities
  (declare (salience 40))
  ?f <- (estudiante (p_health ?ph) (natural ?n))
  (test (and (<= ?n 40) (>= ?ph 6)))
  =>
  (modify ?f (recommend "Puede estudiar Humanidades"))
)
