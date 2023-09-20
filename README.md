# Lab2

- Alexa López Marcos, B94353

Script `IDprocesos`

> El script `IDprocesos.sh` toma el ID del proceso como argumento y utiliza el comando `ps` para obtener información detallada sobre ese proceso, incluyendo su nombre, ID, ID del parent process, usuario propietario, uso de CPU, consumo de memoria y estado. Luego, utiliza el comando `readlink` para obtener la ruta del ejecutable del proceso.

Script `Monitoreo`

> El script `Monitoreo.sh` monitoriza constantemente un proceso específico y, si se detiene, lo reinicia automáticamente. Para ello, verifica si el proceso está en ejecución utilizando `pgrep`, y si no lo está, muestra un mensaje indicando que el proceso ha terminado y ejecuta el comando proporcionado para reiniciar el proceso. El script se ejecuta en un bucle infinito, esperando 5 segundos entre cada verificación, lo que permite mantener aplicaciones o servicios críticos en funcionamiento de forma continua.

Script `Consumo`

> El script `Consumo.sh` monitorea un proceso específico, registra el uso de CPU y memoria del proceso en un archivo de registro.txt y luego genera una gráfica a partir de esos datos utilizando `Gnuplot`. El monitoreo se detiene después de un período de tiempo definido.
