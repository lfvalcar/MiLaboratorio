#!/bin/bash


# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para realizar la copia de seguridad y la restauracion de la carpeta personal de los usuarios indicados por parametros.
# Profesor: Marco Antonio Jimenez Garcia


# Librerias
source librerias.sh

# Requisitos
requisitos_script 'AVISO: para el correcto funcionamiento de este script tiene que ejecutarse con privilegios de SUPERUSUARIO\n
este script necesita los siguientes parámetros para ejecutarse ejemplo: ./backup.sh usuario1 usuario2\n
también genera un archivo erroresBackup.log con los errores'

# Variables
ERRORES_BACKUP=erroresBackup.log

# Generacion del archivo de errores
echo 'No hay errores :)' > $ERRORES_BACKUP

while true 
do
	# Menu
	clear
	echo "Usuario seleccionados: $*"
	echo 'C) Realizar copia de seguridad de los usuarios seleccionados'
	echo 'R) Restaturar última copia de seguridad de los usuarios seleccionados'
	echo 'E) Ver los errores de los backups'
	echo '0) Salir'

	# Seleccionar opcion
	read -p 'Seleccione una opción: ' OPERACION
	echo ''

	# OPCIONES
	case $OPERACION in 
		0)
			echo "script $0 finalizado"
			exit 0
			;;
		'C')
			# Ruta donde se almacenan los backups
			read -p '¿Donde desea almacenar la copia de seguridad? [ruta absoluta] ' RUTA_BACKUP

			# Por cada usuario se realiza el backup
			for USUARIO in $*
			do
				NOMBRE_BACKUP="$USUARIO-$(date +%F_%H).tar"
				tar -cf $RUTA_BACKUP/$NOMBRE_BACKUP -C /home $USUARIO 2> $ERRORES_BACKUP

				# Se comprueba si el backup se ha realizado con exito o no
				if [ $? -eq 1 ]
				then
					echo "Backup $NOMBRE_BACKUP terminado con errores, para más información $ERRORES_BACKUP"
				else
					echo "Backup $NOMBRE_BACKUP realizado con éxito"
				fi
			done	
			;;
		'R')
			# Ruta donde las copias de seguridad a restaurar
			read -p '¿Directorio donde se almacenan las copias a restaurar? [ruta absoluta] ' RUTA_BACKUP

			# Por cada usuario se selecciona la copia mas reciente y se restaura
			for USUARIO in $*
			do
				USUARIO_BACKUP=$(find $RUTA_BACKUP -type f -name $USUARIO* -exec ls -t {} + | head -n 1)
				tar -xf $USUARIO_BACKUP -C /home 2> $ERRORES_BACKUP

				# Se comprueba si el backup se ha restaurado con exito o no
				if [ $? -eq 1 ]
				then
					echo "Backup $NOMBRE_BACKUP restaurado con errores, para más información $ERRORES_BACKUP"
				else
					echo "Backup $NOMBRE_BACKUP restaurado con éxito"
				fi
			done
			;;
		'E')
			cat $ERRORES_BACKUP
			;;
		*)
			echo -e 'Debes seleccionar una opción válida [C/R]\n'
	esac
	# END OPCIONES

	# Volver al menu
	echo ''
	read -n 1 -p 'Pulsa intro para continuar...' pausa 
done
