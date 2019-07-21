﻿# Recreated by: ing.jasb91
# Based by James Preston of The Queen's College, Oxford // Website: myworldofit.net
# version 1.0.2 qualcomisp (qa) 2019/07/16
# Update 2019/07/20
# Añadido modulo de contraseñas más seguras sin el texto claro dentro de este código.
# Apunta a un archivo llamado cred.xml

#Load the .NET assembly for WinSCP & main variable
Add-Type -Path "[Ruta del archivo WinSCPnet.dll (Obtener de WinSCP Assembly)]"
$mainpath = "[Ruta principal donde se clonó o copió la herramienta]"
$switches = Import-Csv -Path "[Ruta del archivo separado por comas .csv; puede usar '$mainpath\filename.csv' si está en el directorio base]"
## Modulo para separar las credenciales del texto claro en el codigo en un archivo xml de PSCredentials #########
## Referencias:
## https://docs.microsoft.com/en-us/dotnet/api/system.management.automation.pscredential?view=pscore-6.2.0
## https://www.jaapbrasser.com/quickly-and-securely-storing-your-credentials-powershell/
## https://www.jesusninoc.com/system-management-automation-pscredential/
$credentials = Import-Clixml -Path "[Ruta del archivo separado por comas cred.xml; puede usar '$mainpath\cred.xml' si está en el directorio base]"
#################################################################################################################
$date = Get-Date -Format yyyy-M-d


#Loop over the lines in the CSV
    Foreach ($line in $switches) {

    #Define the folder to store the output in and create it if it does not exist (if the folder exists already this will generate a non-blocking error)
    $outputfolder = "$mainpath\Backups\" + $line.hostname + "\"
    #Variable "folderexists" creada para comprobar que existe el directorio del dispositivo "hostname".
    $folderexists = Test-Path $outputfolder
    #El codigo se anida en un condicional para evitar que se ejecute el codigo, si se cumple la condición anterior.
    if($folderexists -eq $False){
    New-Item $outputfolder -ItemType Directory
    }
    #Define the path to store the result of the download
    $outputpath = $outputfolder + $date

    #Store the session details
    $sessionOptions = New-Object WinSCP.SessionOptions
    $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
    $sessionOptions.HostName = $line.hostname
    ### Cambio de parámetros de crendenciales ###
    $sessionOptions.UserName = $Credentials.GetNetworkCredential().UserName
    $sessionOptions.Password = $Credentials.GetNetworkCredential().Password
    #############################################
    $sessionOptions.SshHostKeyFingerprint = $line.sshhostfingerprint
    $session = New-Object WinSCP.Session
    ##### New variable for distingh device type
    $devicetype = $line.typedevice

    #Connect to the host
    $fileexists = Test-Path $outputpath -PathType Leaf
    if ($fileexists -eq $False){
    $session.Open($sessionOptions)
}
#Define the transfer options
$transferOptions = New-Object WinSCP.TransferOptions
$transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

#Download the startup-config (the result of the last 'write memory' from the switches CLI) and save it to the outputpath
# Variable "fileexists" para comprobar existencia del archivo de configuración
if ($fileexists -eq $False){
# Switch Case To distinguish between types of devices [0 = HP Aruba/Procurve; 1 = Allied Telesis]
# Puede seguir agregando más equipos, descomentando las líneas 67 y 68, pero debe conocer el sistema de archivos y tenerlas en el csv.
    switch ( $devicetype )
    {
        0 { $transferResult = $session.GetFiles("/cfg/startup-config", $outputpath, $False, $transferOptions) }
        1 { $transferResult = $session.GetFiles("/flash:/default.cfg", $outputpath, $False, $transferOptions) }
        #2 { $session.GetFiles("<ruta del config file del dispositivo>", $outputpath, $False, $transferOptions) }
        #3 { $session.GetFiles("<ruta del config file del dispositivo>", $outputpath, $False, $transferOptions) }
    }
}
# Log para escribir el archivo log.txt y registrar los sucesos del respaldo.

foreach ($transfer in $transferResult.Transfers){
    if ($fileexists -eq $False){
        "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")   Backup of $($sessionOptions.HostName) succeeded" | Out-File -FilePath "$mainpath\backup-events.log"" -Append
}
    else{
        "$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")   The file $($sessionOptions.HostName) already exists" | Out-File -FilePath "$mainpath\backup-events.log"" -Append
}
}
# Disconnect from the server
$session.Dispose()
}
"$(Get-Date -Format "yyyy/MM/dd HH:mm:ss")   End of the process!" | Out-File -FilePath "$mainpath\backup-events.log" -Append
