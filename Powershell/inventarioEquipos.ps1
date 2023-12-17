<#
#####INFO#####
    Autor: Luis Fernando Valverde Cardenas
    Objetivo: El objetivo es realizar un inventario de una serie de caracteristicas de los equipos del dominio

    Descripcion: Este script al ejecutarlo mediante un gpo de inicio de sesion recopilara una serie de datos sobre el equipo del usuario, estos datos se almacenaran en 5 archivos .csv llamados:
        
    1. "Inv_SO.csv" Descripcion: "Nombre equipo";"Sistema operativo";"Version";"Arquitectura";"Directorio SO"

    2. "Info_HW.csv" Descripcion: "Nombre equipo";"Fabricante";"Modelo";"Memoria RAM";"Procesador";"Numero nucleos procesador";"Numero nucleos procesador habilitados"

    3. "Info_Unidades.csv" Descripcion: "Nombre equipo";"Unidad";"Tama�o";"Sistema de arhivos"

    4. "Info_Net.csv" Descripcion: "Nombre equipo";"Identificador de red";"�DHCP habilitado?";"IP activa";"MAC Address";"Servidor DNS";"IP";"Mascara de red"

    5. "Info_SW.csv" Descripcion: "Nombre equipo";"Producto";"Version";"Vendedor";"Instalado en";"Fecha instalacion"
#>

#####INV_SO.CSV#####
#Obtenemos todas las caracteristicas acerca del sistema operativo mediante el cmdlet "Get-CimInstance" almacenado en la variable "$Inv_SO".
$Inv_SO=Get-CimInstance -ClassName  Win32_OperatingSystem | Select-Object *

#Creamos un nuevo objeto con "PSCustomObject" almacenado en la variable "$row" donde dentro de este objeto guardaremos: Caracterastica = $Inv_SO.CsName donde ".CsName" es el nombre de la propiedad que queremos que muestre de todas las almacenadas en "$row".
$row=[PSCustomObject]@{
    'Nombre equipo'=$Inv_SO.CsName
    'Sistema operativo'=$Inv_SO.Caption
    'Version'=$Inv_SO.Version
    'Arquitectura'=$Inv_SO.OSArchitecture
    'Directorio SO'=$Inv_SO.SystemDirectory
}#$row=[PSCustomObject]@

#Una vez hallamos recopilado las propiedades que queremos las exportaremos como archivo .csv elegiendo el delimitador,formato y sin la cabecera.
$row | Export-Csv -Path .\Inv_SO.csv -NoTypeInformation -Delimiter ';' -Encoding UTF8 

#####INFO_HW.CSV##### 
#Repetimo el proceso en vez del sistema operativo con el hardware del equipo.
$Info_HW=Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object *

#Aqui añadimos un recopilador mas para recoger informacion especifica sobre el procesador que la anterior no ha podido dar mas.
$Info_HW2=Get-CimInstance -ClassName Win32_Processor | Select-Object *

$row=[PSCustomObject]@{
    'Nombre equipo'=$Info_HW.Name
    'Fabricante'=$Info_HW.Manufacturer
    'Modelo'=$Info_HW.Model
    'Memoria RAM'=$Info_HW.TotalPhysicalMemory
    'Procesador'=$Info_HW2.Name
    'Numero nucleos procesador'=$Info_HW2.NumberOfCores
    'Numero nucleos procesador habilitados'=$Info_HW2.NumbersOfEnabledCores
}#$row=[PSCustomObject]@

$row | Export-Csv -Path .\Info_HW.csv -NoTypeInformation -Delimiter ';' -Encoding UTF8 

#####INFO_UNIDADES.CSV#####
#Al utilizar un bucle en este caso borramos el fichero para poder actualizar la informacion sin ninguna repeticion de datos
if(test-path ".\Info_Unidades.csv"){
    rm .\Info_Unidades.csv
}#if(test-path ".\Info_Unidades.csv")

#Repetimo el proceso con las unidades de almacenamiento
$Info_Unidades=Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object *

#Creamos una variable contador "$A" para el bucle y asi contar antes cuantas unidades dispone el usuario y asi mediante el bucle ir una por una recopilando sus caracteristicas
$A=(Get-CimInstance -ClassName Win32_LogicalDisk | Select-Object -ExpandProperty Name).count

#Creamos la variable "$B" que sera la que inicialize el bucle y ira sumandose hasta que sea menor que "$A" (numero de unidades de almacenamiento que hay empezando por el 0)
for($B=0;$B -lt $A;$B++ ){
    $row=[PSCustomObject]@{
        'Nombre equipo'=$Info_Unidades[$B].SystemName
        'Unidad'=$Info_Unidades[$B].Name
        'Tamaño'=$Info_Unidades[$B].Size
        'Sistema de arhivos'=$Info_Unidades[$B].FileSystem
    }#$row=[PSCustomObject]@

    $row | Export-Csv -Path .\Info_Unidades.csv -NoTypeInformation -Delimiter ';' -Append -Encoding UTF8

}#for($B=0;$B -lt $A;$B++ )

#####INFO_NET.CSV#####
if(test-path ".\Info_Net.csv"){
    rm .\Info_Net.csv
}#if(test-path ".\Info_Net.csv")

#Repetimo el proceso con las caracteristicas de los adaptadores de red
$Info_Net=Get-CimInstance -query "Select * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled='True'" | Select-Object * 
$A=(Get-CimInstance -query "Select * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled='True'" | Select-Object -ExpandProperty Caption).count

