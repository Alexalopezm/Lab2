#!/bin/bash

# Directorio a monitorear
directorio="/home/alexa/plataformas/Lab2/ServMonitor"


# Archivo de registro
log_file="registro_cambios.log"

# Iniciar el monitoreo
while true; do
  inotifywait -m -r -e create,modify,delete "$directorio" |
  while read -r directorio evento archivo; do
    fecha_hora=$(date +"%Y-%m-%d %H:%M:%S")
    echo "$fecha_hora - Se detectó un evento de $evento en $archivo" >> "$log_file"
  done
  sleep 1  # Esperar 1 segundos antes de continuar monitoreando
done