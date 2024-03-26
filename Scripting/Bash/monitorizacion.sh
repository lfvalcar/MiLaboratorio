#!/bin/bash


# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script en forma de menu para monitorizar el funcionamiento global del sistema, obteniendo metricas del rendimiento, 
# procesos y servicios importantes en ejecucion, usuarios conectados, alertas de seguridad, etc.
# Profesor: Marco Antonio Jimenez Garcia


# Librerias
source librerias.sh

# MENU
while true
do
	# Opciones con limpiado de la pantalla
	clear

	# Menu
	echo '1) Media de carga de ejecución'
	echo '2) Procesos que más recursos consumen'
	echo '3) Procesos más prioritarios'
	echo '4) Utilización de memoria RAM'
	echo '5) Utilización de memoria virtual (swap)'
	echo '6) Utilización de disco'
	echo '7) Servicios en ejecución más importantes'
	echo '8) Usuarios conectados'
	echo '9) Alertas de autenticación fallidas'
	echo '10) Monitor en tiempo real'
	echo '0) Salir'

	# Seleccionar un opcion
	read -p 'Seleccione una opción: ' OP
	echo ''

	# OPCIONES
	case $OP in
		0)
			echo "script $0 finalizado"
			exit 0
			;;
		1)
			imprimir_color cyan 'Media de carga de ejecución'
			imprimir_color azul '1min, 10min, 15min' noline && echo -n ' --> ' && imprimir_color morado "$(uptime | 
			cut -d , -f 4-8)" newline
			;;
		2)
			imprimir_color cyan 'Procesos que más recursos consumen'
			imprimir_color verde 'CPU MEMORIA COMANDO' && echo -e "$(ps --no-headers -eo %cpu,%mem,comm | sort -nr | head | 
			column -t)\n"
			;;
		3)
			imprimir_color cyan 'Procesos más prioritarios'
			imprimir_color verde 'PRIORIDAD COMANDO' && echo -e "$(ps -eo ni,comm | sort -n | head | column -t)\n"
			;;
		4)
			imprimir_color cyan 'Utilización de memoria'
			echo -e "$(imprimir_color verde Total/Usado && free -h | sed '1d;$d' | awk '{print $2"/"$3}')\n"
			;;
		5)
			imprimir_color cyan 'Utilización de memoria virtual (swap)'
			echo -e "$(imprimir_color verde Total/Usado && free -h | sed '1,2 d' | awk '{print $2"/"$3}')\n"
			;;	
		6)
			imprimir_color cyan 'Utilización de disco'
			echo -e "$(df -h | grep '^/dev/\|^Filesystem' | awk '{print $1" "$2"/"$3" "$5}' | column -t)\n"
			;;	
		7)
			imprimir_color cyan 'Servicios en ejecución más importantes'
			echo -e "$(systemctl list-units *system*)\n"
			;;	
		8)
			imprimir_color cyan 'Usuarios conectados'
			imprimir_color azul "$(who)" newline
			;;	
		9)
			imprimir_color cyan 'Inicios de sesión fallidos'
			imprimir_color rojo "$(cat /var/log/auth.log | grep 'FAILED LOGIN')" newline
			;;
		10)
			if [ -f /usr/bin/htop ]
			then
				htop
			else
				top
			fi
		;;
		*)
			echo -e 'Debes seleccionar una opción válida\n'
	esac
	# END OPCIONES

	# Volver al menu
	read -n 1 -p 'Pulsa intro para continuar...' pausa 
done
