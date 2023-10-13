uis = a1111 kohya_ss
notebooks = $(addsuffix .ipynb,${uis})

all: ${notebooks}

%.ipynb: %.org
	pandoc -o $@ $<

-include custom.mk
