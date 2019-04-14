#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.a.fuerza_bruta.series"
salida = "fotos/exp.a.correlacion.fuerza_bruta.pdf"

if (ARG1 ne "") file = ARG1
if (ARG2 ne "") salida = ARG2

f(x) = a * x + b

fit f(x) file using ($1*$2):3 via a, b

set key noenhanced
set term pdf
set output salida
set xlabel "Cota"
set ylabel "Tiempo real"
set title "Correlacion"
plot file using ($1*$2):3 pointtype 7 pointsize 0.2 notitle, \
     f(x) with line notitle
