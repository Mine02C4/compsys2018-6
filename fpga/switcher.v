`timescale 1ns / 1ps

`include "vdefine.h"

module switcher(
    input clk,
    input reset,
    input [1:0] BTN,
    input [`MAX_WIDTH-1:0] max,
    output [`MAX_WIDTH-1:0] number
    );

	wire inc, dec;
	reg [`MAX_WIDTH-1:0] ff = 0;
	reg [19:0] temp_count = 0;
	reg [1:0] out, buff;
	
	assign number = ff;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			temp_count <= 0;
		else
			temp_count <= temp_count + 1;
	end
	
	always @(posedge clk)
		if (temp_count == 0)
			out <= BTN;
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			buff <= 0;
		else
			buff <= out;
	end
	
	assign inc = out[0] & ~buff[0];
	assign dec = out[1] & ~buff[1];
	
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			ff <= 0;
		else if (inc == 1) // increment
		begin
			if (ff == max)
				ff <= 0;
			else
				ff <= ff + 1;
		end
		else if (dec == 1) // decrement
		begin
			if (ff == 0)
				ff <= max;
			else
				ff <= ff - 1;
        end
	end
endmodule
