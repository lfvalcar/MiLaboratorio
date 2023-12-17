#!/bin/bash

#SOBRE EL SCRIPT
echo '###CABECERA###'
echo "script $0"
echo 'AUTOR: Luis Fernando Valverde Cardenas'
echo 'PROFESOR: Angel Oller Segura'
echo 'TEMARIO: UT.10. Administracion de Linux II (sistemas de ficheros,dispositivos de almacenamiento,copias de seguridad,rendimiento).' 
echo 'TRABAJO: TR.10.01 Implantación de un RAID 5 sobre LVM.'
echo -e 'OBJETIVO: A partir de tres discos pasados como parametros construya un sistema RAID 5 sobre un volumen LVM \n'

#REQUISITOS
echo '###REQUISITOS###'
#1º Necesita ejecutarse con privilegios de SUPERUSUARIO.
#2º Necesita especificar entre 3 dispositivos de almacenamiento como parametros al ejecutar el script 
#ejemplo: ./script /dev/sda /dev/sdb /dev/sdc

#CONFIRMACIÓN
echo 'Los dispositivos especificados como parametros seran formateados perdiendo toda informacion' 
read -p '¿Desea continuar? [S/n] ' confirm
if [[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]; then
	echo 'Anulado'
	exit
fi #[[ ($confirm != 'S' && $confirm != 's') || -z $confirm ]]

#FORMATEO
#preparamos los dispositivos 
echo '###FORMATEO###'
dd if=/dev/zero of=$1 status=progress
dd if=/dev/zero of=$2 status=progress
dd if=/dev/zero of=$3 status=progress

#PVCREATE
#creamos los volumenes fisicos
echo '###PVCREATE###'
pvcreate $1
pvcreate $2
pvcreate $3

#VGCREATE
#creamos el grupo de volumenes
echo '###VGCREATE###'
vgcreate data $1 $2 $3 

#LVCREATE
#creamos los volumenes logicos
echo '###LVCREATE###'
lvcreate -n data1 -l 33%VG data
lvcreate -n data2 -l 33%VG data
lvcreate -n data3 -l 33%VG data

#RAID-5
#creamos con los volumenes logicos un raid-5
echo '###CREACION RAID-5###'
mdadm -v -C /dev/md/server:raid5 -l raid5 -n 3 /dev/data/data[1-3]

#CARPETA MONTAJE
#creamos la carpeta donde se va a montar
echo '###CREACION CARPETA MONTAJE###'
mkdir -v /mnt/raid5-server

#FORMATO
#le damos un nuevo formato en ext4
echo '###NUEVO FORMATO###'
mkfs.ext4 /dev/md/server:raid5 

#MONTAJE
#montamos el raid-5 en la carpeta creada
echo '###MONTAJE RAID-5###'
mount -v -t ext4 /dev/md/server:raid5 /mnt/raid5-server 

#PERMANENTE
#hacemos el raid 5 permanente
echo '###PERMANENTE###'
echo '#RAID-5 SERVER' >> /etc/fstab
echo '/dev/md/server:raid5 /mnt/raid5-server ext4 defaults 0 0' >> /etc/fstab
tail -n 2 /etc/fstab
mdadm -Es >> /etc/mdadm/mdadm.conf
tail -n 1 /etc/mdadm/mdadm.conf

#RESULTADO
#vemos el resultado
echo '###RESULTADO###'
lsblk

#END
echo ''
echo "script $0 FINALIZADO"
