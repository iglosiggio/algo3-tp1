#!/usr/bin/awk -f

# Este script recibe una salida con el formato que escupe `make test`, se puede
# correr pipeando una salida o leyendo desde un archivo.

# Se puede pipear la salida a `column -t` para verlo de forma más prolija

{
	suma += $3
	suma_cuadrada += $3 ^ 2
	veces++
}

END {
	esperanza = suma / veces
	esperanza_cuadrada = suma_cuadrada / veces
	varianza = esperanza_cuadrada - (esperanza ^ 2)
	print veces, suma, esperanza, sqrt(varianza)
}
