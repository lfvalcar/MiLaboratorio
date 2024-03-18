# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Crear funciones para los scripts
# Profesor: Marco Antonio Jimenez Garcia



function info_equipo($informe){
   # Introduccion del informe
   imprimir_color -color verde -texto 'Informe detallado del equipo'
   Write-Output 'Informe detallado del equipo' > $informe

   # Sistema
   # Titulo
   imprimir_color -color verde -texto 'Sistema' -archivo $informe

   # Propiedades a mostrar
   $props=@(
    'PSComputerName',
    'Manufacturer',
    'Model',
    'Name',
    'SystemFamily',
    'SystemType'
   )

   # Obtener Info
   $sistema=Get-WmiObject -Class Win32_computersystem

   # Imprimir Info
   Foreach($prop in $sistema.PSObject.Properties){
    if ($prop.Name -in $props){
        imprimir_color -color gris -texto $prop.Name -archivo $informe -formato '-NoNewline'
        imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
        imprimir_color -color amarillo -texto $prop.Value -archivo $informe
    } # if ($prop.Name -in $props)
   } # ForEach ($prop in $sistema.PSObject.Properties)

   # Salto de línea
   imprimir_color -texto ' ' -archivo $informe

   # Procesador
   # Titulo
   imprimir_color -color verde -texto 'Procesador' -archivo $informe

   # Propiedades a mostrar
   $props=@(
    'PSComputerName',
    'DeviceID',
    'DataWidth',
    'MaxClockSpeed',
    'Architecture',
    'Caption',
    'CurrentClockSpeed',
    'Familiy',
    'Manufacturer',
    'NumberOfCores',
    'NumberOfLogicalProcessors',
    'VirtualizationFirmwareEnabled'
   )

   # Obtener Info
   $procesador=Get-WmiObject -Class Win32_Processor

   # Imprimir Info
   Foreach($prop in $procesador.PSObject.Properties){
    if ($prop.Name -in $props){
        imprimir_color -color gris -texto $prop.Name -archivo $informe -formato '-NoNewline'
        imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
        imprimir_color -color amarillo -texto $prop.Value -archivo $informe
    } # if ($prop.Name -in $props)
   } # ForEach ($prop in $procesador.PSObject.Properties)

   imprimir_color -texto ' ' -archivo $informe

   # Memoria
   # Titulo
   imprimir_color -color verde -texto 'Memoria' -archivo $informe

   # Obtener Info
   $memoria=Get-ComputerInfo

   # Imprimir Info
   Foreach($prop in $memoria.PSObject.Properties){
    if ($prop.Name -match ".+Memory.*"){
        $memoriaMB=$prop.Value/1MB -as [int]
        imprimir_color -color gris -texto $prop.Name -archivo $informe -formato '-NoNewline'
        imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
        imprimir_color -color amarillo -texto "$memoriaMB MB" -archivo $informe
    } # if ($prop.Name -match ".+Memory.*")
   } # ForEach ($prop in $memoria.PSObject.Properties)

   imprimir_color -texto ' ' -archivo $informe

   # Red
   # Titulo
   imprimir_color -color verde -texto 'Red' -archivo $informe

   # Obtener Info
   $adaptadores=Get-NetAdapter

   # Propiedades a mostrar
   $props=@(
    'Name',
    'InterfaceDescription',
    'Status',
    'MacAdress',
    'LinkSpeed'
   )

   # Imprimir Info
   Foreach($adaptador in $adaptadores.Name){
    imprimir_color -color cyan -texto "$adaptador" -archivo $informe

    # Obtener Info
    $infoAdaptador=Get-NetAdapter -Name $adaptador

    Foreach($prop in $props){
        $propValue = $infoAdaptador.$prop
        imprimir_color -color gris -texto $prop -archivo $informe -formato '-NoNewline'
        imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
        imprimir_color -color amarillo -texto $propValue -archivo $informe

   } # ForEach ($prop in $props)

   imprimir_color -texto ' ' -archivo $informe
   } # ForEach ($adaptador in $adaptadores.Name)

   imprimir_color -texto ' ' -archivo $informe

   # Disco
   # Titulo
   imprimir_color -color verde -texto 'Discos' -archivo $informe

   # Obtener Info
   $discos=Get-WmiObject -Query 'SELECT * FROM Win32_DiskDrive'

   # Propiedades a mostrar
   $props=@(
    'Partitions',
    'DeviceID',
    'Model',
    'Size',
    'Caption'
   )

   # Inicialización de la variable contador para los títulos de los discos
   $count=0

   # Imprimir Info
   ForEach($disco in $discos){
    # Títulos de los discos 
    imprimir_color -color cyan -texto "Disco $count" -archivo $informe
    $count++

    ForEach($prop in $props){
        $propValue = $disco.$prop
        imprimir_color -color gris -texto $prop -archivo $informe -formato '-NoNewline'
        imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
        imprimir_color -color amarillo -texto $propValue -archivo $informe
   } # ForEach ($prop in $props)
   
   imprimir_color -texto ' ' -archivo $informe
   } # ForEach ($disco in $discos)
   
   imprimir_color -texto ' ' -archivo $informe

   # Paquetes instalados
   # Titulo
   imprimir_color -color verde -texto 'Programas Instalados' -archivo $informe

   # Obtener Info
   $programasInstalados=Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |  Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
   $programasInstalados+=Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
   $programasInstalados=$programasInstalados | ?{ $_.DisplayName -ne $null }

   # Propiedades a mostrar
   $props=@(
    'DisplayVersion',
    'Publisher',
    'InstallDate'
   )

    # Imprimir Info
    $programasInstalados | ForEach-Object {
    imprimir_color -color cyan -texto $_.DisplayName -archivo $informe

    ForEach($prop in $props){
        if($_.$prop -eq $null){
            imprimir_color -color gris -texto $prop -archivo $informe -formato '-NoNewline'
            imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
            imprimir_color -color amarillo -texto 'None' -archivo $informe
        }else{
            imprimir_color -color gris -texto $prop -archivo $informe -formato '-NoNewline'
            imprimir_color -texto ':' -archivo $informe -formato '-NoNewline'
            imprimir_color -color amarillo -texto $_.$prop -archivo $informe
        } # if ($_.$prop -eq $null)
    } # ForEach ($prop in $props)

    imprimir_color -texto ' ' -archivo $informe
}

} # function info_equipo

