# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para crear usuarios locales de forma automatizada especificados en un fichero 
# pasado como parametro.
# Profesor: Marco Antonio Jimenez Garcia



# Parámetros
param (
       [Parameter(Mandatory=$true)]
		[string]$archivoCSV 
)

# Librerias
. .\librerias.ps1

# Limpiar pantalla
Clear-Host

# Introducción
continuacion -mensaje 'Script para crear usuarios locales de forma automatizada especificados en un fichero pasado como parametro.'

# Archivo con las contraseñas generadas para cada usuario durante el script
$passwords='.\passwords.csv'
# Archivo con los registros generados durante el script
$logs='.\usuarios.log'

# Informacion de los requisitos al usuario antes de continuar el script
continuacion -mensaje "AVISO: para el correcto funcionamiento de este script tiene que ejecutarse con privilegios de ADMINISTRADOR`nGenera fichero passwords.csv con los usuarios y sus contraseñas generadas`nGenera fichero usuarios.logs con los registros del script"

# Seleccionar delimitador
$delimitador=Read-Host('Introduce el delimitador del archivo especificado como parámetro')

# Cabeceras de los archivos
Set-Content -Path $passwords -Value 'usuario,contraseña'
Start-Transcript -Path $logs

# Leer archivo CSV
$dataCSV=Import-CSV -Path $archivoCSV -Delimiter $delimitador

ForEach($registro in $dataCSV){ 
    # Variables obtenidas a partir de cada campo del fichero CSV
	$user=$registro.user
	$fullname=$registro.fullname
    $description=$registro.description
    $group=$registro.group

	# Se genera una clave aleatoria con una longitud de 16 caracteres
	$password=$(generar_clave -longitud 16)
	
	# Añadimos el usuario y su respectiva contraseña en el archivo de contraseña
	Add-Content -Path $passwords -Value "$user,$($password['PlainText'])"

	# Se comprueba si el grupo existe (resultado 1 o 0)
	$result=$(grupo_existe -grupo $group)

	if($result -eq 0){
        # Crear grupo
		New-LocalGroup $group 
        Write-Host -ForegroundColor Green "grupo $group creado"
	}else{
        Write-Host -ForegroundColor Yellow "el grupo $group existe, por lo tanto se salta su creación"
    } # if ($result -eq 0)
	
	# Se comprueba si el usuario existe (resultado 1 o 0)
	$result=$(usuario_existe -usuario $user)

	if ($result -ne 0){
		Write-Host -ForegroundColor Yellow "el usuario $user existe, por lo tanto se salta su creación"
	}else{
        # Crear usuario
		New-LocalUser -FullName $fullname -Description $description -Password $($password['Secure']) $user
        Write-Host -ForegroundColor Green "usuario $user creado"
        
        # Añadir usuario al grupo
        Add-LocalGroupMember -Group $group -Member $user
	} # if ($result -ne 0)

} # ForEach ($registro in $dataCSV)

Stop-Transcript
