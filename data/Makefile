# Se pueden pasar para configurar
veces   ?= 50
timeout ?= 30
RUN=../scripts/run_test.sh

.PRECIOUS: %.resultados %.series %.stats

casos_a=$(wildcard ../casos/exp.a.*.in)
casos_b=$(wildcard ../casos/exp.b.*.in)
casos_c=$(wildcard ../casos/exp.c.*.in)

nombres_a=$(casos_a:../casos/%.in=%)
nombres_b=$(casos_b:../casos/%.in=%)
nombres_c=$(casos_c:../casos/%.in=%)

# Sólo reconstruímos los tests si TEST=y
ifneq ($(TEST),)
	TEST_FUERZA_BRUTA=y
	TEST_BACKTRACKING_FACT=y
	TEST_BACKTRACKING_OPT=y
	TEST_MITM=y
	TEST_DINAMICA=y
endif

ifneq ($(TEST_FUERZA_BRUTA),)
%.fuerza_bruta.resultados: ../fuerza_bruta.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../fuerza_bruta.algo $(veces) $(timeout) | tee $@
endif

ifneq ($(TEST_BACKTRACKING_FACT),)
%.backtracking_fact.resultados: ../backtracking_fact.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../backtracking_fact.algo $(veces) $(timeout) \
		| tee $@
endif

ifneq ($(TEST_BACKTRACKING_OPT),)
%.backtracking_opt.resultados: ../backtracking_opt.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../backtracking_opt.algo $(veces) $(timeout) \
		| tee $@
endif

ifneq ($(TEST_MITM),)
%.mitm.resultados: ../mitm.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../mitm.algo $(veces) $(timeout) | tee $@

endif

ifneq ($(TEST_DINAMICA),)
%.dinamica.resultados: ../dinamica.algo ../casos/%.in
	$(RUN) ../casos/$*.in ../dinamica.algo $(veces) $(timeout) | tee $@
endif

%.stats: %.resultados
	grep -v Timeout $^ >/dev/null && ../scripts/stats.awk < $^ > $@ \
	|| echo 0 99999 99999 99999 > $@

exp.a.%.series: $(nombres_a:=.%.stats)
	for stat in exp.a.*.$*.stats; do \
		exp=$${stat%\.$*\.stats}; \
		archivo=../casos/$$exp.in; \
		echo $$(head -n1 $$archivo) $$(cut -f3,4 -d' ' $$stat); \
	done | sort > $@

exp.b.%.series: $(nombres_b:=.%.stats)
	for stat in exp.b.*.$*.stats; do \
		exp=$${stat%\.$*\.stats}; \
		archivo=../casos/$$exp.in; \
		echo $$(head -n1 $$archivo) $$(cut -f3,4 -d' ' $$stat); \
	done | sort > $@

exp.c.%.series: $(nombres_c:=.%.stats)
	for stat in exp.c.*.$*.stats; do \
		exp=$${stat%\.$*\.stats}; \
		archivo=../casos/$$exp.in; \
		n=$$(head -n1 $$archivo | cut -f1 -d' '); \
		echo $$n $$(cut -f3,4 -d' ' $$stat); \
	done | sort > $@

clean:
	rm -f *.stats *.series
