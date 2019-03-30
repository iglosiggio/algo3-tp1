#include <stdint.h>
#include <iostream>
#include <chrono>
#include "algos.h"

using namespace std;

int main(int argc, char** argv) {
	uint32_t n;
	uint32_t w;
	uint32_t *pesos;
	uint32_t *valores;
	uint64_t resultado;

	cin >> n >> w;

	pesos = new uint32_t[n];
        valores = new uint32_t[n];

	for (int i = 0; i < n; i++)
		cin >> pesos[i] >> valores[i];

	auto start = chrono::steady_clock::now();
	resultado = mochila(n, w, pesos, valores);
	auto end = chrono::steady_clock::now();

	double time = chrono::duration<double, milli>(end - start).count();

	cout << algo << ' ' << resultado << ' ' << time << endl;
}
