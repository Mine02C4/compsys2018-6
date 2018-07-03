module fifo(in, we, full, out, re, empty, clk, rst);
	input [7:0] in;
	input we;
	output full;
	output [7:0] out;
	input re;
	output empty;
	input clk, rst;

	reg [7:0] mem[15:0]; 
	reg [3:0] head, tail;
	reg empty, full;
	always @(posedge clk) begin
		if(rst) begin
			head <= 0;
			tail <= 0;
		end else begin
			if(we) head <= head + 1;
			if(re) tail <= tail + 1;
		end
	end
	always @(posedge clk) begin
		if(we) mem[head] <= in;
	end
	assign out = mem[tail];
	always @(*) begin
		if(head == tail) empty = 1'b1;
		else empty = 1'b0;
		if(tail == head+1) full = 1'b1;
		else full = 1'b0;
	end
endmodule

module test;
reg [7:0] in;
reg we;
wire full;
wire [7:0] out;
reg re;
wire empty;
reg clk, rst;

fifo fifo(in, we, full, out, re, empty, clk, rst);
always #5 clk = ~clk;
initial begin
$dumpfile("fifo.vcd");
$dumpvars(0, test);
clk = 0;
rst = 1;
in = 0;
we = 0;
re = 0;
#20
rst = 0;
in = 1;
#10
we = 1;
#10
in = 2;
#10
in = 3;
#10
in = 4;
we = 0;
#10
re = 1;
#60
$finish;
end
endmodule
