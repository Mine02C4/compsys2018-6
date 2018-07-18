`include "def.h"
module dmem (
    input clk,
    input [15:0] a,
    output [`DATA_W-1:0] rd,
    input [`DATA_W-1:0] wd,
    input  we);

    reg [`DATA_W-1:0] mem[0:`DMEM_DEPTH-1];

    assign rd = mem[a];

    always @(posedge clk)  begin
        if(we) mem[a] <= wd;
    end
    initial
    begin
mem[0] <= 32'h080e0001;
mem[1] <= 32'h00020004;
mem[2] <= 32'h00050102;
mem[3] <= 32'h01060203;
mem[4] <= 32'h02040304;
mem[5] <= 32'h04050406;
mem[6] <= 32'h04070507;
mem[7] <= 32'h06070000;

    end
endmodule

