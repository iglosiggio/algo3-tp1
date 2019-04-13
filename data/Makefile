veces=50
timeout=30

RUN=../scripts/run_test.sh

%.fuerza_bruta.resultados: ../fuerza_bruta.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../fuerza_bruta.algo $(veces) $(timeout) | tee $@

%.backtracking_fact.resultados: ../backtracking_fact.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../backtracking_fact.algo $(veces) $(timeout) | tee $@

%.backtracking_opt.resultados: ../backtracking_opt.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../backtracking_opt.algo $(veces) $(timeout) | tee $@

%.mitm.resultados: ../mitm.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../mitm.algo $(veces) $(timeout) | tee $@

%.dinamica.resultados: ../dinamica.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../dinamica.algo $(veces) $(timeout) | tee $@

%.stats: %.resultados
	../scripts/stats.awk < $^ > $@
