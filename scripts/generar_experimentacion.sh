#!/bin/sh

generar_a=$(dirname "$0")/generar_a.awk
generar_b=$(dirname "$0")/generar_b.awk
generar_c=$(dirname "$0")/generar_c.awk
casos=$(dirname "$0")/../casos

seed_a=1967
seed_b=5612
seed_c=8462

for i in $(seq 1 250); do
	# Experimento A
	script=$generar_a
	seed=$seed_a
	archivo="$casos/exp.a.$i"
	$script -v seed="$((i + seed))" > "$archivo.in"
	echo "?" > "$archivo.out"
	# Experimento B
	script=$generar_b
	seed=$seed_b
	archivo="$casos/exp.b.$i"
	$script -v seed="$((i + seed))" > "$archivo.in"
	echo "?" > "$archivo.out"
	# Experimento C
	script=$generar_c
	seed=$seed_c
	archivo="$casos/exp.c.$i"
	$script -v seed="$((i + seed))" > "$archivo.in"
	echo "?" > "$archivo.out"
done
