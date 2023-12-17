#Autor: Luis Fernando Valverde Cárdenas
#SCRIPT: parametros.ps1

#Objetivo: Definir dos variables: un $nombre y un $saludo. Dichas variables se tomarán como argumentos desde la consola.
#          A continuación que se muestran por consola.

#Parametros de entrada:
#        $nombre: Que contendrá el nombre de una persona o usuario
#        $saludo: Mensaje a mostrar con $nombre

#Establecemos los argumentos a pasar por consolar necesarios
param(
    [string]$nombre,
    [string]$saludo
)

#Imprimos el mensaje con ambas variables para obtener el resultado
Write-Host "$saludo, $nombre"

#Para comprobar el resultado el script se ejecutaría de la siguiente forma:
# .\saludo2.ps1 'Luis Fernando' 'Hola'