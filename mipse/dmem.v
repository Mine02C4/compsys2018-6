`include "def.h"
module dmem (
 input clk,
 input [15:0] a,
 output [`DATA_W-1:0] rd,
 input [`DATA_W-1:0] wd,
 input  [`LANE_W-1:0] we);

    reg [`DATA_W-1:0] mem[0:`DEPTH-1];

    assign  rd = mem[a];
    always @(posedge clk)  begin
        if(we[3]) mem[a][31:24] <= wd[31:24];
        if(we[2]) mem[a][23:16] <= wd[23:16];
        if(we[1]) mem[a][15:8] <= wd[15:8];
        if(we[0]) mem[a][7:0] <= wd[7:0];
    end

	initial
      begin
           $readmemh("dmem.dat", mem);
    end


endmodule
