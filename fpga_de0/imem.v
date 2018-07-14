module imem (
    input [15:0] iaddr,
    input clk,
    input rst_n,
    output [31:0] idata);

    reg [31:0] mem[0:15];

    reg [31:0] rd;
    assign idata = rd;

    always@(posedge clk) begin
        if (!rst_n) begin
            // Set instruction
        end else begin
            rd <= mem[iaddr];
        end
    end
endmodule
