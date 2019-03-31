#include <cstdint>

const char* algo = __FILE__;

#define BIT(n) (1LL << n)

inline uint64_t suma(uint64_t conjunto, uint32_t* valores) {
	uint64_t resultado = 0;

	for (int i = 0; i < 64; i++)
		if (conjunto & BIT(i))
			resultado += valores[i];

	return resultado;
}

inline bool no_se_pasa(uint64_t conjunto, uint32_t limite, uint32_t* pesos) {
	uint64_t peso = 0;

	for (int i = 0; i < 64 && peso <= limite; i++)
		if (conjunto & BIT(i))
			peso += pesos[i];

	return peso <= limite;
}

uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	uint64_t mejor = 0;
	uint64_t conjunto = 1;
	uint64_t mod = BIT(n);

	while (conjunto < mod) {
		if (no_se_pasa(conjunto, w, pesos)) {
			uint64_t valor = suma(conjunto, valores);
			if (valor > mejor)
				mejor = valor;
		}
		conjunto++;
	}

	return mejor;
}