for($B=0;$B -lt $A;$B++ ){
    $row=[PSCustomObject]@{
        'Nombre equipo'=$Info_Net[$B].DNSHostName
        'Identificador de red'=$Info_Net[$B].Caption
        '¿DHCP habilitado?'=$Info_Net[$B].DHCPEanbled
        'IP activa'=$Info_Net[$B].IPEnabled
        'MAC Address'=$Info_Net[$B].MACAddress
        'Servidor DNS'=[string] $Info_Net[$B].DNSServerSearchOrder
        'IP'=[string] $Info_Net[$B].IPAddress
        'Mascara de red'=[string] $Info_Net[$B].IPSubnet
    }#$row=[PSCustomObject]@

    $row | Export-Csv -Path .\Info_Net.csv -NoTypeInformation -Delimiter ';' -Append -Encoding UTF8

}#for($B=0;$B -lt $A;$B++ )

#####INFO_SW.CSV#####
if(test-path ".\Info_SW.csv"){
    rm .\Info_SW.csv
}#if(test-path ".\Info_SW.csv"){

#Repetimo el proceso con las caracteristicas de los programas
$Info_SW=Get-CimInstance -ClassName Win32_Product | Select-Object *
$A=(Get-CimInstance -ClassName Win32_Product | Select-Object -ExpandProperty Name).count

for($B=0;$B -lt $A;$B++ ){
    $row=[PSCustomObject]@{
        'Nombre equipo'=$env:COMPUTERNAME
        'Producto'=$Info_SW[$B].Name
        'Version'=$Info_SW[$B].Version
        'Vendedor'=$Info_SW[$B].Vendor
        'Instalado en'=$Info_SW[$B].InstallLocation
        'Fecha instalacion'=$Info_SW[$B].InstallDate
    }#$row=[PSCustomObject]@

    $row | Export-Csv -Path .\Info_SW.csv -Delimiter ';' -NoTypeInformation -Append -Encoding UTF8

}#for($B=0;$B -lt $A;$B++ )

# SIG # Begin signature block
# MIIFcwYJKoZIhvcNAQcCoIIFZDCCBWACAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUibwCZ6s4KHmwwAL236WPE0To
# 96igggMMMIIDCDCCAfCgAwIBAgIQe4d8/hUxlKBKjNpwHfaleDANBgkqhkiG9w0B
# AQUFADAcMRowGAYDVQQDDBFUZXN0IENvZGUgU2lnbmluZzAeFw0yMzAyMTgxNTU3
# MzBaFw0yODAyMTgxNjA3MzBaMBwxGjAYBgNVBAMMEVRlc3QgQ29kZSBTaWduaW5n
# MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvmOao7jojtBmRw5poUR9
# yYItMGybhbNE3VYMld9WnnbLfn8c7FIemZfPaUWgo0wjKoy/Weh1Pe3BfZW+qCwq
# X8LlOXu98b1fpxXBc1lIG5mJIupfcDCOX6ijgQ2pd5Vh0kAvOuxeZLFTkHGv/dK4
# 67jpYgwW2pskCcdWqG7wH/9OKBwR0FEZiHfucpzvw4I1y4qnQX5hSuB/XhyX403v
# KfZZfr5rxvQRM6UpKmccveu8KTzUwk5/LDg05Hb4jeBV2CkGCQ2uqJuVjSkXej3s
# 29/cpJZSyDry7roILWwrP4tOSBySDObbM29dBBfVzxtY5+MBxmCy1OxS1yZbMq9L
# vQIDAQABo0YwRDAOBgNVHQ8BAf8EBAMCB4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMw
# HQYDVR0OBBYEFONhpQUeu76v3yqVs7iyeS+lQkinMA0GCSqGSIb3DQEBBQUAA4IB
# AQC1MjdJX7vFY51gb4X4XI8UGdwK2aJ+Q0dYqNjP++BgZjr8h+0lYlu2O+mw3RPp
# gZURWs8yhtEUFeOQ4i38TKJOH9Wy9lcUSqXsKUdJXY3ZKYFE94H2iv/QLXhnJirZ
# SbLveBNrezNt3OIq2MfzLlSnMOG4XzPeOL28hLoUcRN1EaNYUtyiILZmP07qF8fQ
# KPrljamlpa7dHvZit+DPSpbofuZvYA6HmnAABA4TOuLepDKyUqL6kvIjvvbvuhCB
# tyqQAAbHjH0sQsNn3WoVHXuFGtCFVuI5G4z0xzyva+uEKtEEhW2QAa7sTXsVEgbl
# USYnGgxEmOV40ICZRWMewP10MYIB0TCCAc0CAQEwMDAcMRowGAYDVQQDDBFUZXN0
# IENvZGUgU2lnbmluZwIQe4d8/hUxlKBKjNpwHfaleDAJBgUrDgMCGgUAoHgwGAYK
# KwYBBAGCNwIBDDEKMAigAoAAoQKAADAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIB
# BDAcBgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQU
# 6Uyy+03moig6MUTjaISQy47YCjUwDQYJKoZIhvcNAQEBBQAEggEAEkOS+gEEdnrd
# KCmtgcGlfauFQVrTs60SA4kp7U+J2Oya7idkqiwMnN32wMrNK3S2TVKZM0o5zlKQ
# ttD1STWI6bHhxW998OlPJqLXZ+K0Ygthg5bgKe9GiI60in8U2RfCV/Qmax4mDgQ3
# 3LjMh6Y8/MZWsgQp/1N3UrRvVxMskvnFPLy8V++zhgQFhJe3GLgTZAXhOcPgMEjN
# 2kCwNq9pqPrzNzxWvTpGJ+Gn68FkGHv9SzaJlUMiOA1seAmIZ0N7Jz/YyK2dg2+2
# 7OayoOlgx1PPzcHd5kJuAm4qeDeZjQjN5tDTAyJuAJB5vqrHeGJRedFmS5U+r+2Z
# 8hngkUjCaQ==
# SIG # End signature block
