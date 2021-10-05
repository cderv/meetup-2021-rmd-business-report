.PHONY: reports-styled reports-default slides deploy clean

all: reports-default reports-styled slides

slides: slides/index.html

slides/index.html: slides/slides.Rmd
		Rscript -e 'xfun::in_dir("slides", rmarkdown::render("$(<F)", output_file = "$(@F)", quiet = TRUE))'

# targets for demo files
DEMORMD = styling-bootstrap.Rmd

reports-styled: slides/styling-bootstrap-styled.html

reports-default: slides/styling-bootstrap-default.html

slides/styling-bootstrap-styled.html: $(DEMORMD)
		Rscript -e 'rmarkdown::render("$<", output_file = "$(@F)", quiet = TRUE)'
		mv $(@F) $@
		cp $< $(@D)

slides/styling-bootstrap-default.html: $(DEMORMD)
		Rscript -e 'rmarkdown::render("$<", output_file = "$(@F)", output_options = list(theme = list(version = 4)), quiet = TRUE)'
		mv $(@F) $@
		cp $< $(@D)

# deployement
## this require the netlify cli to be setup
deploy:
		cd slides && \
		netlify deploy --dir=. --prod || echo '## >> netlify not configured - deployement skipped'
