#!/bin/bash


# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Conjunto de funciones para los scripts de administracion
# Profesor: Marco Antonio Jimenez Garcia


# Funcion que obtiene informacion sobre el equipo con opcion de generar un informe
info_equipo() {

	# Informe obtenido del menu de generacion del informe
	INFORME=$1
	
	# Introduccion del informe
	imprimir_color verde 'Informe detallado del equipo' newline | tee $INFORME

	# Sistema
	imprimir_color verde Sistema | tee -a $INFORME
	echo -e "$(lshw -class system)\n" | sed '/[0-9]/d' | awk -F : '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m"}' | tee -a $INFORME
	
	# Procesador
	imprimir_color verde Procesador | tee -a $INFORME
	echo -e "$(lshw -class processor)\n" | sed '1d; 4,7d' | awk -F : '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m"}' |
	tee -a $INFORME

	# Memoria
	imprimir_color verde Memoria | tee -a $INFORME
	echo -e "$(lshw -class memory)\n" | sed '/[0-9]$/d' | awk -F : '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m"}' |
	tee -a $INFORME

	# Red
	imprimir_color verde Red | tee -a $INFORME
	echo -e "$(lshw -class network)\n" | sed -e '/[0-9]$/d' -e '1d' | 
	awk -F : '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m"}' | tee -a $INFORME

	# Disco
	imprimir_color verde Disco | tee -a $INFORME
	echo -e "$(lshw -class disk)\n" | sed -e '/[0-9]$/d' -e '1d' |
	awk -F : '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m"}' | tee -a $INFORME

	# Paquetes mas pesados
	imprimir_color verde 'Paquetes más pesados' | tee -a $INFORME
	CONSULTA=$(dpkg-query -Wf '${Package} ${Installed-Size}\n' |
	awk '{$2=$2/1024; $2=sprintf("%.2f",$2); print $1" "$2" MB"}' | sort -rn -k2 | head)

	echo -e "PAQUETE\t\t\t\t\tSIZE MB\n$CONSULTA\n" | awk '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m "$3}' |
	column -t | tee -a $INFORME

	# Paquetes mas pequeños
	imprimir_color verde 'Paquetes más pequeños' | tee -a $INFORME
	CONSULTA=$(dpkg-query -Wf '${Package} ${Installed-Size}\n' |
	awk '{$2=sprintf("%.2f",$2); print $1" "$2" KB"}' | sort -n -k2 | head)

	echo -e "PAQUETE\t\t\t\t\tSIZE KB\n$CONSULTA\n" | awk '{print "\033[34m"$1"\033[0m \033[35m"$2"\033[0m "$3}' |
	column -t | tee -a $INFORME

	# Paquetes instalados
	imprimir_color verde 'Paquetes instalados:' | tee -a $INFORME
	
	imprimir_color azul 'Paquetes amd64: ' noline | tee -a $INFORME 
	imprimir_color morado "$(dpkg -l | grep '^ii' | grep ' amd64 ' | wc -l)" | tee -a $INFORME
	
	imprimir_color azul 'Paquetes all: ' noline | tee -a $INFORME
	imprimir_color morado "$(dpkg -l | grep '^ii' | grep ' all ' | wc -l)" | tee -a $INFORME
	
	imprimir_color azul 'Total paquetes instalados: ' noline | tee -a $INFORME 
	imprimir_color morado "$(dpkg -l | grep '^ii' | wc -l)\n" | tee -a $INFORME
}

# Funcion que a partir de un texto y color especificado imprime el texto en ese color
imprimir_color() {
	
	# Variables
	# Color con el que se imprimira el mensaje
	local COLOR
	# Texto a que se imprimira como mensaje
	local TEXTO=$2
	# Formato que le quieras dar al mensaje como saltos de lineas o suprimirlos
	local FORMATO=$3
	# END Variables

	# Menu que transforma el color especificado en etiquetas para el comando echo
	case $1 in
		"negro")
		COLOR=30
		;;
		"rojo")
		COLOR=31
		;;
		"verde")
		COLOR=32
		;;
		"marron")
		COLOR=33
		;;
		"azul")
		COLOR=34
		;;
		"morado")
		COLOR=35
		;;
		"cyan")
		COLOR=36
		;;
		"gris")
		COLOR=37
		;;
		*)
		echo "color no válido"
		return 1
		;;
	esac

	# Menu que transforma el formato especificado en etiquetas para el comando echo
	case $FORMATO in 
	'noline')
		echo -en "\e["$COLOR"m"$TEXTO"\e[0m"
	;;
	'newline')
		echo -e "\e["$COLOR"m"$TEXTO"\e[0m\n"
	;;
	*)
		echo -e "\e["$COLOR"m"$TEXTO"\e[0m"
	;;
	esac
}

# Funcion que genera claves aleatorias
generar_clave() {
	# Longitud de la clave
	local LONGITUD=$1

	local CLAVE=$(cat /dev/urandom | tr -dc "A-Za-z0-9|@#~" | head -c $LONGITUD)
	echo $CLAVE
}

# Funcion que comprueba si el usuario existe
usuario_existe() {

	# Usuario a comprobar
	local USUARIO=$1

	# Se comprueba si el usuario existe en el archivo /etc/passwd
	if [ $(grep -c $USUARIO /etc/passwd) -eq 1 ]
	then
		return 1
	else
		return 0
	fi
}

# Funcion que comprueba si el grupo existe
grupo_existe() {

	# Grupo a comprobar
	local GRUPO=$1

	# Se comprueba si el grupo existe en el archivo /etc/group
	if [ $(grep -c $GRUPO /etc/group) -eq 1 ]
	then
		return 1
	else
		return 0
	fi
}

requisitos_script(){
	# Caracteres para la confirmacion
	local EXPRESION_ESPACIO_BLANCO='^[sS ]*$'
	local REQUISITOS=$1

	echo -e $REQUISITOS
	read -p '¿Quieres continuar? [S/n] ' CONTINUACION

	if [[ ! $CONTINUACION =~ $EXPRESION_ESPACIO_BLANCO ]]
	then
		exit 0
	fi	
}
