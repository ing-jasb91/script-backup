 # script-backup
# Versión 1.0.0 (alpha)
Powershell Script for backup config file from devices network.
Este proyecto es un inicio al programa de respaldo, gracias a James Preston of The Queen's College, Oxford.
Se planea utilizar las base de este script para extender sus funcionalidades en otros lenguajes de programación.

Requisitos previos:
Instalar la última versión de programa WinSCP: https://winscp.net/eng/download.php, o bien descargar la versión Automation y solo registar el dll.

Crear directorios en el sistema de archivos Windows, donde se tenga en cuenta la carpeta donde reposarán los archivos internos.
Por ejemplo en C:\AUTO-BACKUP\

Clonar este repositorio en la carpeta de su preferencia:
git clone https://github.com/ing-jasb91/script-backup.git

Cambiar las variables ($Add-Type, $switches, $outputfolder) a los directorios donde deberían apuntar

Modificar en el archivo "switches.csv" los datos de los dispositivos según la disposición de la tabla .csv
En el paramétro de typedevice del archivo csv, coloque: n HP Aruba/Procurve (0), Allied Telesis (1).

Si necesita incluir otro dispositivo en el condicional "switch case", descomente la línea 48, y coloque los datos según el tipo de dispositivo.
  
  

