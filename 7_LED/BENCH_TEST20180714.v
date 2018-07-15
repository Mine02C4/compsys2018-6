module TEST_DECODER7;
reg A,B,C,D;
wire [7:0] LED;
wire [3:0] AN;
parameter CYCLE = 100;
integer i,j;

reg [8*4:1] A_DISP, D_DISP, G_DISP;
reg [8*2:1] B_DISP, C_DISP, E_DISP, F_DISP, Dp_DISP;
parameter TURN_ON = 1'b0;

DECODER7 i0(.A(A),.B(B),.C(C),.D(D),.LED(LED),.AN(AN));

initial
begin
	for (i = 0; i <= 15; i = i + 1)
	begin
		{A,B,C,D}=i;
		#CYCLE;
	end
	#CYCLE {A,B,C,D}=4'b01xz;
	#CYCLE {A,B,C,D}=4'bxz01;
   #CYCLE $finish;
end

always @(LED)
begin
	for (j = 7; j >= 0; j = j - 1)
	begin
		case (j)
			7 : begin
					if (LED[j] === TURN_ON)
						A_DISP = "----";
					else if (LED[j] === 1'bx)
						A_DISP = "xxxx";
					else
						A_DISP = "    ";
				 end
			6 : begin
					if (LED[j] === TURN_ON)
						B_DISP = "| ";
					else if (LED[j] === 1'bx)
						B_DISP = "x ";
					else
						B_DISP = "  ";
				 end
			5 : begin
					if (LED[j] === TURN_ON)
						C_DISP = "| ";
					else if (LED[j] === 1'bx)
						C_DISP = "x ";
					else
						C_DISP = "  ";
				 end
			4 : begin
					if (LED[j] === TURN_ON)
						D_DISP = "----";
					else if (LED[j] === 1'bx)
						D_DISP = "xxxx";
					else
						D_DISP = "    ";
				 end
			3 : begin
					if (LED[j] === TURN_ON)
						E_DISP = "| ";
					else if (LED[j] === 1'bx)
						E_DISP = "x ";
					else
						E_DISP = "  ";
				 end
			2 : begin
					if (LED[j] === TURN_ON)
						F_DISP = "| ";
					else if (LED[j] === 1'bx)
						F_DISP = "x ";
					else
						F_DISP = "  ";
				 end
			1 : begin
					if (LED[j] === TURN_ON)
						G_DISP = "----";
					else if (LED[j] === 1'bx)
						G_DISP = "xxxx";
					else
						G_DISP = "    ";
				 end
			0 : begin
					if (LED[j] === TURN_ON)
						Dp_DISP = " .";
					else if (LED[j] === 1'bx)
						Dp_DISP = " x";
					else
						Dp_DISP = "  ";
				 end
		endcase
	end
	#5
		$display("ABCD is %h", {A,B,C,D});
		$display("");
		$display("  %s",A_DISP);
		$display(" %s   %s",F_DISP, B_DISP);
		$display("  %s",G_DISP);
		$display(" %s   %s",E_DISP, C_DISP);
		$display("  %s   %s",D_DISP, Dp_DISP);
		$display("");
end

endmodule