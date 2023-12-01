files = Comfyui Automatic1111 SDNext Kohya_ss Reverse-Proxy
notebooks = $(addsuffix .ipynb,${files})

all: ${notebooks}

%.ipynb: %.org
	pandoc -o $@ $<

-include custom.mk
