all: template.pdf template.html

template.pdf: template.qmd
	quarto render template.qmd --to crt-pdf

template.html: template.qmd
	quarto render template.qmd --to crt-html

clean:
	rm -fr template.pdf template.html local.sty template_files template.tex template.fdb_latexmk
