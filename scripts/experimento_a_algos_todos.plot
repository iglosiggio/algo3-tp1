#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo

file_fb = "data/exp.a.fuerza_bruta_cortada.series"
file_mitm = "data/exp.a.mitm_cortada.series"
file_din = "data/exp.a.dinamica_cortada.series"

file_bk_fact = "data/exp.a.backtracking_fact_cortada.series"
file_bk_opt = "data/exp.a.backtracking_opt_cortada.series"

salida = "fotos/exp.a.algos_todos.pdf"

if (ARG1 ne "") salida = ARG1

set term pdf
set output salida
set xlabel "n"
set ylabel "Tiempo (ms)"
set xrange [16 to 24]
set yrange [0 to 65536]
set title sprintf("Tiempo gastado por cada algoritmo")
set logscale y 2

plot file_fb using 1:3 with line title "Promedio por fuerza bruta", \
	 file_din using 1:3 with line title "Promedio por dinamica", \
 	 file_mitm using 1:3 with line title "Promedio por mitm", \
 	 file_bk_opt using 1:3 with line title "Promedio por optimalidad", \
 	 file_bk_fact using 1:3 with line title "Promedio por factibilidad", \
