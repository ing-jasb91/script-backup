# script-backup

# Versión 1.0.2 (dev)

Powershell Script for backup config file from devices network.
Este proyecto es un inicio al programa de respaldo, gracias a James Preston of The Queen's College, Oxford.
Se planea utilizar las base de este script para extender sus funcionalidades en otros lenguajes de programación.

Esta es la versión dek desarrollador de la herramienta backup

Modulos que ya maneja:

+ Carga del assembly WinSCPNet.dll para la comunicación herramienta-devicenet
+ Directorios $mainpath (carpeta base)
+ Importe de archivos csv (contenedor de ip del dispositivo de red, tipo de dispositivo y fingerprint)
+ Importe del archivo xml (contiene el usuario y la contraseña cifrada por PSCredentials)
+ Bucle "foreach" para tratar cada línea del archivo csv como un dispositivo al que debe respaldar el archivo de configuración
+ Modulo de log para visualizar los sucesos (respaldo y fin del proceso)
