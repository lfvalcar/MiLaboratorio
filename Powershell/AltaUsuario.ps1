#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: altaUsuario.ps1

#Objetivo: 
#     1) Dar de alta un usuario. Con el alta del usuario se establecerán los siguientes valores:
#          Descripción="Alumno/a de Grado Superior"
#          Departamento="Departamento de Formación. Área de Informática"
#          Dirección="Av. Guillermo Reyna, 35, 04600 Huércal-Overa, Almería"
#          Provincia="Almería"
#          Código postal="04600"
#          Oficina / aula="A11"
#          Página web="https://iescuravalera.es/"
#          Organización ="IES Cura Valera"
#          Pais="ES"
#          Ciudad="Huercal-Overa"
#     2) El usuario se ubicará en la unidad organizativa "Alumnos"
#     3) Se le pondrá como contraseña "temporal"
#     4) Se le establecerá una carpeta personal de 100 MB en la unidad w: con enlace a "\\winserverpruebas\personales\$name"   
#Prerequisitos:
#     1) Debe existir el grupo "Alumnos"
#     2) Debe existir una plantilla de cuota con el nombre "Límite de 100 MB"
#     3) Debe estar compartido el directorio \\winserverpruebas\personales en "C:\Shares\personales" para lectura y escritura de usuarios de dominio
#Parámetros de entrada:
#     1) Nombre del usuario. No debe tener espacios y ser único
#     2) Apellido del usuario (opcional)
#     3) Nombre a ser visualizado (opcional)
#     4) La descripción del usuario (opcional)