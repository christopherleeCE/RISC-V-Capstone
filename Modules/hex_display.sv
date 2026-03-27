module hex_display(

	input logic [4:0] SEL,
	output logic [6:0] ZOUT);

	always_comb begin
		unique case(SEL)
		
            5'd0 : ZOUT = ~7'b0111111;
            5'd1 : ZOUT = ~7'b0000110;
            5'd2 : ZOUT = ~7'b1011011;
            5'd3 : ZOUT = ~7'b1001111;
            5'd4 : ZOUT = ~7'b1100110;
            5'd5 : ZOUT = ~7'b1101101;
            5'd6 : ZOUT = ~7'b1111101;
            5'd7 : ZOUT = ~7'b0000111;
            5'd8 : ZOUT = ~7'b1111111;
            5'd9 : ZOUT = ~7'b1100111;
            5'd10: ZOUT = ~7'b1110111;
            5'd11: ZOUT = ~7'b1111100;
            5'd12: ZOUT = ~7'b0111001;
            5'd13: ZOUT = ~7'b1011110;
            5'd14: ZOUT = ~7'b1111001;
            5'd15: ZOUT = ~7'b1110001;
            5'd16: ZOUT = ~7'b1010100; //n
            5'd17: ZOUT = ~7'b0000100; //i
            5'd18: ZOUT = ~7'b0000000; //all off
            5'd19: ZOUT = ~7'b1000000; //-
            5'd20: ZOUT = ~7'b0110111; //N


            default: ZOUT = ~7'b0000000;
		
		endcase
	end
endmodule