`include "def.h"
module rfile
(
    input clk,
    input [`REG_W-1:0] a1, a2, a3,
    output [`DATA_W-1:0] rd1, rd2,
    input [`DATA_W-1:0] wd3,
    input we3, input rst_n
);
    reg [`DATA_W-1:0] rf[0:`REG-1];
    assign rd1 = |a1 == 0 ? 0 : rf[a1];
    assign rd2 = |a2 == 0 ? 0 : rf[a2];
    
    integer i;
    always @(negedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            for (i = 0; i < `REG; i = i + 1)
                rf[i] <= 0;
            begin
            end
            rf[`REG_STACK] <= `DEPTH - 1;
        end
        else if(we3) rf[a3] <= wd3;
    end
endmodule

