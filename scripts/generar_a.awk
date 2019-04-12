#!/usr/bin/awk -f

BEGIN {
	if (seed)
		srand(seed)
	else
		srand()

	if (!n)
		n = int(rand_rango(15, 25))

	for (i = 0; i < n; i++) {
		items["peso"][i] = int(rand_rango(0, 101))
		items["valor"][i] = int(rand_rango(0, 101))
		pesos += items["peso"][i]
	}

	w = int(pesos / 2)

	print n, w

	for (i = 0; i < n; i++)
		print items["peso"][i], items["valor"][i]
}

# Genera un número en el intervalo [piso, techo)
function rand_rango(piso, techo) {
	return (techo - piso) * rand() + piso
}
