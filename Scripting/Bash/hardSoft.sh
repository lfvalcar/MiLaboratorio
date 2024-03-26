#!/bin/bash


# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para obtener informacion detallada del hardware y software de un equipo, con la opcion de generar un informe 
# que se pueda imprimir
# Profesor: Marco Antonio Jimenez Garcia


# Librerias
source librerias.sh

# Caracteres que se aceptan como confirmacion de la generacion del informe
EXPRESION_ESPACIO_BLANCO='^[sS ]*$'
EXPRESION_EXTENSION='\.[^/]+$'

# Informacion de los requisitos al usuario antes de continuar el script
requisitos_script 'AVISO: para el correcto funcionamiento de este script tiene que ejecutarse con privilegios de SUPERUSUARIO'

# ¿INFORME?
read -p '¿Quieres generar un informe? [S/n] ' OPCION
 
if [[ $OPCION =~ $EXPRESION_ESPACIO_BLANCO ]]
then
	read -p '¿Cómo quieres llamar al informe (extensión por defecto .txt)?: ' INFORME
	# Se comprueba si tiene o no extension
	if [[ ! $INFORME =~ $EXPRESION_EXTENSION ]]
	then
		# Si no tiene se le agrega la extension por defecto
		INFORME="$INFORME.txt"
	fi
else
	INFORME=/dev/null
fi
# END ¿INFORME?

# Obtencion de informacion del equipo
echo 'obteniendo información sobre el equipo'
info_equipo $INFORME

# Fin del script
echo 'información detallada sobre el equipo obtenida y reportada'
echo "script $0 finalizado"
