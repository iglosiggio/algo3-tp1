TMPFILES=*.log *.aux

all: mochila.pdf

%.pdf: %.tex
	pdflatex $(LATEXFLAGS) $<

clean:
	rm -f mochila.pdf $(TMPFILES)
