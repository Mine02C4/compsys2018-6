`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/07/16 20:19:06
// Design Name: 
// Module Name: vivado_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vivado_top(
    input clk,
    input reset,
    input [3:0] sw,
    input [1:0] btn,
    output [11:0] seg,
    output finish,
    output [12:0] leds
    );
    wire core_clock;
    wire [`DATA_W-1:0] ddataout, ddatain ;
    wire [`DATA_W-1:0] iaddr, addr_imem_1;
    wire [`DATA_W-1:0] daddr, addr_dmem_1;
    wire [`DATA_W-1:0] idata;
    wire we;
    wire [`MAX_WIDTH-1:0] display_number, display_addr;
    wire [3:0] d0, d1, d2, d3;
    wire [3:0] dots;
    mipse core(.clk(core_clock), .rst_n(!reset), .instr(idata), 
    .readdata(ddatain), .pc(iaddr), .aluresult(daddr),
    .writedata(ddataout), .memwrite(we), .finish(finish));
    imem imem_1(.a(addr_imem_1[17:2]), .rd(idata));
    //imem imem_1(.a({2'b0, display_addr[`MAX_WIDTH-1:2]}), .rd(idata));

    switcher switcher_1(.clk(core_clock), .reset(reset), .BTN(btn), .number(display_addr));
    //assign addr_dmem_1 = finish ? {18'b0, display_addr} : daddr;
    assign addr_dmem_1 = sw[3] ? display_addr : finish ? {display_addr, 2'b0} + 256 : daddr; // sw[3] DEBUG MODE
    assign addr_imem_1 = sw[3] ? display_addr : iaddr; // sw[3] DEBUG MODE
    assign display_number = sw[2] ? iaddr : display_addr; // sw[2] PC or manual addr       
    assign dots = 4'b1101;
    assign leds = sw[1] ? idata : ddatain; // sw[1] imem or dmem
    dmem dmem_1(.clk(core_clock), .a(addr_dmem_1[17:2]), .rd(ddatain), .wd(ddataout), .we(we));
    //number_to_4digits(.number(display_number), .d0(d0), .d1(d1), .d2(d2), .d3(d3));
    assign d0 = finish ? ddatain[3:0] : 0;
    number_to_3digits(.number(display_number), .d0(d1), .d1(d2), .d2(d3));
    dynamic_7seg dseg_1(.clk(core_clock), .reset(reset), .d0(d0), .d1(d1), .d2(d2), .d3(d3), .dots(dots), .seg(seg));
    clk_wiz_0 mmcm_1(.clk_in1(clk), .reset(reset), .clk_out2(core_clock));
endmodule
