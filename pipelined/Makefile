VERILOG := iverilog
VTEST := test.v
VFILES := mipse.v alu.v rfile.v dmem.v imem.v
VOUT := pipelined.out

.PHONY: all test clean

all: $(VOUT)

$(VOUT):	$(TEST) $(VFILES)
	$(VERILOG) -o $@ $^

test: $(VOUT)
	vvp $<

clean:
	$(RM) $(VOUT)

