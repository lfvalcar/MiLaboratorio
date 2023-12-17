#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: arraysCompuestos.ps1

#Objetivo: 
#  	 Crear un script de PowerShell, que contenga un array con la información de 
#    nombre de alumno y curso. De tal manera, que cuando se le pase el parámetro de nombre de alumno indique el curso en que está.

#Parámetros de entrada:
#     1) Alumno (cadena de caracteres)

#Obligamos por consola a introducir los parámetros necesarios
param(
    [Parameter(Mandatory)][string]$alumno
)

#Creamos el array compuesto con los alumnos y sus respectivos cursos
$alumnos=@{Luis='2ASIR'; Álvaro='2ASIR'; Alejandro='1ASIR'; Daniel='2SMR'; Antonio='1SMR'}

#Mostramos los cursos según el alumno pasado
$resultado=$alumnos[$alumno]
Write-Host "El alumno $alumno está en el curso $resultado"