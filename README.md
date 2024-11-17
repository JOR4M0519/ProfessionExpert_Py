# Sistema de Recomendación Estudiantil con CLIPS y Tkinter

Este proyecto es una aplicación de escritorio desarrollada en Python, que utiliza **Tkinter** para la interfaz gráfica y **CLIPS** (C Language Integrated Production System) para inferencia de reglas, con el objetivo de recomendar una carrera universitaria basada en las calificaciones y preferencias de un estudiante.

## Requisitos

1. **Python 3.x**
2. **Tkinter** 
3. **PyCLIPS** (Un envoltorio para interactuar con CLIPS en Python)
4. **Archivo de reglas CLP** (`rule_file.CLP`), que define las reglas de inferencia del sistema.

## Instalación

1. Clona este repositorio a tu máquina local:

   ```bash
   git clone https://github.com/JOR4M0519/ProfessionExpert_Py.git

2. Instalar dependencias necesarias:

    PyCLIPS:
    ```bash
     pip install pyclips

3. Tener el archivo de reglas rule_file.CLP en el mismo directorio que EL script Python.
  Nota: Este archivo contiene las reglas para la recomendación de carrera.

4. Ejecutar el Proyecto
   - Ejecutar el archivo .bat
     
   - Ejecutar comando en cmd:
      
    ```bash
    python expert.py
