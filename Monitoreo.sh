#!/bin/bash

# Verifica si se proporcionan los argumentos correctos.
if [ $# -ne 2 ]; then
    echo "Error, ingrese el nombre del proceso y comando para ejecutar"
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

# Almacena el nombre del proceso y el comando para ejecutarlo.
process_name="$1"
command_to_run="$2"

# Función para verificar y reiniciar el proceso.
monitor_process() {
    while true; do
        # Verifica si el proceso está en ejecución.
        if pgrep -x "$process_name" >/dev/null; then
            echo "El proceso '$process_name' está en ejecución."
        else
            echo "El proceso '$process_name' no está en ejecución. Se volverá a iniciar."
            # Inicia el proceso nuevamente.
            eval "$command_to_run" &
        fi

        # Espera un tiempo antes de volver a verificar.
        sleep 5  # Puedes ajustar el intervalo de verificación según tus necesidades.
    done
}

# Inicia el monitoreo del proceso en segundo plano.
monitor_process &

# Muestra un mensaje informativo.
echo "Monitoreando el proceso '$process_name'. Presiona Ctrl+C para detener el monitoreo."

# Espera hasta que se presione Ctrl+C para detener el monitoreo.
trap 'echo "Deteniendo el monitoreo."; exit' SIGINT
wait