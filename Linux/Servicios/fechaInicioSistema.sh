#!/bin/bash

#Autor: Luis Fernando Valverde Cardenas
#Objetivo: script sencillo para aprender sobre las unidades de servicios

#Separamos la entrada de las demas para mejor visibilidad
echo ' ' >> /var/log/fechaInicioSistema.log

#Imprimimos y redirigimos hacia el archivo especificado la fecha
echo "El sistema se inició el $(date)" >> /var/log/fechaInicioSistema.log

echo ' ' >> /var/log/fechaInicioSistema.log
