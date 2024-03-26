#!/bin/bash


# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para crear usuarios locales de forma automatizada especificados en un fichero pasado como parametro.
# Profesor: Marco Antonio Jimenez Garcia


# Librerias
source librerias.sh

# Variables
# Archivo con las contraseñas iniciales
PASSWORDS=passwords.csv

# Informacion de los requisitos al usuario antes de continuar el script
requisitos_script 'AVISO: para el correcto funcionamiento de este script tiene que ejecutarse con privilegios de SUPERUSUARIO\n
este script necesita los siguientes parámetros para ejecutarse ejemplo: ./usuarios.sh usuarios.csv\n
también crea un fichero de extensión .csv con los usuarios y sus contraseñas aleatorias'

# Delimitador
read -p 'Introduce el delimitador del archivo especificado como parámetro: ' DELIMITADOR

# Cabecera del archivo con las contraseñas iniciales
echo 'usuario,contraseña' > $PASSWORDS

# Se eliminan las cabeceras del CSV
for REGISTRO in $(cat $1 | sed '1d') 
do	
	USUARIO=$(echo $REGISTRO | awk -F $DELIMITADOR '{print $1}')
	GRUPO=$(echo $REGISTRO | awk -F $DELIMITADOR '{print $2}')

	# Se genera una clave aleatoria con una longitud de 16 caracteres
	PASSWORD=$(generar_clave 16)
	
	# Encabezado del archivo de contraseñas
	echo "$USUARIO,$PASSWORD" >> $PASSWORDS

	# Se comprueba si el grupo existe (resultado 1 o 0)
	grupo_existe $GRUPO

	if [ $? -eq 0 ]
	then
		groupadd $GRUPO && echo "grupo $GRUPO creado"
	fi
	
	# Se comprueba si el usuario existe (resultado 1 o 0)
	usuario_existe $USUARIO

	if [ ! $? -eq 0 ]
	then
		echo "el usuario $USUARIO existe, por lo tanto se salta su creación"
	else
		useradd -s /bin/bash -m -g $GRUPO -p $PASSWORD $USUARIO && echo "usuario $USUARIO creado"
	fi
done
