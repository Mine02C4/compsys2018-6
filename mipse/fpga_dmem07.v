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
mem[0] <= 32'h070c0001;
mem[1] <= 32'h00020003;
mem[2] <= 32'h01020105;
mem[3] <= 32'h02030204;
mem[4] <= 32'h02050206;
mem[5] <= 32'h03040406;
mem[6] <= 32'h05060000;

    end
endmodule

