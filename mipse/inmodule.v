`include "def.h"
module inmodule (
input [`DATA_W/4-1:0] idata,
output reg [`DATA_W/4-1:0] odata,
input clk, we, re, rst_n,
output reg flag );

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) odata <= 0;
	else if(we) odata <= idata;
end

always @(posedge clk) begin
	if(~rst_n) flag <= `DISABLE;
	else if(we) flag <= `ENABLE;
        else if(re) flag <= `DISABLE;
end
endmodule	
