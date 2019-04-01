#!/usr/bin/awk -f

{
	sumas[$1][$3] += $5
	sumas_cuadradas[$1][$3] += $5 ^ 2
	cantidades[$1][$3]++
}

END {
	for (caso in sumas)
		for (algo in sumas[caso]) {
			cant = cantidades[caso][algo]
			suma = sumas[caso][algo]
			suma_cuadrada = sumas_cuadradas[caso][algo]
			esperanza = suma / cant
			esperanza_cuadrada = suma_cuadrada / cant
			varianza = esperanza_cuadrada - (esperanza ^ 2)
			print caso, algo, cant, suma, esperanza, sqrt(varianza)
		}
}
