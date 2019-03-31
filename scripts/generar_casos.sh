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

if [ $# -lt 2 ] || not isnumber "$1"; then
	echo "Uso: $0 <cantidad> <prefijo> [sufijo]"
	exit 1
fi

for i in $(seq 1 "$1"); do
	awk -v seed="$i$3$2" -f "$generar_casos" > "$2$i$3.in"
	echo "?" > "$2$i$3.out"
done
