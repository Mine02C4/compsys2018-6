module omem(addr, rd, wd, we, clk);
	input [7:0] raddr;
	output [7:0] rd;
	input [7:0] addr;
	input [7:0] wd;
	input we;
	input clk;
	reg [7:0] mem [255:0];
	always @(posedge clk) begin
		if(we) mem[addr] <= wd;
	end
	assign rd = mem[addr];
endmodule