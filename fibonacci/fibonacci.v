module tc(clk, rst);
input clk, rst;
	wire [1:0] ara, bra, wa;
	wire [15:0] a, b, l;
	wire [4:0] pca;
	wire dis;
	wire op;
	regfile regfile(ara, a, bra, b, wa, we, l, clk, rst);
	alu alu(a, b, l, op);
	pc pc(dis, pca, clk, rst);
	im im(pca, dis, ara, bra, we, wa, op);
endmodule

module regfile(ara, aout, bra, bout, wa, we, in, clk, rst);
	input [1:0] ara, bra, wa;
	input [15:0] in;
	output [15:0] aout, bout;
	input we, clk, rst;
	reg [15:0] rf[3:0];
	always @(posedge clk or posedge rst) begin
		if(rst) rf[3] <= 1;
		else if(we) rf[wa] <= in;
	end
	assign aout = rf[ara];
	assign bout = rf[bra];
endmodule

module alu(ain, bin, out, op);
	input [15:0] ain, bin;
	output [15:0] out;
	input op;
	reg [15:0] out;
	always @(*) begin
		case(op)
		1'b0: out = ain + bin;
		1'b1: out = ain;
		endcase
	end
endmodule

module pc(dis, pca, clk, rst);
	input dis;
	output [4:0] pca;
	input clk, rst;
	reg [4:0] pca;
	always @(posedge clk or posedge rst) begin
		if(rst) pca <= 0;
		else if(dis == 0) pca = pca + 1;
	end
endmodule

module im(pca, dis, ara, bra, we, wa, op);
	input [4:0] pca;
	output dis;
	output [1:0] ara, bra, wa;
	output we;
	output op;
	reg [8:0] m;
	assign {dis, ara, bra, op, we, wa} = m;
	always @(*) begin
	case(pca)
5'h00: m = 9'b0_11_00_1_1_00;
5'h01: m = 9'b0_11_00_1_1_01;

5'h02: m = 9'b0_00_01_0_1_10;
5'h03: m = 9'b0_01_00_1_1_00;
5'h04: m = 9'b0_10_00_1_1_01;

5'h05: m = 9'b0_00_01_0_1_10;
5'h06: m = 9'b0_01_00_1_1_00;
5'h07: m = 9'b0_10_00_1_1_01;

5'h08: m = 9'b0_00_01_0_1_10;
5'h09: m = 9'b0_01_00_1_1_00;
5'h0a: m = 9'b0_10_00_1_1_01;

5'h0b: m = 9'b0_00_01_0_1_10;
5'h0c: m = 9'b0_01_00_1_1_00;
5'h0d: m = 9'b0_10_00_1_1_01;

5'h0e: m = 9'b0_00_01_0_1_10;
5'h0f: m = 9'b0_01_00_1_1_00;
5'h10: m = 9'b0_10_00_1_1_01;

5'h11: m = 9'b0_00_01_0_1_10;
5'h12: m = 9'b0_01_00_1_1_00;
5'h13: m = 9'b0_10_00_1_1_01;

5'h14: m = 9'b0_00_01_0_1_10;
5'h15: m = 9'b0_01_00_1_1_00;
5'h16: m = 9'b0_10_00_1_1_01;

5'h17: m = 9'b0_00_01_0_1_10;
5'h18: m = 9'b0_01_00_1_1_00;
5'h19: m = 9'b0_10_00_1_1_01;
	endcase
	end
endmodule

module tctest;
reg clk, rst;
tc tc(clk, rst);
always #5 clk = ~clk;
initial begin
$dumpfile("tc.vcd");
$dumpvars(0, tctest);
clk = 0;
rst = 1;
#20
rst = 0;
#400
$finish;
end
endmodule
