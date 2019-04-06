#include <cstdint>
#include <vector>
#include <utility>
#include <algorithm>
#include <iostream>


const char* algo = __FILE__;

using Matriz = std::vector<std::vector<uint32_t> >;

uint64_t dynamic_value_maximizer(uint32_t n, uint32_t w, uint32_t* p, uint32_t* v, std::vector<std::vector<uint32_t> > memoria){

	if(memoria[n][w] != -1) 
		return memoria[n][w];

	uint32_t result = 0;
	if(w < 0 ){
		return 0;
	}

	if( n == 0 || w == 0){
		memoria[n][w] = 0;
		return 0;
	}

	if (p[n] > w) {
		result = dynamic_value_maximizer(n-1, w, p, v, memoria);
	} else {
		result = std::max(dynamic_value_maximizer(n-1, w, p, v, memoria), dynamic_value_maximizer(n-1, w - p[n], p, v, memoria));
	}

	memoria[n][w] = result;
	return result;
}


uint64_t mochila(uint32_t n, uint32_t w, uint32_t* pesos, uint32_t* valores) {
	/* defino una matriz de memorizacion  */

	Matriz memoria;
	std::vector<uint32_t> lista;

	lista.resize(w, -1);
	memoria.resize(n, lista);

	uint64_t result =  dynamic_value_maximizer(n,w,pesos,valores, memoria);
	

	return result;

}
