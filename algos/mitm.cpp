#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>

const char* algo = __FILE__;

using combinacion = std::pair<uint64_t, uint64_t>;
using soluciones = std::vector<combinacion>;

#define BIT(n) (1LL << n)

inline combinacion calcular(uint64_t conjunto, uint32_t* pesos, uint32_t* valores) {
	combinacion resultado;

	for (int i = 0; i < 64; i++)
		if (conjunto & BIT(i)) {
			resultado.first += pesos[i];
			resultado.second += valores[i];
		}

	return resultado;
}


soluciones solucionesSubN(uint32_t* pesos, uint32_t* valores, uint32_t n, uint32_t w){
	uint64_t conjunto = 1;
	uint64_t mejor = 0;
	uint64_t mod = BIT(n);
	soluciones resultado;

	resultado.push_back(combinacion(0, 0));

	while (conjunto < mod) {
		combinacion comb = calcular(conjunto, pesos, valores);
		if (comb.second > mejor)
			mejor = comb.second;
		if (comb.first <= w)
			resultado.push_back(comb);
		conjunto++;
	}

	return resultado; /* Rezamos para que el RVO nos toque */
}

uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* Ordenamos en n^2 */
	for (int i = 0; i < n; i++)
		for (int j = i; j < n; j++)
			if(pesos[i] > pesos[j]) {
				std::swap(pesos[i], pesos[j]);
				std::swap(valores[i], valores[j]);
			}

	/* armo mis 2 sub conjuntos */
	soluciones menores = solucionesSubN(pesos, valores, n/2, w);
	soluciones mayores = solucionesSubN(pesos + n/2, valores + n/2, n - n/2, w);
	std::sort(menores.begin(), menores.end());
	std::sort(mayores.begin(), mayores.end());

	uint64_t mejor_valor = 0;

	for (combinacion& c : mayores) {
		if (c.second < mejor_valor)
			c.second = mejor_valor;
		else
			mejor_valor = c.second;
	}

	uint64_t resultado = 0;

	for (combinacion c : menores) {
		uint64_t peso_deseado = w - c.first;
		uint64_t valor_deseado = 0xFFFFFFFFFFFFFFFFLL;
		auto mejor = std::upper_bound(mayores.begin(), mayores.end(), combinacion(peso_deseado, valor_deseado));

		if (mejor != mayores.begin())
			mejor--;

		uint64_t valor = c.second + mejor->second;

		if (resultado < valor)
			resultado = valor;
	}

	return resultado;
}
