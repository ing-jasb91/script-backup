#Created by: James Preston of The Queen's College, Oxford
#Version: 1.0 on 02/11/2015 17:05
#Website: myworldofit.net

#Load the .NET assembly for WinSCP
Add-Type -Path "C:\Program Files (x86)\WinSCP Automation\WinSCPnet.dll"

#Import the CSV containing switch details and store it in a variable
$switches = Import-Csv -Path "C:\Network Switch Backup\switches.csv"

#Get the current system date in the format year/month/date which will be used to name the backup files
$date = Get-Date -Format yyyy-M-d

#Loop over the lines in the CSV
Foreach ($line in $switches) {

#Define the folder to store the output in and create it if it does not exist (if the folder exists already this will generate a non-blocking error)
$outputfolder = "C:\Network Switch Backup\Backups\" + $line.hostname + "\"
New-Item $outputfolder -ItemType Directory

#Define the path to store the result of the download
$outputpath = $outputfolder + $date

#Store the session details
$sessionOptions = New-Object WinSCP.SessionOptions
$sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
$sessionOptions.HostName = $line.hostname
$sessionOptions.UserName = "transfer"
$sessionOptions.Password = "Qualc0mBackup-SW"
$sessionOptions.SshHostKeyFingerprint = $line.sshhostfingerprint
$session = New-Object WinSCP.Session

#Connect to the host
$session.Open($sessionOptions)

#Define the transfer options
$transferOptions = New-Object WinSCP.TransferOptions
$transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

#Download the startup-config (the result of the last 'write memory' from the switches CLI) and save it to the outputpath
$transferResult = $session.GetFiles("/cfg/startup-config", $outputpath, $False, $transferOptions)

#Disconnect from the server
$session.Dispose()

}