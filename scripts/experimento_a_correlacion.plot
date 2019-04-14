#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.a.fuerza_bruta.series"
salida = "fotos/exp.a.correlacion.fuerza_bruta.pdf"
fn = "\$1*2**\$1"

if (ARG1 ne "") file = ARG1
if (ARG2 ne "") salida = ARG2
if (ARG3 ne "") fn = ARG3

f(x) = a * x + b

fit f(x) file using ( @fn ):2 via a, b

set key noenhanced
set term pdf
set output salida
set xlabel "Cota"
set ylabel "Tiempo real"
set title "Correlacion"
plot file using ( @fn ):2 pointtype 7 pointsize 0.2 notitle, \
     f(x) with line notitle
