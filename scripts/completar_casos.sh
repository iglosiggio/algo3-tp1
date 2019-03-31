#!/bin/sh

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

if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
	echo "Uso: $0 -h [casos] [algoritmo]"
	echo "     El algoritmo por defecto es \`fuerza_bruta\`"
	echo "     La carpeta de casos por defecto es \`casos\`"
	exit 1
fi

casos='./casos/'
algo='./fuerza_bruta.algo'

if [ "$1" ]; then
	casos="$1"
fi

if [ "$2" ]; then
	algo="./$2.algo"
fi

grep -rl '^?$' "$casos" | while read -r salida; do
	"$algo" < "${salida%.out}.in" | cut -d' ' -f2 > "$salida"
done
