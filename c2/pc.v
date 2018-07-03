module pc(paddr, jaddr, we, clk, rst);
	output [7:0] paddr;
	input [7:0] jaddr;
	input we;
	input clk, rst;
	reg [7:0] paddr;
	always @(posedge clk or posedge rst) begin
		if(rst) paddr <= 0;
		else begin
			if(we) paddr <= jaddr;
			else paddr = paddr + 1;
		end
	end
endmodule

