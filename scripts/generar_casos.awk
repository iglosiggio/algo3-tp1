#!/usr/bin/awk -f

BEGIN {
	if (seed)
		srand(seed)
	else
		srand()
	if (!n)
		n = int(12 * rand() + 4)
	if (!w)
		w = 240 * rand() + 16
	printf("%d %d\n", n, w)
	for (i = 0; i < n; i++)
		printf("%d %d\n", 64 * rand() + 1, 64 * rand() + 1);
}
