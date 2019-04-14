#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.c.dinamica.series"
salida = "fotos/exp.c.dinamica.pdf"

f(x) = k*x**2

fit f(x) file via k
stats file using 2:(f($1)) name "DATA"

set term pdf
set output salida
set xlabel "n y W"
set ylabel "Tiempo (ms)"
set title sprintf("Experimentación vs. best-fit\nCorrelacion: %f", \
                  DATA_correlation)
plot file pointtype 7 pointsize 0.2 title "Promedio por caso de prueba", \
     f(x) with line title "Best fit para f(x) = kn^2"
