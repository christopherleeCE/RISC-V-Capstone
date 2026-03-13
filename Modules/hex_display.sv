module hex_display(

	input logic [3:0] SEL,
	output logic [6:0] ZOUT);

	always_comb begin
		unique case(SEL)
		
            4'd0 : ZOUT = ~7'b0111111;
            4'd1 : ZOUT = ~7'b0000110;
            4'd2 : ZOUT = ~7'b1011011;
            4'd3 : ZOUT = ~7'b1001111;
            4'd4 : ZOUT = ~7'b1100110;
            4'd5 : ZOUT = ~7'b1101101;
            4'd6 : ZOUT = ~7'b1111101;
            4'd7 : ZOUT = ~7'b0000111;
            4'd8 : ZOUT = ~7'b1111111;
            4'd9 : ZOUT = ~7'b1100111;
            4'd10: ZOUT = ~7'b1110111;
            4'd11: ZOUT = ~7'b1111100;
            4'd12: ZOUT = ~7'b0111001;
            4'd13: ZOUT = ~7'b1011110;
            4'd14: ZOUT = ~7'b1111001;
            4'd15: ZOUT = ~7'b1110001;

            default: ZOUT = ~7'b0000000;
		
		endcase
	end
endmodule