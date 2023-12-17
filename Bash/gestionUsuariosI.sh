#!/bin/bash

#SOBRE EL SCRIPT
echo '###CABECERA###'
echo "script $0"
echo 'AUTOR: Luis Fernando Valverde Cardenas'
echo 'PROFESOR: Angel Oller Segura'
echo 'TEMARIO: UT.09 Administracion de Linux I (usuarios, procesos, servicios y red)'
echo 'TRABAJO: TR.09.01. Creacion de scripts de configuracion del sistema'
echo 'OBJETIVO: Practicar lo aprendido sobre creacion de usuarios y grupos,politicas de contraseñas,permisos y propietarios de linux'

#REQUISITOS
echo '###REQUISITOS###'
echo '1º Necesita ejecutarse con privilegios de SUPERUSUARIO'
echo '2º El script tiene que ejecutarse junto al .profile con el que viene (linea 66)'

#CONFIRMACION
read -p '¿Desea continuar? [S/n] ' confirm
if [[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]; then
	echo 'Anulado'
	exit
fi #[[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]

#GRUPOS
count=0 #Contador para contar los errores en caso de que haya
echo '###GRUPOS###'
groupadd profesores || ((count++))
groupadd alumnado || ((count++))
groupadd 1asir || ((count++))
groupadd 2asir || ((count++))
groupadd 1eso || ((count++))
groupadd 2eso || ((count++))
groupadd 3eso || ((count++))
groupadd 4eso || ((count++))
if [ $count = 0 ]; then 
	echo 'grupos creados correctamente'
fi #[ $count = 0 ]

#UMASK
#Toda creacion de nuevos ficheros tendra por defecto los permisos de lectura y escritura para el propietario y de solo lectura 
#para el grupo. El resto de usuarios no tendra acceso al fichero.

#Asegurar de que el archivo /etc/skel/.profile exista y establecemos los permisos por defecto, en caso de no exista informar al usuario
echo '###UMASK###'
#Comprobamos si existe el fichero .profile
if [ -f /etc/skel/.profile ]; then
	cp -v /etc/skel/.profile /etc/skel/.profile.bk #Copia de seguridad del archivo .profile anterior para restaurar posteriormente
	#Si existe el fichero .profile comprobamos si tiene establecido umask a 137
	if ! grep  -q '^[^#]*umask 137' /etc/skel/.profile ; then 
		#Si no tiene umask a 137, comprobamos si es que no esta establecido umask o esta establecido a otro valor
		if grep -q '^[^#]*umask [0-9][0-9][0-9]' /etc/skel/.profile ; then 
			#Si esta establecido umask con otro valor, cambiamos el valor de umask a 137
			sed -E -i 's/^[^#]*umask [0-9][0-9][0-9]/umask 137/g' /etc/skel/.profile
			echo 'umask cambiado en /etc/skel/.profile'
		else
			#Si no esta establecido umask, lo agregamos junto al valor 137
			echo  ' ' >> /etc/skel/.profile 
			echo '#SET UMASK' >> /etc/skel/.profile
			echo 'umask 137' >> /etc/skel/.profile 
			echo 'umask establecido en /etc/skel/.profile'
		fi #grep -q '^[^#]*umask [0-9][0-9][0-9]'
	else
		echo 'umask ya esta establecido a 137'
	fi #! grep  -q '^[^#]*umask 137' 
else 
	#Si no existe el fichero copiamos a la ruta el que viene con el script
	echo '***[WARNING] No existe el fichero /etc/skel/.profile' 
	cp -v .profile /etc/skel/ 
fi #[ -f /etc/skel/.profile ]

#USUARIOS
count=0
echo '###USUARIOS###'
useradd alumno1asir -m -s /bin/bash -g 1asir -G alumnado -p "alumno" || ((count++))
useradd alumno2asir -m -s /bin/bash -g 2asir -G alumnado -p "alumno" || ((count++))
useradd alumno1eso -m -s /bin/bash -g 1eso -G alumnado -p "alumno" || ((count++))
useradd alumno2eso -m -s /bin/bash -g 2eso -G alumnado -p "alumno" || ((count++))
useradd alumno3eso -m -s /bin/bash -g 3eso -G alumnado -p "alumno" || ((count++))
useradd alumno4eso -m -s /bin/bash -g 4eso -G alumnado -p "alumno" || ((count++))
useradd profesor1 -m -s /bin/bash -g profesores -p "profesor" || ((count++))
if [ $count = 0 ]; then 
	echo 'usuarios creados correctamente'
fi #[ $count = 0 ]

#POLITICAS DE CONTRASEÑA
count=0
#Todas las cuentas deberan cambiar la contraseña cada 60 dias y tendran que expirar el 31/07/2023. 
#Tendran un aviso de cambio de contraseña 10 dias del cumplimiento de su fecha
echo '###POLITICAS CONTRASEÑAS###'
chage -m 60 -E 2023-07-31 -W 10 alumno1asir || ((count++))
chage -m 60 -E 2023-07-31 -W 10 alumno2asir || ((count++))
chage -m 60 -E 2023-07-31 -W 10 alumno1eso || ((count++))
chage -m 60 -E 2023-07-31 -W 10 alumno2eso || ((count++))
chage -m 60 -E 2023-07-31 -W 10 alumno3eso || ((count++))
chage -m 60 -E 2023-07-31 -W 10 alumno4eso || ((count++))
chage -m 60 -E 2023-07-31 -W 10 profesor1 || ((count++))
if [ $count = 0 ]; then 
	echo 'politicas de contraseñas establecidas correctamente '
fi #[ $count = 0 ]

#ARBOL DE DIRECTORIOS
#En /srv/niveles habra un directorio para cada curso (1asir, 2asir, etc) 
#A su vez, dentro de cada curso, habra un directorio “entregatrabajos” para que el alumnado del curso correspondiente entregue los trabajos.
echo '###ARBOL DE DIRECTORIOS###'
mkdir -pv /srv/niveles/{1asir/entregatrabajos,2asir/entregatrabajos,1eso/entregatrabajos,2eso/entregatrabajos,3eso/entregatrabajos,4eso/entregatrabajos}
echo 'arbol de directorios listo'

#PERMISOS Y PROPIETARIOS DEL ARBOL DE DIRECTORIOS
echo '###PERMISOS Y PROPIETARIOS DEL ARBOL DE DIRECTORIOS###'
#Cuyo propietario sera el profesor 
chown -Rv profesor1 /srv/niveles
#Los usuarios “profesores” tendran acceso a todos los directorios creados anteriormente y podran borrar o crear ficheros.
chmod -Rv u+rwx /srv/niveles
#Restringimos un poco mas
chmod -v o-rwx /srv/niveles/*
#El grupo propietario sera el nivel para el que esta dirigido (por ejemplo 1asir para el grupo 1asir).
chgrp -Rv 1asir /srv/niveles/1asir
chgrp -Rv 2asir /srv/niveles/2asir
chgrp -Rv 1eso /srv/niveles/1eso
chgrp -Rv 2eso /srv/niveles/2eso
chgrp -Rv 3eso /srv/niveles/3eso
chgrp -Rv 4eso /srv/niveles/4eso
#Para el directorio “entregatrabajos” se estableceran las medias oportunas para que los alumnos no puedan leer/ver los trabajos
#entregados por otros compañeros/as o borrarselos.
chmod -v 1730 /srv/niveles/1asir/entregatrabajos
chmod -v 1730 /srv/niveles/2asir/entregatrabajos
chmod -v 1730 /srv/niveles/1eso/entregatrabajos
chmod -v 1730 /srv/niveles/2eso/entregatrabajos
chmod -v 1730 /srv/niveles/3eso/entregatrabajos
chmod -v 1730 /srv/niveles/4eso/entregatrabajos

#END
echo ''
echo "script $0 FINALIZADO"
