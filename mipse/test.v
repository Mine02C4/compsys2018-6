/* test bench */
`timescale 1ns/1ps
`include "def.h"
module test_cpu;
    parameter STEP = 10;
    integer FP;
    integer i;
    reg clk, rst_n;
    reg[31:0] count, patterns;
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
        $dumpfile("dump.vcd");
        $dumpvars(0,mipse_1);
        FP= $fopen("answer.txt");
        clk <= `DISABLE;
        rst_n <= `ENABLE_N;
        count <= 0;
        patterns <= 0;
        #(STEP*1/4)
        #STEP
        rst_n <= `DISABLE_N;
        #(STEP*100000)
        $display("Finish by STEP max");
        $display("patterns = %d", patterns);
        for(i=0; i<1024; i=i+1)
            $fdisplay(FP,"%h", dmem_1.mem[i]);
        $stop;
    end

    always @(negedge clk) begin
        $display("pc:%h(%d) idatain:%h", mipse_1.pc, mipse_1.pc / 4 + 1,  mipse_1.instr);
        $display("reg:%h %h %h %h %h %h %h {%h %h}",
        mipse_1.rfile_1.rf[1], mipse_1.rfile_1.rf[2],
        mipse_1.rfile_1.rf[3], mipse_1.rfile_1.rf[4], mipse_1.rfile_1.rf[5],
        mipse_1.rfile_1.rf[6], mipse_1.rfile_1.rf[7],
        mipse_1.rfile_1.rf[8], mipse_1.rfile_1.rf[9]);
        count <= count + 1;
        if (mipse_1.pc == 32'h30)
        begin
            $display("pattern: %h %h %h %h %h %h %h %h",
            dmem_1.mem[256], dmem_1.mem[257], dmem_1.mem[258], dmem_1.mem[259],
            dmem_1.mem[260], dmem_1.mem[261], dmem_1.mem[262], dmem_1.mem[263]);
            patterns <= patterns + 1;
        end
        if (mipse_1.lb_op)
        begin
            $display("result %h, aluresult %h, readdata %h",
                mipse_1.result, mipse_1.aluresult, mipse_1.readdata);
        end
        if((daddr == 32'h7fff) & we)
        begin
            $display("FINISH dmem = %h", dmem_1.mem[16'd11]); // output line 12
            $display("%h count:%d",ddataout,count);
            for(i=256; i<1024; i=i+1)
            begin
                /*$fdisplay(FP,"%d %d %d %d",
                    dmem_1.mem[i][31:24], dmem_1.mem[i][23:16],
                    dmem_1.mem[i][15:8],  dmem_1.mem[i][7:0]);*/
                $fdisplay(FP,"%d", dmem_1.mem[i]);
            end
            $finish;
        end
    end
endmodule
