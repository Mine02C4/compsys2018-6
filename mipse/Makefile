VERILOG := iverilog
VFLAGS := -Wall -Wno-timescale
VTEST := test.v
VHEADERS := def.h
VFILES := mipse.v alu.v rfile.v dmem.v imem.v rand.v
VOUT := mipse.out

PROGRAM := randsearch2.asm

ASMDIR := ../compiler
ASM := $(ASMDIR)/compile.py
ASMDEPS = $(ASMDIR)/compsys_compiler.py

INPUTDIR := ../input
DMEMINPUTS := $(wildcard $(INPUTDIR)/dmem*.dat)
ANSWERS := $(patsubst $(INPUTDIR)/dmem%.dat, answer%.txt, $(DMEMINPUTS))
FPGA_DMEMS := $(patsubst $(INPUTDIR)/dmem%.dat, fpga_dmem%.v, $(DMEMINPUTS))

.PHONY: all answers test clean

all: $(VOUT)

answers: $(ANSWERS)

fpga: $(FPGA_DMEMS)

fpga_dmem%.v: $(INPUTDIR)/dmem%.dat mem_converter.py
	./mem_converter.py $< -t dmem.template.v -o $@

answer%.txt: $(INPUTDIR)/dmem%.dat $(VOUT)
	cp $< dmem.dat
	vvp -N $(VOUT) +NODEBUG
	mv answer.txt $@

imem.v: randsearch2.imem.dat mem_converter.py
	./mem_converter.py $< -t imem.template.v -o $@

$(VOUT): $(VTEST) $(VFILES) $(VHEADERS)
	$(VERILOG) $(VFLAGS) -o $@ $(VTEST) $(VFILES)

test: randsearch2.imem.dat $(VOUT)
	cp $< imem.dat
	vvp -N $(VOUT) +NODEBUG

%.imem.dat: %.asm $(ASM) $(ASMDEPS)
	$(ASM) -o $@ $<

clean:
	$(RM) $(VOUT) imem.v dmem.v

