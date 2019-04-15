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
	if (!p_piso)
		p_piso = 1
	if (!p_techo)
		p_techo = 64
	if (!v_piso)
		v_piso = 1
	if (!v_techo)
		v_techo = 64

	print int(n), int(w)

	for (i = 0; i < n; i++)
		print(int((p_techo - p_piso) * rand() + p_piso),
		      int((v_techo - v_piso) * rand() + v_piso))
}
