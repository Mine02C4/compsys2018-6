module top(clk, rst);
	input clk, rst;
	wire [15:0] a, b, o, l, aa, iv;
	wire [1:0] aaddr, baddr, oaddr;
	wire [7:0] pa;
	wire [23:0] d;
	wire [7:0] mrd;
	wire [3:0] op;
	regfile regfile(a, b, aaddr, baddr, l, oaddr, rwe, clk, rst);
	sel2 asel2(a, iv, as, aa);
	alu alu(aa, b, op, o, carry, zero, bigger);
	pc pc(pa, l[7:0], pwe, clk, rst);
	imem imem(pa, d) ;
	sel2 msel2(o, {8'h0, mrd}, ms, l);
	omem omem(aa[7:0], mrd, b[7:0], mwe, clk);
	decoder decoder(d, iv, as, ms, mwe, rwe, aaddr, baddr, op, oaddr, pwe, carry, zero, bigger);
endmodule