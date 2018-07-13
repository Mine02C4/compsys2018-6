test:
	iverilog test_mipse.v inmodule.v disp.v mipse.v alu.v rfile.v dmem.v imem.v intmem.v
intmem.dat:
	./asm.pl testint.asm -o intmem.tmp
	cat zero4 intmem.tmp > intmem.dat
