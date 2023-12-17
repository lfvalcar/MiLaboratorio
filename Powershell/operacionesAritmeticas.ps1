#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: operacionesAritmeticas.ps1

#Objetivo: Recoge dos variables por consola con Read y lleve a cabo todas las operaciones aritméticas entre ellas. 
#          El resultado es motrado por consola

#Recogemos los valores de las variables por consola
[decimal]$n1=Read-Host('Introduce un número')
[decimal]$n2=Read-Host('Introduce otro número')

#Realizamos la operación aritmética de suma
Write-Host "Resultado suma:" ($n1 + $n2)

#Realizamos la operación aritmética de resta
Write-Host "Resultado resta:" ($n1 - $n2)

#Realizamos la operación aritmética de multiplicación
Write-Host "Resultado multiplicación:" ($n1 * $n2)

#Realizamos la operación aritmética de división
Write-Host "Resultado división:" ($n1 / $n2)

#Realizamos la operación aritmética del resto de la división
Write-Host "Resultado resto de división:" ($n1 % $n2)