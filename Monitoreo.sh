#!/bin/bash

# Verifica que se proporcionen los argumentos requeridos
if [ $# -ne 2 ]; then
    echo "Error, ingrese el nombre del proceso y comando para ejecutar"
    echo "Uso: $0 <nombre_del_proceso> <comando_para_ejecutar>"
    exit 1
fi

nombre_proceso="$1"
comando="$2"

while true; do
  # Verificar si el proceso está en ejecución
  if pgrep -x "$nombre_proceso" >/dev/null; then
    echo "El proceso '$nombre_proceso' está en ejecución."
  else
    echo "El proceso '$nombre_proceso' ha terminado. Reiniciando..."
    # Ejecutar el comando para reiniciar el proceso
    $comando &
  fi

  # Intervalo de tiempo para revisar el estado del proceso (en segundos)
  sleep 5
done