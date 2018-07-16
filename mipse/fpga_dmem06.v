`include "def.h"
module dmem (
    input clk,
    input [15:0] a,
    output [`DATA_W-1:0] rd,
    input [`DATA_W-1:0] wd,
    input  we);

    reg [`DATA_W-1:0] mem[0:`DEPTH-1];

    assign rd = mem[a];

    always @(posedge clk)  begin
        if(we) mem[a] <= wd;
    end
    initial
    begin
mem[0] <= 32'h06090001;
mem[1] <= 32'h00020003;
mem[2] <= 32'h01020203;
mem[3] <= 32'h02040205;
mem[4] <= 32'h03040405;

    end
endmodule

