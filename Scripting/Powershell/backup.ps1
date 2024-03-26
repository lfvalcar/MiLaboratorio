# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para realizar la copia de seguridad y la restauracion de la carpeta personal de los usuarios indicados por parametros.
# Profesor: Marco Antonio Jimenez Garcia



# Librerias
. .\librerias.ps1

# Limpiar pantalla
Clear-Host

# Introducción
continuacion -mensaje 'Script para realizar la copia de seguridad y la restauracion de la carpeta personal de los usuarios indicados por parametros.'

# Requisitos
continuacion -mensaje "AVISO: para el correcto funcionamiento de este script tiene que ejecutarse con privilegios de ADMINISTRADOR`nNecesita los siguientes parámetros: .\backup.ps1 usuario1 usuario2`nGenera un archivo backup.log con los eventos del script"

# Variables
$logs='.\backup.log'

# Generacion del archivo de eventos
Start-Transcript -Path $logs

While($true){ 
	# Menu
	Clear-Host
	Write-Host "Usuarios seleccionados: $args"
	Write-Host 'C) Realizar copia de seguridad de los usuarios seleccionados'
	Write-Host 'R) Restaturar última copia de seguridad de los usuarios seleccionados'
	Write-Host 'E) Ver los registros de los backups'
	Write-Host '0) Salir'

	# Seleccionar opcion
	$operacion=Read-Host('Seleccione una opción')
	Write-Host ''

	# Opciones
	switch($operacion){
		0{
            Stop-Transcript
			# Obtener nombre del script
            $scriptName = $MyInvocation.MyCommand.Name
            Write-Host "script $scriptName finalizado"
            exit
		}
		'C'{
			# Ruta donde se almacenan los backups
			$rutaBackup=Read-Host('¿Donde desea almacenar la copia de seguridad? [ruta absoluta]')

            # Fecha de los backups
            $fechaBackup=$(Get-Date -Format "MM-dd-yyyy_HH-mm")

			# Por cada usuario se realiza el backup
			ForEach($usuario in $args){
				$backup="$rutaBackup\$usuario-$fechaBackup.zip"

                # Realiza la copia y comprimirla
				Compress-Archive -Path "C:\Users\$usuario" -DestinationPath $backup

				# Se comprueba si el backup se ha realizado con exito o no
				if(Test-Path $backup){
					Write-Host 'Backup realizado con éxito'
				}else{
                    Write-Host "Backup terminado con errores, para más información $logs"
				} # if(Test-Path $backup)
            } # ForEach($usuario in $args)
		}
		'R'{
			# Ruta donde las copias de seguridad a restaurar
			$rutaBackup=Read-Host('¿Directorio donde se almacenan las copias a restaurar? [ruta absoluta]')

			# Por cada usuario se selecciona la copia mas reciente y se restaura
			ForEach($usuario in $args){
				$backupRestore=$(buscar_archivo_reciente -patron $usuario -directorio $rutaBackup)
				
                # Descompresión y restauración del backup
                Expand-Archive -Path $backupRestore -DestinationPath "C:\Users"

				# Se comprueba si el backup se ha restaurado con exito o no
				if(Test-Path "C:\Users\$usuario"){
                    Write-Host 'Backup restaurado con éxito'
				}else{
                    Write-Host "Backup restaurado con errores, para más información $logs"
				} # if(Test-Path "C:\Users\$usuario")
			} # ForEach($usuario in $args)
		}
		'E'{
			cat $logs
		}
		default{
			Write-Host "Debes seleccionar una opción válida [C/R]`n"
        }
	} # switch($operacion)

	# Volver al menu
	Write-Host ''
	$pausa=Read-Host('Pulsa intro para continuar...') 
} # While($true)