`include "def.h"

module rand(clk, rst_n, out);
    input clk, rst_n;
    output [`DATA_W-1:0] out;
    reg [`DATA_W-1:0] out;

    wire [`DATA_W-1:0] seed;
    assign seed = 32'b11101011101011011101010010101001;

    wire [`DATA_W-1:0] x1, x2, x3;
    assign x1 = out ^ out << 13;  // Use previous output
    assign x2 = x1 ^ x1 >> 17;
    assign x3 = x2 ^ x2 << 5;

    always @(posedge clk) begin
        if (!rst_n) begin
            out <= seed;
        end else begin
            out <= x3;
        end
    end
endmodule
