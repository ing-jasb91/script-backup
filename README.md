 # script-backup
# Versión 1.0.0 (alpha)
Powershell Script for backup config file from devices network.
Este proyecto es un inicio al programa de respaldo, gracias a James Preston of The Queen's College, Oxford.
Se planea utilizar las base de este script para extender sus funcionalidades en otros lenguajes de programación.

Requisitos previos:
Instalar la última versión de programa WinSCP: https://winscp.net/eng/download.php
Crear directorios en el sistema de archivos Windows, donde se tenga en cuenta la carpeta donde reposarán los archivos internos.

Clonar este repositorio en la carpeta de su preferencia: git clone https://github.com/ing-jasb91/script-backup.git
Cambiar las variables ($Add-Type, $switches, $outputfolder, $)
Modificar en el archivo switches.csv los datos de los dispositivos según su la dispositivo de la tabla .csv
Si necesita incluir otro dispositivo en el condicional "switch case", descomente la línea 48, y coloque los datos según el tipo de dispositivo.
  En este caso solo funciona con HP Aruba/Procurve (0), y los equipos Allied Telesis (1).
  

