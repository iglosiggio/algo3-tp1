algos=fuerza_bruta mitm backtracking_opt backtracking_fact dinamica
algos_graficos=backtracking_opt.algografico backtracking_fact.algografico dinamica.algografico
exes=$(algos:=.algo)
tmp=*.log *.aux
casos=$(wildcard casos/*.in)
tests=$(casos:.in=.test)

all: mochila.pdf $(exes) $(algos_graficos) main.o

%.algo: algos/%.cpp main.o
	$(CXX) $(CXXFLAGS) $^ -o $@
%.algografico: algos/%.cpp main.o
	$(CXX) $(CXXFLAGS) -DREPORTAR $^ -o $@

clean:
	rm -f mochila.pdf $(exes) $(tmp)

%.test: casos/%.test
	@

test: $(tests)

casos/%.test: $(exes) casos/%.in casos/%.out
	@for exe in $(exes); do \
		echo $* $$(cat casos/$*.out) $$(./$$exe < casos/$*.in); \
	done;

fotos/%.opt.pdf: casos/%.in backtracking_opt.algografico
	./backtracking_opt.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpdf > $@

fotos/%.fact.pdf: casos/%.in backtracking_fact.algografico
	./backtracking_fact.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpdf > $@

fotos/%.dinamica.pdf: casos/%.in dinamica.algografico
	./dinamica.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpdf > $@

casos_a=$(wildcard casos/exp.a.*.in)
runs_a=$(casos_a:casos/%.in=%)
targets_a=$(foreach algo, $(algos), \
		$(foreach run, $(runs_a), $(run).$(algo).stats))
targets_a+=$(foreach algo, $(algos), exp.a.$(algo).series)
fotos_a=$(foreach algo, $(algos), fotos/exp.a.$(algo).pdf)

fotos/exp.a.%.pdf: data/exp.a.%.series
	scripts/experimento_a.plot $^ $@

exp_a:
	(cd data; $(MAKE) $(targets_a))

casos_b=$(wildcard casos/exp.b.*.in)
runs_b=$(casos_b:casos/%.in=%)
targets_b=$(foreach algo, backtracking_fact backtracking_opt mitm, \
		$(foreach run, $(runs_b), $(run).$(algo).stats))
targets_b+=$(foreach algo, backtracking_fact backtracking_opt mitm, \
		exp.b.$(algo).series)
fotos_b=fotos/exp.b.backtracking_fact.pdf fotos/exp.b.backtracking_opt.pdf fotos/exp.b.mitm.pdf

fotos/exp.b.%.pdf: data/exp.b.%.series
	scripts/experimento_b.plot $^ $@

exp_b:
	(cd data; $(MAKE) $(targets_b))

casos_c=$(wildcard casos/exp.c.*.in)
targets_c=$(casos_c:casos/%.in=%.dinamica.resultados)
targets_c+=$(casos_c:casos/%.in=%.dinamica.stats)
targets_c+=exp.c.dinamica.series
fotos_c=fotos/exp.c.dinamica.pdf

fotos/exp.c.dinamica.pdf: data/exp.c.dinamica.series
	scripts/experimento_c.plot

exp_c:
	(cd data; $(MAKE) $(targets_c))

experimentos: exp_a exp_b exp_c
	@

ilustraciones=fotos/pdf.dinamica.pdf

mochila.pdf: mochila.tex $(fotos_a) $(fotos_b) $(fotos_c) $(ilustraciones)
	latexmk mochila.tex -pdf
