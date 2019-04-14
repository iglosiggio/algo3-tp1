#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file = "data/exp.c.dinamica.series"
salida = "fotos/exp.c.dinamica.pdf"

f(x) = k*x**2

fit f(x) file via k

set term pdf
set output salida
set xlabel "n y W"
set ylabel "Tiempo (ms)"
set title "Experimentación vs. best-fit"
plot file pointtype 7 pointsize 0.2 title "Promedio por caso de prueba", \
     f(x) with line title "Best fit para f(x) = kn^2"
