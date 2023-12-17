#!/bin/bash

#SOBRE EL SCRIPT
echo '###CABECERA###'
echo "script $0"
echo 'AUTOR: Luis Fernando Valverde Cardenas' 
echo 'PROFESOR: Angel Oller Segura'
echo 'TEMARIO: UT.09 Administracion de Linux I (usuarios, procesos, servicios y red)' 
echo 'TRABAJO: TR.09.01. Creacion de scripts de configuracion del sistema'
echo 'OBJETIVO: Deshacer todo las configuraciones y modificaciones realizadas por el gestionUsuariosI.sh'

#REQUISITOS
echo '###REQUISITOS###'
echo 'Necesita ejecutarse con privilegios de SUPERUSUARIO'

#CONFIRMACIÓN
read -p '¿Desea continuar? [S/n] ' confirm
if [[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]; then
	echo 'Anulado'
	exit
fi #if [[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]

#ÁRBOL DE DIRECTORIOS
echo '###ÁRBOL DE DIRECTORIOS###'
rm -Rv /srv/niveles/*
rmdir -v /srv/niveles

#USUARIOS
echo '###USUARIOS###'
userdel -r alumno1asir
userdel -r alumno2asir
userdel -r alumno1eso
userdel -r alumno2eso
userdel -r alumno3eso
userdel -r alumno4eso
userdel -r profesor1

#GRUPOS
count=0 #Contador para contar los errores en caso de que haya
echo '###GRUPOS###'
groupdel 1asir || ((count++))
groupdel 2asir || ((count++))
groupdel 1eso || ((count++))
groupdel 2eso || ((count++))
groupdel 3eso || ((count++))
groupdel 4eso || ((count++))
groupdel profesores || ((count++))
groupdel alumnado || ((count++))
if [ $count = 0 ]; then 
	echo 'grupos borrados correctamente'
fi #if [ $count = 0 ]

#UMASK
echo '###UMASK###'
mv -v /etc/skel/.profile.bk /etc/skel/.profile

#END
echo ' ' 
echo "script $0 FINALIZADO"