function imprimir_color($color,$texto,$archivo,$formato){
    # Seleccionar color
    switch ($color) {
        'negro' {
            $color='black'
        }
        'gris' {
            $color='gray'
        }
        'azul' {
            $color='blue'
        }
        'verde' {
            $color='green'
        }
        'cyan' {
        $color='cyan'
        }
        'rojo' {
            $color='rojo'
        }
        'magenta' {
            $color='magenta'
        }
        'amarillo' {
            $color='yellow'
        }
        'blanco' {
            $color='white'
        }
        $null {
            $color=$null
        }
        default {
            Write-Host "color no válido"
        }
    } # switch ($color)

    # Ordenes iniciales
    [string]$impresionPantalla='Write-Host'
    [string]$impresionArchivo='Write-Output'

    # Agregacion o no del formato especificado
    if ($formato -ne $null){
        $impresionPantalla+=" $formato"
    } # if ($formato -ne $null)

    # Agregacion o no del archivo
    if ($archivo -ne $null) {
        $impresionArchivo+=' "'+$texto+'"' +" | Add-Content -Path $archivo -Encoding UTF8"

        if ($formato -ne $null){
            $impresionArchivo+=" $formato"
        } # if ($formato -ne $null)

        # Ejecutamos el comando
        Invoke-Expression $impresionArchivo
    } # if ($archivo -ne $null)

    # Agregacion o no del color
    if ($color -ne $null){
        $impresionPantalla+=" -ForegroundColor $color"
    } # if ($color -ne $null)

    # Impresion final
    $impresionPantalla+=' "'+$texto+'" '
    Invoke-Expression $impresionPantalla
} # function imprimir_color

function generar_clave($longitud){
    if ($longitud -le 8) {
        Write-Host "La longitud de la contraseña debe ser mayor que 8."
        exit
    } # if ($longitud -le 8)

    $caracteresPermitidos='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_'

    # Se genera una clave aleatoria con una longitud de 16 caracteres
    for($count=0;$count -lt $longitud;$count++){
        # Obtener número aleatorio dentro de la longitud de los caracteres permitidos
        $numCaracter=$(Get-Random -Minimum 0 -Maximum ($caracteresPermitidos.Length-1))
        # Seleccionar carácter de los permitidos
        $caracter=$caracteresPermitidos[$numCaracter]
        # Añadir carácter a la contaseña
        $passwordPlainText+=$caracter
    } # for ($count=0;$password.Length -lt $longitud;$count++)

    # Convertir la contraseña de texot plano a segura
    $passwordSecure=$(ConvertTo-SecureString -String $passwordPlainText -AsPlainText -Force)

    $password = @{
        Secure = $passwordSecure
        PlainText = $passwordPlainText
    }

    return $password
} # function generar_clave

function usuario_existe($usuario) {
    # Comprobar si el usuario existe
    $userExists=$(Get-WmiObject Win32_UserAccount -Filter "Name='$usuario'" -ErrorAction SilentlyContinue)

    if ($userExists -ne $null) {
        return 1  # El usuario existe
    } else {
        return 0  # El usuario no existe
    } # if ($userExists -ne $null)
} # function usuario_existe

function grupo_existe($grupo) {
    # Comprobar si el grupo existe
    $groupExists=$(Get-WmiObject Win32_Group -Filter "Name='$grupo'" -ErrorAction SilentlyContinue)

    if ($groupExists -ne $null) {
        return 1  # El grupo existe
    } else {
        return 0  # El grupo no existe
    } # if ($groupExists -ne $null)
} # function grupo_existe

function continuacion($mensaje) {
    # Valores permitidos para avanzar en el menu
    $valoresPermitidos=@('s', 'S','')

    # Imprimir mensaje
    Write-Host -ForegroundColor Yellow $mensaje
    # Seleccionar opcion a partir del mensaje
    $confirmacion=Read-Host('¿Quieres continuar? [S/n] ')
    
    # Salir o continuar dependiendo de la opcion elegida
    if ($confirmacion -notin $valoresPermitidos) {
        exit
    } # if ($confirmacion -notin $valoresPermitidos)
} # function continuacion

function buscar_archivo_reciente($directorio,$patron){
    # Obtener archivos que coinciden con el patrón
    $coincidencias=$(Get-ChildItem -Path $directorio -Filter "*$patron*" -Recurse)

    # Obtener el archivo más reciente
    $coincidenciaReciente=$($coincidencias | Sort-Object LastWriteTime -Descending | Select-Object -First 1)

    # Verificar si se encontró el archivo
    if ($coincidenciaReciente) {
        return $coincidenciaReciente.FullName
    }else{
        Write-Host -ForegroundColor Red 'No se encontraron archivos que coincidan con el patrón en el directorio especificado.'
    } # if ($coincidenciaReciente)
} # buscar_archivo_reciente
