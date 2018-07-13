/* test bench */
`timescale 1ns/1ps
`include "def.h"
module test_cpu;
    parameter STEP = 10;
    integer FP;
    integer i;
    reg clk, rst_n;
    reg[31:0] count;
    wire [`DATA_W-1:0] ddataout, ddatain ;
    wire [`DATA_W-1:0] iaddr;
    wire [`DATA_W-1:0] daddr;
    wire [`DATA_W-1:0] idata;
    wire we;

    /* Clock generator */
    always #(STEP/2) begin
        clk <= ~clk;
    end

    mipse mipse_1(.clk(clk), .rst_n(rst_n), .instr(idata), 
    .readdata(ddatain), .pc(iaddr), .aluresult(daddr),
    .writedata(ddataout), .memwrite(we));

    imem imem_1(.a(iaddr[17:2]), .rd(idata));
    dmem dmem_1(.clk(clk), .a(daddr[17:2]), .rd(ddatain), .wd(ddataout), .we(we));

    initial begin
        $dumpfile("pipelined.vcd");
        $dumpvars(0,mipse_1);
        FP= $fopen("result.dat");
        clk <= `DISABLE;
        rst_n <= `ENABLE_N;
        count <= 0;
        #(STEP*1/4)
        #STEP
        rst_n <= `DISABLE_N;
        #(STEP*100000)
        $display("Finish by STEP max");
        $finish;
    end

    always @(negedge clk) begin
        $display("pc:%h idatain:%h", mipse_1.pc, mipse_1.instr);
        $display("reg:%h %h %h %h %h %h %h",
        mipse_1.rfile_1.rf[1], mipse_1.rfile_1.rf[2],
        mipse_1.rfile_1.rf[3], mipse_1.rfile_1.rf[4], mipse_1.rfile_1.rf[5],
        mipse_1.rfile_1.rf[6], mipse_1.rfile_1.rf[7]);
        $display("mem:%h %h %h %h", 
        dmem_1.mem[0], dmem_1.mem[1],
        dmem_1.mem[2], dmem_1.mem[3]);
        count <= count+1;
        if((daddr == 32'h7fff) & we)
        begin
            $display("FINISH dmem = %h", dmem_1.mem[16'd11]); // output line 12
            $display("%h count:%d",ddataout,count);
            for(i=0; i<50; i=i+1)
                $fdisplay(FP,"%h", dmem_1.mem[i]);
            $finish;
        end
    end
endmodule