module DECODER7(A,B,C,D,LED,AN);
input A,B,C,D;
output [7:0] LED;
output [3:0] AN;
reg [7:0] LED;

assign AN = 4'b1110;

always @(A or B or C or D)
begin
//7セグの形状考慮
case({A,B,C, D}) 
4'b0000:LED <= 8'b0000001_1;//0
4'b0001:LED <= 8'b1001111_1;//1
4'b0010:LED <= 8'b0010010_1;//2
4'b0011:LED <= 8'b0000110_1;//3
4'b0100:LED <= 8'b1001100_1;//4
4'b0101:LED <= 8'b0100100_1;//5
4'b0110:LED <= 8'b0100000_1;//6
4'b0111:LED <= 8'b0001101_1;//7
4'b1000:LED <= 8'b0000000_1;//8
4'b1001:LED <= 8'b0001100_1;//9

default:LED <= 8'bxxxxxxx_x;
endcase
end
endmodule