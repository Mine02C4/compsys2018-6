`timescale 1ns / 1ps

`include "vdefine.h"

module number_to_3digits(
    input [`MAX_WIDTH-1:0] number,
    output [3:0] d0,
    output [3:0] d1,
    output [3:0] d2
    );
    assign d0 = number % 10;
    assign d1 = number / 10 % 10;
    assign d2 = number / 100 % 10;
endmodule
