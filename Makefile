.PHONY: reports-styled reports-default report-docx slides deploy clean

all: reports-default reports-styled reports-docx slides

slides: slides/index.html

slides/index.html: slides/slides.Rmd
		Rscript -e 'xfun::in_dir("slides", rmarkdown::render("$(<F)", output_file = "$(@F)", quiet = TRUE))'

# targets for demo files
DEMORMD = styling-bootstrap.Rmd

reports-styled: slides/styling-bootstrap-styled.html

reports-default: slides/styling-bootstrap-default.html

reports-docx: slides/pinguins-report.docx

slides/styling-bootstrap-styled.html: $(DEMORMD)
		Rscript -e 'rmarkdown::render("$<", output_file = "$(@F)", quiet = TRUE)'
		mv $(@F) $@
		cp $< $(@D)

slides/styling-bootstrap-default.html: $(DEMORMD)
		Rscript -e 'rmarkdown::render("$<", output_file = "$(@F)", rmarkdown::html_document(theme = list(version = 4)), quiet = TRUE)'
		mv $(@F) $@
		cp $< $(@D)

DEMODOCX = pinguins-report.Rmd

slides/pinguins-report.docx: pinguins-report.Rmd template.docx
		Rscript -e 'rmarkdown::render("$<", output_file = "$(@F)", quiet = TRUE)'
		mv $(@F) $@
		cp -t $(@D) $^

# deployement
## this require the netlify cli to be setup
deploy:
		cd slides && \
		netlify deploy --dir=. --prod || echo '## >> netlify not configured - deployement skipped'

clean:
		rm slides/styling-bootstrap-styled.html
		rm slides/styling-bootstrap-default.html
		rm slides/pinguins-report.docx
		rm slides/template.docx
		rm slides/pinguins-report.Rmd
		rm slides/styling-bootstrap.Rmd
