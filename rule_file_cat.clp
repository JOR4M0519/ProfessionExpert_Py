;
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
