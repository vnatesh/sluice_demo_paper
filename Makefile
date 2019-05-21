REPORT=paper
LATEX=pdflatex
BIBTEX=bibtex --min-crossrefs=1000
REF=paper.bib

TEX=$ $(wildcard *.tex)	$(REF)

PS2PDF=ps2pdf14 -dPDFSETTINGS=/prepress -dEPSCrop
GNUPLOT=gnuplot

SRCS = $(TEX) $(PDF)

$(REPORT).pdf: $(SRCS) $(REF) $(PDF) $(GRAFFLE_PDF) $(GNUPLOT_PDF)
	$(LATEX) $(REPORT)
	$(BIBTEX) $(REPORT)
	perl -p -i -e "s/%\s+//" paper.bbl
	$(LATEX) $(REPORT)
	$(LATEX) $(REPORT)

spell:
	make clean
	for i in *.tex ; do ispell $$i; done

tidy:
	-rm -f *.dvi *.aux *.log *.blg *.bbl

clean:
	-rm -f *~ *.dvi *.aux *.log *.blg *.bbl *.out $(REPORT).pdf

.PHONY: clean tidy ps pdf
