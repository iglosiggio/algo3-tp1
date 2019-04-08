#include <cstdint>
#include <algorithm>

#ifdef REPORTAR
#include <iostream>
#include <vector>
#endif

const char* algo = __FILE__;

struct problema {
	uint32_t n;
	uint32_t w;
	uint32_t* pesos;
	uint32_t* valores;
};

struct solucion {
	uint32_t i;
	uint64_t peso_actual;
	uint64_t peso_restante;
	uint64_t valor_actual;
};

uint64_t backtracking(struct problema p, struct solucion s) {
#ifdef REPORTAR
	static std::vector<std::string> padres(p.n);
	std::string node;
	node += std::to_string(s.i);
	node += "\\npa=";
	node += std::to_string(s.peso_actual);
	node += "\\npr=";
	node += std::to_string(s.peso_restante);
	node += "\\nva=";
	node += std::to_string(s.valor_actual);

	if (s.i < p.n)
		padres[s.i] = '"' + node + '"';

	if (s.i == 0)
		std::cout << padres[s.i] << std::endl;

	if (s.i != 0)
		std::cout << padres[s.i - 1] << " -> " << padres[s.i]
		          << std::endl;
#endif
	/* Si llegué al final entonces retorno */
	if (s.i == p.n)
		return s.valor_actual;

	uint64_t nuevo_peso = s.peso_actual + p.pesos[s.i];
	uint64_t nuevo_valor = s.valor_actual + p.valores[s.i];

	/* Si entra todo llenamos la mochila */
	if (s.peso_actual + s.peso_restante <= p.w) {
		for(int i = s.i; i < p.n; i++)
			s.valor_actual += p.valores[i];
		return s.valor_actual;
	}

	/* Podemos cortar porque ordenamos según los pesos */
	if (nuevo_peso > p.w)
		return s.valor_actual;

	/* Considero el caso de agregar o no el iésimo elemento */
	struct solucion con_i = {
		s.i + 1,
		nuevo_peso,
		s.peso_restante - p.pesos[s.i],
		nuevo_valor
	};

	struct solucion sin_i = {
		s.i + 1,
		s.peso_actual,
		s.peso_restante - p.pesos[s.i],
		s.valor_actual
	};

	return std::max(backtracking(p, con_i), backtracking(p, sin_i));
}

uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* Ordenamos en n^2 */
	for (int i = 0; i < n; i++)
		for (int j = i; j < n; j++)
			if(pesos[i] > pesos[j]) {
				std::swap(pesos[i], pesos[j]);
				std::swap(valores[i], valores[j]);
			}

	/* Calculamos la suma */
	uint64_t suma = 0;
	for (int i = 0; i < n; i++)
		suma += pesos[i];
	

	return backtracking({n, w, pesos, valores}, {0, 0, suma, 0});
}
