#!/bin/bash

# Comprueba si se proporcionó un argumento (el ejecutable a monitorear).
if [ $# -ne 1 ]; then
    echo "Uso: $0 <ejecutable>"
    exit 1
fi

# Nombre del ejecutable a monitorear.
ejecutable="$1"

# Nombre del archivo de registro.
log_file="registro.txt"

# Intervalo de tiempo entre las lecturas de uso de CPU y memoria (en segundos).
intervalo=1

# Tiempo máximo de ejecución del proceso (en segundos).
tiempo_maximo=60

# Inicializa el archivo de registro.
echo "Tiempo CPU Memoria" > "$log_file"

# Inicia el proceso y obtiene su PID.
./$ejecutable &
pid=$!

# Monitorea el proceso durante el tiempo especificado.
contador=0
while [ $contador -lt $tiempo_maximo ]; do
    tiempo_actual=$(date "+%H:%M:%S")
    uso_cpu=$(ps -p $pid -o %cpu | tail -n 1)
    uso_memoria=$(ps -p $pid -o %mem | tail -n 1)
    echo "$tiempo_actual $uso_cpu $uso_memoria" >> "$log_file"
    sleep $intervalo
    contador=$((contador + $intervalo))
done

# Detiene el proceso.
kill $pid

# Grafica los valores utilizando Gnuplot.
gnuplot <<EOF
set xlabel "Tiempo"
set ylabel "Porcentaje"
set title "Consumo de CPU y Memoria"
set terminal png
set output "grafico.png"
plot "$log_file" using 1:2 with lines title "CPU", \
     "$log_file" using 1:3 with lines title "Memoria"
EOF

echo "Proceso finalizado. Se ha generado un archivo de registro y un gráfico."

exit 0