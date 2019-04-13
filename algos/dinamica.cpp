#include <cstdint>
#include <vector>

#ifdef REPORTAR
#include <iostream>
#endif

const char* algo = __FILE__;

using Fila = std::vector<uint64_t>;
using Matriz = std::vector<Fila>;

#define VACIO UINT64_MAX

uint64_t dinamica(uint32_t i, uint32_t restante, uint32_t* pesos,
                  uint32_t* valores, Matriz& dp) {

	if (i == UINT32_MAX)
		return 0;

	uint64_t& celda = dp[i][restante];

#ifdef REPORTAR
	static std::vector<std::string> padres(i + 1);
	std::string node;
	node += "[i=";
	node += std::to_string(i);
	node += ", r=";
	node += std::to_string(restante);
	node += "]";

	padres[i] = '"' + node + '"';

	if (celda != VACIO)
		std::cout << "edge [style=dashed]" << std::endl;

	if (i + 1 == padres.size())
		std::cout << padres[i] << std::endl;

	if (i + 1 != padres.size())
		std::cout << padres[i + 1] << " -> " << padres[i]
		          << std::endl;

	if (celda != VACIO)
		std::cout << "edge [style=solid]" << std::endl;
#endif

	if (celda != VACIO)
		return celda;

	celda = dinamica(i - 1, restante, pesos, valores, dp);

	if (pesos[i] <= restante)
		celda = std::max(
			celda,
			dinamica(i - 1, restante - pesos[i], pesos, valores, dp)
			+ valores[i]
		);

	return celda;
}


uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	Matriz dp(n, Fila(w + 1, VACIO));

	return dinamica(n - 1, w, pesos, valores, dp);
}
