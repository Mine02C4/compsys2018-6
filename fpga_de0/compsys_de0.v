module compsys_de0 (
	input clk,
	input [2:0] buttons,
	input [9:0] switchs,
	output [7:0] seg1,
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

	// ----------------------------- Test for ram -----------------------------
	assign leds = led_mems;
	reg [9:0] led_mems;

	reg [31:0] inp_data;
	reg w_ren;
	wire [31:0] out_data;
	ram	ram_inst(16'b01, clk, inp_data, w_ren, out_data);

	reg [31:0] inp_data2;
	reg w_ren2;
	wire [31:0] out_data2;
	ram	ram_inst2(16'b01, clk, inp_data2, w_ren2, out_data2);

	reg downed;

	always@(posedge clk) begin
		if (buttons[0]) begin
			// Read
			w_ren <= 0;
			led_mems[0] <= out_data[0];
			downed <= 0;
		end else begin
			// Write
			if (!downed) begin
				w_ren <= 1;
				inp_data[0] <= ~out_data[0];
				led_mems[0] <= ~out_data[0];
				downed <= 1;
			end
		end
		if (buttons[1]) begin
			// Read
			w_ren2 <= 0;
			led_mems[1] <= out_data2[0];
		end else begin
			// Write
			w_ren2 <= 1;
			inp_data2[0] <= ~out_data2[0];
			led_mems[1] <= ~out_data2[0];
		end
	end
endmodule
