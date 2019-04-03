#!/usr/bin/gnuplot -c
# Eje X = Algoritmo
# Eje Y = Tiempo
# Color = Experimento

file = "data/bruta_vs_fact.txt"

if (ARG1 ne "") file = ARG1

filter_exp = sprintf("cut -d' ' -f1 %s | sort | uniq", file)
index_algos = sprintf("< awk '{ if (!($3 in algos)) algos[$3]=i++; print $1, algos[$3], $3, $5 }' %s", file)

experimentos = system(filter_exp)

set term qt persist
set title "Algoritmos vs Tiempos"
plot for [exp in experimentos] (index_algos) using 2:(strcol(1) eq exp ? $4 : NaN):xtic(3) title exp
