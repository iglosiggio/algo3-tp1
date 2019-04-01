#!/usr/bin/awk -f

BEGIN {
	if (!field)
		field = 0
}

{
	suma += $(field)
	suma_cuadrada += $(field) * $(field)
	i++
}

END {
	if (i == 0)
		exit

	esperanza = suma/i
	esperanza_cuadrada = suma_cuadrada/i
	varianza = esperanza_cuadrada - esperanza * esperanza
	printf("%f %f %f\n", suma, esperanza, sqrt(varianza))
}
