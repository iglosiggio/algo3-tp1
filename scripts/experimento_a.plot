#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.a.fuerza_bruta.series"
salida = "fotos/exp.a.fuerza_bruta.pdf"
fn = "n*2**n"

if (ARG1 ne "") file = ARG1
if (ARG2 ne "") salida = ARG2
if (ARG3 ne "") fn = ARG3

f(x,y) = @fn

fit f(x,y) file using 1:2:3 via k
stats file using 3:(f($1,$2)) name "DATA"

set term pdf
set output salida
set xlabel "n"
set ylabel "Tiempo (ms)"
set xrange [16 to 24]
set title sprintf("Tiempo gastado\nCorrelacion: %f", DATA_correlation)
plot file using 1:3 pointtype 7 pointsize 0.2 title "Promedio por caso de prueba", \
     file using 1:(f($1,$2)) with line title sprintf("Best fit para %s", fn)
