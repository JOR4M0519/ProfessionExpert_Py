import clips

# Entorno CLIPS
env = clips.Environment()

# Plantilla 'estudiante'
template_string = """
(deftemplate estudiante
  (slot math (type INTEGER))
  (slot we (type INTEGER))
  (slot natural (type INTEGER))
  (slot social (type INTEGER))
  (slot languagef (type INTEGER))
  
  (slot c_math (type STRING))
  (slot c_social (type STRING))
  (slot c_natural (type STRING))

  (slot p_humanities (type INTEGER))
  (slot p_engineering (type INTEGER))
  (slot p_sciences (type INTEGER))
  (slot p_health (type INTEGER))

  (slot recommend (type STRING))
)
"""

#Se carga la tabla
env.build(template_string)



#Se carga el archivo de las reglas
rule_file = 'rule_file.CLP'
env.load(rule_file)


# Se crea un hecho 
fact_string = """
(estudiante
  (math 70)
  (we 80)
  (natural 50)
  (social 85)
  (languagef 75)
  (p_humanities 4)
  (p_engineering 6)
  (p_sciences 5)
  (p_health 8)
  (c_math "N/A")
  (c_social "N/A")
  (c_natural "N/A")
  (recommend "N/A"))
"""


#Se inserta el hecho 
env.assert_string(fact_string)

# Ejecutar el motor de inferencia
env.run()

rules = env.rules()

# Imprimir cada regla cargada
#for rule in rules:
#    print(rule)

# Mostrar el resultado final
for fact in env.facts():
    print(fact)