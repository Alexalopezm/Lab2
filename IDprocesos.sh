#!/bin/bash

# Verifica que se haya proporcionado un argumento (ID de proceso).
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ID_de_proceso>"
    exit 1
fi

# Almacena el ID de proceso proporcionado como argumento.
process_id="$1"

# Verifica si el proceso existe.
if ps -p "$process_id" &>/dev/null; then
    # Obtén información del proceso y almacénala en variables.
    process_name=$(ps -o comm= -p "$process_id")
    parent_process_id=$(ps -o ppid= -p "$process_id")
    owner=$(ps -o user= -p "$process_id")
    cpu_usage=$(ps -o %cpu= -p "$process_id")
    memory_usage=$(ps -o %mem= -p "$process_id")
    status=$(ps -o stat= -p "$process_id")
    executable_path=$(readlink -f "/proc/$process_id/exe")

    # Muestra la información obtenida.
    echo "Nombre del proceso: $process_name"
    echo "ID del proceso: $process_id"
    echo "Parent process ID: $parent_process_id"
    echo "Usuario propietario: $owner"
    echo "Porcentaje de uso de CPU: $cpu_usage%"
    echo "Consumo de memoria: $memory_usage%"
    echo "Estado (status): $status"
    echo "Path del ejecutable: $executable_path"
else
    echo "El proceso con ID $process_id no existe."
    exit 2
fi

exit 0