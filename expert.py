import tkinter as tk
from tkinter import messagebox
import clips

# Cargar datos en CLIPS 
def cargar_datos():
    try:
      # Recuperar datos del formulario
      math = int(entry_math.get())
      we = int(entry_we.get())
      natural = int(entry_natural.get())
      social = int(entry_social.get())
      languagef = int(entry_languagef.get())
      p_humanities = int(entry_p_humanities.get())
      p_engineering = int(entry_p_engineering.get())
      p_sciences = int(entry_p_sciences.get())
      p_health = int(entry_p_health.get())
    
      # Cargar los datos en el hecho para insertar en CLIPS
      fact_string = f"""
      (estudiante
        (math {math})
        (we {we})
        (natural {natural})
        (social {social})
        (languagef {languagef})
        (p_humanities {p_humanities})
        (p_engineering {p_engineering})
        (p_sciences {p_sciences})
        (p_health {p_health})
        (c_math "N/A")
        (c_social "N/A")
        (c_natural "N/A")
        (recommend "N/A"))
      """
      env.assert_string(fact_string)
      messagebox.showinfo("Éxito", "Los datos se han cargado correctamente.")
      button_ejecutar.config(state='normal')

    except Exception:
        messagebox.showerror("Error", "Por favor, ingrese valores válidos para todos los campos.")

    


def ejecutar_inferencia():
    try:
        # Paso 1: Ejecutar motor de inferencia para obtener las categorías
        env.run()

        c_math = None
        c_natural = None
        c_social = None

        # Extraer categorías de los hechos
        for fact in env.facts():
            if 'estudiante' in str(fact): 
                c_math = fact['c_math']
                c_natural = fact['c_natural']
                c_social = fact['c_social']

        # Mostrar categorías en los Entries
        if c_math is not None:
            entry_c_math.config(state='normal')
            entry_c_math.insert(tk.END, c_math)
            entry_c_math.config(state='disabled')

        if c_natural is not None:
            entry_c_natural.config(state='normal')
            entry_c_natural.insert(tk.END, c_natural)
            entry_c_natural.config(state='disabled')

        if c_social is not None:
            entry_c_social.config(state='normal')
            entry_c_social.insert(tk.END, c_social)
            entry_c_social.config(state='disabled')

        # Paso 2: Cargar reglas para recomendaciones y ejecutar nuevamente
        rule_file_r = 'rule_file_result.clp'
        env.load(rule_file_r)
        env.run()

        recomendacion = None

        # Extraer la recomendación
        for fact in env.facts():
            if 'recommend' in str(fact):  
                recomendacion = fact['recommend']
                break

        # Mostrar la recomendación en el Text Area
        if recomendacion is not None:
            text_area.config(state='normal')
            text_area.insert(tk.END, f"Recomendación: {recomendacion}")
            text_area.config(state='disabled')

    except Exception:
        messagebox.showerror("Error", "Por favor, volver a intentar")


# Configurar entorno CLIPS
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
env.build(template_string)

# Cargar archivo de reglas
rule_file = 'rule_file_cat.CLP'
env.load(rule_file)




# Configurar interfaz gráfica con Tkinter
root = tk.Tk()
root.title("Sistema de Recomendación Estudiantil")


# Etiquetas y entradas datos
label_math = tk.Label(root, text="Matemáticas:")
label_math.grid(row=0, column=0)
entry_math = tk.Entry(root)
entry_math.grid(row=0, column=1)

label_we = tk.Label(root, text="Expresiones Escritas:")
label_we.grid(row=1, column=0)
entry_we = tk.Entry(root)
entry_we.grid(row=1, column=1)

label_natural = tk.Label(root, text="Ciencias Naturales:")
label_natural.grid(row=2, column=0)
entry_natural = tk.Entry(root)
entry_natural.grid(row=2, column=1)

label_social = tk.Label(root, text="Ciencias Sociales:")
label_social.grid(row=3, column=0)
entry_social = tk.Entry(root)
entry_social.grid(row=3, column=1)

label_languagef = tk.Label(root, text="Segunda Lenguaje:")
label_languagef.grid(row=4, column=0)
entry_languagef = tk.Entry(root)
entry_languagef.grid(row=4, column=1)

#Preferencias de estudio
label_p_humanities = tk.Label(root, text="Preferencia por Humanidades:")
label_p_humanities.grid(row=5, column=0)
entry_p_humanities = tk.Entry(root)
entry_p_humanities.grid(row=5, column=1)

label_p_engineering = tk.Label(root, text="Preferencia por Ingeniería:")
label_p_engineering.grid(row=6, column=0)
entry_p_engineering = tk.Entry(root)
entry_p_engineering.grid(row=6, column=1)

label_p_sciences = tk.Label(root, text="Preferencia por Ciencias:")
label_p_sciences.grid(row=7, column=0)
entry_p_sciences = tk.Entry(root)
entry_p_sciences.grid(row=7, column=1)

label_p_health = tk.Label(root, text="Preferencia por Salud:")
label_p_health.grid(row=8, column=0)
entry_p_health = tk.Entry(root)
entry_p_health.grid(row=8, column=1)

#Categorias de Materias
label_c_math = tk.Label(root, text="Cat. Matematicas:")
label_c_math.grid(row=9, column=0)
entry_c_math = tk.Entry(root)
entry_c_math.grid(row=9, column=1)
entry_c_math.config(state='disabled')

label_c_natural = tk.Label(root, text="Cat. Naturales:")
label_c_natural.grid(row=10, column=0)
entry_c_natural = tk.Entry(root)
entry_c_natural.grid(row=10, column=1)
entry_c_natural.config(state='disabled')

label_c_social = tk.Label(root, text="Cat. Social:")
label_c_social.grid(row=11, column=0)
entry_c_social = tk.Entry(root)
entry_c_social.grid(row=11, column=1)
entry_c_social.config(state='disabled')

# Área de texto de recomendación
text_area = tk.Text(root, height=5, width=50)
text_area.grid(row=12, column=0, columnspan=2)
text_area.config(state='disabled')

# Botones para cargar datos y ejecutar
button_cargar = tk.Button(root, text="Cargar Datos", command=cargar_datos)
button_cargar.grid(row=13, column=0)

button_ejecutar = tk.Button(root, text="Ejecutar Recomendación", command=ejecutar_inferencia)
button_ejecutar.grid(row=13, column=1)
button_ejecutar.config(state='disabled')


# Ejecutar la interfaz
root.mainloop()
