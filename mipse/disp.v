`include "def.h"
module disp (
input [`DATA_W/4-1:0] data,
input clk, we, rst_n,
output flag );

reg [3:0] delay;
reg [`DATA_W/4-1:0] data_r;
assign flag = (delay == 4'b0000);
always @(posedge clk) begin
	if(~rst_n) delay <= 4'b0000;
	else if(we) begin
	 delay <= 4'b0001;
	 data_r <= data; 
	end
	else if(delay == 4'b0111) begin
		case (data_r)
		 8'h30: $monitor("0");
		 8'h31: $monitor("1");
		 8'h32: $monitor("2");
		 8'h33: $monitor("3");
		 8'h34: $monitor("4");
		 8'h35: $monitor("5");
		 8'h36: $monitor("6");
		 8'h37: $monitor("7");
		 8'h38: $monitor("8");
		 8'h39: $monitor("9");
		 8'h41: $monitor("A");
		 8'h42: $monitor("B");
		 8'h43: $monitor("C");
		 8'h44: $monitor("D");
		 8'h45: $monitor("E");
		 8'h46: $monitor("F");
		 8'h47: $monitor("G");
		 8'h48: $monitor("H");
		 8'h49: $monitor("I");
		 8'h4A: $monitor("J");
		 8'h4B: $monitor("K");
		 8'h4C: $monitor("L");
		 8'h4D: $monitor("M");
		 8'h4E: $monitor("N");
		 8'h4F: $monitor("O");
		 8'h50: $monitor("P");
		 8'h51: $monitor("Q");
		 8'h52: $monitor("R");
		 8'h53: $monitor("S");
		 8'h54: $monitor("T");
		 8'h55: $monitor("U");
		 8'h56: $monitor("V");
		 8'h57: $monitor("W");
		 8'h58: $monitor("X");
		 8'h59: $monitor("Y");
		 8'h5A: $monitor("Z");
		 default: $monitor("Undef ");
		endcase
		delay <= 4'b0000;
  	  end
	else if(delay !=0000)
		delay <= delay + 1;
end
endmodule	
