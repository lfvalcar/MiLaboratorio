#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: arrays.ps1

#Objetivo: 
#  	 Crear un script de PowerShell, que contenga un array con la información de curso y aula. De tal manera, 
#    que cuando se le pase el parámetro de curso (1,2,3 o 4) proporcione el nombre del aula.

#Parámetros de entrada:
#     1) Curso (valor numérico entre 1 y 4)

#Obligamos por consola a introducir los parámetros necesarios
param(
    [Parameter(Mandatory)][int]$curso
)

#Creamos el array con las aulas
$aulas=@('A1', 'A2', 'A3', 'A4')

#Mostramos la aula según el parámetro pasado (-1 porque las posiciones del array empiezan por 0)
$resultado=$aulas[$curso-1]
Write-Host "El curso $curso está en la aula $resultado"
