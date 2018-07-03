module sm(a, b, state, clk, rst);
	input a, b;
	output [1:0] state;
	input clk, rst;
	reg [1:0] state, nstate;
	always @(posedge clk or posedge rst) begin
		if(rst) state <= 0;
		else state <= nstate;
	end
	always @(*) begin
		if(({a,b} == 2'b00) || ({a,b} == 2'b00)) nstate = state;
		else begin
			case (state)
			// synopsys full_case parallel_case
			2'b00: if(a) nstate = 2'b01;
			2'b01: begin
				if(a) nstate = 2'b11;
				if(b) nstate = 2'b00;
			end
			2'b11: if(b) nstate = 2'b01;
			endcase
		end
	end
endmodule
module test;
	reg a, b, clk, rst;
	wire [1:0] state;
	sm sm(a, b, state, clk, rst);
	always #5 clk = ~clk;
initial begin
$dumpfile("sm.vcd");
$dumpvars(0, test);
rst = 1'b1;
clk = 1'b0;
a = 1'b0;
b = 1'b0;
#20
rst = 1'b0;
#20
a = 1'b1;
#10
a = 1'b0;
#10
a = 1'b1;
#20
a = 1'b0;
b = 1'b1;
#30
$finish;
end
endmodule
