files = starter
notebooks = $(addsuffix .ipynb,${files})

all: ${notebooks}

%.ipynb: %.org
	pandoc -o $@ $<

-include custom.mk
