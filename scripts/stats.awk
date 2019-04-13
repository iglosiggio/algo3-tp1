#!/usr/bin/awk -f

# Este script recibe una salida con el formato que escupe `make test`, se puede
# correr pipeando una salida o leyendo desde un archivo.

# Se puede pipear la salida a `column -t` para verlo de forma más prolija

{
	suma += $3
	datos[veces++] = $3
}

END {
	esperanza = suma / veces

	for (i = 0; i < veces; i++)
		error_cuadrado += (datos[i] - esperanza) ^ 2

	varianza = error_cuadrado / (veces - 1)

	print veces, suma, esperanza, sqrt(varianza)
}
