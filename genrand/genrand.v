module genrand(clk,rst,seed,randnum);
   input clk,rst;
   input [15:0] seed;
   output [15:0] randnum;
   reg [15:0] xx;
   reg [15:0] randnum;

   always @(posedge clk)begin
      if(rst)begin//はじめだけseed値を代入する
          randnum=seed;
      end
      xx=randnum;
      xx=xx^xx<<3;
      xx=xx^xx>>11;
      xx=xx^xx<<7;
      randnum=xx;
   end
endmodule // genrand

module test_genrand;
   reg clk,rst;
   reg [15:0] seed;
   wire [15:0] randnum;
   genrand genrand(clk,rst,seed,randnum);
   always #5 clk=~clk;
   initial begin
      $dumpfile("genrand.vcd");
      $dumpvars(0,test);
      rst=1;
      clk=0;
      seed=4;
      #20;
      rst=0;
      #500;
      $finish;
   end // initial begin
endmodule // test_genrand

	
   
