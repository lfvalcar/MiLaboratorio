#Autor: Luis Fernando Valverde Cardenas
#Objetivo: Copiar todos los archivos de una ruta a otra, en el caso de que existe el archivo, nos quedaremos con el que tenga la fecha de modificacion superior.

#Inicializamos variables para el bucle
$quitForce=''
$quit='S'
#Establecemos un bucle para encerrar al usuario hasta que no continue o introduzca las rutas bien
while($quit -eq 'S'){
    #Le pedimos al usuario que introduzca la ruta de origen de los archivos a copiar y la ruta de destino donde se copiaran
    Write-Host 'AVISO: Las rutas que introduzca deben tener el siguiente formato: C:\Users\usuario'
    $source=Read-Host('Introduce la ruta de origen que contiene los archivos que quieres copiar')
    $target=Read-Host('Introduce la ruta de destino donde se copiaran los archivos')

    #Comprobamos que las rutas son correctas
    if((-not(test-path $source)) -or (-not(test-path $target))){
        #Las rutas no son correctas
        Write-Host 'Las rutas introducidas son incorrectas'
        $QuitForce=Read-Host('Quieres continuar (S/N)')
    }else{
        #Salimos del bucle al comprobar que las rutas estan bien
        $quit='N'    
    }#if((-not(test-path $source)) -or (-not(test-path $target)))
    
    #Si el usuario decide continuar este if se salta y si no decide continuar se sale del script
    if($QuitForce -eq 'N'){
        exit
    }else{}#if($QuitForce -eq 'N')
    
}#while($quit -eq 'S')

#De las rutas introducidas por el usuario obtenemos el contenido (archivos)
$SourceContent=Get-ChildItem -File $source
$TargetContent=Get-ChildItem -File $target

#Con un bucle comprobamos por cada archivo del origen si existe en el destino (si no existe se copiara)
for($count=0;$count -lt $SourceContent.count;$count++){    
    #Del contenido del origen vamos extrayendo los nombres de los archivos convirtiendolos en cadenas de texto para que funcionen con .contains
    [string]$id=$SourceContent[$count]

    #Comprobamos si en el destino existe el archivo
    if($TargetContent.Name.Contains($id)){        
        #En caso de que exista,filtramos por el nombre para obtener su fecha de modificacion
        $FilterTarget=Get-ChildItem $target -Filter $id
        
        #Comparamos las fechas de modificacion de ambos archivos
        if($SourceContent[$count].LastWriteTime -gt $FilterTarget.LastWriteTime){    
            #Si la fecha de modificacion del origen es superior a la del destino, se sobrescribe
            Copy-Item "$source\$id" $target

        }else{}#if($SourceContent[$count].LastWriteTime -gt $FilterTarget.LastWriteTime)

    }else{        
        #Copiamos los archivos si no existen en el destino
        Copy-Item "$source\$id" $target
    }#if($TargetContent.Name.Contains($id))

}#for($count=0;$count -lt $SourceContent.count;$count++)