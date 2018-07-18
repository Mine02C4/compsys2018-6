`timescale 1ns/1ps
module fpga_sim;
    parameter STEP = 10;
    reg clk, reset;
    reg [3:0] sw;
    reg [1:0] btn;
    wire [11:0] seg;
    wire finish;
    wire [12:0] leds;
    
    vivado_top v_top(.clk(clk), .reset(reset), .sw(sw), .btn(btn), .seg(seg), .finish(finish), .leds(leds));
    
    /* Clock generator */
    always #(STEP/2) begin
        clk <= ~clk;
    end
    
    initial
    begin
        clk <= 0;
        reset <= 1;
        sw <= 0;
        btn <= 0;
        #(STEP*1/4)
        #STEP
        #STEP
        reset <= 0;
        #(STEP*1000000)
        $stop;
    end
    
    always @(negedge clk)
    begin
        if (finish)
        begin
            sw[0] <= 0;
            #STEP
            #STEP
            #STEP
            sw[0] <= 0;
        end
    end

endmodule
