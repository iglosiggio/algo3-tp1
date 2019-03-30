algos=fuerza_bruta mitm backtracking_opt backtracking_fact dinamica
exes=$(algos:=.algo)
tmp=*.log *.aux

all: mochila.pdf $(exes) main.o

%.pdf: %.tex
	pdflatex $(LATEXFLAGS) $<

%.algo: algos/%.cpp main.o
	$(CXX) $^ -o $@

clean:
	rm -f mochila.pdf $(exes) $(tmp)

%.test: $(exes) casos/%.in casos/%.out
	@cat casos/$*.out
	@for exe in $(exes); do ./$$exe < casos/$*.in; done
