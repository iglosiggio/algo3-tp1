#!/usr/bin/awk -f

BEGIN {
	if (seed)
		srand(seed)
	else
		srand()

	n = w = int(rand_rango(100, 1001))

	print n, w

	for (i = 0; i < n; i++)
		print int(rand_rango(1, w / 2)), int(rand_rango(1, 5001))
}

# Genera un número en el intervalo [piso, techo)
function rand_rango(piso, techo) {
	return (techo - piso) * rand() + piso
}
