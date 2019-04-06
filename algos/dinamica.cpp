#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>


const char* algo = __FILE__;

using Matriz = std::vector<std::vector<int32_t> >;

Matriz memoria;
std::vector<int32_t> lista;

uint32_t dynamic_value_maximizer(uint32_t i, uint32_t peso_restante, uint32_t* p, uint32_t* v, std::vector<std::vector<int32_t> > memoria){

	if( i == 0 || peso_restante <= 0){
		return 0;
	}

	if(memoria[i-1][peso_restante] != -1) {
		std::cout << memoria[i-1][peso_restante] << std::endl;
		return memoria[i-1][peso_restante];
	}

	uint32_t result = 0;


	if (p[i-1] > peso_restante) {
		result = dynamic_value_maximizer(i-1, peso_restante, p, v, memoria);
	} else {
		result = std::max(dynamic_value_maximizer(i-1, peso_restante, p, v, memoria), 
					v[i-1] + dynamic_value_maximizer(i-1, peso_restante - p[i-1], p, v, memoria));
	}
	memoria[i-1][peso_restante] = result;

	return result;
}


uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* defino una matriz de memorizacion  */

	lista.resize(w, -1);
	memoria.resize(n, lista);

	uint32_t result =  dynamic_value_maximizer(n,w-1,pesos,valores, memoria);

	return result;

}
