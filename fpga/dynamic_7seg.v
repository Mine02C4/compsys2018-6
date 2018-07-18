`timescale 1ns / 1ps

`define DYNAMIC_PERIOD_LOG2 16

module dynamic_7seg(
    input clk, reset,
    input [3:0] d0, d1, d2, d3,
    input [3:0] dots,
    output [11:0] seg
    );

	reg [11:0] buff;
	reg [`DYNAMIC_PERIOD_LOG2:0] counter;
	wire [1:0] digit;
	wire [7:0] digit_number;

    assign seg = buff;
    assign digit = counter[`DYNAMIC_PERIOD_LOG2:`DYNAMIC_PERIOD_LOG2-1];
    assign digit_number =
        digit == 0 ? d0 :
        digit == 1 ? d1 :
        digit == 2 ? d2 :
        d3;
    
    function [3:0] anodes;
       input [1:0] digit;
       case (digit)
           2'd0: anodes = 4'b1110;
           2'd1: anodes = 4'b1101;
           2'd2: anodes = 4'b1011;
           2'd3: anodes = 4'b0111;
       endcase
    endfunction

	function [6:0] digicathodes;
	   input [3:0] number;
	   case (number)
           4'b0000: digicathodes = 12'b1000000; //0
           4'b0001: digicathodes = 12'b1111001; //1
           4'b0010: digicathodes = 12'b0100100; //2
           4'b0011: digicathodes = 12'b0110000; //3
           4'b0100: digicathodes = 12'b0011001; //4
           4'b0101: digicathodes = 12'b0010010; //5
           4'b0110: digicathodes = 12'b0000010; //6
           4'b0111: digicathodes = 12'b1011000; //7
           4'b1000: digicathodes = 12'b0000000; //8
           4'b1001: digicathodes = 12'b0010000; //9
           default: digicathodes = 12'b1111111; //è¡ìî
       endcase
	endfunction

	always @(posedge clk or posedge reset)
    begin
        if (reset) counter <= 0;
        else counter <= counter + 1;
        buff <= {anodes(digit), dots[digit], digicathodes(digit_number)};
    end
	
endmodule
