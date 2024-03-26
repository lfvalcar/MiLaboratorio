# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script para obtener informacion detallada del hardware y software de un equipo, con la opcion de generar un informe 
# que se pueda imprimir
# Profesor: Marco Antonio Jimenez Garcia



# Librerias 
. .\librerias.ps1

# Limpiar pantalla
Clear-Host

# Introducci�n
continuacion -mensaje 'Script para obtener informacion detallada del hardware y software de un equipo, con la opcion de generar un informe que se pueda imprimir'

# Valores permitidos para avanzar en el menu de generacion de informe
$valoresPermitidos=@('s','S','') 

# Expresion regular para comprobar si tiene extension
$expresionExtension="^.+\.[A-Za-z0-9]+$"

# Seleccionar opcion para el menu de generacion de informe
$confirmacion=Read-Host('�Quieres generar un informe? [S/n] ')
    
# Menu informe
if ($confirmacion -in $valoresPermitidos) {
    # Seleccionar nombre del informe
    $informe=Read-Host('�C�mo quieres llamar al informe (extensi�n por defecto .txt)?: ')
        
    # Comprobar extension
	if ($informe -notmatch $expresionExtension){
        # Si no tiene se le agrega la extension por defecto
		$informe="$informe.txt"
    } # if ($informe -notmatch $expresionExtension)

    # Funcion de obtencion de informacion del equipo (con informe)
    Write-Host 'obteniendo informaci�n sobre el equipo'
    info_equipo -informe $informe

}if($confirmacion -eq 'N'){
    # Funcion de obtencion de informacion del equipo (sin informe)
    Write-Host 'obteniendo informaci�n sobre el equipo'
    info_equipo -informe $null
}else{
    exit
} # if ($confirmacion -in $valoresPermitidos)
# END Menu informe

# Fin del script
Write-Host 'informaci�n detallada sobre el equipo obtenida y reportada'

# Obtener nombre del script
$scriptName = $MyInvocation.MyCommand.Name
Write-Host "script $scriptName finalizado"