# Recreated by: ing.jasb91
# Based by James Preston of The Queen's College, Oxford // Website: myworldofit.net
# version 1.0 alpha 2019/07/16

#Load the .NET assembly for WinSCP
Add-Type -Path "C:\Program Files (x86)\WinSCP\WinSCPnet.dll"

#Import the CSV containing switch details and store it in a variable
$switches = Import-Csv -Path "C:\Users\jhon.serrano\Desktop\BACKUP-SWITCHES\switches.csv"

#Get the current system date in the format year/month/date which will be used to name the backup files
$date = Get-Date -Format yyyy-M-d

#Loop over the lines in the CSV
Foreach ($line in $switches) {

#Define the folder to store the output in and create it if it does not exist (if the folder exists already this will generate a non-blocking error)
$outputfolder = "C:\Users\jhon.serrano\Desktop\BACKUP-SWITCHES\Backups\" + $line.hostname + "\"
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
$sessionOptions.UserName = "transfer"
$sessionOptions.Password = "Qualc0mBackup-SW"
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
    switch ( $devicetype )
    {
        0 { $session.GetFiles("/cfg/startup-config", $outputpath, $False, $transferOptions) }
        1 { $session.GetFiles("/flash:/default.cfg", $outputpath, $False, $transferOptions) }
    }
}
#Disconnect from the server
$session.Dispose()
}