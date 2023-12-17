#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: replace.ps1

#Objetivo: 
#  	 Sustituir las “ñ” de una cadena texto introducida como parámetro por n.

#Parámetros de entrada:
#     1) texto (cadena de caracteres)

#Obligamos por consola a introducir los parámetros necesarios
param(
    [Parameter(Mandatory)][string]$texto
)

#Procedemos a reemplazar las "ñ" por "n" del texto
$resultado=$texto.Replace('ñ','n')

#Mostramos el resultado
Write-Host "El resultado del cambio es $resultado"