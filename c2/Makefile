VERILOG := iverilog

VFILES = alu.v  decoder.v  imem.v  omem.v  pc.v  regfile.v  sel2.v  test.v  top.v

.PHONY: all test

all: c2.out

test: c2.out
	vvp $<

c2.out: $(VFILES)
	$(VERILOG) -o $@ $^
