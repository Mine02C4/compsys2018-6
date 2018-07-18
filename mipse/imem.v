`include "def.h"
module imem
(
 input [15:0] a,
 output [`DATA_W-1:0] rd
);
    reg [`DATA_W-1:0] mem[0:`IMEM_DEPTH-1];

    assign rd = mem[a];

    initial
    begin
mem[0] <= 32'h20010000;
mem[1] <= 32'h80020000;
mem[2] <= 32'h80030001;
mem[3] <= 32'h200c000a;
mem[4] <= 32'h20210001;
mem[5] <= 32'h2009ffff;
mem[6] <= 32'h21290001;
mem[7] <= 32'h10490026;
mem[8] <= 32'h200a0000;
mem[9] <= 32'h04002000;
mem[10] <= 32'h30840003;
mem[11] <= 32'h01296820;
mem[12] <= 32'h01ad6820;
mem[13] <= 32'hada40400;
mem[14] <= 32'h200b0001;
mem[15] <= 32'h2008ffff;
mem[16] <= 32'h21080001;
mem[17] <= 32'h10680014;
mem[18] <= 32'h01086820;
mem[19] <= 32'h81a60002;
mem[20] <= 32'h81a70003;
mem[21] <= 32'h00c92022;
mem[22] <= 32'h00e92822;
mem[23] <= 32'h00852024;
mem[24] <= 32'h1404fff7;
mem[25] <= 32'h0126202a;
mem[26] <= 32'h0127282a;
mem[27] <= 32'h00852025;
mem[28] <= 32'h1404fff3;
mem[29] <= 32'h00c66820;
mem[30] <= 32'h01ad6820;
mem[31] <= 32'h8da40400;
mem[32] <= 32'h00e76820;
mem[33] <= 32'h01ad6820;
mem[34] <= 32'h8da50400;
mem[35] <= 32'h00852022;
mem[36] <= 32'h1404ffeb;
mem[37] <= 32'h200b0000;
mem[38] <= 32'h214a0001;
mem[39] <= 32'h018a2022;
mem[40] <= 32'h0004202a;
mem[41] <= 32'h008b2027;
mem[42] <= 32'h30840001;
mem[43] <= 32'h1404ffd8;
mem[44] <= 32'h100bffdc;
mem[45] <= 32'h1000ffd8;
mem[46] <= 32'hac027fff;
mem[47] <= 32'h1000ffff;

    end
endmodule

