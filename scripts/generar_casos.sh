#!/bin/sh

generar_casos=$(dirname "$0")/generar_casos.awk

isnumber() {
	echo "$1" | grep -E "^[0-9]+$" >/dev/null
}

not() {
	if "$@"; then
		return 1
	else
		return 0
	fi
}

if [ $# != 2 ] || not isnumber "$1"; then
	echo "Uso: scripts/generar_casos.sh <cantidad> <prefijo> [sufijo]"
fi

for i in $(seq 1 "$1"); do
	awk -v seed="$i$3$2" -f "$generar_casos" > "$2$i$3.in"
	echo "INCOMPLETO" > "$2$i$3.out"
done
