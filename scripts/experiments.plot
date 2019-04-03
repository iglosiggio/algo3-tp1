#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo
# Color = Experimento

file = "data/bruta_vs_fact.txt"

if (ARG1 ne "") file = ARG1

filter_algos = sprintf("cut -d' ' -f3 %s | sort | uniq", file)
filter_exp = sprintf("cut -d' ' -f1 %s | sort | uniq", file)
index_exp = sprintf("< awk '{   \
	if (!($1 in e))         \
		e[$1]=i++;      \
	print $3, e[$1], $1, $5 \
}' %s", file)

algos = system(filter_algos)
experimentos = system(filter_exp)

set key noenhanced
set term qt persist
set xlabel "Casos de prueba"
set ylabel "Tiempo (ms)"
set xrange [-1:words(experimentos)]
set title "Tiempo gastado por cada algoritmo"
plot for [algo in algos] (index_exp) \
     using 2:(strcol(1) eq algo ? $4 : NaN):xtic(3) title algo[7:*]
