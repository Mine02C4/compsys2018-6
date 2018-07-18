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
mem[0] <= 32'h214a0015;
mem[1] <= 32'h0013000a;
mem[2] <= 32'h01050118;
mem[3] <= 32'h011b020a;
mem[4] <= 32'h0211021f;
mem[5] <= 32'h03040312;
mem[6] <= 32'h0320030c;
mem[7] <= 32'h04070414;
mem[8] <= 32'h0418041b;
mem[9] <= 32'h04120509;
mem[10] <= 32'h050b051b;
mem[11] <= 32'h050a0518;
mem[12] <= 32'h060f0616;
mem[13] <= 32'h060e061c;
mem[14] <= 32'h060d0712;
mem[15] <= 32'h071b081f;
mem[16] <= 32'h0809081b;
mem[17] <= 32'h091b091f;
mem[18] <= 32'h090a0a15;
mem[19] <= 32'h0a0b0a1f;
mem[20] <= 32'h0a110a13;
mem[21] <= 32'h0b150b18;
mem[22] <= 32'h0d130d11;
mem[23] <= 32'h0d0f0d1c;
mem[24] <= 32'h0d150e1d;
mem[25] <= 32'h0e1c0e1e;
mem[26] <= 32'h0e1a0e10;
mem[27] <= 32'h0e190e16;
mem[28] <= 32'h0f110f16;
mem[29] <= 32'h101a1113;
mem[30] <= 32'h111f1119;
mem[31] <= 32'h11161220;
mem[32] <= 32'h13151518;
mem[33] <= 32'h1619171f;
mem[34] <= 32'h171d181b;
mem[35] <= 32'h191f191d;
mem[36] <= 32'h1a1e1c1e;
mem[37] <= 32'h1d1f0000;

    end
endmodule

