module compsys_de0 (
    input clk,
    input [2:0] buttons,
    input [9:0] switchs,
    output [7:0] seg1, seg2, seg3, seg4,
    output [9:0] leds,
    output [3:0] vga_r, vga_g, vga_b,
    output vga_vs, vga_hs);

    wire rst_n;
    wire [31:0] ddataout, ddatain;
    wire [31:0] iaddr;
    wire [31:0] daddr;
    wire [31:0] idata;
    wire we;

    // Use button 0 as reset switch
    assign rst_n = buttons[0];

    mipse mipse_1(.clk(clk), .rst_n(rst_n), .instr(idata),
                  .readdata(ddatain), .pc(iaddr), .aluresult(daddr),
                  .writedata(ddataout), .memwrite(we));

    imem imem_1(iaddr[13:2], clk, 32'b0, 1'b0, idata);  // read only
    dmem dmem_1(daddr[17:2], clk, ddatain, we, ddataout);

    assign leds[9:0] = iaddr[13:4];

    // Turn off
    assign seg1 = ~8'b0;
    assign seg2 = ~8'b0;
    assign seg3 = ~8'b0;
    assign seg4 = ~8'b0;

endmodule
