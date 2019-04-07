#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>

const char* algo = __FILE__;

using Fila = std::vector<uint64_t>;
using Matriz = std::vector<Fila>;

#define VACIO UINT64_MAX

uint64_t dinamica(uint32_t i, uint32_t restante, uint32_t* pesos,
                  uint32_t* valores, Matriz& dp) {

	if (i == UINT32_MAX)
		return 0;

	uint64_t& celda = dp[i][restante];

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
	Matriz dp(n, Fila(w, VACIO));

	return dinamica(n - 1, w - 1, pesos, valores, dp);
}
