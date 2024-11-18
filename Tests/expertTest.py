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
rule_file = 'rule_file_cat.CLP'
env.load(rule_file)


# Se crea un hecho 
fact_string = """
(estudiante
  (math 45)
  (we 60)
  (natural 30)
  (social 75)
  (languagef 80)
  (p_humanities 5)
  (p_engineering 4)
  (p_sciences 3)
  (p_health 7)
  (c_math "N/A")
  (c_social "N/A")
  (c_natural "N/A")
  (recommend "N/A"))
"""

rules = env.rules()

# Imprimir cada regla cargada
#for rule in rules:
#    print(rule)

#Se inserta el hecho 
env.assert_string(fact_string)

# Ejecutar el motor de inferencia Para obtener las categorias
env.run()


# Ejecutar el motor de inferencia Para obtener los resultados finales
rule_file_r = 'rule_file_result.clp'
env.load(rule_file_r)

agenda_content = env.eval('(agenda MAIN)')
env.run()










# Mostrar el resultado final
for fact in env.facts():
    print(fact)