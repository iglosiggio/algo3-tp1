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
set ylabel "W"
set title "Tiempo gastado"
#set hidden3d
set xrange [25:70]
set yrange [0:3765]
set cbrange [0:30000]
set palette defined (0 "blue", 100 "#00ffff", 2000 "white", 5000 "yellow", \
                     30000 "red", 30001 "grey")
plot file using 1:2:3 pointtype 7 pointsize 0.3 palette title ""
