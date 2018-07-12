VERILOG := iverilog
VTEST := test.v
VHEADERS := def.h
VFILES := mipse.v alu.v rfile.v dmem.v imem.v
VOUT := pipelined.out

.PHONY: all test clean

all: $(VOUT)

$(VOUT): $(VTEST) $(VFILES) $(VHEADERS)
	$(VERILOG) -o $@ $(VTEST) $(VFILES)

test: $(VOUT)
	vvp $<

clean:
	$(RM) $(VOUT)

