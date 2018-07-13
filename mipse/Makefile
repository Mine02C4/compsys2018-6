VERILOG := iverilog
VFLAGS := -Wall -Wno-timescale
VTEST := test.v
VHEADERS := def.h
VFILES := mipse.v alu.v rfile.v dmem.v imem.v rand.v
VOUT := mipse.out

ASMDIR := ../compiler
ASM := $(ASMDIR)/compile.py
ASMDEPS = $(ASMDIR)/compsys_compiler.py

.PHONY: all test clean

all: $(VOUT)

$(VOUT): $(VTEST) $(VFILES) $(VHEADERS)
	$(VERILOG) $(VFLAGS) -o $@ $(VTEST) $(VFILES)

test: randsearch.imem.dat $(VOUT) 
	cp $< imem.dat
	vvp $(VOUT)

%.imem.dat: %.asm $(ASM) $(ASMDEPS)
	$(ASM) -o $@ $<

imem.dat: prog.asm $(ASM) $(ASMDEPS)
	$(ASM) -o $@ $<

clean:
	$(RM) $(VOUT)

