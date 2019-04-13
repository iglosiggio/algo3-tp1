#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.a.fuerza_bruta.series"
salida = "fotos/exp.a.fuerza_bruta.pdf"

if (ARG1 ne "") file = ARG1
if (ARG2 ne "") salida = ARG2

set key noenhanced
set term pdf
set output salida
set xlabel "n"
set ylabel "Tiempo (ms)"
set xrange [16 to 24]
set title "Tiempo gastado"
plot file pointtype 7 pointsize 0.2 title "Promedio por caso de prueba", \
     file smooth acsplines with line title "Curva aproximada"
