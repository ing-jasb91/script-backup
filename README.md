# script-backup

# Versión 1.0.0 (alpha)

Powershell Script for backup config file from devices network.
Este proyecto es un inicio al programa de respaldo, gracias a James Preston of The Queen's College, Oxford.

Instrucciones:
1) Instalar la última versión de programa WinSCP: https://winscp.net/eng/download.php, o bien descargar la versión Automation y solo registar el dll.

2) Crear directorios en el sistema de archivos Windows, donde se tenga en cuenta la carpeta donde reposarán los archivos internos.
Por ejemplo en C:\AUTO-BACKUP\. Puede ser otra, de su preferencia.

3) Clonar este repositorio en la carpeta elegida anteriormente:
git clone https://github.com/ing-jasb91/script-backup.git

4) Cambiar las variables ($Add-Type, $switches, $outputfolder, $credentials) a los directorios donde deberían apuntar.

5) Modificar en el archivo "switches.csv" los datos de los dispositivos según la disposición de la tabla .csv
Recuerde que esta tabla solo debe contener la dirección IP del dispositivo, el tipo de dispositivo según marca/modelo y el fingerprint.
Para el paramétro de typedevice, en el archivo csv coloque: para HP Aruba/Procurve (0) y para Allied Telesis (1).
