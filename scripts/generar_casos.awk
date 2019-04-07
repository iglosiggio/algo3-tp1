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
	if (!s_piso)
		s_piso = 1
	if (!s_techo)
		s_techo = 64
	if (!v_piso)
		v_piso = 1
	if (!v_techo)
		v_techo = 64

	print int(n), int(w)

	for (i = 0; i < n; i++)
		print(int(s_techo * rand() + s_piso),
		      int(v_techo * rand() + v_piso))
}
