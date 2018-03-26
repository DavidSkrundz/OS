TOPDIR := ..
include $(TOPDIR)/Makedefs


PDF := OS.pdf
$(PDF): $(shell find . -name "*.tex")


all: $(PDF)
	@

clean:
	@rm -f *.aux *.log *.out *.toc *.pdf
