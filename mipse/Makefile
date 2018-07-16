VERILOG := iverilog
VFLAGS := -Wall -Wno-timescale
VTEST := test.v
VHEADERS := def.h
VFILES := mipse.v alu.v rfile.v dmem.v imem.v rand.v
VOUT := mipse.out

ASMDIR := ../compiler
ASM := $(ASMDIR)/compile.py
ASMDEPS = $(ASMDIR)/compsys_compiler.py

INPUTDIR := ../input
DMEMINPUTS := $(wildcard $(INPUTDIR)/dmem*.dat)

.PHONY: all answers test clean

all: $(VOUT)

answers: $(patsubst $(INPUTDIR)/dmem%.dat, answer%.txt, $(DMEMINPUTS))

answer%.txt: $(INPUTDIR)/dmem%.dat $(VOUT)
	cp $< dmem.dat
	vvp -N $(VOUT) +NODEBUG
	mv answer.txt $@

imem.v: randsearch.imem.dat
	./imem_converter.py $< -t imem.template.v -o $@

$(VOUT): $(VTEST) $(VFILES) $(VHEADERS)
	$(VERILOG) $(VFLAGS) -o $@ $(VTEST) $(VFILES)

test: randsearch.imem.dat $(VOUT)
	cp $< imem.dat
	vvp -N $(VOUT) +NODEBUG

%.imem.dat: %.asm $(ASM) $(ASMDEPS)
	$(ASM) -o $@ $<

clean:
	$(RM) $(VOUT)

