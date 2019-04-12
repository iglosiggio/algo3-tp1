#!/usr/bin/awk -f

BEGIN {
	if (seed)
		srand(seed)
	else
		srand()
	if (!n)
		n = rand_rango(25, 71)

	for (i = 0; i < n; i++) {
		items["peso"][i] = int(rand_rango(0, 101))
		items["valor"][i] = int(rand_rango(0, 101))
		pesos += items["peso"][i]
	}

	w = rand_rango(2, pesos + 1)
	print int(n), int(w)

	for (i = 0; i < n; i++)
		print items["peso"][i], items["valor"][i]
}

# Genera un número en el intervalo [piso, techo)
function rand_rango(piso, techo) {
	return (techo - piso) * rand() + piso
}
