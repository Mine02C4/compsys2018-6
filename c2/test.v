module test;
	reg clk, rst;
	top top(clk, rst);
	always #5 clk = ~clk;
	initial begin
	$dumpfile("test.vcd");
	$dumpvars(0, top);
	clk = 1;
	rst = 1;
	#20
	rst = 0;
	#200
	$finish;
	end
endmodule
