`include "def.h"
module imem
(
 input [15:0] a,
 output [`DATA_W-1:0] rd
);
    reg [`DATA_W-1:0] mem[0:`DEPTH-1];

    assign rd = mem[a];

    initial
    begin
mem[0] <= 32'h80020000;
mem[1] <= 32'h80030001;
mem[2] <= 32'h20040003;
mem[3] <= 32'h00400820;
mem[4] <= 32'h00410820;
mem[5] <= 32'h00410820;
mem[6] <= 32'h00410820;
mem[7] <= 32'h2021fffc;
mem[8] <= 32'h04002800;
mem[9] <= 32'h00a42824;
mem[10] <= 32'hac250400;
mem[11] <= 32'h1401fffb;
mem[12] <= 32'h00600820;
mem[13] <= 32'h00610820;
mem[14] <= 32'h2021ffff;
mem[15] <= 32'h80260002;
mem[16] <= 32'h00c63020;
mem[17] <= 32'h00c63020;
mem[18] <= 32'h2021ffff;
mem[19] <= 32'h80270002;
mem[20] <= 32'h00e73820;
mem[21] <= 32'h00e73820;
mem[22] <= 32'h8cc80400;
mem[23] <= 32'h8ce90400;
mem[24] <= 32'h1128ffea;
mem[25] <= 32'h1401fff4;
mem[26] <= 32'hac037fff;
mem[27] <= 32'h1000ffff;

    end
endmodule

