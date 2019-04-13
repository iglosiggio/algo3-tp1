algos=fuerza_bruta mitm backtracking_opt backtracking_fact dinamica
algos_graficos=backtracking_opt.algografico backtracking_fact.algografico dinamica.algografico
exes=$(algos:=.algo)
tmp=*.log *.aux
casos=$(wildcard casos/*.in)
tests=$(casos:.in=.test)

all: mochila.pdf $(exes) $(algos_graficos) main.o

mochila.pdf: mochila.tex
	latexmk mochila.tex -pdf

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

fotos/%.opt.png: casos/%.in backtracking_opt.algografico
	./backtracking_opt.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpng > $@

fotos/%.fact.png: casos/%.in backtracking_fact.algografico
	./backtracking_fact.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpng > $@

fotos/%.dinamica.png: casos/%.in dinamica.algografico
	./dinamica.algografico < casos/$*.in \
	| head -n -1 \
	| awk 'BEGIN { print "digraph {" } { print $0 } END { print "}" }' \
	| dot -Tpng > $@

experimentos: exp_a
	@

casos_a=$(wildcard casos/exp.a.*.in)
runs_a=$(casos_a:casos/%.in=%)
targets_a=$(foreach algo, $(algos), \
		$(foreach run, $(runs_a), $(run).$(algo).resultados))

exp_a:
	(cd data; $(MAKE) $(targets_a)); \
