module alu(ain, bin, op, out, carry, zero, bigger);
	input [15:0] ain, bin;
	input op;
	output [15:0] out;
	output carry, zero, bigger;
	reg [16:0] pout; // わざと1bit多くとっておく。これを繰り上がり検出に用いる。
	reg [16:0] temp17; // 一時格納領域
	reg [32:0] temp33a, temp33b, temp33c, temp33d;

always @(*) begin
	case(cmd)
	4’b0000: pout = ina; // a through
	4’b0001: pout = ina + inb; // +
	4’b0010: pout = ina – inb; // -　これもcarryがうまくいく。なぜなら、補数表現だから
	4’b0011: pout = ina & inb; // and
	4’b0100: pout = ina | inb; // or
	4’b0101: pout = ina ^ inb; // xor
	4’b0110: pout = {17{ina[inb]}}; // bit extract ちょっと玄人ぶってみた
	4’b0111: pout = ina | 1’b1 << inb; // bit set コンパイラが最適化しやすく、シンプルに、美しく
	4’b1000: pout = ina & ~(1’b1 << inb) // bit reset 上に同じ
4’b1001: pout = ina << inb // arithmetic shift left
4’b1010: begin // arithmetic shift right
temp17 = {ina,1’b0} >> inb
pout = {temp17[0],temp17[16:1]};
end
	4’b1011: begin // arithmetic shift right with carry
			temp33a = {1’b0,ina,16{carry}} << inb;
			pout = temp33a[32:16];
		end
	4’b1100: begin // arithmetic shift left with carry
			temp33b = {17{carry},ina,1’b0} >> inb;
			pout = {temp33b[0],temp33b[16:1]};
		end
4’b1101: begin // rotate left circular
temp33a = {1’b0,ina,ina} << inb;
pout = temp33c[32:16];
end
	4’b1110: begin // rotate right circular
			temp33b = {ina,ina,1’b0} >> inb;
			pout = {temp33d[0],temp33b[16:1]};
		end
	4’b1111: bein // multiplier だれかが掛け算は合成できるといったから
			pout = ina * inb;
		end
	endcase
end
assign out = pout;
always @(posedge clk) begin
	carry = pout[16];
	if(out == 0) zero = 1
	else zero = 0;
	if(ina > inb) bigger = 1
	else bigger = 0
end
endmodule

