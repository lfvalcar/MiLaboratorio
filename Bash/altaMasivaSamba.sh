#!/bin/bash
#Autor: Luis Fernando Valverde Cárdenas
#Objetivo: El objetivo del trabajo será crear un script en bash que permita dar de alta en un dominio de Samba un conjunto de usuarios pasados en un fichero de tipo csv

#NOTAS
	#Necesita ejecutarse como superusuario para que funcione correctamente
	#Hay que indicar -f como segundo parámetro para obligas a crear el usuario si está repetido añadiendo un extra al nombre de usuario para que se de de alta
	#Hay que indicar el fichero .csv como primer parámetro para que funcione correctamente


#FUNCIONES
#Función que da de alta usuarios con propiedades por defecto en samba con el primer parámetro como el usuario
altaUsuarioSamba () {
	resultado="Usuario $1 registrado"
	samba-tool user create $1 'Asir#2021' --job-title 'Operario' --department 'Departamento Producción' --company 'IES Cura Valera' --mail "$1@luis.int" 2> /dev/null || resultado="No registrado. El usuario $1 ya existe en el sistema."
}

#Preparamos la cabecera del fichero resultado .result 
echo 'nombre;apellidos;dni;resultado' > $1.result

#Extraemos del fichero .csv por cada usuario sus datos con un bucle
while IFS=";" read -r nombre apellidos dni
do
	#A partir de los datos creamos el nombre de usuario
	#Tomamos los dos primeros caracteres del nombre,1ºapellido y dni
	usuario="${nombre:0:2}${apellidos:0:2}${dni:0:2}"

	#una vez tenemos el nombre usuario nos aseguramos de que esté en minúsculas para evitar problemas con linux
	usuario=${usuario,,}

	#Una vez tenemos los datos, damos de alta el usuario en el dominio con la función
	altaUsuarioSamba $usuario

	#Inicializamos la variable count a 1 para el proceso de forzado de usuario -f
	count=1

	#Aquí comenzamos el proceso de forzado de creación de usuarios -f
	#Comprobamos si existe el segundo parámetro donde debería estar -f
	if [ $2 ]; then
		#En caso de que true comprobamos si el segundo parámetro es -f
		if [ $2 = '-f' ]; then
			#En caso de true abrimos un bucle para crear nombre de usuarios distintos añadiendo $count hasta que se registre
			while [ ${resultado:0:2} = 'No' ]
			do
				altaUsuarioSamba "${usuario}$count"
				((count++))
			done #${resultado:0:2} = 'No' 
		fi #$2
	fi #$2 = '-f'
		
	#El resultado lo enviamos al fichero .result
	echo "$nombre;$apellidos;$dni;$resultado" >> $1.result

done < <(tail -n +2 $1)  #IFS=";" read -r nombre apellidos dni
