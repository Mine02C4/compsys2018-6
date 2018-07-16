QFILES := $(wildcard Q*.txt)
DMEMFILES := $(patsubst Q%.txt, dmem%.dat, $(QFILES))
CONVERTER := dmem_converter.py

.PHONY: all

all: $(DMEMFILES)

dmem%.dat: $(CONVERTER) Q%.txt
	./$^ -o $@

