#!/usr/bin/awk -f

# Este script recibe una salida con el formato que escupe `make test`, se puede
# correr pipeando una salida o leyendo desde un archivo.

# Se puede pipear la salida a `column -t` para verlo de forma más prolija

# Salida de ejemplo:
# $ scripts/stats.awk data/bruta_vs_fact.txt | sort | column -t
# ej1     algos/backtracking_fact.cpp  200  0.214678  0.00107339  0.00022847
# ej1     algos/fuerza_bruta.cpp       200  0.743579  0.0037179   0.00081167
# gen.1   algos/backtracking_fact.cpp  200  13.9821   0.0699105   0.0378566
# gen.1   algos/fuerza_bruta.cpp       200  606.397   3.03198     0.739051
# gen.10  algos/backtracking_fact.cpp  200  2.21292   0.0110646   0.00653992
# gen.10  algos/fuerza_bruta.cpp       200  114.717   0.573583    0.40238
# gen.2   algos/backtracking_fact.cpp  200  1.29698   0.00648491  0.00340202
# gen.2   algos/fuerza_bruta.cpp       200  103.516   0.517582    0.12764
# gen.3   algos/backtracking_fact.cpp  200  15.5708   0.0778539   0.0632328
# gen.3   algos/fuerza_bruta.cpp       200  762.537   3.81268     0.798048
# gen.4   algos/backtracking_fact.cpp  200  0.862646  0.00431323  0.00122599
# gen.4   algos/fuerza_bruta.cpp       200  37.8045   0.189023    0.0773748
# gen.5   algos/backtracking_fact.cpp  200  0.303949  0.00151975  0.00123171
# gen.5   algos/fuerza_bruta.cpp       200  5.97142   0.0298571   0.0382396
# gen.6   algos/backtracking_fact.cpp  200  1.23194   0.00615969  0.00356318
# gen.6   algos/fuerza_bruta.cpp       200  101.186   0.505929    0.375187
# gen.7   algos/backtracking_fact.cpp  200  0.14222   0.0007111   0.000334865
# gen.7   algos/fuerza_bruta.cpp       200  3.44213   0.0172106   0.0125473
# gen.8   algos/backtracking_fact.cpp  200  4.86259   0.024313    0.00656937
# gen.8   algos/fuerza_bruta.cpp       200  171.01    0.855049    0.177926
# gen.9   algos/backtracking_fact.cpp  200  0.910351  0.00455175  0.00110722
# gen.9   algos/fuerza_bruta.cpp       200  13.0581   0.0652905   0.0105765
# pdf     algos/backtracking_fact.cpp  200  0.311954  0.00155977  0.000847322
# pdf     algos/fuerza_bruta.cpp       200  2.47201   0.01236     0.00945658

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
