#!/bin/bash

#Autor: Luis Fernando Valverde Cardenas
#Objetivo: script sencillo para practicar con unidades de servicio

#Separamos la entrada de las demas para mejor visibilidad
echo ' ' >> /var/log/usuariosConectados.log

#Imprimimos y redirigimos hacia el archivo especificado la fecha de la entrada
echo "ENTRADA: $(date)" >> /var/log/usuariosConectados.log

#Imprimimos y redirigimos hacia el archivo especificado la lista de usuarios conectados al sistema
who >> /var/log/usuariosConectados.log
#
echo ' ' >> /var/log/usuariosConectados.log
#
#
#
