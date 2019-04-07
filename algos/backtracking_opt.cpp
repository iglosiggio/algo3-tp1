#include <cstdint>
#include <algorithm>

const char* algo = __FILE__;

struct problema {
	uint32_t n;
	uint32_t w;
	uint32_t* pesos;
	uint32_t* valores;
};

struct solucion {
	uint32_t i;
	uint64_t valor_actual;
	uint64_t valor_restante;
	uint64_t mejor_valor;
	uint64_t peso_actual;
};

uint64_t backtracking(struct problema p, struct solucion s) {
	/* Si llegué al final entonces retorno */
	if (s.i == UINT32_MAX)
		return s.mejor_valor;

	uint64_t nuevo_peso = s.peso_actual + p.pesos[s.i];
	uint64_t nuevo_valor = s.valor_actual + p.valores[s.i];

	/* Si no podemos ganarle al mejor nos rendimos */
	if (s.valor_actual + s.valor_restante <= s.mejor_valor)
		return s.mejor_valor;

	/* Considero el caso de agregar o no el iésimo elemento */
	struct solucion con_i = {
		s.i - 1,
		nuevo_valor,
		s.valor_restante - p.valores[s.i],
		std::max(nuevo_valor, s.mejor_valor),
		nuevo_peso
	};

	struct solucion sin_i = {
		s.i - 1,
		s.valor_actual,
		s.valor_restante - p.valores[s.i],
		s.mejor_valor,
		s.peso_actual
	};

	if (nuevo_peso <= p.w)
		sin_i.mejor_valor = std::max(s.mejor_valor,
		                             backtracking(p, con_i));

	return std::max(sin_i.mejor_valor, backtracking(p, sin_i));
}

uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* Ordenamos en n^2 */
	for (int i = 0; i < n; i++)
		for (int j = i; j < n; j++)
			if(valores[i] > valores[j]) {
				std::swap(pesos[i], pesos[j]);
				std::swap(valores[i], valores[j]);
			}

	/* Calculamos la suma */
	uint64_t suma = 0;
	for (int i = 0; i < n; i++)
		suma += valores[i];

	return backtracking({n, w, pesos, valores}, {n - 1, 0, suma, 0, 0});
}
