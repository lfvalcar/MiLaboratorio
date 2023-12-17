#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: read-host.ps1

#Objetivo: Definir dos variables: un $nombre y un $saludo. Los valores de estas variables se les pedirá al usuario.
#          A continuaciónque se muestran por consola.

#Le pedimos al usuario por consola los valores de las variables.
[string]$nombre=Read-Host('¿Cómo te llamas? ')
[string]$saludo=Read-Host('¿Cómo quieres que te saludemos? ')

#Imprimos el mensaje con ambas variables para obtener el resultado
Write-Host "$saludo, $nombre"