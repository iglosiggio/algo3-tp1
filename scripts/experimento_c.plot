#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.c.dinamica.series"
salida = "fotos/exp.c.dinamica.pdf"

set key noenhanced
set term pdf
set output salida
set xlabel "n"
set ylabel "Tiempo (ms)"
set title "Tiempo gastado"
plot file pointtype 7 pointsize 0.2 title "Promedio por caso de prueba", \
     file smooth acsplines with line title "Curva aproximada"
