#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>

const char* algo = __FILE__;

using combinacion = std::pair<uint64_t, uint64_t>;
using soluciones = std::vector<combinacion>;

#define BIT(n) (1LL << n)

inline combinacion calcular(uint64_t conjunto, uint32_t* pesos,
                            uint32_t* valores) {
	combinacion resultado;

	for (int i = 0; i < 64; i++)
		if (conjunto & BIT(i)) {
			resultado.first += pesos[i];
			resultado.second += valores[i];
		}

	return resultado;
}


soluciones solucionesSubN(uint32_t* pesos, uint32_t* valores, uint32_t n,
                          uint32_t w) {
	uint64_t conjunto = 0;
	uint64_t mod = BIT(n);
	soluciones resultado;

	while (conjunto < mod) {
		combinacion comb = calcular(conjunto, pesos, valores);
		if (comb.first <= w)
			resultado.push_back(comb);
		conjunto++;
	}

	return resultado; /* Rezamos para que el RVO nos toque */
}

uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* Armo mis 2 subconjuntos */
	soluciones izq = solucionesSubN(pesos, valores, n/2, w);
	soluciones der = solucionesSubN(pesos + n/2, valores + n/2,
	                                    n - n/2, w);
	std::sort(der.begin(), der.end());

	uint64_t mejor_valor = 0;

	for (combinacion& c : der) {
		if (c.second < mejor_valor)
			c.second = mejor_valor;
		else
			mejor_valor = c.second;
	}

	uint64_t resultado = 0;

	for (combinacion c : izq) {
		auto inicio = der.begin();
		auto fin = der.end();
		combinacion deseada = {w - c.first, 0xFFFFFFFFFFFFFFFFLL};
		auto mejor = std::upper_bound(inicio, fin, deseada);

		if (mejor != inicio)
			mejor--;

		uint64_t valor = c.second + mejor->second;

		if (resultado < valor)
			resultado = valor;
	}

	return resultado;
}
