#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: contains.ps1

#Objetivo: 
#  	 Identificar si un texto está contenido en otra cadena. Ambas cadenas serán pasadas como parámetros. 

#Parámetros de entrada:
#     1) texto1 (cadena de caracteres)
#     2) texto2 (cadena de caracteres)

#Obligamos por consola a introducir los parámetros necesarios
param(
    [Parameter(Mandatory)][string]$texto,
    [Parameter(Mandatory)][string]$cadena
)

#Comprobamos si el texto contiene la cadena
$resultado=$texto.Contains($cadena)

#Motramos el resultado
if ($resultado){
    Write-Host 'El texto introducido CONTIENE la cadena'
}else{
    Write-Host 'El texto introducido NO contiene la cadena'
}