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
	grep -v Timeout $^ >/dev/null && ../scripts/stats.awk < $^ > $@ \
	|| echo Timeout

exp.a.%.series:
	for stat in exp.a.*.$*.stats; do \
		exp=$${stat%\.$*\.stats}; \
		archivo=../casos/$$exp.in \
		n=$$(head -n1 $$archivo | cut -f1 -d' '); \
		echo $$n $$(cut -f3,4 -d' ' $$stat); \
	done | sort > $@

exp.c.%.series:
	for stat in exp.c.*.$*.stats; do \
		exp=$${stat%\.$*\.stats}; \
		archivo=../casos/$$exp.in; \
		n=$$(head -n1 $$archivo | cut -f1 -d' '); \
		echo $$n $$(cut -f3,4 -d' ' $$stat); \
	done | sort > $@
