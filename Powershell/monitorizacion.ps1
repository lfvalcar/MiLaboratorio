# Autor: Luis Fernando Valverde Cardenas
# Objetivo: Script en forma de menu para monitorizar el funcionamiento global del sistema, obteniendo metricas del rendimiento, 
# procesos y servicios importantes en ejecucion, usuarios conectados, alertas de seguridad, etc.
# Profesor: Marco Antonio Jimenez Garcia



# Librerias
. .\librerias.ps1

# Limpiar pantalla
Clear-Host

# Introducción
continuacion -mensaje 'Script en forma de menu para monitorizar el funcionamiento global del sistema, obteniendo metricas del rendimiento, procesos y servicios importantes en ejecucion, usuarios conectados, alertas de seguridad, etc.'

While ($true) {
	# Limpiar pantalla
	clear-Host

	# Menu
	Write-Host '1) Procesos que más recursos consumen'
	Write-Host '2) Procesos más prioritarios'
	Write-Host '3) Utilización de memoria RAM'
	Write-Host '4) Utilización de memoria virtual (swap)'
	Write-Host '5) Utilización de disco'
	Write-Host '6) Últimas actualizaciones instaladas'
	Write-Host '7) Usuarios conectados'
	Write-Host '8) Alertas de autenticación fallidas'
    Write-Host '9) Errores críticos del sistema'
	Write-Host '0) Salir'

	# Seleccionar una opcion
	$op=Read-Host('Seleccione una opción')
	Write-Host ''

	# Ociones
	switch ($op) {
		'0'{
			# Obtener nombre del script
            $scriptName = $MyInvocation.MyCommand.Name
            Write-Host "script $scriptName finalizado"
            exit
			}
		'1'{
			# Obtener info
            $topProcesos = Get-Process | Sort-Object -Property CPU -Descending | Select-Object -First 10

            # Imprimir info
            Write-Host -ForegroundColor Green 'Procesos que más recursos consumen'
            Write-Host -ForegroundColor Gray -NoNewline 'Proceso'
            Write-Host -NoNewline ':'
            Write-Host -ForegroundColor Cyan -NoNewline '(ID)'
            Write-Host -NoNewline ':'
            Write-Host -ForegroundColor Magenta -NoNewline 'Uso RAM'
            Write-Host -NoNewline ':'
            Write-Host -ForegroundColor Yellow 'Uso CPU'

            $position=1
            ForEach ($proceso in $topProcesos) {
                $nombre = $proceso.ProcessName
                $id = $proceso.Id
                $usoCPU = [math]::Round($proceso.CPU, 2)
                $usoMemoria = [math]::Round($proceso.WorkingSet / 1MB, 2)
                
                Write-Host -ForegroundColor Gray -NoNewline "$position $nombre"
                Write-Host -NoNewline ':'
                Write-Host -ForegroundColor Cyan -NoNewline "($id)"
                Write-Host -NoNewline ':'
                Write-Host -ForegroundColor Magenta -NoNewline "$usoMemoria MB"
                Write-Host -NoNewline ':'
                Write-Host -ForegroundColor Yellow "$usoCPU %"
                $position++
            } # ForEach ($proceso in $topProcesos)
			}
		'2'{
			# Propiedades a mostrar
            $props=@(
            'Name',
            'Priority'
            )

            # Obtener Info
            $procesos=Get-WmiObject -Query "SELECT * FROM Win32_Process"
            $procesosPrioritarios=$procesos | Sort-Object Priority
            $procesos=$procesosPrioritarios | Select-Object -First 5

            # Imprimir Info
            imprimir_color -color verde -texto 'Procesos más prioritarios' -archivo $null
            ForEach($proceso in $procesos){
                ForEach($prop in $props){
                    imprimir_color -color gris -texto $prop -archivo $null -formato '-NoNewline'
                    imprimir_color -texto ':' -archivo $null -formato '-NoNewline'
                    imprimir_color -color amarillo -texto $proceso.$prop -archivo $null
                } # ForEach($prop in $props)

                Write-Host ''
            } # ForEach($proceso in $procesos)    
			}
		'3'{
		    # Obtener info
            $informacionRAM = Get-CimInstance -ClassName Win32_OperatingSystem

            # Calcular info
            $memoriaTotalGB = [math]::Round($informacionRAM.TotalVisibleMemorySize / 1GB, 2)
            $memoriaDisponibleGB = [math]::Round($informacionRAM.FreePhysicalMemory / 1GB, 2)
            $porcentajeUtilizado = [math]::Round((($informacionRAM.TotalVisibleMemorySize - $informacionRAM.FreePhysicalMemory) / $informacionRAM.TotalVisibleMemorySize) * 100, 2)

            # Imprimir info
            imprimir_color -color verde -texto 'Información de la memoria RAM' -archivo $null
            imprimir_color -color gris -texto 'Memoria RAM Total' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$memoriaTotalGB GB" -archivo $null
  
            imprimir_color -color gris -texto 'Memoria RAM libre' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$memoriaDisponibleGB GB" -archivo $null

            imprimir_color -color gris -texto 'Memoria RAM utilizada' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$porcentajeUtilizado %" -archivo $null 
			}
		'4'{
			# Obtener info
            $informacionMemoria = Get-CimInstance -ClassName Win32_OperatingSystem

            # Calcular info
            $memoriaVirtualTotalGB = [math]::Round($informacionMemoria.TotalVirtualMemorySize / 1GB, 2)
            $memoriaVirtualDisponibleGB = [math]::Round($informacionMemoria.FreeVirtualMemory / 1GB, 2)
            $porcentajeUtilizadoMemoriaVirtual = [math]::Round((($informacionMemoria.TotalVirtualMemorySize - $informacionMemoria.FreeVirtualMemory) / $informacionMemoria.TotalVirtualMemorySize) * 100, 2)

            # Imprimir info
            imprimir_color -color verde -texto 'Información de la memoria virtual (swap)' -archivo $null
            imprimir_color -color gris -texto 'Memoria virtual total' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$memoriaVirtualTotalGB GB" -archivo $null

            imprimir_color -color gris -texto 'Memoria virtual libre' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$memoriaVirtualDisponibleGB GB" -archivo $null

            imprimir_color -color gris -texto 'Memoria virtual utilizada' -archivo $null -formato '-NoNewline'
            imprimir_color -texto ' : ' -archivo $null -formato '-NoNewline'
            imprimir_color -color amarillo -texto "$porcentajeUtilizadoMemoriaVirtual %" -archivo $null
			}
		'5'{
			# Obtener info
            $discosLocales=$(Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq 3 })

            # Imprimir info
            imprimir_color -color verde -texto 'Utilización de los discos locales' -archivo $null

            ForEach ($disco in $discosLocales) {
                $letra = $disco.DeviceID
                $tamanoTotal = [math]::Round($disco.Size / 1GB, 0)
                $espacioLibre = [math]::Round($disco.FreeSpace / 1GB, 0)
                $porcentajeLibre = [math]::Round(($espacioLibre / $tamanoTotal) * 100, 0)
                $tipoFileSystem = $disco.FileSystem

                Write-Host " $letra ${tamanoTotal}GB (Libre: $porcentajeLibre %) [$tipoFileSystem]"
            } # ForEach ($disco in $discosLocales)
			}	
		'6'{
            imprimir_color -color verde -texto 'Últimas 5 actualizaciones instaladas' -archivo $null
			Get-HotFix | Sort-Object -Property InstalledOn -Descending | Select-Object -First 5
			}	
		'7'{
			imprimir_color -color verde -texto 'Usuarios conectados' -archivo $null
            quser
			}	
		'8'{
            imprimir_color -color verde -texto 'Intento fallidos de autentificación' -archivo $null
			Get-EventLog -LogName Security -InstanceId 4625
			}	
		'9'{
            imprimir_color -color verde -texto 'Último 10 eventos críticos del sistema' -archivo $null
			Get-WinEvent -LogName System -FilterXPath "*[System[(Level=1)]]" -MaxEvents 10 -ErrorAction SilentlyContinue
			}
		default{
			Write-Host -ForegroundColor Red "Debes seleccionar una opción válida`n"
            }
	} # switch ($op)

	# Volver al menu
    Write-Host ''
	$pausa=Read-Host('Pulsa intro para continuar...') 
} # While ($true)