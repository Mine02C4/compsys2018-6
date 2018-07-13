/* test bench */
`timescale 1ns/1ps
`include "def.h"
module test_mipse;
parameter STEP = 10;
   reg clk, rst_n;
   wire [`DATA_W-1:0] ddataout, ddatain, dmemrd ;
   wire [`DATA_W-1:0] iaddr;
   wire [`DATA_W-1:0] daddr;
   wire [`DATA_W-1:0] idata, idata_imem, idata_intmem;
   wire [`LINE_W-1:0] we;
   wire [7:0] odata;
   wire dispf, disp_en, inp_en, dmem_en, inpf ;
   reg set;
   reg [`DATA_W/4-1:0] indata;
   assign disp_en = (daddr[31:4] == `DATA_W'ha000000);
   assign inp_en = (daddr[31:4] == `DATA_W'ha100000);
   assign intmem_en = (iaddr[31:16] == `DATA_W'h8000);
   assign dmem_en = (daddr[`DATA_W-1:18]==0);
  
   always #(STEP/2) begin
            clk <= ~clk;
   end

   mipse mipse_1(.clk(clk), .rst_n(rst_n), .instr(idata),
               .readdata(ddatain), .pc(iaddr), .aluresult(daddr),
               .writedata(ddataout), .memwrite(we), .intrq(inpf) );

   disp disp_1(.clk(clk), .rst_n(rst_n), .data(ddataout[15:8]),
	.we(we[1] & disp_en), .flag(dispf) );

   inmodule inmodule_1(.clk(clk), .rst_n(rst_n), .idata(indata), .odata(odata),
	.we(set), .re(inp_en & daddr[3:0] == 4'b0010), .flag(inpf));

  imem  imem_1(.a(iaddr[17:2]), .rd(idata_imem) );
  intmem  intmem_1(.a(iaddr[17:2]), .rd(idata_intmem) );
  dmem  dmem_1(.clk(clk), .a(daddr[17:2]), .rd(dmemrd), 
  					.wd(ddataout), .we(we) );

  assign ddatain = disp_en ? {31'b0,dispf} : inp_en ? {16'b0,odata,7'b0,inpf} :
										dmemrd;

  assign idata = intmem_en ? idata_intmem : idata_imem;
 
  initial begin
      $dumpfile("mipse.vcd");
//      $dumpvars(0,mipse_1,disp_1,inmodule_1);
      $dumpvars(0);
      clk <= `DISABLE;
      rst_n <= `ENABLE_N;
      set <= `DISABLE;
   #(STEP*1/4)
   #STEP
      rst_n <= `DISABLE_N;
   #(STEP*10)
  #(STEP*10)
      indata <= 8'h41;
      set <= `ENABLE;
   #STEP
      set <= `DISABLE;
   #(STEP*30)
      indata <= 8'h42;
      set <= `ENABLE;
   #STEP
      set <= `DISABLE;
   #(STEP*30)
      indata <= 8'h43;
      set <= `ENABLE;
   #STEP
      set <= `DISABLE;
   #(STEP*30)
      indata <= 8'h44;
      set <= `ENABLE;
   #STEP
      set <= `DISABLE;
   #(STEP*50)

   $finish;
   end

   always @(negedge clk) begin
      $display("pc:%h idatain:%h", mipse_1.pc, mipse_1.instr);
      $display("intreq:%h inten:%h epc:%h", mipse_1.intrq, mipse_1.inten, mipse_1.epc);
      $display("reg1:%h %h %h %h %h %h %h %h", 
	mipse_1.rfile_1.rf[1], mipse_1.rfile_1.rf[2], mipse_1.rfile_1.rf[3],
	mipse_1.rfile_1.rf[4], mipse_1.rfile_1.rf[5], mipse_1.rfile_1.rf[6],
	mipse_1.rfile_1.rf[7], mipse_1.rfile_1.rf[8] ); 
      $display("reg24:%h %h %h %h %h %h %h %h", 
	mipse_1.rfile_1.rf[24], mipse_1.rfile_1.rf[25], mipse_1.rfile_1.rf[26],
	mipse_1.rfile_1.rf[27], mipse_1.rfile_1.rf[28], mipse_1.rfile_1.rf[29],
	mipse_1.rfile_1.rf[30], mipse_1.rfile_1.rf[31] ); 
   end 
endmodule
