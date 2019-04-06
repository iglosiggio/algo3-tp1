#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>


const char* algo = __FILE__;

using Matriz = std::vector<std::vector<int32_t> >;

uint64_t dynamic_value_maximizer(uint32_t i, uint32_t w, uint32_t* p, uint32_t* v, std::vector<std::vector<int32_t> > memoria){

	if(memoria[i][w] != -1) 
		return memoria[i][w];

	uint32_t result = 0;

	if( i == 0 || w <= 0){
		return 0;
	}

	if (p[i] > w) {
		result = dynamic_value_maximizer(i-1, w, p, v, memoria);
	} else {
		result = std::max(dynamic_value_maximizer(i-1, w, p, v, memoria), v[i] + dynamic_value_maximizer(i-1, w - p[i], p, v, memoria));
	}

	return result;
}


uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* defino una matriz de memorizacion  */

	Matriz memoria;
	std::vector<int32_t> lista;

	lista.resize(w, -1);
	memoria.resize(n, lista);

	uint64_t result =  dynamic_value_maximizer(n-1,w-1,pesos,valores, memoria);
	

	return result;

}
