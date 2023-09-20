#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Error, ingrese el nombre del ejecutable &"
  echo "Uso: $0 <nombre_del_ejecutable> &"
  exit 1
fi

# Duración del monitoreo en segundos
tiempo_monitoreo=120  # 2 minutos

# Nombre del ejecutable
ejecutable="$1"

# Nombre del archivo de registro
log_file="registro.log"

# Obtener el tiempo actual en segundos, desde el inicio del sistema
tiempo_inicio=$(awk '{print int($1)}' /proc/uptime)

# Función para verificar si el proceso sigue en ejecución
proceso() {
  pgrep "$ejecutable" > /dev/null
}

# Inicializar el archivo de registro con encabezados si no existe
if [ ! -e "$log_file" ]; then
  echo "Tiempo CPU Memoria" > "$log_file"
fi

# Se monitorea el proceso
while proceso; do
  tiempo_actual=$(awk '{print int($1)}' /proc/uptime)
  delta_tiempo=$((tiempo_actual - tiempo_inicio))
  if [ "$delta_tiempo" -le "$tiempo_monitoreo" ]; then
    ps -C "$ejecutable" -o %cpu,%mem | tail -n 1 >> "$log_file"
    sleep 1
  else
    break
  fi
done

# Generar la gráfica con Gnuplot
gnuplot <<EOF
set terminal png
set output 'Grafica_Consumo.png'
set title 'Consumo de CPU y Memoria del ejecutable "$ejecutable"'
set xlabel 'Tiempo (s)'
set ylabel 'Valor Porcentual'
plot "$log_file" using 1 with lines title 'CPU', \
     "$log_file" using 2 with lines title 'Memoria'
EOF

echo "El monitoreo ha finalizado y se ha generado una gráfica en 'Grafica_Consumo.png'."
echo "Presione Crtl+C para salir del programa"