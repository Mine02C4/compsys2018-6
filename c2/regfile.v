module regfile(aout, bout, aaddr, baddr, oin, oaddr, we, clk, rst);
	output [15:0] aout, bout;
	input [15:0] oin;
	input [1:0] aaddr, baddr, oaddr;
	input clk, rst;
	reg [15:0] ra[3:0];
	always @(posedge clk or posedge rst) begin
		if(rst) begin
			ra[0] <= 0; 
			ra[1] <= 0;
			ra[2] <= 0;
			ra[3] <= 0;
		end else begin
			if (we) ra[oaddr] <= oin;
		end
	end
	assign aout = ra[aaddr];
	assign bout = ra[baddr];
endmodule
