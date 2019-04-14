algos=fuerza_bruta mitm backtracking_opt backtracking_fact dinamica
algos_graficos=backtracking_opt.algografico backtracking_fact.algografico \
	dinamica.algografico
exes=$(algos:=.algo)
tmp=*.log *.aux
casos=$(wildcard casos/*.in)
tests=$(casos:.in=.test)

# No tiene sentido borrarlos todo el tiempo
.PRECIOUS: main.o data/%.series

all: $(exes) $(algos_graficos) mochila.pdf

clean:
	rm -f mochila.pdf $(exes) $(tmp)
	$(MAKE) -C data clean

%.algo: algos/%.cpp main.o
	$(CXX) $(CXXFLAGS) $^ -o $@
%.algografico: algos/%.cpp main.o
	$(CXX) $(CXXFLAGS) -DREPORTAR $^ -o $@

# Alias para poder correr `make pdf.test` y cosas así
# La salida tiene la siguiente forma:
# 	<test> <salida esperada> <algo> <salida> <tiempo>
%.test: casos/%.test

casos/%.test: $(exes) casos/%.in casos/%.out
	@for exe in $(exes); do \
		echo $* $$(cat casos/$*.out) $$(./$$exe < casos/$*.in); \
	done;

# Lógica de experimentación
series_a=$(foreach algo, $(algos), exp.a.$(algo).series)
series_b+=exp.b.backtracking_fact.series exp.b.backtracking_opt.series \
	  exp.b.mitm.series exp.b.dinamica.series
series_c=exp.c.dinamica.series

data/%.series:
	$(MAKE) -C data $*.series

# Gráficos que generamos
fotos_a=$(foreach algo, $(algos), fotos/exp.a.$(algo).pdf)
fotos_b=fotos/exp.b.backtracking_fact.pdf fotos/exp.b.backtracking_opt.pdf \
	fotos/exp.b.mitm.pdf
fotos_c=fotos/exp.c.dinamica.pdf
correlacion=fotos/exp.a.correlacion.fuerza_bruta.pdf \
	    fotos/exp.a.correlacion.backtracking_fact.pdf \
	    fotos/exp.a.correlacion.backtracking_opt.pdf \
	    fotos/exp.a.correlacion.mitm.pdf \
	    fotos/exp.b.correlacion.dinamica.pdf # Usamos un dataset más acorde
grafos=fotos/pdf.dinamica.pdf

# Gráficos de cada experimento
fotos/exp.a.%.pdf: data/exp.a.%.series
	scripts/experimento_a.plot $^ $@

fotos/exp.b.%.pdf: data/exp.b.%.series
	scripts/experimento_b.plot $^ $@

fotos/exp.c.dinamica.pdf: data/exp.c.dinamica.series
	scripts/experimento_c.plot

# Gráficos de llamadas recursivas
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

# Gráficos de correlación
fotos/exp.a.correlacion.fuerza_bruta.pdf: data/exp.a.fuerza_bruta.series
	scripts/experimento_a_correlacion.plot $^ $@ '$$1*2**$$1'

fotos/exp.a.correlacion.backtracking%.pdf: data/exp.a.backtracking%.series
	# ¿Esto está bien? ¿Realmente son O(2^n)?
	scripts/experimento_a_correlacion.plot $^ $@ '2**$$1'

fotos/exp.a.correlacion.mitm.pdf: data/exp.a.mitm.series
	scripts/experimento_a_correlacion.plot $^ $@ '$$1*2**($$1 / 2)'

fotos/exp.b.correlacion.dinamica.pdf: data/exp.b.dinamica.series
	scripts/experimento_correlacion_dinamica.plot $^ $@

mochila.pdf: mochila.tex $(fotos_a) $(fotos_b) $(fotos_c) $(correlacion) \
	$(grafos)
	latexmk mochila.tex -pdf
