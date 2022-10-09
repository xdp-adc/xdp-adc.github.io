# Minimal makefile for Sphinx documentation
#

# You can set these variables from the command line, and also
# from the environment for the first two.
SPHINXOPTS    ?=
SPHINXBUILD   ?= sphinx-build
SOURCEDIR     = .
BUILDDIR      = _build

# Put it first so that "make" without argument is like "make help".
help:
	@$(SPHINXBUILD) -M help "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

.PHONY: help Makefile

# Catch-all target: route all unknown targets to Sphinx using the new
# "make mode" option.  $(O) is meant as a shortcut for $(SPHINXOPTS).
%: Makefile
	@$(SPHINXBUILD) -M $@ "$(SOURCEDIR)" "$(BUILDDIR)" $(SPHINXOPTS) $(O)

release:
	# get rid of old cache
	rm -rf docs/*
	printf "docs.xdpadc.com\n" > docs/CNAME

	# generate new site
	make html

	# copy the site over
	mkdir -p docs
	cp -r _build/html/* docs/

	# replace the static folder path
	mv docs/_static docs/static
	mv docs/_sources docs/sources
	find docs -type f -exec sed -i 's/_static/static/g' {} \;
	find docs -type f -exec sed -i 's/_sources/sources/g' {} \;
