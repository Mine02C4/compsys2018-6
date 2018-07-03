module sel2(d0, d1, s, o);
	input [15:0] d0, d1;
	input s;
	output [15:0] o;
	reg [15:0] o;
	always @(*) begin
		if(s) o = d1;
		else o = d0;
	end
endmodule
