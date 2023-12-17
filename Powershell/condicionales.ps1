#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: condicionales.ps1

#Objetivo: 
#  	 Comparar dos cadenas de texto introducidos como parámetros y diga si son iguales o no.

#Parámetros de entrada:
#     1) texto1 (cadena de caracteres)
#     2) texto2 (cadena de caracteres)

#Obligamos por consola a introducir los parámetros necesarios
param(
    [Parameter(Mandatory)][string]$cad1,
    [Parameter(Mandatory)][string]$cad2
)

#Comparamos las cadenas de texto pasadas como parámetros distinguiendo las mayúsculas de las minúsculas
if ($cad1 -ceq $cad2){
    #Mostramos el resultado (true)
    Write-Host "Las cadenas de texto $cad1 y $cad2 SON iguales"
}else{
    #Mostramos el resultado (false)
    Write-Host "Las cadenas de texto $cad1 y $cad2 NO son iguales"
}