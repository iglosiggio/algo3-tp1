#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo
# Color = Experimento

file = "data/bruta_vs_fact.txt"

if (ARG1 ne "") file = ARG1

filter_algos = sprintf("cut -d' ' -f3 %s | sort | uniq", file)
filter_exp = sprintf("cut -d' ' -f1 %s | sort | uniq", file)

algos = system(filter_algos)
experimentos = system(filter_exp)

by_algo = '"< grep ".algo." ".file." | grep "'

set term qt persist

set key noenhanced
set border 1
set style fill transparent solid 0.5 noborder
set xlabel "Tiempo (ms)"

unset ytics
set xtics axis

set multiplot layout 4, 3 title "Algoritmos vs Tiempos"

do for [ex in experimentos] {
	set title ex

	plot for [algo in algos] \
	     ("< grep '^".ex." ' '".file."' | grep ' ".algo." '") \
	     using 5:(1) smooth kdensity with filledcurves y=0 notitle
}

unset multiplot
